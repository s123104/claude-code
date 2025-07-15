#!/bin/bash
set -e

# ========== Claude Code 自動化安裝與啟動腳本 ==========
# 版本: 3.0.0
# 支援: Windows WSL2 + Linux 環境自動偵測與安裝
# 作者: Claude Code 中文社群
# 更新: 2025-07-15

# 首先檢查作業系統環境
detect_os() {
    if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]] || [[ -n "$WINDIR" ]]; then
        echo "❌ 偵測到 Windows 環境，此腳本需要在 WSL 環境中執行"
        echo "請先安裝 WSL2 並使用以下 PowerShell 腳本："
        echo "  1. 以管理員身份開啟 PowerShell"
        echo "  2. 執行: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
        echo "  3. 執行: .\\setup.ps1"
        echo ""
        echo "或手動安裝 WSL2："
        echo "  wsl --install"
        exit 1
    fi
    
    if ! grep -qi microsoft /proc/version 2>/dev/null; then
        echo "⚠️ 未偵測到 WSL 環境，將以純 Linux 模式執行"
        export LINUX_MODE=true
    else
        echo "✅ WSL 環境偵測成功，開始安裝程序"
        export WSL_MODE=true
    fi
}

# 偵測作業系統
detect_os

# ========== 錯誤處理與日誌系統 ==========
LOG_FILE="/tmp/claude_setup_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 錯誤處理函數
error_exit() {
    echo -e "${RED}❌ 錯誤：$1${NC}" >&2
    echo -e "${YELLOW}📋 完整日誌已保存至：$LOG_FILE${NC}" >&2
    exit 1
}

# 警告函數
warn() {
    echo -e "${YELLOW}⚠️ 警告：$1${NC}"
}

# 成功訊息函數
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# 資訊訊息函數
info() {
    echo -e "${BLUE}🔵 $1${NC}"
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
    
    success "Windows 版本檢查通過（Build $os_build）"
}

# 檢查虛擬化支援
check_virtualization() {
    info "檢查虛擬化支援..."
    
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
    
    success "虛擬化支援檢查通過"
}

# 檢查並啟用 Windows 功能
enable_windows_features() {
    info "檢查 Windows 功能..."
    
    local features=("Microsoft-Windows-Subsystem-Linux" "VirtualMachinePlatform")
    local needs_reboot=false
    
    for feature in "${features[@]}"; do
        local state=$(powershell.exe -Command "Get-WindowsOptionalFeature -Online -FeatureName $feature | Select-Object -ExpandProperty State" 2>/dev/null | tr -d '\r')
        
        if [[ "$state" != "Enabled" ]]; then
            info "啟用 Windows 功能：$feature"
            powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart" || error_exit "無法啟用 $feature"
            needs_reboot=true
        else
            success "$feature 已啟用"
        fi
    done
    
    if [[ "$needs_reboot" == "true" ]]; then
        warn "Windows 功能已啟用，建議重新啟動後再執行此腳本"
    fi
}

# 修復 WSL 常見問題
fix_wsl_issues() {
    info "修復 WSL 常見問題..."
    
    # 重新啟動 WSL 服務
    powershell.exe -Command "Restart-Service LxssManager -Force" 2>/dev/null || warn "無法重新啟動 LxssManager 服務"
    
    # 清理損壞的 WSL 分發版
    powershell.exe -Command "wsl --shutdown" 2>/dev/null
    
    # 設定 WSL 2 為預設版本
    powershell.exe -Command "wsl --set-default-version 2" 2>/dev/null || warn "無法設定 WSL 2 為預設版本"
    
    success "WSL 問題修復完成"
}

# 安裝 WSL 分發版
install_wsl_distro() {
    info "檢查 WSL 分發版..."
    
    # 檢查是否已安裝 Ubuntu
    local installed_distros=$(powershell.exe -Command "wsl --list --quiet" 2>/dev/null | tr -d '\r')
    
    if echo "$installed_distros" | grep -qi ubuntu; then
        success "Ubuntu 已安裝"
        return 0
    fi
    
    info "安裝 Ubuntu 24.04 LTS..."
    if ! powershell.exe -Command "wsl --install -d Ubuntu-24.04" 2>/dev/null; then
        warn "Ubuntu 24.04 安裝失敗，嘗試安裝 Ubuntu 22.04..."
        if ! powershell.exe -Command "wsl --install -d Ubuntu-22.04" 2>/dev/null; then
            error_exit "無法安裝 Ubuntu 分發版"
        fi
    fi
    
    success "Ubuntu 安裝完成"
}

