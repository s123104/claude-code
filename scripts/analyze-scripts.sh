#!/bin/bash
# 腳本分析與檢查工具
# 生成時間: 2025-10-28T05:40:00+08:00

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPTS_DIR="/Users/azlife.eth/claude-code/scripts"
REPORT_FILE="$SCRIPTS_DIR/scripts-analysis-report.md"

echo "# 腳本分析報告" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**生成時間**: $(date '+%Y-%m-%dT%H:%M:%S+08:00')" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Claude Code 腳本分析與檢查工具                      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# 1. 列出所有腳本（排除 node_modules）
echo -e "${YELLOW}📋 掃描腳本檔案...${NC}"
echo "" >> "$REPORT_FILE"
echo "## 1. 腳本清單" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "### 根目錄腳本 (scripts/)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "| 檔案名稱 | 類型 | 大小 | 最後修改 |" >> "$REPORT_FILE"
echo "|----------|------|------|----------|" >> "$REPORT_FILE"

cd "$SCRIPTS_DIR"
for file in *.sh *.js *.cjs; do
    if [ -f "$file" ] 2>/dev/null; then
        size=$(ls -lh "$file" 2>/dev/null | awk '{print $5}')
        modified=$(ls -l "$file" 2>/dev/null | awk '{print $6, $7, $8}')
        type="${file##*.}"
        echo "| \`$file\` | $type | $size | $modified |" >> "$REPORT_FILE"
        echo -e "${GREEN}✓${NC} $file ($size)"
    fi
done 2>/dev/null

echo "" >> "$REPORT_FILE"
echo "### doc-sync 子目錄腳本" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "| 檔案名稱 | 類型 | 大小 | 最後修改 |" >> "$REPORT_FILE"
echo "|----------|------|------|----------|" >> "$REPORT_FILE"

cd "$SCRIPTS_DIR/doc-sync"
for file in *.sh *.js *.cjs; do
    if [ -f "$file" ] 2>/dev/null; then
        size=$(ls -lh "$file" 2>/dev/null | awk '{print $5}')
        modified=$(ls -l "$file" 2>/dev/null | awk '{print $6, $7, $8}')
        type="${file##*.}"
        echo "| \`$file\` | $type | $size | $modified |" >> "$REPORT_FILE"
        echo -e "${GREEN}✓${NC} doc-sync/$file ($size)"
    fi
done 2>/dev/null

echo ""
echo -e "${YELLOW}📊 生成功能分析...${NC}"
echo "" >> "$REPORT_FILE"
echo "## 2. 功能分析" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 2. 功能分類
cat >> "$REPORT_FILE" << 'FUNC_EOF'
### 根目錄腳本功能

| 腳本名稱 | 主要功能 | 狀態 | 備註 |
|---------|---------|------|------|
| `auto-doc-updater.js` | 自動檢查並更新專案文檔 | ⚠️ 過時 | 功能被 doc-sync 取代 |
| `batch-sync-projects.sh` | 批次同步 18 個專案 | ✅ 有效 | 核心同步工具 |
| `docs.sh` | 舊版文檔工具 | ❌ 廢棄 | 功能不明，建議移除 |
| `import-mcp-servers.sh` | MCP 伺服器導入 | ✅ 有效 | 獨立功能 |
| `professional-doc-sync.js` | 專業文檔同步 | ⚠️ 重複 | 與 doc-sync 功能重疊 |
| `quality-checker.js` | 文檔品質檢查 | ✅ 有效 | 品質保證工具 |
| `setup-git-hooks.sh` | Git hooks 設定 | ✅ 有效 | 自動化工具 |
| `sync-official-docs.sh` | 同步官方文檔 | ⚠️ 重複 | 與 doc-sync 功能重疊 |
| `sync-versions.sh` | 版本同步 | ✅ 有效 | 版本管理工具 |
| `update-all-docs.sh` | 更新所有文檔 | ✅ 有效 | 批次更新工具 |
| `validate-docs.sh` | 文檔驗證 | ✅ 有效 | 驗證工具 |

