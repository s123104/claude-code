#!/bin/bash
# ========== Claude Code 融合智能安裝系統 v4.0.0 ==========
# 結合官方二進制 + NPM 生態 + Context7 智能分析 + 全面環境修復
# 支援: macOS + Linux + WSL2 全平台智能安裝
# 特色: 雙引擎智能選擇、完整錯誤恢復、Context7 多模態分析、Shell 版本檢測升級
# 作者: Claude Code 開發團隊 & 中文社群
# 更新: 2025-07-19T23:00:00+08:00

# 2025 Shell 最佳實踐：嚴格模式設定
set -euo pipefail

# ========== 核心配置參數 ==========
SCRIPT_VERSION="4.0.0"
# shellcheck disable=SC2034
NVM_VERSION="v0.40.3"            # 最新穩定版本 (2025-04-23)
# shellcheck disable=SC2034
NODE_TARGET_VERSION="22.14.0"    # LTS Jod 最新版本
# shellcheck disable=SC2034
NODE_FALLBACK_VERSION="18.20.8"  # LTS Hydrogen 備用版本
CLAUDE_PACKAGE="@anthropic-ai/claude-code"
GCS_BUCKET="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"
MIN_NODE_VERSION="18"
MIN_BASH_VERSION="4.0"           # 建議的最低 bash 版本
MIN_ZSH_VERSION="5.0"            # 建議的最低 zsh 版本

# 智能安裝參數
INSTALL_METHOD=""
CONFIDENCE_SCORE=0
BINARY_SCORE=0
NPM_SCORE=0

# ========== 日誌和顏色系統 ==========
LOG_FILE="/tmp/claude_fusion_setup_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# 統一日誌函數
log_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_debug() {
    if [[ "${DEBUG_MODE:-}" == "true" ]]; then
        echo -e "${PURPLE}[DEBUG]${NC} $1"
    fi
}

# 兼容舊版函數名
error_exit() {
    log_error "$1"
    log_info "完整日誌已保存至：$LOG_FILE"
    exit 1
}

# ========== 參數解析系統 ==========
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --fast|-f)
                export FAST_MODE=true
                log_info "啟用快速模式"
                shift
                ;;
            --force-binary)
                export FORCE_BINARY=true
                log_info "強制使用官方二進制安裝"
                shift
                ;;
            --force-npm)
                export FORCE_NPM=true
                log_info "強制使用 NPM 安裝"
                shift
                ;;
            --version=*)
                export TARGET_VERSION="${1#*=}"
                log_info "指定版本: $TARGET_VERSION"
                shift
                ;;
            --verbose|-v)
                export DEBUG_MODE=true
                log_info "啟用詳細日誌模式"
                shift
                ;;
            --no-context7)
                export DISABLE_CONTEXT7=true
                log_info "禁用 Context7 分析"
                shift
                ;;
            --dry-run)
                export DRY_RUN=true
                log_info "測試模式（不實際安裝）"
                shift
                ;;
            --repair)
                export REPAIR_MODE=true
                log_info "修復模式"
                shift
                ;;
            --clean-install)
                export CLEAN_INSTALL=true
                log_info "清理重新安裝模式"
                shift
                ;;
            --test)
                export TEST_MODE=true
                log_info "自動測試模式"
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                log_warn "未知參數: $1"
                shift
                ;;
        esac
    done
}

# 顯示幫助資訊
show_help() {
    cat << EOF
Claude Code 融合智能安裝系統 v$SCRIPT_VERSION

使用方法:
  $0 [選項]

基本選項:
  --fast, -f              快速模式（跳過互動）
  --verbose, -v           詳細日誌模式
  --help, -h              顯示幫助資訊

安裝方式:
  --force-binary          強制使用官方二進制安裝
  --force-npm             強制使用 NPM 安裝
  --version=VERSION       指定版本 (stable/latest/x.y.z)

高級選項:
  --no-context7           禁用 Context7 智能分析
  --dry-run               測試模式（不實際安裝）
  --repair                修復現有安裝
  --test                  執行自動測試
  --clean-install         清理並重新安裝

範例:
  $0                      # 智能安裝
  $0 --fast               # 快速安裝
  $0 --force-binary       # 強制二進制安裝
  $0 --version=stable     # 安裝穩定版

EOF
}

# ========== Bash 版本檢測與升級系統 ==========

# 檢測當前 bash 版本
get_bash_version() {
    local version
    # 在 macOS 上優先檢查 Homebrew 安裝的 bash 版本
    if [[ "${SYSTEM_TYPE:-}" == "macos" ]] && command -v brew &>/dev/null; then
        local homebrew_bash
        homebrew_bash="$(brew --prefix)/bin/bash"
        if [[ -x "$homebrew_bash" ]]; then
            version=$("$homebrew_bash" --version 2>/dev/null | head -n1 | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "3.2")
        else
            version=$(bash --version 2>/dev/null | head -n1 | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "3.2")
        fi
    elif [[ -n "${BASH_VERSION:-}" ]]; then
        version="${BASH_VERSION}"
    else
        version=$(bash --version 2>/dev/null | head -n1 | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "3.2")
    fi
    echo "${version}"
}

# 檢測當前 zsh 版本
get_zsh_version() {
    local version
    # 在 macOS 上優先檢查 Homebrew 安裝的 zsh 版本
    if [[ "${SYSTEM_TYPE:-}" == "macos" ]] && command -v brew &>/dev/null; then
        local homebrew_zsh
        homebrew_zsh="$(brew --prefix)/bin/zsh"
        if [[ -x "$homebrew_zsh" ]]; then
            version=$("$homebrew_zsh" --version 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "4.0")
        else
            version=$(zsh --version 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "4.0")
        fi
    else
        version=$(zsh --version 2>/dev/null | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "4.0")
    fi
    echo "${version}"
}

# 比較版本號
version_compare() {
    local version1="$1"
    local version2="$2"
    
    # 提取主要和次要版本號
    local v1_major v1_minor v2_major v2_minor
    v1_major=$(echo "$version1" | sed 's/[^0-9].*//' | grep -o '^[0-9]*' || echo "0")
    v1_minor=$(echo "$version1" | sed 's/^[0-9]*\.//' | sed 's/[^0-9].*//' | grep -o '^[0-9]*' || echo "0")
    v2_major=$(echo "$version2" | sed 's/[^0-9].*//' | grep -o '^[0-9]*' || echo "0")
    v2_minor=$(echo "$version2" | sed 's/^[0-9]*\.//' | sed 's/[^0-9].*//' | grep -o '^[0-9]*' || echo "0")
    
    # 轉換為整數進行比較
    local v1_int=$((v1_major * 100 + v1_minor))
    local v2_int=$((v2_major * 100 + v2_minor))
    
    if [[ $v1_int -lt $v2_int ]]; then
        return 0  # version1 < version2 (true, needs upgrade)
    else
        return 1  # version1 >= version2 (false, no upgrade needed)
    fi
}

# 互動式提示函數
interactive_prompt() {
    local message="$1"
    local default_answer="${2:-N}"
    
    # 快速模式下自動選擇預設答案
    if [[ "${FAST_MODE:-}" == "true" ]]; then
        log_info "快速模式：自動選擇 $default_answer"
        if [[ "$default_answer" == "Y" || "$default_answer" == "y" ]]; then
            return 0
        else
            return 1
        fi
    fi
    
    local answer
    echo -e "${YELLOW}[PROMPT]${NC} $message"
    echo -e "${BLUE}提示：快速模式可使用 --fast 參數跳過互動${NC}"
    read -r -p "Continue? (y/N): " answer
    
    if [[ -z "$answer" ]]; then
        answer="$default_answer"
    fi
    
    case "$answer" in
        [Yy]* ) return 0 ;;
        * ) return 1 ;;
    esac
}

# 檢測並升級 zsh 版本
check_and_upgrade_zsh() {
    log_info "檢測 zsh 版本..."
    
    local current_version
    current_version=$(get_zsh_version)
    log_info "當前 zsh 版本：$current_version"
    
    # 比較版本
    if version_compare "$current_version" "$MIN_ZSH_VERSION"; then
        log_warn "zsh version is too old ($current_version < $MIN_ZSH_VERSION), upgrade recommended"
        
        local should_upgrade=false
        if [[ "${FAST_MODE:-}" == "true" ]]; then
            log_info "快速模式：自動選擇升級 zsh"
            should_upgrade=true
        else
            if interactive_prompt "是否要升級到最新版本的 zsh？" "Y"; then
                should_upgrade=true
            fi
        fi
        
        if [[ "$should_upgrade" == "true" ]]; then
            upgrade_zsh
        else
            log_warn "跳過 zsh 升級，可能影響某些功能"
        fi
    else
        log_success "zsh version meets requirements ($current_version >= $MIN_ZSH_VERSION)"
    fi
}

# 檢測並升級 bash 版本
check_and_upgrade_bash() {
    log_info "檢測 bash 版本..."
    
    local current_version
    current_version=$(get_bash_version)
    log_info "當前 bash 版本：$current_version"
    
    # 比較版本
    if version_compare "$current_version" "$MIN_BASH_VERSION"; then
        log_warn "bash version is too old ($current_version < $MIN_BASH_VERSION), upgrade recommended"
        
        local should_upgrade=false
        if [[ "${FAST_MODE:-}" == "true" ]]; then
            log_info "快速模式：自動選擇升級 bash"
            should_upgrade=true
        else
            if interactive_prompt "是否要升級到最新版本的 bash？" "Y"; then
                should_upgrade=true
            fi
        fi
        
        if [[ "$should_upgrade" == "true" ]]; then
            upgrade_bash
        else
            log_warn "跳過 bash 升級，可能影響某些功能"
        fi
    else
        log_success "bash version meets requirements ($current_version >= $MIN_BASH_VERSION)"
    fi
}

# 升級 zsh
upgrade_zsh() {
    log_info "開始升級 zsh..."
    
    case "${SYSTEM_TYPE:-}" in
        macos)
            upgrade_zsh_macos
            ;;
        linux|wsl)
            upgrade_zsh_linux
            ;;
        *)
            log_warn "未知系統類型，跳過 zsh 升級"
            ;;
    esac
}

