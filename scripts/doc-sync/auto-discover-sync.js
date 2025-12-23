#!/usr/bin/env node

/**
 * Claude Code 官方文檔自動發現與同步工具
 *
 * ⚠️ 重要說明（2025-12-24）：
 * ==============================
 * 此腳本目前已 **無法正常使用**，原因如下：
 *
 * 1. Anthropic 已將官方文檔遷移至新平台：
 *    - 舊網址：https://docs.anthropic.com/zh-TW/docs/claude-code/... (已失效)
 *    - 新網址：https://platform.claude.com/docs/...
 *
 * 2. 原本獨立的「Claude Code」文檔區段已不存在，
 *    相關內容已整合至 Agent SDK、Agent Skills、Tool Use 等新分類。
 *
 * 3. 建議替代方案：
 *    - 使用 context7 MCP 動態獲取最新官方文檔
 *    - 直接訪問 https://platform.claude.com/docs/
 *    - 參考 https://platform.claude.com/llms.txt 獲取完整索引
 *
 * 如需修復此腳本，需要：
 * 1. 更新 baseUrl 為 https://platform.claude.com
 * 2. 完全重寫文檔發現邏輯以適應新的目錄結構
 * 3. 處理新的多分類文檔結構
 * ==============================
 *
 * 原始功能（已過時）：
 * 1. 自動掃描官方文檔網站，發現所有可用文檔
 * 2. 自動下載新增的文檔
 * 3. 更新現有文檔
 * 4. 生成完整的同步報告
 *
 * 使用方式：
 * node scripts/doc-sync/auto-discover-sync.js [選項]
 *
 * 選項：
 * --discover-only    僅發現文檔，不下載
 * --force            強制更新所有文檔
 * --dry-run          預覽模式
 * --verbose          詳細輸出
 */

import fs from "fs/promises";
import path from "path";
import { fileURLToPath } from "url";
import { existsSync } from "fs";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.join(__dirname, "..", "..");

class AutoDiscoverSync {
  constructor() {
    this.baseUrl = "https://docs.anthropic.com/zh-TW/docs/claude-code";
    this.enBaseUrl = "https://docs.anthropic.com/en/docs/claude-code";
    this.docsDir = path.join(rootDir, "docs/anthropic-claude-code-zh-tw");
    this.readmePath = path.join(this.docsDir, "README.md");

    this.options = {
      discoverOnly: false,
      force: false,
      dryRun: false,
      verbose: false,
    };

    this.stats = {
      discovered: 0,
      existing: 0,
      new: 0,
      updated: 0,
      deleted: 0,
      skipped: 0,
      failed: 0,
      errors: [],
    };

    this.discoveredDocs = new Set();
  }

  parseArgs() {
    const args = process.argv.slice(2);
    for (const arg of args) {
      switch (arg) {
        case "--discover-only":
          this.options.discoverOnly = true;
          break;
        case "--force":
          this.options.force = true;
          break;
        case "--dry-run":
          this.options.dryRun = true;
          break;
        case "--verbose":
          this.options.verbose = true;
          break;
        case "--help":
          this.showHelp();
          process.exit(0);
        default:
          if (!arg.startsWith("--")) break;
          console.warn(`⚠️  未知選項: ${arg}`);
      }
    }
  }

  showHelp() {
    console.log(`
📚 Claude Code 官方文檔自動發現與同步工具

使用方式：
  node auto-discover-sync.js [選項]

選項：
  --discover-only    僅發現文檔，不下載
  --force            強制更新所有文檔
  --dry-run          預覽模式，不實際修改檔案
  --verbose          詳細輸出
  --help             顯示此說明

範例：
  node auto-discover-sync.js                 # 完整同步
  node auto-discover-sync.js --discover-only # 僅列出所有文檔
  node auto-discover-sync.js --force         # 強制更新所有
  node auto-discover-sync.js --dry-run       # 預覽模式
    `);
  }

