# Awesome Claude Code 中文精選資源總覽

> **資料來源：**
>
> - [GitHub 專案](https://github.com/hesreallyhim/awesome-claude-code)
> - [Anthropic 官方文檔](https://docs.anthropic.com/en/docs/claude-code/overview)
> - [官方斜線命令文檔](https://docs.anthropic.com/en/docs/claude-code/slash-commands)
> - [官方 Hooks 系統文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)
> - **文件整理時間：2025-07-15T14:16:31+08:00**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 目錄分類與重點資源](#2-目錄分類與重點資源)
- [3. Workflow & Knowledge Guides](#3-workflow--knowledge-guides)
- [4. Tooling & IDE 整合](#4-tooling--ide-整合)
- [5. Hooks 實例](#5-hooks-實例)
- [6. Slash-Commands 精選](#6-slash-commands-精選)
- [7. CLAUDE.md 實戰範例](#7-claudemd-實戰範例)
- [8. MCP/整合與自動化](#8-mcp整合與自動化)
- [9. 社群貢獻與參與](#9-社群貢獻與參與)
- [10. 官方文檔與延伸閱讀](#10-官方文檔與延伸閱讀)

---

## 1. 專案簡介

Awesome Claude Code 是一份由社群協作維護的精選清單，收錄 Claude Code 相關的指令、CLAUDE.md、workflow、hooks、MCP 整合、IDE 工具、最佳實踐與各類自動化資源，協助開發者提升生產力、優化 AI 代理開發流程。

---

## 2. 目錄分類與重點資源

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

| 命令分類 | 命令 | 功能說明 | 使用範例 |
|----------|------|----------|----------|
| **基礎控制** | `/help` | 顯示可用命令幫助 | `/help` |
| | `/clear` | 清除對話歷史 | `/clear` |
| | `/model` | 選擇或切換 AI 模型 | `/model claude-opus-4` |
| **專案管理** | `/review` | 請求程式碼審查 | `/review src/` |
| | `/init` | 初始化專案記憶體 | `/init` |
| | `/memory` | 管理專案記憶體 | `/memory view` |
| **配置管理** | `/config` | 查看/修改配置 | `/config list` |
| | `/permissions` | 管理工具權限 | `/permissions` |
| **診斷工具** | `/doctor` | 系統健康檢查 | `/doctor` |
| | `/status` | 查看系統狀態 | `/status` |
| **MCP 管理** | `/mcp` | 互動式 MCP 管理 | `/mcp` |

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

## Flags
- --flag1: 旗標說明

## Examples
/command --flag1 value
```

#### 進階範例：專案特定命令
```markdown
# security-audit

對專案進行全面安全審計，包括依賴檢查、程式碼掃描和配置驗證

## Flags
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
- 支援布林旗標：`--fix`、`--verbose`
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

> 本文件僅為社群整理，詳細內容與最新資源請參閱官方 GitHub 與文檔。