# 升級 bash
upgrade_bash() {
    log_info "開始升級 bash..."
    
    case "${SYSTEM_TYPE:-}" in
        macos)
            upgrade_bash_macos
            ;;
        linux|wsl)
            upgrade_bash_linux
            ;;
        *)
            log_warn "未知系統類型，跳過 bash 升級"
            ;;
    esac
}

# macOS 升級 zsh
upgrade_zsh_macos() {
    log_info "在 macOS 上升級 zsh..."
    
    # 檢查 Homebrew
    if ! command -v brew &>/dev/null; then
        log_info "安裝 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            log_error "Homebrew 安裝失敗"
            return 1
        }
    fi
    
    # 升級 zsh
    log_info "使用 Homebrew 安裝最新版 zsh..."
    brew install zsh || {
        log_error "zsh 升級失敗"
        return 1
    }
    
    # 添加到 /etc/shells
    local new_zsh_path
    new_zsh_path="$(brew --prefix)/bin/zsh"
    
    if ! grep -q "$new_zsh_path" /etc/shells 2>/dev/null; then
        log_info "將新 zsh 添加到 /etc/shells..."
        echo "$new_zsh_path" | sudo tee -a /etc/shells >/dev/null
    fi
    
    # 詢問是否更改默認 shell 到 zsh
    if [[ "${FAST_MODE:-}" == "true" ]] || interactive_prompt "是否要將 zsh 設為默認 shell？（macOS 推薦）" "Y"; then
        log_info "更改默認 shell 到 zsh..."
        chsh -s "$new_zsh_path" || log_warn "更改默認 shell 失敗，請手動執行：chsh -s $new_zsh_path"
    fi
    
    log_success "zsh 升級完成"
}

# macOS 升級 bash
upgrade_bash_macos() {
    log_info "在 macOS 上升級 bash..."
    
    # 檢查 Homebrew
    if ! command -v brew &>/dev/null; then
        log_info "安裝 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            log_error "Homebrew 安裝失敗"
            return 1
        }
    fi
    
    # 升級 bash
    log_info "使用 Homebrew 安裝最新版 bash..."
    brew install bash || {
        log_error "bash 升級失敗"
        return 1
    }
    
    # 添加到 /etc/shells
    local new_bash_path
    new_bash_path="$(brew --prefix)/bin/bash"
    
    if ! grep -q "$new_bash_path" /etc/shells 2>/dev/null; then
        log_info "將新 bash 添加到 /etc/shells..."
        echo "$new_bash_path" | sudo tee -a /etc/shells >/dev/null
    fi
    
    # 在 macOS 上推薦使用 zsh
    if [[ "${FAST_MODE:-}" == "true" ]] || interactive_prompt "是否要將 zsh 設為默認 shell？（macOS 推薦）" "Y"; then
        log_info "更改默認 shell 到 zsh..."
        chsh -s /bin/zsh || log_warn "更改默認 shell 失敗，請手動執行：chsh -s /bin/zsh"
    fi
    
    log_success "bash 升級完成"
}

# Linux 升級 zsh
upgrade_zsh_linux() {
    log_info "在 Linux 上升級 zsh..."
    
    # 更新套件管理器
    if command -v apt &>/dev/null; then
        sudo apt update
        sudo apt install -y zsh || {
            log_warn "使用 apt 升級 zsh 失敗，可能已是最新版本"
        }
    elif command -v yum &>/dev/null; then
        sudo yum update -y zsh || {
            log_warn "使用 yum 升級 zsh 失敗，可能已是最新版本"
        }
    elif command -v dnf &>/dev/null; then
        sudo dnf update -y zsh || {
            log_warn "使用 dnf 升級 zsh 失敗，可能已是最新版本"
        }
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu zsh --noconfirm || {
            log_warn "使用 pacman 升級 zsh 失敗，可能已是最新版本"
        }
    else
        log_warn "未找到支援的套件管理器，請手動升級 zsh"
        return 1
    fi
    
    log_success "zsh 升級完成"
}

# Linux 升級 bash
upgrade_bash_linux() {
    log_info "在 Linux 上升級 bash..."
    
    # 更新套件管理器
    if command -v apt &>/dev/null; then
        sudo apt update
        sudo apt install -y bash || {
            log_warn "使用 apt 升級 bash 失敗，可能已是最新版本"
        }
    elif command -v yum &>/dev/null; then
        sudo yum update -y bash || {
            log_warn "使用 yum 升級 bash 失敗，可能已是最新版本"
        }
    elif command -v dnf &>/dev/null; then
        sudo dnf update -y bash || {
            log_warn "使用 dnf 升級 bash 失敗，可能已是最新版本"
        }
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu bash --noconfirm || {
            log_warn "使用 pacman 升級 bash 失敗，可能已是最新版本"
        }
    else
        log_warn "未找到支援的套件管理器，請手動升級 bash"
        return 1
    fi
    
    log_success "bash 升級完成"
}

# ========== 環境檢測系統 ==========

