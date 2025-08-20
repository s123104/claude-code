#!/bin/bash

##
# Claude Code 文檔同步執行腳本
# 
# 功能：
# - 自動檢查依賴
# - 執行文檔同步
# - 生成同步報告
# - 錯誤處理與日誌
##

set -euo pipefail

# 顏色輸出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 腳本目錄
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

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
        "PROGRESS")
            echo -e "${PURPLE}⏳ [${timestamp}] PROGRESS: ${message}${NC}"
            ;;
    esac
}

# 檢查依賴
check_dependencies() {
    log "INFO" "檢查系統依賴..."
    
    # 檢查 Node.js
    if ! command -v node &> /dev/null; then
        log "ERROR" "Node.js 未安裝。請先安裝 Node.js 18+ 版本"
        log "INFO" "安裝指令: https://nodejs.org/"
        exit 1
    fi
    
    local node_version=$(node --version | sed 's/v//')
    local required_version="18.0.0"
    
    if [ "$(printf '%s\n' "$required_version" "$node_version" | sort -V | head -n1)" != "$required_version" ]; then
        log "ERROR" "Node.js 版本過舊。當前版本: $node_version，需要: $required_version+"
        exit 1
    fi
    
    log "SUCCESS" "Node.js 版本檢查通過: $node_version"
    
    # 檢查 npm 依賴
    if [ ! -f "$SCRIPT_DIR/package.json" ]; then
        log "ERROR" "找不到 package.json 文件"
        exit 1
    fi
    
    if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
        log "WARNING" "依賴尚未安裝，正在安裝..."
        install_dependencies
    fi
    
    log "SUCCESS" "依賴檢查完成"
}

# 安裝依賴
install_dependencies() {
    log "INFO" "安裝 NPM 依賴..."
    
    cd "$SCRIPT_DIR"
    
    if ! npm install; then
        log "ERROR" "依賴安裝失敗"
        exit 1
    fi
    
    log "SUCCESS" "依賴安裝完成"
}

# 執行同步
run_sync() {
    local mode=${1:-"normal"}
    local target_page=${2:-""}
    
    log "INFO" "開始執行文檔同步..."
    log "INFO" "模式: $mode"
    
    cd "$SCRIPT_DIR"
    
    local sync_command="node enhanced-doc-sync.js"
    
    case $mode in
        "dry-run")
            sync_command="$sync_command --dry-run"
            log "INFO" "預覽模式：不會實際修改檔案"
            ;;
        "force")
            sync_command="$sync_command --force"
            log "WARNING" "強制模式：將覆蓋所有現有文檔"
            ;;
        "changelog")
            sync_command="$sync_command --changelog-only"
            log "INFO" "僅同步 CHANGELOG"
            ;;
        "verbose")
            sync_command="$sync_command --verbose"
            log "INFO" "詳細輸出模式"
            ;;
    esac
    
    if [ -n "$target_page" ]; then
        sync_command="$sync_command --target $target_page"
        log "INFO" "目標頁面: $target_page"
    fi
    
    log "PROGRESS" "執行指令: $sync_command"
    
    # 捕獲開始時間
    local start_time=$(date +%s)
    
    # 執行同步
    if $sync_command; then
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))
        log "SUCCESS" "文檔同步完成 (耗時: ${duration}s)"
        return 0
    else
        local exit_code=$?
        log "ERROR" "文檔同步失敗 (錯誤代碼: $exit_code)"
        return $exit_code
    fi
}

# 顯示同步報告
show_report() {
    local report_file="$ROOT_DIR/sync-report-enhanced.json"
    
    if [ -f "$report_file" ]; then
        log "INFO" "同步報告摘要:"
        
        # 使用 node 解析 JSON (如果可用)
        if command -v jq &> /dev/null; then
            echo -e "${BLUE}📊 統計資料:${NC}"
            jq -r '
                "   📅 時間: " + .timestamp + 
                "\n   ⏱️  耗時: " + (.duration_seconds | tostring) + "s" +
                "\n   📝 CHANGELOG: " + (.changelog.versions_processed | tostring) + " 版本" +
                "\n   📄 最新版本: " + .changelog.latest_version +
                "\n   📚 文檔統計:" +
                "\n      ✅ 更新: " + (.docs.updated | tostring) +
                "\n      ⏭️  跳過: " + (.docs.skipped | tostring) +
                "\n      ❌ 失敗: " + (.docs.failed | tostring) +
                "\n   ⚡ 效能: " + .performance.pages_per_second + " 頁/秒"
            ' "$report_file"
            
            # 顯示錯誤（如有）
            local error_count=$(jq '.errors | length' "$report_file")
            if [ "$error_count" -gt 0 ]; then
                echo -e "${YELLOW}⚠️  發現 $error_count 個錯誤，詳見報告文件${NC}"
            fi
        else
            echo -e "${BLUE}📄 詳細報告請查看: $report_file${NC}"
        fi
    else
        log "WARNING" "找不到同步報告文件"
    fi
}

