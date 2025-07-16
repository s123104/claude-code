#!/bin/bash
set -e

# ========== Claude Code 自動化安裝與啟動腳本 ==========
# 版本: 3.3.0 (整合 Context7 最佳實踐)
# 支援: Windows WSL2 + Linux + macOS 環境自動偵測與安裝
# 新增: 智能檢測、安全跳過、現有安裝保護、Context7 最佳實踐
# 作者: Claude Code 中文社群
# 更新: 2025-01-14

# ========== 配置參數 ==========
SCRIPT_VERSION="3.3.0"
NVM_VERSION="v0.40.3"
NODE_TARGET_VERSION="22.17.1"    # LTS Jod
NODE_FALLBACK_VERSION="18.20.8"  # LTS Hydrogen
CLAUDE_PACKAGE="@anthropic-ai/claude-code"

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

# 首先檢查作業系統環境
detect_os() {
    log_info "正在偵測作業系統環境..."
    
    # 檢查是否在 Windows 原生環境執行
    if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]] || [[ -n "$WINDIR" ]]; then
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
    if ! grep -qi microsoft /proc/version 2>/dev/null; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            SYSTEM_TYPE="macos"
            log_success "偵測到 macOS 環境"
        else
            SYSTEM_TYPE="linux"
            log_warn "未偵測到 WSL 環境，將以純 Linux 模式執行"
        fi
        export LINUX_MODE=true
        
        # 檢查 Linux 發行版
        if [[ -f /etc/os-release ]]; then
            source /etc/os-release
            log_info "Linux 發行版: $NAME $VERSION"
        else
            log_warn "無法識別 Linux 發行版，可能會遇到相容性問題"
        fi
    else
        SYSTEM_TYPE="wsl"
        log_success "WSL 環境偵測成功，開始安裝程序"
        export WSL_MODE=true
        
        # 檢查 WSL 版本
        local wsl_version=$(wsl.exe --version 2>/dev/null | head -1)
        if [[ -n "$wsl_version" ]]; then
            log_info "WSL 版本: $wsl_version"
        fi
    fi
    
    # 檢查系統架構
    ARCH=$(uname -m)
    log_info "系統架構: $ARCH"
    
    # 檢查 Shell 類型
    SHELL_TYPE=$(basename "$SHELL")
    log_info "Shell 類型: $SHELL_TYPE"
    
    # 設定 Shell 配置文件
    if [[ "$SHELL_TYPE" == "zsh" ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
    
    log_info "Shell 配置文件：$SHELL_CONFIG"
    
    # 檢查是否為 root 用戶
    if [[ $EUID -eq 0 ]]; then
        log_warn "偵測到 root 用戶，建議使用一般用戶執行此腳本"
    fi
}

# 檢查指令是否存在
check_command() {
    if ! command -v "$1" &>/dev/null; then
        error_exit "找不到指令：$1"
    fi
}

# 檢查 Windows 版本與 WSL 支援
check_windows_version() {
    local os_build=$(powershell.exe -Command "(Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber" 2>/dev/null | tr -d '\r')
    if [[ -z "$os_build" ]]; then
        error_exit "無法取得 Windows 版本資訊"
    fi
    
    if [[ "$os_build" -lt 19041 ]]; then
        error_exit "Windows 版本過低（Build $os_build），WSL 2 需要 Windows 10 Build 19041 或更新版本"
    fi
    
    log_success "Windows 版本檢查通過（Build $os_build）"
}

# 檢查虛擬化支援
check_virtualization() {
    log_info "檢查虛擬化支援..."
    
    # 檢查 BIOS 虛擬化
    local vt_enabled=$(powershell.exe -Command "Get-ComputerInfo | Select-Object -ExpandProperty HyperVRequirementVirtualizationFirmwareEnabled" 2>/dev/null | tr -d '\r')
    if [[ "$vt_enabled" != "True" ]]; then
        error_exit "BIOS 虛擬化未啟用，請進入 BIOS 設定啟用 VT-x/AMD-V"
    fi
    
    # 檢查 CPU 是否支援 SLAT
    local slat_enabled=$(powershell.exe -Command "Get-ComputerInfo | Select-Object -ExpandProperty HyperVRequirementSecondLevelAddressTranslation" 2>/dev/null | tr -d '\r')
    if [[ "$slat_enabled" != "True" ]]; then
        error_exit "CPU 不支援 SLAT（第二層地址轉換），WSL 2 需要較新的 CPU"
    fi
    
    log_success "虛擬化支援檢查通過"
}

# 檢查並啟用 Windows 功能
enable_windows_features() {
    log_info "檢查 Windows 功能..."
    
    local features=("Microsoft-Windows-Subsystem-Linux" "VirtualMachinePlatform")
    local needs_reboot=false
    
    for feature in "${features[@]}"; do
        local state=$(powershell.exe -Command "Get-WindowsOptionalFeature -Online -FeatureName $feature | Select-Object -ExpandProperty State" 2>/dev/null | tr -d '\r')
        
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
}

# 修復 WSL 常見問題
fix_wsl_issues() {
    log_info "修復 WSL 常見問題..."
    
    # 重新啟動 WSL 服務
    powershell.exe -Command "Restart-Service LxssManager -Force" 2>/dev/null || log_warn "無法重新啟動 LxssManager 服務"
    
    # 清理損壞的 WSL 分發版
    powershell.exe -Command "wsl --shutdown" 2>/dev/null
    
    # 設定 WSL 2 為預設版本
    powershell.exe -Command "wsl --set-default-version 2" 2>/dev/null || log_warn "無法設定 WSL 2 為預設版本"
    
    log_success "WSL 問題修復完成"
}

# 安裝 WSL 分發版
install_wsl_distro() {
    log_info "檢查 WSL 分發版..."
    
    # 檢查是否已安裝 Ubuntu
    local installed_distros=$(powershell.exe -Command "wsl --list --quiet" 2>/dev/null | tr -d '\r')
    
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

# 網路連線檢查
check_network_connectivity() {
    log_info "檢查網路連線..."
    
    # 檢查基本網路連線
    if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        error_exit "無法連線到網際網路，請檢查網路設定"
    fi
    
    # 檢查 DNS 解析
    if ! nslookup raw.githubusercontent.com >/dev/null 2>&1; then
        log_warn "DNS 解析有問題，可能影響下載速度"
    fi
    
    # 檢查重要網站連線
    local sites=("github.com" "npmjs.com" "nodejs.org")
    for site in "${sites[@]}"; do
        if ! curl -s --connect-timeout 5 "https://$site" >/dev/null; then
            log_warn "無法連線到 $site，可能影響安裝程序"
        fi
    done
    
    log_success "網路連線檢查通過"
}

# 系統資源檢查
check_system_resources() {
    log_info "檢查系統資源..."
    
    # 檢查記憶體
    local mem_total=$(free -m | awk '/^Mem:/{print $2}')
    local mem_available=$(free -m | awk '/^Mem:/{print $7}')
    
    log_info "記憶體總量：${mem_total}MB"
    log_info "可用記憶體：${mem_available}MB"
    
    if [[ $mem_available -lt 512 ]]; then
        log_warn "可用記憶體不足 512MB，可能影響安裝效能"
    fi
    
    # 檢查 CPU 核心數
    local cpu_cores=$(nproc)
    log_info "CPU 核心數：$cpu_cores"
    
    # 檢查 Load Average
    local load_avg=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')
    log_info "系統負載：$load_avg"
    
    # 使用 awk 替代 bc 進行浮點數比較
    if [[ $(echo "$load_avg $cpu_cores" | awk '{print ($1 > $2)}') == "1" ]]; then
        log_warn "系統負載過高，可能影響安裝效能"
    fi
}

# 檢查磁碟空間
check_disk_space() {
    local free_space=$(df -h ~ | awk 'NR==2 {print $4}')
    local free_bytes=$(df ~ | awk 'NR==2 {print $4}')
    
    log_info "家目錄剩餘空間：$free_space"
    
    # 檢查是否有足夠空間（至少 1GB）
    if [[ $free_bytes -lt 1048576 ]]; then
        error_exit "磁碟空間不足（剩餘：$free_space），需要至少 1GB 空間"
    fi
    
    # 檢查其他重要目錄空間
    local tmp_space=$(df -h /tmp | awk 'NR==2 {print $4}')
    log_info "臨時目錄空間：$tmp_space"
    
    # 檢查 WSL 磁碟使用量（如果在 WSL 環境）
    if [[ -n "$WSL_MODE" ]]; then
        local wsl_usage=$(df -h /mnt/c | awk 'NR==2 {print $5}' | tr -d '%')
        if [[ $wsl_usage -gt 90 ]]; then
            log_warn "Windows C: 磁碟使用率 ${wsl_usage}%，可能影響 WSL 效能"
        fi
    fi
}

# 安裝系統依賴
install_system_dependencies() {
    log_info "更新系統與安裝必要工具..."
    
    # 更新軟體包列表
    if ! sudo apt update; then
        error_exit "無法更新軟體包列表"
    fi
    
    # 安裝必要工具
    local packages="curl git build-essential python3 python3-pip ripgrep ca-certificates gnupg lsb-release"
    if ! sudo apt install -y $packages; then
        error_exit "無法安裝必要工具"
    fi
    
    log_success "系統依賴安裝完成"
}

# 修復 npm 配置污染
fix_npm_config() {
    log_info "檢查 npm 配置和與 nvm 的兼容性..."
    
    local npmrc_file="$HOME/.npmrc"
    local cleanup_needed=false
    local backup_created=false
    
    # 檢查 .npmrc 是否存在
    if [[ -f "$npmrc_file" ]]; then
        # 備份原始配置（僅在需要清理時）
        if grep -q -E "(prefix|globalconfig)" "$npmrc_file" 2>/dev/null || grep -q "/mnt/c/" "$npmrc_file" 2>/dev/null; then
            cp "$npmrc_file" "$npmrc_file.backup.$(date +%Y%m%d_%H%M%S)" || log_warn "無法備份 .npmrc"
            backup_created=true
        fi
        
        # 移除有問題的配置（與 nvm 不兼容）
        if grep -q "prefix" "$npmrc_file" 2>/dev/null; then
            log_warn "偵測到 ~/.npmrc prefix 設置，與 nvm 不兼容，將自動移除..."
            sed -i '/prefix/d' "$npmrc_file"
            cleanup_needed=true
        fi
        
        if grep -q "globalconfig" "$npmrc_file" 2>/dev/null; then
            log_warn "偵測到 ~/.npmrc globalconfig 設置，與 nvm 不兼容，將自動移除..."
            sed -i '/globalconfig/d' "$npmrc_file"
            cleanup_needed=true
        fi
        
        # 移除 Windows 路徑污染
        if grep -q "/mnt/c/" "$npmrc_file" 2>/dev/null; then
            log_warn "偵測到 Windows 路徑污染，將自動移除..."
            grep -v "/mnt/c/" "$npmrc_file" > "$npmrc_file.tmp" && mv "$npmrc_file.tmp" "$npmrc_file"
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
    else
        log_success "~/.npmrc 不存在，跳過檢查"
    fi
    
    # 智能檢查全域 npm 配置中的 prefix 設置
    if command -v npm &>/dev/null; then
        local npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
        if [[ -n "$npm_prefix" && "$npm_prefix" != *".nvm"* ]]; then
            log_warn "偵測到全域 npm prefix 配置與 nvm 衝突（$npm_prefix）"
            log_info "正在清理全域 npm prefix 配置..."
            npm config delete prefix 2>/dev/null || true
            log_success "全域 npm prefix 配置已清理"
        else
            log_success "npm prefix 配置檢查通過"
        fi
    fi
}

# 安裝 Node Version Manager
install_nvm() {
    log_info "檢查 Node Version Manager..."
    
    # 檢查 nvm 是否已安裝
    export NVM_DIR="$HOME/.nvm"
    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        source "$NVM_DIR/nvm.sh"
        if command -v nvm &>/dev/null; then
            local current_version=$(nvm --version)
            log_success "nvm 已安裝（版本：$current_version）"
            
            # 檢查是否需要升級
            if [[ "$current_version" < "${NVM_VERSION#v}" ]]; then
                log_warn "nvm 版本 $current_version 較舊，建議升級到 $NVM_VERSION"
                read -p "是否要升級 nvm？(y/N): " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
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
    
    # 使用 curl 或 wget 下載
    if command -v curl &>/dev/null; then
        curl -o- "$nvm_install_url" | bash
    elif command -v wget &>/dev/null; then
        wget -qO- "$nvm_install_url" | bash
    else
        error_exit "需要 curl 或 wget 來下載 NVM"
    fi
    
    # 重新載入 nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # 確保 nvm 載入於 shell 配置（2025 最佳實踐）
    configure_nvm_profile
    
    log_success "nvm $NVM_VERSION 安裝完成"
}

# 配置 NVM 最佳實踐到 shell profile
configure_nvm_profile() {
    log_info "配置 NVM 最佳實踐到 shell profile..."
    
    # 創建 .zshrc 如果不存在（macOS Catalina+ 需要）
    if [[ ! -f "$SHELL_CONFIG" ]]; then
        touch "$SHELL_CONFIG"
        log_info "已創建 Shell 配置文件：$SHELL_CONFIG"
    fi
    
    # 2025 最佳實踐配置
    local nvm_config='
# NVM Configuration (2025 Best Practices)
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # This loads nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # This loads nvm bash_completion
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi'
    
    # 檢查是否已配置
    if ! grep -q 'NVM Configuration' "$SHELL_CONFIG" 2>/dev/null; then
        # 移除舊的配置
        if grep -q 'nvm.sh' "$SHELL_CONFIG" 2>/dev/null; then
            log_warn "發現舊的 nvm 配置，將更新為最佳實踐版本"
            sed -i '/export NVM_DIR/d' "$SHELL_CONFIG"
            sed -i '/nvm\.sh/d' "$SHELL_CONFIG"
            sed -i '/bash_completion/d' "$SHELL_CONFIG"
        fi
        
        echo "$nvm_config" >> "$SHELL_CONFIG"
        log_success "NVM 最佳實踐配置已添加到 $SHELL_CONFIG"
    else
        log_success "NVM 配置已存在"
    fi
}

# 安裝 Node.js
install_nodejs() {
    log_info "檢查 Node.js 安裝狀況..."
    
    # 確保 nvm 可用
    export NVM_DIR="$HOME/.nvm"
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
    local current_version=$(nvm current | sed 's/v//')
    
    if [[ "$current_version" == "$NODE_TARGET_VERSION" ]]; then
        log_success "當前已使用 Node.js $NODE_TARGET_VERSION"
    else
        log_info "切換到 Node.js $NODE_TARGET_VERSION..."
        nvm use "$NODE_TARGET_VERSION"
        nvm alias default "$NODE_TARGET_VERSION"
        log_success "已切換到 Node.js $NODE_TARGET_VERSION"
    fi
}

verify_nodejs_installation() {
    log_info "驗證 Node.js 安裝..."
    
    local node_version=$(node -v | sed 's/v//')
    local major_version=$(echo "$node_version" | cut -d. -f1)
    
    if [[ $major_version -lt 18 ]]; then
        error_exit "Node.js 版本過低（$node_version），需要 >= 18.0.0"
    fi
    
    log_success "Node.js 版本驗證通過（v$node_version）"
}

# 檢查 Node.js 環境
verify_nodejs_environment() {
    log_info "驗證 Node.js 環境..."
    
    # 檢查 node/npm 路徑
    local node_path=$(which node 2>/dev/null)
    local npm_path=$(which npm 2>/dev/null)
    
    if [[ -z "$node_path" || -z "$npm_path" ]]; then
        error_exit "Node.js 或 npm 未正確安裝"
    fi
    
    # 檢查是否指向 Windows 路徑
    if [[ "$node_path" == /mnt/c/* || "$npm_path" == /mnt/c/* ]]; then
        error_exit "node/npm 指向 Windows 路徑，請移除 Windows node/npm 並重新安裝"
    fi
    
    # 檢查版本
    local node_version=$(node -v 2>/dev/null)
    local npm_version=$(npm -v 2>/dev/null)
    
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
    local node_path=$(which node 2>/dev/null)
    if [[ "$node_path" == *".nvm"* ]]; then
        log_success "偵測到 nvm 管理的 Node.js（$node_path）"
        
        # 清理可能的 prefix 設置以避免衝突
        local current_prefix=$(npm config get prefix 2>/dev/null || echo "")
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
        
        log_success "npm 配置優化完成（nvm 模式）"
        return 0
    fi
    
    # 非 nvm 環境下的傳統配置
    log_warn "未偵測到 nvm 環境，使用傳統 npm 全域配置"
    
    # 檢查是否已經配置過
    local global_dir="$HOME/.npm-global"
    local current_prefix=$(npm config get prefix 2>/dev/null || echo "")
    
    if [[ "$current_prefix" == "$global_dir" ]]; then
        log_success "npm 全域配置已存在（$global_dir）"
        return 0
    fi
    
    log_info "配置 npm 全域安裝目錄..."
    
    # 創建全域安裝目錄
    mkdir -p "$global_dir"
    
    # 設定 npm 安全和效能配置（根據 Context7 最佳實踐）
    npm config set prefix "$global_dir"
    npm config set os linux
    npm config set fund false
    npm config set audit false
    npm config set update-notifier false
    npm config set strict-ssl true
    npm config set audit-level high
    
    # 更新 PATH
    if ! grep -q "$global_dir/bin" "$SHELL_CONFIG"; then
        echo "export PATH=\$HOME/.npm-global/bin:\$PATH" >> "$SHELL_CONFIG"
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
        local claude_version=$(claude --version 2>/dev/null | head -1 || echo "unknown")
        log_success "Claude Code CLI 已安裝（版本：$claude_version）"
        
        # 檢查是否需要更新
        read -p "是否要重新安裝最新版本？(y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "跳過 Claude Code CLI 重新安裝"
            return 0
        fi
    fi
    
    install_claude_code_fresh
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
    local claude_path=$(which claude 2>/dev/null)
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
    local node_version=$(node -v | sed 's/v//')
    local major_version=$(echo $node_version | cut -d. -f1)
    
    if [[ $major_version -lt 18 ]]; then
        log_warn "Node.js 版本 $node_version 不符合項目需求（>=18.0.0）"
    else
        log_success "Node.js 版本符合項目需求（v$node_version >= 18.0.0）"
    fi
    
    # 檢查 npm 與 nvm 的兼容性
    local npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
    local node_path=$(which node 2>/dev/null)
    
    if [[ "$node_path" == *".nvm"* ]]; then
        if [[ "$npm_prefix" == *".nvm"* ]]; then
            log_success "npm 與 nvm 兼容性檢查通過"
        else
            log_warn "npm prefix 設置可能與 nvm 不兼容（$npm_prefix）"
        fi
    fi
    
    # 顯示版本資訊
    log_info "=== 安裝完成摘要 ==="
    echo "Node.js: $(node -v)"
    echo "npm: $(npm -v)"
    echo "Claude Code: $(claude --version 2>/dev/null || echo 'installed')"
    echo "Git: $(git --version)"
    echo "nvm: $(nvm --version 2>/dev/null || echo 'not available')"
    echo "系統: $SYSTEM_TYPE ($ARCH)"
    echo "Shell: $SHELL_TYPE"
    echo "配置文件: $SHELL_CONFIG"
    echo "完整日誌: $LOG_FILE"
    
    log_success "所有檢查通過！"
}

# ========== Windows 端偵測（僅於 Windows PowerShell 管理員下有效） ==========
if grep -qi microsoft /proc/version; then
  log_success "已在 WSL 環境內，進行 Linux 端安裝"
else
  log_info "Windows 環境偵測，開始 WSL 2 安裝程序"
  
  # 檢查管理員權限
  if ! powershell.exe -Command "[Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent() | Select-Object -ExpandProperty IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')" 2>/dev/null | grep -q True; then
    error_exit "需要管理員權限執行此腳本"
  fi
  
  # 系統檢查
  check_windows_version
  check_virtualization
  enable_windows_features
  fix_wsl_issues
  install_wsl_distro
  
  log_info "WSL 2 安裝完成！請重啟電腦後進入 WSL 環境重新執行本腳本"
  exit 0
fi

# ========== Linux/WSL 端自動化安裝與修復 ==========
log_info "開始 Linux/WSL 端自動化安裝與修復程序"

# 主安裝流程函數
main_installation() {
    echo "=========================================="
    echo "  Claude Code 自動安裝工具 v$SCRIPT_VERSION"
    echo "  整合 Context7 最佳實踐優化"
    echo "=========================================="
    echo
    
    log_info "=== 開始 Claude Code 安裝流程 ==="
    
    # 偵測作業系統環境
    detect_os
    
    # 系統檢查階段
    check_dependencies
    check_disk_space
    check_network_connectivity
    check_system_resources
    
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
    
    log_success "Claude Code 安裝流程完成！"
}

# 執行主安裝流程
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_installation
    
    echo
    log_info "=== 後續步驟 ==="
    echo "  1. 重新載入終端或執行: source $SHELL_CONFIG"
    echo "  2. 進入專案目錄並執行: claude"
    echo "  3. 查看所有指令: claude --help"
    echo ""
    log_info "=== 說明文件 ==="
    echo "  • README.md - 完整使用指南"
    echo "  • docs/ - 詳細文件目錄"
    echo ""
    log_info "🔧 如遇問題，請檢查日誌：$LOG_FILE"
fi