### doc-sync 子目錄腳本功能

| 腳本名稱 | 主要功能 | 狀態 | 備註 |
|---------|---------|------|------|
| `auto-doc-sync.js` | 基本文檔同步 | ✅ 有效 | 保留作為簡單版本 |
| `enhanced-doc-sync.js` | 增強文檔同步 | ✅ 有效 | 推薦使用 |
| `sync-docs.sh` | Shell 包裝器 | ✅ 有效 | 執行入口 |
| `zh-tw-translator-simple.cjs` | 簡化翻譯器 | ✅ 有效 | 獨立翻譯工具 |
| `zh-tw-translator.cjs` | 完整翻譯器 | ✅ 有效 | 進階翻譯 |
| `zh-tw-translator.js` | 翻譯器 (ESM) | ⚠️ 重複 | 與 .cjs 重複 |

FUNC_EOF

echo "" >> "$REPORT_FILE"
echo "## 3. 重複檢測" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "### 功能重疊的腳本組" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**組 1: 文檔同步功能**" >> "$REPORT_FILE"
echo "- \`auto-doc-updater.js\` (根目錄)" >> "$REPORT_FILE"
echo "- \`professional-doc-sync.js\` (根目錄)" >> "$REPORT_FILE"
echo "- \`sync-official-docs.sh\` (根目錄)" >> "$REPORT_FILE"
echo "- \`doc-sync/enhanced-doc-sync.js\` ✅ 保留" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**建議**: 移除根目錄的同步腳本，統一使用 \`doc-sync/\` 模組" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**組 2: 翻譯器**" >> "$REPORT_FILE"
echo "- \`doc-sync/zh-tw-translator.js\` (ESM)" >> "$REPORT_FILE"
echo "- \`doc-sync/zh-tw-translator.cjs\` (CommonJS) ✅ 保留" >> "$REPORT_FILE"
echo "- \`doc-sync/zh-tw-translator-simple.cjs\` (簡化版) ✅ 保留" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**建議**: 移除 .js 版本，保留 .cjs 版本以確保相容性" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "## 4. 清理建議" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "### 建議移除的檔案" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "1. \`auto-doc-updater.js\` - 功能已被 doc-sync 取代" >> "$REPORT_FILE"
echo "2. \`professional-doc-sync.js\` - 與 doc-sync/enhanced-doc-sync.js 重複" >> "$REPORT_FILE"
echo "3. \`sync-official-docs.sh\` - 與 doc-sync/sync-docs.sh 重複" >> "$REPORT_FILE"
echo "4. \`docs.sh\` - 舊版工具，功能不明" >> "$REPORT_FILE"
echo "5. \`doc-sync/zh-tw-translator.js\` - 與 .cjs 版本重複" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "### 建議保留的檔案" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "1. \`batch-sync-projects.sh\` - 專案批次同步（核心工具）" >> "$REPORT_FILE"
echo "2. \`import-mcp-servers.sh\` - MCP 伺服器導入（獨立功能）" >> "$REPORT_FILE"
echo "3. \`quality-checker.js\` - 文檔品質檢查（品質保證）" >> "$REPORT_FILE"
echo "4. \`setup-git-hooks.sh\` - Git hooks 設定（自動化）" >> "$REPORT_FILE"
echo "5. \`sync-versions.sh\` - 版本同步（版本管理）" >> "$REPORT_FILE"
echo "6. \`update-all-docs.sh\` - 文檔批次更新（批次工具）" >> "$REPORT_FILE"
echo "7. \`validate-docs.sh\` - 文檔驗證（驗證工具）" >> "$REPORT_FILE"
echo "8. \`doc-sync/\` 整個目錄 - 文檔同步模組（核心模組）" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo ""
echo -e "${GREEN}✅ 分析完成！報告已生成：$REPORT_FILE${NC}"
echo ""
cat "$REPORT_FILE"
