#!/bin/bash
set -e

# ========== Windows 端偵測（僅於 Windows PowerShell 管理員下有效） ==========
if grep -qi microsoft /proc/version; then
  echo "✅ 已在 WSL 環境內，進行 Linux 端安裝"
else
  echo "🔵 [Windows] 檢查 WSL 2、虛擬化、Hyper-V 狀態..."
  powershell.exe -Command "Get-WindowsOptionalFeature -Online | Where-Object { \$_.FeatureName -match 'Microsoft-Windows-Subsystem-Linux|VirtualMachinePlatform|Microsoft-Hyper-V' }"
  powershell.exe -Command "systeminfo | findstr /i 'Virtualization'"
  powershell.exe -Command "Get-ComputerInfo | Select-Object OsName,OsVersion,WindowsProductName"
  powershell.exe -Command "Get-Volume | Where-Object { \$_.DriveLetter -eq 'C' } | Select-Object SizeRemaining,Size"
  echo "🟡 若出現 [Disabled] 或 [No]，請於 BIOS 啟用虛擬化，並於 Windows 功能啟用 WSL 2/Hyper-V"
  echo "🔵 安裝 WSL 2 與 Ubuntu 24.04 LTS..."
  wsl --install -d Ubuntu-24.04 || wsl --install -d Ubuntu-22.04
  echo "請重啟電腦後重新執行本腳本"
  exit 0
fi

# ========== Linux/WSL 端自動化安裝與修復 ==========
echo "🔵 更新系統與安裝必要工具..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential python3 python3-pip ripgrep

# 檢查磁碟空間
FREE_SPACE=$(df -h ~ | awk 'NR==2 {print $4}')
echo "🟢 家目錄剩餘空間：$FREE_SPACE"

# 檢查/修復 .npmrc 污染
if grep -q "prefix" ~/.npmrc 2>/dev/null; then
  echo "🟡 偵測到 ~/.npmrc prefix 污染，將自動移除..."
  sed -i '/prefix/d' ~/.npmrc
fi
if grep -q "globalconfig" ~/.npmrc 2>/dev/null; then
  echo "🟡 偵測到 ~/.npmrc globalconfig 污染，將自動移除..."
  sed -i '/globalconfig/d' ~/.npmrc
fi

# 檢查/安裝 nvm
if ! command -v nvm &>/dev/null; then
  echo "🔵 安裝 nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
  echo "✅ nvm 已安裝"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# 確保 nvm 載入於 bashrc/zshrc
if ! grep -q 'nvm.sh' ~/.bashrc; then
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
fi

echo "🔵 安裝 Node.js 18 LTS..."
nvm install 18
nvm use 18

# 檢查 node/npm 路徑，避免 Windows 污染
NODE_PATH=$(which node)
NPM_PATH=$(which npm)
if [[ "$NODE_PATH" == /mnt/c/* || "$NPM_PATH" == /mnt/c/* ]]; then
  echo "❌ node/npm 指向 Windows 路徑，請移除 Windows node/npm 並重啟 WSL"
  exit 1
fi

# 設定 npm 全域安裝目錄
echo "🔵 設定 npm 全域安裝目錄..."
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
npm config set os linux
echo 'export PATH=$HOME/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 安裝 Claude Code CLI
echo "🔵 全域安裝 Claude Code CLI..."
npm install -g @anthropic-ai/claude-code --force --no-os-check

# 驗證安裝
echo "🔵 驗證安裝結果..."
echo "node 路徑: $(which node)"
echo "node 版本: $(node -v)"
echo "npm 路徑: $(which npm)"
echo "npm 版本: $(npm -v)"
echo "claude 路徑: $(which claude)"
claude --help || echo "❌ Claude Code CLI 啟動失敗，請檢查上方錯誤訊息"

# 常見問題自動偵測
echo "🟡 常見問題自動偵測："
if [[ "$NODE_PATH" == /mnt/c/* || "$NPM_PATH" == /mnt/c/* ]]; then
  echo "❌ node/npm 路徑污染：請移除 Windows node/npm，並於 WSL 內重新安裝"
fi
if ! command -v claude &>/dev/null; then
  echo "❌ Claude Code 未正確安裝，請檢查 npm 權限與路徑"
fi

echo "✅ 安裝完成！請於專案目錄執行 claude 開始使用，或 claude --help 查看指令"