# 主動清理 npm/nvm 配置衝突
proactive_npm_cleanup() {
    log_debug "執行主動 npm/nvm 配置清理..."
    
    # 檢查是否存在 npm/nvm 衝突
    local has_npm_conflicts=false
    local needs_nvm_switch=false
    
    # 檢查 npm 配置
    if command -v npm &>/dev/null; then
        # 檢查 globalconfig 是否指向非 nvm 目錄
        local globalconfig
        globalconfig=$(npm config get globalconfig 2>/dev/null || echo "")
        if [[ -n "$globalconfig" ]] && [[ "$globalconfig" != "undefined" ]] && [[ "$globalconfig" != *"/.nvm/"* ]]; then
            has_npm_conflicts=true
            log_debug "發現 globalconfig 衝突: $globalconfig"
        fi
        
        # 檢查 prefix 是否為 npm-global 且 nvm 使用 system（可能衝突）
        local prefix
        prefix=$(npm config get prefix 2>/dev/null || echo "")
        local nvm_current=""
        
        # 先檢查 nvm 狀態
        local temp_nvm_dir="${NVM_DIR:-$HOME/.nvm}"
        if [[ -s "$temp_nvm_dir/nvm.sh" ]]; then
            # shellcheck source=/dev/null
            source "$temp_nvm_dir/nvm.sh" 2>/dev/null || true
            if command -v nvm &>/dev/null; then
                nvm_current=$(timeout 5 nvm current 2>/dev/null || echo "none")
            fi
        fi
        
        # 只有當使用 npm-global 且 nvm 是 system 時才認為有衝突
        if [[ "$prefix" == *"/.npm-global"* ]] && [[ "$nvm_current" == "system" ]]; then
            has_npm_conflicts=true
            log_debug "發現 npm-global prefix 與 nvm system 的衝突: $prefix"
        fi
    fi
    
    # 檢查 nvm 狀態
    local nvm_dir="${NVM_DIR:-$HOME/.nvm}"
    if [[ -s "$nvm_dir/nvm.sh" ]]; then
        # shellcheck source=/dev/null
        source "$nvm_dir/nvm.sh" 2>/dev/null || true
        
        if command -v nvm &>/dev/null; then
            local nvm_current
            nvm_current=$(timeout 5 nvm current 2>/dev/null || echo "none")
            
            # 如果 nvm 使用 system 而不是管理的版本，可能會有衝突
            if [[ "$nvm_current" == "system" ]] && [[ "$has_npm_conflicts" == "true" ]]; then
                needs_nvm_switch=true
                log_debug "nvm 當前使用 system，但存在 npm 配置衝突"
            fi
        fi
    fi
    
    # 如果發現衝突，立即修復
    if [[ "$has_npm_conflicts" == "true" ]] || [[ "$needs_nvm_switch" == "true" ]]; then
        log_info "🔧 檢測到 npm/nvm 配置衝突，執行主動清理..."
        
        # 載入 nvm 環境
        if [[ -s "$nvm_dir/nvm.sh" ]]; then
            # shellcheck source=/dev/null
            source "$nvm_dir/nvm.sh" 2>/dev/null || true
            
            if command -v nvm &>/dev/null; then
                # 找到可用的 nvm 版本
                local available_versions
                available_versions=$(timeout 10 nvm ls --no-colors 2>/dev/null | grep -E "v[0-9]+" | head -5 || echo "")
                
                if [[ -n "$available_versions" ]]; then
                    # 嘗試切換到最新的 LTS 版本
                    local target_version
                    target_version=$(echo "$available_versions" | grep -E "(lts|Latest LTS)" | head -1 | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" | head -1)
                    
                    # 如果沒有 LTS，使用最新版本
                    if [[ -z "$target_version" ]]; then
                        target_version=$(echo "$available_versions" | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" | head -1)
                    fi
                    
                    if [[ -n "$target_version" ]]; then
                        log_info "🔄 切換到 nvm 管理的版本: $target_version"
                        if timeout 15 nvm use --delete-prefix "$target_version" --silent 2>/dev/null; then
                            log_success "✅ 成功切換到 $target_version 並清理 prefix 衝突"
                        else
                            log_warn "⚠️  nvm 切換失敗，使用手動清理"
                            manual_npm_cleanup
                        fi
                    else
                        log_warn "⚠️  未找到有效的 nvm 版本，使用手動清理"
                        manual_npm_cleanup
                    fi
                else
                    log_warn "⚠️  nvm 沒有安裝的版本，使用手動清理"
                    manual_npm_cleanup
                fi
            else
                log_warn "⚠️  nvm 命令不可用，使用手動清理"
                manual_npm_cleanup
            fi
        else
            log_warn "⚠️  nvm 未正確安裝，使用手動清理"
            manual_npm_cleanup
        fi
    else
        log_debug "✅ 未發現 npm/nvm 配置衝突"
    fi
}

# 手動清理 npm 配置
manual_npm_cleanup() {
    log_info "🔧 執行手動 npm 配置清理..."
    
    if command -v npm &>/dev/null; then
        # 檢查 npm 版本以使用正確語法
        local npm_version
        npm_version=$(npm --version 2>/dev/null | head -1 || echo "0.0.0")
        local npm_major_version
        npm_major_version=$(echo "$npm_version" | cut -d. -f1)
        
        if [[ "$npm_major_version" -ge 8 ]]; then
            # npm 8.0+ 語法
            log_debug "使用 npm 8.0+ 語法清理 globalconfig 和 prefix..."
            npm config delete globalconfig --location=user 2>/dev/null || true
            npm config delete globalconfig --location=global 2>/dev/null || true
            npm config delete prefix --location=user 2>/dev/null || true
            npm config delete prefix --location=global 2>/dev/null || true
        else
            # 舊版 npm 語法
            log_debug "使用舊版 npm 語法清理 globalconfig 和 prefix..."
            npm config delete globalconfig 2>/dev/null || true
            npm config delete globalconfig -g 2>/dev/null || true
            npm config delete prefix 2>/dev/null || true
            npm config delete prefix -g 2>/dev/null || true
        fi
        
        log_info "✅ npm 配置清理完成"
    fi
}

# 修復 Claude Code 路徑問題
fix_claude_path_issues() {
    log_info "🔧 檢查和修復 Claude Code 路徑問題..."
    
    # 檢查 Claude 是否可用
    local claude_actual_path claude_expected_path
    claude_actual_path=$(which claude 2>/dev/null || echo "")
    claude_expected_path="$HOME/.local/bin/claude"
    
    if [[ -n "$claude_actual_path" ]]; then
        log_success "✅ Claude Code 在 $claude_actual_path 可用"
        
        # 檢查是否需要創建 .local/bin 軟連結
        if [[ "$claude_actual_path" != "$claude_expected_path" ]] && [[ ! -f "$claude_expected_path" ]]; then
            log_info "🔗 創建 Claude Code 軟連結到 ~/.local/bin/"
            
            # 確保 .local/bin 目錄存在
            mkdir -p "$HOME/.local/bin"
            
            # 創建軟連結
            if ln -sf "$claude_actual_path" "$claude_expected_path" 2>/dev/null; then
                log_success "✅ 軟連結創建成功: $claude_expected_path -> $claude_actual_path"
            else
                log_warn "⚠️  軟連結創建失敗，但 Claude 仍可從 $claude_actual_path 使用"
            fi
        fi
        
        # 確保 .local/bin 在 PATH 中
        if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
            log_info "🛠️  添加 ~/.local/bin 到 PATH"
            
            # 添加到當前會話
            export PATH="$HOME/.local/bin:$PATH"
            
            # 添加到 shell 配置文件
            local shell_config
            if [[ "$SHELL" == *"zsh"* ]] || [[ -n "${ZSH_VERSION:-}" ]]; then
                shell_config="$HOME/.zshrc"
            else
                shell_config="$HOME/.bashrc"
            fi
            
            if [[ -f "$shell_config" ]] && ! grep -q ".local/bin" "$shell_config" 2>/dev/null; then
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$shell_config"
                log_success "✅ PATH 已更新到 $shell_config"
            fi
        fi
        
        # 測試 Claude Code 功能
        if timeout 5 "$claude_actual_path" --version >/dev/null 2>&1; then
            log_success "✅ Claude Code 功能測試通過"
        else
            log_warn "⚠️  Claude Code 功能測試失敗，但安裝路徑正確"
        fi
        
    else
        log_warn "⚠️  Claude Code 未找到，需要安裝"
        return 1
    fi
}

# 自動測試系統
run_automated_tests() {
    log_info "🧪 開始自動測試 Claude Code 安裝..."
    
    local tests_passed=0
    local tests_failed=0
    local test_results=()
    
    # 測試 1: Claude CLI 可執行性
    log_info "測試 1/8: Claude CLI 可執行性..."
    if command -v claude >/dev/null 2>&1; then
        log_success "✅ Claude CLI 可執行"
        ((tests_passed++))
        test_results+=("✅ Claude CLI 可執行性")
    else
        log_error "❌ Claude CLI 不可執行"
        ((tests_failed++))
        test_results+=("❌ Claude CLI 不可執行")
    fi
    
    # 測試 2: Claude 版本檢查
    log_info "測試 2/8: Claude 版本檢查..."
    local claude_version
    claude_version=$(timeout 10 claude --version 2>/dev/null || echo "failed")
    if [[ "$claude_version" != "failed" ]] && [[ -n "$claude_version" ]]; then
        log_success "✅ Claude 版本: $claude_version"
        ((tests_passed++))
        test_results+=("✅ Claude 版本檢查 ($claude_version)")
    else
        log_error "❌ Claude 版本檢查失敗"
        ((tests_failed++))
        test_results+=("❌ Claude 版本檢查失敗")
    fi
    
    # 測試 3: Claude 路徑配置
    log_info "測試 3/8: Claude 路徑配置..."
    local claude_path expected_path
    claude_path=$(which claude 2>/dev/null)
    expected_path="$HOME/.local/bin/claude"
    if [[ -n "$claude_path" ]] && [[ -f "$expected_path" ]]; then
        log_success "✅ Claude 路徑配置正確"
        ((tests_passed++))
        test_results+=("✅ Claude 路徑配置")
    else
        log_error "❌ Claude 路徑配置問題"
        ((tests_failed++))
        test_results+=("❌ Claude 路徑配置問題")
    fi
    
    # 測試 4: npm/nvm 配置衝突檢查
    log_info "測試 4/8: npm/nvm 配置衝突檢查..."
    local nvm_warning
    nvm_warning=$(timeout 5 nvm current 2>&1 | grep -i "globalconfig\|prefix.*incompatible" || echo "")
    if [[ -z "$nvm_warning" ]]; then
        log_success "✅ 無 npm/nvm 配置衝突"
        ((tests_passed++))
        test_results+=("✅ npm/nvm 配置正常")
    else
        log_error "❌ 存在 npm/nvm 配置衝突"
        ((tests_failed++))
        test_results+=("❌ npm/nvm 配置衝突")
    fi
    
    # 測試 5: Claude 基本功能測試
    log_info "測試 5/8: Claude 基本功能測試..."
    if timeout 10 claude --help >/dev/null 2>&1; then
        log_success "✅ Claude 基本功能正常"
        ((tests_passed++))
        test_results+=("✅ Claude 基本功能")
    else
        log_error "❌ Claude 基本功能異常"
        ((tests_failed++))
        test_results+=("❌ Claude 基本功能異常")
    fi
    
    # 測試 6: 環境變數檢查
    log_info "測試 6/8: 環境變數檢查..."
    if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
        log_success "✅ PATH 環境變數配置正確"
        ((tests_passed++))
        test_results+=("✅ PATH 環境變數")
    else
        log_error "❌ PATH 環境變數配置問題"
        ((tests_failed++))
        test_results+=("❌ PATH 環境變數問題")
    fi
    
    # 測試 7: Shell 配置檢查
    log_info "測試 7/8: Shell 配置檢查..."
    local shell_config
    if [[ "$SHELL" == *"zsh"* ]] || [[ -n "${ZSH_VERSION:-}" ]]; then
        shell_config="$HOME/.zshrc"
    else
        shell_config="$HOME/.bashrc"
    fi
    
    if [[ -f "$shell_config" ]] && grep -q ".local/bin" "$shell_config" 2>/dev/null; then
        log_success "✅ Shell 配置文件已更新"
        ((tests_passed++))
        test_results+=("✅ Shell 配置文件")
    else
        log_warn "⚠️  Shell 配置文件可能需要手動更新"
        ((tests_failed++))
        test_results+=("⚠️ Shell 配置文件需更新")
    fi
    
    # 測試 8: Claude 連線測試（可選）
    log_info "測試 8/8: Claude 連線測試..."
    if timeout 15 claude doctor >/dev/null 2>&1; then
        log_success "✅ Claude 連線正常"
        ((tests_passed++))
        test_results+=("✅ Claude 連線正常")
    else
        log_warn "⚠️  Claude 連線測試失敗（可能需要認證）"
        ((tests_failed++))
        test_results+=("⚠️ Claude 連線需認證")
    fi
    
    # 顯示測試結果摘要
    echo
    log_info "🧪 測試結果摘要："
    log_info "   ✅ 通過測試: $tests_passed/8"
    log_info "   ❌ 失敗測試: $tests_failed/8"
    
    echo
    log_info "📋 詳細測試結果："
    for result in "${test_results[@]}"; do
        log_info "   $result"
    done
    
    # 根據測試結果給出建議
    echo
    if [[ $tests_failed -eq 0 ]]; then
        log_success "🎉 所有測試通過！Claude Code 安裝完全正常。"
        return 0
    elif [[ $tests_failed -le 2 ]]; then
        log_warn "⚠️  部分測試失敗，但核心功能正常。建議檢查上述問題。"
        return 1
    else
        log_error "❌ 多項測試失敗，Claude Code 可能存在重大問題。建議重新安裝。"
        return 2
    fi
}

# 快速修復 nvm 警告
quick_fix_nvm_warning() {
    log_info "🔧 快速修復 nvm 警告..."
    
    # 載入 nvm 環境
    local nvm_dir="${NVM_DIR:-$HOME/.nvm}"
    if [[ -s "$nvm_dir/nvm.sh" ]]; then
        # shellcheck source=/dev/null
        source "$nvm_dir/nvm.sh" 2>/dev/null || true
        
        if command -v nvm &>/dev/null; then
            local current_nvm
            current_nvm=$(nvm current 2>/dev/null || echo "none")
            
            # 如果目前是 system，嘗試切換到可用版本
            if [[ "$current_nvm" == "system" ]]; then
                # 查找可用版本
                local available_versions
                available_versions=$(timeout 10 nvm ls --no-colors 2>/dev/null | grep -E "v[0-9]+\.[0-9]+\.[0-9]+" | grep -v "system" | head -3 || echo "")
                
                if [[ -n "$available_versions" ]]; then
                    local target_version
                    # 嘗試使用最新的版本
                    target_version=$(echo "$available_versions" | head -1 | grep -o "v[0-9]\+\.[0-9]\+\.[0-9]\+" | head -1)
                    
                    if [[ -n "$target_version" ]]; then
                        log_info "🔄 切換到 nvm 版本: $target_version"
                        # 使用 --delete-prefix 來清理 npmrc 配置衝突
                        if timeout 15 nvm use --delete-prefix "$target_version" --silent 2>/dev/null; then
                            log_success "✅ 成功切換到 $target_version 並清理配置衝突"
                            return 0
                        else
                            log_warn "⚠️  無法切換到 $target_version，嘗試手動清理"
                            # 後備方案：手動清理
                            manual_npm_cleanup
                        fi
                    fi
                else
                    log_warn "⚠️  未找到可用的 nvm 版本"
                fi
            fi
        fi
    fi
    
    # 如果 nvm 切換失敗，至少清理 globalconfig
    manual_npm_cleanup
}

# 檢測作業系統環境
detect_environment() {
    log_info "🔍 正在檢測系統環境..."
    
    # 檢查 macOS 環境
    if [[ "$OSTYPE" == "darwin"* ]]; then
        SYSTEM_TYPE="macos"
        log_success "偵測到 macOS 環境"
        export MACOS_MODE=true
        
        # 檢查 macOS 版本
        local macos_version
        macos_version=$(sw_vers -productVersion 2>/dev/null || echo "unknown")
        log_info "macOS 版本：$macos_version"
        
        # 檢查 Homebrew
        if command -v brew &>/dev/null; then
            local brew_version
            brew_version=$(brew --version | head -1)
            log_info "Homebrew 版本：$brew_version"
        else
            log_warn "Homebrew 未安裝，建議安裝以獲得最佳體驗"
        fi
        
        return 0
    fi
    
    # 檢查是否在 Windows 原生環境執行
    if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]] || [[ -n "${WINDIR:-}" ]]; then
        log_error "偵測到 Windows 環境，此腳本需要在 WSL 環境中執行"
        echo "請先安裝 WSL2 並使用以下 PowerShell 腳本："
        echo "  1. 以管理員身份開啟 PowerShell"
        echo "  2. 執行: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
        echo "  3. 執行: .\\setup.ps1"
        echo ""
        echo "或手動安裝 WSL2："
        echo "  wsl --install"
        exit 1
    fi
    
    # 檢查是否在 WSL 環境
    if [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
        SYSTEM_TYPE="wsl"
        log_success "WSL 環境偵測成功，開始安裝程序"
        export WSL_MODE=true
        
        # 檢查 WSL 版本
        local wsl_version
        if command -v wsl.exe &>/dev/null; then
            wsl_version=$(wsl.exe --version 2>/dev/null | head -1 || echo "WSL 1")
            log_info "WSL 版本: $wsl_version"
        fi
    else
        SYSTEM_TYPE="linux"
        log_warn "未偵測到 WSL 環境，將以純 Linux 模式執行"
        export LINUX_MODE=true
        
        # 檢查 Linux 發行版
        if [[ -f /etc/os-release ]]; then
            local distro_info
            # shellcheck source=/dev/null
            # shellcheck disable=SC2153
            distro_info=$(. /etc/os-release && echo "${NAME} ${VERSION}")
            log_info "Linux 發行版: $distro_info"
        else
            log_warn "無法識別 Linux 發行版，可能會遇到相容性問題"
        fi
    fi
    
    # 檢查系統架構
    ARCH=$(uname -m)
    log_info "系統架構: $ARCH"
    
    # 檢查 Shell 類型
    SHELL_TYPE=$(basename "${SHELL:-/bin/bash}")
    log_info "Shell 類型: $SHELL_TYPE"
    
    # 檢測 Shell 配置文件
    SHELL_CONFIG="$HOME/.bashrc"
    if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
        # 確保 zsh 配置文件存在
        if [[ ! -f "$SHELL_CONFIG" ]]; then
            touch "$SHELL_CONFIG"
            log_info "建立 zsh 配置文件：$SHELL_CONFIG"
        fi
    fi
    log_info "Shell 配置文件：$SHELL_CONFIG"
    
    # 檢查是否為 root 用戶
    if [[ $EUID -eq 0 ]]; then
        log_warn "偵測到 root 用戶，建議使用一般用戶執行此腳本"
    fi
    
    export SYSTEM_TYPE ARCH SHELL_TYPE SHELL_CONFIG
}

# 檢查系統資源
check_system_resources() {
    log_debug "檢查系統資源..."
    
    # CPU 核心數
    local cpu_cores
    cpu_cores=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo "1")
    log_debug "CPU 核心數: $cpu_cores"
    
    # 記憶體大小
    local memory_gb
    if [[ "$SYSTEM_TYPE" == "macos" ]]; then
        memory_gb=$(( $(sysctl -n hw.memsize 2>/dev/null || echo "4294967296") / 1024 / 1024 / 1024 ))
    else
        memory_gb=$(free -g 2>/dev/null | awk '/^Mem:/{print $2}' || echo "4")
    fi
    log_debug "記憶體大小: ${memory_gb}GB"
    
    # 磁碟空間
    local disk_free
    disk_free=$(df -h "$HOME" 2>/dev/null | awk 'NR==2{print $4}' || echo "unknown")
    log_debug "可用磁碟空間: $disk_free"
    
    export CPU_CORES="$cpu_cores" MEMORY_GB="$memory_gb" DISK_FREE="$disk_free"
}

