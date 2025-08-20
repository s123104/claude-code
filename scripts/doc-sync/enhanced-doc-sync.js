#!/usr/bin/env node

/**
 * Claude Code 增強文檔自動同步工具
 * 
 * 功能：
 * 1. 智能爬取 Anthropic 官方文檔
 * 2. 高品質 HTML 到 Markdown 轉換
 * 3. 同步 CHANGELOG 內容並翻譯
 * 4. 檢測內容差異與版本變更
 * 5. 生成詳細同步報告
 * 
 * 技術特點：
 * - 使用 cheerio 進行精確的 HTML 解析
 * - 智能內容差異檢測
 * - 漸進式翻譯系統
 * - 完整的錯誤處理與重試機制
 * 
 * 使用方式：
 * node scripts/enhanced-doc-sync.js [選項]
 * 
 * 選項：
 * --force              強制更新所有文檔
 * --dry-run            預覽模式，不實際修改檔案
 * --changelog-only     僅更新 CHANGELOG
 * --verbose            詳細輸出
 * --target PAGE        僅同步指定頁面
 * --batch-size N       批次處理大小 (預設: 3)
 */

import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import { createWriteStream } from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.join(__dirname, '..');

class EnhancedClaudeCodeDocSync {
  constructor() {
    this.baseUrl = 'https://docs.anthropic.com/en/docs/claude-code';
    this.rawGithubUrl = 'https://raw.githubusercontent.com/anthropics/claude-code/main';
    this.docsDir = path.join(rootDir, 'docs/anthropic-claude-code-zh-tw');
    this.mainDocPath = path.join(rootDir, 'claude-code-zh-tw.md');
    
    // 官方文檔頁面配置
    this.docPages = {
      'overview': { 
        url: 'overview', 
        priority: 1, 
        description: '概述頁面',
        sections: ['get-started', 'features', 'why-developers-love']
      },
      'quickstart': { 
        url: 'quickstart', 
        priority: 1, 
        description: '快速開始指南',
        sections: ['installation', 'first-session', 'basic-commands']
      },
      'sub-agents': { 
        url: 'sub-agents', 
        priority: 2, 
        description: 'Subagents 專業代理系統',
        sections: ['what-are-subagents', 'configuration', 'management', 'examples']
      },
      'mcp': { 
        url: 'mcp', 
        priority: 2, 
        description: 'Model Context Protocol',
        sections: ['server-types', 'oauth', 'management', 'examples']
      },
      'common-workflows': { 
        url: 'common-workflows', 
        priority: 2, 
        description: '常用工作流程'
      },
      'sdk': { 
        url: 'sdk', 
        priority: 2, 
        description: 'SDK 文檔'
      },
      'hooks-guide': { 
        url: 'hooks-guide', 
        priority: 3, 
        description: 'Hooks 指南'
      },
      'github-actions': { 
        url: 'github-actions', 
        priority: 3, 
        description: 'GitHub Actions 整合'
      },
      'cli-reference': { 
        url: 'cli-reference', 
        priority: 2, 
        description: 'CLI 參考'
      },
      'settings': { 
        url: 'settings', 
        priority: 2, 
        description: '設定檔案'
      },
      'security': { 
        url: 'security', 
        priority: 3, 
        description: '安全設定'
      },
      'troubleshooting': { 
        url: 'troubleshooting', 
        priority: 3, 
        description: '疑難排解'
      }
    };
    
    this.options = {
      force: false,
      dryRun: false,
      changelogOnly: false,
      verbose: false,
      target: null,
      batchSize: 3
    };

    this.stats = {
      startTime: Date.now(),
      processed: 0,
      updated: 0,
      skipped: 0,
      failed: 0,
      errors: []
    };

    // 翻譯映射表
    this.translations = new Map([
      // 核心概念
      ['Claude Code', 'Claude Code'],
      ['subagents', '子代理'],
      ['Model Context Protocol', '模型上下文協議'],
      ['MCP', 'MCP'],
      ['hooks', 'hooks'],
      ['OAuth', 'OAuth'],
      ['API', 'API'],
      ['CLI', 'CLI'],
      ['SDK', 'SDK'],
      
      // 技術術語
      ['authentication', '認證'],
      ['authorization', '授權'],
      ['configuration', '配置'],
      ['environment', '環境'],
      ['session', '會話'],
      ['workspace', '工作區'],
      ['repository', '儲存庫'],
      ['directory', '目錄'],
      ['file', '檔案'],
      ['command', '指令'],
      ['parameter', '參數'],
      ['option', '選項'],
      ['flag', '參數'],
      ['argument', '參數'],
      
      // 操作動詞
      ['install', '安裝'],
      ['setup', '設定'],
      ['configure', '配置'],
      ['enable', '啟用'],
      ['disable', '停用'],
      ['update', '更新'],
      ['upgrade', '升級'],
      ['downgrade', '降級'],
      ['create', '建立'],
      ['delete', '刪除'],
      ['remove', '移除'],
      ['add', '新增'],
      ['edit', '編輯'],
      ['modify', '修改'],
      ['fix', '修復'],
      ['resolve', '解決'],
      ['debug', '除錯'],
      ['troubleshoot', '疑難排解'],
      
      // 狀態描述
      ['available', '可用'],
      ['enabled', '已啟用'],
      ['disabled', '已停用'],
      ['active', '啟用中'],
      ['inactive', '未啟用'],
      ['running', '執行中'],
      ['stopped', '已停止'],
      ['failed', '失敗'],
      ['successful', '成功'],
      ['completed', '完成'],
      ['pending', '待處理'],
      
      // 常見片語
      ['getting started', '快速開始'],
      ['quick start', '快速開始'],
      ['best practices', '最佳實踐'],
      ['common issues', '常見問題'],
      ['known issues', '已知問題'],
      ['release notes', '版本說明'],
      ['change log', '更新日誌'],
      ['user guide', '使用指南'],
      ['reference guide', '參考指南'],
      ['troubleshooting guide', '疑難排解指南']
    ]);
  }

