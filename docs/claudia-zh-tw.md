# opcode (原名 Claudia) 中文說明書

## 概述

opcode 是 Claude Code 的強大圖形化應用程式和工具套件。創建自訂代理、管理互動式 Claude Code 會話、執行安全的背景代理等功能。


> **專案資訊**
>
> - **專案名稱**：opcode (原名 Claudia)
> - **專案版本**：v0.2.0
> - **專案最後更新**：2025-10-13
> - **文件整理時間**：2025-10-28T19:00:00+08:00
>
> **核心定位**
> - **功能**：Claude Code 的強大圖形化應用程式，提供自訂代理創建、會話管理、背景代理執行等功能
> - **場景**：視覺化管理、代理創建、會話管理、專案組織、背景任務執行
> - **客群**：Claude Code 用戶、代理開發者、專案管理者、多任務開發者
>
> **資料來源**
> - [GitHub 專案](https://github.com/getAsterisk/claudia)
> - [官方網站](https://claudiacode.com)
> - [Discord 社群](https://discord.com/invite/KYwhHVzUsY)

---

## 🔔 重要變更通知

**專案更名**：Claudia 已正式更名為 **opcode**。所有功能和 API 保持不變，但品牌識別和專案名稱已更新。

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

- **前端**：React + TypeScript + Tailwind CSS
- **後端**：Rust (Tauri 2)
- **狀態管理**：Zustand
- **UI 元件**：shadcn/ui
- **圖表**：Recharts
- **資料庫**：本地 SQLite (透過 Tauri)

---

## 2. 核心功能

### 2.1 專案與會話管理

#### 專案管理介面

- **多專案切換**：快速在不同 Claude Code 專案間切換
- **專案儀表板**：每個專案的統計概覽
- **會話歷史**：完整的對話記錄和檢索
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

#### 預建代理

Claudia 包含多個預建的專業代理：

- **Frontend Expert**：前端開發專家
- **Backend Architect**：後端架構師
- **DevOps Engineer**：DevOps 工程師
- **Security Auditor**：安全審查專家
- **Documentation Writer**：文檔撰寫專家

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

- **自動發現**：掃描並發現可用的 MCP 伺服器
- **配置管理**：視覺化編輯 MCP 配置
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

#### 會話時間軸

- **視覺化歷史**：以時間軸呈現會話記錄
- **檢查點標記**：重要時刻的標記和註解
- **快速跳轉**：快速返回特定時間點
- **分支比較**：比較不同會話路徑的結果

#### 檢查點功能

```
⏰ 會話時間軸

23:45 ├─ 📝 開始優化 API 效能
      │
23:50 ├─ 🔍 分析效能瓶頸 [檢查點]
      │   └─ 發現 N+1 查詢問題
      │
23:55 ├─ 🛠️ 實作 eager loading
      │
00:05 ├─ ✅ 測試效能改善 [檢查點]
      │   └─ 效能提升 300%
      │
00:10 └─ 📋 撰寫最佳化文檔
```

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
# 方法 1: 從官網下載
# 訪問 https://claudiacode.com
# 下載適合您作業系統的安裝檔

# 方法 2: 從 GitHub Releases 下載
# https://github.com/getAsterisk/claudia/releases

# 方法 3: 從原始碼建置 (開發者)
git clone https://github.com/getAsterisk/claudia.git
cd claudia
npm install
npm run build
```

#### 首次設定

1. **啟動 Claudia**
2. **Claude Code 檢測**：自動檢測 CLI 安裝
3. **API 金鑰設定**：如需要，輸入 Anthropic API 金鑰
4. **專案掃描**：掃描現有的 Claude Code 專案
5. **偏好設定**：選擇預設模型和設定

```
🚀 歡迎使用 Claudia!

正在檢測環境...
✅ Claude Code CLI: 已安裝 (v2.x.x)
✅ API 金鑰: 已設定
✅ 專案掃描: 發現 3 個專案

請選擇預設設定:
• 預設模型: claude-sonnet-4
• 自動儲存會話: 是
• 啟用使用量追蹤: 是
• MCP 伺服器自動啟動: 是

設定完成! 🎉
```

### 3.3 配置檔案

#### Claudia 配置

```json
// ~/.claudia/config.json
{
  "app": {
    "theme": "dark",
    "language": "zh-TW",
    "autoSave": true,
    "updateCheck": true
  },
  "claudeCode": {
    "defaultModel": "claude-sonnet-4",
    "maxTokens": 4000,
    "temperature": 0.7,
    "projectPaths": ["~/projects/web-app", "~/projects/api-service"]
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
  }
}
```

---

## 4. 使用指南

### 4.1 快速開始

#### 建立第一個專案

1. **開啟 Claudia**
2. **點選 "新增專案"**
3. **選擇專案目錄**
4. **配置 CLAUDE.md**
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

步驟 5: 選擇代理
> 🤖 Frontend Expert
> 🤖 Backend Architect

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

#### 專案切換

```
🗂️ 專案列表

📂 my-web-app (目前)
   ├── 最後活動: 2 分鐘前
   ├── 今日 tokens: 1,234
   └── 狀態: 🟢 活躍

📂 api-service
   ├── 最後活動: 1 小時前
   ├── 今日 tokens: 567
   └── 狀態: 🟡 閒置

📂 mobile-app
   ├── 最後活動: 昨天
   ├── 今日 tokens: 0
   └── 狀態: ⚫ 非活躍
```

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

1. **基本資訊**：名稱、描述、圖示
2. **系統提示**：定義代理的行為和專長
3. **工具配置**：選擇可用的工具
4. **模型設定**：選擇 AI 模型和參數
5. **測試驗證**：測試代理回應品質

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

📁 內建代理 (5)
├── 🖥️ Frontend Expert
├── 🏗️ Backend Architect
├── ⚙️ DevOps Engineer
├── 🛡️ Security Auditor
└── 📝 Documentation Writer

📁 我的代理 (3)
├── 🎨 UI/UX Designer
├── 📊 Data Analyst
└── 🧪 Test Engineer

📁 社群代理 (12)
├── 🚀 Performance Optimizer
├── 🔐 Security Scanner
└── ... (更多)
```

#### 代理共享

- **匯出代理**：將自訂代理打包為 `.agent` 檔案
- **匯入代理**：從檔案或 URL 匯入代理
- **社群分享**：上傳到 Claudia 代理庫
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

#### 可視化編輯器

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

- Frontend Expert: 前端開發任務
- Backend Architect: 後端和 API 開發
- DevOps Engineer: 部署和基礎設施
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

#### 主題系統

```css
/* 自訂主題範例 */
:root {
  /* 主要色彩 */
  --primary: #3b82f6;
  --secondary: #6366f1;
  --accent: #10b981;

  /* 背景色彩 */
  --background: #0f172a;
  --surface: #1e293b;
  --overlay: #334155;

  /* 文字色彩 */
  --text-primary: #f8fafc;
  --text-secondary: #cbd5e1;
  --text-muted: #64748b;

  /* 狀態色彩 */
  --success: #10b981;
  --warning: #f59e0b;
  --error: #ef4444;
  --info: #3b82f6;
}

.theme-custom {
  /* 套用自訂變數 */
  background-color: var(--background);
  color: var(--text-primary);
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

### 8.3 建置與部署

#### 開發環境設定

```bash
# 克隆專案
git clone https://github.com/getAsterisk/claudia.git
cd claudia

# 安裝依賴
npm install

# 安裝 Rust 工具鏈
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 安裝 Tauri CLI
npm install -g @tauri-apps/cli

# 開發模式運行
npm run tauri dev
```

#### 建置發布

```bash
# 建置生產版本
npm run tauri build

# 建置不同平台
npm run tauri build -- --target x86_64-pc-windows-msvc
npm run tauri build -- --target x86_64-apple-darwin
npm run tauri build -- --target x86_64-unknown-linux-gnu

# 建置輸出
# Windows: src-tauri/target/release/bundle/msi/
# macOS: src-tauri/target/release/bundle/dmg/
# Linux: src-tauri/target/release/bundle/deb/
```

---

## 9. 疑難排解

### 9.1 常見問題

#### Claude Code 連接問題

**問題**：Claudia 無法檢測到 Claude Code CLI

**解決方案**：

```bash
# 檢查 Claude Code 安裝
claude --version

# 檢查 PATH 環境變數
echo $PATH | grep claude

# 手動設定 Claude Code 路徑
# 在 Claudia 設定中指定 CLI 路徑
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

Claudia 版本: 1.2.3
作業系統: macOS 14.5.0
記憶體使用: 234MB / 8GB

Claude Code CLI:
✅ 已安裝: v2.1.0
✅ API 金鑰: 已設定
✅ 權限: 正常

MCP 伺服器:
✅ GitHub: 運行中
✅ PostgreSQL: 運行中
❌ Filesystem: 連接失敗

建議修復:
1. 重新啟動 Filesystem MCP 伺服器
2. 檢查檔案權限設定
```

---

## 10. 延伸閱讀

### 10.1 官方資源

- [Claudia GitHub](https://github.com/getAsterisk/claudia)
- [官方網站](https://claudiacode.com)
- [Discord 社群](https://discord.gg/G9g25nj9)
- [Twitter @getAsterisk](https://x.com/getAsterisk)

### 10.2 相關專案

- [Claude Code](https://github.com/anthropics/claude-code)
- [Tauri](https://tauri.app/)
- [CC Agents](https://github.com/getAsterisk/claudia/tree/main/cc_agents)

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

- [GitHub Discussions](https://github.com/getAsterisk/claudia/discussions)
- [Discord 技術支援](https://discord.gg/G9g25nj9)
- [問題回報](https://github.com/getAsterisk/claudia/issues)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/getAsterisk/claudia) 與相關文檔。
>
> **版本資訊**：Claudia v0.1.0 - Claude Code 圖形化界面工具  
> **最後更新**：2025-08-19T23:52:25+08:00