# ========== Windows 端偵測（僅於 Windows PowerShell 管理員下有效） ==========
if grep -qi microsoft /proc/version; then
  success "已在 WSL 環境內，進行 Linux 端安裝"
else
  info "Windows 環境偵測，開始 WSL 2 安裝程序"
  
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
  
  info "WSL 2 安裝完成！請重啟電腦後進入 WSL 環境重新執行本腳本"
  exit 0
fi

# ========== Linux/WSL 端自動化安裝與修復 ==========
info "開始 Linux/WSL 端自動化安裝與修復程序"

# 檢查磁碟空間
check_disk_space() {
    local free_space=$(df -h ~ | awk 'NR==2 {print $4}')
    local free_bytes=$(df ~ | awk 'NR==2 {print $4}')
    
    info "家目錄剩餘空間：$free_space"
    
    # 檢查是否有足夠空間（至少 1GB）
    if [[ $free_bytes -lt 1048576 ]]; then
        error_exit "磁碟空間不足（剩餘：$free_space），需要至少 1GB 空間"
    fi
}

# 安裝系統依賴
install_system_dependencies() {
    info "更新系統與安裝必要工具..."
    
    # 更新軟體包列表
    if ! sudo apt update; then
        error_exit "無法更新軟體包列表"
    fi
    
    # 安裝必要工具
    local packages="curl git build-essential python3 python3-pip ripgrep ca-certificates gnupg lsb-release"
    if ! sudo apt install -y $packages; then
        error_exit "無法安裝必要工具"
    fi
    
    success "系統依賴安裝完成"
}

# 修復 npm 配置污染
fix_npm_config() {
    info "檢查並修復 npm 配置..."
    
    local npmrc_file="$HOME/.npmrc"
    local cleanup_needed=false
    
    # 檢查 .npmrc 是否存在
    if [[ -f "$npmrc_file" ]]; then
        # 備份原始配置
        cp "$npmrc_file" "$npmrc_file.backup.$(date +%Y%m%d_%H%M%S)" || warn "無法備份 .npmrc"
        
        # 移除有問題的配置
        if grep -q "prefix" "$npmrc_file" 2>/dev/null; then
            warn "偵測到 ~/.npmrc prefix 污染，將自動移除..."
            sed -i '/prefix/d' "$npmrc_file"
            cleanup_needed=true
        fi
        
        if grep -q "globalconfig" "$npmrc_file" 2>/dev/null; then
            warn "偵測到 ~/.npmrc globalconfig 污染，將自動移除..."
            sed -i '/globalconfig/d' "$npmrc_file"
            cleanup_needed=true
        fi
        
        # 移除 Windows 路徑
        if grep -q "/mnt/c/" "$npmrc_file" 2>/dev/null; then
            warn "偵測到 Windows 路徑污染，將自動移除..."
            grep -v "/mnt/c/" "$npmrc_file" > "$npmrc_file.tmp" && mv "$npmrc_file.tmp" "$npmrc_file"
            cleanup_needed=true
        fi
        
        if [[ "$cleanup_needed" == "true" ]]; then
            success "npm 配置清理完成"
        fi
    fi
}

# 安裝 Node Version Manager
install_nvm() {
    info "檢查 Node Version Manager..."
    
    # 檢查 nvm 是否已安裝
    export NVM_DIR="$HOME/.nvm"
    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        source "$NVM_DIR/nvm.sh"
        if command -v nvm &>/dev/null; then
            success "nvm 已安裝（版本：$(nvm --version)）"
            return 0
        fi
    fi
    
    info "安裝 nvm..."
    
    # 下載並安裝 nvm
    local nvm_install_url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh"
    if ! curl -o- "$nvm_install_url" | bash; then
        error_exit "nvm 安裝失敗"
    fi
    
    # 重新載入 nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # 確保 nvm 載入於 shell 配置
    local shell_config="$HOME/.bashrc"
    if [[ -f "$HOME/.zshrc" ]]; then
        shell_config="$HOME/.zshrc"
    fi
    
    if ! grep -q 'nvm.sh' "$shell_config"; then
        echo 'export NVM_DIR="$HOME/.nvm"' >> "$shell_config"
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$shell_config"
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> "$shell_config"
    fi
    
    success "nvm 安裝完成"
}

