#!/usr/bin/env node
/**
 * sync-html-versions.js
 * 
 * 從 SSOT (config/metadata.json) 自動同步版本資訊到 index.html
 * 
 * @author Claude Code 自動化專家
 * @version 1.0.0
 * @created 2025-12-25T01:46:55+08:00
 * 
 * Usage:
 *   node scripts/sync-html-versions.js [--dry-run] [--verbose]
 * 
 * Options:
 *   --dry-run   僅顯示變更，不實際寫入
 *   --verbose   顯示詳細資訊
 * 
 * [context7:/cheeriojs/cheerio - HTML parsing best practices]
 */

const fs = require('fs');
const path = require('path');

// 配置
const CONFIG = {
  metadataPath: path.join(__dirname, '../config/metadata.json'),
  htmlPath: path.join(__dirname, '../index.html'),
};

// 解析命令行參數
const args = process.argv.slice(2);
const DRY_RUN = args.includes('--dry-run');
const VERBOSE = args.includes('--verbose');

/**
 * 日誌輸出
 */
function log(message, type = 'info') {
  const prefix = {
    info: '📌',
    success: '✅',
    warning: '⚠️',
    error: '❌',
    change: '🔄',
  };
  console.log(`${prefix[type] || '📌'} ${message}`);
}

/**
 * 詳細日誌
 */
function verbose(message) {
  if (VERBOSE) {
    console.log(`   ${message}`);
  }
}

/**
 * 讀取 SSOT 元數據
 */
function readMetadata() {
  try {
    const content = fs.readFileSync(CONFIG.metadataPath, 'utf8');
    return JSON.parse(content);
  } catch (error) {
    log(`無法讀取 metadata.json: ${error.message}`, 'error');
    process.exit(1);
  }
}

/**
 * 讀取 HTML 檔案
 */
function readHtml() {
  try {
    return fs.readFileSync(CONFIG.htmlPath, 'utf8');
  } catch (error) {
    log(`無法讀取 index.html: ${error.message}`, 'error');
    process.exit(1);
  }
}

/**
 * 寫入 HTML 檔案
 */
function writeHtml(content) {
  if (DRY_RUN) {
    log('Dry run 模式 - 不寫入檔案', 'warning');
    return;
  }
  try {
    fs.writeFileSync(CONFIG.htmlPath, content, 'utf8');
    log('index.html 已更新', 'success');
  } catch (error) {
    log(`無法寫入 index.html: ${error.message}`, 'error');
    process.exit(1);
  }
}

/**
 * 格式化日期 (ISO 8601 -> 顯示格式)
 */
function formatDate(isoString) {
  const date = new Date(isoString);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

/**
 * 執行替換並記錄變更
 */
function replaceAndLog(html, pattern, replacement, description) {
  const regex = new RegExp(pattern, 'g');
  const matches = html.match(regex);
  
  if (matches && matches.length > 0) {
    const newHtml = html.replace(regex, replacement);
    if (newHtml !== html) {
      log(`${description}: ${matches.length} 處`, 'change');
      matches.forEach(match => verbose(`  - "${match.substring(0, 50)}..."`));
      return newHtml;
    }
  }
  
  verbose(`${description}: 無需更新`);
  return html;
}

/**
 * 主程式
 */
function main() {
  console.log('╔════════════════════════════════════════════════════════╗');
  console.log('║     SSOT → index.html 版本同步工具 v1.0.0              ║');
  console.log('╚════════════════════════════════════════════════════════╝');
  console.log('');
  
  if (DRY_RUN) {
    log('執行 Dry Run 模式', 'warning');
  }
  
  // 1. 讀取 SSOT
  log('讀取 SSOT 元數據...', 'info');
  const metadata = readMetadata();
  
  const claudeCodeVersion = metadata.claudeCode?.version || '2.0.75';
  const projectVersion = metadata.project?.version || '5.1.0';
  const lastUpdated = metadata.lastUpdated || new Date().toISOString();
  const activeProjects = metadata.documentation?.totalProjects || 14;
  const archivedProjects = metadata.documentation?.archivedProjects || 5;
  
  console.log('');
  log('SSOT 資訊:', 'info');
  console.log(`   Claude Code: v${claudeCodeVersion}`);
  console.log(`   專案版本: v${projectVersion}`);
  console.log(`   更新日期: ${formatDate(lastUpdated)}`);
  console.log(`   活躍專案: ${activeProjects}`);
  console.log(`   歸檔專案: ${archivedProjects}`);
  console.log('');
  
  // 2. 讀取 HTML
  log('讀取 index.html...', 'info');
  let html = readHtml();
  const originalHtml = html;
  
  // 3. 執行替換
  log('執行版本同步...', 'info');
  console.log('');
  
  // Claude Code 版本 - 僅替換 meta 標籤中的版本
  // 不替換專案卡片中的版本號 (各專案有自己的版本)
  html = replaceAndLog(
    html,
    'Claude Code v2\\.0\\.\\d{1,3}',
    `Claude Code v${claudeCodeVersion}`,
    'Claude Code 版本 (meta)'
  );
  
  // 專案版本 (v5.X.X 格式)
  html = replaceAndLog(
    html,
    'v5\\.\\d+\\.\\d+',
    `v${projectVersion}`,
    '專案版本'
  );
  
  // 日期格式 - 僅更新 meta 標籤和 footer 中的日期
  // 不更新專案卡片中各專案的發布日期
  const formattedDate = formatDate(lastUpdated);
  
  // 更新 meta 標籤中的日期
  html = replaceAndLog(
    html,
    '最後更新 \\d{4}-\\d{2}-\\d{2}',
    `最後更新 ${formattedDate}`,
    'Meta 日期'
  );
  
  // 更新 footer 時間戳記
  html = replaceAndLog(
    html,
    'datetime="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}"',
    `datetime="${formattedDate}T00:00:00"`,
    'Footer datetime'
  );
  
  // 更新顯示的更新日期
  html = replaceAndLog(
    html,
    '最後更新時間：\\d{4}-\\d{2}-\\d{2}',
    `最後更新時間：${formattedDate}`,
    '顯示更新日期'
  );
  
  // 專案數量
  html = replaceAndLog(
    html,
    '\\d+ 個專案',
    `${activeProjects} 個專案`,
    '專案數量文字'
  );
  
  html = replaceAndLog(
    html,
    '\\d+ 個活躍專案',
    `${activeProjects} 個活躍專案`,
    '活躍專案數量'
  );
  
  console.log('');
  
  // 4. 統計變更
  if (html === originalHtml) {
    log('無需更新 - 版本已同步', 'success');
  } else {
    const lineChanges = html.split('\n').length - originalHtml.split('\n').length;
    log(`共計變更 ${Math.abs(lineChanges)} 行`, 'info');
    
    // 5. 寫入檔案
    writeHtml(html);
  }
  
  console.log('');
  log('同步完成', 'success');
}

// 執行
main();