# 檢查網路條件
check_network_conditions() {
    log_debug "檢查網路條件..."
    
    # 測試 Google Cloud Storage 連線
    local gcs_ping
    gcs_ping=$(ping -c 1 -W 3 storage.googleapis.com 2>/dev/null | grep "time=" | cut -d'=' -f4 | cut -d' ' -f1 || echo "999")
    local gcs_ms
    gcs_ms=$(echo "$gcs_ping" | cut -d'.' -f1 2>/dev/null || echo "999")
    
    # 測試 NPM Registry 連線
    local npm_ping
    npm_ping=$(ping -c 1 -W 3 registry.npmjs.org 2>/dev/null | grep "time=" | cut -d'=' -f4 | cut -d' ' -f1 || echo "999")
    local npm_ms
    npm_ms=$(echo "$npm_ping" | cut -d'.' -f1 2>/dev/null || echo "999")
    
    log_debug "GCS 延遲: ${gcs_ms}ms"
    log_debug "NPM 延遲: ${npm_ms}ms"
    
    export GCS_PING_MS="$gcs_ms" NPM_PING_MS="$npm_ms"
}

# 檢查官方二進制支援
check_official_binary_support() {
    log_debug "檢查官方二進制支援..."
    
    # 檢查平台支援
    case "${SYSTEM_TYPE:-}" in
        macos|linux)
            log_debug "平台支援官方二進制"
            ;;
        wsl)
            log_debug "WSL 環境，可能支援但建議使用 NPM"
            return 1
            ;;
        *)
            log_debug "平台不支援官方二進制"
            return 1
            ;;
    esac
    
    # 檢查架構支援
    case "${ARCH:-}" in
        x86_64|amd64|arm64|aarch64)
            log_debug "架構支援官方二進制"
            ;;
        *)
            log_debug "架構不支援官方二進制"
            return 1
            ;;
    esac
    
    # 檢查必需工具
    if ! command -v curl &>/dev/null; then
        log_debug "缺少 curl 工具"
        return 1
    fi
    
    # 測試 GCS 連線
    if ! curl -I "$GCS_BUCKET/stable" --max-time 10 &>/dev/null; then
        log_debug "無法連線到 GCS bucket"
        return 1
    fi
    
    log_debug "官方二進制支援檢查通過"
    return 0
}

# 檢查 Node.js 環境健康度
check_nodejs_health() {
    log_debug "檢查 Node.js 環境健康度..."
    
    # 檢查 Node.js 是否安裝
    if ! command -v node &>/dev/null; then
        log_debug "Node.js 未安裝"
        return 1
    fi
    
    # 檢查 Node.js 版本
    local node_version
    node_version=$(node --version 2>/dev/null | sed 's/v//' | cut -d'.' -f1)
    if [[ $node_version -lt $MIN_NODE_VERSION ]]; then
        log_debug "Node.js 版本過舊: v$node_version (需要 v$MIN_NODE_VERSION+)"
        return 1
    fi
    
    # 檢查 npm 是否安裝
    if ! command -v npm &>/dev/null; then
        log_debug "npm 未安裝"
        return 1
    fi
    
    # 檢查 npm 配置是否有衝突（允許 npm-global 配置）
    local prefix_conflict=false
    local current_prefix
    current_prefix=$(npm config get prefix 2>/dev/null | grep -v "undefined" || echo "")
    
    # 只有當 prefix 不是 nvm 管理的，也不是我們的 npm-global 時才視為衝突
    if [[ -n "$current_prefix" ]] && [[ "$current_prefix" != *"/.nvm/"* ]] && [[ "$current_prefix" != *"/.npm-global"* ]]; then
        prefix_conflict=true
    fi
    
    if [[ "$prefix_conflict" == "true" ]]; then
        log_debug "檢測到 npm prefix 配置衝突: $current_prefix"
        return 1
    fi
    
    log_debug "Node.js 環境健康檢查通過"
    return 0
}

# ========== Context7 智能分析系統 ==========

