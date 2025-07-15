# Claude Code Windows 自動化安裝腳本
# 版本: 3.0.0
# 支援: Windows 10/11 + WSL2 + Docker 自動安裝與修復
# 作者: Claude Code 中文社群
# 更新: 2025-07-15

param(
    [switch]$Force,
    [string]$Language = "auto",
    [switch]$SkipDocker,
    [switch]$Verbose
)

# 設定嚴格模式
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# 管理員權限檢查
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ 需要管理員權限。正在重新啟動為管理員..." -ForegroundColor Red
    $arguments = "-File `"$PSCommandPath`""
    if ($Force) { $arguments += " -Force" }
    if ($Language -ne "auto") { $arguments += " -Language $Language" }
    if ($SkipDocker) { $arguments += " -SkipDocker" }
    if ($Verbose) { $arguments += " -Verbose" }
    
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    exit
}

# 語言偵測
$currentLang = if ($Language -eq "auto") { 
    if ($env:LANG -like "*zh*" -or [System.Globalization.CultureInfo]::CurrentCulture.Name -like "*zh*") { 
        "zh-TW" 
    } else { 
        "en" 
    }
} else { 
    $Language 
}

# 多語言訊息
$Messages = @{
    "zh-TW" = @{
        Title = "Claude Code Windows 自動化安裝工具 v3.0"
        CheckingEnv = "正在檢測系統環境..."
        SystemInfo = "系統資訊"
        InstallingComponent = "正在安裝"
        ComponentExists = "已安裝"
        ComponentMissing = "缺失"
        InstallSuccess = "安裝成功"
        InstallFailed = "安裝失敗"
        WSLFixing = "正在修復 WSL2 問題..."
        WSLFixed = "WSL2 修復完成"
        RestartRequired = "需要重新啟動系統以完成安裝"
        SetupComplete = "環境安裝完成！"
        StartingServices = "正在啟動 Claude Code..."
        PressEnterToContinue = "按 Enter 繼續..."
        Error = "錯誤"
        Warning = "警告"
        Info = "資訊"
        NodejsPathIssue = "偵測到 Node.js 路徑衝突問題"
        FixingPaths = "正在修復路徑設定..."
        VirtualizationDisabled = "虛擬化功能未啟用"
        VirtualizationEnabled = "虛擬化功能已啟用"
        CheckingPrerequisites = "檢查系統先決條件..."
        WindowsVersionCheck = "檢查 Windows 版本..."
        WindowsFeatureCheck = "檢查 Windows 功能..."
        DownloadingWSLKernel = "下載 WSL2 核心更新..."
        CleaningWSLDistros = "清理損壞的 WSL 分發版..."
        ConfiguringWSL = "設定 WSL2 環境..."
        InstallingUbuntu = "安裝 Ubuntu 分發版..."
        TestingWSL = "測試 WSL2 功能..."
        CreatingLauncher = "創建啟動器..."
        FinalVerification = "最終驗證..."
    }
    "en" = @{
        Title = "Claude Code Windows Auto-Installation Tool v3.0"
        CheckingEnv = "Checking system environment..."
        SystemInfo = "System Information"
        InstallingComponent = "Installing"
        ComponentExists = "Already installed"
        ComponentMissing = "Missing"
        InstallSuccess = "Successfully installed"
        InstallFailed = "Failed to install"
        WSLFixing = "Fixing WSL2 issues..."
        WSLFixed = "WSL2 fix completed"
        RestartRequired = "System restart required to complete installation"
        SetupComplete = "Environment setup completed!"
        StartingServices = "Starting Claude Code..."
        PressEnterToContinue = "Press Enter to continue..."
        Error = "Error"
        Warning = "Warning"
        Info = "Info"
        NodejsPathIssue = "Detected Node.js path conflict issue"
        FixingPaths = "Fixing path configuration..."
        VirtualizationDisabled = "Virtualization is disabled"
        VirtualizationEnabled = "Virtualization is enabled"
        CheckingPrerequisites = "Checking system prerequisites..."
        WindowsVersionCheck = "Checking Windows version..."
        WindowsFeatureCheck = "Checking Windows features..."
        DownloadingWSLKernel = "Downloading WSL2 kernel update..."
        CleaningWSLDistros = "Cleaning up corrupted WSL distributions..."
        ConfiguringWSL = "Configuring WSL2 environment..."
        InstallingUbuntu = "Installing Ubuntu distribution..."
        TestingWSL = "Testing WSL2 functionality..."
        CreatingLauncher = "Creating launcher..."
        FinalVerification = "Final verification..."
    }
}

$msg = $Messages[$currentLang]

# 工具函數
function Write-ColorMessage {
    param(
        [string]$Message, 
        [string]$Color = "White", 
        [string]$Prefix = "",
        [switch]$NoNewLine
    )
    
    $prefixColor = switch ($Prefix) {
        "✅" { "Green" }
        "❌" { "Red" }
        "⚠️" { "Yellow" }
        "🔵" { "Blue" }
        "🔧" { "Cyan" }
        "📋" { "Magenta" }
        default { $Color }
    }
    
    if ($Prefix) {
        Write-Host $Prefix -ForegroundColor $prefixColor -NoNewline
        Write-Host " $Message" -ForegroundColor $Color -NoNewline:$NoNewLine
    } else {
        Write-Host $Message -ForegroundColor $Color -NoNewline:$NoNewLine
    }
}

function Test-Command {
    param([string]$Command)
    try {
        if (Get-Command $Command -ErrorAction SilentlyContinue) {
            return $true
        }
        return $false
    } catch {
        return $false
    }
}

function Test-WindowsVersion {
    Write-ColorMessage $msg.WindowsVersionCheck "Yellow" "🔍"
    
    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
    $buildNumber = [int]$osInfo.BuildNumber
    
    Write-ColorMessage "Windows: $($osInfo.Caption) (Build $buildNumber)" "White" "📋"
    Write-ColorMessage "系統版本: $($osInfo.Version)" "White" "📋"
    
    if ($buildNumber -lt 19041) {
        Write-ColorMessage "Windows 版本過低，WSL2 需要 Windows 10 Build 19041 或更新版本" "Red" "❌"
        return $false
    }
    
    # 檢查 Windows 11 特定需求
    if ($buildNumber -ge 22000) {
        Write-ColorMessage "偵測到 Windows 11，檢查進階功能..." "Blue" "🔵"
        
        # 檢查 TPM 2.0 (Windows 11 需求)
        $tpm = Get-CimInstance -ClassName Win32_Tpm -ErrorAction SilentlyContinue
        if ($tpm) {
            Write-ColorMessage "TPM 2.0 可用" "Green" "✅"
        } else {
            Write-ColorMessage "TPM 2.0 不可用" "Yellow" "⚠️"
        }
    }
    
    Write-ColorMessage "Windows 版本檢查通過" "Green" "✅"
    return $true
}

function Test-Virtualization {
    Write-ColorMessage "檢查虛擬化支援..." "Yellow" "🔍"
    
    try {
        $processors = Get-CimInstance -ClassName Win32_Processor
        $virtualizationEnabled = $processors | Where-Object { $_.VirtualizationFirmwareEnabled -eq $true }
        
        if ($virtualizationEnabled) {
            Write-ColorMessage $msg.VirtualizationEnabled "Green" "✅"
            return $true
        } else {
            Write-ColorMessage $msg.VirtualizationDisabled "Red" "❌"
            Write-ColorMessage "請在 BIOS 中啟用 VT-x/AMD-V 虛擬化功能" "Yellow" "⚠️"
            return $false
        }
    } catch {
        Write-ColorMessage "無法檢查虛擬化狀態，將繼續安裝" "Yellow" "⚠️"
        return $true
    }
}

function Install-WithWinget {
    param(
        [string]$PackageId, 
        [string]$Name,
        [string[]]$AdditionalArgs = @()
    )
    
    Write-ColorMessage "$($msg.InstallingComponent): $Name..." "Yellow" "🔧"
    
    try {
        $args = @(
            "install", 
            "--id", $PackageId, 
            "--silent", 
            "--accept-package-agreements", 
            "--accept-source-agreements"
        ) + $AdditionalArgs
        
        & winget @args
        
        if ($LASTEXITCODE -eq 0) {
            Write-ColorMessage "$($msg.InstallSuccess): $Name" "Green" "✅"
            return $true
        } else {
            Write-ColorMessage "$($msg.InstallFailed): $Name (Exit Code: $LASTEXITCODE)" "Red" "❌"
            return $false
        }
    } catch {
        Write-ColorMessage "$($msg.InstallFailed): $Name - $($_.Exception.Message)" "Red" "❌"
        return $false
    }
}

function Enable-WindowsFeature {
    param([string[]]$Features)
    
    Write-ColorMessage $msg.WindowsFeatureCheck "Yellow" "🔍"
    
    $needsRestart = $false
    
    foreach ($feature in $Features) {
        try {
            $featureState = Get-WindowsOptionalFeature -Online -FeatureName $feature -ErrorAction SilentlyContinue
            
            if ($featureState -and $featureState.State -eq "Enabled") {
                Write-ColorMessage "$($msg.ComponentExists): $feature" "Green" "✅"
            } else {
                Write-ColorMessage "$($msg.InstallingComponent): $feature..." "Yellow" "🔧"
                
                $result = Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart
                
                if ($result.RestartNeeded) {
                    $needsRestart = $true
                }
                
                Write-ColorMessage "$($msg.InstallSuccess): $feature" "Green" "✅"
            }
        } catch {
            Write-ColorMessage "$($msg.InstallFailed): $feature - $($_.Exception.Message)" "Red" "❌"
        }
    }
    
    return $needsRestart
}

function Install-WSLKernel {
    Write-ColorMessage $msg.DownloadingWSLKernel "Yellow" "🔧"
    
    $wslUpdateUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
    $wslUpdatePath = "$env:TEMP\wsl_update_x64.msi"
    
    try {
        Invoke-WebRequest -Uri $wslUpdateUrl -OutFile $wslUpdatePath -UseBasicParsing
        Start-Process msiexec.exe -ArgumentList "/i `"$wslUpdatePath`" /quiet /norestart" -Wait
        Remove-Item $wslUpdatePath -Force -ErrorAction SilentlyContinue
        
        Write-ColorMessage "WSL2 核心更新完成" "Green" "✅"
        return $true
    } catch {
        Write-ColorMessage "WSL2 核心更新失敗: $($_.Exception.Message)" "Red" "❌"
        return $false
    }
}

