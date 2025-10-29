# Claude Code 文檔同步工具 (Doc-Sync)

這是 Claude Code 專案的獨立文檔同步工具模組，負責自動爬取和同步官方文檔。

## 📁 檔案結構

```
doc-sync/
├── README.md                      # 本說明文件
├── package.json                   # Node.js 依賴配置
├── package-lock.json              # 依賴版本鎖定
├── auto-discover.sh               # 執行腳本（Shell 包裝器）
├── auto-discover-sync.js          # 官方文檔同步工具（推薦）
└── zh-tw-translator-simple.cjs    # 繁體中文翻譯工具
```

## 🚀 快速開始

1. **安裝依賴**

   ```bash
   cd scripts/doc-sync
   npm install
   ```

2. **執行同步**

   ```bash
   # 使用 Shell 包裝器（推薦）
   ./auto-discover.sh

   # 或直接使用 Node.js
   node auto-discover-sync.js
   ```

## 🛠️ 主要功能

### auto-discover-sync.js（推薦）

- ✅ 自動發現官方文檔頁面（53+ 頁）
- ✅ 直接下載 Markdown 格式（.md 端點）
- ✅ 智能同步（僅更新變更的文檔）
- ✅ 自動刪除 404 文檔
- ✅ 支援繁中/英文雙版本
- ✅ 自動重試機制
- ✅ 詳細同步報告

### auto-discover.sh（Shell 包裝器）

- ✅ 自動依賴檢查和安裝
- ✅ 參數解析和驗證
- ✅ 彩色日誌輸出
- ✅ 錯誤處理
- ✅ 報告展示

### zh-tw-translator-simple.cjs（翻譯工具）

- ✅ 技術術語翻譯
- ✅ CHANGELOG 項目翻譯
- ✅ 保持程式碼和指令原樣
- ✅ 可獨立使用

## 📖 使用方式

### 基本指令

```bash
# 完整同步（推薦）
./auto-discover.sh

# 僅發現文檔列表
./auto-discover.sh discover

# 強制更新所有文檔
./auto-discover.sh force

# 預覽模式
cd scripts/doc-sync && node auto-discover-sync.js --dry-run

# 詳細輸出
cd scripts/doc-sync && node auto-discover-sync.js --verbose
```

### 進階選項

```bash
# 查看最新報告
./auto-discover.sh report

# 顯示說明
./auto-discover.sh help
```

## 📊 輸出檔案

同步完成後會產生：

- `docs/anthropic-claude-code-zh-tw/*.md` - 官方文檔鏡像（43 個有效文檔）
- `docs/anthropic-claude-code-zh-tw/README.md` - 索引文件
- `auto-discover-sync-report.json` - 詳細同步報告（根目錄）

## 🔧 配置說明

### 自動發現機制

- 從官方網站 `https://docs.anthropic.com/zh-TW/docs/claude-code/overview` 自動提取所有文檔連結
- 支援繁中和英文雙版本發現
- 自動識別新增或移除的文檔

### 文檔下載方式

- 直接從 `.md` 端點下載完整 Markdown 內容
- 格式：`https://docs.anthropic.com/zh-TW/docs/claude-code/{page}.md`
- 如果繁中版不存在，自動回退到英文版

### 404 處理

- 自動偵測 HTTP 404 錯誤
- 自動刪除不再存在的文檔
- 在報告中分類顯示 404 錯誤

## 🐛 疑難排解

### 常見問題

1. **執行權限問題**

   ```bash
   chmod +x auto-discover.sh
   ```

2. **依賴安裝失敗**

   ```bash
   cd scripts/doc-sync
   rm -rf node_modules package-lock.json
   npm install
   ```

3. **網路連線問題**
   ```bash
   node auto-discover-sync.js --verbose  # 查看詳細錯誤
   ```

### 錯誤代碼

- `0` - 成功完成
- `1` - 一般錯誤
- `130` - 使用者中斷

## 🔄 與主專案整合

此工具設計為獨立模組，可透過以下方式與主專案整合：

1. **從專案根目錄執行**

   ```bash
   scripts/doc-sync/auto-discover.sh
   ```

2. **在其他腳本中調用**

   ```bash
   cd scripts/doc-sync && ./auto-discover.sh force
   ```

3. **CI/CD 整合**
   ```yaml
   - name: 同步文檔
     run: cd scripts/doc-sync && ./auto-discover.sh
   ```

## 📞 技術支援

如有問題請：

1. 查看 `auto-discover-sync-report.json` 和錯誤日誌
2. 使用 `--verbose` 選項獲取詳細資訊
3. 在主專案 GitHub Issues 回報問題

## 📄 版本資訊

- **Version**: 3.0
- **Last Updated**: 2025-10-29
- **Dependencies**: Node.js 18+, npm, node-fetch
- **License**: MIT
