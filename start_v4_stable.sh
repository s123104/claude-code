#!/bin/bash
# Claude Code 融合智能安裝系統 v4.0.0 (穩定版)
# 結合官方二進制 + NPM 生態 + 智能選擇
set -euo pipefail

# ========== 核心配置 ==========
SCRIPT_VERSION="4.0.0"
CLAUDE_PACKAGE="@anthropic-ai/claude-code"
GCS_BUCKET="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"
MIN_NODE_VERSION="18"

# 智能安裝參數
INSTALL_METHOD=""
BINARY_SCORE=0
NPM_SCORE=0

# ========== 日誌系統 ==========
LOG_FILE="/tmp/claude_fusion_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ========== 參數解析 ==========
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --fast|-f) FAST_MODE=true; shift ;;
            --force-binary) FORCE_BINARY=true; shift ;;
            --force-npm) FORCE_NPM=true; shift ;;
            --dry-run) DRY_RUN=true; shift ;;
            --help|-h) show_help; exit 0 ;;
            *) log_warn "未知參數: $1"; shift ;;
        esac
    done
}

show_help() {
    cat << 'EOF'
Claude Code 融合智能安裝系統 v4.0.0

使用方法:
  ./start_v4_stable.sh [選項]

選項:
  --fast, -f              快速模式
  --force-binary          強制二進制安裝
  --force-npm             強制 NPM 安裝
  --dry-run               測試模式
  --help, -h              顯示幫助

範例:
  ./start_v4_stable.sh                # 智能安裝
  ./start_v4_stable.sh --fast         # 快速模式
  ./start_v4_stable.sh --force-npm    # 強制 NPM
EOF
}

# ========== 環境檢測 ==========
detect_environment() {
    log_info "檢測系統環境..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        SYSTEM_TYPE="macos"
        log_success "檢測到 macOS 環境"
    elif [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
        SYSTEM_TYPE="wsl"
        log_success "檢測到 WSL 環境"
    else
        SYSTEM_TYPE="linux"
        log_success "檢測到 Linux 環境"
    fi
    
    ARCH=$(uname -m)
    log_info "系統架構: $ARCH"
    export SYSTEM_TYPE ARCH
}

# ========== 檢查函數 ==========
check_binary_support() {
    case "${SYSTEM_TYPE:-}" in
        macos|linux) ;;
        *) return 1 ;;
    esac
    
    case "${ARCH:-}" in
        x86_64|amd64|arm64|aarch64) ;;
        *) return 1 ;;
    esac
    
    command -v curl >/dev/null 2>&1 || return 1
    curl -I "$GCS_BUCKET/stable" --max-time 10 >/dev/null 2>&1
}

check_nodejs_health() {
    command -v node >/dev/null 2>&1 || return 1
    command -v npm >/dev/null 2>&1 || return 1
    
    local node_version
    node_version=$(node --version | sed 's/v//' | cut -d'.' -f1)
    [[ $node_version -ge $MIN_NODE_VERSION ]]
}

# ========== 智能選擇引擎 ==========
intelligent_method_selection() {
    log_info "智能分析最佳安裝方法..."
    
    # 強制模式檢查
    if [[ "${FORCE_BINARY:-}" == "true" ]]; then
        if check_binary_support; then
            INSTALL_METHOD="binary"
            log_success "強制使用官方二進制安裝"
            return 0
        else
            log_error "當前環境不支援官方二進制安裝"
            exit 1
        fi
    fi
    
    if [[ "${FORCE_NPM:-}" == "true" ]]; then
        INSTALL_METHOD="npm"
        log_success "強制使用 NPM 安裝"
        return 0
    fi
    
    # 重置評分
    BINARY_SCORE=0
    NPM_SCORE=0
    
    # 官方二進制支援檢查
    if check_binary_support; then
        BINARY_SCORE=$((BINARY_SCORE + 40))
        log_info "官方二進制支援: +40分"
    else
        log_info "官方二進制不支援"
    fi
    
    # 平台兼容性評分
    case "${SYSTEM_TYPE:-}" in
        macos)
            BINARY_SCORE=$((BINARY_SCORE + 35))
            NPM_SCORE=$((NPM_SCORE + 30))
            log_info "macOS 環境: 二進制+35分，NPM+30分"
            ;;
        linux)
            BINARY_SCORE=$((BINARY_SCORE + 30))
            NPM_SCORE=$((NPM_SCORE + 30))
            log_info "Linux 環境: 平衡支援+30分"
            ;;
        wsl)
            NPM_SCORE=$((NPM_SCORE + 40))
            log_info "WSL 環境: NPM+40分"
            ;;
    esac
    
    # Node.js 環境健康度
    if check_nodejs_health; then
        NPM_SCORE=$((NPM_SCORE + 30))
        log_info "Node.js 環境健康: NPM+30分"
    else
        BINARY_SCORE=$((BINARY_SCORE + 25))
        log_info "Node.js 環境問題: 二進制+25分"
    fi
    
    # 決策邏輯
    echo
    log_info "智能安裝方法評分結果:"
    log_info "  官方二進制安裝: $BINARY_SCORE 分"
    log_info "  NPM 生態安裝: $NPM_SCORE 分"
    
    if [[ $BINARY_SCORE -gt $NPM_SCORE ]]; then
        INSTALL_METHOD="binary"
        log_success "選擇官方二進制安裝 (推薦指數: $BINARY_SCORE)"
    else
        INSTALL_METHOD="npm"
        log_success "選擇 NPM 生態安裝 (推薦指數: $NPM_SCORE)"
    fi
    
    export INSTALL_METHOD
}

