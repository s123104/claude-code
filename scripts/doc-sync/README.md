# Claude Code 文檔同步工具 (Doc-Sync)

這是 Claude Code 專案的獨立文檔同步工具模組，負責自動爬取和同步官方文檔。

## 📁 檔案結構

```
doc-sync/
├── README.md                    # 本說明文件
├── package.json                 # Node.js 依賴配置
├── package-lock.json           # 依賴版本鎖定
├── sync-docs.sh                # 執行腳本（Shell 包裝器）
├── enhanced-doc-sync.js        # 增強版同步工具（推薦）
└── auto-doc-sync.js           # 基本版同步工具
```

## 🚀 快速開始

1. **安裝依賴**
   ```bash
   npm install
   ```

2. **執行同步**
   ```bash
   # 使用 Shell 包裝器（推薦）
   ./sync-docs.sh
   
   # 或直接使用 Node.js
   node enhanced-doc-sync.js
   ```

## 🛠️ 主要功能

### enhanced-doc-sync.js（增強版）
- ✅ 智能 HTML 解析和 Markdown 轉換
- ✅ 繁體中文智能翻譯
- ✅ 批次處理和錯誤重試
- ✅ 詳細同步報告生成
- ✅ 內容差異檢測
- ✅ 性能監控統計

### sync-docs.sh（Shell 包裝器）
- ✅ 自動依賴檢查和安裝
- ✅ 參數解析和驗證
- ✅ 彩色日誌輸出
- ✅ 錯誤處理和清理
- ✅ 同步報告展示

## 📖 使用方式

### 基本指令
```bash
./sync-docs.sh                    # 標準同步
./sync-docs.sh dry-run           # 預覽模式
./sync-docs.sh force             # 強制更新
./sync-docs.sh changelog         # 僅同步 CHANGELOG
./sync-docs.sh verbose           # 詳細輸出
```

### 進階選項
```bash
./sync-docs.sh --target overview # 僅同步指定頁面
./sync-docs.sh --report          # 顯示最新報告
./sync-docs.sh --cleanup         # 清理舊檔案
./sync-docs.sh --install-deps    # 僅安裝依賴
./sync-docs.sh --help           # 顯示說明
```

### NPM 腳本
```bash
npm run sync            # 完整同步
npm run sync:force      # 強制更新
npm run sync:dry-run    # 預覽模式
npm run sync:changelog  # 僅 CHANGELOG
npm run sync:verbose    # 詳細輸出
```

## 📊 輸出檔案

同步完成後會在專案根目錄產生：

- `sync-report-enhanced.json` - 詳細同步報告
- `docs/anthropic-claude-code-zh-tw/` - 官方文檔鏡像
- `claude-code-zh-tw.md` - 更新的主文檔（CHANGELOG 區塊）

## 🔧 配置說明

### 支援的文檔頁面
- `overview` - 概述頁面（優先級 1）
- `quickstart` - 快速開始（優先級 1）
- `sub-agents` - Subagents 系統（優先級 2）
- `mcp` - Model Context Protocol（優先級 2）
- `cli-reference` - CLI 參考（優先級 2）
- 更多頁面請參考 `enhanced-doc-sync.js`

### 自訂翻譯映射
編輯 `enhanced-doc-sync.js` 中的 `translations` Map 來新增或修改翻譯：

```javascript
this.translations = new Map([
  ['new-term', '新術語'],
  // 在此新增更多翻譯
]);
```

## 🐛 疑難排解

### 常見問題

1. **執行權限問題**
   ```bash
   chmod +x sync-docs.sh
   ```

2. **依賴安裝失敗**
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```

3. **網路連線問題**
   ```bash
   ./sync-docs.sh verbose  # 查看詳細錯誤
   ```

### 錯誤代碼
- `0` - 成功完成
- `1` - 一般錯誤
- `2` - 網路連線錯誤
- `3` - 檔案系統錯誤
- `130` - 使用者中斷

## 🔄 與主專案整合

此工具設計為獨立模組，可透過以下方式與主專案整合：

1. **從專案根目錄執行**
   ```bash
   scripts/doc-sync/sync-docs.sh
   ```

2. **在其他腳本中調用**
   ```bash
   cd scripts/doc-sync && ./sync-docs.sh changelog
   ```

3. **CI/CD 整合**
   ```yaml
   - name: 同步文檔
     run: cd scripts/doc-sync && ./sync-docs.sh
   ```

## 📞 技術支援

如有問題請：
1. 查看 `sync-report-enhanced.json` 和錯誤日誌
2. 使用 `--verbose` 選項獲取詳細資訊
3. 在主專案 GitHub Issues 回報問題

## 📄 版本資訊

- **Version**: 2.0
- **Created**: 2025-08-20
- **Dependencies**: Node.js 18+, npm
- **License**: MIT