  parseArgs() {
    const args = process.argv.slice(2);
    this.options.force = args.includes('--force');
    this.options.dryRun = args.includes('--dry-run');
    this.options.changelogOnly = args.includes('--changelog-only');
    this.options.verbose = args.includes('--verbose');
    
    const targetIndex = args.indexOf('--target');
    if (targetIndex !== -1 && args[targetIndex + 1]) {
      this.options.target = args[targetIndex + 1];
    }
    
    const batchIndex = args.indexOf('--batch-size');
    if (batchIndex !== -1 && args[batchIndex + 1]) {
      this.options.batchSize = parseInt(args[batchIndex + 1]) || 3;
    }
  }

  log(message, level = 'INFO') {
    const timestamp = new Date().toISOString().split('T')[1].split('.')[0];
    const colors = {
      INFO: '\x1b[36m',     // 青色
      SUCCESS: '\x1b[32m',  // 綠色
      WARNING: '\x1b[33m',  // 黃色
      ERROR: '\x1b[31m',    // 紅色
      VERBOSE: '\x1b[90m',  // 灰色
      PROGRESS: '\x1b[35m'  // 紫色
    };
    
    if (level === 'VERBOSE' && !this.options.verbose) return;
    
    const prefix = level === 'PROGRESS' ? '⏳' : 
                   level === 'SUCCESS' ? '✅' : 
                   level === 'WARNING' ? '⚠️' : 
                   level === 'ERROR' ? '❌' : 'ℹ️';
    
    console.log(`${colors[level]}${prefix} [${timestamp}] ${message}\x1b[0m`);
  }

  async loadDependencies() {
    try {
      // 動態導入依賴
      this.fetch = (await import('node-fetch')).default;
      this.cheerio = await import('cheerio');
      this.log('依賴加載成功', 'SUCCESS');
    } catch (error) {
      this.log(`依賴加載失敗: ${error.message}`, 'ERROR');
      this.log('請執行: cd scripts && npm install', 'INFO');
      throw error;
    }
  }