# ========== 安裝引擎 ==========
install_via_binary() {
    log_info "使用官方二進制安裝引擎..."
    
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        log_info "測試模式: 模擬官方二進制安裝"
        return 0
    fi
    
    local download_dir="$HOME/.claude/downloads"
    mkdir -p "$download_dir"
    
    # 檢測平台
    local os arch platform
    case "$(uname -s)" in
        Darwin) os="darwin" ;;
        Linux) os="linux" ;;
        *) log_error "不支援的作業系統"; return 1 ;;
    esac
    
    case "$(uname -m)" in
        x86_64|amd64) arch="x64" ;;
        arm64|aarch64) arch="arm64" ;;
        *) log_error "不支援的架構"; return 1 ;;
    esac
    
    platform="${os}-${arch}"
    log_info "檢測到平台: $platform"
    
    # 獲取版本
    local version
    if ! version=$(curl -fsSL "$GCS_BUCKET/stable" --max-time 30); then
        log_error "無法獲取版本資訊"
        return 1
    fi
    log_info "目標版本: $version"
    
    # 下載 manifest
    local manifest_json
    if ! manifest_json=$(curl -fsSL "$GCS_BUCKET/$version/manifest.json" --max-time 30); then
        log_error "無法下載安裝清單"
        return 1
    fi
    
    # 提取校驗和
    local checksum
    if command -v jq >/dev/null 2>&1; then
        checksum=$(echo "$manifest_json" | jq -r ".platforms[\"$platform\"].checksum // empty")
    else
        # 簡單的 JSON 解析
        checksum=$(echo "$manifest_json" | grep -o "\"$platform\"[^}]*\"checksum\"[[:space:]]*:[[:space:]]*\"[a-f0-9]\{64\}\"" | grep -o "[a-f0-9]\{64\}")
    fi
    
    if [[ -z "$checksum" ]]; then
        log_error "無法提取校驗和"
        return 1
    fi
    
    log_info "安全校驗和: ${checksum:0:16}..."
    
    # 下載二進制
    local binary_path="$download_dir/claude-$version-$platform"
    log_info "下載 Claude Code 二進制文件..."
    
    if ! curl -fsSL -o "$binary_path" "$GCS_BUCKET/$version/$platform/claude" --max-time 300; then
        log_error "下載失敗"
        return 1
    fi
    
    # 校驗檔案
    local actual_checksum
    if [[ "$os" == "darwin" ]]; then
        actual_checksum=$(shasum -a 256 "$binary_path" | cut -d' ' -f1)
    else
        actual_checksum=$(sha256sum "$binary_path" | cut -d' ' -f1)
    fi
    
    if [[ "$actual_checksum" != "$checksum" ]]; then
        log_error "檔案校驗失敗"
        rm -f "$binary_path"
        return 1
    fi
    
    log_success "檔案完整性驗證通過"
    
    # 執行安裝
    chmod +x "$binary_path"
    log_info "執行官方安裝程序..."
    
    if "$binary_path" install; then
        log_success "官方二進制安裝完成"
        rm -f "$binary_path"
        return 0
    else
        log_error "官方安裝程序執行失敗"
        rm -f "$binary_path"
        return 1
    fi
}

