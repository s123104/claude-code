# Context Engineering 脈絡工程入門指南

## 概述

Context Engineering（脈絡工程）是一門為 AI 程式設計助手工程化脈絡的學科，確保 AI 具備端到端完成任務所需的完整資訊。本專案提供完整的 **PRP 工作流程範本**（Planning, Requirements, Process）、**結構化文檔模板**和**最佳實踐指南**，幫助開發者有效地與 AI 協作開發。

> **Context Engineering 比 prompt engineering 好 10 倍，比 vibe coding 好 100 倍。**

透過系統性地組織和提供 AI 所需的背景資訊，脈絡工程能夠大幅提升 AI 輸出的品質和一致性，確保 AI 能夠完整地完成複雜任務。

> **專案資訊**
>
> - **專案名稱**：Context Engineering Intro
> - **專案版本**：最新版本
> - **專案最後更新**：2025-11-15
> - **文件整理時間**：2025-12-24T00:42:00+08:00
>
> **核心定位**
>
> - **功能**：提供 PRP 工作流程、結構化範本和最佳實踐，幫助開發者建立高效的 AI 協作流程
> - **場景**：新專案啟動、AI 協作開發、技術寫作、知識管理、程式碼生成
> - **客群**：AI 輔助開發者、技術寫作者、專案經理、知識工程師
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/coleam00/context-engineering-intro)
> - [Context Engineering 方法論網站](https://contextengineering.dev)
> - [PRP 工作流程說明](https://github.com/coleam00/context-engineering-intro#prp-workflow)

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. Context Engineering 核心概念](#2-context-engineering-核心概念)
- [3. 快速開始](#3-快速開始)
- [4. PRP 工作流程](#4-prp-工作流程)
- [5. 範本系統](#5-範本系統)
- [6. 最佳實踐](#6-最佳實踐)
- [7. 實用案例](#7-實用案例)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 專案簡介

Context Engineering（脈絡工程）是一門為 AI 程式設計助手工程化脈絡的學科，確保 AI 具備端到端完成任務所需的完整資訊。這個專案提供了完整的範本和方法論，幫助開發者有效地與 AI 協作開發。

### 1.1 核心理念

> **Context Engineering 比 prompt engineering 好 10 倍，比 vibe coding 好 100 倍。**

- **結構化脈絡**：系統性地組織和提供 AI 所需的背景資訊
- **端到端交付**：確保 AI 能夠完整地完成複雜任務
- **可重複流程**：建立標準化的開發流程和範本
- **品質保證**：透過脈絡工程提升 AI 輸出的品質和一致性

### 1.2 使用場景

- **新專案啟動**：快速建立 AI 輔助開發的標準流程
- **複雜功能開發**：系統性地分解和實作大型功能
- **團隊協作**：標準化 AI 輔助開發的最佳實踐
- **程式碼品質**：提升 AI 生成程式碼的品質和維護性
- **知識管理**：累積和重用開發經驗和最佳實踐

---

## 2. Context Engineering 核心概念

### 2.1 什麼是 Context Engineering？

Context Engineering 是一種結構化方法，用於：

1. **定義清晰的需求**：使用 INITIAL.md 描述功能需求
2. **提供充足的脈絡**：包含相關程式碼範例和專案資訊
3. **建立執行規範**：透過 CLAUDE.md 定義專案標準
4. **生成詳細規格**：使用 PRP（Product Requirements Prompt）系統
5. **執行與驗證**：依據規格實作並驗證結果

### 2.2 傳統方法 vs Context Engineering

#### 傳統 Prompt Engineering

```
❌ "請幫我寫一個用戶認證系統"

問題：
- 缺乏具體需求
- 沒有專案脈絡
- 無法確保品質
- 難以重複使用
```

#### Context Engineering

```
✅ 結構化流程：

1. INITIAL.md - 詳細需求描述
2. CLAUDE.md - 專案規範和標準
3. examples/ - 相關程式碼範例
4. PRP 生成 - 綜合產品需求規格
5. 執行實作 - 基於完整脈絡的實作

結果：
- 明確的需求定義
- 一致的程式碼品質
- 可重複的開發流程
- 累積的知識資產
```

### 2.3 PRP（Product Requirements Prompt）概念

PRP 融合了傳統 PRD（產品需求文件）的嚴謹性和現代 prompt engineering 的脈絡導向思維：

- **範圍明確**：避免過度指定建構方式，專注於需求本身
- **脈絡豐富**：提供充足的背景資訊和範例
- **可執行性**：直接可用於 AI 實作的格式

---

## 3. 快速開始

### 3.1 安裝與設定

```bash
# 1. 克隆範本
git clone https://github.com/coleam00/context-engineering-intro.git
cd context-engineering-intro

# 2. 設定專案規則（可選 - 提供範本）
# 編輯 CLAUDE.md 添加專案特定指導原則

# 3. 添加範例（強烈建議）
# 將相關程式碼範例放入 examples/ 資料夾

# 4. 建立初始功能需求
# 編輯 INITIAL.md 包含您的功能需求

# 5. 生成全面的 PRP（產品需求提示）
# 在 Claude Code 中執行：
/generate-prp INITIAL.md

# 6. 執行 PRP 以實作功能
# 在 Claude Code 中執行：
/execute-prp PRPs/your-feature-name.md
```

### 3.2 基本工作流程

#### 步驟 1：定義需求（INITIAL.md）

```markdown
# 用戶認證系統

## 功能需求

- 用戶註冊與登入
- JWT token 管理
- 密碼加密與驗證
- 角色權限控制

## 技術要求

- 使用 Node.js + Express
- PostgreSQL 資料庫
- bcrypt 密碼加密
- JWT token 認證

## 驗收標準

- 所有 API 端點正常運作
- 密碼安全性符合最佳實踐
- 完整的錯誤處理機制
- 單元測試覆蓋率 > 80%
```

#### 步驟 2：生成 PRP

```bash
# 在 Claude Code 中執行
/generate-prp INITIAL.md
```

**注意**：斜線命令是定義在 `.claude/commands/` 中的自訂命令。您可以查看其實作：
- `.claude/commands/generate-prp.md` - 查看如何研究和建立 PRP
- `.claude/commands/execute-prp.md` - 查看如何從 PRP 實作功能

這些命令中的 `$ARGUMENTS` 變數會接收您在命令名稱後傳遞的任何內容（例如 `INITIAL.md` 或 `PRPs/your-feature.md`）。

此命令會：
1. 讀取您的功能需求
2. 研究程式碼庫以尋找模式
3. 搜尋相關文檔
4. 在 `PRPs/your-feature-name.md` 中建立全面的 PRP

#### 步驟 3：執行實作

```bash
# 在 Claude Code 中執行
/execute-prp PRPs/your-feature-name.md
```

AI 編碼助手會：
1. 從 PRP 讀取所有脈絡
2. 建立詳細的實作計劃
3. 執行每個步驟並進行驗證
4. 執行測試並修復任何問題
5. 確保所有成功標準都達成

### 3.3 範本結構

```
context-engineering-intro/
├── .claude/
│   ├── commands/
│   │   ├── generate-prp.md    # 生成全面 PRP 的命令
│   │   └── execute-prp.md     # 執行 PRP 實作功能的命令
│   └── settings.local.json    # Claude Code 權限設定
├── PRPs/
│   ├── templates/
│   │   └── prp_base.md       # PRP 基礎範本
│   └── EXAMPLE_multi_agent_prp.md  # 完整 PRP 範例
├── examples/                  # 您的程式碼範例（關鍵！）
│   ├── README.md             # 說明每個範例的用途
│   ├── cli.py                # CLI 實作模式
│   ├── agent/                # Agent 架構模式
│   │   ├── agent.py          # Agent 建立模式
│   │   ├── tools.py          # 工具實作模式
│   │   └── providers.py     # 多提供者模式
│   └── tests/                # 測試模式
│       ├── test_agent.py     # 單元測試模式
│       └── conftest.py       # Pytest 配置
├── use-cases/                # 特定使用案例
│   ├── agent-factory-with-subagents/  # AI Agent Factory（含子代理）
│   ├── ai-coding-workflows-foundation/  # AI 編碼工作流程基礎
│   ├── mcp-server/          # MCP 伺服器範本
│   ├── pydantic-ai/         # Pydantic AI 範本
│   └── template-generator/  # 範本生成器
├── validation/               # 驗證工具
│   ├── example-validate.md
│   ├── README.md
│   └── ultimate_validate_command.md
├── claude-code-full-guide/   # Claude Code 完整指南
│   ├── CLAUDE.md
│   ├── INITIAL.md
│   ├── install_claude_code_windows.md
│   └── PRPs/
│       ├── EXAMPLE_multi_agent_prp.md
│       └── templates/
│           └── prp_base.md
├── CLAUDE.md                 # AI 助手的全域規則
├── INITIAL.md                # 功能需求範本
├── INITIAL_EXAMPLE.md        # 功能需求範例
└── README.md                 # 專案說明文件
```

---

## 4. PRP 工作流程

### 4.1 PRP 生成流程

#### 輸入要素

1. **INITIAL.md**：基礎需求描述
2. **CLAUDE.md**：專案規範和標準
3. **examples/**：相關程式碼範例
4. **專案脈絡**：現有程式碼庫資訊

#### 生成過程

```bash
/generate-prp INITIAL.md
```

**生成過程詳解**：

1. **研究階段**
   - 分析您的程式碼庫以尋找模式
   - 搜尋類似的實作
   - 識別要遵循的慣例

2. **文檔收集**
   - 獲取相關 API 文檔
   - 包含函式庫文檔
   - 添加注意事項和特殊情況

3. **藍圖建立**
   - 建立逐步實作計劃
   - 包含驗證關卡
   - 添加測試要求

4. **品質檢查**
   - 評分信心等級（1-10）
   - 確保包含所有脈絡

#### 輸出結果

````markdown
# PRP: 用戶認證系統

## 專案脈絡

- 專案類型: Node.js REST API
- 技術棧: Express + PostgreSQL + JWT
- 程式碼風格: ESLint + Prettier
- 測試框架: Jest

## 詳細需求

### API 端點設計

- POST /auth/register - 用戶註冊
- POST /auth/login - 用戶登入
- POST /auth/refresh - token 刷新
- POST /auth/logout - 用戶登出

### 資料模型

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT NOW()
);
```
````

### 實作指南

1. 使用 bcrypt 進行密碼雜湊
2. JWT payload 包含 userId, role, iat, exp
3. 實作 refresh token 機制
4. 添加 rate limiting 防護

### 測試要求

- 單元測試：所有 service 函數
- 整合測試：API 端點完整流程
- 安全測試：常見攻擊防護驗證

````

### 4.2 PRP 執行

```bash
/execute-prp PRPs/your-feature-name.md
```

**執行過程詳解**：

1. **載入脈絡**：讀取整個 PRP
2. **計劃**：使用 TodoWrite 建立詳細任務清單
3. **執行**：實作每個元件
4. **驗證**：執行測試和 linting
5. **迭代**：修復發現的任何問題
6. **完成**：確保所有需求都達成

**PRP 內容**：

PRP（Product Requirements Prompt）是全面的實作藍圖，包含：
- 完整的脈絡和文檔
- 帶驗證的實作步驟
- 錯誤處理模式
- 測試要求

它們類似於 PRD（產品需求文件），但更專門針對指導 AI 編碼助手而設計。

**查看範例**：參閱 `PRPs/EXAMPLE_multi_agent_prp.md` 查看生成的完整範例。

---

## 5. 範本系統

### 5.1 通用範本

#### CLAUDE.md 範本

```markdown
# 專案：[專案名稱]

## 專案概述

[專案的詳細描述，包括目標、範圍和主要功能]

## 技術棧

- 後端：[技術選擇]
- 前端：[技術選擇]
- 資料庫：[資料庫選擇]
- 部署：[部署平台]

## 開發規範

### 程式碼風格

- 使用 [Linter] 進行程式碼檢查
- 遵循 [Style Guide] 風格指南
- 所有函數必須有完整的文檔註解

### 測試要求

- 單元測試覆蓋率 ≥ 80%
- 整合測試覆蓋核心業務流程
- E2E 測試覆蓋關鍵用戶路徑

### API 設計

- 遵循 RESTful 設計原則
- 使用統一的錯誤回應格式
- 實作適當的狀態碼和錯誤訊息

## 安全要求

- 所有輸入進行驗證和清理
- 敏感資料必須加密儲存
- 實作適當的認證和授權機制
```

#### INITIAL.md 範本

```markdown
# [功能名稱]

## 背景和目標

[描述為什麼需要這個功能，以及它要解決什麼問題]

## 功能需求

### 核心功能

- [核心功能 1]
- [核心功能 2]
- [核心功能 3]

### 非功能需求

- 效能要求：[具體指標]
- 安全要求：[安全考量]
- 可用性要求：[可用性標準]

## 技術考量

- 技術棧限制：[特定技術要求]
- 整合需求：[與現有系統的整合]
- 擴展性考量：[未來擴展的可能性]

## 驗收標準

- [ ] [驗收標準 1]
- [ ] [驗收標準 2]
- [ ] [驗收標準 3]

## 參考資料

- [相關文檔連結]
- [類似實作參考]
```

### 5.2 專業領域範本

#### MCP 伺服器範本

```markdown
# MCP 伺服器：[伺服器名稱]

## 功能概述

提供 [具體功能] 的 Model Context Protocol 伺服器實作

## 工具定義

### [工具名稱 1]

- 功能：[具體功能描述]
- 輸入：[參數定義]
- 輸出：[回傳格式]

### [工具名稱 2]

- 功能：[具體功能描述]
- 輸入：[參數定義]
- 輸出：[回傳格式]

## 技術實作

- 使用 TypeScript 開發
- 遵循 MCP 協議規範
- 實作完整的錯誤處理
- 包含 OAuth 認證機制

## 部署方式

- Cloudflare Workers 部署
- 環境變數配置
- CI/CD 自動化流程
```

---

## 6. 最佳實踐

### 6.1 編寫有效的 INITIAL.md

#### ✅ 好的範例

```markdown
# 即時通知系統

## 背景和目標

目前用戶無法即時收到重要事件通知，導致響應延遲。
需要建立即時通知系統，支援多種通知管道。

## 功能需求

### 核心功能

- WebSocket 即時推送
- 郵件通知備援
- 通知類型管理（緊急、一般、資訊）
- 用戶偏好設定（哪些事件要通知）

### 非功能需求

- 延遲 < 100ms（WebSocket）
- 支援 10,000 併發連線
- 99.9% 可用性

## 技術考量

- 使用 Redis 作為訊息佇列
- WebSocket 連線管理
- 郵件服務整合（SendGrid）

## 驗收標準

- [ ] 用戶可即時收到重要事件通知
- [ ] 通知延遲低於 100ms
- [ ] 支援郵件備援機制
- [ ] 提供通知偏好設定介面
```

#### ❌ 避免的寫法

```markdown
# 通知功能

## 需求

做一個通知系統。

## 要求

- 要快
- 要穩定
- 好用

## 技術

用新技術。
```

### 6.2 有效使用範例

`examples/` 資料夾對成功**至關重要**。當 AI 編碼助手能看到要遵循的模式時，表現會好得多。

#### 組織範例檔案

```
examples/
├── README.md           # 說明每個範例的用途
├── cli.py             # CLI 實作模式
├── agent/             # Agent 架構模式
│   ├── agent.py      # Agent 建立模式
│   ├── tools.py      # 工具實作模式
│   └── providers.py  # 多提供者模式
└── tests/            # 測試模式
    ├── test_agent.py # 單元測試模式
    └── conftest.py   # Pytest 配置
```

#### 範例應包含的內容

1. **程式碼結構模式**
   - 如何組織模組
   - 匯入慣例
   - 類別/函數模式

2. **測試模式**
   - 測試檔案結構
   - Mock 方法
   - 斷言風格

3. **整合模式**
   - API 客戶端實作
   - 資料庫連接
   - 認證流程

4. **CLI 模式**
   - 參數解析
   - 輸出格式化
   - 錯誤處理

#### 範例檔案品質標準

- **完整性**：範例程式碼能夠運行
- **相關性**：與目前任務高度相關
- **最佳實踐**：展示正確的實作方式
- **文檔完整**：包含清晰的註解說明
- **README 說明**：每個範例都應有 README 說明其用途

### 6.3 迭代改進

#### 版本管理

```
PRPs/
├── v1/
│   └── user-auth-v1.md     # 初始版本
├── v2/
│   └── user-auth-v2.md     # 改進版本
└── current/
    └── user-auth.md        # 目前版本
```

#### 回饋循環

1. **實作結果分析**：檢查 AI 輸出品質
2. **脈絡優化**：改進 CLAUDE.md 和範例
3. **流程改進**：優化 PRP 生成流程
4. **知識累積**：更新最佳實踐文檔

### 6.4 驗證工具

專案包含驗證工具目錄 (`validation/`)，提供：
- **範例驗證**：驗證範例的正確性
- **終極驗證命令**：全面的驗證流程
- **驗證指南**：如何有效使用驗證工具

### 6.5 最佳實踐總結

1. **在 INITIAL.md 中明確**：不要假設 AI 知道您的偏好
2. **提供全面的範例**：更多範例 = 更好的實作
3. **使用驗證關卡**：PRP 包含必須通過的測試命令
4. **利用文檔**：包含官方 API 文檔和 MCP 伺服器資源
5. **自訂 CLAUDE.md**：添加您的慣例和專案特定規則

---

## 7. 實用案例

專案包含多個完整的使用案例範本，每個都展示了 Context Engineering 在不同場景下的應用：

### 7.1 MCP 伺服器開發 (`use-cases/mcp-server/`)

使用 Context Engineering 開發 MCP 伺服器的完整流程，包含：
- TypeScript 實作範本
- Cloudflare Workers 部署配置
- OAuth 認證機制
- 完整的測試套件
- 資料庫工具實作範例

**範例功能**：
- GitHub OAuth 整合
- 資料庫工具（含 Sentry 錯誤追蹤）
- MCP 協議規範遵循
- 完整的錯誤處理

### 7.2 Pydantic AI 代理開發 (`use-cases/pydantic-ai/`)

建立 Pydantic AI 代理的完整範本，包含：
- 基本聊天代理
- 結構化輸出代理
- 工具啟用代理
- 測試模式範例

**範例功能**：
- 多提供者支援（OpenAI、Anthropic 等）
- 工具函數整合
- 結構化輸出格式
- 完整的測試套件

### 7.3 AI Agent Factory（含子代理）(`use-cases/agent-factory-with-subagents/`)

建立具有子代理的 AI Agent Factory，包含：
- RAG Agent 完整實作
- 文件擷取和嵌入流程
- 多提供者支援
- CLI 介面
- 完整的測試和驗證報告

**範例功能**：
- RAG（檢索增強生成）代理
- 文件擷取和分塊
- 向量嵌入和搜尋
- SQLite 資料庫整合
- 完整的依賴管理

### 7.4 AI 編碼工作流程基礎 (`use-cases/ai-coding-workflows-foundation/`)

建立 AI 編碼工作流程的基礎架構，包含：
- 程式碼庫分析代理
- 驗證代理
- 計劃建立和執行命令
- 入門指南

**範例功能**：
- 程式碼庫分析
- 自動驗證
- 計劃生成
- 執行追蹤

### 7.5 範本生成器 (`use-cases/template-generator/`)

Meta-Framework 開發範本，能夠為任何技術領域生成專門的 Context Engineering 範本。

**範例功能**：
- 動態 CLAUDE.md 生成
- 相關範例程式碼收集
- 最佳實踐文檔生成
- 工作流程腳本生成

### 7.6 Claude Code 完整指南 (`claude-code-full-guide/`)

專為 Claude Code 使用者設計的完整指南，包含：
- Windows 安裝指南
- 完整的工作流程範例
- PRP 範本和範例
- 最佳實踐

**範例功能**：
- Claude Code 安裝和設定
- 工作流程建立
- PRP 生成和執行
- 多代理協作範例

---

## 8. 延伸閱讀

### 8.1 官方資源

- [Context Engineering Intro GitHub](https://github.com/coleam00/context-engineering-intro)
- [Context Engineering 方法論](https://contextengineering.dev)
- [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)

### 8.2 相關專案和使用案例

- [MCP 伺服器範例](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/mcp-server)
- [Pydantic AI 範本](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/pydantic-ai)
- [AI Agent Factory（含子代理）](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/agent-factory-with-subagents)
- [AI 編碼工作流程基礎](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/ai-coding-workflows-foundation)
- [範本生成器](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/template-generator)
- [Claude Code 完整指南](https://github.com/coleam00/context-engineering-intro/tree/main/claude-code-full-guide)

### 8.3 最佳實踐資源

- [PRP 設計模式](https://github.com/coleam00/context-engineering-intro/blob/main/docs/prp-patterns.md)
- [AI 協作工作流程](https://github.com/coleam00/context-engineering-intro/blob/main/docs/workflow-guide.md)
- [品質保證指南](https://github.com/coleam00/context-engineering-intro/blob/main/docs/quality-guide.md)

### 8.4 社群資源

- [Context Engineering 討論群](https://github.com/coleam00/context-engineering-intro/discussions)
- [最佳實踐分享](https://github.com/coleam00/context-engineering-intro/wiki)
- [範本貢獻指南](https://github.com/coleam00/context-engineering-intro/blob/main/CONTRIBUTING.md)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/coleam00/context-engineering-intro) 與相關文檔。
>
> **版本資訊**：Context Engineering - AI 輔助開發脈絡工程方法論  
> **最後更新**：2025-11-25T02:45:00+08:00  
> **專案更新**：2025-11-15T18:41:25-06:00  
> **主要變更**：新增 `.claude/commands/` 自訂命令系統（generate-prp、execute-prp）、新增多個使用案例（agent-factory-with-subagents、ai-coding-workflows-foundation、mcp-server、pydantic-ai、template-generator）、新增 validation/ 驗證工具目錄、新增 claude-code-full-guide/ 完整指南、更新 PRP 工作流程詳細說明、更新範例結構和使用指南、新增最佳實踐總結