  async fetchWithRetry(url, maxRetries = 3) {
    for (let i = 0; i < maxRetries; i++) {
      try {
        this.log(`正在獲取: ${url}`, 'VERBOSE');
        
        const response = await this.fetch(url, {
          headers: {
            'User-Agent': 'Claude-Code-Enhanced-Doc-Sync/2.0.0',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.9',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache'
          },
          timeout: 30000
        });
        
        if (!response.ok) {
          throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        
        const content = await response.text();
        this.log(`成功獲取: ${url} (${content.length} 字符)`, 'VERBOSE');
        return content;
        
      } catch (error) {
        this.log(`獲取失敗 (嘗試 ${i + 1}/${maxRetries}): ${error.message}`, 'WARNING');
        if (i === maxRetries - 1) throw error;
        
        // 指數退避
        const delay = Math.min(2000 * Math.pow(2, i), 10000);
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
  }

  async fetchChangelog() {
    this.log('開始獲取 CHANGELOG...', 'INFO');
    
    try {
      const changelogUrl = `${this.rawGithubUrl}/CHANGELOG.md`;
      const content = await this.fetchWithRetry(changelogUrl);
      const versions = this.parseChangelog(content);
      
      this.log(`成功獲取 CHANGELOG，包含 ${versions.length} 個版本`, 'SUCCESS');
      return versions;
      
    } catch (error) {
      this.log(`獲取 CHANGELOG 失敗: ${error.message}`, 'ERROR');
      this.stats.errors.push({ type: 'changelog', error: error.message });
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
      
      // 檢測版本標題 (## 1.0.85 格式)
      if (line.match(/^##\s+(\d+\.\d+\.\d+)$/)) {
        if (currentVersion) {
          versions.push({
            version: currentVersion,
            changes: currentChanges.filter(c => c.trim()).join('\n').trim(),
            rawChanges: currentChanges
          });
        }
        currentVersion = line.replace(/^##\s+/, '');
        currentChanges = [];
      } else if (currentVersion && line) {
        currentChanges.push(line);
      }
    }

    // 添加最後一個版本
    if (currentVersion) {
      versions.push({
        version: currentVersion,
        changes: currentChanges.filter(c => c.trim()).join('\n').trim(),
        rawChanges: currentChanges
      });
    }

    return versions;
  }

  translateChangelogEntry(text) {
    let translated = text;
    
    // 應用翻譯映射
    for (const [en, zh] of this.translations) {
      const regex = new RegExp(`\\b${en.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'gi');
      translated = translated.replace(regex, zh);
    }

    // 特殊處理
    translated = translated
      // 保持技術術語的格式
      .replace(/Ctrl\+([a-zA-Z])/g, 'Ctrl+$1')
      .replace(/\/([a-zA-Z-]+)/g, '/$1')
      .replace(/`([^`]+)`/g, '`$1`')
      .replace(/--([a-zA-Z-]+)/g, '--$1')
      
      // 常見動詞翻譯
      .replace(/\bFixed\b/g, '修復')
      .replace(/\bAdded\b/g, '新增')
      .replace(/\bImproved\b/g, '改善')
      .replace(/\bEnhanced\b/g, '增強')
      .replace(/\bUpgraded\b/g, '升級')
      .replace(/\bEnabled\b/g, '啟用')
      .replace(/\bDisabled\b/g, '停用')
      .replace(/\bSupport\b/g, '支援')
      .replace(/\bsupport\b/g, '支援')
      
      // 技術術語本地化
      .replace(/\bWindows\b/g, 'Windows')
      .replace(/\bmacOS\b/g, 'macOS')
      .replace(/\bLinux\b/g, 'Linux')
      .replace(/\bNode\.js\b/g, 'Node.js')
      .replace(/\bnpm\b/g, 'npm')
      .replace(/\bpnpm\b/g, 'pnpm')
      .replace(/\byarn\b/g, 'yarn')
      .replace(/\bVS\s?Code\b/g, 'VS Code')
      .replace(/\bGitHub\b/g, 'GitHub')
      .replace(/\bGit\b/g, 'Git')
      
      // 檔案和路徑
      .replace(/\.bashrc/g, '.bashrc')
      .replace(/\.claude/g, '.claude')
      .replace(/CLAUDE\.md/g, 'CLAUDE.md')
      .replace(/package\.json/g, 'package.json')
      
      // 清理多餘空格
      .replace(/\s+/g, ' ')
      .trim();

    return translated;
  }

  formatChangelogForChinese(versions) {
    const recentVersions = versions.slice(0, 25); // 取最近25個版本
    let formattedText = '';

    for (const {version, changes, rawChanges} of recentVersions) {
      formattedText += `### ${version}\n\n`;
      
      // 解析變更項目
      const changeItems = rawChanges
        .filter(line => line.trim() && line.startsWith('-'))
        .map(line => line.replace(/^-\s*/, '').trim())
        .filter(line => line && !line.startsWith('#'));

      if (changeItems.length === 0) {
        // 如果沒有標準格式的項目，嘗試解析整體內容
        const lines = changes.split('\n').filter(line => line.trim());
        for (const line of lines) {
          const translated = this.translateChangelogEntry(line);
          formattedText += `- ${translated}\n`;
        }
      } else {
        // 處理標準格式的變更項目
        for (const item of changeItems) {
          const translated = this.translateChangelogEntry(item);
          formattedText += `- ${translated}\n`;
        }
      }
      
      formattedText += '\n';
    }

    return formattedText.trim();
  }

  async fetchOfficialDoc(page, config) {
    const url = `${this.baseUrl}/${config.url}`;
    this.log(`獲取官方文檔: ${page} (${config.description})`, 'VERBOSE');
    
    try {
      const html = await this.fetchWithRetry(url);
      const content = await this.parseHtmlToMarkdown(html, page, config);
      
      this.log(`成功解析: ${page} (${content.length} 字符)`, 'VERBOSE');
      return content;
      
    } catch (error) {
      this.log(`獲取 ${page} 失敗: ${error.message}`, 'WARNING');
      this.stats.errors.push({ 
        type: 'fetch', 
        page, 
        error: error.message,
        url 
      });
      return null;
    }
  }

  async parseHtmlToMarkdown(html, page, config) {
    const $ = this.cheerio.load(html);
    
    // 移除不需要的元素
    $('script, style, nav, header, footer, .sidebar, .navigation').remove();
    $('[class*="nav"], [class*="menu"], [class*="sidebar"]').remove();
    
    // 尋找主要內容區域
    let content = '';
    const mainSelectors = [
      'main',
      '[role="main"]', 
      '.main-content',
      '.content',
      '.docs-content',
      '.markdown-body',
      'article'
    ];

    let $main = null;
    for (const selector of mainSelectors) {
      $main = $(selector).first();
      if ($main.length > 0) break;
    }

    if (!$main || $main.length === 0) {
      // 如果找不到主要內容區域，使用 body
      $main = $('body');
    }

    // 轉換為 Markdown
    content = this.htmlToMarkdown($main, $);
    
    // 後處理
    content = this.postProcessMarkdown(content, page, config);
    
    return content;
  }

  htmlToMarkdown($element, $) {
    let markdown = '';
    
    $element.contents().each((i, elem) => {
      const $elem = $(elem);
      const tagName = elem.tagName ? elem.tagName.toLowerCase() : null;
      
      if (elem.type === 'text') {
        const text = $(elem).text().trim();
        if (text) {
          markdown += text + ' ';
        }
      } else if (tagName) {
        switch (tagName) {
          case 'h1':
            markdown += `\n# ${$elem.text().trim()}\n\n`;
            break;
          case 'h2':
            markdown += `\n## ${$elem.text().trim()}\n\n`;
            break;
          case 'h3':
            markdown += `\n### ${$elem.text().trim()}\n\n`;
            break;
          case 'h4':
            markdown += `\n#### ${$elem.text().trim()}\n\n`;
            break;
          case 'h5':
            markdown += `\n##### ${$elem.text().trim()}\n\n`;
            break;
          case 'h6':
            markdown += `\n###### ${$elem.text().trim()}\n\n`;
            break;
          case 'p':
            const pText = this.htmlToMarkdown($elem, $).trim();
            if (pText) {
              markdown += `${pText}\n\n`;
            }
            break;
          case 'ul':
            $elem.find('li').each((i, li) => {
              const liText = this.htmlToMarkdown($(li), $).trim();
              if (liText) {
                markdown += `* ${liText}\n`;
              }
            });
            markdown += '\n';
            break;
          case 'ol':
            $elem.find('li').each((i, li) => {
              const liText = this.htmlToMarkdown($(li), $).trim();
              if (liText) {
                markdown += `${i + 1}. ${liText}\n`;
              }
            });
            markdown += '\n';
            break;
          case 'code':
            markdown += `\`${$elem.text()}\``;
            break;
          case 'pre':
            const codeText = $elem.find('code').length > 0 
              ? $elem.find('code').text() 
              : $elem.text();
            const language = $elem.find('code').attr('class')?.match(/language-(\w+)/)?.[1] || '';
            markdown += `\n\`\`\`${language}\n${codeText}\n\`\`\`\n\n`;
            break;
          case 'a':
            const href = $elem.attr('href');
            const linkText = $elem.text().trim();
            if (href && linkText) {
              markdown += `[${linkText}](${href})`;
            } else {
              markdown += linkText;
            }
            break;
          case 'strong':
          case 'b':
            markdown += `**${$elem.text().trim()}**`;
            break;
          case 'em':
          case 'i':
            markdown += `*${$elem.text().trim()}*`;
            break;
          case 'table':
            markdown += this.parseTable($elem, $);
            break;
          case 'br':
            markdown += '\n';
            break;
          case 'blockquote':
            const quoteText = this.htmlToMarkdown($elem, $).trim();
            const quoteLines = quoteText.split('\n').map(line => `> ${line}`).join('\n');
            markdown += `\n${quoteLines}\n\n`;
            break;
          default:
            // 對於其他元素，遞歸處理其內容
            markdown += this.htmlToMarkdown($elem, $);
            break;
        }
      }
    });
    
    return markdown;
  }

  parseTable($table, $) {
    let markdown = '\n';
    const rows = [];
    
    $table.find('tr').each((i, tr) => {
      const cells = [];
      $(tr).find('th, td').each((j, cell) => {
        cells.push($(cell).text().trim().replace(/\|/g, '\\|'));
      });
      rows.push(cells);
    });
    
    if (rows.length === 0) return '';
    
    // 表頭
    if (rows[0]) {
      markdown += `| ${rows[0].join(' | ')} |\n`;
      markdown += `| ${rows[0].map(() => '---').join(' | ')} |\n`;
    }
    
    // 表格內容
    for (let i = 1; i < rows.length; i++) {
      if (rows[i]) {
        markdown += `| ${rows[i].join(' | ')} |\n`;
      }
    }
    
    markdown += '\n';
    return markdown;
  }

  postProcessMarkdown(content, page, config) {
    return content
      // 清理多餘的空行
      .replace(/\n{3,}/g, '\n\n')
      // 清理行首尾空格
      .split('\n').map(line => line.trim()).join('\n')
      // 清理段落間多餘空格
      .replace(/\n\s*\n/g, '\n\n')
      // 修復列表格式
      .replace(/\*\s*\n/g, '\n')
      // 確保代碼塊格式正確
      .replace(/```\n\n/g, '```\n')
      .replace(/\n\n```/g, '\n```')
      .trim();
  }

  async updateLocalDoc(page, content, config) {
    const filePath = path.join(this.docsDir, `${page}.md`);
    const timestamp = new Date().toISOString().split('T')[0] + 'T' + 
                     new Date().toISOString().split('T')[1].split('.')[0] + '+08:00';
    
    const frontmatter = {
      source: `"${this.baseUrl}/${config.url}"`,
      fetched_at: `"${timestamp}"`,
      updated_features: `"${timestamp} - 增強版自動同步官方文檔"`,
      description: `"${config.description}"`,
      priority: config.priority
    };

    const header = `---
${Object.entries(frontmatter).map(([key, value]) => `${key}: ${value}`).join('\n')}
---

[原始文件連結](${this.baseUrl}/${config.url})

# ${config.description}

`;

    const fullContent = header + content;

    if (this.options.dryRun) {
      this.log(`【預覽模式】準備更新: ${page}.md (${content.length} 字符)`, 'VERBOSE');
      return false;
    }

    try {
      // 檢查檔案是否存在以及內容是否有變化
      let shouldUpdate = this.options.force;
      let existingSize = 0;
      
      if (!shouldUpdate) {
        try {
          const existingContent = await fs.readFile(filePath, 'utf-8');
          existingSize = existingContent.length;
          
          // 比較主要內容 (排除 frontmatter)
          const existingMainContent = existingContent.split('---').slice(2).join('---').trim();
          const newMainContent = content.trim();
          
          // 內容差異檢測
          const contentChanged = existingMainContent !== newMainContent;
          const sizeDifference = Math.abs(existingSize - fullContent.length);
          const significantChange = sizeDifference > 100 || contentChanged;
          
          shouldUpdate = significantChange;
          
          if (shouldUpdate) {
            this.log(`檢測到內容變更: ${page}.md (大小差異: ${sizeDifference} 字符)`, 'VERBOSE');
          }
          
        } catch {
          shouldUpdate = true; // 檔案不存在
          this.log(`建立新檔案: ${page}.md`, 'VERBOSE');
        }
      }

      if (shouldUpdate) {
        await fs.writeFile(filePath, fullContent, 'utf-8');
        this.log(`✅ 已更新: ${page}.md (${content.length} 字符)`, 'SUCCESS');
        return true;
      } else {
        this.log(`⏭️ 無變更: ${page}.md (${existingSize} 字符)`, 'VERBOSE');
        return false;
      }
      
    } catch (error) {
      this.log(`❌ 更新 ${page}.md 失敗: ${error.message}`, 'ERROR');
      this.stats.errors.push({ 
        type: 'write', 
        page, 
        error: error.message,
        filePath 
      });
      return false;
    }
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

**📅 最後更新時間**: ${timestamp}  
**📊 資料來源**: [GitHub CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)  
**🔄 同步工具**: Enhanced Doc Sync v2.0

`;

      const newContent = beforeChangelog + newChangelogSection + afterChangelog;

      if (this.options.dryRun) {
        this.log('【預覽模式】CHANGELOG 區塊已準備更新', 'INFO');
        return;
      }

      await fs.writeFile(this.mainDocPath, newContent, 'utf-8');
      this.log('✅ 主文檔 CHANGELOG 區塊更新成功', 'SUCCESS');
      
    } catch (error) {
      this.log(`❌ 更新主文檔失敗: ${error.message}`, 'ERROR');
      this.stats.errors.push({ 
        type: 'main-doc', 
        error: error.message 
      });
      throw error;
    }
  }

  async syncOfficialDocs() {
    if (this.options.changelogOnly) {
      this.log('⏭️ 跳過官方文檔同步（僅更新 CHANGELOG）', 'INFO');
      return { updated: 0, skipped: 0, failed: 0 };
    }

    this.log('🚀 開始同步官方文檔...', 'INFO');
    
    // 確保目錄存在
    await fs.mkdir(this.docsDir, { recursive: true });
    
    // 篩選要處理的頁面
    let pagesToProcess = Object.entries(this.docPages);
    
    if (this.options.target) {
      pagesToProcess = pagesToProcess.filter(([page]) => page === this.options.target);
      if (pagesToProcess.length === 0) {
        throw new Error(`指定的頁面不存在: ${this.options.target}`);
      }
      this.log(`🎯 僅處理指定頁面: ${this.options.target}`, 'INFO');
    }

    // 按優先級排序
    pagesToProcess.sort(([,a], [,b]) => a.priority - b.priority);
    
    let updated = 0, skipped = 0, failed = 0;
    const total = pagesToProcess.length;
    
    // 批次處理
    for (let i = 0; i < pagesToProcess.length; i += this.options.batchSize) {
      const batch = pagesToProcess.slice(i, i + this.options.batchSize);
      
      this.log(`📦 處理批次 ${Math.floor(i / this.options.batchSize) + 1}/${Math.ceil(total / this.options.batchSize)} (${batch.length} 個項目)`, 'PROGRESS');
      
      const batchPromises = batch.map(async ([page, config]) => {
        try {
          this.stats.processed++;
          const progress = `${this.stats.processed}/${total}`;
          this.log(`🔄 [${progress}] 處理: ${page}`, 'PROGRESS');
          
          const content = await this.fetchOfficialDoc(page, config);
          if (content) {
            const wasUpdated = await this.updateLocalDoc(page, content, config);
            return { page, status: wasUpdated ? 'updated' : 'skipped', config };
          } else {
            return { page, status: 'failed', config };
          }
          
        } catch (error) {
          this.log(`❌ 處理 ${page} 時出錯: ${error.message}`, 'ERROR');
          this.stats.errors.push({ 
            type: 'process', 
            page, 
            error: error.message 
          });
          return { page, status: 'failed', config };
        }
      });

      const batchResults = await Promise.allSettled(batchPromises);
      
      // 統計批次結果
      for (const result of batchResults) {
        if (result.status === 'fulfilled') {
          const { status } = result.value;
          if (status === 'updated') updated++;
          else if (status === 'skipped') skipped++;
          else failed++;
        } else {
          failed++;
        }
      }
      
      // 批次間延遲
      if (i + this.options.batchSize < pagesToProcess.length) {
        await new Promise(resolve => setTimeout(resolve, 2000));
      }
    }

    this.log(`📊 文檔同步完成: ${updated} 更新, ${skipped} 跳過, ${failed} 失敗`, 'INFO');
    return { updated, skipped, failed };
  }

  async generateReport(changelogVersions, docStats) {
    const endTime = Date.now();
    const duration = Math.round((endTime - this.stats.startTime) / 1000);
    
    const report = {
      timestamp: new Date().toISOString(),
      duration_seconds: duration,
      changelog: {
        versions_processed: changelogVersions ? changelogVersions.length : 0,
        latest_version: changelogVersions && changelogVersions.length > 0 ? changelogVersions[0].version : 'N/A',
        versions_updated: changelogVersions ? Math.min(25, changelogVersions.length) : 0
      },
      docs: {
        ...docStats,
        total_pages: Object.keys(this.docPages).length,
        target_page: this.options.target
      },
      options: this.options,
      stats: this.stats,
      errors: this.stats.errors,
      performance: {
        pages_per_second: docStats.updated > 0 ? (docStats.updated / duration).toFixed(2) : '0',
        average_page_time: docStats.updated > 0 ? `${(duration / docStats.updated).toFixed(1)}s` : 'N/A'
      }
    };

    const reportPath = path.join(rootDir, 'sync-report-enhanced.json');
    
    if (!this.options.dryRun) {
      await fs.writeFile(reportPath, JSON.stringify(report, null, 2), 'utf-8');
      this.log(`📄 詳細報告已儲存: ${reportPath}`, 'INFO');
    }

    // 輸出摘要報告
    this.log('\n' + '='.repeat(60), 'INFO');
    this.log('📊 同步完成報告', 'INFO');
    this.log('='.repeat(60), 'INFO');
    this.log(`⏱️  執行時間: ${duration}s`, 'INFO');
    this.log(`📅 時間戳記: ${report.timestamp}`, 'INFO');
    this.log(`📝 CHANGELOG 版本: ${report.changelog.versions_processed} (更新 ${report.changelog.versions_updated})`, 'INFO');
    this.log(`📄 最新版本: ${report.changelog.latest_version}`, 'INFO');
    this.log(`📚 文檔統計:`, 'INFO');
    this.log(`   ✅ 更新: ${docStats.updated} 個`, 'SUCCESS');
    this.log(`   ⏭️  跳過: ${docStats.skipped} 個`, 'INFO');
    this.log(`   ❌ 失敗: ${docStats.failed} 個`, docStats.failed > 0 ? 'WARNING' : 'INFO');
    this.log(`⚡ 效能: ${report.performance.pages_per_second} 頁/秒`, 'INFO');
    
    if (this.stats.errors.length > 0) {
      this.log(`\n⚠️  發現 ${this.stats.errors.length} 個錯誤:`, 'WARNING');
      for (const error of this.stats.errors.slice(0, 5)) {
        this.log(`   ${error.type}: ${error.page || 'N/A'} - ${error.error}`, 'ERROR');
      }
      if (this.stats.errors.length > 5) {
        this.log(`   ... 還有 ${this.stats.errors.length - 5} 個錯誤，詳見報告文件`, 'WARNING');
      }
    }
    
    if (this.options.dryRun) {
      this.log('\n🔍 【預覽模式】實際檔案未被修改', 'WARNING');
    } else {
      this.log('\n✨ 同步作業完成', 'SUCCESS');
    }

    return report;
  }

  async run() {
    this.parseArgs();
    this.log('🚀 Claude Code 增強文檔自動同步工具啟動', 'INFO');
    this.log(`🔧 配置: ${JSON.stringify(this.options, null, 2)}`, 'VERBOSE');

    try {
      // 0. 載入依賴
      await this.loadDependencies();

      // 1. 獲取並更新 CHANGELOG
      this.log('📋 階段 1: 處理 CHANGELOG', 'INFO');
      const changelogVersions = await this.fetchChangelog();
      const formattedChangelog = this.formatChangelogForChinese(changelogVersions);
      await this.updateMainDoc(formattedChangelog);

      // 2. 同步官方文檔
      this.log('📚 階段 2: 同步官方文檔', 'INFO');
      const docStats = await this.syncOfficialDocs();

      // 3. 生成報告
      this.log('📊 階段 3: 生成報告', 'INFO');
      await this.generateReport(changelogVersions, docStats);

      process.exit(0);
      
    } catch (error) {
      this.log(`💥 同步過程中發生致命錯誤: ${error.message}`, 'ERROR');
      this.log(`🔍 錯誤堆疊: ${error.stack}`, 'VERBOSE');
      
      // 生成錯誤報告
      const errorReport = {
        timestamp: new Date().toISOString(),
        error: error.message,
        stack: error.stack,
        options: this.options,
        stats: this.stats
      };
      
      if (!this.options.dryRun) {
        const errorPath = path.join(rootDir, 'sync-error.json');
        await fs.writeFile(errorPath, JSON.stringify(errorReport, null, 2), 'utf-8');
        this.log(`📄 錯誤報告已儲存: ${errorPath}`, 'INFO');
      }
      
      process.exit(1);
    }
  }
}

// 當直接執行此腳本時
if (import.meta.url === `file://${process.argv[1]}`) {
  const sync = new EnhancedClaudeCodeDocSync();
  sync.run().catch(error => {
    console.error('\x1b[31m💥 致命錯誤:\x1b[0m', error);
    process.exit(1);
  });
}

export default EnhancedClaudeCodeDocSync;