install_via_npm() {
    log_info "使用 NPM 生態安裝引擎..."
    
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        log_info "測試模式: 模擬 NPM 安裝"
        return 0
    fi
    
    # 檢查 Node.js
    if ! command -v node >/dev/null 2>&1; then
        log_error "Node.js 未安裝，請先安裝 Node.js $MIN_NODE_VERSION+"
        return 1
    fi
    
    # 檢查版本
    local node_version
    node_version=$(node --version | sed 's/v//' | cut -d'.' -f1)
    if [[ $node_version -lt $MIN_NODE_VERSION ]]; then
        log_error "Node.js 版本過舊: v$node_version (需要 v$MIN_NODE_VERSION+)"
        return 1
    fi
    
    # 清理舊版本
    if command -v claude >/dev/null 2>&1; then
        log_info "清理舊版本..."
        npm uninstall -g "$CLAUDE_PACKAGE" 2>/dev/null || true
    fi
    
    # 設定 npm 全域目錄
    local npm_global_dir="$HOME/.npm-global"
    mkdir -p "$npm_global_dir"
    npm config set prefix "$npm_global_dir"
    
    # 確保 PATH
    if [[ ":$PATH:" != *":$npm_global_dir/bin:"* ]]; then
        export PATH="$npm_global_dir/bin:$PATH"
    fi
    
    # 安裝
    log_info "安裝 Claude Code NPM 套件..."
    if npm install -g "$CLAUDE_PACKAGE"; then
        log_success "NPM 安裝完成"
        return 0
    else
        log_error "NPM 安裝失敗"
        return 1
    fi
}

# ========== 驗證系統 ==========
verify_installation() {
    log_info "驗證 Claude Code 安裝..."
    
    if ! command -v claude >/dev/null 2>&1; then
        log_error "claude 命令未找到"
        return 1
    fi
    
    local claude_version
    if claude_version=$(claude --version 2>/dev/null); then
        log_success "Claude 版本: $claude_version"
    else
        log_error "無法獲取 Claude 版本"
        return 1
    fi
    
    # 健康檢查
    if claude doctor >/dev/null 2>&1; then
        log_success "Claude doctor 檢查通過"
    else
        log_warn "Claude doctor 檢查發現問題（但不影響基本功能）"
    fi
    
    log_success "Claude Code 安裝驗證完成"
    return 0
}

# ========== 主程序 ==========
print_header() {
    local title="$1"
    echo
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo -e "${CYAN}    ${YELLOW}$title${CYAN}    ${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo
}

main() {
    local start_time=$(date +%s)
    
    parse_arguments "$@"
    
    print_header "Claude Code 融合智能安裝系統 v$SCRIPT_VERSION"
    echo -e "${GREEN}雙引擎智能選擇 | 跨平台兼容 | 一鍵智能安裝${NC}"
    
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        echo -e "${YELLOW}測試模式已啟用（不會實際安裝）${NC}"
    fi
    echo
    
    # 階段一：環境檢測
    log_info "=== 第一階段：環境檢測 ==="
    detect_environment
    
    # 階段二：智能選擇
    log_info "=== 第二階段：智能選擇 ==="
    intelligent_method_selection
    
    # 階段三：執行安裝
    log_info "=== 第三階段：執行安裝 ==="
    local install_success=false
    
    case "$INSTALL_METHOD" in
        "binary")
            if install_via_binary; then
                install_success=true
            else
                log_warn "二進制安裝失敗，嘗試 NPM 降級..."
                if install_via_npm; then
                    install_success=true
                fi
            fi
            ;;
        "npm")
            if install_via_npm; then
                install_success=true
            else
                log_error "NPM 安裝失敗"
            fi
            ;;
    esac
    
    # 驗證結果
    if [[ "$install_success" == "true" ]] && [[ "${DRY_RUN:-}" != "true" ]]; then
        verify_installation
    fi
    
    # 計算時間
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # 最終結果
    echo
    if [[ "$install_success" == "true" ]]; then
        print_header "安裝成功完成"
        log_success "Claude Code 融合智能安裝成功！"
        log_info "安裝方法: $INSTALL_METHOD"
        log_info "安裝時間: ${duration}s"
        
        if [[ "${DRY_RUN:-}" != "true" ]]; then
            echo
            log_info "後續步驟:"
            echo "  1. 重新載入終端: source ~/.zshrc"
            echo "  2. 進入專案目錄並執行: claude"
            echo "  3. 查看幫助: claude --help"
        fi
    else
        print_header "安裝失敗"
        log_error "Claude Code 安裝失敗"
        echo "完整日誌位置: $LOG_FILE"
        exit 1
    fi
}

# 執行主程序
if [[ "${BASH_SOURCE[0]:-$0}" == "${0}" ]]; then
    main "$@"
fi