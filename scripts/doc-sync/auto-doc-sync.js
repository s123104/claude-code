#!/usr/bin/env node

/**
 * Claude Code 文檔自動同步工具
 * 
 * 功能：
 * 1. 自動爬取 Anthropic 官方文檔
 * 2. 同步 CHANGELOG 內容
 * 3. 更新繁體中文文檔
 * 4. 檢測版本差異
 * 
 * 使用方式：
 * node scripts/auto-doc-sync.js [--force] [--dry-run] [--changelog-only]
 */

import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.join(__dirname, '..');

class ClaudeCodeDocSync {
  constructor() {
    this.baseUrl = 'https://docs.anthropic.com/en/docs/claude-code';
    this.rawGithubUrl = 'https://raw.githubusercontent.com/anthropics/claude-code/main';
    this.docsDir = path.join(rootDir, 'docs/anthropic-claude-code-zh-tw');
    this.mainDocPath = path.join(rootDir, 'claude-code-zh-tw.md');
    
    // 官方文檔頁面映射
    this.docPages = {
      'overview': 'overview',
      'quickstart': 'quickstart', 
      'common-workflows': 'common-workflows',
      'sdk': 'sdk',
      'sub-agents': 'sub-agents',
      'hooks-guide': 'hooks-guide',
      'github-actions': 'github-actions',
      'mcp': 'mcp',
      'troubleshooting': 'troubleshooting',
      'third-party-integrations': 'third-party-integrations',
      'amazon-bedrock': 'amazon-bedrock',
      'google-vertex-ai': 'google-vertex-ai',
      'corporate-proxy': 'corporate-proxy',
      'llm-gateway': 'llm-gateway',
      'devcontainer': 'devcontainer',
      'setup': 'setup',
      'iam': 'iam',
      'security': 'security',
      'monitoring-usage': 'monitoring-usage',
      'costs': 'costs',
      'analytics': 'analytics',
      'settings': 'settings',
      'ide-integrations': 'ide-integrations',
      'terminal-config': 'terminal-config',
      'memory': 'memory',
      'cli-reference': 'cli-reference',
      'interactive-mode': 'interactive-mode',
      'slash-commands': 'slash-commands',
      'hooks': 'hooks',
      'data-usage': 'data-usage',
      'legal-and-compliance': 'legal-and-compliance'
    };
    
    this.options = {
      force: false,
      dryRun: false,
      changelogOnly: false,
      verbose: false
    };
  }

  parseArgs() {
    const args = process.argv.slice(2);
    this.options.force = args.includes('--force');
    this.options.dryRun = args.includes('--dry-run');
    this.options.changelogOnly = args.includes('--changelog-only');
    this.options.verbose = args.includes('--verbose');
  }

  log(message, level = 'INFO') {
    const timestamp = new Date().toISOString().split('T')[1].split('.')[0];
    const colors = {
      INFO: '\x1b[36m',  // 青色
      SUCCESS: '\x1b[32m', // 綠色
      WARNING: '\x1b[33m', // 黃色
      ERROR: '\x1b[31m',   // 紅色
      VERBOSE: '\x1b[90m'  // 灰色
    };
    
    if (level === 'VERBOSE' && !this.options.verbose) return;
    
    console.log(`${colors[level]}[${timestamp}] ${level}: ${message}\x1b[0m`);
  }

