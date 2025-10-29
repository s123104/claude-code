#!/usr/bin/env node
/**
 * sync-changelog.js - 自動同步 CHANGELOG 到主文檔
 * 
 * 功能：
 * - 從 claude-code-changelog-2.0-zh-tw.md 讀取 CHANGELOG
 * - 自動替換 claude-code-zh-tw.md 中對應區塊
 * - 保留格式與結構
 * 
 * 使用方法：
 *   node scripts/sync-changelog.js
 */

import { readFileSync, writeFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const rootDir = join(__dirname, '..');

// 檔案路徑
const CHANGELOG_FILE = join(rootDir, 'claude-code-changelog-2.0-zh-tw.md');
const MAIN_DOC_FILE = join(rootDir, 'claude-code-zh-tw.md');

// ANSI 顏色
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  red: '\x1b[31m',
};

function log(msg, color = 'reset') {
  console.log(`${colors[color]}${msg}${colors.reset}`);
}

/**
 * 從 CHANGELOG 檔案中提取內容（去除檔頭）
 */
function extractChangelogContent() {
  log('📖 讀取 CHANGELOG 檔案...', 'blue');
  const content = readFileSync(CHANGELOG_FILE, 'utf-8');
  
  // 跳過第一行標題，從第二行開始
  const lines = content.split('\n');
  const startIndex = lines.findIndex(line => line.trim().startsWith('## 2.0.28'));
  
  if (startIndex === -1) {
    throw new Error('找不到 CHANGELOG 起始點 (## 2.0.28)');
  }
  
  // 找到最後的元資訊區塊（**📅 最後更新時間**）
  const endIndex = lines.findIndex(line => line.includes('**📅 最後更新時間**'));
  
  if (endIndex === -1) {
    throw new Error('找不到 CHANGELOG 結束點');
  }
  
  // 提取 CHANGELOG 內容（包含元資訊）
  const changelogContent = lines.slice(startIndex, endIndex + 4).join('\n');
  
  log(`✅ 成功提取 ${endIndex - startIndex + 4} 行 CHANGELOG 內容`, 'green');
  return changelogContent;
}

/**
 * 替換主文檔中的 CHANGELOG 區塊
 */
function replaceChangelogInMainDoc(changelogContent) {
  log('📝 讀取主文檔...', 'blue');
  const mainDoc = readFileSync(MAIN_DOC_FILE, 'utf-8');
  
  // 找到 CHANGELOG 區塊的開始和結束
  const startMarker = '### CHANGELOG 新功能摘錄（依版本，來源：GitHub CHANGELOG）';
  const endMarker = '**📌 版本範圍**: 1.0.115 - 2.0.28（最新）';
  
  const startIndex = mainDoc.indexOf(startMarker);
  const endIndex = mainDoc.indexOf(endMarker);
  
  if (startIndex === -1 || endIndex === -1) {
    throw new Error('找不到主文檔中的 CHANGELOG 區塊標記');
  }
  
  // 找到結束標記的下一行（包含完整的結束行）
  const endLineEnd = mainDoc.indexOf('\n', endIndex + endMarker.length);
  
  // 構建新內容
  const before = mainDoc.substring(0, startIndex);
  const after = mainDoc.substring(endLineEnd);
  
  const newContent = `${before}${startMarker}\n\n${changelogContent}${after}`;
  
  log('💾 寫入更新後的主文檔...', 'yellow');
  writeFileSync(MAIN_DOC_FILE, newContent, 'utf-8');
  
  log('✅ 主文檔 CHANGELOG 區塊已成功更新！', 'green');
}

/**
 * 主執行函數
 */
function main() {
  try {
    log('\n🚀 開始同步 CHANGELOG...', 'blue');
    log('='.repeat(60), 'blue');
    
    // 1. 提取 CHANGELOG 內容
    const changelogContent = extractChangelogContent();
    
    // 2. 替換主文檔中的內容
    replaceChangelogInMainDoc(changelogContent);
    
    log('='.repeat(60), 'green');
    log('🎉 CHANGELOG 同步完成！', 'green');
    log('\n📊 更新統計:', 'blue');
    log(`  ✓ 來源檔案: ${CHANGELOG_FILE.split('/').pop()}`, 'green');
    log(`  ✓ 目標檔案: ${MAIN_DOC_FILE.split('/').pop()}`, 'green');
    log(`  ✓ 更新時間: ${new Date().toISOString().split('.')[0].replace('T', ' ')}`, 'green');
    log('');
    
  } catch (error) {
    log('\n❌ 錯誤：' + error.message, 'red');
    process.exit(1);
  }
}

// 執行
main();

