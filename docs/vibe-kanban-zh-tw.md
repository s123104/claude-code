# Vibe Kanban 中文說明書

## 概述

Vibe Kanban 是一個視覺化的**專案管理工具**，結合 **Kanban 看板系統**、**AI 代理整合**和 **Git 工作流程**。提供直觀的任務管理介面、自動化工作流程和多代理協作支援，讓團隊能夠高效地組織和追蹤專案進度。

支援 Claude Code Subagents 多代理編排，可以自動分配任務給合適的 AI 代理，實現智能化的專案管理和開發協作。

> **專案資訊**
>
> - **專案名稱**：Vibe Kanban
> - **專案版本**：v0.0.142
> - **專案最後更新**：2025-12-21
> - **文件整理時間**：2025-12-24T00:42:00+08:00
>
> **核心定位**
>
> - **功能**：視覺化專案管理工具，整合 Kanban 看板、AI 代理和 Git 工作流程，支援多代理編排
> - **場景**：專案管理、任務追蹤、團隊協作、AI 代理調度、Git 工作流程整合
> - **客群**：專案經理、開發團隊、敏捷實踐者、AI 輔助開發團隊
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/BloopAI/vibe-kanban)
> - [官方網站](https://vibekanban.com)
> - [NPM 套件](https://www.npmjs.com/package/vibe-kanban)
> - [多代理編排最佳實踐](https://docs.anthropic.com/en/docs/claude-code/subagents)

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

#### 支援的代理（10 個）

Vibe Kanban 支援 10 個程式設計代理，每個代理都有其專長領域：

| 代理                   | 功能特色         | 最佳用途       |
| ---------------------- | ---------------- | -------------- |
| **Claude Code**        | 程式碼生成與重構 | 複雜邏輯開發   |
| **OpenAI Codex**       | 程式碼補全       | 函數實作       |
| **GitHub Copilot**     | 程式碼建議       | 快速開發       |
| **Gemini CLI**         | 快速原型開發     | MVP 建構       |
| **Amp**                | 全端開發         | 完整功能開發   |
| **Cursor Agent CLI**   | AI 原生編輯      | 智能程式碼編輯 |
| **OpenCode**           | SST OpenCode     | 全端應用開發   |
| **Droid CLI**          | Factory AI Droid | 智能程式碼生成 |
| **Claude Code Router** | 多模型編排       | 複雜任務協調   |
| **Qwen Code**          | 通義千問程式碼   | 中文程式碼生成 |

### 2.4 最新功能（v0.0.122）

#### 核心功能增強

- **多進程支援**：改進的 `--mcp` 命令支援多進程執行
- **差異檢視器**：新增文字換行切換功能，提升程式碼檢視體驗
- **遠端 SSH 配置**：支援遠端伺服器部署時的 SSH 連接配置
- **認證改進**：允許非 localhost 的認證重定向
- **Copilot 會話恢復**：改進 GitHub Copilot 會話恢復功能
- **Gemini 修復**：修復 Gemini CLI 整合問題
- **Git 錯誤處理**：將 Git 錯誤與 GitHub 錯誤解耦，提升錯誤處理準確度

#### 技術架構

- **後端**：Rust + Axum 網路框架 + Tokio 異步運行時
- **前端**：React 18 + TypeScript + Vite + Tailwind CSS
- **資料庫**：SQLite + SQLx migrations
- **類型共享**：ts-rs 從 Rust 結構生成 TypeScript 類型
- **MCP 伺服器**：內建 Model Context Protocol 伺服器用於 AI 代理整合

#### 代理編排

```yaml
工作流程範例:
  步驟1: Claude Code 設計架構
  步驟2: Gemini CLI 快速原型
  步驟3: Codex 補全細節
  步驟4: Amp 整合測試
  步驟5: Claude Code 程式碼審查

並行執行範例:
  任務A: Claude Code 實作後端 API
  任務B: Gemini CLI 建立前端介面
  任務C: Droid CLI 撰寫測試案例
  → 三個代理同時執行，提升開發效率
```

#### MCP 伺服器整合

Vibe Kanban 支援為每個代理配置 MCP（Model Context Protocol）伺服器，增強代理能力：

- **Context7**：官方函式庫文檔查詢
- **Playwright**：瀏覽器自動化與測試
- **自訂 MCP 伺服器**：可配置任何符合 MCP 協議的伺服器

配置方式：Settings → MCP Servers → 選擇代理 → 配置 MCP 伺服器

---

## 3. 安裝與設定

### 3.1 快速安裝

#### NPM 安裝（推薦）

```bash
# 使用 npx 直接執行（推薦方式）
npx vibe-kanban

# 這會自動下載並啟動最新版本的 Vibe Kanban
# 首次執行會自動設定必要的配置
```

#### 從原始碼安裝

```bash
# 克隆專案
git clone https://github.com/BloopAI/vibe-kanban.git
cd vibe-kanban

# 安裝依賴（需要 pnpm >= 8）
pnpm install

# 啟動開發模式（前端 + 後端）
pnpm run dev

# 或分別啟動
pnpm run frontend:dev    # 前端開發伺服器（預設 port 3000）
pnpm run backend:dev     # 後端開發伺服器（自動分配 port）
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

#### 啟動與初始化

```bash
# 執行 npx vibe-kanban 後，會自動：
# 1. 檢測 Git 倉庫
# 2. 建立必要的配置檔案
# 3. 啟動後端和前端伺服器
# 4. 在瀏覽器中開啟看板介面

npx vibe-kanban

# 輸出範例:
✅ Backend started on port 8080
✅ Frontend started on port 3000
🌐 Open http://localhost:3000 in your browser
```

#### 環境變數配置

Vibe Kanban 支援以下環境變數：

| 變數                              | 類型       | 預設值         | 說明                             |
| --------------------------------- | ---------- | -------------- | -------------------------------- |
| `POSTHOG_API_KEY`                 | Build-time | Empty          | PostHog 分析 API 金鑰（選用）    |
| `POSTHOG_API_ENDPOINT`            | Build-time | Empty          | PostHog 分析端點（選用）         |
| `BACKEND_PORT`                    | Runtime    | `0` (自動分配) | 後端伺服器端口                   |
| `FRONTEND_PORT`                   | Runtime    | `3000`         | 前端開發伺服器端口               |
| `HOST`                            | Runtime    | `127.0.0.1`    | 後端伺服器主機                   |
| `DISABLE_WORKTREE_ORPHAN_CLEANUP` | Runtime    | Not set        | 停用 git worktree 清理（除錯用） |

**Build-time 變數**：在執行 `pnpm run build` 時設定  
**Runtime 變數**：應用程式啟動時讀取

### 3.3 代理配置

#### 代理認證要求

在使用 Vibe Kanban 之前，您需要先認證您要使用的程式設計代理。每個代理都有不同的認證方式：

#### Claude Code

```bash
# 檢查 Claude Code 安裝
claude --version

# Claude Code 使用內建的認證機制
# 首次使用時會自動提示認證
```

#### OpenAI Codex

```bash
# 設定 OpenAI API 金鑰
export OPENAI_API_KEY="your-openai-key"

# 或使用 Codex CLI 認證
codex auth
```

#### GitHub Copilot

```bash
# 使用 GitHub CLI 認證
gh auth login

# 或設定 GitHub Personal Access Token
export GITHUB_TOKEN="your-github-token"
```

#### Gemini CLI

```bash
# 設定 Gemini API 金鑰
export GEMINI_API_KEY="your-gemini-key"

# 或使用 Gemini CLI 認證
gemini auth
```

#### Droid CLI

```bash
# 安裝 Droid CLI
curl -fsSL https://app.factory.ai/cli | sh

# 在 Droid CLI 中使用 /login 命令認證
droid
# 然後執行: /login

# 或設定 API 金鑰
export FACTORY_API_KEY="fk-..."
```

#### 其他代理

- **Amp**：使用 Amp CLI 認證
- **Cursor Agent CLI**：使用 Cursor CLI 認證
- **OpenCode**：使用 OpenCode CLI 認證
- **Qwen Code**：使用 Qwen CLI 認證
- **Claude Code Router**：使用 CCR CLI 認證

**注意**：完整的代理安裝和認證指南請參閱 [官方文檔](https://vibekanban.com/docs)。

---

## 4. 使用指南

### 4.1 基本工作流程

#### 建立任務

Vibe Kanban 提供兩種建立任務的方式：

**方式 1：建立任務（不立即啟動）**

1. 點擊看板右上角的 **加號 (+)** 按鈕
2. 或使用鍵盤快捷鍵 **`c`**
3. 填寫任務標題和描述
4. 點擊「建立任務」將任務加入看板

**方式 2：建立並立即啟動**

1. 點擊「建立任務」按鈕旁的「建立並啟動」
2. 選擇代理和變體（variant）
3. 選擇基礎分支
4. 任務會立即開始執行

#### 任務標籤（Task Tags）

在任務描述中使用 `@` 符號可以插入可重用的文字片段：

```
📝 新增任務範例

任務標題: 實作用戶認證
描述:
建立完整的用戶認證系統，包含註冊、登入、JWT 管理

使用任務標籤:
@auth-template  # 插入預設的認證模板

技術要求:
- 使用 Node.js + Express
- PostgreSQL 資料庫
- bcrypt 密碼加密

指派代理: Claude Code
預估時間: 4 小時
優先級: 高
```

**任務標籤功能**：

- 輸入 `@` 後會顯示可用的標籤列表
- 選擇標籤會自動插入預設的文字內容
- 可節省重複輸入常見任務結構的時間

#### 建立任務嘗試（Task Attempt）

當您開啟一個尚未執行的任務時，可以建立任務嘗試：

1. **選擇代理配置檔**：從可用代理中選擇（如 Claude Code、Gemini、Codex 等）
2. **選擇變體（Variant）**：如果代理支援變體，選擇適當的變體（如 Default、Plan、Router）
3. **選擇基礎分支**：指定代理應該從哪個分支開始工作（預設為當前分支）

**任務嘗試配置範例**：

```
任務: 實作用戶認證
狀態: 待辦事項 → 建立嘗試

代理配置:
├── 代理: Claude Code
├── 變體: Default
└── 基礎分支: main

MCP 伺服器:
├── Context7: 已啟用
└── Playwright: 已啟用

[建立並啟動]
```

**提示**：使用「建立並啟動」可以一次完成任務建立和嘗試建立，使用預設配置。

#### 進度追蹤

Vibe Kanban 提供即時的任務執行監控：

**任務執行狀態顯示**：

```
📊 任務執行狀態

實作用戶認證 (進行中)
├── ⏱️  開始時間: 09:30
├── 🤖 執行代理: Claude Code
├── 📈 進度: 65%
├── 🌿 工作分支: feature/user-auth
└── 📋 子任務:
    ├── ✅ 資料庫模型設計
    ├── ✅ API 路由建立
    ├── 🔄 密碼加密實作
    ├── ⏳ JWT 服務實作
    └── ⏳ 單元測試撰寫
```

**即時日誌串流**：

- **Server-Sent Events (SSE)**：即時串流執行日誌
- **多進程日誌檢視**：支援檢視多個進程的日誌
- **日誌篩選**：可以篩選和搜尋日誌內容
- **差異串流**：即時顯示程式碼變更差異

**即時日誌範例**：

```
[09:30] 開始分析需求...
[09:35] 建立 User 模型
[09:42] 實作註冊 API
[09:48] 正在實作密碼加密...
[09:52] 完成密碼加密實作
[09:55] 開始實作 JWT 服務...
```

**差異檢視**：

- **即時差異串流**：透過 Server-Sent Events 串流顯示變更
- **文字換行切換**：在差異檢視器中切換文字換行顯示（v0.0.122 新增）
- **檔案導航**：快速導航到變更的檔案
- **變更摘要**：顯示新增、刪除、修改的檔案統計
- **統一/分割檢視**：切換統一檢視和分割檢視模式

#### 子任務（Subtasks）

Vibe Kanban 支援建立子任務來分解複雜的工作：

**建立子任務**：

1. 開啟父任務
2. 點擊右上角的三點選單
3. 選擇「建立子任務」
4. 填寫子任務標題和描述
5. 子任務會自動繼承父任務的基礎分支

**子任務特性**：

- **自動繼承**：子任務自動繼承父任務嘗試的基礎分支
- **任務關係**：在「任務關係」面板中查看父子任務關係
- **獨立執行**：每個子任務可以獨立建立嘗試和執行
- **進度追蹤**：可以追蹤父任務和所有子任務的進度

**使用場景**：

- 將大型功能分解為多個小任務
- 並行開發不同的功能模組
- 追蹤複雜專案的進度

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

### 4.3 遠端部署與 SSH 配置

#### 遠端伺服器部署

當 Vibe Kanban 運行在遠端伺服器上時（例如透過 Cloudflare Tunnel、ngrok 或 systemctl 服務），您可以配置編輯器透過 SSH 開啟專案：

**配置步驟**：

1. **透過隧道存取**：使用 Cloudflare Tunnel、ngrok 或類似工具暴露 Web UI
2. **配置遠端 SSH**：在 Settings → Editor Integration 中設定：
   - **Remote SSH Host**：您的伺服器主機名或 IP 地址
   - **Remote SSH User**：SSH 用戶名（選用）
3. **必要條件**：
   - 從本地機器到遠端伺服器的 SSH 存取
   - 已配置 SSH 金鑰（無密碼認證）
   - VSCode Remote-SSH 擴展（或 Cursor/Windsurf 的等效擴展）

**支援的編輯器**：

- **VS Code**：Microsoft 的程式碼編輯器
- **Cursor**：具有 AI 原生功能的 VSCode 分支
- **Windsurf**：針對協作開發優化的 VSCode 分支
- **Neovim、Emacs、Sublime Text**：其他受歡迎的編輯器
- **Custom**：使用自訂 shell 命令

**運作方式**：

當配置遠端 SSH 後，點擊「在 VSCode 中開啟」按鈕會：

1. 生成特殊協議 URL：`vscode://vscode-remote/ssh-remote+user@host/path/to/project`
2. 在預設瀏覽器中開啟，啟動本地編輯器
3. 編輯器透過 SSH 連接到遠端伺服器
4. 專案或任務 worktree 在遠端上下文中開啟

**詳細設定說明**：請參閱 [官方文檔](https://vibekanban.com/docs/configuration-customisation/global-settings#remote-ssh-configuration)

---

## 5. 代理管理

### 5.1 代理配置

#### 預設代理配置

在 Settings → Default Agent Configuration 中可以設定：

1. **選擇預設代理**：選擇新任務嘗試的預設代理（如 Claude Code、Gemini、Codex 等）
2. **選擇變體**：如果代理支援變體，選擇預設變體（如 Default、Plan、Router）

**提示**：您可以在建立任務嘗試時覆蓋預設配置。

#### MCP 伺服器配置

為每個代理配置 MCP（Model Context Protocol）伺服器以增強能力：

**配置步驟**：

1. 前往 Settings → MCP Servers
2. 選擇要配置的代理
3. 選擇或新增 MCP 伺服器：
   - **熱門 MCP 伺服器**：提供一鍵安裝（如 Context7、Playwright）
   - **自訂 MCP 伺服器**：手動配置 JSON

**MCP 伺服器配置範例**：

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/cli"],
      "env": {
        "CONTEXT7_API_KEY": "your-api-key"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp-server"]
    }
  }
}
```

**可用的熱門 MCP 伺服器**：

- **Context7**：官方函式庫文檔查詢
- **Playwright**：瀏覽器自動化與測試
- **自訂伺服器**：可配置任何符合 MCP 協議的伺服器

### 5.2 工作流程自動化

#### 多代理編排

Vibe Kanban 支援並行或串列執行多個代理：

**並行執行範例**：

```yaml
任務: 建立全端應用

並行執行:
  代理1: Claude Code
    任務: 設計後端 API 架構
    分支: feature/backend-api

  代理2: Gemini CLI
    任務: 建立前端 UI 組件
    分支: feature/frontend-ui

  代理3: Droid CLI
    任務: 撰寫整合測試
    分支: feature/integration-tests

結果: 三個代理同時工作，大幅提升開發效率
```

**串列執行範例**：

```yaml
任務: 實作用戶認證系統

串列執行:
  步驟1: Claude Code
    動作: 分析需求並設計架構
    完成後自動觸發步驟2

  步驟2: Claude Code
    動作: 實作後端 API
    完成後自動觸發步驟3

  步驟3: Codex
    動作: 補全測試案例
    完成後自動觸發步驟4

  步驟4: Amp
    動作: 整合測試與部署
```

#### Vibe Kanban MCP 伺服器

Vibe Kanban 本身也作為 MCP 伺服器，讓其他 AI 代理可以管理任務：

**可用工具**：

- `list_projects` - 列出所有專案
- `list_tasks` - 列出專案中的任務
- `create_task` - 建立新任務
- `update_task` - 更新任務狀態
- `create_task_attempt` - 建立任務嘗試

**配置方式**：請參閱 [Vibe Kanban MCP Server 文檔](https://vibekanban.com/docs/integrations/vibe-kanban-mcp-server)

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

| 任務類型       | 推薦代理           | 理由                  |
| -------------- | ------------------ | --------------------- |
| 架構設計       | Claude Code        | 深度思考能力強        |
| 快速原型       | Gemini CLI         | 快速生成能力          |
| 程式碼補全     | OpenAI Codex       | 程式碼補全專精        |
| 全端整合       | Amp                | 端到端開發能力        |
| 重構優化       | Claude Code        | 程式碼品質要求高      |
| 智能程式碼生成 | Droid CLI          | Factory AI 的智能生成 |
| 多模型協調     | Claude Code Router | 複雜任務的多模型編排  |
| 中文程式碼生成 | Qwen Code          | 通義千問的中文支援    |
| GitHub 整合    | GitHub Copilot     | 與 GitHub 深度整合    |
| AI 原生編輯    | Cursor Agent CLI   | Cursor 的 AI 原生功能 |
| SST 應用開發   | OpenCode           | SST 框架專用開發      |

### 6.3 團隊協作

#### GitHub 整合

Vibe Kanban 支援 GitHub 整合，提供：

- **自動分支管理**：任務嘗試自動建立和追蹤分支
- **Pull Request 建立與追蹤**：自動建立 PR 並追蹤狀態
- **狀態同步**：任務狀態直接從 Vibe Kanban 同步到 GitHub

**配置方式**：

1. 前往 Settings → GitHub Integration
2. 提供 GitHub Personal Access Token (PAT)
3. 授權 Vibe Kanban 存取您的 GitHub 帳戶

#### 組織與專案管理

Vibe Kanban 支援組織層級的管理：

- **組織建立**：建立團隊組織
- **專案共享**：在組織內共享專案
- **成員管理**：邀請和管理團隊成員
- **權限控制**：設定不同角色的權限

#### 工作流程標準化

```yaml
團隊工作流程:
  1. 需求分析階段:
    - 產品經理建立任務
    - 技術主管審核可行性
    - 分配適當的代理和 MCP 伺服器

  2. 開發執行階段:
    - 代理自動執行實作
    - 即時進度追蹤（透過 SSE）
    - 自動程式碼檢查
    - 多進程日誌檢視

  3. 審查部署階段:
    - 差異檢視器審查變更
    - 人工程式碼審查
    - 自動化測試驗證
    - 部署到相應環境
    - GitHub PR 自動建立
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
> **版本資訊**：Vibe Kanban v0.0.122 - 視覺化專案管理工具（10 個程式設計代理、MCP 伺服器整合、遠端 SSH 配置）  
> **最後更新**：2025-11-25T02:53:00+08:00  
> **主要變更**：更新至 v0.0.122、新增 Droid CLI、Claude Code Router、Qwen Code 代理支援、新增遠端 SSH 配置功能、新增 MCP 伺服器配置說明、更新技術架構說明、新增任務標籤功能說明、更新 GitHub 整合說明
