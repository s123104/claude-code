#!/bin/bash

##
# Claude Code 官方文檔專業同步工具
# 
# 功能：
# - 深度驗證官方文檔最新狀態
# - 智能內容差異檢測
# - 自動同步更新
# - 高品質 CHANGELOG 翻譯
##

set -euo pipefail

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 腳本目錄
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# 顯示橫幅
show_banner() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║     Claude Code 官方文檔專業同步工具 v3.0.0                  ║"
    echo "║              Deep Verification & Auto Sync                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 日誌函數
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case $level in
        "INFO")
            echo -e "${CYAN}ℹ️  [${timestamp}] INFO: ${message}${NC}"
            ;;
        "SUCCESS")
            echo -e "${GREEN}✅ [${timestamp}] SUCCESS: ${message}${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  [${timestamp}] WARNING: ${message}${NC}"
            ;;
        "ERROR")
            echo -e "${RED}❌ [${timestamp}] ERROR: ${message}${NC}"
            ;;
    esac
}

# 檢查依賴
check_dependencies() {
    log "INFO" "檢查系統依賴..."
    
    # 檢查 Node.js
    if ! command -v node &> /dev/null; then
        log "ERROR" "Node.js 未安裝。請先安裝 Node.js 18+ 版本"
        exit 1
    fi
    
    local node_version=$(node --version | sed 's/v//')
    log "SUCCESS" "Node.js 版本: $node_version"
    
    # 檢查 npm 依賴
    if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
        log "WARNING" "依賴尚未安裝，正在安裝..."
        cd "$SCRIPT_DIR"
        npm install --silent
        log "SUCCESS" "依賴安裝完成"
    fi
}

# 執行同步
run_sync() {
    local args="$@"
    
    log "INFO" "開始執行文檔深度同步..."
    log "INFO" "參數: ${args:-<無>}"
    
    cd "$SCRIPT_DIR"
    
    if node professional-doc-sync.js $args; then
        log "SUCCESS" "同步作業完成"
        
        # 顯示報告摘要
        if [ -f "$ROOT_DIR/sync-report-professional.json" ]; then
            echo -e "\n${BLUE}📊 同步報告已生成:${NC} sync-report-professional.json"
            
            # 如果有 jq，顯示摘要
            if command -v jq &> /dev/null; then
                echo -e "${BLUE}📈 快速摘要:${NC}"
                jq -r '
                    "   📄 總頁面: " + (.statistics.total_pages | tostring) +
                    "\n   ✨ 新增: " + (.statistics.new_pages | tostring) +
                    "\n   🔄 更新: " + (.statistics.updated_pages | tostring) +
                    "\n   ✓  無變更: " + (.statistics.unchanged_pages | tostring) +
                    "\n   📝 CHANGELOG 版本: " + (.statistics.changelog_versions | tostring) +
                    "\n   ⏱️  耗時: " + (.duration_seconds | tostring) + "秒"
                ' "$ROOT_DIR/sync-report-professional.json"
            fi
        fi
        
        return 0
    else
        log "ERROR" "同步作業失敗"
        return 1
    fi
}

# 顯示使用說明
show_help() {
    cat << EOF
Claude Code 官方文檔專業同步工具

使用方式:
    $0 [選項]

選項:
    --verbose         詳細輸出模式
    --dry-run         預覽模式，不實際修改檔案
    --force           強制更新所有文檔（即使內容相同）
    --changelog-only  僅同步 CHANGELOG
    --docs-only       僅同步文檔（跳過 CHANGELOG）
    --help           顯示此說明

範例:
    $0                       # 完整同步（文檔 + CHANGELOG）
    $0 --dry-run            # 預覽將要進行的變更
    $0 --verbose            # 詳細輸出模式
    $0 --changelog-only     # 僅同步 CHANGELOG
    $0 --docs-only          # 僅同步文檔頁面
    $0 --force --verbose    # 強制更新並顯示詳細資訊

功能說明:
    ✓ 深度驗證官方文檔最新狀態
    ✓ 智能內容差異檢測（MD5 雜湊比對）
    ✓ 自動同步更新到本地
    ✓ 高品質 CHANGELOG 翻譯
    ✓ 詳細同步報告生成
    ✓ 錯誤追蹤和記錄

技術特點:
    • 支援 30+ 個官方文檔頁面
    • 按優先級排序同步
    • 智能內容解析（HTML 轉 Markdown）
    • 防止請求過快（500ms 間隔）
    • 完整的錯誤處理機制

EOF
}

# 主函數
main() {
    # 解析參數
    if [[ "$*" == *"--help"* ]] || [[ "$*" == *"-h"* ]]; then
        show_help
        exit 0
    fi
    
    show_banner
    
    # 檢查依賴
    check_dependencies
    
    # 執行同步
    if run_sync "$@"; then
        echo -e "\n${GREEN}✨ 文檔同步系統執行完成！${NC}"
        exit 0
    else
        echo -e "\n${RED}💥 文檔同步系統執行失敗${NC}"
        exit 1
    fi
}

# 捕獲中斷信號
trap 'log "WARNING" "收到中斷信號，正在清理..."; exit 130' INT TERM

# 執行主函數
main "$@"