  log(message, force = false) {
    if (this.options.verbose || force) {
      console.log(message);
    }
  }

  async fetchWithRetry(url, retries = 3) {
    for (let i = 0; i < retries; i++) {
      try {
        const { default: fetch } = await import("node-fetch");
        const response = await fetch(url, {
          headers: {
            "User-Agent":
              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
            Accept:
              "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language": "zh-TW,zh;q=0.9,en;q=0.8",
          },
        });

        if (!response.ok) {
          throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }

        return await response.text();
      } catch (error) {
        this.log(`⚠️  嘗試 ${i + 1}/${retries} 失敗: ${error.message}`);
        if (i === retries - 1) throw error;
        await new Promise((resolve) => setTimeout(resolve, 1000 * (i + 1)));
      }
    }
  }

  async discoverDocsFromSitemap() {
    this.log("🔍 正在從 Anthropic 官方網站發現文檔...", true);

    try {
      // 嘗試抓取側邊欄或主頁來發現所有文檔連結
      const html = await this.fetchWithRetry(`${this.baseUrl}/overview`);

      // 提取所有 claude-code 相關連結
      const linkRegex = /docs\/claude-code\/([a-z0-9-]+)/g;
      let match;

      while ((match = linkRegex.exec(html)) !== null) {
        const docSlug = match[1];
        if (docSlug && !this.discoveredDocs.has(docSlug)) {
          this.discoveredDocs.add(docSlug);
          this.stats.discovered++;
        }
      }

      // 如果從繁中版發現不全，也嘗試從英文版發現
      const enHtml = await this.fetchWithRetry(`${this.enBaseUrl}/overview`);
      while ((match = linkRegex.exec(enHtml)) !== null) {
        const docSlug = match[1];
        if (docSlug && !this.discoveredDocs.has(docSlug)) {
          this.discoveredDocs.add(docSlug);
          this.stats.discovered++;
        }
      }

      this.log(`✅ 發現 ${this.stats.discovered} 個文檔頁面`, true);

      // 顯示發現的文檔列表
      if (this.options.verbose || this.options.discoverOnly) {
        console.log("\n📄 發現的文檔列表：");
        const sorted = Array.from(this.discoveredDocs).sort();
        sorted.forEach((doc, index) => {
          console.log(`  ${(index + 1).toString().padStart(2)}. ${doc}`);
        });
        console.log("");
      }
    } catch (error) {
      console.error("❌ 發現文檔失敗:", error.message);
      this.stats.errors.push({ phase: "discovery", error: error.message });
      throw error;
    }
  }

  async checkExistingDocs() {
    this.log("📂 檢查現有文檔...", true);

    try {
      await fs.access(this.docsDir);
      const files = await fs.readdir(this.docsDir);
      const mdFiles = files.filter(
        (f) => f.endsWith(".md") && f !== "README.md"
      );

      this.stats.existing = mdFiles.length;
      this.log(`  現有文檔: ${this.stats.existing} 個`, true);

      // 計算新文檔數量
      mdFiles.forEach((f) => {
        const slug = f.replace(".md", "");
        if (this.discoveredDocs.has(slug)) {
          this.discoveredDocs.delete(slug);
        }
      });

      this.stats.new = this.discoveredDocs.size;
      if (this.stats.new > 0) {
        console.log(`\n🆕 發現 ${this.stats.new} 個新文檔：`);
        Array.from(this.discoveredDocs)
          .sort()
          .forEach((doc) => {
            console.log(`  - ${doc}`);
          });
      }
    } catch (error) {
      console.log("  📁 目錄不存在，將建立新目錄");
      await fs.mkdir(this.docsDir, { recursive: true });
    }
  }

