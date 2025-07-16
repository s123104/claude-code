#!/bin/bash
# 2025 Shell 最佳實踐：嚴格模式設定
set -euo pipefail

# ========== Claude Code 自動化安裝與啟動腳本 ==========
# 版本: 3.5.0 (2025 最佳實踐優化版)
# 支援: Windows WSL2 + Linux + macOS 環境自動偵測與安裝
# 新增: Bash 版本檢測升級、快速模式優化、ShellCheck 0 警告
# 作者: Claude Code 中文社群
# 更新: 2025-07-16

# ========== 配置參數 ==========
SCRIPT_VERSION="3.5.0"
NVM_VERSION="v0.40.3"            # 最新穩定版本
NODE_TARGET_VERSION="22.14.0"    # LTS Jod 最新版本
NODE_FALLBACK_VERSION="18.20.8"  # LTS Hydrogen 備用版本
CLAUDE_PACKAGE="@anthropic-ai/claude-code"
MIN_BASH_VERSION="4.0"           # 建議的最低 bash 版本

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

warn() {
    log_warn "$1"
}

success() {
    log_success "$1"
}

info() {
    log_info "$1"
}

# ========== Bash 版本檢測與升級系統 ==========

# 檢測當前 bash 版本
get_bash_version() {
    local version
    if [[ -n "${BASH_VERSION:-}" ]]; then
        version="${BASH_VERSION}"
    else
        version=$(bash --version 2>/dev/null | head -n1 | grep -o '[0-9]\+\.[0-9]\+' | head -1 || echo "3.2")
    fi
    echo "${version}"
}

# 比較版本號
version_compare() {
    local version1="$1"
    local version2="$2"
    
    # 移除非數字字符，只保留主要和次要版本號
    local v1_major v1_minor v2_major v2_minor
    v1_major=$(echo "$version1" | cut -d. -f1)
    v1_minor=$(echo "$version1" | cut -d. -f2)
    v2_major=$(echo "$version2" | cut -d. -f1)
    v2_minor=$(echo "$version2" | cut -d. -f2)
    
    # 轉換為整數進行比較
    local v1_int=$((v1_major * 100 + v1_minor))
    local v2_int=$((v2_major * 100 + v2_minor))
    
    if [[ $v1_int -lt $v2_int ]]; then
        return 1  # version1 < version2
    elif [[ $v1_int -gt $v2_int ]]; then
        return 2  # version1 > version2
    else
        return 0  # version1 == version2
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
        log_warn "bash 版本過舊（$current_version < $MIN_BASH_VERSION），建議升級"
        
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
        log_success "bash 版本符合要求（$current_version >= $MIN_BASH_VERSION）"
    fi
}