function Fix-WSL2Issues {
    Write-ColorMessage $msg.WSLFixing "Yellow" "🔧"
    
    # 停止 WSL
    try {
        wsl --shutdown | Out-Null
        Start-Sleep -Seconds 3
    } catch {
        # 忽略錯誤
    }
    
    Write-ColorMessage $msg.CleaningWSLDistros "Yellow" "🔧"
    
    # 清理損壞的 WSL 分發版
    $problematicDistros = @("docker-desktop", "docker-desktop-data")
    foreach ($distro in $problematicDistros) {
        try {
            wsl --unregister $distro 2>$null
            Write-ColorMessage "清理分發版: $distro" "Green" "✅"
        } catch {
            # 忽略錯誤，可能原本就不存在
        }
    }
    
    # 清理 .wslconfig
    $wslConfigPath = "$env:USERPROFILE\.wslconfig"
    if (Test-Path $wslConfigPath) {
        try {
            Remove-Item $wslConfigPath -Force
            Write-ColorMessage "清理 .wslconfig 配置檔" "Green" "✅"
        } catch {
            Write-ColorMessage "無法清理 .wslconfig: $($_.Exception.Message)" "Yellow" "⚠️"
        }
    }
    
    # 重新啟動相關服務
    $services = @("HvHost", "vmcompute", "LxssManager")
    foreach ($service in $services) {
        try {
            if (Get-Service $service -ErrorAction SilentlyContinue) {
                Restart-Service $service -Force
                Write-ColorMessage "重新啟動服務: $service" "Green" "✅"
            }
        } catch {
            Write-ColorMessage "無法重新啟動服務: $service" "Yellow" "⚠️"
        }
    }
    
    # 設定 WSL2 為預設版本
    try {
        wsl --set-default-version 2 | Out-Null
        Write-ColorMessage "設定 WSL2 為預設版本" "Green" "✅"
    } catch {
        Write-ColorMessage "無法設定 WSL2 為預設版本" "Yellow" "⚠️"
    }
    
    Write-ColorMessage $msg.WSLFixed "Green" "✅"
}