# 安裝 Node.js
install_nodejs() {
    info "安裝 Node.js 18 LTS..."
    
    # 確保 nvm 可用
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    if ! command -v nvm &>/dev/null; then
        error_exit "nvm 未正確安裝"
    fi
    
    # 安裝 Node.js 18
    if ! nvm install 18; then
        error_exit "Node.js 18 安裝失敗"
    fi
    
    # 使用 Node.js 18
    if ! nvm use 18; then
        error_exit "無法切換到 Node.js 18"
    fi
    
    # 設定預設版本
    nvm alias default 18
    
    success "Node.js 18 LTS 安裝完成"
}

# 檢查 Node.js 環境
verify_nodejs_environment() {
    info "驗證 Node.js 環境..."
    
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
    
    info "Node.js 路徑：$node_path"
    info "Node.js 版本：$node_version"
    info "npm 路徑：$npm_path"
    info "npm 版本：$npm_version"
    
    success "Node.js 環境驗證通過"
}

# 配置 npm 全域安裝目錄
configure_npm_global() {
    info "配置 npm 全域安裝目錄..."
    
    # 創建全域安裝目錄
    local global_dir="$HOME/.npm-global"
    mkdir -p "$global_dir"
    
    # 設定 npm 配置
    npm config set prefix "$global_dir"
    npm config set os linux
    npm config set fund false
    npm config set audit false
    
    # 更新 PATH
    local shell_config="$HOME/.bashrc"
    if [[ -f "$HOME/.zshrc" ]]; then
        shell_config="$HOME/.zshrc"
    fi
    
    if ! grep -q "$global_dir/bin" "$shell_config"; then
        echo "export PATH=\$HOME/.npm-global/bin:\$PATH" >> "$shell_config"
    fi
    
    # 重新載入 PATH
    export PATH="$global_dir/bin:$PATH"
    
    success "npm 全域安裝目錄配置完成"
}

# 安裝 Claude Code CLI
install_claude_code() {
    info "安裝 Claude Code CLI..."
    
    # 清理舊版本
    npm uninstall -g @anthropic-ai/claude-code 2>/dev/null || true
    
    # 安裝 Claude Code
    if ! npm install -g @anthropic-ai/claude-code --force --no-os-check; then
        error_exit "Claude Code CLI 安裝失敗"
    fi
    
    success "Claude Code CLI 安裝完成"
}

# 驗證 Claude Code 安裝
verify_claude_installation() {
    info "驗證 Claude Code 安裝..."
    
    # 重新載入 PATH
    export PATH="$HOME/.npm-global/bin:$PATH"
    
    # 檢查 claude 指令
    local claude_path=$(which claude 2>/dev/null)
    if [[ -z "$claude_path" ]]; then
        error_exit "Claude Code 未正確安裝或未在 PATH 中"
    fi
    
    info "Claude Code 路徑：$claude_path"
    
    # 測試 Claude Code 功能
    if ! claude --help >/dev/null 2>&1; then
        error_exit "Claude Code CLI 無法正常運行"
    fi
    
    success "Claude Code 驗證通過"
}

# 最終系統檢查
final_system_check() {
    info "執行最終系統檢查..."
    
    # 檢查所有必要指令
    local commands=("node" "npm" "claude" "git" "curl")
    for cmd in "${commands[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            error_exit "指令 $cmd 未找到"
        fi
    done
    
    # 顯示版本資訊
    info "=== 安裝完成摘要 ==="
    echo "Node.js: $(node -v)"
    echo "npm: $(npm -v)"
    echo "Claude Code: $(claude --version 2>/dev/null || echo 'installed')"
    echo "Git: $(git --version)"
    echo "完整日誌: $LOG_FILE"
    
    success "所有檢查通過！"
}

# 執行安裝流程
check_disk_space
install_system_dependencies
fix_npm_config
install_nvm
install_nodejs
verify_nodejs_environment
configure_npm_global
install_claude_code
verify_claude_installation
final_system_check

success "Claude Code 安裝完成！"
info "使用方法："
echo "  1. 進入專案目錄"
echo "  2. 執行 'claude' 開始使用"
echo "  3. 執行 'claude --help' 查看所有指令"
echo ""
info "如遇問題，請檢查日誌：$LOG_FILE"