# Context7 多模態環境分析
context7_analyze_environment() {
    if [[ "${DISABLE_CONTEXT7:-}" == "true" ]]; then
        echo "npm"  # 預設降級到 NPM
        return 0
    fi
    
    log_info "🧠 Context7 智能分析環境..."
    
    local analysis_result=""
    local confidence_score=0
    
    # 1. 系統資源分析 (30%)
    local resource_score=0
    if [[ ${CPU_CORES:-1} -ge 4 ]] && [[ ${MEMORY_GB:-4} -ge 8 ]]; then
        resource_score=30
        analysis_result="binary"
        log_debug "高性能系統，推薦官方二進制: +30分"
    elif [[ ${CPU_CORES:-1} -ge 2 ]] && [[ ${MEMORY_GB:-4} -ge 4 ]]; then
        resource_score=15
        log_debug "中等性能系統: +15分"
    fi
    confidence_score=$((confidence_score + resource_score))
    
    # 2. 網路條件分析 (25%)
    local network_score=0
    if [[ ${GCS_PING_MS:-999} -lt 100 ]]; then
        network_score=25
        if [[ "$analysis_result" != "npm" ]]; then
            analysis_result="binary"
        fi
        log_debug "優秀網路連線，推薦官方二進制: +25分"
    elif [[ ${NPM_PING_MS:-999} -lt 150 ]]; then
        network_score=15
        if [[ -z "$analysis_result" ]]; then
            analysis_result="npm"
        fi
        log_debug "良好 NPM 連線: +15分"
    fi
    confidence_score=$((confidence_score + network_score))
    
    # 3. 平台適配分析 (20%)
    local platform_score=0
    case "${SYSTEM_TYPE:-}" in
        macos)
            platform_score=20
            if [[ "$analysis_result" != "npm" ]]; then
                analysis_result="binary"
            fi
            log_debug "macOS 平台，推薦官方二進制: +20分"
            ;;
        linux)
            platform_score=15
            log_debug "Linux 平台: +15分"
            ;;
        wsl)
            platform_score=10
            analysis_result="npm"
            log_debug "WSL 環境，推薦 NPM: +10分"
            ;;
    esac
    confidence_score=$((confidence_score + platform_score))
    
    # 4. 歷史成功率分析 (15%)
    local history_score=0
    local history_file="$HOME/.claude/install_history.log"
    if [[ -f "$history_file" ]]; then
        local binary_success npm_success
        binary_success=$(grep -c "binary.*success" "$history_file" 2>/dev/null || echo "0")
        npm_success=$(grep -c "npm.*success" "$history_file" 2>/dev/null || echo "0")
        
        if [[ $binary_success -gt $npm_success ]]; then
            history_score=15
            analysis_result="binary"
            log_debug "歷史二進制安裝成功率較高: +15分"
        elif [[ $npm_success -gt $binary_success ]]; then
            history_score=15
            analysis_result="npm"
            log_debug "歷史 NPM 安裝成功率較高: +15分"
        else
            history_score=5
            log_debug "歷史記錄平衡: +5分"
        fi
    fi
    confidence_score=$((confidence_score + history_score))
    
    # 5. 用戶偏好分析 (10%)
    local preference_score=0
    local prefs_file="$HOME/.claude/user_preferences.json"
    if [[ -f "$prefs_file" ]]; then
        local preferred_method
        preferred_method=$(grep -o '"install_method":"[^"]*"' "$prefs_file" 2>/dev/null | cut -d'"' -f4 || echo "")
        if [[ -n "$preferred_method" ]]; then
            preference_score=10
            analysis_result="$preferred_method"
            log_debug "用戶偏好 $preferred_method: +10分"
        fi
    fi
    confidence_score=$((confidence_score + preference_score))
    
    # 確保有有效的分析結果
    if [[ -z "$analysis_result" ]]; then
        analysis_result="npm"  # 預設使用 NPM
        log_debug "使用預設 NPM 方法"
    fi
    
    # 儲存分析結果
    local context_dir="$HOME/.claude"
    mkdir -p "$context_dir"
    {
        echo "timestamp=$(date +%s)"
        echo "confidence_score=$confidence_score"
        echo "recommended_method=$analysis_result"
        echo "cpu_cores=${CPU_CORES:-1}"
        echo "memory_gb=${MEMORY_GB:-4}"
        echo "gcs_ping_ms=${GCS_PING_MS:-999}"
        echo "npm_ping_ms=${NPM_PING_MS:-999}"
        echo "system_type=${SYSTEM_TYPE:-unknown}"
    } >> "$context_dir/context7_analysis.log"
    
    log_info "🎯 Context7 分析完成"
    log_info "   推薦方法: $analysis_result"
    log_info "   信心指數: $confidence_score/100"
    
    echo "$analysis_result"
}

# ========== 智能安裝引擎選擇器 ==========

# 智能檢測最佳安裝方法
detect_best_installation_method() {
    log_info "🔍 智能分析最佳安裝方法..."
    
    # 檢查強制模式
    if [[ "${FORCE_BINARY:-}" == "true" ]]; then
        if check_official_binary_support; then
            INSTALL_METHOD="binary"
            log_success "🎯 強制使用官方二進制安裝"
            return 0
        else
            log_error "當前環境不支援官方二進制安裝"
            exit 1
        fi
    fi
    
    if [[ "${FORCE_NPM:-}" == "true" ]]; then
        INSTALL_METHOD="npm"
        log_success "🎯 強制使用 NPM 安裝"
        return 0
    fi
    
    # 重置評分
    BINARY_SCORE=0
    NPM_SCORE=0
    
    # 檢測官方二進制支援度
    if check_official_binary_support; then
        BINARY_SCORE=$((BINARY_SCORE + 40))
        log_info "✅ 官方二進制支援: +40 分"
    else
        log_info "❌ 官方二進制不支援"
    fi
    
    # 檢測平台兼容性
    case "${SYSTEM_TYPE:-}" in
        macos)
            BINARY_SCORE=$((BINARY_SCORE + 35))
            NPM_SCORE=$((NPM_SCORE + 30))
            log_info "✅ macOS 環境，二進制優勢: +35分，NPM: +30分"
            ;;
        linux)
            BINARY_SCORE=$((BINARY_SCORE + 30))
            NPM_SCORE=$((NPM_SCORE + 30))
            log_info "✅ Linux 環境，平衡支援: +30分"
            ;;
        wsl)
            NPM_SCORE=$((NPM_SCORE + 40))
            log_info "✅ WSL 環境，NPM 更適合: +40 分"
            ;;
    esac
    
    # 檢測網路連線品質
    local network_quality="unknown"
    if [[ ${GCS_PING_MS:-999} -lt 100 ]]; then
        BINARY_SCORE=$((BINARY_SCORE + 20))
        network_quality="excellent"
        log_info "✅ 優秀 GCS 連線: +20 分"
    elif [[ ${NPM_PING_MS:-999} -lt 150 ]]; then
        NPM_SCORE=$((NPM_SCORE + 20))
        network_quality="good"
        log_info "✅ 良好 NPM 連線: +20 分"
    fi
    
    # 檢測 Node.js 環境健康度
    if check_nodejs_health; then
        NPM_SCORE=$((NPM_SCORE + 30))
        log_info "✅ Node.js 環境健康: +30 分"
    else
        BINARY_SCORE=$((BINARY_SCORE + 25))
        log_info "⚠️  Node.js 環境問題，偏向二進制: +25 分"
    fi
    
    # Context7 智能分析
    local context_recommendation
    context_recommendation=$(context7_analyze_environment)
    case "$context_recommendation" in
        "binary")
            BINARY_SCORE=$((BINARY_SCORE + 15))
            log_info "🧠 Context7 推薦二進制: +15 分"
            ;;
        "npm")
            NPM_SCORE=$((NPM_SCORE + 15))
            log_info "🧠 Context7 推薦 NPM: +15 分"
            ;;
    esac
    
    # 決策邏輯
    echo
    log_info "📊 智能安裝方法評分結果："
    log_info "   🔹 官方二進制安裝: $BINARY_SCORE 分"
    log_info "   🔹 NPM 生態安裝: $NPM_SCORE 分"
    
    if [[ $BINARY_SCORE -gt $NPM_SCORE ]]; then
        INSTALL_METHOD="binary"
        CONFIDENCE_SCORE=$BINARY_SCORE
        log_success "🎯 選擇官方二進制安裝（推薦指數: $BINARY_SCORE）"
    else
        INSTALL_METHOD="npm"
        CONFIDENCE_SCORE=$NPM_SCORE
        log_success "🎯 選擇 NPM 生態安裝（推薦指數: $NPM_SCORE）"
    fi
    
    export INSTALL_METHOD CONFIDENCE_SCORE
}

# ========== 官方二進制安裝引擎 ==========