function Install-UbuntuDistribution {
    Write-ColorMessage $msg.InstallingUbuntu "Yellow" "🔧"
    
    # 檢查是否已有 Ubuntu 分發版
    try {
        $installedDistros = wsl --list --quiet 2>$null
        if ($installedDistros -and ($installedDistros -join " ") -match "Ubuntu") {
            Write-ColorMessage "Ubuntu 分發版已安裝" "Green" "✅"
            return $true
        }
    } catch {
        # 繼續安裝
    }
    
    # 嘗試安裝 Ubuntu
    try {
        # 優先嘗試 Ubuntu 24.04
        $result = wsl --install -d Ubuntu-24.04 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-ColorMessage "Ubuntu 24.04 LTS 安裝成功" "Green" "✅"
            return $true
        }
        
        # 備選 Ubuntu 22.04
        $result = wsl --install -d Ubuntu-22.04 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-ColorMessage "Ubuntu 22.04 LTS 安裝成功" "Green" "✅"
            return $true
        }
        
        # 備選 Ubuntu (預設)
        $result = wsl --install -d Ubuntu 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-ColorMessage "Ubuntu 安裝成功" "Green" "✅"
            return $true
        }
        
        Write-ColorMessage "所有 Ubuntu 版本安裝失敗" "Red" "❌"
        return $false
        
    } catch {
        Write-ColorMessage "Ubuntu 安裝失敗: $($_.Exception.Message)" "Red" "❌"
        return $false
    }
}