# 升級 bash
upgrade_bash() {
    log_info "開始升級 bash..."
    
    case "$SYSTEM_TYPE" in
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
    
    # 詢問是否更改默認 shell
    if [[ "${FAST_MODE:-}" == "true" ]] || interactive_prompt "是否要將新 bash 設為默認 shell？" "Y"; then
        log_info "更改默認 shell 到新 bash..."
        chsh -s "$new_bash_path" || log_warn "更改默認 shell 失敗，請手動執行：chsh -s $new_bash_path"
    fi
    
    log_success "bash 升級完成"
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

# 互動式提示函數 - 使用優化版本
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

# 檢測 npm 權限問題
check_npm_permissions() {
    log_info "檢測 npm 權限問題..."
    
    local npm_prefix npm_cache has_permission_issues=false
    
    if command -v npm &>/dev/null; then
        npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
        npm_cache=$(npm config get cache 2>/dev/null || echo "")
        
        # 檢查 npm prefix 權限
        if [[ -n "$npm_prefix" && -d "$npm_prefix" ]]; then
            if [[ ! -w "$npm_prefix" ]]; then
                log_warn "npm 全域安裝目錄無寫入權限：$npm_prefix"
                has_permission_issues=true
            fi
        fi
        
        # 檢查 npm cache 權限
        if [[ -n "$npm_cache" && -d "$npm_cache" ]]; then
            if [[ ! -w "$npm_cache" ]]; then
                log_warn "npm 快取目錄無寫入權限：$npm_cache"
                has_permission_issues=true
            fi
        fi
        
        # 檢查是否有 root 擁有的 npm 目錄
        if [[ -d "/usr/local/lib/node_modules" ]]; then
            local owner
            if command -v stat &>/dev/null; then
                if stat --version 2>/dev/null | grep -q GNU; then
                    owner=$(stat -c %U "/usr/local/lib/node_modules" 2>/dev/null || echo "unknown")
                else
                    owner=$(stat -f %Su "/usr/local/lib/node_modules" 2>/dev/null || echo "unknown")
                fi
                if [[ "$owner" == "root" ]]; then
                    log_warn "偵測到 root 擁有的 npm 目錄：/usr/local/lib/node_modules"
                    has_permission_issues=true
                fi
            fi
        fi
        
        if [[ "$has_permission_issues" == "true" ]]; then
            log_error "偵測到 npm 權限問題"
            if interactive_prompt "是否要修正 npm 權限問題？建議使用安全的 ~/.npm-global 目錄"; then
                fix_npm_permissions_safe
            else
                log_warn "跳過 npm 權限修正，可能影響後續安裝"
            fi
        else
            log_success "npm 權限檢查通過"
        fi
    else
        log_info "npm 未安裝，跳過權限檢查"
    fi
}

# 安全修正 npm 權限（使用 ~/.npm-global）
fix_npm_permissions_safe() {
    log_info "使用安全方式修正 npm 權限..."
    
    # 建立 ~/.npm-global 目錄
    local npm_global_dir="$HOME/.npm-global"
    mkdir -p "$npm_global_dir"
    
    # 備份現有 .npmrc
    if [[ -f "$HOME/.npmrc" ]]; then
        cp "$HOME/.npmrc" "$HOME/.npmrc.backup.$(date +%Y%m%d_%H%M%S)"
        log_info "已備份現有 .npmrc 配置"
    fi
    
    # 清理衝突設定
    if command -v npm &>/dev/null; then
        npm config delete prefix 2>/dev/null || true
        npm config delete globalconfig 2>/dev/null || true
        
        # 設定新的 npm prefix
        npm config set prefix "$npm_global_dir"
        npm config set audit false
        npm config set fund false
        npm config set update-notifier false
        npm config set strict-ssl true
    fi
    
    # 更新 PATH
    if [[ -n "${SHELL_CONFIG:-}" ]] && ! grep -q "$npm_global_dir/bin" "$SHELL_CONFIG" 2>/dev/null; then
        echo "export PATH=\$HOME/.npm-global/bin:\$PATH" >> "$SHELL_CONFIG"
        log_info "已將 ~/.npm-global/bin 加入 PATH"
    fi
    
    # 重新載入 PATH
    export PATH="$npm_global_dir/bin:$PATH"
    
    log_success "npm 權限修正完成（使用安全的 ~/.npm-global）"
}

# 檢測 nvm 與 npm 衝突
check_nvm_npm_conflicts() {
    log_info "檢測 nvm 與 npm 衝突..."
    
    local has_conflicts=false node_path npm_prefix
    
    if command -v node &>/dev/null; then
        node_path=$(which node 2>/dev/null || echo "")
        if command -v npm &>/dev/null; then
            npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
            
            # 檢查是否使用 nvm 但 npm prefix 設定不當
            if [[ "$node_path" == *".nvm"* ]]; then
                if [[ -n "$npm_prefix" && "$npm_prefix" != *".nvm"* && "$npm_prefix" != *".npm-global"* ]]; then
                    log_warn "偵測到 nvm 與 npm prefix 衝突"
                    log_warn "Node.js 路徑：$node_path"
                    log_warn "npm prefix：$npm_prefix"
                    has_conflicts=true
                fi
            fi
            
            # 檢查 .npmrc 中的衝突設定
            if [[ -f "$HOME/.npmrc" ]]; then
                if grep -q "globalconfig" "$HOME/.npmrc" 2>/dev/null; then
                    log_warn "偵測到 .npmrc 中的 globalconfig 設定與 nvm 衝突"
                    has_conflicts=true
                fi
            fi
        fi
    fi
    
    if [[ "$has_conflicts" == "true" ]]; then
        log_error "偵測到 nvm 與 npm 衝突"
        if interactive_prompt "是否要修正 nvm 與 npm 衝突？"; then
            fix_nvm_npm_conflicts
        else
            log_warn "跳過衝突修正，可能影響 Node.js 版本管理"
        fi
    else
        log_success "nvm 與 npm 相容性檢查通過"
    fi
}

# 修正 nvm 與 npm 衝突
fix_nvm_npm_conflicts() {
    log_info "修正 nvm 與 npm 衝突..."
    
    # 如果使用 nvm，清理 npm prefix 設定
    if command -v nvm &>/dev/null; then
        local current_node_version
        current_node_version=$(nvm current 2>/dev/null || echo "system")
        if [[ "$current_node_version" != "system" ]]; then
            log_info "偵測到 nvm 環境，清理 npm prefix 設定"
            if command -v npm &>/dev/null; then
                npm config delete prefix 2>/dev/null || true
                npm config delete globalconfig 2>/dev/null || true
            fi
        fi
    fi
    
    # 清理 .npmrc 中的衝突設定 - macOS 兼容版本
    if [[ -f "$HOME/.npmrc" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' '/globalconfig/d; /prefix.*\/usr\/local/d' "$HOME/.npmrc" 2>/dev/null || true
        else
            sed -i '/globalconfig/d; /prefix.*\/usr\/local/d' "$HOME/.npmrc" 2>/dev/null || true
        fi
    fi
    
    log_success "nvm 與 npm 衝突修正完成"
}

# 檢測 claude code CLI 狀態
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
        
        # 檢查是否需要更新（這裡可以加入版本比較邏輯）
        if [[ "$claude_version" == *"1.0.5"* ]]; then
            log_warn "claude code CLI 版本較舊，建議更新"
            needs_update=true
        fi
    fi
    
    if [[ "$needs_install" == "true" ]]; then
        local should_install=false
        if [[ "${FAST_MODE:-}" == "true" ]]; then
            log_info "快速模式：自動安裝 claude code CLI"
            should_install=true
        else
            if interactive_prompt "是否要安裝 claude code CLI？"; then
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
            if interactive_prompt "是否要更新 claude code CLI？"; then
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

# 清理系統環境污染
clean_system_environment() {
    log_info "清理系統環境污染..."
    
    # 清理 PATH 中的 Windows 路徑（WSL 環境）
    if [[ -n "${WSL_MODE:-}" ]]; then
        if echo "$PATH" | grep -q "/mnt/c/"; then
            log_info "清理 PATH 中的 Windows 路徑"
            local new_path
            new_path=$(echo "$PATH" | tr ':' '\n' | grep -v "/mnt/c/" | tr '\n' ':' | sed 's/:$//')
            export PATH="$new_path"
            
            # 更新 shell 配置
            if [[ -n "${SHELL_CONFIG:-}" ]] && grep -q "/mnt/c/" "$SHELL_CONFIG" 2>/dev/null; then
                # 使用兼容的 sed 語法
                if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
                    sed -i '' '/\/mnt\/c\//d' "$SHELL_CONFIG"
                else
                    sed -i '/\/mnt\/c\//d' "$SHELL_CONFIG"
                fi
                log_info "已從 $SHELL_CONFIG 移除 Windows 路徑"
            fi
        fi
    fi
    
    log_success "系統環境清理完成"
}

# 安全設定最佳實踐
apply_security_best_practices() {
    log_info "套用安全設定最佳實踐..."
    
    # npm 安全設定
    if command -v npm &>/dev/null; then
        npm config set audit true
        npm config set fund false
        npm config set update-notifier false
        npm config set strict-ssl true
        npm config set audit-level moderate
        
        # 移除已棄用的 cache-min 設定，使用 prefer-offline 替代
        npm config delete cache-min 2>/dev/null || true
    fi
    
    # 檢查 .npmrc 權限
    if [[ -f "$HOME/.npmrc" ]]; then
        chmod 600 "$HOME/.npmrc"
    fi
    
    log_success "安全設定最佳實踐已套用"
}

# 主要檢測與修復流程 - 簡化版本
# 註：優化版本在後面定義

# 首先檢查作業系統環境
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
            # 使用子 shell 避免污染當前環境
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
    
    # 智能檢測 Shell 配置文件（基於最佳實踐）
    detect_shell_config() {
        local detected_shell="" config_file=""
        
        # 1. 檢測當前運行的 shell
        if [[ -n "${ZSH_VERSION:-}" ]]; then
            detected_shell="zsh"
        elif [[ -n "${BASH_VERSION:-}" ]]; then
            detected_shell="bash"
        elif [[ -n "${FISH_VERSION:-}" ]]; then
            detected_shell="fish"
        else
            # 回退到 $SHELL 變數
            detected_shell=$(basename "${SHELL:-/bin/bash}" 2>/dev/null || echo "bash")
        fi
        
        # 2. 根據 shell 類型設定配置文件優先順序
        case "$detected_shell" in
            zsh)
                # zsh 配置文件優先順序（macOS 13+ 預設使用 zsh）
                if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
                    # macOS zsh 優先使用 .zshrc
                    for config in "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.zshenv"; do
                        if [[ -f "$config" ]]; then
                            config_file="$config"
                            break
                        fi
                    done
                    config_file="${config_file:-$HOME/.zshrc}"
                else
                    # Linux zsh 配置
                    for config in "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.profile"; do
                        if [[ -f "$config" ]]; then
                            config_file="$config"
                            break
                        fi
                    done
                    config_file="${config_file:-$HOME/.zshrc}"
                fi
                ;;
            bash)
                # bash 配置文件優先順序（考慮 macOS 特殊情況）
                if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
                    # macOS bash 預設使用 .bash_profile 作為 login shell
                    for config in "$HOME/.bash_profile" "$HOME/.bashrc" "$HOME/.profile"; do
                        if [[ -f "$config" ]]; then
                            config_file="$config"
                            break
                        fi
                    done
                    config_file="${config_file:-$HOME/.bash_profile}"
                else
                    # Linux 等其他系統使用 .bashrc
                    for config in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile"; do
                        if [[ -f "$config" ]]; then
                            config_file="$config"
                            break
                        fi
                    done
                    config_file="${config_file:-$HOME/.bashrc}"
                fi
                ;;
            fish)
                # fish 配置文件
                config_file="$HOME/.config/fish/config.fish"
                # 確保 fish 配置目錄存在
                mkdir -p "$(dirname "$config_file")" 2>/dev/null || true
                ;;
            *)
                # 其他 shell 或未知 shell，使用通用配置
                if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
                    # macOS 預設嘗試 .zshrc（因為 macOS 13+ 預設使用 zsh）
                    for config in "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.profile"; do
                        if [[ -f "$config" ]]; then
                            config_file="$config"
                            break
                        fi
                    done
                    config_file="${config_file:-$HOME/.zshrc}"
                else
                    # Linux 等其他系統
                    for config in "$HOME/.profile" "$HOME/.bashrc" "$HOME/.zshrc"; do
                        if [[ -f "$config" ]]; then
                            config_file="$config"
                            break
                        fi
                    done
                    config_file="${config_file:-$HOME/.profile}"
                fi
                ;;
        esac
        
        # 輸出結果：shell_type|config_file
        echo "$detected_shell|$config_file"
    }
    
    # 執行檢測並解析結果
    local shell_detection_result
    shell_detection_result=$(detect_shell_config)
    DETECTED_SHELL=$(echo "$shell_detection_result" | cut -d'|' -f1)
    SHELL_CONFIG=$(echo "$shell_detection_result" | cut -d'|' -f2)
    
    # 驗證和創建配置文件
    validate_shell_config() {
        local config_file="$1"
        local config_dir
        config_dir=$(dirname "$config_file")
        
        # 確保配置目錄存在
        if [[ ! -d "$config_dir" ]]; then
            mkdir -p "$config_dir" || {
                log_warn "無法創建配置目錄：$config_dir"
                return 1
            }
        fi
        
        # 如果配置文件不存在，創建它
        if [[ ! -f "$config_file" ]]; then
            touch "$config_file" || {
                log_warn "無法創建配置文件：$config_file"
                return 1
            }
            log_info "已創建配置文件：$config_file"
        fi
        
        # 檢查配置文件是否可寫
        if [[ ! -w "$config_file" ]]; then
            log_warn "配置文件無寫入權限：$config_file"
            return 1
        fi
        
        return 0
    }
    
    # 驗證配置文件
    if ! validate_shell_config "$SHELL_CONFIG"; then
        log_warn "配置文件驗證失敗，使用回退方案"
        # 回退到 .profile 作為通用配置
        SHELL_CONFIG="$HOME/.profile"
        validate_shell_config "$SHELL_CONFIG" || {
            error_exit "無法設定任何可用的 shell 配置文件"
        }
    fi
    
    log_info "檢測到的 Shell: $DETECTED_SHELL"
    log_info "Shell 配置文件：$SHELL_CONFIG"
    
    # 檢查是否為 root 用戶
    if [[ $EUID -eq 0 ]]; then
        log_warn "偵測到 root 用戶，建議使用一般用戶執行此腳本"
    fi
}