# JSON 解析函數（無 jq 時使用）
get_checksum_from_manifest() {
    local json="$1"
    local platform="$2"
    
    # 規範化 JSON 並提取校驗和
    json=$(echo "$json" | tr -d '\n\r\t' | sed 's/ \+/ /g')
    
    if [[ $json =~ \"$platform\"[^}]*\"checksum\"[[:space:]]*:[[:space:]]*\"([a-f0-9]{64})\" ]]; then
        echo "${BASH_REMATCH[1]}"
        return 0
    fi
    
    return 1
}

# 官方二進制安裝實現
install_via_official_binary() {
    log_info "🚀 使用官方二進制安裝引擎..."
    
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        log_info "🧪 測試模式：模擬官方二進制安裝"
        return 0
    fi
    
    local target="${TARGET_VERSION:-stable}"
    local download_dir="$HOME/.claude/downloads"
    
    # 創建下載目錄
    mkdir -p "$download_dir"
    
    # 檢測平台
    local os arch platform
    case "$(uname -s)" in
        Darwin) os="darwin" ;;
        Linux) os="linux" ;;
        *) 
            log_error "不支援的作業系統: $(uname -s)"
            return 1
            ;;
    esac
    
    case "$(uname -m)" in
        x86_64|amd64) arch="x64" ;;
        arm64|aarch64) arch="arm64" ;;
        *) 
            log_error "不支援的架構: $(uname -m)"
            return 1
            ;;
    esac
    
    platform="${os}-${arch}"
    log_info "🖥️  檢測到平台: $platform"
    
    # 獲取版本資訊
    log_info "📡 獲取最新版本資訊..."
    local version
    if ! version=$(curl -fsSL "$GCS_BUCKET/stable" --max-time 30 2>/dev/null); then
        log_error "無法獲取版本資訊，可能是網路問題"
        return 1
    fi
    
    if [[ -z "$version" ]]; then
        log_error "版本資訊為空"
        return 1
    fi
    
    log_info "📦 目標版本: $version"
    
    # 下載並解析 manifest
    log_info "📋 下載安裝清單..."
    local manifest_json
    if ! manifest_json=$(curl -fsSL "$GCS_BUCKET/$version/manifest.json" --max-time 30 2>/dev/null); then
        log_error "無法下載安裝清單"
        return 1
    fi
    
    # 提取校驗和
    local checksum
    if command -v jq >/dev/null 2>&1; then
        checksum=$(echo "$manifest_json" | jq -r ".platforms[\"$platform\"].checksum // empty" 2>/dev/null)
    else
        checksum=$(get_checksum_from_manifest "$manifest_json" "$platform")
    fi
    
    if [[ -z "$checksum" ]] || [[ ! "$checksum" =~ ^[a-f0-9]{64}$ ]]; then
        log_error "平台 $platform 不支援或校驗和無效"
        log_debug "Checksum: '$checksum'"
        return 1
    fi
    
    log_info "🔐 安全校驗和: ${checksum:0:16}..."
    
    # 下載二進制文件
    local binary_path="$download_dir/claude-$version-$platform"
    log_info "⬇️  正在下載 Claude Code 二進制文件..."
    
    # 使用進度條下載
    if ! curl -fsSL -o "$binary_path" "$GCS_BUCKET/$version/$platform/claude" \
        --progress-bar --max-time 300; then
        log_error "下載失敗，請檢查網路連線"
        rm -f "$binary_path"
        return 1
    fi
    
    # 校驗檔案完整性
    log_info "🔍 驗證檔案完整性..."
    local actual_checksum
    if [[ "$os" == "darwin" ]]; then
        actual_checksum=$(shasum -a 256 "$binary_path" 2>/dev/null | cut -d' ' -f1)
    else
        actual_checksum=$(sha256sum "$binary_path" 2>/dev/null | cut -d' ' -f1)
    fi
    
    if [[ "$actual_checksum" != "$checksum" ]]; then
        log_error "檔案校驗失敗！可能檔案已損壞"
        log_error "預期: $checksum"
        log_error "實際: $actual_checksum"
        rm -f "$binary_path"
        return 1
    fi
    
    log_success "✅ 檔案完整性驗證通過"
    
    # 設定執行權限
    chmod +x "$binary_path"
    
    # 執行官方安裝程序
    log_info "⚙️  執行官方安裝程序..."
    if "$binary_path" install ${target:+"$target"}; then
        log_success "✅ 官方二進制安裝完成"
        
        # 清理暫存檔案
        rm -f "$binary_path"
        
        # 驗證安裝
        verify_claude_installation "binary"
        return 0
    else
        log_error "官方安裝程序執行失敗"
        rm -f "$binary_path"
        return 1
    fi
}

# ========== NPM 生態安裝引擎 ==========

# 強化版 npm/nvm 衝突檢測與自動修復系統
clean_npm_config_conflicts() {
    log_info "🔍 開始全面檢測 npm/nvm 配置衝突..."
    
    local npmrc_file="$HOME/.npmrc"
    local has_conflicts=false
    local backup_created=false
    local repair_success=false
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    
    # 多個 .npmrc 檔案位置檢查 (最佳實踐)
    local npmrc_files=("$HOME/.npmrc" "/usr/local/etc/npmrc" "/etc/npmrc")
    
    # === 步驟 1: 檢測所有可能的衝突源 ===
    log_info "📋 檢測 npm 配置衝突源..."
    
    # 1.1 檢查多個 .npmrc 檔案位置（最佳實踐）
    log_info "🔍 檢查多個 .npmrc 檔案位置..."
    for npmrc_path in "${npmrc_files[@]}"; do
        if [[ -f "$npmrc_path" ]]; then
            local conflict_lines
            conflict_lines=$(grep -E "^(prefix|globalconfig)" "$npmrc_path" 2>/dev/null || true)
            
            if [[ -n "$conflict_lines" ]]; then
                log_warn "🚨 發現 $npmrc_path 中有 prefix 或 globalconfig 設定，這會與 nvm 衝突"
                has_conflicts=true
                
                log_info "衝突的設定行："
                echo "$conflict_lines" | while IFS= read -r line; do
                    echo "  ❌ $line (在 $npmrc_path)"
                done
            fi
        fi
    done
    
    # 1.2 使用 npm config ls -l 檢查所有配置位置（最佳實踐）
    if command -v npm &>/dev/null; then
        log_info "🔍 使用 npm config ls -l 檢查所有配置位置..."
        local npm_config_output
        npm_config_output=$(npm config ls -l 2>/dev/null || echo "")
        
        if [[ -n "$npm_config_output" ]]; then
            # 檢查配置檔案位置
            local config_files
            config_files=$(echo "$npm_config_output" | grep -E "^; .*\.npmrc" | grep -v "builtin" || echo "")
            
            if [[ -n "$config_files" ]]; then
                log_info "發現的 npm 配置檔案："
                echo "$config_files" | while IFS= read -r config_file; do
                    echo "  📄 $config_file"
                done
            fi
            
            # 檢查 prefix 和 globalconfig 設定
            if echo "$npm_config_output" | grep -E "^prefix" | grep -v "undefined" >/dev/null 2>&1; then
                local prefix_setting
                prefix_setting=$(echo "$npm_config_output" | grep -E "^prefix" | head -1)
                log_warn "🚨 發現 prefix 設定：$prefix_setting"
                has_conflicts=true
            fi
            
            if echo "$npm_config_output" | grep -E "^globalconfig" | grep -v "undefined" >/dev/null 2>&1; then
                local globalconfig_setting
                globalconfig_setting=$(echo "$npm_config_output" | grep -E "^globalconfig" | head -1)
                log_warn "🚨 發現 globalconfig 設定：$globalconfig_setting"
                has_conflicts=true
            fi
        fi
    fi
    
    # 檢查當前 Node.js 和 nvm 狀態
    local current_node_version=""
    local node_path=""
    local nvm_available=false
    
    if command -v node &>/dev/null; then
        current_node_version=$(node --version 2>/dev/null | sed 's/^v//' || echo "")
        node_path=$(which node 2>/dev/null || echo "")
        log_info "當前 Node.js 版本：v$current_node_version"
        log_info "Node.js 路徑：$node_path"
    fi
    
    # 檢查並載入 nvm
    local nvm_dir="${NVM_DIR:-$HOME/.nvm}"
    if [[ -s "$nvm_dir/nvm.sh" ]]; then
        log_info "🔄 載入 nvm 環境..."
        # shellcheck source=/dev/null
        source "$nvm_dir/nvm.sh" 2>/dev/null || true
        
        if command -v nvm &>/dev/null; then
            nvm_available=true
            local nvm_current
            nvm_current=$(timeout 5 nvm current 2>/dev/null || echo "none")
            log_info "nvm 當前版本：$nvm_current"
        fi
    fi
    
    # === 如果發現衝突，進行修復 ===
    if [[ "$has_conflicts" == "true" ]]; then
        log_warn "⚠️  檢測到 npm/nvm 配置衝突，開始自動修復..."
        
        # 安全備份現有配置
        if [[ -f "$npmrc_file" ]] && [[ "$backup_created" == "false" ]]; then
            local backup_file="${npmrc_file}.backup.${timestamp}"
            if cp "$npmrc_file" "$backup_file" 2>/dev/null; then
                backup_created=true
                log_info "✅ 已備份 .npmrc 到：$backup_file"
            else
                log_warn "⚠️  無法備份 .npmrc，繼續修復..."
            fi
        fi
        
        # 使用 nvm delete-prefix（最佳方法）
        if [[ "$nvm_available" == "true" ]]; then
            log_info "🔧 使用 nvm --delete-prefix 自動修復..."
            
            # 先檢查是否有正在使用的 Node.js 版本
            local current_nvm_version
            current_nvm_version=$(nvm current 2>/dev/null || echo "none")
            
            # 嘗試使用當前 nvm 版本執行 delete-prefix
            if [[ "$current_nvm_version" != "none" ]] && [[ "$current_nvm_version" != "system" ]]; then
                log_info "🔄 使用當前 nvm 版本：$current_nvm_version"
                if nvm use --delete-prefix "$current_nvm_version" --silent 2>/dev/null; then
                    log_success "✅ nvm delete-prefix 修復成功"
                    repair_success=true
                fi
            fi
        fi
        
        # 手動修復方法（備用）
        if [[ "$repair_success" == "false" ]] && command -v npm &>/dev/null; then
            log_info "🔧 執行手動修復方法..."
            
            # 支援新版 npm 的 --location 參數
            local npm_version
            npm_version=$(npm --version 2>/dev/null | head -1 || echo "0.0.0")
            local npm_major_version
            npm_major_version=$(echo "$npm_version" | cut -d. -f1)
            
            if [[ "$npm_major_version" -ge 8 ]]; then
                # npm 8.0+ 語法
                log_info "使用 npm 8.0+ 語法清理配置..."
                npm config delete prefix --location=user 2>/dev/null || true
                npm config delete globalconfig --location=user 2>/dev/null || true
                npm config delete prefix --location=global 2>/dev/null || true
                npm config delete globalconfig --location=global 2>/dev/null || true
            else
                # 舊版 npm 語法
                log_info "使用舊版 npm 語法清理配置..."
                npm config delete prefix 2>/dev/null || true
                npm config delete globalconfig 2>/dev/null || true
                npm config delete prefix -g 2>/dev/null || true
                npm config delete globalconfig -g 2>/dev/null || true
            fi
            
            repair_success=true
        fi
    fi
    
    # 清理 npm 快取
    if command -v npm &>/dev/null; then
        npm cache clean --force 2>/dev/null || true
        log_info "✅ npm 快取已清理"
    fi
    
    # 最終狀態檢查
    log_info "🔍 驗證修復結果..."
    
    local final_conflicts=false
    
    # 重新檢查配置
    if command -v npm &>/dev/null; then
        local final_prefix
        final_prefix=$(npm config get prefix 2>/dev/null | grep -v "undefined" || echo "")
        
        if [[ -n "$final_prefix" ]]; then
            log_info "當前 npm prefix：$final_prefix"
            
            # 檢查是否仍有衝突
            if [[ "$final_prefix" != *"/.nvm/versions/node/"* ]] && [[ "$final_prefix" != *"/.npm-global"* ]]; then
                if [[ "$nvm_available" == "true" ]]; then
                    log_warn "⚠️  prefix 設定可能仍有問題，但 nvm 可用"
                    final_conflicts=true
                fi
            else
                log_success "✅ npm prefix 設定正常"
            fi
        else
            log_success "✅ npm prefix 未設定（將使用 nvm 預設）"
        fi
    fi
    
    # 最終報告與建議
    echo
    if [[ "$has_conflicts" == "false" ]]; then
        log_success "🎉 未發現 npm/nvm 配置衝突，環境正常"
    elif [[ "$repair_success" == "true" ]] && [[ "$final_conflicts" == "false" ]]; then
        log_success "🎉 npm/nvm 衝突修復成功！"
        log_info "📋 修復摘要："
        echo "  ✅ 已清理衝突的 npm 配置"
        if [[ "$backup_created" == "true" ]]; then
            echo "  ✅ 原始配置已備份"
        fi
        echo "  ✅ npm 快取已清理"
        
        log_info "🔄 建議執行以下操作完成修復："
        echo "  1. 重新載入 shell：source ${SHELL_CONFIG:-~/.zshrc}"
        if [[ "$nvm_available" == "true" ]] && [[ -n "$current_node_version" ]]; then
            echo "  2. 重新設定 nvm 版本：nvm use v${current_node_version}"
        fi
        echo "  3. 驗證 npm 設定：npm config get prefix"
    else
        log_warn "⚠️  部分衝突可能需要手動處理"
        log_info "🛠️  故障排查建議："
        echo "  1. 檢查 shell 配置檔案中的環境變數設定"
        echo "  2. 確認 nvm 正確安裝：curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash"
        echo "  3. 重新啟動終端並測試：nvm --version"
        
        if [[ "$backup_created" == "true" ]]; then
            echo "  4. 如需還原：mv $npmrc_file.backup.$timestamp $npmrc_file"
        fi
    fi
    
    return 0
}