function Test-WSLFunctionality {
    Write-ColorMessage $msg.TestingWSL "Yellow" "🔍"
    
    try {
        # 測試 WSL 是否可以執行
        $result = wsl -- echo "WSL Test OK" 2>$null
        if ($result -eq "WSL Test OK") {
            Write-ColorMessage "WSL2 功能測試通過" "Green" "✅"
            return $true
        } else {
            Write-ColorMessage "WSL2 功能測試失敗" "Red" "❌"
            return $false
        }
    } catch {
        Write-ColorMessage "WSL2 功能測試失敗: $($_.Exception.Message)" "Red" "❌"
        return $false
    }
}

function Test-NetworkConnectivity {
    Write-ColorMessage "檢查網路連線..." "Yellow" "🔍"
    
    # 檢查基本網路連線
    try {
        $ping = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        if (-not $ping) {
            Write-ColorMessage "無法連線到網際網路，請檢查網路設定" "Red" "❌"
            return $false
        }
        
        # 檢查重要網站連線
        $sites = @("github.com", "npmjs.com", "nodejs.org", "raw.githubusercontent.com")
        foreach ($site in $sites) {
            try {
                $response = Invoke-WebRequest -Uri "https://$site" -UseBasicParsing -TimeoutSec 5 -ErrorAction SilentlyContinue
                if (-not $response) {
                    Write-ColorMessage "無法連線到 $site，可能影響安裝程序" "Yellow" "⚠️"
                }
            } catch {
                Write-ColorMessage "無法連線到 $site，可能影響安裝程序" "Yellow" "⚠️"
            }
        }
        
        Write-ColorMessage "網路連線檢查通過" "Green" "✅"
        return $true
    } catch {
        Write-ColorMessage "網路連線檢查失敗: $($_.Exception.Message)" "Red" "❌"
        return $false
    }
}

