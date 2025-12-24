#!/usr/bin/env node
/**
 * SSOT 自動注入腳本
 * 從 config/metadata.json 讀取版本資訊並注入 index.html
 *
 * 用法:
 *   node scripts/inject-ssot-to-html.js              # 執行注入
 *   node scripts/inject-ssot-to-html.js --dry-run    # 預覽模式
 *   node scripts/inject-ssot-to-html.js --verbose    # 詳細輸出
 *   node scripts/inject-ssot-to-html.js --help       # 顯示說明
 *
 * @author AI Assistant
 * @version 1.0.0
 * @date 2025-12-25
 */

const fs = require("fs");
const path = require("path");

// 路徑配置
const ROOT_DIR = path.join(__dirname, "..");
const METADATA_PATH = path.join(ROOT_DIR, "config", "metadata.json");
const HTML_PATH = path.join(ROOT_DIR, "index.html");

// 解析命令列參數
const args = process.argv.slice(2);
const dryRun = args.includes("--dry-run");
const verbose = args.includes("--verbose");
const showHelp = args.includes("--help") || args.includes("-h");

/**
 * 顯示使用說明
 */
function showUsage() {
  console.log(`
SSOT 自動注入腳本 v1.0.0

用法: node scripts/inject-ssot-to-html.js [選項]

選項:
  --dry-run     預覽模式，不寫入檔案
  --verbose     詳細輸出
  --help, -h    顯示此說明

範例:
  node scripts/inject-ssot-to-html.js              # 執行注入
  node scripts/inject-ssot-to-html.js --dry-run    # 預覽變更
  node scripts/inject-ssot-to-html.js --verbose    # 詳細輸出
`);
}

/**
 * 讀取 SSOT 元資料
 */
function readMetadata() {
  try {
    const content = fs.readFileSync(METADATA_PATH, "utf8");
    return JSON.parse(content);
  } catch (error) {
    console.error(`❌ 無法讀取 metadata: ${error.message}`);
    process.exit(1);
  }
}

/**
 * 取得當前時間戳記 (ISO-8601 格式)
 */
function getCurrentTimestamp() {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, "0");
  const day = String(now.getDate()).padStart(2, "0");
  const hours = String(now.getHours()).padStart(2, "0");
  const minutes = String(now.getMinutes()).padStart(2, "0");
  const seconds = String(now.getSeconds()).padStart(2, "0");
  return `${year}-${month}-${day}T${hours}:${minutes}:${seconds}+08:00`;
}

/**
 * 執行 SSOT 注入
 */
function injectSSOT() {
  const metadata = readMetadata();
  const timestamp = getCurrentTimestamp();

  if (verbose) {
    console.log("📖 讀取 SSOT 元資料:");
    console.log(`   專案版本: v${metadata.project.version}`);
    console.log(`   Claude Code 版本: v${metadata.claudeCode.version}`);
    console.log(`   活躍專案數: ${metadata.documentation.totalProjects}`);
    console.log(`   時間戳記: ${timestamp}`);
    console.log("");
  }

  // 讀取 HTML
  let html;
  try {
    html = fs.readFileSync(HTML_PATH, "utf8");
  } catch (error) {
    console.error(`❌ 無法讀取 index.html: ${error.message}`);
    process.exit(1);
  }

  const changes = [];
  let updatedHtml = html;

  // 定義替換規則
  const replacements = [
    {
      name: "Claude Code 版本 (description)",
      pattern: /Claude Code v[\d.]+/g,
      replacement: `Claude Code v${metadata.claudeCode.version}`,
    },
    {
      name: "專案版本 (footer)",
      pattern: /版本：v[\d.]+/g,
      replacement: `版本：v${metadata.project.version}`,
    },
    {
      name: "SSOT 架構版本",
      pattern: /SSOT 架構 v[\d.]+/g,
      replacement: `SSOT 架構 v${metadata.project.version}`,
    },
    {
      name: "活躍專案數",
      pattern: /(\d+) 個活躍專案/g,
      replacement: `${metadata.documentation.totalProjects} 個活躍專案`,
    },
    {
      name: "時間戳記 (ISO-8601)",
      pattern: /最後更新：\d{4}-\d{2}-\d{2}T[\d:]+\+\d{2}:\d{2}/g,
      replacement: `最後更新：${timestamp}`,
    },
    {
      name: "時間戳記 (日期)",
      pattern: /最後更新：\d{4}-\d{2}-\d{2}(?!\T)/g,
      replacement: `最後更新：${timestamp.slice(0, 10)}`,
    },
  ];

  // 執行替換
  for (const rule of replacements) {
    const matches = updatedHtml.match(rule.pattern);
    if (matches && matches.length > 0) {
      const before = matches[0];
      updatedHtml = updatedHtml.replace(rule.pattern, rule.replacement);

      // 檢查是否有實際變更
      if (before !== rule.replacement) {
        changes.push({
          name: rule.name,
          before: before,
          after: rule.replacement,
          count: matches.length,
        });
      }
    }
  }

  // 輸出變更摘要
  if (changes.length === 0) {
    console.log("✅ 所有版本資訊已是最新，無需更新");
    return { success: true, changes: [] };
  }

  console.log("📝 變更摘要:");
  console.log("─".repeat(60));
  for (const change of changes) {
    console.log(`  ${change.name}:`);
    console.log(`    - ${change.before}`);
    console.log(`    + ${change.after}`);
    if (change.count > 1) {
      console.log(`    (共 ${change.count} 處)`);
    }
    console.log("");
  }
  console.log("─".repeat(60));
  console.log(`共 ${changes.length} 項變更`);

  // 寫入檔案
  if (dryRun) {
    console.log("\n⚠️  [預覽模式] 未寫入任何變更");
  } else {
    try {
      fs.writeFileSync(HTML_PATH, updatedHtml, "utf8");
      console.log("\n✅ 已成功更新 index.html");
    } catch (error) {
      console.error(`\n❌ 寫入失敗: ${error.message}`);
      process.exit(1);
    }
  }

  return { success: true, changes };
}

/**
 * 主程式
 */
function main() {
  console.log("🔄 SSOT 自動注入腳本");
  console.log("=".repeat(60));

  if (showHelp) {
    showUsage();
    return;
  }

  if (dryRun) {
    console.log("📋 模式：預覽 (dry-run)");
  }
  console.log("");

  const result = injectSSOT();

  console.log("");
  console.log("=".repeat(60));
  console.log(result.success ? "🎉 執行完成" : "❌ 執行失敗");
}

// 執行
if (require.main === module) {
  main();
}

module.exports = { injectSSOT, readMetadata };
