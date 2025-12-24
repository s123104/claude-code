# Claude Code 腳本工具集

專業的自動化工具集，用於維護 Claude Code 專案的文檔、版本同步和品質檢查。

## 📁 檔案結構

```
scripts/
├── README.md                    # 本說明文件
├── auto-maintenance.sh          # 🤖 綜合自動維護腳本（推薦）
├── sync-changelog.js            # ⭐ CHANGELOG 自動同步
├── sync-html-versions.js        # 🆕 SSOT 版本同步到 index.html
├── sync-index-docs.js           # 📊 文檔元資料同步到 index.html
├── validate-docs.sh             # 🔍 文檔驗證工具
├── sync-versions.sh             # 🔄 版本同步機制
├── update-all-docs.sh           # 📝 批次更新文檔
├── batch-sync-projects.sh       # 🚀 18 個專案批次同步
├── setup-git-hooks.sh           # 🔧 Git hooks 設定
├── import-mcp-servers.sh        # 🔌 MCP 伺服器導入
└── doc-sync/                    # 📥 官方文檔同步模組
    ├── README.md                # 模組說明
    ├── auto-discover-sync.js    # 自動發現與同步（已過時）
    ├── auto-discover.sh         # Shell 包裝器
    ├── zh-tw-translator-simple.cjs  # 繁體中文翻譯
    ├── package.json             # 依賴配置
    └── package-lock.json        # 版本鎖定
```

## 🤖 綜合自動維護腳本（推薦）

### auto-maintenance.sh

整合所有維護任務的一站式腳本，用於同步、驗證、更新和提交。

**快速使用**：

```bash
# 完整維護（同步 + 驗證 + 更新 + 提交）
bash scripts/auto-maintenance.sh --full

# 僅同步專案
bash scripts/auto-maintenance.sh --sync

# 僅驗證文檔
bash scripts/auto-maintenance.sh --validate

# 預覽模式（不實際執行）
bash scripts/auto-maintenance.sh --full --dry-run

# 顯示幫助
bash scripts/auto-maintenance.sh --help
```

**選項說明**：

| 選項 | 說明 |
|------|------|
| `--full` | 完整維護（所有步驟） |
| `--sync` | 同步 analysis-projects 專案 |
| `--validate` | 驗證文檔品質 |
| `--update` | 更新文檔日期 |
| `--commit` | 自動提交變更 |
| `--dry-run` | 預覽模式 |

## 🎯 核心工具

### 1. CHANGELOG 同步工具 (`sync-changelog.js`) ⭐ 最新

從 `claude-code-changelog-2.0-zh-tw.md` 自動同步到主文檔，確保內容一致性。

**核心功能**：

- ✅ **自動讀取** - 從專用 CHANGELOG 文件讀取
- ✅ **智能替換** - 精確定位並替換主文檔區塊
- ✅ **格式保留** - 保持元資料和結構完整
- ✅ **去重處理** - 自動清理重複內容
- ✅ **版本追蹤** - 記錄同步時間和統計

**快速使用**：

```bash
node scripts/sync-changelog.js
```

**使用場景**：

- 更新 CHANGELOG 後同步到主文檔
- 確保 CHANGELOG 區塊內容一致
- 自動化文檔維護流程

### 2. 文檔同步至 index.html (`sync-index-docs.js`) 📊

自動提取文檔元資料並同步更新到 `index.html` 專案卡片。

**核心功能**：

- ✅ **自動掃描** - 掃描所有繁體中文文檔（20+ 個）
- ✅ **元資料提取** - 版本、時間、功能、場景、客群
- ✅ **智能推斷** - 從文檔內容智能分析資訊
- ✅ **自動更新** - 同步更新到 index.html 專案卡片
- ✅ **格式統一** - 確保所有卡片格式一致

**快速使用**：

```bash
node scripts/sync-index-docs.js
node scripts/sync-index-docs.js --dry-run  # 預覽模式
```

### 3. 官方文檔爬取工具 (`doc-sync/`) 🌟

完整的官方文檔自動發現、下載、翻譯和同步系統。

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
    - cron: "0 2 * * *" # 每日 02:00
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "18"
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

### 4. 文檔驗證工具 (`validate-docs.sh`) 🔍

全面的文檔品質檢查系統，確保連結有效性和內容品質。

**核心功能**：

- ✅ **Markdown 語法檢查** - YAML front matter、標題層級、程式碼區塊
- ✅ **連結驗證** - 內部連結、圖片連結、外部連結可達性
- ✅ **結構分析** - 文檔結構、標點符號、表格格式
- ✅ **版本一致性** - 版本資訊、日期格式檢查
- ✅ **內容品質** - 檔案大小、TODO 檢查、重複標題

**快速使用**：

```bash
bash scripts/validate-docs.sh              # 完整驗證
bash scripts/validate-docs.sh --no-external  # 跳過外部連結
bash scripts/validate-docs.sh --quick-fix    # 快速修復
```

### 5. SSOT 版本同步工具 (`sync-html-versions.js`) 🆕

從 SSOT (config/metadata.json) 自動同步版本資訊到 index.html。

**核心功能**：

- ✅ **SSOT 讀取** - 從 metadata.json 讀取最新版本資訊
- ✅ **精確替換** - 僅更新 meta 標籤和 footer，不影響專案卡片
- ✅ **Dry Run 模式** - 預覽變更不實際寫入
- ✅ **詳細日誌** - 顯示每個替換的詳細資訊

**快速使用**：

```bash
node scripts/sync-html-versions.js              # 執行同步
node scripts/sync-html-versions.js --dry-run    # 預覽模式
node scripts/sync-html-versions.js --verbose    # 詳細輸出
```