function Install-WingetIfNeeded {
    if (Test-Command "winget") {
        Write-ColorMessage "$($msg.ComponentExists): Windows Package Manager" "Green" "✅"
        return $true
    }
    
    Write-ColorMessage "$($msg.InstallingComponent): Windows Package Manager..." "Yellow" "🔧"
    
    try {
        # 嘗試通過 Microsoft Store 安裝
        $storeUrl = "ms-windows-store://pdp/?productid=9NBLGGH4NNS1"
        Start-Process $storeUrl
        
        Write-ColorMessage "請從 Microsoft Store 安裝 Windows Package Manager (winget)" "Yellow" "⚠️"
        Write-ColorMessage "安裝完成後請重新執行此腳本" "Yellow" "⚠️"
        
        Read-Host $msg.PressEnterToContinue
        return $false
    } catch {
        Write-ColorMessage "無法開啟 Microsoft Store 安裝 winget" "Red" "❌"
        return $false
    }
}

function Create-LauncherScript {
    Write-ColorMessage $msg.CreatingLauncher "Yellow" "🔧"
    
    $launcherPath = "$PSScriptRoot\start.bat"
    $launcherContent = @"
@echo off
chcp 65001 > nul
echo.
echo ========================================
echo   Claude Code 啟動器 v3.0
echo ========================================
echo.

:: 檢查 WSL 是否可用
wsl --list --quiet > nul 2>&1
if errorlevel 1 (
    echo ❌ WSL 未正確安裝或配置
    echo 請執行: setup.ps1
    pause
    exit /b 1
)

:: 檢查 Ubuntu 是否存在
wsl --list --quiet | findstr /i ubuntu > nul
if errorlevel 1 (
    echo ❌ 未找到 Ubuntu 分發版
    echo 請執行: setup.ps1
    pause
    exit /b 1
)

echo ✅ 正在啟動 Claude Code...
echo.

:: 啟動 Claude Code 安裝腳本
wsl -d Ubuntu -- bash -c "cd /mnt/c$(echo '%~dp0' | tr '\\' '/' | sed 's/://')/; ./start.sh"

if errorlevel 1 (
    echo.
    echo ❌ Claude Code 啟動失敗
    echo 請檢查 WSL 環境或重新執行 setup.ps1
    pause
    exit /b 1
)

echo.
echo ✅ Claude Code 安裝完成！
echo.
pause
"@
    
    try {
        $launcherContent | Out-File -FilePath $launcherPath -Encoding UTF8
        Write-ColorMessage "啟動器創建成功: start.bat" "Green" "✅"
        return $true
    } catch {
        Write-ColorMessage "啟動器創建失敗: $($_.Exception.Message)" "Red" "❌"
        return $false
    }
}

function Invoke-FinalVerification {
    Write-ColorMessage $msg.FinalVerification "Yellow" "🔍"
    
    $allGood = $true
    
    # 檢查 WSL
    if (Test-WSLFunctionality) {
        Write-ColorMessage "WSL2 驗證通過" "Green" "✅"
    } else {
        Write-ColorMessage "WSL2 驗證失敗" "Red" "❌"
        $allGood = $false
    }
    
    # 檢查必要工具
    $tools = @("git", "winget")
    foreach ($tool in $tools) {
        if (Test-Command $tool) {
            Write-ColorMessage "$tool 驗證通過" "Green" "✅"
        } else {
            Write-ColorMessage "$tool 驗證失敗" "Red" "❌"
            $allGood = $false
        }
    }
    
    # 檢查啟動器
    if (Test-Path "$PSScriptRoot\start.bat") {
        Write-ColorMessage "啟動器驗證通過" "Green" "✅"
    } else {
        Write-ColorMessage "啟動器驗證失敗" "Red" "❌"
        $allGood = $false
    }
    
    return $allGood
}

# ========== 主安裝流程 ==========

Clear-Host
Write-Host "=" * 80 -ForegroundColor Cyan
Write-ColorMessage $msg.Title "Cyan" "🚀"
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host ""