# 檢查 Windows 版本與 WSL 支援
check_windows_version() {
    local os_build
    if command -v powershell.exe &>/dev/null; then
        os_build=$(powershell.exe -Command "(Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber" 2>/dev/null | tr -d '\r')
        if [[ -z "$os_build" ]]; then
            error_exit "無法取得 Windows 版本資訊"
        fi
        
        if [[ "$os_build" -lt 19041 ]]; then
            error_exit "Windows 版本過低（Build $os_build），WSL 2 需要 Windows 10 Build 19041 或更新版本"
        fi
        
        log_success "Windows 版本檢查通過（Build $os_build）"
    else
        log_warn "無法檢查 Windows 版本，跳過此檢查"
    fi
}

# 檢查虛擬化支援
check_virtualization() {
    log_info "檢查虛擬化支援..."
    
    # 檢查 BIOS 虛擬化
    if command -v powershell.exe &>/dev/null; then
        local vt_enabled
        vt_enabled=$(powershell.exe -Command "Get-ComputerInfo | Select-Object -ExpandProperty HyperVRequirementVirtualizationFirmwareEnabled" 2>/dev/null | tr -d '\r')
        if [[ "$vt_enabled" != "True" ]]; then
            error_exit "BIOS 虛擬化未啟用，請進入 BIOS 設定啟用 VT-x/AMD-V"
        fi
        
        # 檢查 CPU 是否支援 SLAT
        local slat_enabled
        slat_enabled=$(powershell.exe -Command "Get-ComputerInfo | Select-Object -ExpandProperty HyperVRequirementSecondLevelAddressTranslation" 2>/dev/null | tr -d '\r')
        if [[ "$slat_enabled" != "True" ]]; then
            error_exit "CPU 不支援 SLAT（第二層地址轉換），WSL 2 需要較新的 CPU"
        fi
        
        log_success "虛擬化支援檢查通過"
    else
        log_warn "無法檢查虛擬化支援，跳過此檢查"
    fi
}

# 檢查並啟用 Windows 功能
enable_windows_features() {
    log_info "檢查 Windows 功能..."
    
    local features=("Microsoft-Windows-Subsystem-Linux" "VirtualMachinePlatform")
    local needs_reboot=false
    
    if command -v powershell.exe &>/dev/null; then
        for feature in "${features[@]}"; do
            local state
            state=$(powershell.exe -Command "Get-WindowsOptionalFeature -Online -FeatureName $feature | Select-Object -ExpandProperty State" 2>/dev/null | tr -d '\r')
            
            if [[ "$state" != "Enabled" ]]; then
                log_info "啟用 Windows 功能：$feature"
                powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart" || error_exit "無法啟用 $feature"
                needs_reboot=true
            else
                log_success "$feature 已啟用"
            fi
        done
        
        if [[ "$needs_reboot" == "true" ]]; then
            log_warn "Windows 功能已啟用，建議重新啟動後再執行此腳本"
        fi
    else
        log_warn "無法檢查 Windows 功能，跳過此檢查"
    fi
}

# 修復 WSL 常見問題
fix_wsl_issues() {
    log_info "修復 WSL 常見問題..."
    
    if command -v powershell.exe &>/dev/null; then
        # 重新啟動 WSL 服務
        powershell.exe -Command "Restart-Service LxssManager -Force" 2>/dev/null || log_warn "無法重新啟動 LxssManager 服務"
        
        # 清理損壞的 WSL 分發版
        powershell.exe -Command "wsl --shutdown" 2>/dev/null
        
        # 設定 WSL 2 為預設版本
        powershell.exe -Command "wsl --set-default-version 2" 2>/dev/null || log_warn "無法設定 WSL 2 為預設版本"
        
        log_success "WSL 問題修復完成"
    else
        log_warn "無法修復 WSL 問題，跳過此檢查"
    fi
}

# 安裝 WSL 分發版
install_wsl_distro() {
    log_info "檢查 WSL 分發版..."
    
    # 檢查是否已安裝 Ubuntu
    if command -v powershell.exe &>/dev/null; then
        local installed_distros
        installed_distros=$(powershell.exe -Command "wsl --list --quiet" 2>/dev/null | tr -d '\r')
        
        if echo "$installed_distros" | grep -qi ubuntu; then
            log_success "Ubuntu 已安裝"
            return 0
        fi
        
        log_info "安裝 Ubuntu 24.04 LTS..."
        if ! powershell.exe -Command "wsl --install -d Ubuntu-24.04" 2>/dev/null; then
            log_warn "Ubuntu 24.04 安裝失敗，嘗試安裝 Ubuntu 22.04..."
            if ! powershell.exe -Command "wsl --install -d Ubuntu-22.04" 2>/dev/null; then
                error_exit "無法安裝 Ubuntu 分發版"
            fi
        fi
        
        log_success "Ubuntu 安裝完成"
    else
        log_warn "無法安裝 WSL 分發版，跳過此檢查"
    fi
}

# ========== Context7 最佳實踐整合 ==========

