#!/bin/bash

##
# 批次更新所有專案的繁體中文文檔
# 自動檢查版本並更新對應文檔
##

set -euo pipefail

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 目錄設定
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ANALYSIS_DIR="$ROOT_DIR/analysis-projects"
DOCS_DIR="$ROOT_DIR/docs"

# 專案對應文檔映射（已移除過時專案：2025-12-24）
# 已淘汰：Claude-Code-Usage-Monitor, claudia, claude-agents, ClaudeCode-Debugger, claude-code-leaderboard
declare -A PROJECT_DOCS=(
    ["agents"]="agents-zh-tw.md"
    ["awesome-claude-code"]="awesome-claude-code-zh-tw.md"
    ["SuperClaude_Framework"]="superclaude-zh-tw.md"
    ["claude-code-guide"]="claude-code-guide-zh-tw.md"
    ["claudecodeui"]="claudecodeui-zh-tw.md"
    ["BPlusTree3"]="bplustree3-zh-tw.md"
    ["claude-code-spec"]="claude-code-spec-zh-tw.md"
    ["ccusage"]="ccusage-zh-tw.md"
    ["vibe-kanban"]="vibe-kanban-zh-tw.md"
    ["context-engineering-intro"]="context-engineering-intro-zh-tw.md"
    ["contains-studio-agents"]="contains-studio-agents-zh-tw.md"
    ["claude-code-security-review"]="claude-code-security-review-zh-tw.md"
)

# 日誌函數
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case $level in
        "INFO")
            echo -e "${CYAN}ℹ️  [${timestamp}] ${message}${NC}"
            ;;
        "SUCCESS")
            echo -e "${GREEN}✅ [${timestamp}] ${message}${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  [${timestamp}] ${message}${NC}"
            ;;
        "ERROR")
            echo -e "${RED}❌ [${timestamp}] ${message}${NC}"
            ;;
    esac
}

# 獲取專案版本資訊
get_project_version() {
    local project_dir=$1
    cd "$project_dir"
    
    # 嘗試獲取 tag 版本
    local version=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
    
    if [ -z "$version" ]; then
        # 如果沒有 tag，使用最後提交日期
        version=$(git log -1 --format=%cd --date=format:'%Y-%m-%d' 2>/dev/null || echo "未知")
    fi
    
    echo "$version"
}

# 更新文檔版本標註
update_doc_version() {
    local doc_file=$1
    local version=$2
    local project_name=$3
    
    if [ ! -f "$doc_file" ]; then
        log "WARNING" "文檔不存在: $doc_file"
        return 1
    fi
    
    # 使用 sed 更新版本標註（跨平台兼容）
    local temp_file="${doc_file}.tmp"
    awk -v ver="$version" -v proj="$project_name" '
    BEGIN { in_header = 0; updated = 0 }
    /^>/ && !in_header { in_header = 1 }
    in_header && /版本[：:]/ {
        if (!updated) {
            print "> - **版本**：" ver
            updated = 1
            next
        }
    }
    in_header && /最後更新/ {
        print "> - **最後更新**：" strftime("%Y-%m-%dT%H:%M:%S+08:00")
        next
    }
    /^[^>]/ && in_header { in_header = 0 }
    { print }
    ' "$doc_file" > "$temp_file" && mv "$temp_file" "$doc_file"
    
    log "SUCCESS" "已更新 $project_name 文檔版本: $version"
}

# 主函數
main() {
    log "INFO" "開始批次更新所有專案文檔..."
    
    local total=0
    local updated=0
    local skipped=0
    
    cd "$ANALYSIS_DIR"
    
    for project_dir in */; do
        project_name="${project_dir%/}"
        total=$((total + 1))
        
        # 檢查是否有對應的文檔
        doc_name="${PROJECT_DOCS[$project_name]:-}"
        
        if [ -z "$doc_name" ]; then
            log "WARNING" "找不到 $project_name 對應的文檔映射"
            skipped=$((skipped + 1))
            continue
        fi
        
        doc_file="$DOCS_DIR/$doc_name"
        
        if [ ! -f "$doc_file" ]; then
            log "WARNING" "文檔檔案不存在: $doc_file"
            skipped=$((skipped + 1))
            continue
        fi
        
        # 獲取專案版本
        log "INFO" "處理 $project_name..."
        version=$(get_project_version "$ANALYSIS_DIR/$project_dir")
        
        # 更新文檔
        if update_doc_version "$doc_file" "$version" "$project_name"; then
            updated=$((updated + 1))
        else
            skipped=$((skipped + 1))
        fi
    done
    
    echo ""
    log "SUCCESS" "批次更新完成！"
    log "INFO" "總計: $total | 已更新: $updated | 略過: $skipped"
}

# 執行主函數
main "$@"

