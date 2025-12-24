#!/bin/bash
#
# Claude Code 文檔專案自動維護腳本
# 整合所有維護任務：同步、驗證、更新、提交
#
# 使用方式：
#   bash scripts/auto-maintenance.sh [選項]
#
# 選項：
#   --full        完整維護（所有步驟）
#   --sync        僅同步專案
#   --validate    僅驗證文檔
#   --update      僅更新日期
#   --commit      自動提交變更
#   --dry-run     預覽模式
#   --help        顯示幫助
#
# 建立時間：2025-12-24T21:43:48+08:00
# 維護者：Claude Code 團隊

set -euo pipefail

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# 配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ANALYSIS_DIR="$ROOT_DIR/analysis-projects"
DOCS_DIR="$ROOT_DIR/docs"
TIMESTAMP=$(date '+%Y-%m-%dT%H:%M:%S+08:00')
LOG_FILE="$SCRIPT_DIR/maintenance.log"

# 預設選項
DO_SYNC=false
DO_VALIDATE=false
DO_UPDATE=false
DO_COMMIT=false
DRY_RUN=false

# 日誌函數
log() {
    local level=$1
    shift
    local message="$*"
    local ts=$(date '+%Y-%m-%d %H:%M:%S')
    
    case $level in
        "INFO")
            echo -e "${CYAN}ℹ️  [${ts}] ${message}${NC}"
            ;;
        "SUCCESS")
            echo -e "${GREEN}✅ [${ts}] ${message}${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  [${ts}] ${message}${NC}"
            ;;
        "ERROR")
            echo -e "${RED}❌ [${ts}] ${message}${NC}"
            ;;
        "STEP")
            echo -e "${BOLD}${BLUE}━━━ ${message} ━━━${NC}"
            ;;
    esac
    
    echo "[$ts] [$level] $message" >> "$LOG_FILE"
}

# 顯示幫助
show_help() {
    cat << EOF
${BOLD}Claude Code 文檔專案自動維護腳本${NC}

${CYAN}使用方式：${NC}
  bash scripts/auto-maintenance.sh [選項]

${CYAN}選項：${NC}
  --full        完整維護（同步 + 驗證 + 更新 + 提交）
  --sync        同步 analysis-projects 專案
  --validate    驗證文檔品質
  --update      更新文檔日期
  --commit      自動提交變更
  --dry-run     預覽模式（不實際執行）
  --help        顯示此幫助

${CYAN}範例：${NC}
  bash scripts/auto-maintenance.sh --full          # 完整維護
  bash scripts/auto-maintenance.sh --sync --update # 同步並更新
  bash scripts/auto-maintenance.sh --validate      # 僅驗證
  bash scripts/auto-maintenance.sh --full --dry-run # 預覽完整維護

EOF
}

# 同步專案
sync_projects() {
    log "STEP" "同步 analysis-projects 專案"
    
    if [ ! -d "$ANALYSIS_DIR" ]; then
        log "ERROR" "analysis-projects 目錄不存在"
        return 1
    fi
    
    local success_count=0
    local fail_count=0
    
    cd "$ANALYSIS_DIR"
    for dir in */; do
        local project="${dir%/}"
        log "INFO" "同步 $project..."
        
        if [ "$DRY_RUN" = true ]; then
            log "INFO" "[DRY-RUN] 將同步 $project"
            success_count=$((success_count + 1))
            continue
        fi
        
        cd "$dir"
        if git fetch origin 2>/dev/null; then
            local default_branch=$(git remote show origin 2>/dev/null | grep 'HEAD branch' | awk '{print $NF}' || echo "main")
            git reset --hard "origin/$default_branch" 2>/dev/null || git reset --hard origin/master 2>/dev/null || true
            log "SUCCESS" "已同步 $project"
            success_count=$((success_count + 1))
        else
            log "WARNING" "無法同步 $project"
            fail_count=$((fail_count + 1))
        fi
        cd ..
    done
    
    log "SUCCESS" "同步完成：成功 $success_count / 失敗 $fail_count"
}

