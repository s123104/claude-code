# Claude Code 文檔自動同步工具

這是一套專業的自動爬取和同步工具，用於維護 Claude Code 的繁體中文文檔。

## 🚀 功能特色

### 基本版本 (`auto-doc-sync.js`)
- ✅ 自動爬取 Anthropic 官方文檔
- ✅ 同步 GitHub CHANGELOG
- ✅ 基本 HTML 到 Markdown 轉換
- ✅ 繁體中文翻譯
- ✅ 內容差異檢測

### 增強版本 (`enhanced-doc-sync.js`) 🌟
- ✅ **智能 HTML 解析** - 使用 cheerio 進行精確解析
- ✅ **高品質轉換** - 完整的 HTML 到 Markdown 轉換
- ✅ **批次處理** - 支援批次同步減少伺服器負載
- ✅ **錯誤恢復** - 指數退避重試機制
- ✅ **詳細報告** - 完整的同步報告和錯誤追蹤
- ✅ **內容驗證** - 智能內容差異檢測
- ✅ **性能監控** - 同步性能指標統計

## 📦 安裝依賴

```bash
cd scripts/doc-sync
npm install
```

## 🔧 使用方式

### 基本同步
```bash
# 同步所有文檔（推薦使用增強版）
node enhanced-doc-sync.js

# 僅同步 CHANGELOG
node enhanced-doc-sync.js --changelog-only

# 預覽模式（不實際修改檔案）
node enhanced-doc-sync.js --dry-run

# 強制更新所有文檔
node enhanced-doc-sync.js --force

# 詳細輸出
node enhanced-doc-sync.js --verbose
```

### 進階選項
```bash
# 僅同步指定頁面
node enhanced-doc-sync.js --target overview

# 設定批次大小
node enhanced-doc-sync.js --batch-size 5

# 組合選項
node enhanced-doc-sync.js --target mcp --verbose --dry-run
```

### NPM 腳本
```bash
# 在 scripts/doc-sync 目錄中可使用
npm run sync           # 完整同步
npm run sync:force     # 強制更新
npm run sync:dry-run   # 預覽模式
npm run sync:changelog # 僅 CHANGELOG
npm run sync:verbose   # 詳細輸出
```

## 📊 支援的文檔頁面

| 頁面 | 優先級 | 描述 |
|------|--------|------|
| `overview` | 1 | 概述頁面 |
| `quickstart` | 1 | 快速開始指南 |
| `sub-agents` | 2 | Subagents 專業代理系統 |
| `mcp` | 2 | Model Context Protocol |
| `cli-reference` | 2 | CLI 參考 |
| `settings` | 2 | 設定檔案 |
| `common-workflows` | 2 | 常用工作流程 |
| `sdk` | 2 | SDK 文檔 |
| `hooks-guide` | 3 | Hooks 指南 |
| `github-actions` | 3 | GitHub Actions 整合 |
| `security` | 3 | 安全設定 |
| `troubleshooting` | 3 | 疑難排解 |

完整列表請參考 `enhanced-doc-sync.js` 中的 `docPages` 配置。

## 📁 輸出結構

```
docs/anthropic-claude-code-zh-tw/
├── overview.md                 # 概述
├── quickstart.md              # 快速開始
├── sub-agents.md              # Subagents 系統
├── mcp.md                     # MCP 文檔
├── cli-reference.md           # CLI 參考
└── ...                        # 其他文檔

claude-code-zh-tw.md           # 主文檔（CHANGELOG 更新）
sync-report-enhanced.json      # 同步報告
sync-error.json               # 錯誤報告（如有）
```

## 🛠️ 文檔格式

每個同步的文檔都包含：

```yaml
---
source: "https://docs.anthropic.com/en/docs/claude-code/page"
fetched_at: "2025-08-20T12:34:56+08:00"
updated_features: "2025-08-20T12:34:56+08:00 - 增強版自動同步官方文檔"
description: "頁面描述"
priority: 2
---

[原始文件連結](https://docs.anthropic.com/en/docs/claude-code/page)

# 頁面標題

文檔內容...
```

## 📈 同步報告

同步完成後會生成詳細報告 `sync-report-enhanced.json`：

```json
{
  "timestamp": "2025-08-20T12:34:56.789Z",
  "duration_seconds": 45,
  "changelog": {
    "versions_processed": 85,
    "latest_version": "1.0.85",
    "versions_updated": 25
  },
  "docs": {
    "updated": 3,
    "skipped": 8,
    "failed": 0,
    "total_pages": 11
  },
  "performance": {
    "pages_per_second": "0.24",
    "average_page_time": "4.1s"
  }
}
```

## 🔄 自動化設定

### GitHub Actions 整合
建立 `.github/workflows/sync-docs.yml`：

```yaml
name: 同步文檔
on:
  schedule:
    - cron: '0 2 * * *'  # 每日 02:00
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: 安裝依賴
        run: cd scripts/doc-sync && npm install
      - name: 同步文檔
        run: cd scripts/doc-sync && node enhanced-doc-sync.js
      - name: 提交變更
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add .
          git diff --staged --quiet || git commit -m "docs: 自動同步官方文檔 $(date +%Y-%m-%d)"
          git push
```

### Cron 任務
```bash
# 每日 2:00 自動同步
0 2 * * * cd /path/to/claude-code && node scripts/doc-sync/enhanced-doc-sync.js
```

## 🐛 疑難排解

### 常見問題

1. **依賴安裝失敗**
   ```bash
   cd scripts/doc-sync
   rm -rf node_modules package-lock.json
   npm install
   ```

2. **網路連線問題**
   ```bash
   # 使用重試機制
   node enhanced-doc-sync.js --verbose
   ```

3. **內容解析錯誤**
   ```bash
   # 檢查特定頁面
   node enhanced-doc-sync.js --target overview --verbose
   ```

### 錯誤代碼

- `0` - 成功
- `1` - 一般錯誤
- `2` - 網路錯誤
- `3` - 檔案系統錯誤

### 日誌等級

- `INFO` - 一般資訊
- `SUCCESS` - 成功訊息
- `WARNING` - 警告訊息
- `ERROR` - 錯誤訊息
- `VERBOSE` - 詳細資訊（需要 --verbose）
- `PROGRESS` - 進度資訊

## 🔧 高級配置

### 自訂翻譯映射
編輯 `enhanced-doc-sync.js` 中的 `translations` Map：

```javascript
this.translations = new Map([
  ['your-term', '您的翻譯'],
  // ... 更多翻譯
]);
```

### 調整批次大小
```bash
# 降低伺服器負載
node enhanced-doc-sync.js --batch-size 1

# 提高同步速度
node enhanced-doc-sync.js --batch-size 10
```

### 自訂頁面優先級
編輯 `docPages` 配置中的 `priority` 值：
- `1` - 最高優先級（核心頁面）
- `2` - 中等優先級（重要頁面）
- `3` - 低優先級（輔助頁面）

## 📞 技術支援

如有問題請：
1. 檢查 `sync-error.json` 錯誤報告
2. 使用 `--verbose` 查看詳細日誌
3. 在 GitHub Issues 中回報問題

## 📄 許可證

MIT License - 請參考 LICENSE 文件。
