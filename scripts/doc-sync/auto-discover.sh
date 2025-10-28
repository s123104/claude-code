#!/usr/bin/env bash

#==============================================================================#
#  Claude Code 官方文檔自動發現與同步工具 - Shell 包裝器                        #
#==============================================================================#
# 功能：自動掃描和同步 Anthropic 官方文檔
# 
# 使用方式：
#   ./auto-discover.sh                  # 完整同步
#   ./auto-discover.sh discover         # 僅發現文檔列表
#   ./auto-discover.sh force            # 強制更新所有
#   ./auto-discover.sh dry-run          # 預覽模式
#   ./auto-discover.sh verbose          # 詳細輸出
#
# 作者：Claude Code 專案維護團隊
# 版本：1.0.0
# 最後更新：2025-10-29
#==============================================================================#

set -euo pipefail

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 取得腳本目錄
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
NODE_SCRIPT="$SCRIPT_DIR/auto-discover-sync.js"

# 日誌函數
log_info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
  echo -e "${RED}❌ $1${NC}"
}

log_step() {
  echo -e "${CYAN}▶︎  $1${NC}"
}

# 顯示說明
show_help() {
  cat << EOF

${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}
${CYAN}║  📚 Claude Code 官方文檔自動發現與同步工具                 ║${NC}
${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}

${PURPLE}使用方式：${NC}
  $0 [command] [options]

${PURPLE}指令：${NC}
  sync              完整同步（預設）
  discover          僅發現文檔列表，不下載
  force             強制更新所有文檔
  dry-run           預覽模式，不實際修改檔案
  verbose           詳細輸出
  report            顯示最新同步報告
  help              顯示此說明

${PURPLE}範例：${NC}
  $0                          # 完整同步
  $0 discover                 # 僅列出所有文檔
  $0 force                    # 強制更新所有
  $0 dry-run                  # 預覽模式
  $0 verbose                  # 詳細輸出
  $0 force verbose            # 組合使用

${PURPLE}功能說明：${NC}
  - 🔍 自動掃描官方網站發現所有文檔
  - 📥 智能下載新增和更新的文檔
  - 📝 自動更新 README 索引
  - 📊 生成詳細同步報告
  - 🌐 支援繁中和英文版本

${PURPLE}輸出檔案：${NC}
  - docs/anthropic-claude-code-zh-tw/         # 官方文檔鏡像
  - auto-discover-sync-report.json            # 詳細報告

EOF
}

# 檢查 Node.js
check_nodejs() {
  if ! command -v node &> /dev/null; then
    log_error "Node.js 未安裝"
    log_info "請安裝 Node.js 18+ 版本"
    log_info "下載: https://nodejs.org/"
    exit 1
  fi
  
  local node_version=$(node -v | sed 's/v//' | cut -d. -f1)
  if [ "$node_version" -lt 18 ]; then
    log_warning "Node.js 版本過舊 (目前: $(node -v))"
    log_info "建議升級到 18+ 版本"
  fi
}

# 檢查依賴
check_dependencies() {
  log_step "檢查依賴..."
  
  if [ ! -f "$SCRIPT_DIR/package.json" ]; then
    log_error "找不到 package.json"
    exit 1
  fi
  
  if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
    log_warning "依賴未安裝，開始安裝..."
    cd "$SCRIPT_DIR"
    npm install
    log_success "依賴安裝完成"
  else
    log_success "依賴檢查通過"
  fi
}

# 顯示最新報告
show_report() {
  local report_file="$ROOT_DIR/auto-discover-sync-report.json"
  
  if [ ! -f "$report_file" ]; then
    log_warning "找不到同步報告"
    log_info "請先執行同步: $0 sync"
    exit 1
  fi
  
  echo ""
  log_step "讀取最新報告..."
  echo ""
  
  # 使用 jq 美化輸出（如果可用）
  if command -v jq &> /dev/null; then
    cat "$report_file" | jq -C '.'
  else
    cat "$report_file"
  fi
  
  echo ""
}

# 執行同步
run_sync() {
  local args=()
  
  for arg in "$@"; do
    case "$arg" in
      discover)
        args+=("--discover-only")
        ;;
      force)
        args+=("--force")
        ;;
      dry-run)
        args+=("--dry-run")
        ;;
      verbose)
        args+=("--verbose")
        ;;
    esac
  done
  
  log_step "執行同步..."
  echo ""
  
  cd "$SCRIPT_DIR"
  node "$NODE_SCRIPT" "${args[@]}"
}

# 主程式
main() {
  # 檢查參數
  if [ $# -eq 0 ]; then
    # 無參數，執行完整同步
    check_nodejs
    check_dependencies
    run_sync
    exit 0
  fi
  
  # 解析指令
  case "$1" in
    help|--help|-h)
      show_help
      exit 0
      ;;
    report)
      show_report
      exit 0
      ;;
    sync|discover|force|dry-run|verbose)
      check_nodejs
      check_dependencies
      run_sync "$@"
      exit 0
      ;;
    *)
      log_error "未知指令: $1"
      log_info "使用 '$0 help' 查看說明"
      exit 1
      ;;
  esac
}

# 錯誤處理
trap 'log_error "執行中斷"; exit 130' INT
trap 'log_error "執行失敗"; exit 1' ERR

# 執行主程式
main "$@"