  async fetchWithRetry(url, maxRetries = 3) {
    for (let i = 0; i < maxRetries; i++) {
      try {
        this.log(`正在獲取: ${url}`, 'VERBOSE');
        
        // 使用動態導入 node-fetch
        const fetch = await import('node-fetch').then(m => m.default);
        const response = await fetch(url, {
          headers: {
            'User-Agent': 'Claude-Code-Doc-Sync/1.0.0',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
          },
          timeout: 30000
        });
        
        if (!response.ok) {
          throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        
        return await response.text();
      } catch (error) {
        this.log(`獲取失敗 (嘗試 ${i + 1}/${maxRetries}): ${error.message}`, 'WARNING');
        if (i === maxRetries - 1) throw error;
        await new Promise(resolve => setTimeout(resolve, 2000 * (i + 1)));
      }
    }
  }

  async fetchChangelog() {
    this.log('開始獲取 CHANGELOG...', 'INFO');
    try {
      const changelogUrl = `${this.rawGithubUrl}/CHANGELOG.md`;
      const content = await this.fetchWithRetry(changelogUrl);
      return this.parseChangelog(content);
    } catch (error) {
      this.log(`獲取 CHANGELOG 失敗: ${error.message}`, 'ERROR');
      throw error;
    }
  }

  parseChangelog(content) {
    const lines = content.split('\n');
    const versions = [];
    let currentVersion = null;
    let currentChanges = [];

    for (let line of lines) {
      line = line.trim();
      
      // 檢測版本標題
      if (line.startsWith('## ') && !line.includes('Changelog')) {
        if (currentVersion) {
          versions.push({
            version: currentVersion,
            changes: currentChanges.join('\n').trim()
          });
        }
        currentVersion = line.replace('## ', '');
        currentChanges = [];
      } else if (currentVersion && line) {
        currentChanges.push(line);
      }
    }

    // 添加最後一個版本
    if (currentVersion) {
      versions.push({
        version: currentVersion,
        changes: currentChanges.join('\n').trim()
      });
    }

    this.log(`成功解析 ${versions.length} 個版本`, 'SUCCESS');
    return versions;
  }

  translateChangelogItem(text) {
    // 基本的英文到繁體中文翻譯映射
    const translations = {
      // 技術詞彙
      'Background commands': '背景命令',
      'Customizable status line': '可自訂狀態列',
      'Performance': '效能',
      'Windows': 'Windows',
      'Fixed': '修復',
      'Added': '新增',
      'Improved': '改善',
      'Enhanced': '增強',
      'Upgraded': '升級',
      'SDK': 'SDK',
      'Hooks': 'Hooks',
      'MCP': 'MCP',
      'OAuth': 'OAuth',
      'API': 'API',
      'CLI': 'CLI',
      'UI': 'UI',
      'Bash': 'Bash',
      'tool': '工具',
      'support': '支援',
      'configuration': '配置',
      'authentication': '認證',
      'permission': '權限',
      'subagent': '子代理',
      'agent': '代理',
      'file search': '檔案搜尋',
      'native': '原生',
      'slash command': '斜線指令',
      'mention': '提及',
      'context': '上下文',
      'rendering': '渲染',
      'model': '模型',
      'version': '版本',
      'settings': '設定',
      'callback': '回調',
      'confirmation': '確認',
      'stability': '穩定性',
      'diagnostics': '診斷',
      'connection': '連線',
      'error handling': '錯誤處理',
      'shell': 'shell',
      'environment': '環境',
      'initialization': '初始化',
      'customization': '自訂',
      'typeahead': '自動完成',
      'session': '會話',
      'transcript': '記錄',
      'timeout': '逾時',
      'JSON': 'JSON',
      'output': '輸出',
      'input': '輸入',
      'tracking': '追蹤',
      'multi-turn': '多輪',
      'conversation': '對話',
      'hidden files': '隱藏檔案',
      'suggestions': '建議',
      'functionality': '功能',
      'mentions': '提及',
      'custom': '自訂',
      'commands': '指令',
      'directory': '目錄',
      'paths': '路徑',
      'network': '網路',
      'connectivity': '連線',
      'reliability': '可靠性'
    };

    let translated = text;
    
    // 替換基本詞彙
    for (const [en, zh] of Object.entries(translations)) {
      const regex = new RegExp(`\\b${en}\\b`, 'gi');
      translated = translated.replace(regex, zh);
    }

    // 處理特殊格式
    translated = translated
      .replace(/Ctrl\+([a-zA-Z])/g, 'Ctrl+$1')
      .replace(/\/([a-zA-Z-]+)/g, '/$1')
      .replace(/`([^`]+)`/g, '`$1`')
      .replace(/CLAUDE\.md/g, 'CLAUDE.md')
      .replace(/\.bashrc/g, '.bashrc')
      .replace(/pnpm/g, 'pnpm')
      .replace(/npm/g, 'npm');

    return translated;
  }

  formatChangelogForChinese(versions) {
    const recentVersions = versions.slice(0, 20); // 只取最近20個版本
    let formattedText = '';

    for (const {version, changes} of recentVersions) {
      formattedText += `- ${version}\n\n`;
      
      const changeLines = changes.split('\n').filter(line => line.trim());
      for (const line of changeLines) {
        const cleanLine = line.replace(/^[-*]\s*/, '').trim();
        if (cleanLine && !cleanLine.startsWith('#')) {
          const translatedLine = this.translateChangelogItem(cleanLine);
          formattedText += `  - ${translatedLine}\n`;
        }
      }
      formattedText += '\n';
    }

    return formattedText.trim();
  }

  async updateMainDoc(changelogContent) {
    this.log('更新主文檔中的 CHANGELOG 區塊...', 'INFO');
    
    try {
      const content = await fs.readFile(this.mainDocPath, 'utf-8');
      
      // 尋找 CHANGELOG 區塊
      const changelogStartPattern = /### CHANGELOG 新功能摘錄（依版本，來源：GitHub CHANGELOG）/;
      const changelogEndPattern = /---\n\n## 🎉 結語/;
      
      const startMatch = content.match(changelogStartPattern);
      const endMatch = content.match(changelogEndPattern);
      
      if (!startMatch || !endMatch) {
        throw new Error('找不到 CHANGELOG 區塊標記');
      }

      const beforeChangelog = content.substring(0, startMatch.index + startMatch[0].length);
      const afterChangelog = content.substring(endMatch.index);
      
      const timestamp = new Date().toISOString().split('T')[0];
      const newChangelogSection = `

${changelogContent}

**最後更新時間**: ${timestamp}  
**資料來源**: [GitHub CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)

`;

      const newContent = beforeChangelog + newChangelogSection + afterChangelog;

      if (this.options.dryRun) {
        this.log('【預覽模式】CHANGELOG 區塊已準備更新', 'INFO');
        return;
      }

      await fs.writeFile(this.mainDocPath, newContent, 'utf-8');
      this.log('主文檔 CHANGELOG 區塊更新成功', 'SUCCESS');
      
    } catch (error) {
      this.log(`更新主文檔失敗: ${error.message}`, 'ERROR');
      throw error;
    }
  }

  async fetchOfficialDoc(page) {
    const url = `${this.baseUrl}/${page}`;
    this.log(`獲取官方文檔: ${page}`, 'VERBOSE');
    
    try {
      const content = await this.fetchWithRetry(url);
      return this.extractMainContent(content);
    } catch (error) {
      this.log(`獲取 ${page} 失敗: ${error.message}`, 'WARNING');
      return null;
    }
  }

  extractMainContent(html) {
    // 簡單的 HTML 內容提取（實際使用時可考慮使用 cheerio）
    let content = html;
    
    // 移除 HTML 標籤但保留結構
    content = content
      .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
      .replace(/<style\b[^<]*(?:(?!<\/style>)<[^<]*)*<\/style>/gi, '')
      .replace(/<nav\b[^<]*(?:(?!<\/nav>)<[^<]*)*<\/nav>/gi, '')
      .replace(/<header\b[^<]*(?:(?!<\/header>)<[^<]*)*<\/header>/gi, '')
      .replace(/<footer\b[^<]*(?:(?!<\/footer>)<[^<]*)*<\/footer>/gi, '');

    // 尋找主要內容區域
    const mainContentPattern = /<main[^>]*>([\s\S]*?)<\/main>/i;
    const match = content.match(mainContentPattern);
    
    if (match) {
      content = match[1];
    }

    // 基本的 HTML 到 Markdown 轉換
    content = content
      .replace(/<h([1-6])[^>]*>(.*?)<\/h[1-6]>/gi, (match, level, text) => {
        const hashes = '#'.repeat(parseInt(level));
        return `${hashes} ${text.replace(/<[^>]*>/g, '').trim()}`;
      })
      .replace(/<p[^>]*>(.*?)<\/p>/gi, '$1\n\n')
      .replace(/<li[^>]*>(.*?)<\/li>/gi, '* $1')
      .replace(/<code[^>]*>(.*?)<\/code>/gi, '`$1`')
      .replace(/<pre[^>]*>(.*?)<\/pre>/gi, '```\n$1\n```')
      .replace(/<a[^>]*href="([^"]*)"[^>]*>(.*?)<\/a>/gi, '[$2]($1)')
      .replace(/<strong[^>]*>(.*?)<\/strong>/gi, '**$1**')
      .replace(/<em[^>]*>(.*?)<\/em>/gi, '*$1*')
      .replace(/<br\s*\/?>/gi, '\n')
      .replace(/<[^>]*>/g, '') // 移除所有剩餘的 HTML 標籤
      .replace(/&nbsp;/g, ' ')
      .replace(/&amp;/g, '&')
      .replace(/&lt;/g, '<')
      .replace(/&gt;/g, '>')
      .replace(/&quot;/g, '"')
      .replace(/&#39;/g, "'")
      .replace(/\n\s*\n\s*\n/g, '\n\n') // 清理多餘的空行
      .trim();

    return content;
  }

  async updateLocalDoc(page, content) {
    const filePath = path.join(this.docsDir, `${page}.md`);
    const timestamp = new Date().toISOString().split('T')[0] + 'T' + 
                     new Date().toISOString().split('T')[1].split('.')[0] + '+08:00';
    
    const header = `---
source: "https://docs.anthropic.com/en/docs/claude-code/${page}"
fetched_at: "${timestamp}"
updated_features: "${timestamp} - 自動同步官方文檔"
---

[原始文件連結](https://docs.anthropic.com/en/docs/claude-code/${page})

`;

    const fullContent = header + content;

    if (this.options.dryRun) {
      this.log(`【預覽模式】準備更新: ${page}.md`, 'VERBOSE');
      return;
    }

    try {
      // 檢查檔案是否存在，如果存在則比較內容
      let shouldUpdate = this.options.force;
      
      if (!shouldUpdate) {
        try {
          const existingContent = await fs.readFile(filePath, 'utf-8');
          const existingMainContent = existingContent.split('---')[2] || '';
          shouldUpdate = existingMainContent.trim() !== content.trim();
        } catch {
          shouldUpdate = true; // 檔案不存在，需要建立
        }
      }

      if (shouldUpdate) {
        await fs.writeFile(filePath, fullContent, 'utf-8');
        this.log(`已更新: ${page}.md`, 'SUCCESS');
        return true;
      } else {
        this.log(`無變更: ${page}.md`, 'VERBOSE');
        return false;
      }
      
    } catch (error) {
      this.log(`更新 ${page}.md 失敗: ${error.message}`, 'ERROR');
      return false;
    }
  }

  async syncOfficialDocs() {
    if (this.options.changelogOnly) {
      this.log('跳過官方文檔同步（僅更新 CHANGELOG）', 'INFO');
      return { updated: 0, skipped: 0, failed: 0 };
    }

    this.log('開始同步官方文檔...', 'INFO');
    
    // 確保目錄存在
    await fs.mkdir(this.docsDir, { recursive: true });
    
    let updated = 0, skipped = 0, failed = 0;
    
    for (const [docName, page] of Object.entries(this.docPages)) {
      try {
        const content = await this.fetchOfficialDoc(page);
        if (content) {
          const wasUpdated = await this.updateLocalDoc(docName, content);
          if (wasUpdated) updated++;
          else skipped++;
        } else {
          failed++;
        }
        
        // 避免請求過於頻繁
        await new Promise(resolve => setTimeout(resolve, 1000));
        
      } catch (error) {
        this.log(`處理 ${docName} 時出錯: ${error.message}`, 'ERROR');
        failed++;
      }
    }

    return { updated, skipped, failed };
  }

  async generateReport(changelogVersions, docStats) {
    const timestamp = new Date().toISOString();
    const report = {
      timestamp,
      changelog: {
        versions_processed: changelogVersions ? changelogVersions.length : 0,
        latest_version: changelogVersions && changelogVersions.length > 0 ? changelogVersions[0].version : 'N/A'
      },
      docs: docStats,
      options: this.options
    };

    const reportPath = path.join(rootDir, 'sync-report.json');
    
    if (!this.options.dryRun) {
      await fs.writeFile(reportPath, JSON.stringify(report, null, 2), 'utf-8');
    }

    this.log('=== 同步報告 ===', 'INFO');
    this.log(`時間戳記: ${timestamp}`, 'INFO');
    this.log(`CHANGELOG 版本數: ${report.changelog.versions_processed}`, 'INFO');
    this.log(`最新版本: ${report.changelog.latest_version}`, 'INFO');
    this.log(`文檔更新: ${report.docs.updated} 個`, 'INFO');
    this.log(`文檔跳過: ${report.docs.skipped} 個`, 'INFO');
    this.log(`文檔失敗: ${report.docs.failed} 個`, 'INFO');
    
    if (this.options.dryRun) {
      this.log('【預覽模式】實際檔案未被修改', 'WARNING');
    }

    return report;
  }

  async run() {
    this.parseArgs();
    this.log('Claude Code 文檔自動同步工具啟動', 'INFO');

    try {
      // 1. 獲取並更新 CHANGELOG
      const changelogVersions = await this.fetchChangelog();
      const formattedChangelog = this.formatChangelogForChinese(changelogVersions);
      await this.updateMainDoc(formattedChangelog);

      // 2. 同步官方文檔
      const docStats = await this.syncOfficialDocs();

      // 3. 生成報告
      await this.generateReport(changelogVersions, docStats);

      this.log('文檔同步完成', 'SUCCESS');
      
    } catch (error) {
      this.log(`同步過程中發生錯誤: ${error.message}`, 'ERROR');
      process.exit(1);
    }
  }
}

// 當直接執行此腳本時
if (import.meta.url === `file://${process.argv[1]}`) {
  const sync = new ClaudeCodeDocSync();
  sync.run().catch(error => {
    console.error('\x1b[31m致命錯誤:\x1b[0m', error);
    process.exit(1);
  });
}

export default ClaudeCodeDocSync;