  async downloadDoc(slug) {
    const outputPath = path.join(this.docsDir, `${slug}.md`);
    const timestamp = new Date().toISOString().split(".")[0] + "+08:00";

    try {
      this.log(`  📥 下載: ${slug}...`);

      // 優先嘗試繁中版的 .md 直接下載
      let markdown;
      let sourceUrl;
      try {
        sourceUrl = `${this.baseUrl}/${slug}.md`;
        this.log(`    🔗 獲取: ${sourceUrl}`);
        markdown = await this.fetchWithRetry(sourceUrl);
      } catch (error) {
        // 如果繁中版不存在，嘗試英文版
        this.log(`    ⚠️  繁中版不可用，嘗試英文版...`);
        sourceUrl = `${this.enBaseUrl}/${slug}.md`;
        this.log(`    🔗 獲取: ${sourceUrl}`);
        markdown = await this.fetchWithRetry(sourceUrl);
      }

      // 生成 front-matter
      const content = `---
source: "${sourceUrl}"
fetched_at: "${timestamp}"
---

${markdown}
`;

      if (!this.options.dryRun) {
        await fs.writeFile(outputPath, content, "utf-8");
      }

      this.log(`  ✅ 完成: ${slug}`, true);
      this.stats.updated++;
    } catch (error) {
      console.error(`  ❌ 失敗: ${slug} - ${error.message}`);
      this.stats.failed++;
      this.stats.errors.push({ doc: slug, error: error.message });

      // 如果是 404 錯誤且文件存在，則刪除該文件
      if (error.message.includes("404") && existsSync(outputPath)) {
        try {
          if (!this.options.dryRun) {
            await fs.unlink(outputPath);
            console.log(`  🗑️  已刪除 404 文檔: ${slug}`);
            this.stats.deleted = (this.stats.deleted || 0) + 1;
          } else {
            console.log(`  🗑️  [預覽] 將刪除: ${slug}`);
          }
        } catch (unlinkError) {
          console.error(`  ⚠️  無法刪除: ${slug} - ${unlinkError.message}`);
        }
      }
    }
  }

  async updateReadme() {
    this.log("📝 更新 README 索引...", true);

    try {
      const files = await fs.readdir(this.docsDir);
      const mdFiles = files
        .filter((f) => f.endsWith(".md") && f !== "README.md")
        .sort();

      const timestamp = new Date().toISOString().split(".")[0] + "+08:00";
      const bullets = mdFiles
        .map((f) => {
          const slug = f.replace(".md", "");
          return `- ${slug} → [${f}](./${f})`;
        })
        .join("\n");

      const readmeContent = `---
title: "Anthropic Claude Code 官方文檔（繁中）本地鏡像索引"
source_index: "${this.baseUrl}/overview"
fetched_at: "${timestamp}"
---

# Claude Code 官方文檔（繁中）本地鏡像索引

本目錄為 Anthropic 官方「Claude Code」繁中站點的本地鏡像，來源見上方 \`source_index\`。

## 條目

${bullets}

> 註：已批次同步主要文件；若官方內容更新，建議執行同步腳本重新抓取。
`;

      if (!this.options.dryRun) {
        await fs.writeFile(this.readmePath, readmeContent, "utf-8");
      }

      this.log("✅ README 已更新", true);
    } catch (error) {
      console.error("❌ 更新 README 失敗:", error.message);
      this.stats.errors.push({ phase: "readme", error: error.message });
    }
  }