# 設定 npm 全域安裝目錄
setup_npm_global_config() {
    log_info "⚙️  設定 npm 全域安裝目錄..."
    
    local npm_global_dir="$HOME/.npm-global"
    
    # 創建 npm 全域安裝目錄
    if [[ ! -d "$npm_global_dir" ]]; then
        mkdir -p "$npm_global_dir"
        log_info "📁 已創建 npm 全域安裝目錄：$npm_global_dir"
    fi
    
    # 配置 npm 使用此目錄
    npm config set prefix "$npm_global_dir" 2>/dev/null || true
    
    # 確保 PATH 包含 npm 全域 bin 目錄
    local npm_bin_dir="$npm_global_dir/bin"
    
    if [[ ":$PATH:" != *":$npm_bin_dir:"* ]]; then
        # 添加到當前 shell
        export PATH="$npm_bin_dir:$PATH"
        
        # 添加到 shell 配置檔案
        if [[ -f "$SHELL_CONFIG" ]]; then
            if ! grep -q "npm-global/bin" "$SHELL_CONFIG" 2>/dev/null; then
                {
                    echo ""
                    echo "# npm 全域安裝目錄 PATH"
                    echo "export PATH=\"\$HOME/.npm-global/bin:\$PATH\""
                } >> "$SHELL_CONFIG"
                log_info "✅ 已將 npm 全域 bin 目錄添加到 $SHELL_CONFIG"
            fi
        fi
    fi
    
    log_success "✅ npm 全域安裝目錄設定完成"
}

# NPM 生態安裝實現
install_via_npm_ecosystem() {
    log_info "🔧 使用 NPM 生態安裝引擎..."
    
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        log_info "🧪 測試模式：模擬 NPM 安裝"
        return 0
    fi
    
    # 檢查 Node.js 環境
    if ! command -v node &>/dev/null; then
        log_error "❌ Node.js 未安裝，請先安裝 Node.js $MIN_NODE_VERSION+"
        log_info "建議使用 nvm 安裝：curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
        return 1
    fi
    
    # 檢查 Node.js 版本
    local node_version
    node_version=$(node --version 2>/dev/null | sed 's/v//' | cut -d'.' -f1)
    if [[ $node_version -lt $MIN_NODE_VERSION ]]; then
        log_error "❌ Node.js 版本過舊: v$node_version (需要 v$MIN_NODE_VERSION+)"
        return 1
    fi
    
    # 檢查 npm
    if ! command -v npm &>/dev/null; then
        log_error "❌ npm 未安裝"
        return 1
    fi
    
    # 清理 npm 配置衝突
    clean_npm_config_conflicts
    
    # 設定 npm 全域安裝目錄
    setup_npm_global_config
    
    # 清理舊版本
    if command -v claude &>/dev/null; then
        log_info "🧹 清理舊版本..."
        npm uninstall -g "$CLAUDE_PACKAGE" 2>/dev/null || true
    fi
    
    # 確保使用正確的 npm 配置
    log_info "當前 npm 配置："
    npm config get prefix 2>/dev/null || true
    
    # 安裝新版本
    log_info "📦 安裝 Claude Code NPM 套件..."
    local install_attempts=0
    local max_attempts=3
    
    while [[ $install_attempts -lt $max_attempts ]]; do
        install_attempts=$((install_attempts + 1))
        log_info "📥 安裝嘗試 $install_attempts/$max_attempts..."
        
        if npm install -g "$CLAUDE_PACKAGE" --force --no-audit --progress=true; then
            log_success "✅ NPM 安裝完成"
            verify_claude_installation "npm"
            return 0
        else
            log_warn "⚠️  安裝嘗試 $install_attempts 失敗"
            
            if [[ $install_attempts -lt $max_attempts ]]; then
                log_info "🔄 清理快取並重試..."
                npm cache clean --force 2>/dev/null || true
                sleep 2
            fi
        fi
    done
    
    log_error "❌ NPM 安裝失敗，已嘗試 $max_attempts 次"
    return 1
}

# ========== 安裝驗證與恢復系統 ==========

# 安裝驗證與健康檢查
verify_claude_installation() {
    local install_method="$1"
    
    log_info "🔍 驗證 Claude Code 安裝..."
    
    # 基礎檢查
    if ! command -v claude &>/dev/null; then
        log_error "❌ claude 命令未找到"
        return 1
    fi
    
    local claude_path
    claude_path=$(which claude 2>/dev/null)
    log_info "📍 Claude 路徑: $claude_path"
    
    # 版本檢查
    local claude_version
    if claude_version=$(claude --version 2>/dev/null); then
        log_success "✅ Claude 版本: $claude_version"
    else
        log_error "❌ 無法獲取 Claude 版本"
        return 1
    fi
    
    # 執行官方健康檢查（跳過互動式檢查）
    log_info "🏥 執行基本功能檢查..."
    if claude --help &>/dev/null; then
        log_success "✅ Claude 基本功能檢查通過"
    else
        log_warn "⚠️  Claude 基本功能檢查發現問題"
        return 1
    fi
    
    # 記錄成功安裝
    local context_dir="$HOME/.claude"
    local history_file="$context_dir/install_history.log"
    mkdir -p "$context_dir"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $install_method install success - $claude_version" >> "$history_file"
    
    # 更新用戶偏好
    local prefs_file="$context_dir/user_preferences.json"
    echo "{\"install_method\":\"$install_method\",\"last_success\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" > "$prefs_file"
    
    log_success "🎉 Claude Code 安裝驗證完成"
    return 0
}

# 檢查 Claude Code CLI 狀態
check_claude_cli_status() {
    log_info "檢測 claude code CLI 狀態..."
    
    local claude_path claude_version="" needs_install=false needs_update=false
    
    claude_path=$(which claude 2>/dev/null || echo "")
    
    if [[ -z "$claude_path" ]]; then
        log_warn "claude code CLI 未安裝"
        needs_install=true
    else
        claude_version=$(claude --version 2>/dev/null | head -1 || echo "unknown")
        log_info "claude code CLI 路徑：$claude_path"
        log_info "claude code CLI 版本：$claude_version"
        
        # 檢查是否需要更新 - 檢測最新可用版本
        local latest_version current_version_number
        latest_version=$(npm view "$CLAUDE_PACKAGE" version 2>/dev/null || echo "unknown")
        
        if [[ "$latest_version" != "unknown" ]]; then
            current_version_number=$(echo "$claude_version" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1)
            if [[ -z "$current_version_number" ]]; then
                current_version_number="0.0.0"
            fi
            
            if [[ "$current_version_number" != "$latest_version" ]]; then
                log_warn "claude code CLI 版本較舊（當前：${current_version_number}，最新：${latest_version}），建議更新"
                needs_update=true
            else
                log_success "claude code CLI 版本已是最新（${current_version_number}）"
            fi
        else
            log_warn "無法檢測最新版本，跳過更新檢查"
        fi
    fi
    
    if [[ "$needs_install" == "true" ]]; then
        local should_install=false
        if [[ "${FAST_MODE:-}" == "true" ]]; then
            log_info "快速模式：自動安裝 claude code CLI"
            should_install=true
        else
            if interactive_prompt "是否要安裝 claude code CLI？" "Y"; then
                should_install=true
            fi
        fi
        
        if [[ "$should_install" == "true" ]]; then
            return 0  # 讓主安裝流程處理
        else
            log_warn "跳過 claude code CLI 安裝"
        fi
    elif [[ "$needs_update" == "true" ]]; then
        local should_update=false
        if [[ "${FAST_MODE:-}" == "true" ]]; then
            log_info "快速模式：自動更新 claude code CLI"
            should_update=true
        else
            if interactive_prompt "是否要更新 claude code CLI？" "Y"; then
                should_update=true
            fi
        fi
        
        if [[ "$should_update" == "true" ]]; then
            return 0  # 讓主安裝流程處理
        else
            log_warn "跳過 claude code CLI 更新"
        fi
    else
        log_success "claude code CLI 狀態正常"
        return 1  # 已安裝且最新，跳過安裝流程
    fi
}

