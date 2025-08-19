# Vibe Kanban 中文說明書

> **版本**: 最新版本


## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/BloopAI/vibe-kanban)
> - [官方網站](https://vibekanban.com)
> - [NPM 套件](https://www.npmjs.com/package/vibe-kanban)
> - **文件整理時間：2025-08-19T23:52:25+08:00**
> - **專案版本：v0.0.63-20250819084625**
> - **專案最後更新：2025-08-19T16:44:53+01:00**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心功能](#2-核心功能)
- [3. 安裝與設定](#3-安裝與設定)
- [4. 使用指南](#4-使用指南)
- [5. 代理管理](#5-代理管理)
- [6. 最佳實踐](#6-最佳實踐)
- [7. 延伸閱讀](#7-延伸閱讀)

---

## 1. 專案簡介

Vibe Kanban 是一個視覺化專案管理工具，專為使用 AI 程式設計代理的開發者設計。它整合了 Git 倉庫管理和 Claude Code、Gemini CLI、Codex、Amp 等多種程式設計代理，讓開發者能夠有效地編排和管理 AI 輔助開發工作流程。

### 1.1 核心理念

> **讓 AI 程式設計代理發揮 10 倍效能**

隨著 AI 程式設計代理越來越多地撰寫程式碼，人類工程師現在將大部分時間花在規劃、審查和編排任務上。Vibe Kanban 簡化了這個過程。

### 1.2 主要優勢

- **🔄 代理切換**：輕鬆在不同程式設計代理間切換
- **⚡ 並行執行**：編排多個程式設計代理並行或串列執行
- **👀 快速審查**：快速審查工作成果並啟動開發伺服器
- **📊 狀態追蹤**：追蹤程式設計代理正在處理的任務狀態
- **⚙️ 集中配置**：集中管理程式設計代理的 MCP 配置

### 1.3 使用場景

- **多代理協作**：同時使用多個 AI 代理處理不同任務
- **專案管理**：視覺化管理複雜的開發專案
- **工作流程編排**：設計和執行結構化的開發流程
- **代碼審查**：系統性地審查 AI 生成的程式碼
- **團隊協作**：標準化 AI 輔助開發的流程

---

## 2. 核心功能

### 2.1 看板管理

#### 任務狀態追蹤

```
📋 Vibe Kanban 看板

待辦事項    │ 進行中      │ 審查中      │ 已完成
─────────   │ ─────────   │ ─────────   │ ─────────
🔲 用戶認證  │ 🔄 API 開發  │ 👀 前端優化  │ ✅ 資料庫設計
🔲 支付整合  │ 🔄 測試撰寫  │ 👀 文檔更新  │ ✅ 初始設定
🔲 部署配置  │              │              │ ✅ Git 設定

代理指派:    │ 代理指派:    │ 代理指派:    │
- Claude Code │ - Gemini CLI │ - Claude Code │
- Amp         │ - Codex      │              │
```

#### 拖拉管理

- **直觀操作**：拖拉卡片在不同狀態間移動
- **自動同步**：狀態變更自動同步到 Git 倉庫
- **批量操作**：支援多選和批量狀態更新
- **自訂欄位**：可自訂看板欄位和工作流程

### 2.2 Git 整合

#### 倉庫管理

```bash
🌲 Git 整合功能

自動化操作:
├── 📥 自動 pull 最新變更
├── 🔀 智能分支管理
├── 📝 自動 commit 訊息生成
└── 🚀 一鍵部署流程

分支策略:
├── 🌿 feature/task-123
├── 🧪 develop
└── 📦 main
```

#### 變更追蹤

- **即時同步**：Git 變更即時反映在看板上
- **衝突解決**：智能檢測和解決 merge 衝突
- **歷史記錄**：完整的變更歷史追蹤
- **分支視覺化**：圖形化顯示分支結構

### 2.3 多代理支援

#### 支援的代理

| 代理            | 功能特色         | 最佳用途     |
| --------------- | ---------------- | ------------ |
| **Claude Code** | 程式碼生成與重構 | 複雜邏輯開發 |
| **Gemini CLI**  | 快速原型開發     | MVP 建構     |
| **Codex**       | 程式碼補全       | 函數實作     |
| **Amp**         | 全端開發         | 完整功能開發 |

### 2.4 新版增強（v0.0.63）

- 新增 `ProcessLogsViewer` 與 `ProcessSelectionContext`，支援多進程日誌檢視與篩選
- 新增 `file_ranker.rs` 檔案關聯排序服務，提升檔案選擇與建議準確度
- 優化 `TaskFormDialog`、`CurrentAttempt` 與多處前端組件的互動與效能
- 更新多項依賴與前端樣式，改善可讀性與操作體驗

#### 代理編排

```yaml
工作流程範例:
  步驟1: Claude Code 設計架構
  步驟2: Gemini CLI 快速原型
  步驟3: Codex 補全細節
  步驟4: Amp 整合測試
  步驟5: Claude Code 程式碼審查
```

---

## 3. 安裝與設定

### 3.1 快速安裝

#### NPM 安裝

```bash
# 全域安裝
npm install -g vibe-kanban

# 或使用 npx 直接執行
npx vibe-kanban

# 啟動看板
vibe-kanban
```

#### 從原始碼安裝

```bash
# 克隆專案
git clone https://github.com/BloopAI/vibe-kanban.git
cd vibe-kanban

# 安裝依賴
npm install

# 建置專案
npm run build

# 啟動開發模式
npm run dev
```

### 3.2 初始設定

#### 專案初始化

```bash
# 在專案目錄中初始化
cd your-project
vibe-kanban init

# 輸出範例:
✅ Git 倉庫檢測: 已初始化
✅ 配置檔案: 已建立 .vibe-kanban.json
✅ 工作流程: 已建立預設看板
📋 看板 URL: http://localhost:3000
```

#### 配置檔案

```json
// .vibe-kanban.json
{
  "project": {
    "name": "My Project",
    "description": "AI 輔助開發專案",
    "repository": "git@github.com:user/repo.git"
  },
  "agents": {
    "claude-code": {
      "enabled": true,
      "config": "~/.claude/config.json"
    },
    "gemini-cli": {
      "enabled": true,
      "apiKey": "${GEMINI_API_KEY}"
    }
  },
  "workflow": {
    "columns": ["backlog", "in-progress", "review", "done"],
    "autoAssign": true,
    "gitIntegration": true
  }
}
```

### 3.3 代理配置

#### Claude Code 整合

```bash
# 檢查 Claude Code 安裝
claude --version

# 設定 API 金鑰（如需要）
export ANTHROPIC_API_KEY="your-api-key"

# 驗證整合
vibe-kanban test-agent claude-code
```

#### 其他代理設定

```bash
# Gemini CLI 設定
export GEMINI_API_KEY="your-gemini-key"

# Codex 設定
export OPENAI_API_KEY="your-openai-key"

# 驗證所有代理
vibe-kanban test-agents
```

---

## 4. 使用指南

### 4.1 基本工作流程

#### 建立任務

```
📝 新增任務

任務標題: 實作用戶認證
描述: 建立完整的用戶認證系統，包含註冊、登入、JWT 管理

技術要求:
- 使用 Node.js + Express
- PostgreSQL 資料庫
- bcrypt 密碼加密

指派代理: Claude Code
預估時間: 4 小時
優先級: 高

[建立任務]
```

#### 代理執行

```bash
# 任務會自動出現在看板的 "待辦事項" 欄位
# 點擊任務卡片進入詳細頁面

任務: 實作用戶認證
狀態: 待辦事項 → 進行中

指派代理: Claude Code
執行模式:
  ○ 即時執行
  ● 排程執行 (30分鐘後)
  ○ 手動觸發

[開始執行]
```

#### 進度追蹤

```
📊 任務執行狀態

實作用戶認證 (進行中)
├── ⏱️  開始時間: 09:30
├── 🤖 執行代理: Claude Code
├── 📈 進度: 65%
└── 📋 子任務:
    ├── ✅ 資料庫模型設計
    ├── ✅ API 路由建立
    ├── 🔄 密碼加密實作
    ├── ⏳ JWT 服務實作
    └── ⏳ 單元測試撰寫

即時日誌:
[09:30] 開始分析需求...
[09:35] 建立 User 模型
[09:42] 實作註冊 API
[09:48] 正在實作密碼加密...
```

### 4.2 程式碼審查

#### 審查界面

```
👀 程式碼審查: 用戶認證系統

變更檔案 (5):
├── 📄 models/User.js (新增)
├── 📄 routes/auth.js (新增)
├── 📄 middleware/auth.js (新增)
├── 📄 tests/auth.test.js (新增)
└── 📄 package.json (修改)

AI 程式碼品質報告:
✅ 程式碼風格: 符合 ESLint 規範
✅ 安全性: 密碼正確加密
✅ 測試覆蓋: 85% 覆蓋率
⚠️  建議: 增加 rate limiting

動作:
[✅ 批准] [❌ 拒絕] [💬 留言] [🔄 要求修改]
```

#### 自動檢查

- **程式碼品質**：ESLint、Prettier 自動檢查
- **安全掃描**：自動檢測常見安全漏洞
- **測試覆蓋**：自動執行測試並檢查覆蓋率
- **效能分析**：檢測潛在的效能問題

### 4.3 部署管理

#### 一鍵部署

```bash
# 從看板觸發部署
任務: 實作用戶認證
狀態: 審查中 → 已完成

部署選項:
├── 🚀 開發環境部署
├── 🧪 測試環境部署
└── 📦 生產環境部署

選擇: 開發環境部署
[開始部署]

部署進度:
├── ✅ 程式碼建置
├── ✅ 測試執行
├── ✅ Docker 映像建立
├── 🔄 部署到開發環境...
└── ⏳ 健康檢查
```

---

## 5. 代理管理

### 5.1 代理配置

#### 效能調優

```json
{
  "agents": {
    "claude-code": {
      "model": "claude-sonnet-4",
      "temperature": 0.7,
      "maxTokens": 4000,
      "tools": ["Edit", "Read", "Bash"]
    },
    "gemini-cli": {
      "model": "gemini-pro",
      "creativityLevel": "balanced",
      "safetySettings": "strict"
    }
  }
}
```

#### 成本控制

```yaml
成本管理設定:
  每日預算: $50
  代理優先級:
    - Claude Code: 高成本，高品質
    - Gemini CLI: 中成本，中品質
    - Codex: 低成本，快速補全

  自動切換:
    - 複雜任務 → Claude Code
    - 簡單任務 → Gemini CLI
    - 程式碼補全 → Codex
```

### 5.2 工作流程自動化

#### 觸發器設定

```javascript
// 工作流程範例
const workflow = {
  trigger: "task_created",
  conditions: {
    taskType: "backend",
    priority: "high",
  },
  actions: [
    {
      agent: "claude-code",
      action: "analyze_requirements",
      timeout: "10m",
    },
    {
      agent: "claude-code",
      action: "implement_code",
      timeout: "2h",
    },
    {
      agent: "codex",
      action: "add_tests",
      timeout: "30m",
    },
  ],
};
```

### 5.3 品質保證

#### 自動化檢查

```yaml
品質門檻:
  程式碼品質:
    - ESLint 零錯誤
    - Prettier 格式化
    - 複雜度 < 10

  測試要求:
    - 覆蓋率 ≥ 80%
    - 所有測試通過
    - 效能測試達標

  安全性:
    - 無高風險漏洞
    - 依賴安全掃描通過
    - 敏感資料保護
```

---

## 6. 最佳實踐

### 6.1 任務規劃

#### 有效的任務描述

```markdown
✅ 好的任務描述:

標題: 實作即時通知系統
描述:

- 使用 WebSocket 實作即時推送
- 支援多種通知類型（緊急、一般、資訊）
- 整合郵件備援機制
- 提供用戶偏好設定

技術要求:

- Node.js + Socket.io
- Redis 作為訊息佇列
- SendGrid 郵件服務

驗收標準:

- 通知延遲 < 100ms
- 支援 1000+ 併發連線
- 具備優雅降級機制

預估時間: 6 小時
代理建議: Claude Code (複雜邏輯) + Amp (整合測試)
```

### 6.2 代理選擇策略

#### 任務與代理匹配

| 任務類型   | 推薦代理    | 理由             |
| ---------- | ----------- | ---------------- |
| 架構設計   | Claude Code | 深度思考能力強   |
| 快速原型   | Gemini CLI  | 快速生成能力     |
| 程式碼補全 | Codex       | 程式碼補全專精   |
| 全端整合   | Amp         | 端到端開發能力   |
| 重構優化   | Claude Code | 程式碼品質要求高 |

### 6.3 團隊協作

#### 看板共享

```bash
# 設定團隊看板
vibe-kanban team init

# 邀請團隊成員
vibe-kanban invite team@example.com

# 權限管理
vibe-kanban permissions set developer --read-write
vibe-kanban permissions set reviewer --review-only
```

#### 工作流程標準化

```yaml
團隊工作流程:
  1. 需求分析階段:
    - 產品經理建立任務
    - 技術主管審核可行性
    - 分配適當的代理

  2. 開發執行階段:
    - 代理自動執行實作
    - 即時進度追蹤
    - 自動程式碼檢查

  3. 審查部署階段:
    - 人工程式碼審查
    - 自動化測試驗證
    - 部署到相應環境
```

---

## 7. 延伸閱讀

### 7.1 官方資源

- [Vibe Kanban GitHub](https://github.com/BloopAI/vibe-kanban)
- [官方網站](https://vibekanban.com)
- [NPM 套件](https://www.npmjs.com/package/vibe-kanban)
- [影片介紹](https://youtu.be/TFT3KnZOOAk)

### 7.2 相關專案

- [BloopAI](https://github.com/BloopAI)
- [Claude Code](https://github.com/anthropics/claude-code)
- [Gemini CLI](https://ai.google.dev/)

### 7.3 學習資源

- [看板方法論](https://kanbanboard.com/)
- [AI 輔助開發最佳實踐](https://github.com/BloopAI/vibe-kanban/wiki)
- [Git 工作流程](https://git-scm.com/docs/gitworkflows)

### 7.4 社群支援

- [GitHub Discussions](https://github.com/BloopAI/vibe-kanban/discussions)
- [問題回報](https://github.com/BloopAI/vibe-kanban/issues)
- [功能建議](https://github.com/BloopAI/vibe-kanban/issues/new?template=feature_request.md)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/BloopAI/vibe-kanban) 與相關文檔。
>
> **版本資訊**：Vibe Kanban v0.0.63-20250819084625 - 最新版本  
> **最後更新**：2025-08-19T23:52:25+08:00
