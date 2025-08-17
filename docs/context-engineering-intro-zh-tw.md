# Context Engineering 脈絡工程入門指南

> **版本**: 最新版本


## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/coleam00/context-engineering-intro)
> - [Context Engineering 方法論](https://contextengineering.dev)
> - **文件整理時間：2025-08-17T23:55:00+08:00**
> - **專案最後更新：2025-08-10T 最新版本**

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
git clone https://github.com/coleam00/Context-Engineering-Intro.git
cd Context-Engineering-Intro

# 2. 設定專案規則（可選 - 提供範本）
# 編輯 CLAUDE.md 添加專案特定指導原則

# 3. 添加範例（強烈建議）
# 將相關程式碼範例放入 examples/ 資料夾

# 4. 建立初始功能需求
# 編輯 INITIAL.md 包含您的功能需求
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

#### 步驟 3：執行實作

```bash
# 在 Claude Code 中執行
/execute-prp PRPs/user-authentication.md
```

### 3.3 範本結構

```
context-engineering-template/
├── CLAUDE.md              # 專案規範和標準
├── INITIAL.md             # 初始功能需求
├── examples/              # 程式碼範例
│   ├── auth-example.js
│   ├── api-patterns.js
│   └── test-examples.js
├── PRPs/                  # 生成的產品需求規格
│   └── user-auth.md
├── use-cases/             # 特定使用案例
│   ├── mcp-server/
│   ├── pydantic-ai/
│   └── template-generator/
└── docs/                  # 文檔和指南
    ├── best-practices.md
    └── workflow-guide.md
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

# 系統會：
# 1. 分析 INITIAL.md 的需求
# 2. 讀取 CLAUDE.md 的專案標準
# 3. 掃描 examples/ 的相關範例
# 4. 結合專案脈絡生成詳細 PRP
```

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
/execute-prp PRPs/user-authentication.md

# 系統會：
# 1. 讀取 PRP 的詳細規格
# 2. 分析現有程式碼結構
# 3. 生成所需的程式碼檔案
# 4. 實作測試案例
# 5. 更新相關文檔
````

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

#### 組織範例檔案

```
examples/
├── authentication/
│   ├── jwt-service.js      # JWT 處理範例
│   ├── auth-middleware.js  # 認證中介軟體
│   └── password-utils.js   # 密碼處理工具
├── api-patterns/
│   ├── rest-controller.js  # REST API 控制器範例
│   ├── error-handling.js   # 錯誤處理模式
│   └── validation.js       # 輸入驗證範例
└── testing/
    ├── unit-test.spec.js   # 單元測試範例
    ├── integration.spec.js # 整合測試範例
    └── mock-data.js        # 測試資料範例
```

#### 範例檔案品質標準

- **完整性**：範例程式碼能夠運行
- **相關性**：與目前任務高度相關
- **最佳實踐**：展示正確的實作方式
- **文檔完整**：包含清晰的註解說明

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

---

## 7. 實用案例

### 7.1 MCP 伺服器開發

使用 Context Engineering 開發 MCP 伺服器的完整流程：

#### 案例：GitHub 整合 MCP 伺服器

```markdown
# INITIAL.md

# GitHub MCP 伺服器

## 背景和目標

為 Claude Code 提供 GitHub 整合能力，支援 issue 管理、PR 審查等功能。

## 功能需求

### 核心工具

- list_repositories：列出用戶倉庫
- create_issue：建立新 issue
- search_code：搜尋程式碼
- get_pull_request：獲取 PR 資訊

### 認證機制

- GitHub OAuth App 整合
- token 安全管理
- 權限範圍控制

## 技術要求

- TypeScript 實作
- Cloudflare Workers 部署
- 完整的錯誤處理
- 單元測試覆蓋

## 驗收標準

- [ ] 所有工具正常運作
- [ ] OAuth 認證流程完整
- [ ] 錯誤處理優雅
- [ ] 部署自動化完成
```

### 7.2 Pydantic AI 代理開發

#### 案例：智能程式碼審查代理

```markdown
# INITIAL.md

# 程式碼審查 AI 代理

## 背景和目標

建立智能程式碼審查代理，自動檢查程式碼品質、安全性和最佳實踐。

## 功能需求

### 核心能力

- 程式碼品質分析
- 安全漏洞檢測
- 效能問題識別
- 最佳實踐建議

### 整合需求

- Git 工作流程整合
- CI/CD 管道支援
- 多種程式語言支援

## 技術實作

- Pydantic AI 框架
- 結構化輸出格式
- 工具函數整合
- 完整測試套件

## 交付標準

- [ ] 代理正確分析程式碼
- [ ] 輸出格式結構化
- [ ] 整合測試通過
- [ ] 文檔完整
```

### 7.3 範本生成器

#### Meta-Framework 開發

這是一個生成其他範本的範本系統：

```markdown
# INITIAL.md

# Context Engineering 範本生成器

## 背景和目標

建立 Meta-Framework，能夠為任何技術領域生成專門的 Context Engineering 範本。

## 功能需求

### 範本類型

- 框架專用範本（React、Vue、Django 等）
- 領域專用範本（AI、區塊鏈、IoT 等）
- 專案類型範本（Web App、API、CLI 等）

### 生成能力

- 動態 CLAUDE.md 生成
- 相關範例程式碼收集
- 最佳實踐文檔生成
- 工作流程腳本生成

## 技術架構

- 範本引擎設計
- 知識庫管理
- API 介面設計
- 擴展機制設計
```

---

## 8. 延伸閱讀

### 8.1 官方資源

- [Context Engineering Intro GitHub](https://github.com/coleam00/context-engineering-intro)
- [Context Engineering 方法論](https://contextengineering.dev)
- [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)

### 8.2 相關專案

- [MCP 伺服器範例](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/mcp-server)
- [Pydantic AI 範本](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/pydantic-ai)
- [範本生成器](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/template-generator)

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
> **最後更新**：2025-08-17T23:55:00+08:00