  async generateReport() {
    const duration = ((Date.now() - this.stats.startTime) / 1000).toFixed(2);

    console.log("\n" + "=".repeat(60));
    console.log("📊 同步報告");
    console.log("=".repeat(60));
    console.log(`⏱️  執行時間: ${duration}秒`);
    console.log(`🔍 發現文檔: ${this.stats.discovered} 個`);
    console.log(`📄 現有文檔: ${this.stats.existing} 個`);
    console.log(`🆕 新增文檔: ${this.stats.new} 個`);
    console.log(`✅ 成功更新: ${this.stats.updated} 個`);
    console.log(`🗑️  已刪除 (404): ${this.stats.deleted || 0} 個`);
    console.log(`⏭️  跳過文檔: ${this.stats.skipped || 0} 個`);
    console.log(`❌ 失敗文檔: ${this.stats.failed} 個`);

    if (this.stats.errors.length > 0) {
      console.log("\n⚠️  錯誤詳情:");
      const error404s = this.stats.errors.filter((e) =>
        e.error.includes("404")
      );
      const otherErrors = this.stats.errors.filter(
        (e) => !e.error.includes("404")
      );

      if (error404s.length > 0) {
        console.log(`  📋 404 錯誤 (${error404s.length} 個):`);
        error404s.forEach((err, index) => {
          console.log(`    ${index + 1}. ${err.doc}`);
        });
      }

      if (otherErrors.length > 0) {
        console.log(`  📋 其他錯誤 (${otherErrors.length} 個):`);
        otherErrors.forEach((err, index) => {
          console.log(`    ${index + 1}. ${err.doc}: ${err.error}`);
        });
      }
    }

    console.log("=".repeat(60) + "\n");

    // 寫入 JSON 報告
    const reportPath = path.join(rootDir, "auto-discover-sync-report.json");
    const report = {
      timestamp: new Date().toISOString(),
      duration,
      stats: this.stats,
      options: this.options,
      discoveredDocs: Array.from(this.discoveredDocs),
    };

    if (!this.options.dryRun) {
      await fs.writeFile(reportPath, JSON.stringify(report, null, 2), "utf-8");
      console.log(`📋 詳細報告已儲存: ${reportPath}\n`);
    }
  }

  async run() {
    this.stats.startTime = Date.now();

    console.log(
      "╔════════════════════════════════════════════════════════════════╗"
    );
    console.log(
      "║  🤖 Claude Code 官方文檔自動發現與同步工具                 ║"
    );
    console.log(
      "╚════════════════════════════════════════════════════════════════╝\n"
    );

    this.parseArgs();

    if (this.options.dryRun) {
      console.log("🔍 預覽模式 - 不會實際修改檔案\n");
    }

    try {
      // 階段 1: 發現所有文檔
      await this.discoverDocsFromSitemap();

      if (this.options.discoverOnly) {
        console.log("✅ 發現完成（僅發現模式）\n");
        return;
      }

      // 階段 2: 檢查現有文檔
      await this.checkExistingDocs();

      // 階段 3: 下載/更新文檔
      if (this.options.force) {
        console.log("\n🔄 強制模式 - 將更新所有文檔\n");
        // 重新加載所有文檔到待下載列表
        const files = await fs.readdir(this.docsDir);
        const mdFiles = files.filter(
          (f) => f.endsWith(".md") && f !== "README.md"
        );
        mdFiles.forEach((f) => {
          this.discoveredDocs.add(f.replace(".md", ""));
        });
      }

      if (this.discoveredDocs.size > 0 || this.options.force) {
        console.log("\n📥 開始下載文檔...\n");

        const docsToProcess = Array.from(this.discoveredDocs);
        for (const slug of docsToProcess) {
          await this.downloadDoc(slug);
        }
      } else {
        console.log("\n✅ 所有文檔都是最新的，無需更新\n");
      }

      // 階段 4: 更新 README
      if (!this.options.dryRun && this.stats.updated > 0) {
        await this.updateReadme();
      }

      // 階段 5: 生成報告
      await this.generateReport();

      console.log("✅ 同步完成！\n");
    } catch (error) {
      console.error("\n❌ 同步過程發生錯誤:", error.message);
      if (this.options.verbose) {
        console.error(error.stack);
      }
      process.exit(1);
    }
  }
}

// 主程式入口
const sync = new AutoDiscoverSync();
sync.run().catch((error) => {
  console.error("💥 致命錯誤:", error.message);
  process.exit(1);
});