# 檢查系統依賴
check_dependencies() {
    log_info "檢查系統依賴..."
    
    local required_tools=("curl" "wget" "git")
    local missing_tools=()
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            missing_tools+=("$tool")
        fi
    done
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log_warn "缺少必要工具：${missing_tools[*]}"
        log_info "正在安裝缺少的工具..."
        
        if command -v apt &>/dev/null; then
            sudo apt update
            sudo apt install -y "${missing_tools[@]}"
        elif command -v yum &>/dev/null; then
            sudo yum install -y "${missing_tools[@]}"
        elif command -v brew &>/dev/null; then
            brew install "${missing_tools[@]}"
        else
            error_exit "無法安裝必要工具，請手動安裝：${missing_tools[*]}"
        fi
    fi
    
    log_success "系統依賴檢查完成"
}

# 網路容錯下載函數
download_with_retry() {
    local url="$1"
    local output_file="${2:-}"
    local max_retries=3
    local retry_delay=2
    local timeout=30
    
    for ((i=1; i<=max_retries; i++)); do
        log_info "嘗試下載 ($i/$max_retries): $url"
        
        if [[ -n "$output_file" ]]; then
            # 下載到指定檔案
            if curl -fsSL --connect-timeout "$timeout" --max-time $((timeout*2)) -o "$output_file" "$url"; then
                log_success "下載成功: $url"
                return 0
            fi
        else
            # 輸出到標準輸出
            if curl -fsSL --connect-timeout "$timeout" --max-time $((timeout*2)) "$url"; then
                log_success "下載成功: $url"
                return 0
            fi
        fi
        
        if [[ $i -lt $max_retries ]]; then
            log_warn "下載失敗，等待 ${retry_delay} 秒後重試..."
            sleep $retry_delay
            retry_delay=$((retry_delay * 2))
        fi
    done
    
    log_error "下載失敗，已達最大重試次數: $url"
    return 1
}

