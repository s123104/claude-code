# Awesome Claude Code 中文精選資源總覽

[![Awesome](https://awesome.re/badge-flat2.svg)](https://awesome.re)

> **版本**: 最新版本（2025-10-16 重大更新）

## 概述

這是一份精選的 **斜線指令**、**CLAUDE.md 檔案**、**CLI 工具** 和其他資源與指南的清單，用於增強您的 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 工作流程、生產力和體驗。

Claude Code 是由 [Anthropic](https://www.anthropic.com/) 發布的尖端 CLI 基礎編碼助手和代理，您可以在終端或 IDE 中訪問。這是一個快速發展的工具，提供許多強大的功能，並允許以多種不同方式進行大量配置。使用者正在積極探索最佳實踐和工作流程。希望此儲存庫能幫助社群分享知識並了解如何充分利用 Claude Code。

> **專案資訊**
>
> - **專案名稱**：Awesome Claude Code
> - **專案版本**：v2025.10.16
> - **專案最後更新**：2025-10-16
> - **文件整理時間**：2025-10-28T19:00:00+08:00
>
> **核心定位**
>
> - **功能**：精選的 Claude Code 資源總覽，包含 Agent Skills、斜線指令、CLI 工具、Hooks 系統等
> - **場景**：學習 Claude Code、提升工作流程、探索最佳實踐、社群資源發現
> - **客群**：Claude Code 用戶、開發者、學習者、工具探索者
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/hesreallyhim/awesome-claude-code)
> - [Anthropic 官方文檔](https://docs.anthropic.com/en/docs/claude-code/overview)
> - [Agent Skills 官方文檔](https://docs.claude.com/en/docs/claude-code/skills)
> - [官方斜線命令文檔](https://docs.anthropic.com/en/docs/claude-code/slash-commands)
> - [官方 Hooks 系統文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)

---

## 📢 重要公告

### 🆕 2025-10-16 - **AGENT SKILLS 重大更新**

**Claude Got Skills!**

自 Claude Code v2.0.20 起，我們獲得了一組**新功能**供使用者探索：[**Agent Skills**](https://docs.claude.com/en/docs/claude-code/skills)。

> **Agent skills** 是模型控制的配置（檔案、腳本、資源等），使 Claude Code 能夠執行需要特定知識或能力的專業任務。

---

## 🆕 本週新增

> 過去 7 天新增的資源

### [`Codex Skill`](https://github.com/skills-directory/skill-codex)

由 [klaudworks](https://github.com/klaudworks) 開發 | MIT 授權

使用戶能夠從 claude code 中提示 codex。與原始 codex mcp 伺服器不同，此技能會從您的提示中推斷參數（如模型、推理努力、沙箱），或要求您指定它們。它還簡化了繼續先前 codex 會話的過程，以便 codex 可以繼續使用先前的情境。

### [`claude-mem`](https://github.com/thedotmack/claude-mem)

由 [Alex Newman](https://github.com/thedotmack) 開發

持久化記憶壓縮系統，捕獲工具使用、生成 AI 驅動的會話摘要，並透過 SQLite 儲存和全文搜尋將相關情境注入未來的 Claude Code 會話中（無需額外成本依賴！）🦾

### [`cc-sessions`](https://github.com/GWUDCAP/cc-sessions)

由 [toastdev](https://github.com/satoastshi) 開發 | MIT 授權

使用 Claude Code 進行生產開發的主觀方法。

### [`fcakyon Collection`](https://github.com/fcakyon/claude-codex-settings/tree/main/.claude/hooks)

由 [Fatih Akyon](https://github.com/fcakyon) 開發 | Apache-2.0 授權

精心編寫的程式碼品質和工具使用管理 hooks 集合（例如強制使用 Tavily 而非 WebFetch 工具）。

### [`/linux-desktop-slash-commands`](https://github.com/danielrosehill/Claude-Code-Linux-Desktop-Slash-Commands)

由 [Daniel Rosehill](https://github.com/danielrosehill) 開發

專為促進 Linux 桌面環境中常見和進階操作的斜線指令庫（儘管許多指令在 Linux 伺服器上也很有用）。指令組包括硬體基準測試、檔案系統組織和安全性態勢驗證。

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. Agent Skills（代理技能）](#2-agent-skills代理技能) ⭐ 新增
- [3. 目錄分類與重點資源](#3-目錄分類與重點資源)
- [4. Workflow & Knowledge Guides](#4-workflow--knowledge-guides)
- [5. Tooling & IDE 整合](#5-tooling--ide-整合)
- [6. Hooks 實例](#6-hooks-實例)
- [7. Slash-Commands 精選](#7-slash-commands-精選)
- [8. CLAUDE.md 實戰範例](#8-claudemd-實戰範例)
- [9. MCP/整合與自動化](#9-mcp整合與自動化)
- [10. 社群貢獻與參與](#10-社群貢獻與參與)
- [11. 官方文檔與延伸閱讀](#11-官方文檔與延伸閱讀)

---

## 1. 專案簡介

Awesome Claude Code 是一份由社群協作維護的精選清單，收錄 Claude Code 相關的指令、CLAUDE.md、workflow、hooks、MCP 整合、IDE 工具、最佳實踐與各類自動化資源，協助開發者提升生產力、優化 AI 代理開發流程。

### 1.1 最新更新（2025-10-16）

- **🆕 Agent Skills**：Claude Code v2.0.20 新功能
- **新增工具**：claude-mem、cc-sessions、Codex Skill 等
- **持續維護**：定期更新社群貢獻的資源
- **品質保證**：嚴格的資源篩選標準
- **社群驅動**：開放式貢獻模式

---

## 2. Agent Skills（代理技能）

> **Agent skills** 是模型控制的配置（檔案、腳本、資源等），使 Claude Code 能夠執行需要特定知識或能力的專業任務。

### 什麼是 Agent Skills？

Agent Skills 是 Claude Code v2.0.20 引入的重大新功能。與傳統的斜線指令不同，Agent Skills 允許 Claude Code：

- ✅ **執行專業任務**：需要特定領域知識或技術能力的任務
- ✅ **模型控制**：由 AI 模型自主決定何時使用技能
- ✅ **情境感知**：根據對話情境自動推斷參數
- ✅ **可擴展性**：社群可以創建和分享自定義技能

### 官方資源

- 📚 [Agent Skills 官方文檔](https://docs.claude.com/en/docs/claude-code/skills)
- 🔗 [Agent Skills 規範](https://github.com/anthropics/skills/blob/main/agent_skills_spec.md)
- 📁 [Skills Directory](https://github.com/skills-directory)

### 可用的 Agent Skills

#### [`Codex Skill`](https://github.com/skills-directory/skill-codex)

**功能**：從 Claude Code 內部提示 Codex

- 自動推斷模型、推理努力、沙箱參數
- 簡化繼續先前 Codex 會話的過程
- 保持情境連續性

**使用場景**：

- 需要多步驟推理的複雜程式設計任務
- 需要深度思考的架構設計
- 跨會話的程式碼生成和優化

**目標使用者**：高級開發者、AI 研究人員、需要增強推理能力的專案

---

## 3. 目錄分類與重點資源

- **Workflows & Knowledge Guides**：專案啟動、管理、知識導入、Context Priming、SDLC 全流程
- **Tooling**：用量監控、Code Flow、IDE/編輯器整合、Webhooks、Swarm/多代理協作
- **Hooks**：各類 hooks 實作、TypeScript/PHP/Go 等語言範例
- **Slash-Commands**：Git/CI/PR/測試/優化/自動化/專案管理/文件/安全/AI 輔助
- **CLAUDE.md**：語言/領域/專案腳手架/記憶體協議（MCP）等範本
- **MCP/整合**：MCP server/client、API、外部資源引用、工具鏈串接
- **官方文檔**：安裝、API、MCP、工具定義、最佳實踐

---

## 3. Workflow & Knowledge Guides

- **Blogging Platform**：一鍵管理部落格文章、分類、媒體
- **ClaudeLog**：進階 CLAUDE.md 實戰、plan mode、配置技巧
- **Context Priming**：專案情境導入、目標/結構/協作參數
- **n8n_agent**：AI 驅動的 QA/設計/專案管理/優化全流程
- **Project Bootstrapping/Task Management**：專案啟動、slash-commands 自訂
- **Project Workflow System**：任務、審查、部署一條龍
- **Shipping Real Code**：真實產品交付流程
- **Simone**：文件/規範/流程一體化管理
- **Slash-commands megalist**：超過 80 條社群精選指令

---

## 4. Tooling & IDE 整合

- **CC Usage**：用量監控 CLI，token/cost 儀表板
- **Claude Code Flow**：遞迴式自動化 agent 編輯/測試/優化
- **Claude Hub**：Webhook 連 GitHub，AI 協作 PR/issue
- **Claude Squad/Swarm**：多代理協作、分工
- **IDE 插件**：Emacs（claude-code.el）、Neovim（claude-code.nvim）、桌面應用（crystal）

---

## 5. Hooks 實例與最佳實踐

### 5.1 官方 Hooks 系統架構

- **事件觸發點**：
  - `PreToolUse`：工具調用前執行
  - `PostToolUse`：工具完成後執行
  - `Notification`：需要用戶輸入或權限時觸發
  - `Stop`：主代理完成回應時執行

### 5.2 Hook 配置範例

```json
{
  "hooks": {
    "preToolUse": [
      {
        "name": "format-code",
        "command": ["prettier", "--write", "{file}"],
        "tools": ["Edit"],
        "filePatterns": ["*.js", "*.ts", "*.tsx"]
      }
    ],
    "postToolUse": [
      {
        "name": "run-tests",
        "command": ["npm", "test"],
        "tools": ["Edit"]
      }
    ],
    "notification": [
      {
        "name": "slack-notify",
        "command": ["curl", "-X", "POST", "slack-webhook-url"],
        "types": ["permission"]
      }
    ]
  }
}
```

### 5.3 社群 Hook 實作

- **claude-code-hooks-sdk**（PHP）：企業級 Hook 管理
- **claude-hooks**（TypeScript）：前端專案自動化
- **Linting/Testing/Notification**（Go）：高效能工具鏈整合

### 5.4 最佳實踐

- **結構化 JSON 輸出**：支援複雜的條件判斷和控制流程
- **型別安全**：TypeScript Hook 提供完整的型別檢查
- **錯誤處理**：透過 exit codes 和 stderr 回傳狀態
- **安全性**：Hook 以完整用戶權限執行，需謹慎設計

### 5.5 進階 Hook 範例

```bash
# 自動代碼格式化 Hook
#!/bin/bash
if [[ "$CLAUDE_TOOL" == "Edit" && "$CLAUDE_FILE" =~ \.(js|ts|tsx)$ ]]; then
    prettier --write "$CLAUDE_FILE"
    eslint --fix "$CLAUDE_FILE"
fi

# 自動測試執行 Hook
#!/bin/bash
if [[ "$CLAUDE_TOOL" == "Edit" ]]; then
    npm run test:affected
    exit $?
fi
```

---

## 6. Slash-Commands 精選與完整指南

### 6.1 內建斜線命令（官方）

| 命令分類     | 命令           | 功能說明           | 使用範例               |
| ------------ | -------------- | ------------------ | ---------------------- |
| **基礎控制** | `/help`        | 顯示可用命令幫助   | `/help`                |
|              | `/clear`       | 清除對話歷史       | `/clear`               |
|              | `/model`       | 選擇或切換 AI 模型 | `/model claude-opus-4` |
| **專案管理** | `/review`      | 請求程式碼審查     | `/review src/`         |
|              | `/init`        | 初始化專案記憶體   | `/init`                |
|              | `/memory`      | 管理專案記憶體     | `/memory view`         |
| **配置管理** | `/config`      | 查看/修改配置      | `/config list`         |
|              | `/permissions` | 管理工具權限       | `/permissions`         |
| **診斷工具** | `/doctor`      | 系統健康檢查       | `/doctor`              |
|              | `/status`      | 查看系統狀態       | `/status`              |
| **MCP 管理** | `/mcp`         | 互動式 MCP 管理    | `/mcp`                 |

### 6.2 社群精選斜線命令

#### Git 與版本控制

- `/commit` - 智能提交訊息生成
- `/create-pr` - 自動建立 Pull Request
- `/fix-issue` - 針對 Issue 進行修復
- `/pr-review` - Pull Request 深度審查
- `/update-branch-name` - 分支名稱標準化

#### 測試與程式碼品質

- `/check` - 全面程式碼檢查
- `/clean` - 程式碼清理和重構
- `/code_analysis` - 深度程式碼分析
- `/optimize` - 效能優化建議
- `/tdd` - 測試驅動開發輔助

#### 專案脈絡與文件

- `/context-prime` - 專案脈絡建立
- `/prime` - 快速脈絡載入
- `/rsi` - 重複性壓力傷害預防提醒
- `/add-to-changelog` - 自動更新變更日誌
- `/create-docs` - 文件自動生成
- `/update-docs` - 文件同步更新

#### CI/CD 與部署

- `/release` - 發布版本管理
- `/run-ci` - CI 流程觸發

#### 專案管理工具

- `/create-command` - 自訂命令建立
- `/todo` - 任務管理
- `/create-jtbd` - Jobs-to-be-Done 分析
- `/create-prd` - 產品需求文件生成

#### 專業工具

- `/act` - React 無障礙性檢查
- `/five` - 五個為什麼分析法
- `/mermaid` - 自動生成 ER 圖和流程圖
- `/use-stepper` - 步驟式流程設計

### 6.3 自訂斜線命令建立

#### 基本語法

```markdown
# 命令名稱

命令描述與用途說明

## 參數與選項

- --option1: 參數說明

## Examples

/command --option1 value
```

#### 進階範例：專案特定命令

```markdown
# security-audit

對專案進行全面安全審計，包括依賴檢查、程式碼掃描和配置驗證

## 參數與選項

- --deep: 執行深度掃描
- --fix: 自動修復發現的問題
- --report: 生成詳細報告

## Examples

/security-audit --deep --report
/security-audit --fix
```

### 6.4 MCP 動態斜線命令

MCP 伺服器會自動暴露斜線命令，格式為：`/mcp__<server-name>__<prompt-name>`

#### 常見 MCP 命令範例

```bash
# GitHub 整合
/mcp__github__list_prs
/mcp__github__create_issue "Bug 報告" "high"

# 資料庫操作
/mcp__postgres__query "SELECT * FROM users"
/mcp__postgres__schema "users"

# API 文檔
/mcp__docs__search "authentication"
/mcp__docs__reference "api/users"
```

### 6.5 最佳實踐

#### 命令組織結構

```
.claude/commands/
├── git/
│   ├── smart-commit.md
│   └── pr-template.md
├── testing/
│   ├── coverage-report.md
│   └── e2e-suite.md
└── shared/
    ├── project-init.md
    └── docs-sync.md
```

#### 命令命名規範

- 使用短橫線分隔：`create-component` 而非 `createComponent`
- 動詞在前：`check-security` 而非 `security-check`
- 保持簡潔：`deploy` 而非 `deploy-application`

#### 參數設計原則

- 提供合理預設值
- 支援布林選項：`--fix`、`--verbose`
- 允許多重選項：`--include src tests docs`
- 驗證必要參數

---

## 7. CLAUDE.md 實戰範例

- **語言/框架**：AI IntelliJ Plugin、AWS MCP Server、DroidconKotlin、EDSL、Giselle、HASH、Inkline、JSBeeb、Lamoom Python、LangGraphJS、Metabase、SG Cars Trends Backend、SPy、TPL
- **領域/專案**：AVS Vibe、Comm、Course Builder、Cursor Tools、Guitar、Note Companion、Pareto Mac、SteadyStart
- **MCP/腳手架**：Basic Memory、claude-code-mcp-enhanced、Perplexity MCP
- **官方建議**：/init 指令自動產生 CLAUDE.md，支援 @import、@path 引用

---

## 8. MCP 整合與自動化

- **MCP server/client**：`claude mcp add`、`claude mcp serve`、`claude mcp list`、`claude mcp get`、`claude mcp remove`
- **Slash-commands 與 MCP**：`/mcp__github__list_prs`、`/mcp__jira__create_issue "Bug" high`
- **API 工具鏈**：多工具串接、tool_use/stop_reason 處理、JSON 結構化回傳
- **外部資源引用**：@github:issue://123、@docs:file://api/authentication
- **權限規則**：Bash/Edit/Read/WebFetch/mcp\_\_\* 精細控管
- **自動化範例**：Python/CLI/Docker/HTTP/SSE 多協議

---

## 9. 社群貢獻與參與

- **貢獻方式**：Pull Request、/project:add-new-resource 指令、CLAUDE.md/HOOKS/指令投稿
- **內容收錄原則**：最佳實踐、創新/實驗性 workflow、工具/外掛、非傳統 AI 助理應用
- **License 注意**：未附 LICENSE 預設為全著作權，建議選擇開源授權
- **行為準則**：請遵守 code-of-conduct.md

---

## 10. 官方文檔與延伸閱讀

- [Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code/overview)
- [MCP/工具整合 API](https://docs.anthropic.com/en/docs/claude-code/docs/claude-code/mcp)
- [工具定義/最佳實踐](https://docs.anthropic.com/en/docs/claude-code/docs/agents-and-tools/tool-use/overview)
- [CLAUDE.md 記憶體協議](https://docs.anthropic.com/en/docs/claude-code/docs/claude-code/memory)
- [社群精選資源](https://github.com/hesreallyhim/awesome-claude-code)

---

> 本文件僅為社群整理版本，詳細內容與最新資源請參閱官方 GitHub 與文檔。
>
> **最後更新**：2025-10-29T02:05:00+08:00 | **專案更新**：2025-10-29T13:54:56-04:00
