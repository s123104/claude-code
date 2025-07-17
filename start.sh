#!/bin/bash
# 2025 Shell 最佳實踐：嚴格模式設定
set -euo pipefail

# ========== Claude Code 自動化安裝與啟動腳本 ==========
# 版本: 3.5.2 (2025 最佳實踐優化版)
# 支援: Windows WSL2 + Linux + macOS 環境自動偵測與安裝
# 新增: 強化 npm/nvm 衝突修復，自動執行 delete-prefix，完整解決 macOS zsh 問題
# 作者: Claude Code 中文社群
# 更新: 2025-07-17T23:45:15+08:00

# ========== 配置參數 ==========
SCRIPT_VERSION="3.5.2"
# shellcheck disable=SC2034
NVM_VERSION="v0.40.3"            # 最新穩定版本
# shellcheck disable=SC2034
NODE_TARGET_VERSION="22.14.0"    # LTS Jod 最新版本
# shellcheck disable=SC2034
NODE_FALLBACK_VERSION="18.20.8"  # LTS Hydrogen 備用版本
CLAUDE_PACKAGE="@anthropic-ai/claude-code"
MIN_BASH_VERSION="4.0"           # 建議的最低 bash 版本
MIN_ZSH_VERSION="5.0"            # 建議的最低 zsh 版本

# ========== 日誌和顏色系統 ==========
LOG_FILE="/tmp/claude_setup_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
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