# 錯誤恢復處理
handle_installation_failure() {
    local failed_method="$1"
    local error_code="$2"
    
    log_error "❌ $failed_method 安裝失敗 (錯誤代碼: $error_code)"
    
    # 記錄失敗
    local context_dir="$HOME/.claude"
    local history_file="$context_dir/install_history.log"
    mkdir -p "$context_dir"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $failed_method install failed - error_code:$error_code" >> "$history_file"
    
    # 智能降級策略
    case "$failed_method" in
        "binary")
            log_info "🔄 智能降級：切換到 NPM 安裝方式..."
            if install_via_npm_ecosystem; then
                log_success "✅ NPM 降級安裝成功"
                return 0
            else
                log_error "❌ NPM 降級安裝也失敗"
            fi
            ;;
        "npm")
            log_info "🔄 嘗試環境修復..."
            clean_npm_config_conflicts
            if install_via_npm_ecosystem; then
                log_success "✅ 修復後 NPM 安裝成功"
                return 0
            else
                log_error "❌ 環境修復失敗"
            fi
            ;;
    esac
    
    # 提供故障排除建議
    provide_troubleshooting_advice "$failed_method"
    return 1
}

# 故障排除建議
provide_troubleshooting_advice() {
    local failed_method="$1"
    
    echo
    log_info "🛠️  故障排除建議："
    
    case "$failed_method" in
        "binary")
            echo "  1. 檢查網路連線: ping storage.googleapis.com"
            echo "  2. 檢查防火牆設定，確保允許 HTTPS 連線"
            echo "  3. 嘗試使用 NPM 安裝: $0 --force-npm"
            echo "  4. 檢查磁碟空間是否足夠"
            ;;
        "npm")
            echo "  1. 檢查 Node.js 版本: node --version (需要 $MIN_NODE_VERSION+)"
            echo "  2. 清理 npm 快取: npm cache clean --force"
            echo "  3. 重新安裝 Node.js: 建議使用 nvm 管理版本"
            echo "  4. 檢查網路代理設定: npm config get proxy"
            echo "  5. 嘗試使用二進制安裝: $0 --force-binary"
            ;;
    esac
    
    echo "  📋 完整日誌位置: $LOG_FILE"
    echo "  🔗 更多幫助: https://github.com/s123104/claude-code/wiki/troubleshooting"
}

# ========== 主安裝流程 ==========

# 優化的彩色輸出
print_header() {
    local title="$1"
    local width=70
    local padding=$(((width - ${#title}) / 2))
    
    echo
    echo -e "${CYAN}$(printf '═%.0s' $(seq 1 $width))${NC}"
    echo -e "${CYAN}$(printf ' %.0s' $(seq 1 $padding))${YELLOW}$title${CYAN}$(printf ' %.0s' $(seq 1 $padding))${NC}"
    echo -e "${CYAN}$(printf '═%.0s' $(seq 1 $width))${NC}"
    echo
}

# 融合智能安裝主流程
main_installation() {
    local start_time
    start_time=$(date +%s)
    
    # 解析命令列參數
    parse_arguments "$@"
    
    # 顯示標題
    print_header "Claude Code 融合智能安裝系統 v$SCRIPT_VERSION"
    echo -e "${GREEN}🚀 雙引擎智能選擇 | Context7 多模態分析 | 完整錯誤恢復${NC}"
    echo -e "${GREEN}🎯 官方二進制 + NPM 生態 | Shell 版本檢測升級 | 跨平台兼容${NC}"
    
    if [[ "${FAST_MODE:-}" == "true" ]]; then
        echo -e "${YELLOW}⚡ 快速模式已啟用${NC}"
    fi
    
    if [[ "${DRY_RUN:-}" == "true" ]]; then
        echo -e "${PURPLE}🧪 測試模式已啟用（不會實際安裝）${NC}"
    fi
    
    if [[ "${TEST_MODE:-}" == "true" ]]; then
        echo -e "${PURPLE}🧪 自動測試模式已啟用${NC}"
        echo
        run_automated_tests
        exit $?
    fi
    
    echo
    
    # 第一階段：智能環境檢測
    log_info "=== 第一階段：智能環境檢測 ==="
    detect_environment
    
    # 主動清理 npm/nvm 配置衝突
    proactive_npm_cleanup
    
    check_system_resources
    check_network_conditions
    
    # 第二階段：Shell 環境檢測與升級
    log_info "=== 第二階段：Shell 環境檢測與升級 ==="
    
    # 在 macOS 上優先檢測 zsh，其他系統檢測 bash
    if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
        # zsh 版本檢測與升級
        echo -e "${CYAN}[步驟 1/3]${NC} Zsh 版本檢測與升級"
        check_and_upgrade_zsh
        
        # Bash 版本檢測與升級
        echo -e "${CYAN}[步驟 2/3]${NC} Bash 版本檢測與升級"
        check_and_upgrade_bash
        
        # Claude Code CLI 狀態檢測
        echo -e "${CYAN}[步驟 3/3]${NC} Claude Code CLI 狀態檢測"
        if check_claude_cli_status; then
            # 需要安裝或更新
            CLAUDE_NEEDS_INSTALL=true
        else
            # 已安裝且最新
            CLAUDE_NEEDS_INSTALL=false
        fi
    else
        # Bash 版本檢測與升級
        echo -e "${CYAN}[步驟 1/3]${NC} Bash 版本檢測與升級"
        check_and_upgrade_bash
        
        # zsh 版本檢測與升級
        echo -e "${CYAN}[步驟 2/3]${NC} Zsh 版本檢測與升級"
        check_and_upgrade_zsh
        
        # Claude Code CLI 狀態檢測
        echo -e "${CYAN}[步驟 3/3]${NC} Claude Code CLI 狀態檢測"
        if check_claude_cli_status; then
            # 需要安裝或更新
            CLAUDE_NEEDS_INSTALL=true
        else
            # 已安裝且最新
            CLAUDE_NEEDS_INSTALL=false
        fi
    fi
    
    # 如果 Claude Code 已是最新，跳過安裝流程
    if [[ "${CLAUDE_NEEDS_INSTALL:-true}" == "false" ]]; then
        log_success "Claude Code 已是最新版本，跳過安裝流程"
        
        # 修復路徑問題
        fix_claude_path_issues
        local end_time duration
        end_time=$(date +%s)
        duration=$((end_time - start_time))
        
        print_header "🎉 檢查完成"
        log_success "Claude Code 環境檢查完成！"
        log_info "📊 檢查統計："
        log_info "   🔹 檢查時間: ${duration}s"
        
        echo
        log_info "📋 後續步驟："
        echo "  1. 重新載入終端或執行: source ${SHELL_CONFIG:-~/.zshrc}"
        echo "  2. 進入專案目錄並執行: claude"
        echo "  3. 查看所有指令: claude --help"
        echo "  4. 執行健康檢查: claude doctor"
        return 0
    fi
    
    # 第三階段：智能安裝引擎選擇
    log_info "=== 第三階段：智能安裝引擎選擇 ==="
    detect_best_installation_method
    
    # 第四階段：執行智能安裝
    log_info "=== 第四階段：執行智能安裝 ==="
    local install_success=false
    
    case "$INSTALL_METHOD" in
        "binary")
            if install_via_official_binary; then
                install_success=true
            else
                log_warn "官方二進制安裝失敗，嘗試降級策略..."
                if handle_installation_failure "binary" "1"; then
                    install_success=true
                fi
            fi
            ;;
        "npm")
            if install_via_npm_ecosystem; then
                install_success=true
            else
                log_warn "NPM 安裝失敗，嘗試修復策略..."
                if handle_installation_failure "npm" "1"; then
                    install_success=true
                fi
            fi
            ;;
        *)
            log_error "未知的安裝方法: $INSTALL_METHOD"
            exit 1
            ;;
    esac
    
    # 計算安裝時間
    local end_time duration
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    # 最終結果
    echo
    if [[ "$install_success" == "true" ]]; then
        print_header "🎉 安裝成功完成"
        log_success "Claude Code 融合智能安裝成功！"
        log_info "📊 安裝統計："
        log_info "   🔹 安裝方法: $INSTALL_METHOD"
        log_info "   🔹 安裝時間: ${duration}s"
        log_info "   🔹 信心指數: $CONFIDENCE_SCORE/100"
        
        # 後續步驟指引
        echo
        log_info "📋 後續步驟："
        echo "  1. 重新載入終端或執行: source ${SHELL_CONFIG:-~/.zshrc}"
        echo "  2. 進入專案目錄並執行: claude"
        echo "  3. 查看所有指令: claude --help"
        echo "  4. 執行健康檢查: claude doctor"
        
        # 收集統計資訊（匿名）
        if [[ "${DRY_RUN:-}" != "true" ]]; then
            {
                echo "timestamp=$(date +%s)"
                echo "install_method=$INSTALL_METHOD"
                echo "success=true"
                echo "duration=$duration"
                echo "system_type=$SYSTEM_TYPE"
                echo "confidence_score=$CONFIDENCE_SCORE"
            } >> "$HOME/.claude/usage_stats.log" 2>/dev/null || true
        fi
        
    else
        print_header "❌ 安裝失敗"
        log_error "Claude Code 安裝失敗，請查看故障排除建議"
        
        echo
        log_info "📞 獲得幫助："
        echo "  📋 完整日誌: $LOG_FILE"
        echo "  📖 故障排除: https://github.com/s123104/claude-code/wiki/troubleshooting"
        echo "  🐛 問題回報: https://github.com/s123104/claude-code/issues"
        
        exit 1
    fi
}

# ========== 腳本入口點 ==========

# 安全檢查：支援直接執行和管道執行
if [[ "${BASH_SOURCE[0]:-$0}" == "${0}" ]] || [[ -z "${BASH_SOURCE[0]:-}" ]]; then
    # 安全性檢查
    if [[ $EUID -eq 0 ]] && [[ "${FORCE_ROOT:-}" != "true" ]]; then
        log_error "❌ 不建議使用 root 權限執行此腳本"
        log_info "如果確實需要，請使用 --force-root 參數"
        exit 1
    fi
    
    # 執行主安裝流程
    main_installation "$@"
    
    echo
    log_info "🔧 如遇問題，請檢查日誌：$LOG_FILE"
fi