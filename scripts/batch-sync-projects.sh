#!/bin/bash
# 批次同步所有 18 個 Claude Code 相關專案
# 生成時間: 2025-10-28T05:30:00+08:00

set -e

# 顏色定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 專案清單
PROJECTS=(
    "agents"
    "SuperClaude_Framework"
    "Claude-Code-Usage-Monitor"
    "awesome-claude-code"
    "claude-code-guide"
    "claudecodeui"
    "BPlusTree3"
    "claudia"
    "claude-code-hooks"
    "claude-code-spec"
    "ccusage"
    "vibe-kanban"
    "claude-agents"
    "ClaudeCode-Debugger"
    "claude-code-leaderboard"
    "context-engineering-intro"
    "contains-studio-agents"
    "claude-code-security-review"
)

# 基礎目錄
BASE_DIR="/Users/azlife.eth/claude-code/analysis-projects"
REPORT_FILE="/Users/azlife.eth/claude-code/PROJECT-SYNC-REPORT.md"

# 初始化報告
echo "# 專案同步報告" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**生成時間**: $(date '+%Y-%m-%dT%H:%M:%S+08:00')" >> "$REPORT_FILE"
echo "**專案總數**: ${#PROJECTS[@]}" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

SUCCESS_COUNT=0
FAIL_COUNT=0

for PROJECT in "${PROJECTS[@]}"; do
    echo -e "${YELLOW}正在同步: $PROJECT${NC}"
    
    cd "$BASE_DIR/$PROJECT" || {
        echo -e "${RED}✗ 失敗: 無法進入目錄 $PROJECT${NC}"
        echo "## ❌ $PROJECT" >> "$REPORT_FILE"
        echo "- **狀態**: 失敗" >> "$REPORT_FILE"
        echo "- **原因**: 目錄不存在" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        continue
    }
    
    # 執行 git 同步
    echo "  - Fetching..."
    if git fetch origin &>/dev/null; then
        echo "  - Resetting..."
        git reset --hard origin/main &>/dev/null || git reset --hard origin/master &>/dev/null
        echo "  - Cleaning..."
        git clean -fd &>/dev/null
        echo "  - Pulling..."
        git pull --rebase origin main &>/dev/null || git pull --rebase origin master &>/dev/null
        
        # 提取版本資訊
        VERSION=$(git describe --tags --abbrev=0 2>/dev/null || echo "無版本標籤")
        LAST_COMMIT=$(git log -1 --format="%ai" 2>/dev/null || echo "未知")
        COMMIT_HASH=$(git log -1 --format="%h" 2>/dev/null || echo "未知")
        
        echo -e "${GREEN}✓ 成功: $PROJECT${NC}"
        echo "  版本: $VERSION"
        echo "  最後更新: $LAST_COMMIT"
        
        # 寫入報告
        echo "## ✅ $PROJECT" >> "$REPORT_FILE"
        echo "- **狀態**: 成功同步" >> "$REPORT_FILE"
        echo "- **版本**: $VERSION" >> "$REPORT_FILE"
        echo "- **Commit**: $COMMIT_HASH" >> "$REPORT_FILE"
        echo "- **最後更新**: $LAST_COMMIT" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    else
        echo -e "${RED}✗ 失敗: $PROJECT (無法 fetch)${NC}"
        echo "## ❌ $PROJECT" >> "$REPORT_FILE"
        echo "- **狀態**: 失敗" >> "$REPORT_FILE"
        echo "- **原因**: Git fetch 失敗" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        FAIL_COUNT=$((FAIL_COUNT + 1))
    fi
    
    echo ""
done

# 生成統計摘要
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## 📊 統計摘要" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "| 項目 | 數量 |" >> "$REPORT_FILE"
echo "|------|------|" >> "$REPORT_FILE"
echo "| 總專案數 | ${#PROJECTS[@]} |" >> "$REPORT_FILE"
echo "| 成功同步 | $SUCCESS_COUNT |" >> "$REPORT_FILE"
echo "| 同步失敗 | $FAIL_COUNT |" >> "$REPORT_FILE"
echo "| 成功率 | $(awk "BEGIN {printf \"%.1f%%\", ($SUCCESS_COUNT/${#PROJECTS[@]})*100}") |" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo -e "${GREEN}========================${NC}"
echo -e "${GREEN}同步完成！${NC}"
echo -e "${GREEN}成功: $SUCCESS_COUNT / ${#PROJECTS[@]}${NC}"
echo -e "${GREEN}失敗: $FAIL_COUNT${NC}"
echo -e "${GREEN}報告已生成: $REPORT_FILE${NC}"
echo -e "${GREEN}========================${NC}"

exit 0

