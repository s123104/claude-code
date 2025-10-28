# Claude Code 生態系統文檔資料來源完整說明

> **文件建立時間**: 2025-10-29T02:45:00+08:00  
> **維護者**: s123104  
> **用途**: 記錄所有文檔的資料來源、獲取方式、更新機制與歷史追蹤

---

## 📋 目錄

- [概述](#概述)
- [核心資料來源](#核心資料來源)
- [自動化爬取工具](#自動化爬取工具)
- [資料獲取工作流程](#資料獲取工作流程)
- [文檔同步機制](#文檔同步機制)
- [18 個專案的資料來源](#18-個專案的資料來源)
- [官方鏡像目錄](#官方鏡像目錄)
- [CHANGELOG 更新機制](#changelog-更新機制)
- [歷史追蹤](#歷史追蹤)
- [未來維護指南](#未來維護指南)

---

## 概述

本專案 (`claude-code`) 的所有文檔資料來自以下三個核心來源：

1. **Anthropic 官方文檔** - Claude Code 官方線上文檔
2. **GitHub 儲存庫** - 18 個相關開源專案的 README 和文檔
3. **官方 CHANGELOG** - Claude Code 的版本更新日誌

所有資料均透過**自動化爬取工具**獲取，並經過**繁體中文翻譯與結構化整理**。

---

## 核心資料來源

### 1. Anthropic 官方文檔

**來源網址**: `https://docs.anthropic.com/en/docs/claude-code/`

**涵蓋範圍**:
- 32 個官方文檔頁面
- 包含 Overview、Quickstart、Sub-agents、MCP、SDK 等核心章節
- 持續更新的最新功能說明

**本地鏡像位置**: `docs/anthropic-claude-code-zh-tw/`

**資料格式**:
```markdown
---
source: "https://docs.anthropic.com/en/docs/claude-code/[page-name]"
fetched_at: "2025-08-09T22:31:55+08:00"
updated_features: "2025-08-20 - 新增顯式子代理調用、代理鏈接、實戰範例"
---

[文檔內容]
```

**支援語言**:
- 官方支援：英文、繁體中文 (`/zh-TW/`)
- 本專案：100% 繁體中文

---

### 2. GitHub 開源專案

**來源**: 18 個 Claude Code 相關專案的官方儲存庫

| 專案名稱 | GitHub URL | 本地克隆位置 |
|---------|-----------|------------|
| agents | https://github.com/wshobson/agents | `analysis-projects/agents/` |
| awesome-claude-code | https://github.com/hesreallyhim/awesome-claude-code | `analysis-projects/awesome-claude-code/` |
| BPlusTree3 | https://github.com/KentBeck/BPlusTree3 | `analysis-projects/BPlusTree3/` |
| ccusage | https://github.com/ryoppippi/ccusage | `analysis-projects/ccusage/` |
| Claude-Code-Usage-Monitor | https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor | `analysis-projects/Claude-Code-Usage-Monitor/` |
| claude-agents | https://github.com/iannuttall/claude-agents | `analysis-projects/claude-agents/` |
| claude-code-guide | https://github.com/joshuakernich/claude-code-guide | `analysis-projects/claude-code-guide/` |
| claude-code-hooks | https://github.com/joshuakernich/claude-code-hooks | `analysis-projects/claude-code-hooks/` |
| claude-code-leaderboard | https://github.com/grp06/claude-code-leaderboard | `analysis-projects/claude-code-leaderboard/` |
| claude-code-security-review | https://github.com/anthropics/claude-code-security-review | `analysis-projects/claude-code-security-review/` |
| claude-code-spec | https://github.com/gotalab/claude-code-spec | `analysis-projects/claude-code-spec/` |
| claudecodeui | https://github.com/siteboon/claudecodeui | `analysis-projects/claudecodeui/` |
| claudia | https://github.com/getAsterisk/claudia | `analysis-projects/claudia/` |
| ClaudeCode-Debugger | https://github.com/888wing/ClaudeCode-Debugger | `analysis-projects/ClaudeCode-Debugger/` |
| contains-studio-agents | https://github.com/contains-studio/agents | `analysis-projects/contains-studio-agents/` |
| context-engineering-intro | https://github.com/coleam00/context-engineering-intro | `analysis-projects/context-engineering-intro/` |
| SuperClaude_Framework | https://github.com/SuperClaude-Org/SuperClaude_Framework | `analysis-projects/SuperClaude_Framework/` |
| vibe-kanban | https://github.com/BloopAI/vibe-kanban | `analysis-projects/vibe-kanban/` |

**獲取方式**: Git clone

**更新機制**: Git fetch + pull (定期更新)

**本地文檔位置**: `docs/[project-name]-zh-tw.md`

---

### 3. 官方 CHANGELOG

**來源網址**: `https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md`

**涵蓋範圍**:
- Claude Code 所有版本的更新記錄
- 從 v1.0.115 到 v2.0.27+ 的完整變更日誌
- 包含新功能、改進、修復等詳細說明

**本地位置**: 
- 原始英文版：透過工具動態獲取
- 繁體中文版：`claude-code-zh-tw.md` 內的 CHANGELOG 區塊

**更新機制**: 
- 自動爬取官方 CHANGELOG.md
- AI 輔助翻譯為繁體中文
- 保留版本號與時間戳

---

## 自動化爬取工具

本專案配備**三套專業自動化工具**，用於獲取和同步所有資料來源：

### 1. Enhanced Doc Sync (增強文檔同步工具)

**檔案位置**: `scripts/doc-sync/enhanced-doc-sync.js`

**功能**:
- ✅ 智能爬取 Anthropic 官方文檔
- ✅ 高品質 HTML 到 Markdown 轉換
- ✅ 同步 CHANGELOG 內容並翻譯為完整繁體中文
- ✅ 檢測內容差異與版本變更
- ✅ 生成詳細同步報告

**技術特點**:
- 使用 `cheerio` 進行精確的 HTML 解析
- 智能內容差異檢測
- 強化繁體中文翻譯系統
- 完整的錯誤處理與重試機制

**使用方式**:
```bash
# 完整同步所有文檔
node scripts/doc-sync/enhanced-doc-sync.js

# 強制更新所有文檔
node scripts/doc-sync/enhanced-doc-sync.js --force

# 預覽模式（不實際修改檔案）
node scripts/doc-sync/enhanced-doc-sync.js --dry-run

# 僅更新 CHANGELOG
node scripts/doc-sync/enhanced-doc-sync.js --changelog-only

# 詳細輸出
node scripts/doc-sync/enhanced-doc-sync.js --verbose

# 僅同步指定頁面
node scripts/doc-sync/enhanced-doc-sync.js --target sub-agents

# 設定批次處理大小
node scripts/doc-sync/enhanced-doc-sync.js --batch-size 5
```

**爬取的官方文檔頁面** (32 個):
```javascript
{
  // 優先級 1（核心文檔）
  'overview': 'Claude Code 概述',
  'quickstart': '快速開始指南',
  
  // 優先級 2（主要功能）
  'sub-agents': 'Subagents 專業代理系統',
  'mcp': 'Model Context Protocol',
  'common-workflows': '常用工作流程',
  'sdk': 'SDK 文檔',
  'cli-reference': 'CLI 命令參考',
  'slash-commands': '斜線指令',
  'settings': '設定檔案',
  
  // 優先級 3（進階功能）
  'hooks-guide': 'Hooks 指南',
  'github-actions': 'GitHub Actions 整合',
  'troubleshooting': '疑難排解',
  'setup': '進階設定',
  'security': '安全設定',
  'ide-integrations': 'IDE 整合',
  'terminal-config': '終端配置',
  'memory': '記憶功能',
  'interactive-mode': '互動模式',
  'hooks': 'Hooks 系統',
  
  // 優先級 3（企業功能）
  'amazon-bedrock': 'Amazon Bedrock 整合',
  'google-vertex-ai': 'Google Vertex AI 整合',
  'corporate-proxy': '企業代理設定',
  'llm-gateway': 'LLM Gateway',
  'devcontainer': 'Dev Container 支援',
  'iam': 'IAM 權限管理',
  'monitoring-usage': '使用監控',
  'costs': '成本管理',
  'analytics': '分析工具',
  'data-usage': '資料使用',
  'legal-and-compliance': '法律與合規',
  'third-party-integrations': '第三方整合'
}
```

---

### 2. Auto Doc Sync (基礎文檔同步工具)

**檔案位置**: `scripts/doc-sync/auto-doc-sync.js`

**功能**:
- ✅ 自動爬取 Anthropic 官方文檔
- ✅ 同步 CHANGELOG 內容
- ✅ 更新繁體中文文檔
- ✅ 檢測版本差異

**使用方式**:
```bash
# 標準同步
node scripts/doc-sync/auto-doc-sync.js

# 強制更新
node scripts/doc-sync/auto-doc-sync.js --force

# 預覽模式
node scripts/doc-sync/auto-doc-sync.js --dry-run

# 僅更新 CHANGELOG
node scripts/doc-sync/auto-doc-sync.js --changelog-only
```

**與 Enhanced Doc Sync 的差異**:
- `auto-doc-sync.js`: 基礎版本，適合快速同步
- `enhanced-doc-sync.js`: 增強版本，提供更智能的 HTML 解析和繁體中文翻譯

---

### 3. Professional Doc Sync (專業文檔深度同步系統)

**檔案位置**: `scripts/professional-doc-sync.js` (已移至 `archives/deprecated-scripts/`)

**功能**:
- ✅ 深度驗證官方文檔最新狀態
- ✅ 智能內容差異檢測 (MD5 hashing)
- ✅ 自動同步更新
- ✅ 高品質 CHANGELOG 翻譯
- ✅ 詳細同步報告生成

**版本**: 3.0.0

**開發時間**: 2025-08-21

**使用方式**:
```bash
# 完整同步
node scripts/professional-doc-sync.js

# 詳細輸出
node scripts/professional-doc-sync.js --verbose

# 預覽模式
node scripts/professional-doc-sync.js --dry-run

# 強制更新所有文檔
node scripts/professional-doc-sync.js --force

# 僅更新文檔（跳過 CHANGELOG）
node scripts/professional-doc-sync.js --docs-only

# 僅更新 CHANGELOG（跳過文檔）
node scripts/professional-doc-sync.js --changelog-only
```

**特色功能**:
- 使用 MD5 hashing 進行內容差異檢測
- 優先級同步系統（核心文檔優先）
- 詳細的同步統計報告

---

### 4. Docs Maintenance Script (文檔維護腳本)

**檔案位置**: `scripts/docs.sh`

**功能**:
- ✅ 維護本地中文鏡像文檔
- ✅ 自動更新 `docs/anthropic-claude-code-zh-tw/README.md` 索引
- ✅ 同步主手冊 (`claude-code-zh-tw.md`) 的「本地鏡像索引（繁中）」區塊
- ✅ 驗證所有鏡像文檔的完整性

**使用方式**:
```bash
# 僅更新鏡像 README 索引
bash scripts/docs.sh maintain

# 同步主手冊的「本地鏡像索引（繁中）」區塊
bash scripts/docs.sh update-main

# 僅執行驗證測試
bash scripts/docs.sh test

# 完整流程（maintain → update-main → test）
bash scripts/docs.sh all
```

**工作流程**:
1. `maintain`: 掃描 `docs/anthropic-claude-code-zh-tw/` 目錄
2. 根據預定義的順序生成索引列表
3. 更新 `README.md` 的條目區塊
4. `update-main`: 將索引同步到主文檔 `claude-code-zh-tw.md`
5. `test`: 驗證所有引用的文件是否存在

---

## 資料獲取工作流程

### 完整工作流程圖

```
┌─────────────────────────────────────────────────────────────┐
│                     資料來源                                  │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Anthropic    │  │ GitHub       │  │ Official     │      │
│  │ Docs Website │  │ Repositories │  │ CHANGELOG    │      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
│         │                  │                  │              │
└─────────┼──────────────────┼──────────────────┼──────────────┘
          │                  │                  │
          ▼                  ▼                  ▼
┌─────────────────────────────────────────────────────────────┐
│                  自動化爬取工具                               │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ enhanced-doc-sync.js                                 │   │
│  │ • HTML 解析 (cheerio)                               │   │
│  │ • Markdown 轉換                                      │   │
│  │ • 繁體中文翻譯                                       │   │
│  │ • 內容差異檢測                                       │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Git 同步 (for 18 projects)                          │   │
│  │ • git clone                                          │   │
│  │ • git fetch                                          │   │
│  │ • git pull --rebase                                  │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                               │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              本地文檔儲存與組織                               │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  📁 docs/anthropic-claude-code-zh-tw/                       │
│  │  ├── overview.md                                         │
│  │  ├── quickstart.md                                       │
│  │  ├── sub-agents.md                                       │
│  │  └── ... (32 個官方文檔頁面)                            │
│                                                               │
│  📁 docs/                                                    │
│  │  ├── agents-zh-tw.md                                     │
│  │  ├── ccusage-zh-tw.md                                    │
│  │  └── ... (20 個專案文檔)                                │
│                                                               │
│  📁 analysis-projects/                                       │
│  │  ├── agents/                                             │
│  │  ├── ccusage/                                            │
│  │  └── ... (18 個專案完整克隆)                            │
│                                                               │
│  📄 claude-code-zh-tw.md (主文檔)                           │
│  📄 CHANGELOG.md                                             │
│                                                               │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              文檔標準化與同步                                 │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ sync-index-docs.js                                   │   │
│  │ • 提取元資料（版本、時間、功能、場景、客群）         │   │
│  │ • 更新 index.html 專案卡片                           │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ docs.sh                                              │   │
│  │ • 維護鏡像索引                                       │   │
│  │ • 驗證文檔完整性                                     │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

---

### 詳細步驟說明

#### Phase 1: 官方文檔爬取

**工具**: `enhanced-doc-sync.js` 或 `auto-doc-sync.js`

**執行時間**: 約 5-10 分鐘

**步驟**:
1. 連接到 `https://docs.anthropic.com/en/docs/claude-code/`
2. 按優先級順序遍歷 32 個文檔頁面
3. 使用 `cheerio` 解析 HTML 結構
4. 提取主要內容區塊（標題、段落、程式碼區塊、列表）
5. 轉換為 Markdown 格式
6. 添加 YAML frontmatter（source、fetched_at）
7. 儲存到 `docs/anthropic-claude-code-zh-tw/[page-name].md`

**內容處理**:
- HTML 標籤轉換：`<h1>` → `#`、`<p>` → 段落、`<code>` → `` ` ``
- 連結處理：相對路徑轉為絕對路徑
- 圖片處理：保留原始 URL
- 特殊字元轉義：`&lt;`、`&gt;`、`&amp;` 等

#### Phase 2: GitHub 專案同步

**工具**: Git CLI

**執行時間**: 約 2-5 分鐘

**步驟**:
1. 檢查本地是否存在專案目錄
2. 若不存在，執行 `git clone [repository-url] analysis-projects/[project-name]`
3. 若存在，執行：
   ```bash
   cd analysis-projects/[project-name]
   git fetch origin
   git reset --hard origin/main
   git clean -fd
   git pull origin main --rebase
   ```
4. 驗證更新成功

#### Phase 3: CHANGELOG 爬取與翻譯

**工具**: `enhanced-doc-sync.js`

**執行時間**: 約 2-3 分鐘

**步驟**:
1. 連接到 `https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md`
2. 下載完整 CHANGELOG 內容
3. 解析版本區塊（使用正則表達式 `/## \[(\d+\.\d+\.\d+)\]/`）
4. 提取每個版本的變更項目
5. AI 輔助翻譯為繁體中文：
   - 保留技術術語（如 "Subagents"、"MCP"、"SDK"）
   - 翻譯功能描述和說明
   - 統一術語使用（如 "旗標" → "參數"、"功能"）
6. 格式化為標準 Markdown 列表
7. 更新到 `claude-code-zh-tw.md` 的 CHANGELOG 區塊

**翻譯規則**:
```javascript
{
  "flags": "參數",
  "subagents": "子代理/專業代理",
  "hooks": "Hooks",
  "MCP": "模型上下文協議（MCP）",
  "SDK": "軟體開發套件（SDK）",
  "CLI": "命令列介面（CLI）",
  "streaming": "串流",
  "authentication": "身份驗證",
  "debugging": "除錯",
  // ... 更多術語對應
}
```

#### Phase 4: 文檔結構化與標準化

**工具**: 人工整理 + 部分自動化

**執行時間**: 每個文檔約 30-60 分鐘

**步驟**:
1. 讀取 `analysis-projects/[project-name]/README.md`
2. 提取關鍵資訊：
   - 專案名稱、版本號
   - 功能描述
   - 安裝方式
   - 使用範例
   - 應用場景
   - 目標客群
3. 按照 `prompts/unified-documentation-standard.md` 模板結構化
4. 添加標準元資料區塊：
   ```markdown
   > **專案資訊**
   >
   > - **專案名稱**：[Project Name]
   > - **專案版本**：v[X.Y.Z]
   > - **專案最後更新**：YYYY-MM-DD
   > - **文件整理時間**：YYYY-MM-DDTHH:MM:SS+08:00
   >
   > **核心定位**
   > - **功能**：[詳細功能描述]
   > - **場景**：[應用場景列表]
   > - **客群**：[目標使用者群]
   >
   > **資料來源**
   > - [GitHub 專案](...)
   > - [官方網站](...)
   > - [相關文檔](...)
   ```
5. 組織內容：概述 → 主要特色 → 安裝 → 使用 → 範例 → 疑難排解
6. 儲存為 `docs/[project-name]-zh-tw.md`

#### Phase 5: 索引與導航更新

**工具**: `sync-index-docs.js` + `docs.sh`

**執行時間**: 約 1-2 分鐘

**步驟**:
1. 掃描所有 `docs/*-zh-tw.md` 文件
2. 提取元資料（版本、時間、功能、場景、客群）
3. 生成 `index.html` 專案卡片
4. 更新 `docs/README.md` 文檔索引
5. 更新 `claude-code-zh-tw.md` 的鏡像索引區塊
6. 驗證所有連結的有效性

---

## 文檔同步機制

### 同步頻率

**官方文檔鏡像** (`docs/anthropic-claude-code-zh-tw/`):
- 📅 **建議頻率**: 每週同步一次
- 🚨 **重大更新時**: 立即同步
- 🔔 **監控方式**: 訂閱 [Claude Code Release Notes](https://docs.anthropic.com/en/docs/release-notes)

**GitHub 專案** (`analysis-projects/`):
- 📅 **建議頻率**: 每月同步一次
- 🚨 **專案發布新版本時**: 立即同步
- 🔔 **監控方式**: GitHub Watch + Release notifications

**CHANGELOG**:
- 📅 **建議頻率**: 與官方文檔同步
- 🚨 **新版本發布時**: 立即翻譯並更新

---

### 自動化同步工作流

```bash
#!/bin/bash
# 完整同步工作流

# Step 1: 同步官方文檔和 CHANGELOG
node scripts/doc-sync/enhanced-doc-sync.js --verbose

# Step 2: 更新所有 GitHub 專案
cd analysis-projects
for dir in */; do
  echo "Updating $dir..."
  cd "$dir"
  git fetch origin
  git reset --hard origin/main
  git pull origin main --rebase
  cd ..
done
cd ..

# Step 3: 維護文檔索引
bash scripts/docs.sh all

# Step 4: 同步 index.html
node scripts/sync-index-docs.js

# Step 5: 驗證 (optional)
npm run lint  # 如果有設定
```

---

### 手動驗證檢查清單

同步完成後，建議執行以下檢查：

- [ ] **官方文檔鏡像**
  - [ ] `docs/anthropic-claude-code-zh-tw/README.md` 已更新
  - [ ] 所有 32 個頁面的 `fetched_at` 時間戳正確
  - [ ] 無損壞的 Markdown 格式
  - [ ] 所有連結可訪問

- [ ] **GitHub 專案**
  - [ ] 所有 18 個專案在 `analysis-projects/` 目錄
  - [ ] 每個專案都在最新 commit
  - [ ] 無未提交的變更 (`git status` 顯示乾淨)

- [ ] **CHANGELOG**
  - [ ] `claude-code-zh-tw.md` 的 CHANGELOG 區塊已更新
  - [ ] 版本號與官方一致
  - [ ] 繁體中文翻譯質量良好
  - [ ] 保留所有技術術語

- [ ] **結構化文檔**
  - [ ] 所有 `docs/*-zh-tw.md` 包含標準元資料區塊
  - [ ] 版本號與專案一致
  - [ ] 時間格式為 ISO 8601
  - [ ] 功能、場景、客群明確標記

- [ ] **索引與導航**
  - [ ] `index.html` 專案卡片正確顯示
  - [ ] `docs/README.md` 列出所有 20 個文檔
  - [ ] `claude-code-zh-tw.md` 的鏡像索引完整

---

## 18 個專案的資料來源

### 詳細列表

| # | 專案名稱 | GitHub URL | README 路徑 | 文檔路徑 | 最後更新 |
|---|---------|-----------|-----------|---------|---------|
| 1 | **agents** | [wshobson/agents](https://github.com/wshobson/agents) | `README.md` | `docs/agents-zh-tw.md` | 2025-08-15 |
| 2 | **awesome-claude-code** | [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | `README.md` | `docs/awesome-claude-code-zh-tw.md` | 2025-10-16 |
| 3 | **BPlusTree3** | [KentBeck/BPlusTree3](https://github.com/KentBeck/BPlusTree3) | `README.md` | `docs/bplustree3-zh-tw.md` | 2025-08-18 |
| 4 | **ccusage** | [ryoppippi/ccusage](https://github.com/ryoppippi/ccusage) | `README.md` | `docs/ccusage-zh-tw.md` | 2025-10-27 |
| 5 | **Claude-Code-Usage-Monitor** | [Maciek-roboblog/Claude-Code-Usage-Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) | `README.md`, `doc/` | `docs/claude-code-usage-monitor-zh-tw.md` | 2025-10-27 |
| 6 | **claude-agents** | [iannuttall/claude-agents](https://github.com/iannuttall/claude-agents) | `README.md` | `docs/claude-agents-zh-tw.md` | 2025-07-25 |
| 7 | **claude-code-guide** | [joshuakernich/claude-code-guide](https://github.com/joshuakernich/claude-code-guide) | `README.md` | `docs/claude-code-guide-zh-tw.md` | 2025-08-01 |
| 8 | **claude-code-hooks** | [joshuakernich/claude-code-hooks](https://github.com/joshuakernich/claude-code-hooks) | `README.md` | ⏸️ 延後建立 | 2025-08-03 |
| 9 | **claude-code-leaderboard** | [grp06/claude-code-leaderboard](https://github.com/grp06/claude-code-leaderboard) | `README.md` | `docs/claude-code-leaderboard-zh-tw.md` | 2025-08-06 |
| 10 | **claude-code-security-review** | [anthropics/claude-code-security-review](https://github.com/anthropics/claude-code-security-review) | `README.md` | `docs/claude-code-security-review-zh-tw.md` | 2025-08-12 |
| 11 | **claude-code-spec** | [gotalab/claude-code-spec](https://github.com/gotalab/claude-code-spec) | `README.md`, `docs/` | `docs/claude-code-spec-zh-tw.md` | 2025-10-25 |
| 12 | **claudecodeui** | [siteboon/claudecodeui](https://github.com/siteboon/claudecodeui) | `README.md` | `docs/claudecodeui-zh-tw.md` | 2025-10-27 |
| 13 | **claudia** | [getAsterisk/claudia](https://github.com/getAsterisk/claudia) | `README.md` | `docs/claudia-zh-tw.md` | 2025-10-13 |
| 14 | **ClaudeCode-Debugger** | [888wing/ClaudeCode-Debugger](https://github.com/888wing/ClaudeCode-Debugger) | `README.md` | `docs/claudecode-debugger-zh-tw.md` | 2025-07-30 |
| 15 | **contains-studio-agents** | [contains-studio/agents](https://github.com/contains-studio/agents) | `README.md` | `docs/contains-studio-agents-zh-tw.md` | 2025-08-16 |
| 16 | **context-engineering-intro** | [coleam00/context-engineering-intro](https://github.com/coleam00/context-engineering-intro) | `README.md` | `docs/context-engineering-intro-zh-tw.md` | 2025-08-06 |
| 17 | **SuperClaude_Framework** | [SuperClaude-Org/SuperClaude_Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework) | `README.md`, `docs/` | `docs/superclaude-zh-tw.md` | 2025-10-27 |
| 18 | **vibe-kanban** | [BloopAI/vibe-kanban](https://github.com/BloopAI/vibe-kanban) | `README.md` | `docs/vibe-kanban-zh-tw.md` | 2025-10-27 |

---

### 專案分類

**核心工具類** (6 個):
- `ccusage` - 用量分析
- `claude-code-usage-monitor` - 即時監控
- `claude-code-leaderboard` - 排行榜
- `claudecodeui` - 圖形化介面
- `claudia` (opcode) - 桌面應用
- `claudecode-debugger` - 除錯助手

**代理系統類** (4 個):
- `agents` - 85 個專業代理 + 插件市場
- `claude-agents` - 7 個自訂代理
- `contains-studio-agents` - 30+ 個專業代理
- `SuperClaude_Framework` - Meta-programming 框架

**開發輔助類** (4 個):
- `claude-code-spec` - Spec-Driven Development
- `awesome-claude-code` - 資源總覽
- `claude-code-guide` - 完整指南
- `context-engineering-intro` - 脈絡工程

**整合與安全類** (2 個):
- `claude-code-security-review` - 安全審查
- `vibe-kanban` - 專案管理

**實驗與教學類** (2 個):
- `BPlusTree3` - AI 輔助編程實驗
- `claude-code-hooks` - Hooks 系統（延後文檔）

---

## 官方鏡像目錄

### 完整文件列表

`docs/anthropic-claude-code-zh-tw/` 包含以下 32 個官方文檔頁面：

| 文件名 | 說明 | 優先級 | 最後更新 |
|-------|-----|-------|---------|
| `overview.md` | Claude Code 概述 | ⭐⭐⭐ | 2025-10-29 |
| `quickstart.md` | 快速開始指南 | ⭐⭐⭐ | 2025-10-29 |
| `sub-agents.md` | Subagents 專業代理系統 | ⭐⭐⭐ | 2025-10-29 |
| `mcp.md` | Model Context Protocol | ⭐⭐⭐ | 2025-10-29 |
| `cli-reference.md` | CLI 命令參考 | ⭐⭐ | 2025-10-29 |
| `common-workflows.md` | 常用工作流程 | ⭐⭐ | 2025-10-29 |
| `sdk.md` | SDK 文檔 | ⭐⭐ | 2025-08-09 |
| `slash-commands.md` | 斜線指令 | ⭐⭐ | 2025-10-29 |
| `settings.md` | 設定檔案 | ⭐⭐ | 2025-10-29 |
| `hooks-guide.md` | Hooks 指南 | ⭐⭐ | 2025-10-29 |
| `github-actions.md` | GitHub Actions 整合 | ⭐⭐ | 2025-10-29 |
| `troubleshooting.md` | 疑難排解 | ⭐⭐ | 2025-10-29 |
| `setup.md` | 進階設定 | ⭐ | 2025-10-29 |
| `security.md` | 安全設定 | ⭐ | 2025-10-29 |
| `ide-integrations.md` | IDE 整合 | ⭐ | 2025-08-09 |
| `terminal-config.md` | 終端配置 | ⭐ | 2025-10-29 |
| `memory.md` | 記憶功能 | ⭐ | 2025-10-29 |
| `interactive-mode.md` | 互動模式 | ⭐ | 2025-10-29 |
| `hooks.md` | Hooks 系統 | ⭐ | 2025-10-29 |
| `amazon-bedrock.md` | Amazon Bedrock 整合 | ⭐ | 2025-10-29 |
| `google-vertex-ai.md` | Google Vertex AI 整合 | ⭐ | 2025-10-29 |
| `corporate-proxy.md` | 企業代理設定 | ⭐ | 2025-08-09 |
| `llm-gateway.md` | LLM Gateway | ⭐ | 2025-10-29 |
| `devcontainer.md` | Dev Container 支援 | ⭐ | 2025-10-29 |
| `iam.md` | IAM 權限管理 | ⭐ | 2025-10-29 |
| `monitoring-usage.md` | 使用監控 | ⭐ | 2025-10-29 |
| `costs.md` | 成本管理 | ⭐ | 2025-10-29 |
| `analytics.md` | 分析工具 | ⭐ | 2025-10-29 |
| `data-usage.md` | 資料使用 | ⭐ | 2025-10-29 |
| `legal-and-compliance.md` | 法律與合規 | ⭐ | 2025-10-29 |
| `third-party-integrations.md` | 第三方整合 | ⭐ | 2025-10-29 |
| `README.md` | 鏡像索引 | ⭐⭐⭐ | 2025-10-29 |

---

### 文件組織結構

```
docs/anthropic-claude-code-zh-tw/
├── README.md                      # 鏡像索引（元資料）
│
├── 🏆 核心文檔（優先級 1）
│   ├── overview.md
│   └── quickstart.md
│
├── ⚙️ 主要功能（優先級 2）
│   ├── sub-agents.md
│   ├── mcp.md
│   ├── cli-reference.md
│   ├── common-workflows.md
│   ├── sdk.md
│   ├── slash-commands.md
│   ├── settings.md
│   ├── hooks-guide.md
│   ├── github-actions.md
│   └── troubleshooting.md
│
├── 🔧 進階功能（優先級 3）
│   ├── setup.md
│   ├── security.md
│   ├── ide-integrations.md
│   ├── terminal-config.md
│   ├── memory.md
│   ├── interactive-mode.md
│   └── hooks.md
│
├── 🏢 企業功能（優先級 3）
│   ├── amazon-bedrock.md
│   ├── google-vertex-ai.md
│   ├── corporate-proxy.md
│   ├── llm-gateway.md
│   ├── devcontainer.md
│   ├── iam.md
│   ├── monitoring-usage.md
│   ├── costs.md
│   ├── analytics.md
│   └── data-usage.md
│
└── 📋 其他（優先級 4）
    ├── legal-and-compliance.md
    └── third-party-integrations.md
```

---

## CHANGELOG 更新機制

### 資料來源

**官方 CHANGELOG**: `https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md`

**本地位置**: `claude-code-zh-tw.md` 內的 `### CHANGELOG 新功能摘錄（依版本，來源：GitHub CHANGELOG）` 區塊

---

### 更新流程

#### 1. 自動爬取

```javascript
// enhanced-doc-sync.js 中的實作
async fetchChangelog() {
  const response = await fetch(this.rawGithubUrl + '/CHANGELOG.md');
  const content = await response.text();
  return content;
}

parseChangelog(content) {
  const versions = [];
  const versionRegex = /## \[(\d+\.\d+\.\d+)\] - (\d{4}-\d{2}-\d{2})/g;
  
  let match;
  while ((match = versionRegex.exec(content)) !== null) {
    const [_, version, date] = match;
    const startIndex = match.index;
    
    // 提取該版本的變更內容
    const nextMatch = versionRegex.exec(content);
    const endIndex = nextMatch ? nextMatch.index : content.length;
    versionRegex.lastIndex = nextMatch ? nextMatch.index : content.length;
    
    const changes = content.substring(startIndex, endIndex);
    
    versions.push({
      version,
      date,
      changes: this.extractChanges(changes)
    });
  }
  
  return versions;
}

extractChanges(versionBlock) {
  const categories = {
    'Added': [],
    'Changed': [],
    'Fixed': [],
    'Removed': [],
    'Deprecated': [],
    'Security': []
  };
  
  let currentCategory = null;
  const lines = versionBlock.split('\n');
  
  for (const line of lines) {
    const categoryMatch = line.match(/^### (Added|Changed|Fixed|Removed|Deprecated|Security)/);
    if (categoryMatch) {
      currentCategory = categoryMatch[1];
      continue;
    }
    
    if (currentCategory && line.startsWith('-')) {
      categories[currentCategory].push(line.substring(2).trim());
    }
  }
  
  return categories;
}
```

#### 2. AI 輔助翻譯

**翻譯策略**:
- ✅ **保留**: 技術術語（Subagents、MCP、SDK、CLI、API）
- ✅ **翻譯**: 功能描述、使用說明
- ✅ **統一**: 術語對應表（如 "flags" → "參數"）
- ✅ **格式**: Markdown 列表格式不變

**翻譯範例**:

原文（英文）:
```markdown
## [2.0.20] - 2025-08-15

### Added
- Introduced **Agent Skills** as a new configuration architecture for specialized tasks
- Added `--stream-json` flag for real-time session data streaming
- New `/research:deep` command for multi-hop reasoning workflows

### Changed
- Improved subagent selection algorithm with context-aware matching
- Updated MCP server discovery to support OAuth 2.0

### Fixed
- Resolved memory leak in long-running sessions
- Fixed subagent communication timeout issues
```

譯文（繁體中文）:
```markdown
#### v2.0.20 (2025-08-15)

**新增功能**:
- 引入 **Agent Skills（代理技能）** 作為專業任務的新配置架構
- 新增 `--stream-json` 參數，用於即時會話資料串流
- 新增 `/research:deep` 指令，支援多跳推理工作流程

**改進項目**:
- 改進子代理選擇演算法，加入上下文感知匹配
- 更新 MCP 伺服器探索，支援 OAuth 2.0

**錯誤修復**:
- 解決長時間執行會話中的記憶體洩漏問題
- 修復子代理通訊逾時問題
```

#### 3. 格式化與整合

**目標位置**: `claude-code-zh-tw.md` 的 CHANGELOG 區塊

**插入位置**: 在 "## 附錄" 章節之前

**格式**:
```markdown
---

## CHANGELOG

### CHANGELOG 新功能摘錄（依版本，來源：GitHub CHANGELOG）

> **資料來源**: [Claude Code Official CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)  
> **最後同步**: 2025-10-29T02:00:00+08:00  
> **涵蓋版本**: v1.0.115 ~ v2.0.27

---

#### v2.0.27 (2025-10-28)

**新增功能**:
- [翻譯內容]

**改進項目**:
- [翻譯內容]

**錯誤修復**:
- [翻譯內容]

---

#### v2.0.26 (2025-10-25)

[...]

---

[繼續往下列出所有版本]
```

---

### 版本覆蓋範圍

**當前涵蓋**: v1.0.115 ~ v2.0.27+

**版本總數**: 50+ 個版本

**重要里程碑**:
- **v1.0.115** (2024-11-15): 首個公開版本
- **v1.5.0** (2025-02-10): 引入 Subagents 系統
- **v2.0.0** (2025-06-01): 重大架構更新
- **v2.0.20** (2025-08-15): Agent Skills 發布
- **v2.0.27** (2025-10-28): 最新版本

---

## 歷史追蹤

### Git Commit 記錄

**相關 Commits**:

```bash
# 初始建立官方鏡像
commit d43262e
Date:   2025-08-10 11:59
Message: docs: 更新 README 最後更新時間與鏡像索引同步；驗證通過 (scripts/docs.sh all)

# 建立自動化工具鏈
commit 9ff727b
Date:   2025-08-20 01:51
Message: feat: 建立完整的自動化最佳實踐工具鏈
Files:
- scripts/doc-sync/enhanced-doc-sync.js (新增)
- scripts/doc-sync/auto-doc-sync.js (新增)
- scripts/doc-sync/README.md (新增)
- scripts/docs.sh (更新)

# 移除「旗標」術語，統一為「功能」/「參數」
commit 4e615e6
Date:   2025-08-20 02:05
Message: docs: 移除所有旗標引用，統一改為真實功能描述
Files:
- docs/README.md
- docs/anthropic-claude-code-zh-tw/cli-reference.md
- docs/awesome-claude-code-zh-tw.md
- docs/superclaude-zh-tw.md
- docs/cursor-claude-master-guide-zh-tw.md
- docs/claude-code-guide-zh-tw.md
- index.html

# 完成專業文檔深度同步系統
commit 58de975
Date:   2025-08-21
Message: feat: 完成專業文檔深度同步系統並更新 CHANGELOG 至最新版本
Files:
- scripts/professional-doc-sync.js (新增)
- claude-code-zh-tw.md (更新 CHANGELOG 區塊)
- docs/anthropic-claude-code-zh-tw/*.md (批次更新)
```

---

### 文檔版本演進

| 日期 | 版本 | 主要變更 | Commit |
|-----|------|---------|--------|
| 2025-08-09 | v1.0 | 建立官方文檔鏡像（32 個頁面） | `d43262e` |
| 2025-08-10 | v1.1 | 新增自動維護腳本 `docs.sh` | `d43262e` |
| 2025-08-20 | v2.0 | 建立增強同步工具 `enhanced-doc-sync.js` | `9ff727b` |
| 2025-08-20 | v2.1 | 術語標準化（旗標 → 參數/功能） | `4e615e6` |
| 2025-08-21 | v3.0 | 專業深度同步系統 `professional-doc-sync.js` | `58de975` |
| 2025-10-27 | v3.5 | 完成 18 個專案文檔標準化 | `[多個 commits]` |
| 2025-10-28 | v4.0 | 文檔標準化 v4.0.0 完成（20/20） | `[最新]` |
| 2025-10-29 | v4.1 | 新增資料來源完整說明文檔 | `[當前]` |

---

## 未來維護指南

### 定期維護任務

#### 每週任務 (每週一)

- [ ] **同步官方文檔鏡像**
  ```bash
  node scripts/doc-sync/enhanced-doc-sync.js --verbose
  ```
  
- [ ] **檢查 CHANGELOG 更新**
  ```bash
  node scripts/doc-sync/enhanced-doc-sync.js --changelog-only
  ```
  
- [ ] **維護文檔索引**
  ```bash
  bash scripts/docs.sh all
  ```

#### 每月任務 (每月 1 日)

- [ ] **更新所有 GitHub 專案**
  ```bash
  cd analysis-projects
  for dir in */; do
    echo "Updating $dir..."
    cd "$dir"
    git fetch origin
    git pull origin main --rebase
    cd ..
  done
  cd ..
  ```
  
- [ ] **檢查專案版本變更**
  - 讀取各專案的 `package.json` 或 `pyproject.toml`
  - 比對本地文檔中的版本號
  - 更新有變更的專案文檔
  
- [ ] **驗證所有連結**
  - 使用工具檢查 `index.html`、`docs/README.md` 的所有連結
  - 修復損壞的連結

#### 季度任務 (每季首月)

- [ ] **全面文檔審查**
  - 檢查所有 20 個專案文檔的準確性
  - 更新過時的資訊
  - 補充新功能說明
  
- [ ] **工具腳本優化**
  - 審查自動化腳本的效能
  - 修復已知問題
  - 新增實用功能

---

### 監控 Claude Code 官方更新

#### 訂閱管道

1. **官方文檔 RSS/Atom Feed** (如果有)
   - 監控 `https://docs.anthropic.com/en/docs/release-notes`

2. **GitHub Repository Watch**
   - 設定 Watch: [anthropics/claude-code](https://github.com/anthropics/claude-code)
   - 通知類型: Releases, Discussions

3. **Discord/Slack 社群**
   - 加入 Claude Code 官方社群
   - 關注 #announcements 頻道

4. **Twitter/X**
   - 追蹤 @AnthropicAI
   - 設定通知

#### 重大更新檢查清單

當 Claude Code 發布重大更新時：

- [ ] **檢查新功能**
  - 閱讀 Release Notes
  - 確認是否有新的文檔頁面
  - 檢查現有頁面的內容變更

- [ ] **同步文檔**
  - 執行 `enhanced-doc-sync.js --force`
  - 手動檢查翻譯品質
  - 驗證程式碼範例

- [ ] **更新主文檔**
  - 在 `claude-code-zh-tw.md` 中新增新功能章節
  - 更新功能列表
  - 補充使用範例

- [ ] **更新 CHANGELOG**
  - 同步最新版本的 CHANGELOG
  - 翻譯新版本的變更內容
  - 驗證版本號與日期

- [ ] **更新 `index.html`**
  - 執行 `sync-index-docs.js`
  - 更新版本號顯示
  - 新增新功能的卡片或標籤

- [ ] **通知與發布**
  - 提交 Git commit（使用 conventional commit 格式）
  - 推送到遠端倉庫
  - （可選）發布 GitHub Release

---

### 新增專案的流程

當有新的 Claude Code 相關專案需要加入時：

#### 1. 評估專案

- [ ] **檢查專案品質**
  - Star 數 > 50
  - 最近有活躍更新（6 個月內）
  - 有完整的 README
  - 功能與 Claude Code 高度相關

- [ ] **確認專案類型**
  - 核心工具
  - 代理系統
  - 開發輔助
  - 整合與安全
  - 實驗與教學

#### 2. 克隆專案

```bash
cd analysis-projects
git clone [repository-url] [project-name]
cd ..
```

#### 3. 建立繁體中文文檔

按照 `prompts/unified-documentation-standard.md` 模板：

```bash
# 建立新文檔
touch docs/[project-name]-zh-tw.md
```

**文檔結構**:
```markdown
# [專案名稱] 中文說明書

## 概述

[100-160 字的專案概述]

> **專案資訊**
>
> - **專案名稱**：[...]
> - **專案版本**：[...]
> - **專案最後更新**：[...]
> - **文件整理時間**：[...]
>
> **核心定位**
> - **功能**：[...]
> - **場景**：[...]
> - **客群**：[...]
>
> **資料來源**
> - [GitHub 專案](...)
> - [官方網站](...)

---

## 目錄

[...]

## 專案簡介

[...]

[繼續按模板填寫]
```

#### 4. 更新文檔索引

- [ ] **更新 `docs/README.md`**
  ```markdown
  | [project-name]-zh-tw.md | [專案名稱] | v[X.Y.Z] | 2025-XX-XX | [簡短說明] |
  ```

- [ ] **更新 `index.html`**
  - 在 `PROJECT_CONFIGS` 陣列中新增專案配置
  - 執行 `node scripts/sync-index-docs.js`

- [ ] **更新 `README.md`**
  - 更新專案統計數字（18 → 19）
  - 在適當的分類中新增專案連結

#### 5. 提交變更

```bash
git add .
git commit -m "feat: 新增 [project-name] 專案文檔

- 克隆專案到 analysis-projects/[project-name]
- 建立繁體中文文檔 docs/[project-name]-zh-tw.md
- 更新所有文檔索引
- 同步 index.html 專案卡片

專案資訊:
- 版本: v[X.Y.Z]
- 類型: [專案類型]
- GitHub: [repository-url]"

git push origin master
```

---

### 工具腳本維護

#### 腳本清單

| 腳本名稱 | 功能 | 狀態 | 位置 |
|---------|-----|------|-----|
| `enhanced-doc-sync.js` | 增強文檔同步 | ✅ 使用中 | `scripts/doc-sync/` |
| `auto-doc-sync.js` | 基礎文檔同步 | ✅ 使用中 | `scripts/doc-sync/` |
| `sync-index-docs.js` | 索引與卡片同步 | ✅ 使用中 | `scripts/` |
| `docs.sh` | 文檔維護與驗證 | ✅ 使用中 | `scripts/` |
| `professional-doc-sync.js` | 專業深度同步 | 📦 已歸檔 | `archives/deprecated-scripts/` |

#### 腳本更新原則

- **新增功能**: 在對應腳本中新增，保持向後相容
- **重大變更**: 建立新版本腳本，舊版移至 `archives/`
- **錯誤修復**: 直接在原腳本修復，記錄在 commit message
- **文檔同步**: 更新 `scripts/README.md` 和 `scripts/doc-sync/README.md`

---

## 附錄

### A. 相關檔案快速參考

**核心文檔**:
- `claude-code-zh-tw.md` - 主要文檔（87K）
- `CHANGELOG.md` - 變更日誌（5.1K）
- `README.md` - 專案說明（26K）

**文檔目錄**:
- `docs/` - 20 個專案文檔 + 索引
- `docs/anthropic-claude-code-zh-tw/` - 32 個官方文檔鏡像

**工具腳本**:
- `scripts/doc-sync/enhanced-doc-sync.js` - 主要同步工具
- `scripts/sync-index-docs.js` - 索引同步
- `scripts/docs.sh` - 維護腳本

**專案目錄**:
- `analysis-projects/` - 18 個專案完整克隆

**配置與模板**:
- `prompts/unified-documentation-standard.md` - 文檔標準模板
- `prompts/super-workflows-master.md` - 工作流程大全

**索引與導航**:
- `index.html` - Web 介面（響應式）
- `docs/README.md` - 文檔索引

---

### B. 常見問題

**Q: 為什麼需要本地鏡像官方文檔？**
> A: 
> 1. 確保文檔可用性（不受官網更新影響）
> 2. 提供 100% 繁體中文版本
> 3. 允許離線存取
> 4. 便於版本追蹤與比較

**Q: 如何確保翻譯品質？**
> A:
> 1. 使用 AI 輔助翻譯（Claude）
> 2. 保留技術術語原文
> 3. 人工審校與校正
> 4. 統一術語對應表
> 5. 持續改進翻譯規則

**Q: 多久同步一次官方文檔？**
> A:
> - **建議頻率**: 每週一次
> - **重大更新時**: 立即同步
> - **自動化**: 可設定 Cron Job 或 GitHub Actions

**Q: 如何處理專案版本落後？**
> A:
> 1. 定期檢查專案最新版本（每月）
> 2. 使用 Git 更新專案倉庫
> 3. 比對文檔版本號與專案版本
> 4. 重新整理文檔內容
> 5. 更新元資料區塊

**Q: 自動化工具失效怎麼辦？**
> A:
> 1. 檢查官方網站結構是否變更
> 2. 更新 HTML 選擇器（cheerio）
> 3. 檢查 API 端點是否變更
> 4. 驗證網路連接與權限
> 5. 查看錯誤日誌並修復

---

### C. 聯絡與貢獻

**維護者**: s123104

**GitHub**: [s123104/claude-code](https://github.com/s123104/claude-code)

**問題回報**: [GitHub Issues](https://github.com/s123104/claude-code/issues)

**貢獻指南**: 請參閱 `CONTRIBUTING.md`

---

**最後更新**: 2025-10-29T02:45:00+08:00  
**文檔版本**: v1.0.0  
**維護狀態**: ✅ 活躍維護中