# 清理功能
cleanup() {
    log "INFO" "清理暫存檔案..."
    
    # 清理錯誤報告（超過7天）
    find "$ROOT_DIR" -name "sync-error-*.json" -mtime +7 -delete 2>/dev/null || true
    
    # 清理舊的報告（保留最近5個）
    find "$ROOT_DIR" -name "sync-report-*.json" | sort -r | tail -n +6 | xargs rm -f 2>/dev/null || true
    
    log "SUCCESS" "清理完成"
}

# 顯示使用說明
show_help() {
    cat << EOF
Claude Code 文檔同步執行腳本

使用方式:
    $0 [模式] [選項]

模式:
    normal      標準同步模式 (預設)
    dry-run     預覽模式，不實際修改檔案
    force       強制更新所有文檔
    changelog   僅同步 CHANGELOG
    verbose     詳細輸出模式

選項:
    --target PAGE    僅同步指定頁面
    --cleanup        清理舊報告檔案
    --install-deps   僅安裝依賴
    --report         僅顯示最新報告
    --help          顯示此說明

範例:
    $0                           # 標準同步
    $0 dry-run                   # 預覽模式
    $0 force                     # 強制更新
    $0 normal --target overview  # 僅同步 overview 頁面
    $0 --report                  # 顯示最新報告
    $0 --cleanup                 # 清理舊檔案

支援的頁面:
    overview, quickstart, sub-agents, mcp, cli-reference,
    settings, common-workflows, sdk, hooks-guide, 
    github-actions, security, troubleshooting
EOF
}

# 主函數
main() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                Claude Code 文檔同步工具                      ║"
    echo "║                    Enhanced Version 2.0                     ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    local mode="normal"
    local target_page=""
    local cleanup_only=false
    local install_only=false
    local report_only=false
    
    # 解析參數
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_help
                exit 0
                ;;
            --target)
                target_page="$2"
                shift 2
                ;;
            --cleanup)
                cleanup_only=true
                shift
                ;;
            --install-deps)
                install_only=true
                shift
                ;;
            --report)
                report_only=true
                shift
                ;;
            dry-run|force|changelog|verbose)
                mode="$1"
                shift
                ;;
            *)
                log "ERROR" "未知參數: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # 僅清理
    if [ "$cleanup_only" = true ]; then
        cleanup
        exit 0
    fi
    
    # 僅安裝依賴
    if [ "$install_only" = true ]; then
        install_dependencies
        exit 0
    fi
    
    # 僅顯示報告
    if [ "$report_only" = true ]; then
        show_report
        exit 0
    fi
    
    # 執行完整流程
    log "INFO" "開始執行完整同步流程..."
    
    # 1. 檢查依賴
    check_dependencies
    
    # 2. 執行同步
    if run_sync "$mode" "$target_page"; then
        # 3. 顯示報告
        show_report
        
        # 4. 清理（如果同步成功）
        cleanup
        
        log "SUCCESS" "🎉 文檔同步流程完成！"
        exit 0
    else
        log "ERROR" "同步過程中發生錯誤"
        
        # 顯示錯誤報告
        local error_file="$ROOT_DIR/sync-error.json"
        if [ -f "$error_file" ]; then
            log "INFO" "錯誤詳情請查看: $error_file"
        fi
        
        exit 1
    fi
}

# 捕獲中斷信號
trap 'log "WARNING" "收到中斷信號，正在清理..."; exit 130' INT TERM

# 執行主函數
main "$@"