# 兼容舊版函數名
error_exit() {
    log_error "$1"
    log_info "完整日誌已保存至：$LOG_FILE"
    exit 1
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
    
    # 詢問是否更改默認 shell - 在 macOS 上推薦使用 zsh
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

# ========== 智能檢測與互動式修復系統 ==========

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

# 檢測作業系統環境
detect_os() {
    log_info "正在偵測作業系統環境..."
    
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
                log_warn "claude code CLI 版本較舊（當前：$current_version_number，最新：$latest_version），建議更新"
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
            install_claude_code_fresh
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
            install_claude_code_fresh
        else
            log_warn "跳過 claude code CLI 更新"
        fi
    else
        log_success "claude code CLI 狀態正常"
    fi
}

# 清理 npm 配置衝突
clean_npm_config_conflicts() {
    log_info "檢查並清理 npm 配置衝突..."
    
    local npmrc_file="$HOME/.npmrc"
    local has_conflicts=false
    local nvm_conflict_detected=false
    
    # 檢查是否存在 prefix 或 globalconfig 設定
    if [[ -f "$npmrc_file" ]]; then
        if grep -E "^(prefix|globalconfig)" "$npmrc_file" >/dev/null 2>&1; then
            log_warn "發現 ~/.npmrc 中有 prefix 或 globalconfig 設定，這會與 nvm 衝突"
            has_conflicts=true
            nvm_conflict_detected=true
            
            # 顯示衝突的設定
            log_info "衝突的設定："
            grep -E "^(prefix|globalconfig)" "$npmrc_file" || true
            
            # 備份原始檔案
            local backup_file="${npmrc_file}.backup.$(date +%Y%m%d_%H%M%S)"
            cp "$npmrc_file" "$backup_file"
            log_info "已備份原始 .npmrc 到：$backup_file"
            
            # 移除衝突的設定
            log_info "移除衝突的 prefix 和 globalconfig 設定..."
            grep -vE "^(prefix|globalconfig)" "$npmrc_file" > "${npmrc_file}.tmp" && mv "${npmrc_file}.tmp" "$npmrc_file"
            
            log_success "已清理 ~/.npmrc 中的衝突設定"
        fi
    fi
    
    # 檢查環境變數衝突
    if [[ -n "${NPM_CONFIG_PREFIX:-}" ]]; then
        log_warn "發現環境變數 NPM_CONFIG_PREFIX=$NPM_CONFIG_PREFIX，這會與 nvm 衝突"
        log_info "建議在 shell 配置檔案中移除 NPM_CONFIG_PREFIX 設定"
        has_conflicts=true
        nvm_conflict_detected=true
    fi
    
    if [[ -n "${PREFIX:-}" ]]; then
        log_warn "發現環境變數 PREFIX=$PREFIX，這可能與 nvm 衝突"
        has_conflicts=true
    fi
    
    # 檢測特殊的 nvm 衝突訊息情形
    local current_node_version=""
    if command -v node &>/dev/null; then
        current_node_version=$(node --version 2>/dev/null | sed 's/^v//' || echo "")
    fi
    
    # 如果檢測到 nvm 相關衝突或有當前 Node.js 版本
    if [[ "$nvm_conflict_detected" == "true" ]] || [[ -n "$current_node_version" ]]; then
        # 嘗試載入 nvm（如果存在）
        if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
            log_info "嘗試載入 nvm 環境..."
            # shellcheck source=/dev/null
            source "$HOME/.nvm/nvm.sh" 2>/dev/null || true
        fi
        
        # 如果 nvm 可用且有當前版本，執行 delete-prefix
        if command -v nvm &>/dev/null && [[ -n "$current_node_version" ]]; then
            log_info "嘗試使用 nvm 清理 prefix 設定..."
            
            # 先檢查 npm config 中的 prefix 設定
            local npm_prefix=""
            npm_prefix=$(npm config get prefix 2>/dev/null | grep -v "undefined" || echo "")
            
            if [[ -n "$npm_prefix" ]] && [[ "$npm_prefix" != *"/.npm-global" ]]; then
                log_info "發現 npm prefix 設定：$npm_prefix"
                
                # 執行 nvm use --delete-prefix
                log_info "執行 nvm use --delete-prefix v${current_node_version} --silent..."
                if nvm use --delete-prefix "v${current_node_version}" --silent 2>/dev/null; then
                    log_success "已使用 nvm 清理 prefix 設定"
                else
                    # 如果失敗，嘗試不同的方法
                    log_warn "nvm delete-prefix 失敗，嘗試替代方法..."
                    
                    # 手動清理 npm prefix
                    if npm config delete prefix 2>/dev/null; then
                        log_info "已手動清理 npm prefix 設定"
                    fi
                    
                    # 嘗試重新使用當前版本
                    if nvm use "v${current_node_version}" --silent 2>/dev/null; then
                        log_info "已重新設定 nvm 使用版本 v${current_node_version}"
                    fi
                fi
            fi
        elif [[ -n "$current_node_version" ]]; then
            # 如果 nvm 不可用但有 Node.js，手動清理
            log_info "nvm 不可用，嘗試手動清理 npm 配置..."
            if command -v npm &>/dev/null; then
                npm config delete prefix 2>/dev/null || true
                npm config delete globalconfig 2>/dev/null || true
                log_info "已嘗試手動清理 npm 配置"
            fi
        fi
    fi
    
    # 清理 npm cache 以確保沒有快取問題
    log_info "清理 npm 快取..."
    if command -v npm &>/dev/null; then
        npm cache clean --force 2>/dev/null || true
    fi
    
    # 最終檢查與提示
    if [[ "$has_conflicts" == "false" ]]; then
        log_success "未發現 npm 配置衝突"
    else
        log_info "npm 配置衝突清理完成"
        
        # 提供額外的建議
        log_info "建議重新載入 shell 或執行：source ${SHELL_CONFIG:-~/.zshrc}"
        if [[ -n "$current_node_version" ]]; then
            log_info "當前 Node.js 版本：v${current_node_version}"
        fi
    fi
}

# 設定 npm 全域安裝目錄
setup_npm_global_config() {
    log_info "設定 npm 全域安裝目錄..."
    
    local npm_global_dir="$HOME/.npm-global"
    
    # 創建 npm 全域安裝目錄
    if [[ ! -d "$npm_global_dir" ]]; then
        mkdir -p "$npm_global_dir"
        log_info "已創建 npm 全域安裝目錄：$npm_global_dir"
    fi
    
    # 配置 npm 使用此目錄
    npm config set prefix "$npm_global_dir" 2>/dev/null || true
    
    # 確保 PATH 包含 npm 全域 bin 目錄
    local npm_bin_dir="$npm_global_dir/bin"
    
    if [[ ":$PATH:" != *":$npm_bin_dir:"* ]]; then
        # 添加到當前 shell
        export PATH="$npm_bin_dir:$PATH"
        
        # 添加到 shell 配置檔案
        local shell_config="${SHELL_CONFIG:-$HOME/.zshrc}"
        if [[ -f "$shell_config" ]]; then
            if ! grep -q "npm-global/bin" "$shell_config" 2>/dev/null; then
                echo "" >> "$shell_config"
                echo "# npm 全域安裝目錄 PATH" >> "$shell_config"
                echo "export PATH=\"\$HOME/.npm-global/bin:\$PATH\"" >> "$shell_config"
                log_info "已將 npm 全域 bin 目錄添加到 $shell_config"
            fi
        fi
    fi
    
    log_success "npm 全域安裝目錄設定完成"
}

# 安裝 Claude Code CLI
install_claude_code_fresh() {
    log_info "安裝 Claude Code CLI..."
    
    # 清理 npm 配置衝突
    clean_npm_config_conflicts
    
    # 設定 npm 全域安裝目錄
    setup_npm_global_config
    
    # 清理舊版本（如果存在）
    if command -v claude &>/dev/null; then
        log_info "清理舊版本..."
        npm uninstall -g "$CLAUDE_PACKAGE" 2>/dev/null || true
    fi
    
    # 確保使用正確的 npm 配置
    log_info "當前 npm 配置："
    npm config get prefix 2>/dev/null || true
    
    # 安裝 Claude Code
    log_info "正在安裝 $CLAUDE_PACKAGE..."
    if ! npm install -g "$CLAUDE_PACKAGE" --force; then
        error_exit "Claude Code CLI 安裝失敗"
    fi
    
    # 驗證安裝
    local claude_path
    claude_path=$(which claude 2>/dev/null || echo "")
    if [[ -n "$claude_path" ]]; then
        log_success "Claude Code CLI 安裝完成：$claude_path"
        
        # 顯示版本資訊
        local claude_version
        claude_version=$(claude --version 2>/dev/null | head -1 || echo "unknown")
        log_info "安裝版本：$claude_version"
    else
        log_warn "Claude Code CLI 安裝完成，但未在 PATH 中找到"
        log_info "請重新載入 shell 或執行：source $SHELL_CONFIG"
    fi
}

# 快速模式檢查
check_fast_mode() {
    local arg
    for arg in "$@"; do
        if [[ "$arg" == "--fast" || "$arg" == "-f" ]]; then
            export FAST_MODE=true
            log_info "啟用快速模式，將跳過非必要檢查"
            return 0
        fi
    done
    return 0
}

# 優化的彩色輸出
print_header() {
    local title="$1"
    local width=60
    local padding=$(((width - ${#title}) / 2))
    
    echo -e "${CYAN}$(printf '=%.0s' $(seq 1 $width))${NC}"
    echo -e "${CYAN}$(printf ' %.0s' $(seq 1 $padding))${YELLOW}$title${CYAN}$(printf ' %.0s' $(seq 1 $padding))${NC}"
    echo -e "${CYAN}$(printf '=%.0s' $(seq 1 $width))${NC}"
}

# 主安裝流程
main_installation() {
    # 檢查快速模式
    check_fast_mode "$@"
    
    print_header "Claude Code 自動安裝工具 v$SCRIPT_VERSION"
    echo -e "${GREEN}整合 Context7 最佳實踐優化${NC}"
    echo -e "${GREEN}智能檢測與互動式修復${NC}"
    echo -e "${GREEN}Zsh/Bash 版本檢測與升級功能${NC}"
    if [[ "${FAST_MODE:-}" == "true" ]]; then
        echo -e "${YELLOW}🚀 快速模式已啟用${NC}"
    fi
    echo
    
    log_info "=== 開始 Claude Code 安裝流程 ==="
    
    # 偵測作業系統環境
    detect_os
    
    log_info "開始自動化安裝與修復程序（${SYSTEM_TYPE:-未知} 環境）"
    
    # 智能檢測與修復
    log_info "=== 開始智能檢測與修復流程 ==="
    
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
        check_claude_cli_status
    else
        # Bash 版本檢測與升級
        echo -e "${CYAN}[步驟 1/3]${NC} Bash 版本檢測與升級"
        check_and_upgrade_bash
        
        # zsh 版本檢測與升級
        echo -e "${CYAN}[步驟 2/3]${NC} Zsh 版本檢測與升級"
        check_and_upgrade_zsh
        
        # Claude Code CLI 狀態檢測
        echo -e "${CYAN}[步驟 3/3]${NC} Claude Code CLI 狀態檢測"
        check_claude_cli_status
    fi
    
    print_header "安裝完成"
    log_success "Claude Code 安裝流程完成！"
}

# 執行主安裝流程
# 安全檢查：支援直接執行和管道執行
if [[ "${BASH_SOURCE[0]:-$0}" == "${0}" ]] || [[ -z "${BASH_SOURCE[0]:-}" ]]; then
    main_installation "$@"
    
    echo
    log_info "=== 後續步驟 ==="
    echo "  1. 重新載入終端或執行: source ${SHELL_CONFIG:-~/.zshrc}"
    echo "  2. 進入專案目錄並執行: claude"
    echo "  3. 查看所有指令: claude --help"
    echo ""
    log_info "🔧 如遇問題，請檢查日誌：$LOG_FILE"
fi