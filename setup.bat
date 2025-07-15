@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: Claude Code Windows 快速安裝腳本
:: 版本: 3.0.0
:: 支援: Windows 10/11 + WSL2 自動安裝
:: 作者: Claude Code 中文社群
:: 更新: 2025-07-15

echo.
echo ========================================================================
echo   Claude Code Windows 快速安裝工具 v3.0
echo ========================================================================
echo.

:: 檢查管理員權限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ 需要管理員權限
    echo 請以管理員身份執行此腳本
    echo.
    pause
    exit /b 1
)

:: 檢查 Windows 版本
for /f "tokens=2 delims=[]" %%i in ('ver') do set winver=%%i
echo 🔍 檢查 Windows 版本: %winver%

:: 檢查 PowerShell 版本
powershell -Command "if ($PSVersionTable.PSVersion.Major -lt 5) { exit 1 }"
if %errorLevel% neq 0 (
    echo ❌ 需要 PowerShell 5.0 或更高版本
    echo 請更新 PowerShell 後重試
    pause
    exit /b 1
)

echo ✅ PowerShell 版本檢查通過
echo.

:: 設定 PowerShell 執行策略
echo 🔧 設定 PowerShell 執行策略...
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
if %errorLevel% neq 0 (
    echo ❌ 無法設定 PowerShell 執行策略
    pause
    exit /b 1
)

echo ✅ PowerShell 執行策略設定完成
echo.

:: 檢查 WSL 是否可用
echo 🔍 檢查 WSL 狀態...
wsl --list --quiet >nul 2>&1
set wsl_status=%errorLevel%

if %wsl_status% equ 0 (
    echo ✅ WSL 已安裝
    
    :: 檢查是否有 Ubuntu 分發版
    wsl --list --quiet | findstr /i ubuntu >nul
    if !errorLevel! equ 0 (
        echo ✅ Ubuntu 分發版已安裝
        echo.
        echo 🚀 環境已準備就緒，正在啟動 Claude Code 安裝...
        echo.
        
        :: 直接啟動 Claude Code 安裝
        wsl -d Ubuntu -- bash -c "cd /mnt/c%~dp0; ./start.sh"
        
        if !errorLevel! equ 0 (
            echo.
            echo ✅ Claude Code 安裝完成！
        ) else (
            echo.
            echo ❌ Claude Code 安裝失敗
            echo 請檢查 WSL 環境或執行 setup.ps1 進行修復
        )
        
        echo.
        pause
        exit /b 0
    ) else (
        echo ⚠️ WSL 已安裝但缺少 Ubuntu 分發版
    )
) else (
    echo ⚠️ WSL 未安裝或未正確配置
)

echo.
echo 🔧 需要安裝或修復 WSL 環境
echo 正在啟動完整安裝程序...
echo.

:: 啟動 PowerShell 腳本進行完整安裝
powershell -File "%~dp0setup.ps1"
set ps_result=%errorLevel%

if %ps_result% equ 0 (
    echo.
    echo ✅ 安裝完成！
    echo.
    echo 📋 後續步驟：
    echo   1. 如果需要重新啟動，請重新啟動電腦
    echo   2. 重新啟動後執行 start.bat 來啟動 Claude Code
    echo   3. 或者立即執行 start.bat（如果不需要重新啟動）
    echo.
) else (
    echo.
    echo ❌ 安裝過程中遇到問題
    echo 請檢查錯誤訊息或重新執行此腳本
    echo.
)

pause
exit /b %ps_result%