### 6. 專案版本同步工具 (`sync-versions.sh`, `update-all-docs.sh`) 🔄

自動同步專案版本資訊到對應文檔。

**核心功能**：

- ✅ **版本掃描** - 自動掃描 analysis-projects/ 的 Git 版本
- ✅ **文檔更新** - 批次更新對應的繁中文檔版本資訊
- ✅ **多源支援** - Git tags、package.json、Cargo.toml
- ✅ **報告生成** - 完整的版本同步報告

**快速使用**：

```bash
bash scripts/sync-versions.sh           # 完整版本同步
bash scripts/update-all-docs.sh         # 批次更新文檔
```

### 7. 專案同步工具 (`batch-sync-projects.sh`) 🚀

批次同步 18 個 Claude Code 相關專案到最新版本。

**核心功能**：

- ✅ **批次 Git 同步** - fetch、reset、clean、pull
- ✅ **版本提取** - tags、commit hash、最後更新時間
- ✅ **詳細報告** - 成功/失敗統計、版本記錄

**快速使用**：

```bash
bash scripts/batch-sync-projects.sh
# 查看報告：PROJECT-SYNC-REPORT.md
```

### 8. Git 自動化工具 (`setup-git-hooks.sh`) 🔧

設定 Git Hooks 實現提交品質自動檢查。

**核心功能**：

- ✅ **commit-msg Hook** - Conventional Commits 格式驗證
- ✅ **pre-commit Hook** - 文檔驗證、大檔案檢查
- ✅ **post-commit Hook** - 版本提醒、CHANGELOG 提示
- ✅ **commitlint 配置** - 自動生成配置檔案

**快速使用**：

```bash
bash scripts/setup-git-hooks.sh          # 安裝 hooks
bash scripts/setup-git-hooks.sh --uninstall  # 移除 hooks
```

### 9. MCP 伺服器導入工具 (`import-mcp-servers.sh`) 🔌

從 Claude Desktop 配置自動導入 MCP 伺服器到 Claude Code。

**核心功能**：

- ✅ **配置解析** - 解析 Claude Desktop JSON 配置
- ✅ **自動導入** - 批次導入所有 MCP 伺服器
- ✅ **配置轉換** - 自動轉換為 Claude Code 格式

**快速使用**：

```bash
bash scripts/import-mcp-servers.sh
```

## 🔄 自動化設定

### GitHub Actions 整合

建立 `.github/workflows/sync-docs.yml`：

```yaml
name: 同步文檔
on:
  schedule:
    - cron: "0 2 * * *" # 每日 02:00
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "18"
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
# 每日 2:00 自動同步官方文檔
0 2 * * * cd /path/to/claude-code/scripts/doc-sync && ./auto-discover.sh

# 每日 3:00 同步專案版本
0 3 * * * cd /path/to/claude-code && bash scripts/sync-versions.sh

# 每日 4:00 驗證文檔品質
0 4 * * * cd /path/to/claude-code && bash scripts/validate-docs.sh
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

4. **Git Hooks 權限問題**

   ```bash
   chmod +x .git/hooks/*
   ```

5. **文檔驗證失敗**
   ```bash
   # 查看詳細日誌
   cat scripts/validation.log
   # 快速修復常見問題
   bash scripts/validate-docs.sh --quick-fix
   ```

### 錯誤代碼

- `0` - 成功
- `1` - 一般錯誤
- `130` - 使用者中斷

## 📊 工具使用統計

| 工具                   | 類別     | 維護難度 | 使用頻率           |
| ---------------------- | -------- | -------- | ------------------ |
| sync-changelog.js      | 文檔同步 | 低       | 每次更新 CHANGELOG |
| sync-html-versions.js  | SSOT 同步| 低       | 每次版本更新       |
| sync-index-docs.js     | 文檔同步 | 中       | 每次文檔更新       |
| doc-sync/              | 文檔同步 | 中       | 每日自動           |
| validate-docs.sh       | 品質檢查 | 低       | 每次提交前         |
| sync-versions.sh       | 版本管理 | 中       | 每週/每次發布      |
| batch-sync-projects.sh | 專案管理 | 低       | 每週/按需          |
| setup-git-hooks.sh     | 自動化   | 低       | 一次性設定         |
| import-mcp-servers.sh  | MCP 整合 | 低       | 按需使用           |

## 📞 技術支援

如有問題請：

1. 查看對應工具的報告文件（`*-report.md`）
2. 使用 `--verbose` 或 `--help` 查看詳細資訊
3. 檢查日誌文件（`scripts/*.log`）
4. 在 GitHub Issues 中回報問題

## 📄 許可證

MIT License - 請參考 LICENSE 文件。

---

**最後更新**: 2025-12-25  
**版本**: 5.1  
**維護者**: s123104  
**腳本總數**: 10 個核心工具 + doc-sync 模組

## 📦 npm 腳本

透過 `package.json` 可使用以下 npm 命令：

```bash
npm run sync:all        # 同步專案並更新 index.html
npm run sync:index      # 僅更新 index.html
npm run sync:projects   # 僅同步專案
npm run validate        # 驗證文檔（跳過外部連結）
npm run validate:full   # 完整驗證（含外部連結）
npm run update:docs     # 批次更新文檔
npm run setup:hooks     # 設定 Git hooks
npm start               # 啟動本地開發伺服器
```

## 🔄 GitHub Actions 自動化

專案已配置 GitHub Actions 自動化：

- **sync-docs.yml**: 每日自動同步專案並更新文檔
- **validate-pr.yml**: PR 時自動驗證文檔品質

觸發時間：每日 UTC 18:00（台灣時間 02:00）
