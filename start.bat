@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: Claude Code 啟動器
:: 版本: 3.0.0
:: 作者: Claude Code 中文社群
:: 更新: 2025-07-15

echo.
echo ========================================
echo   Claude Code 啟動器 v3.0
echo ========================================
echo.

:: 檢查 WSL 是否可用
echo 🔍 檢查 WSL 狀態...
wsl --list --quiet >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ WSL 未正確安裝或配置
    echo.
    echo 📋 解決方案：
    echo   1. 執行 setup.bat 或 setup.ps1 進行安裝
    echo   2. 確保 WSL 功能已啟用
    echo   3. 重新啟動電腦後再試
    echo.
    pause
    exit /b 1
)

:: 檢查 Ubuntu 是否存在
echo 🔍 檢查 Ubuntu 分發版...
wsl --list --quiet | findstr /i ubuntu >nul
if %errorLevel% neq 0 (
    echo ❌ 未找到 Ubuntu 分發版
    echo.
    echo 📋 解決方案：
    echo   1. 執行 setup.bat 或 setup.ps1 安裝 Ubuntu
    echo   2. 或手動執行: wsl --install -d Ubuntu
    echo.
    pause
    exit /b 1
)

echo ✅ WSL 和 Ubuntu 檢查通過
echo.
echo 🚀 正在啟動 Claude Code 安裝程序...
echo.

:: 獲取當前目錄並轉換為 WSL 路徑
set "current_dir=%~dp0"
set "wsl_path=/mnt/c!current_dir:\=/!"
set "wsl_path=!wsl_path::=!"

:: 啟動 Claude Code 安裝腳本
wsl -d Ubuntu -- bash -c "cd '!wsl_path!' && ./start.sh"

if %errorLevel% equ 0 (
    echo.
    echo ✅ Claude Code 安裝完成！
    echo.
    echo 📋 後續使用：
    echo   • 在 WSL 環境中執行 'claude' 指令
    echo   • 或重新執行此 start.bat 檔案
    echo.
    echo 📚 文件參考：
    echo   • README.md - 完整使用指南
    echo   • docs/ - 詳細文件
    echo.
) else (
    echo.
    echo ❌ Claude Code 安裝失敗
    echo.
    echo 📋 疑難排解：
    echo   1. 檢查網路連線
    echo   2. 確認 WSL 環境正常
    echo   3. 重新執行 setup.bat 修復環境
    echo   4. 查看完整日誌：/tmp/claude_setup_*.log
    echo.
    echo 🔧 常見問題：
    echo   • Node.js 版本衝突 - 移除 Windows 版本 Node.js
    echo   • 網路問題 - 檢查防火牆設定
    echo   • 權限問題 - 確認 WSL 目錄權限
    echo.
)

echo.
pause
exit /b %errorLevel%