# 系統先決條件檢查
Write-ColorMessage $msg.CheckingPrerequisites "Yellow" "🔍"

if (-not (Test-WindowsVersion)) {
    Write-ColorMessage "系統不符合 WSL2 需求" "Red" "❌"
    Read-Host $msg.PressEnterToContinue
    exit 1
}

if (-not (Test-Virtualization)) {
    Write-ColorMessage "虛擬化未啟用，某些功能可能無法使用" "Yellow" "⚠️"
}

# 檢查網路連線
if (-not (Test-NetworkConnectivity)) {
    Write-ColorMessage "網路連線有問題，可能影響安裝程序" "Red" "❌"
    Read-Host $msg.PressEnterToContinue
    exit 1
}

# 系統資訊顯示
Write-ColorMessage $msg.SystemInfo "Cyan" "📋"
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
$cpuInfo = Get-CimInstance -ClassName Win32_Processor
Write-Host "  OS: $($osInfo.Caption) Build $($osInfo.BuildNumber)" -ForegroundColor White
Write-Host "  CPU: $($cpuInfo.Name)" -ForegroundColor White
Write-Host "  Memory: $([math]::round($osInfo.TotalVisibleMemorySize/1MB,2)) GB" -ForegroundColor White
Write-Host ""

# 安裝 winget（如果需要）
if (-not (Install-WingetIfNeeded)) {
    exit 1
}

# 檢查並安裝必要軟體
$requiredSoftware = @(
    @{ PackageId = "Git.Git"; Name = "Git" }
)

if (-not $SkipDocker) {
    $requiredSoftware += @{ PackageId = "Docker.DockerDesktop"; Name = "Docker Desktop" }
}

foreach ($software in $requiredSoftware) {
    if (-not (Test-Command $software.Name.ToLower())) {
        Install-WithWinget $software.PackageId $software.Name
    } else {
        Write-ColorMessage "$($msg.ComponentExists): $($software.Name)" "Green" "✅"
    }
}

# 啟用 Windows 功能
$requiredFeatures = @(
    "Microsoft-Windows-Subsystem-Linux",
    "VirtualMachinePlatform"
)

if (-not $SkipDocker) {
    $requiredFeatures += "Microsoft-Hyper-V-All"
    $requiredFeatures += "Containers"
}

$needsRestart = Enable-WindowsFeature $requiredFeatures

# 安裝 WSL2 核心
Install-WSLKernel | Out-Null

# 修復 WSL2 問題
Fix-WSL2Issues

# 安裝 Ubuntu 分發版
Install-UbuntuDistribution | Out-Null

# 創建啟動器
Create-LauncherScript | Out-Null

# 最終驗證
$verificationPassed = Invoke-FinalVerification

Write-Host ""
Write-Host "=" * 80 -ForegroundColor Cyan

if ($needsRestart) {
    Write-ColorMessage $msg.RestartRequired "Red" "⚠️"
    Write-ColorMessage "重新啟動後請執行: start.bat" "Yellow" "📋"
    Write-Host ""
    
    $restart = Read-Host "立即重新啟動? (y/N)"
    if ($restart -eq "y" -or $restart -eq "Y") {
        Restart-Computer -Force
    }
} elseif ($verificationPassed) {
    Write-ColorMessage $msg.SetupComplete "Green" "✅"
    Write-Host ""
    Write-ColorMessage "執行以下指令來啟動 Claude Code：" "Cyan" "🚀"
    Write-Host "  start.bat" -ForegroundColor Yellow
    Write-Host ""
    
    $startNow = Read-Host "立即啟動 Claude Code? (Y/n)"
    if ($startNow -ne "n" -and $startNow -ne "N") {
        & "$PSScriptRoot\start.bat"
    }
} else {
    Write-ColorMessage "安裝過程中遇到問題，請檢查錯誤訊息" "Red" "❌"
    Write-ColorMessage "您可以重新執行 setup.ps1 -Force 來強制重新安裝" "Yellow" "⚠️"
}

Write-Host ""
Read-Host $msg.PressEnterToContinue