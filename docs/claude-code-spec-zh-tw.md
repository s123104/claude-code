# cc-sdd: AI 代理規格驅動開發工具

## 概述

cc-sdd 是一套革命性的規格驅動開發（Spec-Driven Development, SDD）工具，將 Claude Code、Cursor IDE、Gemini CLI、Codex CLI、GitHub Copilot、Qwen Code 和 Windsurf 從原型開發轉型為生產級開發，同時支援自訂規格與指導模板以符合團隊流程。

> **資料來源：**
>
> - [GitHub 專案](https://github.com/gotalab/claude-code-spec)
> - [npm 套件](https://www.npmjs.com/package/cc-sdd)
> - [Kiro IDE 文檔](https://kiro.dev/docs/specs/)
> - **文件整理時間：2025-10-27T23:45:00+08:00**
> - **專案版本：v1.1.5**
> - **專案最後更新：2025-10-25**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心概念](#2-核心概念)
- [3. 快速開始](#3-快速開始)
- [4. 支援平台](#4-支援平台)
- [5. 指令系統](#5-指令系統)
- [6. 工作流程](#6-工作流程)
- [7. 進階配置](#7-進階配置)
- [8. 專案結構](#8-專案結構)
- [9. 最佳實踐](#9-最佳實踐)
- [10. 疑難排解](#10-疑難排解)

---

## 1. 專案簡介

### 1.1 什麼是 cc-sdd？

**cc-sdd** 是一個一鍵安裝的 CLI 工具，為主流 AI 程式代理導入 **AI-DLC（AI 驅動開發生命週期）** 與 **SDD（規格驅動開發）** 工作流程。它能夠：

- 🚀 **快速衝刺取代傳統 Sprint**：從週到小時的交付週期
- 📋 **規格作為唱一信息源**：驅動整個開發生命週期
- 🧠 **持久專案記憶**：AI 在所有會話間維持完整上下文
- 🔄 **AI 原生 + 人類關卡**：AI 執行，人類在關鍵點驗證
- 🌍 **多語言多平台**：支援 12 種語言、8 個 AI 平台

### 1.2 核心價值主張

```
傳統開發流程           vs           AI-DLC 流程
─────────────                    ─────────────
2-4 週 Sprint                    小時至天的快速週期
70% 管理額外負擔                 專注於價值交付
會議、文檔、儀式                 AI 驅動執行、人類驗證
手動同步與溝通                   自動化規格傳播
週級交付                         小時級交付
```

### 1.3 使用場景

- **🏢 企業級開發**：標準化 AI 輔助開發流程
- **👨‍💻 個人專案**：快速從想法到實作
- **🔧 技術重構**：有計劃地modernize現有系統
- **📚 技術探索**：結構化學習新技術
- **🎯 MVP 開發**：快速驗證商業假設

---

## 2. 核心概念

### 2.1 AI-DLC（AI 驅動開發生命週期）

**AI-DLC** 是一種 AI 原生開發方法論，核心原則：

```yaml
原則:
  執行模式: "AI 驅動執行，人類驗證關鍵決策"
  速度: "快速衝刺（小時/天）取代傳統 Sprint（週）"
  負擔削減: "消除 70% 的管理額外負擔"
  品質控制: "在關鍵點設置人類批准關卡"
  
週期:
  需求階段: "AI 提問 → 人類回答 → AI 精煉"
  設計階段: "AI 設計 → 人類審查 → AI 調整"
  實作階段: "AI TDD 開發 → 自動測試 → 人類驗收"
```

### 2.2 SDD（規格驅動開發）

**規格作為基礎**，基於 [Kiro 的 Specs 方法論](https://kiro.dev/docs/specs/)：

```
Specs 方法論生命週期：
┌─────────────┐
│ spec-init   │ ← 初始化功能規格
└─────┬───────┘
      ↓
┌─────────────┐
│requirements │ ← AI 提出澄清問題
└─────┬───────┘
      ↓
┌─────────────┐
│  design     │ ← 技術設計（人類驗證）
└─────┬───────┘
      ↓
┌─────────────┐
│   tasks     │ ← 分解為實作任務
└─────┬───────┘
      ↓
┌─────────────┐
│    impl     │ ← TDD 實作
└─────────────┘
```

### 2.3 專案記憶（Steering）

**Steering** 是持久化的專案知識庫：

```markdown
steering.md 內容包含：
├── 專案概述與目標
├── 技術棧與架構決策
├── 程式碼風格與規範
├── 領域知識與業務規則
├── 最佳實踐與反模式
└── 團隊約定與流程
```

**關鍵優勢**：
- ✅ AI 在所有會話間保持一致理解
- ✅ 新成員快速了解專案脈絡
- ✅ 決策歷史可追溯
- ✅ 規格品質大幅提升

---

## 3. 快速開始

### 3.1 一鍵安裝

#### 基本安裝（Claude Code + 英文）

```bash
npx cc-sdd@latest
```

#### 繁體中文 + Claude Code

```bash
npx cc-sdd@latest --lang zh-TW
```

#### 其他 AI 平台（繁體中文）

```bash
# Cursor IDE
npx cc-sdd@latest --cursor --lang zh-TW

# Gemini CLI
npx cc-sdd@latest --gemini --lang zh-TW

# Claude Code SubAgents（Alpha 版）
npx cc-sdd@next --claude-agent --lang zh-TW

# GitHub Copilot（Alpha 版）
npx cc-sdd@next --copilot --lang zh-TW

# Windsurf IDE（Alpha 版）
npx cc-sdd@next --windsurf --lang zh-TW
```

### 3.2 驗證安裝

安裝完成後，檢查專案結構：

```bash
# Claude Code 用戶
ls .claude/commands/kiro/

# Cursor IDE 用戶
ls .cursor/commands/kiro/

# 檢查設定目錄
ls .kiro/settings/
```

### 3.3 第一個規格驅動開發

#### 新專案流程

```bash
# 1. 初始化功能規格
/kiro:spec-init 使用 OAuth 建構使用者認證系統

# 2. AI 提出澄清問題
/kiro:spec-requirements auth-system

# 3. 創建技術設計（人類驗證）
/kiro:spec-design auth-system

# 4. 分解為實作任務
/kiro:spec-tasks auth-system

# 5. TDD 實作
/kiro:spec-impl auth-system
```

#### 現有專案流程（建議）

```bash
# 0. 首先建立專案記憶（關鍵！）
/kiro:steering

# 1-5. 同新專案流程
/kiro:spec-init 為現有認證新增 OAuth
/kiro:spec-requirements oauth-enhancement

# 可選：分析差距
/kiro:validate-gap oauth-enhancement

# 繼續設計與實作
/kiro:spec-design oauth-enhancement
/kiro:validate-design oauth-enhancement  # 可選
/kiro:spec-tasks oauth-enhancement
/kiro:spec-impl oauth-enhancement
```

---

## 4. 支援平台

### 4.1 AI 代理支援矩陣

| 代理 | 狀態 | 版本 | 指令數 | 特殊功能 |
|------|------|------|--------|----------|
| **Claude Code** | ✅ 完全支援 | Stable | 11 個斜線指令 | `CLAUDE.md` 配置 |
| **Claude Code SubAgents** | ✅ 完全支援 | Alpha | 12 個指令 + 9 個子代理 | 需 `cc-sdd@next` |
| **Cursor IDE** | ✅ 完全支援 | Stable | 11 個指令 | `AGENTS.md` 配置 |
| **Gemini CLI** | ✅ 完全支援 | Stable | 11 個指令 | `GEMINI.md` 配置 |
| **Codex CLI** | ✅ 完全支援 | Alpha | 11 個提示 | 需 `cc-sdd@next` |
| **GitHub Copilot** | ✅ 完全支援 | Alpha | 11 個提示 | 需 `cc-sdd@next` |
| **Qwen Code** | ✅ 完全支援 | Stable | 11 個指令 | `QWEN.md` 配置 |
| **Windsurf IDE** | ✅ 完全支援 | Alpha | 11 個工作流程 | 需 `cc-sdd@next` |

### 4.2 語言支援（12 種）

| 語言 | 代碼 | 狀態 | 範例指令 |
|------|------|------|----------|
| 🇬🇧 英語 | `en` | ✅ | `npx cc-sdd@latest` |
| 🇯🇵 日語 | `ja` | ✅ | `npx cc-sdd@latest --lang ja` |
| 🇹🇼 繁體中文 | `zh-TW` | ✅ | `npx cc-sdd@latest --lang zh-TW` |
| 🇨🇳 簡體中文 | `zh` | ✅ | `npx cc-sdd@latest --lang zh` |
| 🇪🇸 西班牙語 | `es` | ✅ | `npx cc-sdd@latest --lang es` |
| 🇵🇹 葡萄牙語 | `pt` | ✅ | `npx cc-sdd@latest --lang pt` |
| 🇩🇪 德語 | `de` | ✅ | `npx cc-sdd@latest --lang de` |
| 🇫🇷 法語 | `fr` | ✅ | `npx cc-sdd@latest --lang fr` |
| 🇷🇺 俄語 | `ru` | ✅ | `npx cc-sdd@latest --lang ru` |
| 🇮🇹 義大利語 | `it` | ✅ | `npx cc-sdd@latest --lang it` |
| 🇰🇷 韓語 | `ko` | ✅ | `npx cc-sdd@latest --lang ko` |
| 🇸🇦 阿拉伯語 | `ar` | ✅ | `npx cc-sdd@latest --lang ar` |

### 4.3 作業系統支援

```bash
# 自動偵測（推薦）
npx cc-sdd@latest --lang zh-TW

# 手動指定（相容性需求）
npx cc-sdd@latest --lang zh-TW --os mac
npx cc-sdd@latest --lang zh-TW --os linux
npx cc-sdd@latest --lang zh-TW --os windows
```

**注意**：所有平台現在使用相同的指令模板，`--os` 參數保留給特殊相容性需求。

---

## 5. 指令系統

### 5.1 核心指令（Kiro 系列）

#### 5.1.1 規格初始化

```bash
/kiro:spec-init <description>
```

**功能**：初始化新功能的規格文件  
**範例**：
```bash
/kiro:spec-init 建立使用者註冊與登入系統
/kiro:spec-init 新增支付閘道整合
/kiro:spec-init 實作即時通知功能
```

**產出**：
- `.kiro/specs/<feature-name>/spec.md`（規格主文件）
- 初始專案結構

#### 5.1.2 需求收集

```bash
/kiro:spec-requirements <feature_name>
```

**功能**：AI 提出澄清問題以完善需求  
**流程**：
1. AI 分析初始描述
2. 生成澄清問題清單
3. 人類回答問題
4. AI 精煉 requirements.md

**產出**：
- `.kiro/specs/<feature-name>/requirements.md`

#### 5.1.3 技術設計

```bash
/kiro:spec-design <feature_name>
```

**功能**：創建技術設計文檔（需人類驗證）  
**內容包含**：
- 系統架構圖
- 資料模型設計
- API 端點定義
- 技術選型說明
- 安全性考量

**產出**：
- `.kiro/specs/<feature-name>/design.md`
- 系統流程圖（Mermaid 格式）

#### 5.1.4 任務分解

```bash
/kiro:spec-tasks <feature_name>
```

**功能**：將設計分解為可實作的任務  
**產出**：
- `.kiro/specs/<feature-name>/tasks.md`
- 任務依賴關係圖
- 預估時間（由 AI 提供）

#### 5.1.5 TDD 實作

```bash
/kiro:spec-impl <feature_name> [tasks]
```

**功能**：以測試驅動開發方式實作功能  
**流程**：
1. 寫測試（紅燈）
2. 最小實作（綠燈）
3. 重構（保持綠燈）
4. 重複

**範例**：
```bash
# 實作所有任務
/kiro:spec-impl auth-system

# 實作特定任務
/kiro:spec-impl auth-system task-1 task-3
```

#### 5.1.6 狀態追蹤

```bash
/kiro:spec-status <feature_name>
```

**功能**：查看功能開發進度  
**顯示資訊**：
- 需求完成度
- 設計審查狀態
- 任務完成進度
- 測試覆蓋率
- 阻塞問題

### 5.2 品質驗證指令（棕地專案）

#### 5.2.1 差距分析

```bash
/kiro:validate-gap <feature_name>
```

**功能**：分析現有功能與新需求間的差距  
**時機**：在 `spec-design` 之前執行  
**產出**：
- 現有功能清單
- 缺失功能清單
- 衝突點分析
- 遷移建議

#### 5.2.2 設計驗證

```bash
/kiro:validate-design <feature_name>
```

**功能**：驗證設計與現有系統的相容性  
**時機**：在 `spec-design` 之後執行  
**檢查項目**：
- 架構一致性
- API 相容性
- 資料模型整合
- 效能影響評估

### 5.3 專案記憶指令

#### 5.3.1 Steering 建立/更新

```bash
/kiro:steering
```

**功能**：建立或更新專案記憶文檔  
**執行時機**：
- ✅ **現有專案必須首先執行**
- ✅ 專案架構變更後
- ✅ 加入新團隊成員時
- ✅ 重大技術決策後

**AI 會分析**：
- 程式碼架構
- 依賴關係
- 命名慣例
- 設計模式
- 業務邏輯

**產出**：
- `.kiro/steering/steering.md`

#### 5.3.2 自訂領域知識

```bash
/kiro:steering-custom
```

**功能**：新增專門領域知識到 steering  
**使用場景**：
- 業務領域特殊規則
- 合規要求
- 第三方整合文檔
- 團隊特殊約定

---

## 6. 工作流程

### 6.1 標準 SDD 工作流程

```mermaid
graph TD
    A[/kiro:steering] -->|建立專案記憶| B[/kiro:spec-init]
    B -->|初始化規格| C[/kiro:spec-requirements]
    C -->|收集需求| D{需求完整?}
    D -->|否| C
    D -->|是| E[/kiro:spec-design]
    E -->|技術設計| F{設計通過?}
    F -->|否| E
    F -->|是| G[/kiro:spec-tasks]
    G -->|任務分解| H[/kiro:spec-impl]
    H -->|TDD 實作| I{所有測試通過?}
    I -->|否| H
    I -->|是| J[功能完成]
```

### 6.2 棕地專案工作流程（含驗證）

```mermaid
graph TD
    A[/kiro:steering] -->|分析現有系統| B[/kiro:spec-init]
    B --> C[/kiro:spec-requirements]
    C --> D[/kiro:validate-gap]
    D -->|差距分析| E[/kiro:spec-design]
    E --> F[/kiro:validate-design]
    F -->|相容性驗證| G{設計安全?}
    G -->|否| E
    G -->|是| H[/kiro:spec-tasks]
    H --> I[/kiro:spec-impl]
    I --> J[功能完成]
```

### 6.3 快速衝刺範例（實際時間）

```yaml
功能: 使用者認證系統（OAuth）
預估時間: 4-8 小時（vs 傳統 1-2 週）

時間軸:
  00:00 - 00:30  | /kiro:steering（現有專案）
  00:30 - 01:00  | /kiro:spec-init + requirements
  01:00 - 02:00  | 人類回答澄清問題 + AI 精煉需求
  02:00 - 03:00  | /kiro:spec-design + 人類審查
  03:00 - 03:30  | /kiro:validate-design（棕地）
  03:30 - 04:00  | /kiro:spec-tasks
  04:00 - 08:00  | /kiro:spec-impl（TDD 實作）
  
結果: 完整測試覆蓋的生產級程式碼
```

---

## 7. 進階配置

### 7.1 安裝選項

#### 7.1.1 Dry Run 模式

```bash
npx cc-sdd@latest --dry-run --lang zh-TW
```

**功能**：預覽安裝將執行的操作，不實際寫入檔案

#### 7.1.2 備份現有配置

```bash
npx cc-sdd@latest --backup --lang zh-TW
```

**功能**：安裝前自動備份現有配置檔案

#### 7.1.3 自訂 Kiro 目錄

```bash
npx cc-sdd@latest --kiro-dir docs/specs --lang zh-TW
```

**功能**：指定 `.kiro` 目錄位置

### 7.2 模板自訂

#### 7.2.1 模板位置

```
.kiro/settings/templates/
├── steering/
│   └── steering-template.md
├── requirements/
│   └── requirements-template.md
├── design/
│   └── design-template.md
└── tasks/
    └── tasks-template.md
```

#### 7.2.2 自訂需求模板範例

```markdown
# {{KIRO_DIR}}/settings/templates/requirements/requirements-template.md

# 功能需求：{{FEATURE_NAME}}

## 功能概述
{{FEATURE_DESCRIPTION}}

## 使用者故事
作為 [角色]
我想要 [功能]
以便 [目標]

## 功能性需求
### FR-1: [需求標題]
**描述**: 
**接受條件**:
- [ ] 條件 1
- [ ] 條件 2

## 非功能性需求
### NFR-1: 效能需求
- 回應時間 < 200ms
- 並發使用者 > 1000

### NFR-2: 安全性需求
- 資料加密傳輸
- 符合 GDPR 規範

## 約束條件與假設
- 約束 1
- 假設 1

---
**AI 澄清問題區**：
{{AI_QUESTIONS}}
```

### 7.3 多平台配置

#### 7.3.1 同時支援多個 AI 平台

```bash
# 先安裝 Claude Code
npx cc-sdd@latest --claude --lang zh-TW

# 再安裝 Cursor IDE（共用 .kiro/ 目錄）
npx cc-sdd@latest --cursor --lang zh-TW

# 兩個平台可以共用規格文件
```

#### 7.3.2 平台切換

```bash
# Claude Code 會話
claude

# Cursor IDE 會話
cursor

# 兩者共用相同的規格文件和專案記憶
```

---

## 8. 專案結構

### 8.1 完整檔案結構

```
project-root/
├── .claude/                        # Claude Code 配置
│   └── commands/
│       └── kiro/
│           ├── spec-init.md
│           ├── spec-requirements.md
│           ├── spec-design.md
│           ├── spec-tasks.md
│           ├── spec-impl.md
│           ├── spec-status.md
│           ├── validate-gap.md
│           ├── validate-design.md
│           ├── steering.md
│           ├── steering-custom.md
│           └── kiro-utils.md
│
├── .claude/agents/kiro/            # SubAgents（Alpha）
│   ├── requirements-agent.md
│   ├── design-agent.md
│   ├── implementation-agent.md
│   └── ... (9 個子代理)
│
├── .cursor/commands/kiro/          # Cursor IDE 指令
│   └── ... (與 Claude Code 相同)
│
├── .windsurf/workflows/            # Windsurf 工作流程
│   ├── spec-init.yaml
│   └── ... (11 個工作流程)
│
├── .kiro/                          # 核心配置與規格
│   ├── settings/
│   │   ├── rules/
│   │   │   ├── kiro-rules.md
│   │   │   └── platform-specific-rules.md
│   │   └── templates/
│   │       ├── steering/
│   │       ├── requirements/
│   │       ├── design/
│   │       └── tasks/
│   │
│   ├── specs/                      # 功能規格文件
│   │   └── <feature-name>/
│   │       ├── spec.md
│   │       ├── requirements.md
│   │       ├── design.md
│   │       ├── tasks.md
│   │       └── implementation-log.md
│   │
│   └── steering/                   # 專案記憶
│       ├── steering.md
│       └── custom-knowledge.md
│
├── CLAUDE.md                       # Claude Code 主配置
├── AGENTS.md                       # Cursor/Codex/Copilot 配置
├── GEMINI.md                       # Gemini CLI 配置
└── QWEN.md                         # Qwen Code 配置
```

### 8.2 規格文件範例

#### 8.2.1 spec.md

```markdown
# 功能規格：使用者認證系統

**狀態**: 實作中  
**建立時間**: 2025-10-27  
**負責人**: @team-lead

## 概述
實作完整的使用者認證系統，支援 OAuth 2.0 社交登入。

## 相關文件
- [需求文檔](./requirements.md)
- [技術設計](./design.md)
- [實作任務](./tasks.md)

## 時程規劃
- 需求收集: 2025-10-27
- 設計審查: 2025-10-28
- 實作完成: 2025-10-30
```

#### 8.2.2 requirements.md

```markdown
# 需求文檔：使用者認證系統

## 功能性需求

### FR-1: 社交登入
使用者可以透過 Google、GitHub 登入系統。

**接受條件**:
- [ ] 支援 Google OAuth 2.0
- [ ] 支援 GitHub OAuth 2.0
- [ ] 登入後自動建立使用者帳號
- [ ] 儲存社交帳號關聯資訊

### FR-2: 會話管理
系統維護使用者登入狀態。

**接受條件**:
- [ ] 使用 JWT token 管理會話
- [ ] Token 有效期 24 小時
- [ ] 支援 Refresh Token
- [ ] 登出清除所有 token

## 非功能性需求

### NFR-1: 安全性
- 所有密碼加密儲存（bcrypt）
- HTTPS 強制使用
- CSRF 防護
- Rate limiting (登入嘗試)

### NFR-2: 效能
- 登入回應時間 < 500ms
- 支援 1000 並發登入請求
```

#### 8.2.3 design.md

```markdown
# 技術設計：使用者認證系統

## 系統架構

\```mermaid
graph LR
    A[前端] -->|OAuth 重定向| B[OAuth Provider]
    B -->|授權碼| A
    A -->|授權碼| C[後端 API]
    C -->|驗證| B
    C -->|儲存| D[資料庫]
\```

## 資料模型

### User
\```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
\```

### OAuthAccount
\```sql
CREATE TABLE oauth_accounts (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    provider VARCHAR(50) NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    access_token TEXT,
    refresh_token TEXT,
    UNIQUE(provider, provider_user_id)
);
\```

## API 端點

### POST /auth/oauth/google
開始 Google OAuth 流程

**Request**:
\```json
{
  "redirect_uri": "https://app.example.com/callback"
}
\```

**Response**:
\```json
{
  "authorization_url": "https://accounts.google.com/o/oauth2/..."
}
\```

### POST /auth/oauth/callback
處理 OAuth 回調

**Request**:
\```json
{
  "code": "authorization_code",
  "state": "state_token"
}
\```

**Response**:
\```json
{
  "access_token": "jwt_token",
  "refresh_token": "refresh_token",
  "expires_in": 86400,
  "user": {
    "id": "uuid",
    "email": "user@example.com"
  }
}
\```

## 技術選型

- **後端框架**: FastAPI (Python)
- **資料庫**: PostgreSQL
- **快取**: Redis
- **OAuth 函式庫**: authlib
- **JWT**: python-jose

## 安全性考量

1. **OAuth State 參數**: 防止 CSRF 攻擊
2. **Token 儲存**: HttpOnly Cookie
3. **Rate Limiting**: 登入嘗試限制 5 次/分鐘
4. **Audit Log**: 記錄所有認證事件
```

#### 8.2.4 tasks.md

```markdown
# 實作任務：使用者認證系統

## Task 1: 資料庫模型 [2h]
**狀態**: ⏳ 待開始  
**依賴**: 無

### 子任務
- [ ] 建立 User 模型
- [ ] 建立 OAuthAccount 模型
- [ ] 建立資料庫遷移腳本
- [ ] 撰寫模型單元測試

### 接受條件
- [ ] 所有測試通過
- [ ] 遷移腳本可執行

---

## Task 2: OAuth 整合 [4h]
**狀態**: ⏳ 待開始  
**依賴**: Task 1

### 子任務
- [ ] 配置 Google OAuth
- [ ] 配置 GitHub OAuth
- [ ] 實作 OAuth 流程
- [ ] 撰寫整合測試

### 接受條件
- [ ] Google 登入成功
- [ ] GitHub 登入成功
- [ ] 測試覆蓋率 > 80%

---

## Task 3: JWT 會話管理 [3h]
**狀態**: ⏳ 待開始  
**依賴**: Task 2

### 子任務
- [ ] 實作 JWT 生成
- [ ] 實作 Token 驗證
- [ ] 實作 Refresh Token
- [ ] 撰寫安全性測試

### 接受條件
- [ ] Token 正確生成
- [ ] Token 驗證成功
- [ ] Refresh 機制運作

---

## Task 4: API 端點 [3h]
**狀態**: ⏳ 待開始  
**依賴**: Task 3

### 子任務
- [ ] 實作 /auth/oauth/google
- [ ] 實作 /auth/oauth/callback
- [ ] 實作 /auth/logout
- [ ] 撰寫 E2E 測試

### 接受條件
- [ ] 所有端點測試通過
- [ ] API 文檔生成

---

## 總預估時間: 12 小時
## 關鍵路徑: Task 1 → Task 2 → Task 3 → Task 4
```

---

## 9. 最佳實踐

### 9.1 何時使用 Steering

✅ **必須執行 `/kiro:steering` 的情況**：

1. **現有專案首次使用 cc-sdd**（最重要！）
2. 專案架構重大變更後
3. 採用新的技術棧
4. 團隊約定變更
5. 加入新團隊成員前

❌ **不需要頻繁執行**：
- 每個功能開發前（除非架構變更）
- 小的程式碼調整後

### 9.2 規格文檔品質指標

**優質規格文檔特徵**：

```yaml
完整性:
  - 所有需求明確定義
  - 接受條件可測試
  - 非功能性需求完整

可實作性:
  - 任務粒度適中（2-4 小時）
  - 技術選型明確
  - API 定義完整

可維護性:
  - 使用圖表輔助說明
  - 連結相關文檔
  - 決策理由記錄
```

### 9.3 團隊協作最佳實踐

#### 9.3.1 角色分工

```yaml
產品經理:
  負責: spec-init, 需求澄清, 設計審查
  工具: /kiro:spec-init, /kiro:spec-requirements

技術主管:
  負責: 設計審查, 架構決策, steering 維護
  工具: /kiro:spec-design, /kiro:steering, /kiro:validate-design

開發者:
  負責: 任務實作, 單元測試, 程式碼審查
  工具: /kiro:spec-impl, /kiro:spec-status
```

#### 9.3.2 Git 工作流程

```bash
# 1. 從 steering 開始（如需要）
git checkout main
git pull
/kiro:steering

# 2. 為新功能建立分支
git checkout -b feature/user-auth

# 3. 規格驅動開發
/kiro:spec-init 使用者認證系統
/kiro:spec-requirements user-auth
# ... 完成規格 ...

# 4. 提交規格文檔（供團隊審查）
git add .kiro/specs/user-auth/
git commit -m "docs: add user auth spec"
git push origin feature/user-auth

# 5. 建立 PR 審查規格
# 6. 規格通過後才開始實作
/kiro:spec-impl user-auth

# 7. 提交實作
git add .
git commit -m "feat: implement user auth system"
git push
```

### 9.4 模板自訂建議

#### 9.4.1 企業環境調整

```markdown
# .kiro/settings/templates/design/design-template.md

# 技術設計：{{FEATURE_NAME}}

## 合規性檢查清單（必填）
- [ ] GDPR 資料保護評估
- [ ] SOC 2 安全要求
- [ ] 存取控制審查
- [ ] 資料保留政策

## 成本評估（必填）
- 基礎設施成本: $XXX/月
- 第三方服務成本: $XXX/月
- 人力成本: XX 人天

## 風險評估（必填）
| 風險 | 機率 | 影響 | 緩解措施 |
|------|------|------|----------|
| ... | ... | ... | ... |

## 技術設計
... (原有內容) ...
```

---

## 10. 疑難排解

### 10.1 常見問題

#### Q1: 安裝後找不到 `/kiro:` 指令

**解決方案**：

```bash
# 檢查安裝
ls .claude/commands/kiro/  # Claude Code
ls .cursor/commands/kiro/  # Cursor IDE

# 重新安裝
npx cc-sdd@latest --lang zh-TW

# 重啟 AI 代理
```

#### Q2: Steering 生成品質不佳

**原因**：專案架構過於複雜或缺乏文檔

**解決方案**：

```bash
# 1. 先整理專案結構
# 2. 新增關鍵文檔（README, ARCHITECTURE.md）
# 3. 使用 steering-custom 補充領域知識
/kiro:steering-custom

# 4. 重新生成 steering
/kiro:steering
```

#### Q3: 規格文檔過於籠統

**原因**：需求收集階段澄清不足

**解決方案**：

```bash
# 重新執行需求收集，提供更詳細回答
/kiro:spec-requirements <feature-name>

# 使用 validate-gap 分析差距
/kiro:validate-gap <feature-name>
```

#### Q4: 多平台配置衝突

**解決方案**：

```bash
# 使用獨立的 KIRO_DIR
npx cc-sdd@latest --claude --kiro-dir .kiro-claude
npx cc-sdd@latest --cursor --kiro-dir .kiro-cursor

# 或使用符號連結共用規格
ln -s .kiro-claude/specs .kiro-cursor/specs
```

### 10.2 效能優化

#### 10.2.1 大型專案 Steering 優化

```bash
# 僅分析特定目錄
/kiro:steering --focus src/core/

# 排除不重要的目錄
/kiro:steering --exclude node_modules/ dist/ test/
```

#### 10.2.2 規格文檔大小控制

```yaml
建議規格大小:
  requirements.md: "< 5 頁"
  design.md: "< 10 頁（含圖表）"
  tasks.md: "< 20 個任務"
  
過大時:
  - 考慮拆分為多個子功能
  - 使用外部連結參考詳細文檔
  - 專注於核心決策記錄
```

### 10.3 診斷指令

```bash
# 檢查安裝完整性
npx cc-sdd@latest --verify

# 顯示配置資訊
npx cc-sdd@latest --show-config

# 清理並重新安裝
npx cc-sdd@latest --clean --reinstall
```

---

## 附錄

### A. 指令快速參考

```bash
# 核心工作流程
/kiro:steering                          # 建立專案記憶
/kiro:spec-init <desc>                  # 初始化規格
/kiro:spec-requirements <name>          # 收集需求
/kiro:spec-design <name>                # 技術設計
/kiro:spec-tasks <name>                 # 任務分解
/kiro:spec-impl <name> [tasks]          # TDD 實作
/kiro:spec-status <name>                # 查看狀態

# 品質驗證（棕地）
/kiro:validate-gap <name>               # 差距分析
/kiro:validate-design <name>            # 設計驗證

# 專案記憶
/kiro:steering-custom                   # 自訂知識
```

### B. 官方資源

- **GitHub**: https://github.com/gotalab/claude-code-spec
- **npm**: https://www.npmjs.com/package/cc-sdd
- **Kiro IDE**: https://kiro.dev
- **文檔**: https://github.com/gotalab/cc-sdd/tree/main/docs
- **問題回報**: https://github.com/gotalab/cc-sdd/issues

### C. 版本更新記錄

**v1.1.5** (2025-10-25)
- 新增 Windsurf IDE 支援
- 改善模板系統
- 效能優化

**v1.1.0** (2025-10)
- 新增 Claude Code SubAgents 支援
- 新增 12 種語言支援
- 改善 steering 品質

**v1.0.0** (2025-09)
- 首個穩定版本發布
- 支援 7 個 AI 平台
- 完整 SDD 工作流程

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/gotalab/claude-code-spec) 與相關文檔。
>
> **版本資訊**：cc-sdd v1.1.5 - AI 代理規格驅動開發工具  
> **最後更新**：2025-10-27T23:45:00+08:00  
> **授權條款**：MIT License