# 更新文檔日期
update_doc_dates() {
    log "STEP" "更新文檔日期"
    
    cd "$ANALYSIS_DIR"
    local updated=0
    
    for dir in */; do
        local project="${dir%/}"
        cd "$dir"
        local proj_date=$(git log -1 --format='%cd' --date=short 2>/dev/null || echo "")
        cd ..
        
        if [ -z "$proj_date" ]; then
            continue
        fi
        
        # 找到對應的文檔（已淘汰 2025-12-24：claudia, claude-code-leaderboard, ClaudeCode-Debugger, Claude-Code-Usage-Monitor, claude-agents, claude-code-hooks）
        local doc_file=""
        case "$project" in
            "agents") doc_file="agents-zh-tw.md" ;;
            "ccusage") doc_file="ccusage-zh-tw.md" ;;
            "SuperClaude_Framework") doc_file="superclaude-zh-tw.md" ;;
            "claudecodeui") doc_file="claudecodeui-zh-tw.md" ;;
            "vibe-kanban") doc_file="vibe-kanban-zh-tw.md" ;;
            "claude-code-spec") doc_file="claude-code-spec-zh-tw.md" ;;
            "awesome-claude-code") doc_file="awesome-claude-code-zh-tw.md" ;;
            "claude-code-guide") doc_file="claude-code-guide-zh-tw.md" ;;
            "BPlusTree3") doc_file="bplustree3-zh-tw.md" ;;
            "context-engineering-intro") doc_file="context-engineering-intro-zh-tw.md" ;;
            "claude-code-security-review") doc_file="claude-code-security-review-zh-tw.md" ;;
            "contains-studio-agents") doc_file="contains-studio-agents-zh-tw.md" ;;
        esac
        
        if [ -n "$doc_file" ] && [ -f "$DOCS_DIR/$doc_file" ]; then
            # 檢查文檔中的日期
            local doc_date=$(grep -o '專案最後更新.*[0-9-]*' "$DOCS_DIR/$doc_file" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -1)
            
            if [ "$doc_date" != "$proj_date" ]; then
                log "INFO" "$project: $doc_date → $proj_date"
                
                if [ "$DRY_RUN" = false ]; then
                    sed -i '' "s/專案最後更新.*：${doc_date}/專案最後更新**：${proj_date}/" "$DOCS_DIR/$doc_file" 2>/dev/null || true
                fi
                updated=$((updated + 1))
            fi
        fi
    done
    
    # 更新文件整理時間
    local current_time=$(date '+%Y-%m-%dT%H:%M:00+08:00')
    log "INFO" "更新文件整理時間為 $current_time"
    
    if [ "$DRY_RUN" = false ]; then
        for file in "$DOCS_DIR"/*-zh-tw.md; do
            if [ -f "$file" ]; then
                sed -i '' "s/文件整理時間.*：[0-9T:+-]*/文件整理時間**：${current_time}/" "$file" 2>/dev/null || true
            fi
        done
    fi
    
    log "SUCCESS" "已更新 $updated 個專案日期"
}

# 驗證文檔
validate_docs() {
    log "STEP" "驗證文檔品質"
    
    local error_count=0
    local warning_count=0
    
    # 檢查 Markdown 語法
    for file in "$DOCS_DIR"/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            
            # 檢查程式碼區塊配對
            local code_blocks=$(grep -c "^\`\`\`" "$file" 2>/dev/null || echo "0")
            if [ $((code_blocks % 2)) -ne 0 ]; then
                log "ERROR" "$filename: 程式碼區塊未正確關閉"
                error_count=$((error_count + 1))
            fi
            
            # 檢查元資料
            if ! grep -q "專案版本" "$file" 2>/dev/null; then
                log "WARNING" "$filename: 缺少專案版本"
                warning_count=$((warning_count + 1))
            fi
        fi
    done
    
    if [ $error_count -eq 0 ] && [ $warning_count -eq 0 ]; then
        log "SUCCESS" "所有文檔驗證通過"
    else
        log "WARNING" "發現 $error_count 個錯誤，$warning_count 個警告"
    fi
    
    return $error_count
}

# 更新 index.html
update_index() {
    log "STEP" "更新 index.html"
    
    if [ "$DRY_RUN" = true ]; then
        log "INFO" "[DRY-RUN] 將執行 sync-index-docs.js"
        return 0
    fi
    
    cd "$ROOT_DIR"
    if node scripts/sync-index-docs.js 2>/dev/null; then
        log "SUCCESS" "index.html 已更新"
    else
        log "WARNING" "index.html 更新失敗"
    fi
}

# 提交變更
commit_changes() {
    log "STEP" "提交變更"
    
    cd "$ROOT_DIR"
    
    if [ -z "$(git status --porcelain)" ]; then
        log "INFO" "沒有需要提交的變更"
        return 0
    fi
    
    if [ "$DRY_RUN" = true ]; then
        log "INFO" "[DRY-RUN] 將提交以下變更："
        git status --short
        return 0
    fi
    
    git add .
    git commit -m "docs: 自動維護更新 $(date '+%Y-%m-%d %H:%M')" || true
    
    log "SUCCESS" "變更已提交"
}

# 主函數
main() {
    echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${BLUE}║     Claude Code 文檔專案自動維護系統                        ║${NC}"
    echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    log "INFO" "開始維護流程..."
    log "INFO" "時間: $TIMESTAMP"
    
    if [ "$DRY_RUN" = true ]; then
        log "WARNING" "預覽模式 - 不會實際執行任何變更"
    fi
    
    # 執行各步驟
    if [ "$DO_SYNC" = true ]; then
        sync_projects
    fi
    
    if [ "$DO_UPDATE" = true ]; then
        update_doc_dates
        update_index
    fi
    
    if [ "$DO_VALIDATE" = true ]; then
        validate_docs || true
    fi
    
    if [ "$DO_COMMIT" = true ]; then
        commit_changes
    fi
    
    log "SUCCESS" "維護流程完成！"
    echo ""
    echo -e "${BOLD}${GREEN}════════════════════════════════════════════════════════════════${NC}"
}

# 解析參數
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

while [ $# -gt 0 ]; do
    case "$1" in
        --full)
            DO_SYNC=true
            DO_VALIDATE=true
            DO_UPDATE=true
            DO_COMMIT=true
            ;;
        --sync)
            DO_SYNC=true
            ;;
        --validate)
            DO_VALIDATE=true
            ;;
        --update)
            DO_UPDATE=true
            ;;
        --commit)
            DO_COMMIT=true
            ;;
        --dry-run)
            DRY_RUN=true
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            log "ERROR" "未知參數: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done

# 執行主函數
main
