# opcode (原名 Claudia) 中文說明書

## 概述

opcode 是 Claude Code 的強大圖形化應用程式和工具套件。創建自訂代理、管理互動式 Claude Code 會話、執行安全的背景代理等功能。


> **專案資訊**
>
> - **專案名稱**：opcode (原名 Claudia)
> - **專案版本**：v0.2.2+
> - **專案最後更新**：2025-10-16
> - **文件整理時間**：2025-12-24T22:55:00+08:00
>
> **核心定位**
> - **功能**：Claude Code 的強大圖形化應用程式，提供自訂代理創建、會話管理、背景代理執行等功能
> - **場景**：視覺化管理、代理創建、會話管理、專案組織、背景任務執行
> - **客群**：Claude Code 用戶、代理開發者、專案管理者、多任務開發者
>
> **資料來源**
> - [GitHub 專案](https://github.com/winfunc/opcode)（原 getAsterisk/claudia，已遷移）
> - [Discord 社群](https://discord.com/invite/KYwhHVzUsY)

---

## 🔔 重要變更通知

**專案更名**：Claudia 已正式更名為 **opcode**。所有功能和 API 保持不變，但品牌識別和專案名稱已更新。

**v0.2.1 更新**：
- **Web 伺服器模式**：新增 Web 伺服器模式，支援遠端存取
- **Claude 安裝檢測**：改進的 Claude 二進位檔檢測，支援 Windows
- **路徑顯示修復**：修復包含連字號的目錄路徑顯示問題
- **HTTPS 支援**：Web 模式使用 WSS 進行安全連接

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心功能](#2-核心功能)
- [3. 安裝與設定](#3-安裝與設定)
- [4. 使用指南](#4-使用指南)
- [5. CC Agents 系統](#5-cc-agents-系統)
- [6. 專案管理](#6-專案管理)
- [7. 進階功能](#7-進階功能)
- [8. 開發指南](#8-開發指南)
- [9. 疑難排解](#9-疑難排解)
- [10. 延伸閱讀](#10-延伸閱讀)

---

## 1. 專案簡介

**opcode**（原名 Claudia）是一個功能強大的桌面應用程式，專為 Claude Code 使用者打造的圖形化界面工具。基於 Tauri 2 建構，它提供了美觀的 GUI 來管理 Claude Code 會話、創建自訂代理、追蹤使用量等功能。opcode 就像是您的 Claude Code 指揮中心，橋接命令列工具與視覺化體驗之間的差距。

### 1.1 核心特色

- **🖥️ 現代化 GUI**：基於 Tauri 2 的原生桌面應用程式
- **🤖 智能代理管理**：創建和管理自訂 CC Agents
- **📊 使用量分析**：詳細的使用統計和分析儀表板
- **🗂️ 專案管理**：集中管理多個 Claude Code 專案
- **🔌 MCP 整合**：完整的 Model Context Protocol 伺服器管理
- **⏰ 時間軸追蹤**：會話歷史和檢查點功能
- **📝 文檔管理**：CLAUDE.md 檔案的可視化編輯

### 1.2 使用場景

- **開發者工作站**：提升 Claude Code 的日常使用體驗
- **團隊協作**：管理多個專案和代理配置
- **使用量監控**：追蹤和分析 AI 開發成本
- **代理開發**：創建和測試自訂 CC Agents
- **專案組織**：結構化管理大型開發專案

### 1.3 技術架構

- **前端**：React 18 + TypeScript + Vite 6 + Tailwind CSS v4
- **後端**：Rust (Tauri 2)
- **套件管理器**：Bun
- **狀態管理**：Zustand
- **UI 元件**：shadcn/ui + Radix UI
- **圖表**：Recharts
- **資料庫**：SQLite (透過 rusqlite)
- **Markdown 編輯器**：@uiw/react-md-editor
- **動畫**：Framer Motion
- **分析**：PostHog (可選)

---

## 2. 核心功能

### 2.1 專案與會話管理

#### 專案管理介面

- **視覺化專案瀏覽器**：瀏覽 `~/.claude/projects/` 中的所有 Claude Code 專案
- **多專案切換**：快速在不同 Claude Code 專案間切換
- **專案儀表板**：每個專案的統計概覽
- **會話歷史**：完整的對話記錄和檢索，包含第一條訊息和時間戳
- **智能搜尋**：使用內建搜尋快速找到專案和會話
- **會話洞察**：一目了然地查看第一條訊息、時間戳和會話中繼資料
- **專案設定**：CLAUDE.md 和配置檔案管理

#### 會話管理功能

```
📊 專案概覽
├── 活躍會話: 3
├── 本週總 tokens: 12,456
├── 平均會話長度: 15 分鐘
└── 最愛模型: claude-sonnet-4

📝 最近會話
├── 2025-08-17 23:45 - "優化 API 效能" (1,234 tokens)
├── 2025-08-17 22:30 - "重構用戶認證" (2,567 tokens)
└── 2025-08-17 21:15 - "資料庫遷移腳本" (890 tokens)
```

### 2.2 CC Agents 智能代理

#### 自訂 AI 代理

- **自訂代理創建**：建立具有自訂系統提示和行為的專業代理
- **代理庫**：為不同任務建立專用代理集合
- **背景執行**：在獨立程序中運行代理，實現非阻塞操作
- **執行歷史**：追蹤所有代理運行，包含詳細日誌和效能指標

#### 預建代理範例

opcode 包含多個預建的專業代理範例（位於 `cc_agents/` 目錄）：

- **git-commit-bot**：自動生成 Git 提交訊息
- **security-scanner**：安全掃描和漏洞檢測
- **unit-tests-bot**：自動生成單元測試

#### 代理配置格式

代理使用 `.opcode.json` 格式配置：

```json
{
  "name": "Git Commit Bot",
  "description": "自動生成 Git 提交訊息",
  "systemPrompt": "您是一位 Git 專家...",
  "model": "claude-sonnet-4",
  "tools": ["Read", "Bash"],
  "permissions": {
    "fileRead": true,
    "fileWrite": false,
    "network": false
  }
}
```

#### 自訂代理建立

```typescript
// 代理配置範例
interface CustomAgent {
  name: string;
  description: string;
  systemPrompt: string;
  tools: string[];
  model: string;
  temperature: number;
  maxTokens: number;
}

const myAgent: CustomAgent = {
  name: "React Specialist",
  description: "專精於 React 開發的代理",
  systemPrompt: "您是一位 React 專家...",
  tools: ["Edit", "Read", "Bash"],
  model: "claude-sonnet-4",
  temperature: 0.7,
  maxTokens: 4000,
};
```

### 2.3 使用量分析儀表板

#### 統計指標

- **Token 使用趨勢**：時間序列圖表
- **模型使用分布**：各模型使用比例
- **成本分析**：詳細的成本追蹤
- **效率指標**：回應速度和品質分析

#### 視覺化圖表

```
📊 使用量儀表板

Token 使用趨勢 (本週)
    ▲
    │ ●●●
5000│   ●●●●
    │     ●●●
2500│       ●●
    │         ●
    └─────────────▶
     Mon Tue Wed Thu Fri

模型使用分布
├── claude-sonnet-4: 65% (主要使用)
├── claude-opus-4: 25% (複雜任務)
└── claude-haiku: 10% (簡單查詢)

成本分析
├── 本週總成本: $12.45
├── 平均每會話: $1.85
└── 預計月成本: $52.30
```

### 2.4 MCP 伺服器管理

#### 伺服器配置

- **伺服器註冊表**：從中央 UI 管理 Model Context Protocol 伺服器
- **自動發現**：掃描並發現可用的 MCP 伺服器
- **配置管理**：透過 UI 或從現有配置匯入，視覺化編輯 MCP 配置
- **連接測試**：在使用前驗證伺服器連接
- **Claude Desktop 匯入**：從 Claude Desktop 配置匯入伺服器設定
- **狀態監控**：即時監控伺服器狀態
- **日誌查看**：MCP 伺服器執行日誌

#### 支援的 MCP 服務

```yaml
支援的 MCP 伺服器:
  github:
    description: "GitHub 整合"
    tools: ["list_repos", "create_issue", "search_code"]
    status: "running"

  postgres:
    description: "PostgreSQL 資料庫"
    tools: ["query", "schema", "execute"]
    status: "running"

  filesystem:
    description: "檔案系統操作"
    tools: ["read_file", "write_file", "list_dir"]
    status: "running"
```

### 2.5 時間軸與檢查點

#### 會話版本控制

- **檢查點建立**：在編碼會話的任何時間點建立檢查點
- **視覺化時間軸**：使用分支時間軸瀏覽會話歷史
- **即時恢復**：一鍵跳回任何檢查點
- **會話分叉**：從現有檢查點建立新分支
- **差異檢視器**：精確查看檢查點之間的變更

#### 檢查點功能範例

```
⏰ 會話時間軸（分支視圖）

23:45 ├─ 📝 開始優化 API 效能
      │
23:50 ├─ 🔍 分析效能瓶頸 [檢查點 A]
      │   └─ 發現 N+1 查詢問題
      │
23:55 ├─ 🛠️ 實作 eager loading
      │
00:05 ├─ ✅ 測試效能改善 [檢查點 B]
      │   └─ 效能提升 300%
      │
00:10 ├─ 📋 撰寫最佳化文檔
      │
      └─ 🔀 從檢查點 A 分叉
          └─ 🧪 嘗試不同的優化方案
```

#### 差異檢視功能

- **檔案差異**：查看檢查點之間檔案變更
- **程式碼高亮**：語法高亮的差異顯示
- **行級比較**：逐行比較變更
- **合併支援**：協助合併不同分支的變更

### 2.6 Web 伺服器模式（v0.2.1 新增）

#### Web 模式功能

- **遠端存取**：透過 Web 瀏覽器存取 opcode
- **HTTPS/WSS 支援**：使用 WSS 進行安全 WebSocket 連接
- **Claude 安裝檢測**：自動檢測系統中的 Claude 安裝
- **跨平台支援**：Windows、macOS、Linux 全平台支援
- **API 端點**：提供 RESTful API 供外部整合

#### Web 模式使用

```bash
# 啟動 Web 伺服器模式
opcode --web

# 指定端口
opcode --web --port 8080

# HTTPS 模式
opcode --web --https
```

#### Web 模式端點

- **Claude 安裝檢測**：`GET /api/claude/installations`
- **專案列表**：`GET /api/projects`
- **會話管理**：`GET /api/sessions`
- **代理執行**：`POST /api/agents/execute`

---

## 3. 安裝與設定

### 3.1 系統需求

#### 最低系統需求

- **作業系統**：Windows 10/11、macOS 10.15+、Linux (Ubuntu 18.04+)
- **記憶體**：4GB RAM (建議 8GB+)
- **磁碟空間**：500MB 可用空間
- **網路**：穩定的網際網路連線

#### 相依軟體

- **Claude Code CLI**：必須先安裝並設定
- **Node.js**：版本 16+ (用於 MCP 伺服器)
- **Git**：版本控制支援

### 3.2 安裝步驟

#### 下載與安裝

```bash
# 方法 1: 從 GitHub Releases 下載（即將發布）
# https://github.com/getAsterisk/opcode/releases
# 下載適合您作業系統的安裝檔

# 方法 2: 從原始碼建置（推薦開發者）
git clone https://github.com/getAsterisk/opcode.git
cd opcode
bun install
bun run tauri build
```

#### 平台特定安裝

**Linux**：
- `.deb` 套件（Debian/Ubuntu）
- `.AppImage`（通用 Linux）

**macOS**：
- `.dmg` 安裝檔
- Universal Binary（Intel + Apple Silicon）

**Windows**：
- `.msi` 安裝檔
- `.exe` 安裝檔

#### 首次設定

1. **啟動 opcode**：開啟應用程式
2. **歡迎畫面**：選擇 CC Agents 或 Projects
3. **Claude Code 檢測**：自動檢測 `~/.claude` 目錄和 CLI 安裝
4. **API 金鑰設定**：如需要，輸入 Anthropic API 金鑰
5. **專案掃描**：自動掃描現有的 Claude Code 專案
6. **偏好設定**：選擇預設模型和設定

```
🚀 歡迎使用 opcode!

正在檢測環境...
✅ Claude Code CLI: 已安裝 (v2.x.x)
✅ Claude 安裝: 檢測到 1 個安裝
✅ API 金鑰: 已設定
✅ 專案掃描: 發現 3 個專案

請選擇預設設定:
• 預設模型: claude-sonnet-4
• 自動儲存會話: 是
• 啟用使用量追蹤: 是
• MCP 伺服器自動啟動: 是
• Web 伺服器模式: 否（可選）

設定完成! 🎉
```

### 3.3 配置檔案

#### opcode 配置

```json
// ~/.opcode/config.json
{
  "app": {
    "theme": "dark",
    "language": "zh-TW",
    "autoSave": true,
    "updateCheck": true,
    "webServer": {
      "enabled": false,
      "port": 8080,
      "https": false
    }
  },
  "claudeCode": {
    "defaultModel": "claude-sonnet-4",
    "maxTokens": 4000,
    "temperature": 0.7,
    "projectPaths": ["~/projects/web-app", "~/projects/api-service"],
    "claudePath": "auto" // 自動檢測或指定路徑
  },
  "mcp": {
    "autoStart": true,
    "servers": [
      {
        "name": "github",
        "command": "npx",
        "args": ["@anthropic-ai/mcp-server-github"]
      }
    ]
  },
  "agents": {
    "defaultPermissions": {
      "fileRead": true,
      "fileWrite": false,
      "network": false
    }
  }
}
```

---

## 4. 使用指南

### 4.1 快速開始

#### 啟動 opcode

1. **啟動應用程式**：開啟 opcode
2. **歡迎畫面**：選擇 CC Agents 或 Projects
3. **首次設定**：opcode 會自動檢測您的 `~/.claude` 目錄

#### 建立第一個專案

1. **選擇 "Projects"**
2. **點選 "新增專案"** 或選擇現有專案
3. **選擇專案目錄**（如果新增）
4. **配置 CLAUDE.md**（可選）
5. **開始第一個會話**

```
📁 新增專案精靈

步驟 1: 選擇專案目錄
> 📂 ~/projects/my-web-app

步驟 2: 專案類型
> 🌐 Web 應用程式

步驟 3: 技術棧
> ⚛️ React + Node.js

步驟 4: 生成 CLAUDE.md
> ✅ 自動生成基礎配置

步驟 5: 選擇代理（可選）
> 🤖 git-commit-bot
> 🤖 security-scanner

專案建立完成! 🚀
```

#### 開始會話

```
💬 新會話

專案: my-web-app
代理: Frontend Expert
模型: claude-sonnet-4

您的訊息:
> 幫我設計一個現代化的登入頁面

🤖 Frontend Expert:
我來幫您設計一個現代化的登入頁面。
首先，讓我了解一下專案的設計系統...
```

### 4.2 專案管理

#### 專案瀏覽

```
🗂️ 專案列表

📂 my-web-app (目前)
   ├── 最後活動: 2 分鐘前
   ├── 今日 tokens: 1,234
   ├── 會話數: 5
   └── 狀態: 🟢 活躍

📂 api-service
   ├── 最後活動: 1 小時前
   ├── 今日 tokens: 567
   ├── 會話數: 3
   └── 狀態: 🟡 閒置

📂 mobile-app
   ├── 最後活動: 昨天
   ├── 今日 tokens: 0
   ├── 會話數: 0
   └── 狀態: ⚫ 非活躍
```

#### 專案操作流程

```
Projects → Select Project → View Sessions → Resume or Start New
```

- 點擊任何專案查看其會話
- 每個會話顯示第一條訊息和時間戳
- 直接恢復會話或開始新會話
- 使用智能搜尋快速找到專案

#### 專案設定

- **CLAUDE.md 編輯器**：可視化編輯專案記憶體
- **代理配置**：選擇專案可用的代理
- **MCP 伺服器**：配置專案特定的 MCP 服務
- **權限設定**：控制代理可用的工具

### 4.3 會話管理

#### 會話操作

- **暫停/恢復**：隨時暫停和恢復會話
- **分叉**：從任意點創建新的會話分支
- **匯出**：將會話匯出為 Markdown 或 JSON
- **搜尋**：在會話歷史中搜尋特定內容

#### 會話分析

```
📊 會話分析

基本資訊:
• 開始時間: 2025-08-17 23:45:00
• 持續時間: 25 分鐘
• 訊息數: 12 (6 用戶, 6 助手)

使用量統計:
• 輸入 tokens: 1,234
• 輸出 tokens: 2,567
• 總成本: $0.45

效率指標:
• 平均回應時間: 3.2 秒
• 用戶滿意度: 😊 滿意
• 任務完成度: 95%
```

---

## 5. CC Agents 系統

### 5.1 預建代理詳解

#### Frontend Expert 代理

```yaml
名稱: Frontend Expert
描述: 專精於現代前端開發的專家代理
專長:
  - React/Vue/Angular 開發
  - CSS/Tailwind 樣式設計
  - 響應式網頁設計
  - 前端效能優化
  - 使用者體驗設計

系統提示: |
  您是一位資深的前端開發專家，專精於現代前端技術棧。
  您的目標是幫助開發者建立高品質、高效能的前端應用程式。

預設設定:
  模型: claude-sonnet-4
  溫度: 0.7
  最大 tokens: 4000
  工具: [Edit, Read, Bash]
```

#### Backend Architect 代理

```yaml
名稱: Backend Architect
描述: 後端架構設計和 API 開發專家
專長:
  - RESTful/GraphQL API 設計
  - 資料庫架構設計
  - 微服務架構
  - 效能優化
  - 安全性實作

系統提示: |
  您是一位資深的後端架構師，具備豐富的大規模系統設計經驗。
  您專注於建立可擴展、高效能且安全的後端系統。

預設設定:
  模型: claude-opus-4
  溫度: 0.5
  最大 tokens: 6000
  工具: [Edit, Read, Bash, WebFetch]
```

### 5.2 自訂代理開發

#### 代理建立流程

```
CC Agents → Create Agent → Configure → Execute
```

1. **設計代理**：設定名稱、圖示和系統提示
2. **配置模型**：選擇可用的 Claude 模型
3. **設定權限**：配置檔案讀寫和網路存取權限
4. **執行任務**：在任何專案上運行您的代理
5. **測試驗證**：測試代理回應品質

#### 代理建立步驟

1. **基本資訊**：名稱、描述、圖示
2. **系統提示**：定義代理的行為和專長
3. **工具配置**：選擇可用的工具
4. **模型設定**：選擇 AI 模型和參數
5. **權限設定**：配置檔案和網路存取權限
6. **測試驗證**：測試代理回應品質

#### 代理範本

```markdown
# 自訂代理範本

## 基本資訊

- **名稱**: 我的專家代理
- **描述**: 專門處理特定領域任務的代理
- **圖示**: 🤖

## 系統提示
```

您是一位專精於 [領域] 的專家。

### 您的專長包括:

- 技能 1
- 技能 2
- 技能 3

### 您的工作方式:

1. 仔細分析問題
2. 提供詳細的解決方案
3. 確保代碼品質
4. 提供清晰的解釋

請始終以專業、友善的態度回應用戶請求。

```

## 工具配置
- ✅ Edit (編輯檔案)
- ✅ Read (讀取檔案)
- ✅ Bash (執行命令)
- ❌ WebFetch (網路請求)

## 模型設定
- **模型**: claude-sonnet-4
- **溫度**: 0.7
- **最大 tokens**: 4000
- **回應格式**: markdown
```

### 5.3 代理管理

#### 代理庫

```
🤖 代理庫

📁 預建代理範例 (cc_agents/)
├── 🔀 git-commit-bot
│   └── 自動生成 Git 提交訊息
├── 🛡️ security-scanner
│   └── 安全掃描和漏洞檢測
└── 🧪 unit-tests-bot
    └── 自動生成單元測試

📁 我的代理 (自訂)
├── 🎨 UI/UX Designer
├── 📊 Data Analyst
└── 🧪 Test Engineer
```

#### 代理執行

- **背景執行**：在獨立程序中運行代理，實現非阻塞操作
- **執行歷史**：追蹤所有代理運行，包含詳細日誌和效能指標
- **權限控制**：為每個代理設定檔案和網路存取權限
- **程序隔離**：每個代理在獨立程序中執行，確保安全性

#### 代理共享

- **匯出代理**：將自訂代理匯出為 `.opcode.json` 檔案
- **匯入代理**：從檔案或 URL 匯入代理配置
- **代理範本**：使用預建範本快速建立新代理
- **版本管理**：追蹤代理的版本變更

---

## 6. 專案管理

### 6.1 專案儀表板

#### 概覽統計

```
📊 專案儀表板: my-web-app

今日活動:
├── 會話數: 5
├── 總 tokens: 8,432
├── 活躍時間: 2.5 小時
└── 成本: $2.45

本週趨勢:
├── 📈 使用量: ↑ 15%
├── 💰 成本: ↑ 8%
├── ⚡ 效率: ↑ 22%
└── 🎯 目標達成: 85%

熱門代理:
├── Frontend Expert: 40%
├── Backend Architect: 35%
└── DevOps Engineer: 25%
```

#### 檔案活動

```
📁 最近修改的檔案

src/components/LoginForm.tsx
├── 最後修改: 10 分鐘前
├── 修改者: Frontend Expert
└── 變更: 添加表單驗證

src/api/auth.js
├── 最後修改: 1 小時前
├── 修改者: Backend Architect
└── 變更: 實作 JWT 認證

README.md
├── 最後修改: 2 小時前
├── 修改者: Documentation Writer
└── 變更: 更新 API 文檔
```

### 6.2 CLAUDE.md 管理

#### 內建編輯器

- **直接編輯**：在應用程式中直接編輯 CLAUDE.md 檔案
- **即時預覽**：即時查看 Markdown 渲染結果
- **專案掃描器**：在專案中尋找所有 CLAUDE.md 檔案
- **語法高亮**：完整的 Markdown 支援與語法高亮

#### 可視化編輯器範例

```markdown
# 專案: my-web-app

## 🎯 專案概述

這是一個現代化的 Web 應用程式，使用 React 和 Node.js 建構。

## 🛠️ 技術棧

### 前端

- React 18
- TypeScript
- Tailwind CSS
- Vite

### 後端

- Node.js
- Express
- PostgreSQL
- JWT 認證

## 📝 開發規範

### 程式碼風格

- 使用 ESLint + Prettier
- 遵循 Airbnb 風格指南
- 所有函數必須有 TypeScript 類型

### 測試要求

- 單元測試覆蓋率 ≥ 80%
- 整合測試覆蓋關鍵流程
- E2E 測試覆蓋主要用戶路徑

## 🤖 偏好代理

- git-commit-bot: Git 提交訊息生成
- security-scanner: 安全掃描
- unit-tests-bot: 單元測試生成
```

#### 範本庫

- **框架範本**：React、Vue、Angular 專案範本
- **語言範本**：JavaScript、Python、Go 等
- **領域範本**：電商、社交、企業應用等
- **自訂範本**：儲存和重用自己的範本

### 6.3 版本控制整合

#### Git 整合

```
🌲 Git 整合

目前分支: feature/user-auth
狀態: 🟡 有未提交變更

未提交變更 (3):
├── src/components/LoginForm.tsx (已修改)
├── src/api/auth.js (已修改)
└── package.json (已修改)

最近提交:
├── 2562bdc - feat: add user authentication
├── 1a2b3c4 - fix: resolve login validation issues
└── 5d6e7f8 - docs: update API documentation

分支管理:
├── 📌 main (生產)
├── 🚧 develop (開發)
└── ✨ feature/user-auth (目前)
```

---

## 7. 進階功能

### 7.1 自動化工作流程

#### 觸發器設定

```yaml
工作流程: 自動測試
觸發條件: 檔案儲存
檔案模式: "*.{js,ts,tsx}"

動作序列: 1. 執行 ESLint 檢查
  2. 執行相關單元測試
  3. 生成測試報告
  4. 如果失敗，通知用戶

代理: DevOps Engineer
執行模式: 背景執行
通知方式: 桌面通知 + 應用內訊息
```

#### 預設工作流程

- **程式碼檢查**：自動執行 linting 和格式化
- **測試執行**：儲存檔案時自動執行相關測試
- **文檔更新**：程式碼變更時自動更新文檔
- **部署準備**：自動檢查部署準備狀態

### 7.2 多會話管理

#### 並行會話

```
💬 活躍會話 (3)

會話 A: Frontend Expert
├── 主題: 設計登入頁面
├── 開始時間: 23:45
└── 狀態: 🟢 進行中

會話 B: Backend Architect
├── 主題: API 安全強化
├── 開始時間: 23:50
└── 狀態: ⏸️ 已暫停

會話 C: DevOps Engineer
├── 主題: Docker 容器化
├── 開始時間: 00:05
└── 狀態: 🟢 進行中
```

#### 會話協調

- **上下文共享**：會話間共享相關資訊
- **任務依賴**：定義會話間的依賴關係
- **結果整合**：自動整合多個會話的成果
- **衝突解決**：處理會話間的程式碼衝突

### 7.3 團隊協作功能

#### 會話分享

```
🤝 分享會話: "API 架構設計"

分享選項:
├── 🔗 產生分享連結
├── 📧 透過電子郵件分享
├── 💬 匯出為 Markdown
└── 📦 打包專案設定

權限設定:
├── 👁️ 僅檢視
├── 💬 可評論
└── ✏️ 可編輯

過期時間: 7 天
存取密碼: 可選
```

#### 團隊範本

- **共享代理**：團隊共用的自訂代理
- **專案範本**：標準化的專案設定
- **最佳實踐**：團隊開發規範
- **知識庫**：團隊累積的解決方案

---

## 8. 開發指南

### 8.1 擴展開發

#### 插件系統

```typescript
// 插件介面定義
interface ClaudiaPlugin {
  name: string;
  version: string;
  description: string;

  // 生命週期方法
  onActivate(): void;
  onDeactivate(): void;

  // 事件處理
  onSessionStart(session: Session): void;
  onSessionEnd(session: Session): void;
  onMessageSent(message: Message): void;
  onMessageReceived(message: Message): void;
}

// 插件範例
class UsageAnalyzerPlugin implements ClaudiaPlugin {
  name = "Usage Analyzer";
  version = "1.0.0";
  description = "分析使用模式的插件";

  onActivate() {
    console.log("Usage Analyzer 插件已啟動");
  }

  onSessionEnd(session: Session) {
    this.analyzeUsage(session);
  }

  private analyzeUsage(session: Session) {
    // 分析邏輯
  }
}
```

#### API 介面

```typescript
// Claudia API
interface ClaudiaAPI {
  // 專案管理
  projects: {
    list(): Project[];
    create(config: ProjectConfig): Project;
    open(path: string): Project;
    close(project: Project): void;
  };

  // 會話管理
  sessions: {
    start(project: Project, agent: Agent): Session;
    pause(session: Session): void;
    resume(session: Session): void;
    end(session: Session): void;
  };

  // 代理管理
  agents: {
    list(): Agent[];
    create(config: AgentConfig): Agent;
    update(agent: Agent, config: AgentConfig): Agent;
    delete(agent: Agent): void;
  };
}
```

### 8.2 自訂主題

#### 主題系統（Tailwind CSS v4）

opcode 使用 Tailwind CSS v4 和 shadcn/ui 提供現代化的主題系統：

```css
/* Tailwind CSS v4 主題配置 */
@theme {
  --color-primary: #3b82f6;
  --color-secondary: #6366f1;
  --color-accent: #10b981;
  
  --color-background: #0f172a;
  --color-surface: #1e293b;
  --color-overlay: #334155;
  
  --color-text-primary: #f8fafc;
  --color-text-secondary: #cbd5e1;
  --color-text-muted: #64748b;
}
```

#### 主題配置

```json
{
  "theme": {
    "name": "Custom Dark",
    "mode": "dark",
    "colors": {
      "primary": "#3b82f6",
      "background": "#0f172a",
      "surface": "#1e293b"
    },
    "fonts": {
      "ui": "Inter",
      "mono": "JetBrains Mono"
    },
    "animations": {
      "enabled": true,
      "duration": "normal"
    }
  }
}
```

#### UI 元件庫

- **shadcn/ui**：基於 Radix UI 的無障礙元件
- **Lucide React**：現代圖示庫
- **Framer Motion**：流暢的動畫效果
- **Tailwind CSS v4**：最新的實用優先 CSS 框架

### 8.3 建置與部署

#### 前置需求

**系統需求**：
- **作業系統**：Windows 10/11、macOS 11+、Linux (Ubuntu 20.04+)
- **記憶體**：最低 4GB（建議 8GB）
- **儲存空間**：至少 1GB 可用空間

**必要工具**：
1. **Rust** (1.70.0 或更高版本)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Bun** (最新版本)
   ```bash
   curl -fsSL https://bun.sh/install | bash
   ```

3. **Git**
   ```bash
   # Ubuntu/Debian: sudo apt install git
   # macOS: brew install git
   # Windows: 從 https://git-scm.com 下載
   ```

4. **Claude Code CLI**
   - 從 [Claude 官方網站](https://claude.ai/code) 下載並安裝
   - 確保 `claude` 在您的 PATH 中

#### 平台特定依賴

**Linux (Ubuntu/Debian)**：
```bash
sudo apt update
sudo apt install -y \
  libwebkit2gtk-4.1-dev \
  libgtk-3-dev \
  libayatana-appindicator3-dev \
  librsvg2-dev \
  patchelf \
  build-essential \
  curl \
  wget \
  file \
  libssl-dev \
  libxdo-dev \
  libsoup-3.0-dev \
  libjavascriptcoregtk-4.1-dev
```

**macOS**：
```bash
# 安裝 Xcode Command Line Tools
xcode-select --install

# 安裝額外依賴（可選）
brew install pkg-config
```

**Windows**：
- 安裝 [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
- 安裝 [WebView2](https://developer.microsoft.com/microsoft-edge/webview2/)（Windows 11 通常已預裝）

#### 開發環境設定

```bash
# 克隆專案
git clone https://github.com/getAsterisk/opcode.git
cd opcode

# 安裝前端依賴
bun install

# 開發模式運行（含熱重載）
bun run tauri dev

# 僅運行前端
bun run dev

# 類型檢查
bunx tsc --noEmit

# 運行 Rust 測試
cd src-tauri && cargo test

# 格式化程式碼
cd src-tauri && cargo fmt
```

#### 建置發布

```bash
# 建置生產版本
bun run tauri build

# 建置不同平台
bun run tauri build -- --target x86_64-pc-windows-msvc
bun run tauri build -- --target x86_64-apple-darwin
bun run tauri build -- --target x86_64-unknown-linux-gnu

# Debug 建置（編譯更快，檔案更大）
bun run tauri build --debug

# macOS Universal Binary (Intel + Apple Silicon)
bun run tauri build --target universal-apple-darwin

# 建置輸出位置
# Linux: src-tauri/target/release/bundle/
#   - .deb 套件
#   - .AppImage
# macOS: src-tauri/target/release/bundle/
#   - .dmg 安裝檔
# Windows: src-tauri/target/release/bundle/
#   - .msi 安裝檔
#   - .exe 安裝檔
```

#### 建置可執行檔

```bash
# 建置可執行檔（從 GitHub Releases 下載）
bun run build:executables

# 建置當前版本
bun run build:executables:current

# 建置特定平台
bun run build:executables:linux
bun run build:executables:macos
bun run build:executables:windows
```

---

## 9. 疑難排解

### 9.1 常見問題

#### Claude Code 連接問題

**問題**：opcode 無法檢測到 Claude Code CLI

**解決方案**：

```bash
# 檢查 Claude Code 安裝
claude --version

# 檢查 PATH 環境變數
echo $PATH | grep claude

# Windows 特定檢查
# opcode 會自動檢測 Windows 上的 Claude 安裝

# 手動設定 Claude Code 路徑
# 在 opcode 設定中指定 CLI 路徑
# 或在配置檔案中設定 "claudePath"
```

#### 建置問題

**問題**："cargo not found" 錯誤

**解決方案**：
```bash
# 確保 Rust 已安裝且 ~/.cargo/bin 在 PATH 中
source ~/.cargo/env
# 或重新啟動終端
```

**問題**：Linux "webkit2gtk not found" 錯誤

**解決方案**：
```bash
# 安裝 webkit2gtk 開發套件
sudo apt install libwebkit2gtk-4.1-dev
# 或在新版 Ubuntu 上使用
sudo apt install libwebkit2gtk-4.0-dev
```

**問題**：Windows "MSVC not found" 錯誤

**解決方案**：
- 安裝 Visual Studio Build Tools（含 C++ 支援）
- 安裝後重新啟動終端

**問題**：建置時記憶體不足

**解決方案**：
```bash
# 使用較少的並行作業
cargo build -j 2
# 關閉其他應用程式以釋放記憶體
```

#### 代理執行失敗

**問題**：自訂代理無法正常執行

**檢查清單**：

- [ ] 系統提示是否正確
- [ ] 工具權限是否設定
- [ ] API 金鑰是否有效
- [ ] 模型選擇是否正確

#### MCP 伺服器連接問題

**問題**：MCP 伺服器無法啟動或連接

**解決方案**：

```bash
# 檢查 Node.js 版本
node --version

# 手動測試 MCP 伺服器
npx @anthropic-ai/mcp-server-github

# 檢查防火牆設定
# 確保 MCP 端口未被阻擋
```

### 9.2 效能優化

#### 記憶體使用優化

```typescript
// 設定記憶體限制
const config = {
  maxSessions: 5,
  sessionTimeout: 30 * 60 * 1000, // 30 分鐘
  cacheSize: 100 * 1024 * 1024, // 100MB
  historyLimit: 1000, // 最多 1000 條記錄
};
```

#### 網路優化

```json
{
  "network": {
    "timeout": 30000,
    "retries": 3,
    "compression": true,
    "keepAlive": true
  }
}
```

### 9.3 診斷工具

#### 系統診斷

```
🔍 系統診斷報告

opcode 版本: 0.2.1
作業系統: macOS 14.5.0
記憶體使用: 234MB / 8GB

Claude Code CLI:
✅ 已安裝: v2.1.0
✅ Claude 安裝檢測: 1 個安裝
✅ API 金鑰: 已設定
✅ 權限: 正常

MCP 伺服器:
✅ GitHub: 運行中
✅ PostgreSQL: 運行中
❌ Filesystem: 連接失敗

Web 伺服器模式:
❌ 未啟用
✅ 端口可用: 8080

建議修復:
1. 重新啟動 Filesystem MCP 伺服器
2. 檢查檔案權限設定
3. 驗證 Claude 安裝路徑
```

#### 驗證建置

建置後，您可以驗證應用程式是否正常工作：

```bash
# 直接執行建置的可執行檔
# Linux/macOS
./src-tauri/target/release/opcode

# Windows
./src-tauri/target/release/opcode.exe
```

---

## 10. 延伸閱讀

### 10.1 官方資源

- [opcode GitHub](https://github.com/getAsterisk/opcode)
- [Discord 社群](https://discord.com/invite/KYwhHVzUsY)
- [Twitter @getAsterisk](https://x.com/getAsterisk)
- [Asterisk 官網](https://asterisk.so/)

### 10.2 相關專案

- [Claude Code](https://github.com/anthropics/claude-code)
- [Tauri](https://tauri.app/)
- [CC Agents](https://github.com/getAsterisk/opcode/tree/main/cc_agents)
- [Bun](https://bun.sh/)
- [Tailwind CSS v4](https://tailwindcss.com/)

### 10.3 技術文檔

- [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
- [MCP 協議文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)
- [Tauri 文檔](https://tauri.app/develop/)

### 10.4 學習資源

- [Tauri 教學](https://tauri.app/learn/)
- [React 開發指南](https://react.dev/learn)
- [Rust 程式設計](https://doc.rust-lang.org/book/)
- [TypeScript 手冊](https://www.typescriptlang.org/docs/)

### 10.5 社群支援

- [GitHub Discussions](https://github.com/getAsterisk/opcode/discussions)
- [Discord 技術支援](https://discord.com/invite/KYwhHVzUsY)
- [問題回報](https://github.com/getAsterisk/opcode/issues)
- [功能請求](https://github.com/getAsterisk/opcode/issues)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/getAsterisk/opcode) 與相關文檔。
>
> **版本資訊**：opcode v0.2.1 - Claude Code 圖形化界面工具（原名 Claudia）  
> **最後更新**：2025-11-25T02:40:00+08:00  
> **專案更新**：2025-10-13T22:24:22+02:00  
> **主要變更**：專案更名為 opcode、新增 Web 伺服器模式、改進 Claude 安裝檢測（Windows 支援）、路徑顯示修復、HTTPS/WSS 支援、技術棧更新（Bun、Tailwind CSS v4、Vite 6）、預建代理範例（git-commit-bot、security-scanner、unit-tests-bot）
