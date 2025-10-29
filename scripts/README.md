# Claude Code 文檔自動同步工具

這是一套專業的自動爬取和同步工具，用於維護 Claude Code 的繁體中文文檔。

## 🎯 核心工具

### 1. 文檔同步至 index.html (`sync-index-docs.js`) ⭐ 新增
- ✅ **自動掃描** - 掃描所有繁體中文文檔
- ✅ **元資料提取** - 自動提取版本、時間、功能、場景、客群
- ✅ **智能分析** - 從文檔內容智能推斷資訊
- ✅ **自動更新** - 同步更新到 index.html 專案卡片
- ✅ **格式統一** - 確保所有卡片格式一致

**快速使用**：
```bash
# 在 scripts 目錄執行
npm run sync-index        # 執行同步
npm run sync-index:dry    # 乾模式預覽

# 或直接執行
node sync-index-docs.js
node sync-index-docs.js --dry-run
```

### 2. 官方文檔爬取工具 (`doc-sync/`) 🌟 最新

#### auto-discover-sync.js（推薦）
- ✅ **自動發現** - 自動掃描官方網站發現所有文檔（53+ 頁）
- ✅ **直接下載** - 直接從 .md 端點下載完整 Markdown
- ✅ **智能同步** - 僅更新變更的文檔
- ✅ **自動清理** - 自動刪除 404 不存在的文檔
- ✅ **雙語支援** - 繁中/英文雙版本自動回退
- ✅ **錯誤處理** - 自動重試機制（3次）
- ✅ **詳細報告** - 完整的同步報告和錯誤分類

#### zh-tw-translator-simple.cjs（翻譯工具）
- ✅ 技術術語智能翻譯
- ✅ CHANGELOG 項目翻譯
- ✅ 保持程式碼和指令原樣
- ✅ 可獨立使用或整合

## 📦 安裝依賴

```bash
cd scripts/doc-sync
npm install
```

## 🔧 使用方式

### 基本同步
```bash
# 使用 Shell 包裝器（推薦）
cd scripts/doc-sync
./auto-discover.sh                  # 完整同步

# 或直接使用 Node.js
node auto-discover-sync.js          # 標準同步
node auto-discover-sync.js --force  # 強制更新所有
node auto-discover-sync.js --dry-run # 預覽模式
node auto-discover-sync.js --verbose # 詳細輸出
```

### 進階選項
```bash
# 僅發現文檔列表（不下載）
./auto-discover.sh discover

# 強制更新所有文檔
./auto-discover.sh force

# 查看最新報告
./auto-discover.sh report

# 顯示說明
./auto-discover.sh help
```

## 📊 支援的文檔

自動發現系統會掃描官方網站並同步所有可用文檔，目前包括：

- **核心文檔**：overview, quickstart, setup
- **功能文檔**：sub-agents, plugins, skills, hooks
- **整合文檔**：mcp, github-actions, gitlab-ci-cd, jetbrains, vs-code
- **配置文檔**：settings, model-config, network-config, terminal-config
- **雲端部署**：amazon-bedrock, google-vertex-ai
- **安全與合規**：security, iam, legal-and-compliance
- **監控與分析**：monitoring-usage, costs, analytics
- **其他**：troubleshooting, cli-reference, slash-commands

**總計**：43 個有效文檔（會自動更新）

## 📁 輸出結構

```
docs/anthropic-claude-code-zh-tw/
├── README.md                  # 索引文件
├── overview.md                # 概述
├── quickstart.md              # 快速開始
├── sub-agents.md              # 子代理系統
├── plugins.md                 # 插件系統
├── mcp.md                     # MCP 協議
└── ...                        # 其他 40+ 文檔

auto-discover-sync-report.json # 同步報告（根目錄）
```

## 🛠️ 文檔格式

每個同步的文檔都包含 front-matter 元資料：

```yaml
---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/page.md"
fetched_at: "2025-10-29T22:13:00+08:00"
---

# 文檔內容（完整 Markdown 格式）
...
```

## 📈 同步報告

同步完成後會生成詳細報告 `auto-discover-sync-report.json`：

```json
{
  "timestamp": "2025-10-29T14:13:45.123Z",
  "duration": "13.24",
  "stats": {
    "discovered": 53,
    "existing": 43,
    "new": 0,
    "updated": 43,
    "deleted": 10,
    "skipped": 0,
    "failed": 0
  },
  "discoveredDocs": ["overview", "quickstart", ...]
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
        run: cd scripts/doc-sync && ./auto-discover.sh force
      - name: 提交變更
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add docs/anthropic-claude-code-zh-tw/
          git diff --staged --quiet || git commit -m "docs: 自動同步官方文檔 $(date +%Y-%m-%d)"
          git push
```

### Cron 任務
```bash
# 每日 2:00 自動同步
0 2 * * * cd /path/to/claude-code/scripts/doc-sync && ./auto-discover.sh
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
   # 使用詳細輸出查看錯誤
   cd scripts/doc-sync && node auto-discover-sync.js --verbose
   ```

3. **404 文檔問題**
   ```bash
   # 強制更新會自動清理 404 文檔
   cd scripts/doc-sync && ./auto-discover.sh force
   ```

### 錯誤代碼

- `0` - 成功
- `1` - 一般錯誤
- `130` - 使用者中斷

## 📞 技術支援

如有問題請：
1. 檢查 `auto-discover-sync-report.json` 同步報告
2. 使用 `--verbose` 查看詳細日誌
3. 在 GitHub Issues 中回報問題

## 📄 許可證

MIT License - 請參考 LICENSE 文件。

---

**最後更新**: 2025-10-29  
**版本**: 3.0  
**維護者**: s123104