# 網路連線檢查
check_network_connectivity() {
    log_info "檢查網路連線..."
    
    # 檢查基本網路連線（多重備援）
    local dns_servers=("8.8.8.8" "1.1.1.1" "9.9.9.9")
    local network_available=false
    
    for dns in "${dns_servers[@]}"; do
        if ping -c 1 -W 5 "$dns" >/dev/null 2>&1; then
            network_available=true
            break
        fi
    done
    
    if [[ "$network_available" == "false" ]]; then
        error_exit "無法連線到網際網路，請檢查網路設定"
    fi
    
    # 檢查 DNS 解析（多重備援）
    local dns_targets=("raw.githubusercontent.com" "github.com" "nodejs.org")
    local dns_working=false
    
    for target in "${dns_targets[@]}"; do
        if nslookup "$target" >/dev/null 2>&1 || host "$target" >/dev/null 2>&1; then
            dns_working=true
            break
        fi
    done
    
    if [[ "$dns_working" == "false" ]]; then
        log_warn "DNS 解析有問題，可能影響下載速度"
    fi
    
    # 檢查重要網站連線（容錯機制）
    local sites=("github.com" "npmjs.com" "nodejs.org")
    local failed_sites=()
    
    for site in "${sites[@]}"; do
        if ! curl -s --connect-timeout 10 --max-time 20 "https://$site" >/dev/null 2>&1; then
            failed_sites+=("$site")
        fi
    done
    
    if [[ ${#failed_sites[@]} -gt 0 ]]; then
        log_warn "無法連線到以下網站: ${failed_sites[*]}"
        log_warn "這可能影響安裝程序，但腳本將繼續執行"
    fi
    
    log_success "網路連線檢查通過"
}

# 系統資源檢查
check_system_resources() {
    log_info "檢查系統資源..."
    
    # 檢查記憶體
    local mem_total mem_available
    
    if command -v free &>/dev/null; then
        mem_total=$(free -m | awk '/^Mem:/{print $2}')
        mem_available=$(free -m | awk '/^Mem:/{print $7}')
        
        log_info "記憶體總量：${mem_total}MB"
        log_info "可用記憶體：${mem_available}MB"
        
        if [[ $mem_available -lt 512 ]]; then
            log_warn "可用記憶體不足 512MB，可能影響安裝效能"
        fi
    fi
    
    # 檢查 CPU 核心數
    local cpu_cores
    cpu_cores=$(nproc 2>/dev/null || echo "unknown")
    log_info "CPU 核心數：$cpu_cores"
    
    # 檢查 Load Average
    if command -v uptime &>/dev/null; then
        local load_avg
        load_avg=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')
        log_info "系統負載：$load_avg"
        
        # 使用 awk 替代 bc 進行浮點數比較
        if [[ "$cpu_cores" != "unknown" ]]; then
            local high_load
            high_load=$(echo "$load_avg $cpu_cores" | awk '{print ($1 > $2)}')
            if [[ "$high_load" == "1" ]]; then
                log_warn "系統負載過高，可能影響安裝效能"
            fi
        fi
    fi
}

# 檢查磁碟空間
check_disk_space() {
    local free_space free_bytes
    
    if command -v df &>/dev/null; then
        free_space=$(df -h ~ | awk 'NR==2 {print $4}')
        free_bytes=$(df ~ | awk 'NR==2 {print $4}')
        
        log_info "家目錄剩餘空間：$free_space"
        
        # 檢查是否有足夠空間（至少 1GB）
        if [[ $free_bytes -lt 1048576 ]]; then
            error_exit "磁碟空間不足（剩餘：$free_space），需要至少 1GB 空間"
        fi
        
        # 檢查其他重要目錄空間
        local tmp_space
        tmp_space=$(df -h /tmp | awk 'NR==2 {print $4}')
        log_info "臨時目錄空間：$tmp_space"
        
        # 檢查 WSL 磁碟使用量（如果在 WSL 環境）
        if [[ -n "${WSL_MODE:-}" ]]; then
            local wsl_usage
            wsl_usage=$(df -h /mnt/c 2>/dev/null | awk 'NR==2 {print $5}' | tr -d '%' || echo "0")
            if [[ $wsl_usage -gt 90 ]]; then
                log_warn "Windows C: 磁碟使用率 ${wsl_usage}%，可能影響 WSL 效能"
            fi
        fi
    fi
}

# 安裝系統依賴
install_system_dependencies() {
    log_info "更新系統與安裝必要工具..."
    
    if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
        # macOS 使用 Homebrew 安裝依賴
        if ! command -v brew &>/dev/null; then
            log_info "安裝 Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        # 更新 Homebrew 並安裝必要工具
        brew update
        brew install curl git ripgrep
        
        # 確保 Xcode Command Line Tools 已安裝
        if ! xcode-select -p &>/dev/null; then
            log_info "安裝 Xcode Command Line Tools..."
            xcode-select --install
        fi
        
    else
        # Linux/WSL 使用 apt 安裝依賴
        if ! sudo apt update; then
            error_exit "無法更新軟體包列表"
        fi
        
        # 安裝必要工具
        local packages="curl git build-essential python3 python3-pip ripgrep ca-certificates gnupg lsb-release"
        if ! sudo apt install -y "$packages"; then
            error_exit "無法安裝必要工具"
        fi
    fi
    
    log_success "系統依賴安裝完成"
}

# 修復 npm 配置污染
fix_npm_config() {
    log_info "檢查 npm 配置和與 nvm 的兼容性..."

    # 確保所有變數都被初始化以避免 set -u 錯誤
    local npmrc_file="$HOME/.npmrc"
    local cleanup_needed=false
    local backup_created=false

    # ---- Phase 1: scrub ~/.npmrc if present ---------------------------------
    if [[ -f "$npmrc_file" ]]; then
        # 只在第一次需要清理時備份
        if grep -q -E "(^prefix=|^globalconfig=)" "$npmrc_file" 2>/dev/null || grep -q "/mnt/c/" "$npmrc_file" 2>/dev/null; then
            cp "$npmrc_file" "$npmrc_file.backup.$(date +%Y%m%d_%H%M%S)" || log_warn "無法備份 .npmrc"
            backup_created=true
        fi

        # 移除 prefix / globalconfig / Windows 路徑污染（macOS sed 語法不同）
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' -e '/^prefix=/d' -e '/^globalconfig=/d' "$npmrc_file" 2>/dev/null || true
        else
            sed -i -e '/^prefix=/d' -e '/^globalconfig=/d' "$npmrc_file" 2>/dev/null || true
        fi

        # 過濾掉任何 /mnt/c/ 行（避免 WSL 殘留）
        if grep -q "/mnt/c/" "$npmrc_file" 2>/dev/null; then
            # 用暫存檔過濾，避免 sed 多平台字元問題
            grep -v "/mnt/c/" "$npmrc_file" > "$npmrc_file.tmp" && mv "$npmrc_file.tmp" "$npmrc_file"
        fi

        cleanup_needed=true
    fi

    if [[ "$cleanup_needed" == "true" ]]; then
        log_success "npm 配置清理完成"
        if [[ "$backup_created" == "true" ]]; then
            log_info "原始配置已備份到 $npmrc_file.backup.*"
        fi
    else
        log_success "npm 配置檢查通過，無需清理"
    fi

    # ---- Phase 2: inspect effective npm config (prefix / globalconfig) ------
    local npm_prefix="" npm_globalconfig=""

    if command -v npm &>/dev/null; then
        # 使用 command substitution；若 npm 報錯，保留空字串
        npm_prefix="$(npm config get prefix 2>/dev/null || true)"
        npm_globalconfig="$(npm config get globalconfig 2>/dev/null || true)"

        # 有些 npm 版本若值未設，可能回傳 'undefined' 或 'global'
        [[ "$npm_prefix" == "undefined" ]] && npm_prefix=""
        [[ "$npm_globalconfig" == "undefined" ]] && npm_globalconfig=""

        # 檢查並清理 npm prefix 配置
        if [[ -n "${npm_prefix}" ]] && [[ "${npm_prefix}" != *".nvm"* ]] && [[ "${npm_prefix}" != *".npm-global"* ]]; then
            log_warn "偵測到全域 npm prefix 配置與 nvm 衝突（${npm_prefix}）"
            log_info "正在清理全域 npm prefix 配置..."
            npm config delete prefix 2>/dev/null || true
            log_success "全域 npm prefix 配置已清理"
        fi

        # 檢查並清理 globalconfig 配置
        if [[ -n "${npm_globalconfig}" ]]; then
            log_warn "偵測到全域 npm globalconfig 配置與 nvm 衝突（${npm_globalconfig}）"
            log_info "正在清理全域 npm globalconfig 配置..."
            npm config delete globalconfig 2>/dev/null || true
            log_success "全域 npm globalconfig 配置已清理"
        fi

        # macOS 額外：有些舊安裝會殘留 prefix= 行
        if [[ "${SYSTEM_TYPE:-}" == "macos" && -f "$HOME/.npmrc" ]]; then
            if grep -q "^prefix=" "$HOME/.npmrc" 2>/dev/null; then
                log_warn "偵測到 ~/.npmrc 中的 prefix 設定，將自動清理"
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i '' '/^prefix=/d' "$HOME/.npmrc"
                else
                    sed -i '/^prefix=/d' "$HOME/.npmrc"
                fi
                log_success "已清理 ~/.npmrc 中的 prefix 設定"
            fi
        fi

        log_success "npm 配置檢查通過"
    else
        log_warn "npm 指令不存在，略過 npm 配置檢查"
    fi
}

# 安裝 Node Version Manager
install_nvm() {
    log_info "檢查 Node Version Manager..."
    
    # 檢查 nvm 是否已安裝
    export NVM_DIR="$HOME/.nvm"
    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        # shellcheck source=/dev/null
        source "$NVM_DIR/nvm.sh"
        if command -v nvm &>/dev/null; then
            local current_version
            current_version=$(nvm --version)
            log_success "nvm 已安裝（版本：$current_version）"
            
            # 檢查是否需要升級
            if [[ "$current_version" < "${NVM_VERSION#v}" ]]; then
                log_warn "nvm 版本 $current_version 較舊，建議升級到 $NVM_VERSION"
                local should_upgrade=false
                if [[ "${FAST_MODE:-}" == "true" ]]; then
                    log_info "快速模式：自動升級 nvm"
                    should_upgrade=true
                else
                    if interactive_prompt "是否要升級 nvm？" "y"; then
                        should_upgrade=true
                    fi
                fi
                
                if [[ "$should_upgrade" == "true" ]]; then
                    install_nvm_fresh
                else
                    log_info "跳過 nvm 升級，繼續使用版本 $current_version"
                fi
            else
                log_success "nvm 版本已是最新（$current_version）"
            fi
            return 0
        fi
    fi
    
    install_nvm_fresh
}

install_nvm_fresh() {
    log_info "安裝 nvm $NVM_VERSION（最新穩定版）..."
    
    # 下載並安裝 nvm（2025 最新版本）
    local nvm_install_url="https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh"
    log_info "下載 NVM 安裝腳本..."
    
    # 使用容錯下載機制
    if command -v curl &>/dev/null; then
        if download_with_retry "$nvm_install_url" | bash; then
            log_success "NVM 安裝腳本執行成功"
        else
            error_exit "NVM 安裝腳本下載或執行失敗"
        fi
    elif command -v wget &>/dev/null; then
        # wget 備用方案
        if wget -qO- "$nvm_install_url" | bash; then
            log_success "NVM 安裝腳本執行成功"
        else
            error_exit "NVM 安裝腳本下載或執行失敗"
        fi
    else
        error_exit "需要 curl 或 wget 來下載 NVM"
    fi
    
    # 重新載入 nvm
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # 確保 nvm 載入於 shell 配置（2025 最佳實踐）
    configure_nvm_profile
    
    log_success "nvm $NVM_VERSION 安裝完成"
}

# 配置 NVM 最佳實踐到 shell profile
configure_nvm_profile() {
    log_info "配置 NVM 最佳實踐到 shell profile..."
    
    # 配置文件已在 validate_shell_config 函數中驗證和創建
    
    # 根據不同 shell 類型生成對應的配置
    local nvm_config=""
    case "${DETECTED_SHELL:-bash}" in
        fish)
            # Fish shell 使用不同的語法
            nvm_config="
# NVM Configuration (2025 Best Practices)
if test -d \"\$HOME/.nvm\"
    set -x NVM_DIR \"\$HOME/.nvm\"
    # This loads nvm
    if test -s \"\$NVM_DIR/nvm.sh\"
        bass source \"\$NVM_DIR/nvm.sh\"
    end
end"
            ;;
        *)
            # Bash/Zsh 兼容語法
            nvm_config="
# NVM Configuration (2025 Best Practices)
if [ -d \"\$HOME/.nvm\" ]; then
    export NVM_DIR=\"\$HOME/.nvm\"
    # This loads nvm
    [ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"
    # This loads nvm bash_completion
    [ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\"
fi"
            ;;
    esac
    
    # 檢查是否已配置
    if ! grep -q 'NVM Configuration' "${SHELL_CONFIG:-$HOME/.bashrc}" 2>/dev/null; then
        # 移除舊的配置
        if grep -q 'nvm.sh\|NVM_DIR' "${SHELL_CONFIG:-$HOME/.bashrc}" 2>/dev/null; then
            log_warn "發現舊的 nvm 配置，將更新為最佳實踐版本"
            # 使用兼容的 sed 語法
            if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
                sed -i '' '/export NVM_DIR/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '' '/nvm\.sh/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '' '/bash_completion/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '' '/set -x NVM_DIR/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '' '/bass source/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
            else
                sed -i '/export NVM_DIR/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '/nvm\.sh/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '/bash_completion/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '/set -x NVM_DIR/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
                sed -i '/bass source/d' "${SHELL_CONFIG:-$HOME/.bashrc}"
            fi
        fi
        
        echo "$nvm_config" >> "${SHELL_CONFIG:-$HOME/.bashrc}"
        log_success "NVM 最佳實踐配置已添加到 ${SHELL_CONFIG:-$HOME/.bashrc}"
    else
        log_success "NVM 配置已存在"
    fi
}

# 安裝 Node.js
install_nodejs() {
    log_info "檢查 Node.js 安裝狀況..."
    
    # 確保 nvm 可用
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    if ! command -v nvm &>/dev/null; then
        error_exit "nvm 未正確安裝"
    fi
    
    # 檢查目標版本是否已安裝
    if nvm list | grep -q "v$NODE_TARGET_VERSION"; then
        log_success "Node.js $NODE_TARGET_VERSION 已安裝"
        switch_to_target_version
    else
        install_nodejs_fresh
    fi
    
    verify_nodejs_installation
}

install_nodejs_fresh() {
    log_info "安裝 Node.js $NODE_TARGET_VERSION (LTS Jod)..."
    
    if ! nvm install "$NODE_TARGET_VERSION"; then
        log_warn "Node.js $NODE_TARGET_VERSION 安裝失敗，嘗試安裝備用版本 $NODE_FALLBACK_VERSION"
        if ! nvm install "$NODE_FALLBACK_VERSION"; then
                error_exit "Node.js 安裝失敗（主要和備用版本都失敗）"
            fi
        NODE_TARGET_VERSION=$NODE_FALLBACK_VERSION
    fi
    
    switch_to_target_version
}

switch_to_target_version() {
    local current_version
    current_version=$(nvm current | sed 's/v//')
    
    if [[ "$current_version" == "$NODE_TARGET_VERSION" ]]; then
        log_success "當前已使用 Node.js $NODE_TARGET_VERSION"
    else
        log_info "切換到 Node.js $NODE_TARGET_VERSION..."
        
        # 清理可能的 npm 配置衝突
        if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
            # 在 macOS 上使用 --delete-prefix 標誌
            if nvm use --delete-prefix "$NODE_TARGET_VERSION" 2>/dev/null; then
                log_info "已清理 npm prefix 並切換到 Node.js $NODE_TARGET_VERSION"
            else
                # 如果失敗，嘗試不使用 --delete-prefix
                nvm use "$NODE_TARGET_VERSION"
            fi
        else
            nvm use "$NODE_TARGET_VERSION"
        fi
        
        nvm alias default "$NODE_TARGET_VERSION"
        log_success "已切換到 Node.js $NODE_TARGET_VERSION"
    fi
}

verify_nodejs_installation() {
    log_info "驗證 Node.js 安裝..."
    
    local node_version major_version
    node_version=$(node -v | sed 's/v//')
    major_version=$(echo "$node_version" | cut -d. -f1)
    
    if [[ $major_version -lt 18 ]]; then
        error_exit "Node.js 版本過低（$node_version），需要 >= 18.0.0"
    fi
    
    log_success "Node.js 版本驗證通過（v$node_version）"
}

# 檢查 Node.js 環境
verify_nodejs_environment() {
    log_info "驗證 Node.js 環境..."
    
    # 檢查 node/npm 路徑
    local node_path npm_path
    node_path=$(which node 2>/dev/null || echo "")
    npm_path=$(which npm 2>/dev/null || echo "")
    
    if [[ -z "$node_path" || -z "$npm_path" ]]; then
        error_exit "Node.js 或 npm 未正確安裝"
    fi
    
    # 檢查是否指向 Windows 路徑
    if [[ "$node_path" == /mnt/c/* || "$npm_path" == /mnt/c/* ]]; then
        error_exit "node/npm 指向 Windows 路徑，請移除 Windows node/npm 並重新安裝"
    fi
    
    # 檢查版本
    local node_version npm_version
    node_version=$(node -v 2>/dev/null || echo "unknown")
    npm_version=$(npm -v 2>/dev/null || echo "unknown")
    
    log_info "Node.js 路徑：$node_path"
    log_info "Node.js 版本：$node_version"
    log_info "npm 路徑：$npm_path"
    log_info "npm 版本：$npm_version"
    
    log_success "Node.js 環境驗證通過"
}

# 配置 npm 全域安裝目錄（智能檢測模式）
configure_npm_global() {
    log_info "檢查 npm 全域配置狀況..."
    
    # 檢查是否使用 nvm 管理的 node
    local node_path
    node_path=$(which node 2>/dev/null || echo "")
    if [[ "$node_path" == *".nvm"* ]]; then
        log_success "偵測到 nvm 管理的 Node.js（$node_path）"
        
        # 清理可能的 prefix 設置以避免衝突
        if command -v npm &>/dev/null; then
            local current_prefix
            current_prefix=$(npm config get prefix 2>/dev/null || echo "")
            if [[ -n "$current_prefix" && "$current_prefix" != *".nvm"* ]]; then
                log_warn "清理不兼容的 npm prefix 設置（$current_prefix）"
                npm config delete prefix 2>/dev/null || true
            fi
            
            # 設定 npm 安全和效能配置（根據 Context7 最佳實踐）
            npm config set fund false 2>/dev/null || true
            npm config set audit false 2>/dev/null || true
            npm config set update-notifier false 2>/dev/null || true
            npm config set strict-ssl true 2>/dev/null || true
            npm config set audit-level high 2>/dev/null || true
            
            # 針對 macOS 設定特定優化
            if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
                npm config set os darwin 2>/dev/null || true
            fi
        fi
        
        log_success "npm 配置優化完成（nvm 模式）"
        return 0
    fi
    
    # 非 nvm 環境下的傳統配置
    log_warn "未偵測到 nvm 環境，使用傳統 npm 全域配置"
    
    # 檢查是否已經配置過
    local global_dir="$HOME/.npm-global"
    local current_prefix
    current_prefix=$(npm config get prefix 2>/dev/null || echo "")
    
    if [[ "$current_prefix" == "$global_dir" ]]; then
        log_success "npm 全域配置已存在（$global_dir）"
        return 0
    fi
    
    log_info "配置 npm 全域安裝目錄..."
    
    # 創建全域安裝目錄
    mkdir -p "$global_dir"
    
    # 設定 npm 安全和效能配置（根據 Context7 最佳實踐）
    if command -v npm &>/dev/null; then
        npm config set prefix "$global_dir"
        
        # 根據系統類型設定 npm 配置
        if [[ "${SYSTEM_TYPE:-}" == "macos" ]]; then
            npm config set os darwin
        else
            npm config set os linux
        fi
        
        npm config set fund false
        npm config set audit false
        npm config set update-notifier false
        npm config set strict-ssl true
        npm config set audit-level high
    fi
    
    # 更新 PATH
    if [[ -n "${SHELL_CONFIG:-}" ]] && ! grep -q "$global_dir/bin" "${SHELL_CONFIG:-}"; then
        echo "export PATH=\$HOME/.npm-global/bin:\$PATH" >> "${SHELL_CONFIG:-}"
        log_info "已將 $global_dir/bin 添加到 PATH"
    fi
    
    # 重新載入 PATH
    export PATH="$global_dir/bin:$PATH"
    
    log_success "npm 全域安裝目錄配置完成"
}

# 安裝 Claude Code CLI
install_claude_code() {
    log_info "檢查 Claude Code CLI 安裝狀況..."
    
    # 檢查是否已安裝
    if command -v claude &>/dev/null; then
        local claude_version
        claude_version=$(claude --version 2>/dev/null | head -1 || echo "unknown")
        log_success "Claude Code CLI 已安裝（版本：$claude_version）"
        
        # 檢查是否需要更新
        local should_reinstall=false
        if [[ "${FAST_MODE:-}" == "true" ]]; then
            log_info "快速模式：自動重新安裝最新版本"
            should_reinstall=true
        else
            if interactive_prompt "是否要重新安裝最新版本？" "N"; then
                should_reinstall=true
            fi
        fi
        
        if [[ "$should_reinstall" == "true" ]]; then
            install_claude_code_fresh
        else
            log_info "跳過 Claude Code CLI 重新安裝"
        fi
    else
        install_claude_code_fresh
    fi
}

install_claude_code_fresh() {
    log_info "安裝 Claude Code CLI..."
    
    # 清理舊版本（如果存在）
    if command -v claude &>/dev/null; then
        log_info "清理舊版本..."
        npm uninstall -g "$CLAUDE_PACKAGE" 2>/dev/null || true
    fi
    
    # 安裝 Claude Code
    if ! npm install -g "$CLAUDE_PACKAGE" --force; then
        error_exit "Claude Code CLI 安裝失敗"
    fi
    
    log_success "Claude Code CLI 安裝完成"
}

# 驗證 Claude Code 安裝
verify_claude_installation() {
    log_info "驗證 Claude Code 安裝..."
    
    # 重新載入 PATH
    export PATH="$HOME/.npm-global/bin:$PATH"
    
    # 檢查 claude 指令
    local claude_path
    claude_path=$(which claude 2>/dev/null || echo "")
    if [[ -z "$claude_path" ]]; then
        error_exit "Claude Code 未正確安裝或未在 PATH 中"
    fi
    
    log_info "Claude Code 路徑：$claude_path"
    
    # 測試 Claude Code 功能
    if ! claude --help >/dev/null 2>&1; then
        error_exit "Claude Code CLI 無法正常運行"
    fi
    
    log_success "Claude Code 驗證通過"
}

# 最終系統檢查
final_system_check() {
    log_info "執行最終系統檢查..."
    
    # 檢查所有必要指令
    local commands=("node" "npm" "claude" "git" "curl")
    local missing_commands=()
    
    for cmd in "${commands[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            missing_commands+=("$cmd")
        fi
    done
    
    if [[ ${#missing_commands[@]} -gt 0 ]]; then
        error_exit "缺少必要指令：${missing_commands[*]}"
    fi
    
    # 驗證 Node.js 版本符合項目需求
    local node_version major_version
    
    node_version=$(node -v | sed 's/v//')
    major_version=$(echo "$node_version" | cut -d. -f1)
    
    if [[ $major_version -lt 18 ]]; then
        log_warn "Node.js 版本 $node_version 不符合項目需求（>=18.0.0）"
    else
        log_success "Node.js 版本符合項目需求（v$node_version >= 18.0.0）"
    fi
    
    # 檢查 npm 與 nvm 的兼容性
    local npm_prefix node_path
    
    if command -v npm &>/dev/null; then
        npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
        node_path=$(which node 2>/dev/null || echo "")
        
        if [[ "$node_path" == *".nvm"* ]]; then
            if [[ "$npm_prefix" == *".nvm"* ]]; then
                log_success "npm 與 nvm 兼容性檢查通過"
            else
                log_warn "npm prefix 設置可能與 nvm 不兼容（$npm_prefix）"
            fi
        fi
    fi
    
    # 顯示版本資訊
    log_info "=== 安裝完成摘要 ==="
    echo "Node.js: $(node -v)"
    echo "npm: $(npm -v)"
    echo "Claude Code: $(claude --version 2>/dev/null || echo 'installed')"
    echo "Git: $(git --version)"
    echo "nvm: $(nvm --version 2>/dev/null || echo 'not available')"
    echo "系統: ${SYSTEM_TYPE:-unknown} (${ARCH:-unknown})"
    echo "Shell: ${SHELL_TYPE:-unknown}"
    echo "配置文件: ${SHELL_CONFIG:-unknown}"
    echo "完整日誌: $LOG_FILE"
    
    log_success "所有檢查通過！"
}

# ========== Windows 端偵測（僅於 Windows PowerShell 管理員下有效） ==========
# 修正邏輯：檢查是否在 Windows 原生環境且非 WSL
check_windows_admin() {
  # 檢查管理員權限
  if command -v powershell.exe &>/dev/null; then
      local is_admin
      is_admin=$(powershell.exe -Command "[Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent() | Select-Object -ExpandProperty IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')" 2>/dev/null | grep -q True && echo "true" || echo "false")
      if [[ "$is_admin" != "true" ]]; then
          error_exit "需要管理員權限執行此腳本"
      fi
  fi
}

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || -n "${WINDIR:-}" ]] && [[ -z "${WSL_DISTRO_NAME:-}" ]]; then
  log_info "Windows 原生環境偵測，開始 WSL 2 安裝程序"
  
  check_windows_admin
  
  # 系統檢查
  check_windows_version
  check_virtualization
  enable_windows_features
  fix_wsl_issues
  install_wsl_distro
  
  log_info "WSL 2 安裝完成！請重啟電腦後進入 WSL 環境重新執行本腳本"
  exit 0
fi

# ========== Linux/WSL/macOS 端自動化安裝與修復 ==========

# ========== 效能優化與使用者體驗改進 ==========

# 進度條顯示函數
show_progress() {
    local current=$1
    local total=$2
    local message="$3"
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    
    printf "\r%s[PROGRESS]%s %s " "${CYAN}" "${NC}" "$message"
    printf "%s[" "${GREEN}"
    printf "%*s" $filled | tr ' ' '='
    printf "%*s" $empty | tr ' ' '-'
    printf "]%s %d%%" "${NC}" $percentage
    
    if [[ $current -eq $total ]]; then
        echo
    fi
}

# 時間統計函數
start_timer() {
    START_TIME=$(date +%s)
}

end_timer() {
    local end_time
    end_time=$(date +%s)
    local duration=$((end_time - START_TIME))
    local minutes=$((duration / 60))
    local seconds=$((duration % 60))
    
    if [[ $minutes -gt 0 ]]; then
        log_info "執行時間：${minutes}分${seconds}秒"
    else
        log_info "執行時間：${seconds}秒"
    fi
}

# 快速模式檢查
check_fast_mode() {
    # 可接受 0..N 引數，掃描是否包含 --fast 或 -f，以避免在 set -u (nounset) 下展開未定義位置參數
    local arg
    for arg in "$@"; do
        if [[ "$arg" == "--fast" || "$arg" == "-f" ]]; then
            export FAST_MODE=true
            log_info "啟用快速模式，將跳過非必要檢查"
            return 0
        fi
    done
    return 0  # 修正：改為 return 0，避免在主流程中觸發 set -e
}

# 優化的檢測函數（加入進度顯示）
check_system_environment() {
    log_info "檢測系統環境污染..."
    show_progress 1 4 "檢查 PATH 污染"
    
    local has_pollution=false
    
    # 檢查 PATH 中的 Windows 路徑（WSL 環境）
    if [[ -n "${WSL_MODE:-}" ]]; then
        if echo "$PATH" | grep -q "/mnt/c/"; then
            log_warn "偵測到 PATH 中的 Windows 路徑污染"
            has_pollution=true
        fi
    fi
    
    show_progress 2 4 "檢查 Node.js 安裝"
    
    # 檢查多個 Node.js 安裝（去重複）
    local node_paths=()
    if command -v which &>/dev/null; then
        # 使用 while read 循環替代 mapfile 以提高兼容性
        while IFS= read -r line; do
            [[ -n "$line" ]] && node_paths+=("$line")
        done < <(which -a node 2>/dev/null | sort -u)
    fi
    if [[ ${#node_paths[@]} -gt 1 ]]; then
        log_warn "偵測到多個 Node.js 安裝："
        for path in "${node_paths[@]}"; do
            echo "  - $path"
        done
        has_pollution=true
    fi
    
    show_progress 3 4 "檢查 npm 安裝"
    
    # 檢查多個 npm 安裝（去重複）
    local npm_paths=()
    if command -v which &>/dev/null; then
        # 使用 while read 循環替代 mapfile 以提高兼容性
        while IFS= read -r line; do
            [[ -n "$line" ]] && npm_paths+=("$line")
        done < <(which -a npm 2>/dev/null | sort -u)
    fi
    if [[ ${#npm_paths[@]} -gt 1 ]]; then
        log_warn "偵測到多個 npm 安裝："
        for path in "${npm_paths[@]}"; do
            echo "  - $path"
        done
        has_pollution=true
    fi
    
    show_progress 4 4 "完成環境檢測"
    
    if [[ "$has_pollution" == "true" ]]; then
        log_error "偵測到系統環境污染"
        if interactive_prompt "是否要清理系統環境污染？"; then
            clean_system_environment
        else
            log_warn "跳過環境清理，可能影響系統穩定性"
        fi
    else
        log_success "系統環境檢查通過"
    fi
}

# 優化的主要檢測與修復流程
main_diagnostic_and_repair() {
    log_info "=== 開始智能檢測與修復流程 ==="
    start_timer
    
    local total_steps=6
    local current_step=0
    
    # Bash 版本檢測與升級
    ((current_step++))
    echo -e "${CYAN}[步驟 $current_step/$total_steps]${NC} Bash 版本檢測與升級"
    check_and_upgrade_bash
    
    # 系統環境檢測
    ((current_step++))
    echo -e "${CYAN}[步驟 $current_step/$total_steps]${NC} 系統環境檢測"
    check_system_environment
    
    # npm 權限檢測
    ((current_step++))
    echo -e "${CYAN}[步驟 $current_step/$total_steps]${NC} npm 權限檢測"
    check_npm_permissions
    
    # nvm 與 npm 衝突檢測
    ((current_step++))
    echo -e "${CYAN}[步驟 $current_step/$total_steps]${NC} nvm 與 npm 衝突檢測"
    check_nvm_npm_conflicts
    
    # claude code CLI 狀態檢測
    ((current_step++))
    echo -e "${CYAN}[步驟 $current_step/$total_steps]${NC} claude code CLI 狀態檢測"
    check_claude_cli_status
    
    # 套用安全最佳實踐
    ((current_step++))
    echo -e "${CYAN}[步驟 $current_step/$total_steps]${NC} 安全設定最佳實踐"
    if interactive_prompt "是否要套用 npm 安全設定最佳實踐？" "Y"; then
        apply_security_best_practices
    fi
    
    end_timer
    log_success "智能檢測與修復流程完成"
}

# 加入暫停功能
pause_if_needed() {
    if [[ "${FAST_MODE:-}" != "true" ]]; then
        echo -e "${BLUE}按任意鍵繼續...${NC}"
        read -r -n 1 -s
    fi
}

# 優化錯誤處理
# 更防炸、避免未定義參數、且避開與 shell built-in `command` 混淆
handle_error() {
    # 使用具預設值的參數展開，避免在 set -u (nounset) 下爆炸
    local exit_code="${1:-1}"
    local failed_cmd="${2:-<unknown>}"
    local line_number="${3:-?}"

    log_error "指令執行失敗：${failed_cmd}（第 ${line_number} 行，退出碼：${exit_code}）"

    if [[ "${FAST_MODE:-}" != "true" ]]; then
        if interactive_prompt "是否要繼續執行？"; then
            return 0
        else
            log_error "使用者選擇中止執行"
            exit "${exit_code}"
        fi
    else
        log_warn "快速模式：自動繼續執行"
        return 0
    fi
}

# 設定錯誤處理
set -E
trap 'handle_error "$?" "${BASH_COMMAND:-<unknown>}" "${LINENO:-0}"' ERR

# 優化的彩色輸出
print_header() {
    local title="$1"
    local width=60
    local padding=$(((width - ${#title}) / 2))
    
    echo -e "${CYAN}$(printf '=%.0s' $(seq 1 $width))${NC}"
    echo -e "${CYAN}$(printf ' %.0s' $(seq 1 $padding))${YELLOW}$title${CYAN}$(printf ' %.0s' $(seq 1 $padding))${NC}"
    echo -e "${CYAN}$(printf '=%.0s' $(seq 1 $width))${NC}"
}

# 優化的主安裝流程函數
main_installation() {
    # 檢查快速模式
    check_fast_mode "$@"
    
    print_header "Claude Code 自動安裝工具 v$SCRIPT_VERSION"
    echo -e "${GREEN}整合 Context7 最佳實踐優化${NC}"
    echo -e "${GREEN}智能檢測與互動式修復${NC}"
    echo -e "${GREEN}Bash 版本檢測與升級功能${NC}"
    if [[ "${FAST_MODE:-}" == "true" ]]; then
        echo -e "${YELLOW}🚀 快速模式已啟用${NC}"
    fi
    echo
    
    log_info "=== 開始 Claude Code 安裝流程 ==="
    
    # 偵測作業系統環境
    detect_os
    
    log_info "開始自動化安裝與修復程序（${SYSTEM_TYPE:-未知} 環境）"
    
    # 智能檢測與修復
    main_diagnostic_and_repair
    
    # 如果是快速模式，跳過某些非必要檢查
    if [[ "${FAST_MODE:-}" != "true" ]]; then
        pause_if_needed
        # 系統檢查階段
        check_dependencies
        check_disk_space
        check_network_connectivity
        check_system_resources
    else
        log_info "快速模式：跳過詳細系統檢查"
    fi
    
    # 基本系統安裝
    install_system_dependencies
    
    # npm 配置和 nvm 安裝
    fix_npm_config
    install_nvm
    
    # Node.js 安裝和配置
    install_nodejs
    verify_nodejs_environment
    configure_npm_global
    
    # Claude Code 安裝
    install_claude_code
    verify_claude_installation
    
    # 最終檢查
    final_system_check
    
    print_header "安裝完成"
    log_success "Claude Code 安裝流程完成！"
}

# 執行主安裝流程
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_installation "$@"
    
    echo
    log_info "=== 後續步驟 ==="
    echo "  1. 重新載入終端或執行: source ${SHELL_CONFIG:-~/.bashrc}"
    echo "  2. 進入專案目錄並執行: claude"
    echo "  3. 查看所有指令: claude --help"
    echo ""
    log_info "=== 說明文件 ==="
    echo "  • README.md - 完整使用指南"
    echo "  • docs/ - 詳細文件目錄"
    echo ""
    log_info "=== 快速模式 ==="
    echo "  • 使用 ./start.sh --fast 啟用快速模式"
    echo "  • 快速模式會跳過互動提示和非必要檢查"
    echo ""
    log_info "🔧 如遇問題，請檢查日誌：$LOG_FILE"
fi