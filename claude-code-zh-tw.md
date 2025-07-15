# Claude Code 詳細介紹與使用方法說明書

> **資料來源：** [Anthropic Claude Code 官方文件](https://docs.anthropic.com/zh-TW/docs/claude-code/overview)  
> **文件整理時間：** 2025-07-14T11:51:25+08:00

---

## 目錄

- [1. 產品概覽](#1-產品概覽)
- [2. 安裝與系統需求](#2-安裝與系統需求)
  - [2.1 設定與系統需求](#21-設定與系統需求)
- [3. 快速入門](#3-快速入門)
  - [3.1 快速入門](#31-快速入門)
- [4. CLI 指令與斜線命令](#4-cli-指令與斜線命令)
  - [4.1 CLI 指令與斜線命令](#41-cli-指令與斜線命令)
  - [4.2 MCP 伺服器管理指令（2025 最新）](#42-mcp-伺服器管理指令2025-最新)
- [5. 常見工作流程範例](#5-常見工作流程範例)
  - [5.1 常見工作流程範例](#51-常見工作流程範例)
- [6. MCP（模型上下文協議）整合](#6-mcp模型上下文協議整合)
  - [6.1 MCP（模型上下文協議）整合](#61-mcp模型上下文協議整合)
- [7. 設定與自訂（Hooks）](#7-設定與自訂hooks)
  - [7.1 設定與自訂（Hooks、配置）](#71-設定與自訂hooks配置)
- [8. 安全性設計與最佳實踐](#8-安全性設計與最佳實踐)
- [9. 疑難排解與常見問題](#9-疑難排解與常見問題)
- [10. 版本更新與資源連結](#10-版本更新與資源連結)
- [11. 最新 Claude Code API 實作與進階用法（2025 最新）](#11-最新-claude-code-api-實作與進階用法2025-最新)
- [12. 進階細節與 API 實例](#12-進階細節與-api-實例)

---

## 1. 產品概覽

Claude Code 是一款終端機 AI 代理程式設計工具，能理解您的程式碼庫，並以自然語言協助您更快開發。其特色包括：

- 直接整合開發環境，無需額外伺服器或複雜設定
- 支援檔案編輯、錯誤修復、測試執行、程式碼檢查、Git 操作、網路搜尋等
- 強調安全性與隱私，所有操作皆需明確授權
- 支援企業級整合（Amazon Bedrock、Google Vertex AI 等）

---

## 2. 安裝與系統需求

### 系統需求

- 作業系統：macOS 10.15+、Ubuntu 20.04+/Debian 10+，或 WSL（Windows Subsystem for Linux）
- 硬體：至少 4GB RAM
- 軟體：Node.js 18+、git 2.23+（選用）、GitHub/GitLab CLI（選用）
- 網路：需連網以驗證與 AI 處理

### 安裝步驟

```bash
npm install -g @anthropic-ai/claude-code
```

### 啟動與驗證

```bash
cd your-project-directory
claude
```

首次啟動會引導您完成驗證，可選擇 Anthropic Console、Claude App（Pro/Max）、或企業平台（Bedrock/Vertex AI）。

---

### 2.1 設定與系統需求

> 來源：[設定 Claude Code](https://docs.anthropic.com/zh-TW/docs/claude-code/setup)

- 支援作業系統：macOS 10.15+、Ubuntu 20.04+/Debian 10+、WSL（Windows）
- 最低硬體需求：4GB RAM
- 需安裝 Node.js 18+、git 2.23+（選用）、GitHub/GitLab CLI（選用）
- 需網路連線進行驗證與 AI 處理
- 安裝指令：
  ```bash
  npm install -g @anthropic-ai/claude-code
  ```
- 啟動：
  ```bash
  claude
  ```
- 支援 Bash、Zsh、Fish shell，Vim 模式、主題、通知等終端最佳化
- WSL/Windows 安裝疑難排解詳見官方指引

---

## 3. 快速入門

1. 在專案目錄啟動 Claude Code：
   ```bash
   cd /path/to/your/project
   claude
   ```
2. 提問專案相關問題：
   ```
   > what does this project do?
   > where is the main entry point?
   > explain the folder structure
   ```
3. 進行程式碼修改：
   ```
   > add a hello world function to the main file
   ```
   Claude 會尋找檔案、顯示建議、請求批准後才會編輯。
4. Git 操作：
   ```
   > what files have I changed?
   > commit my changes with a descriptive message
   > create a new branch called feature/quickstart
   > show me the last 5 commits
   > help me resolve merge conflicts
   ```
5. 錯誤修復與功能新增：
   ```
   > add input validation to the user registration form
   > there's a bug where users can submit empty forms - fix it
   ```
6. 其他常見工作流程：重構、測試、文檔、代碼審查等。

---

### 3.1 快速入門

> 來源：[快速入門](https://docs.anthropic.com/zh-TW/docs/claude-code/quickstart)

- 啟動專案：
  ```bash
  cd /path/to/your/project
  claude
  ```
- 互動式 REPL 提示：
  - 例：`> what does this project do?`
  - 例：`> add a hello world function to the main file`
- Git 整合：
  - 例：`> commit my changes with a descriptive message`
  - 例：`> help me resolve merge conflicts`
- 常見任務：
  - 需求拆解、重構、測試、文件產生、審查、PR 建立
- 基本命令速查：
  | 命令 | 功能 | 範例 |
  |---|---|---|
  | claude | 啟動互動模式 | claude |
  | claude "task" | 一次性任務 | claude "fix the build error" |
  | claude -p "query" | 查詢後退出 | claude -p "explain this function" |
  | /clear | 清除對話歷史 | > /clear |
  | /help | 顯示可用命令 | > /help |
  | exit/Ctrl+C | 離開 | > exit |

---

## 4. CLI 指令與斜線命令

### 常用 CLI 指令

| 指令              | 功能             | 範例                              |
| ----------------- | ---------------- | --------------------------------- |
| claude            | 啟動互動模式     | claude                            |
| claude "task"     | 一次性任務       | claude "fix the build error"      |
| claude -p "query" | 一次性查詢後退出 | claude -p "explain this function" |
| claude -c         | 繼續最近對話     | claude -c                         |
| claude -r         | 恢復舊對話       | claude -r                         |
| claude commit     | 建立 Git 提交    | claude commit                     |
| /clear            | 清除對話歷史     | > /clear                          |
| /help             | 顯示可用命令     | > /help                           |
| exit/Ctrl+C       | 離開             | > exit                            |

### 斜線命令（/command）

- 內建命令如 /add-dir、/bug、/clear、/config、/doctor、/init、/login、/logout、/mcp、/memory、/model、/permissions、/review、/status、/vim 等
- 支援自訂命令（.claude/commands/ 或 ~/.claude/commands/ 下建立 .md 檔案）
- 支援參數、Bash 命令、檔案參考、命名空間
- MCP 斜線命令自動發現與動態參數

---

### 4.1 CLI 指令與斜線命令

> 來源：[CLI 參考](https://docs.anthropic.com/zh-TW/docs/claude-code/cli-reference)、[斜線命令](https://docs.anthropic.com/zh-TW/docs/claude-code/slash-commands)

- 主要 CLI 指令：
  - `claude` 啟動 REPL
  - `claude "query"` 啟動並執行查詢
  - `claude -p "query"` 非互動模式查詢
  - `claude -c` 繼續最近對話
  - `claude update` 更新版本
  - `claude mcp` MCP 伺服器管理
- 重要標誌：
  - `--add-dir`、`--allowedTools`、`--output-format`、`--model`、`--resume` 等
- 內建斜線命令：
  - `/add-dir`、`/bug`、`/clear`、`/compact`、`/config`、`/cost`、`/doctor`、`/help`、`/init`、`/login`、`/logout`、`/mcp`、`/memory`、`/model`、`/permissions`、`/pr_comments`、`/review`、`/status`、`/terminal-setup`、`/vim`
- 支援自訂斜線命令（Markdown 檔案定義，支援參數、Bash、檔案參考等）

---

### 4.2 MCP 伺服器管理指令（2025 最新）

> 來源：[MCP 官方文件](https://docs.anthropic.com/zh-TW/docs/claude-code/mcp)

#### 主要指令與範例

| 指令                                         | 功能                           | 範例                                                                                                                                         |
| -------------------------------------------- | ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| claude mcp add <name> <command> [args...]    | 新增本地 stdio MCP 伺服器      | claude mcp add my-server -e API_KEY=123 -- /path/to/server arg1 arg2                                                                         |
| claude mcp add --transport sse <name> <url>  | 新增 SSE MCP 伺服器            | claude mcp add --transport sse sse-server https://example.com/sse-endpoint                                                                   |
| claude mcp add --transport http <name> <url> | 新增 HTTP MCP 伺服器           | claude mcp add --transport http http-server https://example.com/mcp                                                                          |
| claude mcp add-json <name> '<json>'          | 以 JSON 設定新增 MCP           | claude mcp add-json weather-api '{"type":"stdio","command":"/path/to/weather-cli","args":["--api-key","abc123"],"env":{"CACHE_DIR":"/tmp"}}' |
| claude mcp add-from-claude-desktop           | 匯入 Claude Desktop MCP        | claude mcp add-from-claude-desktop                                                                                                           |
| claude mcp list                              | 列出所有 MCP 伺服器            | claude mcp list                                                                                                                              |
| claude mcp get <name>                        | 查詢 MCP 詳細資訊              | claude mcp get my-server                                                                                                                     |
| claude mcp remove <name>                     | 移除 MCP 伺服器                | claude mcp remove my-server                                                                                                                  |
| claude mcp serve                             | 將 Claude Code 作為 MCP 伺服器 | claude mcp serve                                                                                                                             |
| claude mcp reset-project-choices             | 重設專案範圍 MCP 批准          | claude mcp reset-project-choices                                                                                                             |

#### 範圍與進階旗標

- `-s`/`--scope`：指定範圍（local/預設、project、user）
- `-e`/`--env`：設定環境變數（如 -e KEY=value）
- `MCP_TIMEOUT`：設定 MCP 啟動逾時（如 MCP_TIMEOUT=10000 claude ...）

#### 範圍說明

- **local**（預設）：僅當前專案可用
- **project**：專案共用（.mcp.json）
- **user**：全域用戶可用

#### 進階用法

- 新增本地範圍 MCP：
  ```bash
  claude mcp add my-private-server /path/to/server
  claude mcp add my-private-server -s local /path/to/server
  ```
- 新增專案範圍 MCP：
  ```bash
  claude mcp add shared-server -s project /path/to/server
  ```
- 新增使用者範圍 MCP：
  ```bash
  claude mcp add my-user-server -s user /path/to/server
  ```
- 以 JSON 設定新增 MCP：
  ```bash
  claude mcp add-json weather-api '{"type":"stdio","command":"/path/to/weather-cli","args":["--api-key","abc123"],"env":{"CACHE_DIR":"/tmp"}}'
  claude mcp get weather-api
  ```
- 匯入 Claude Desktop MCP：
  ```bash
  claude mcp add-from-claude-desktop
  claude mcp list
  ```
- 啟動 Claude Code 為 MCP 伺服器：
  ```bash
  claude mcp serve
  ```

#### 遠端驗證與 OAuth

- 新增需驗證的 SSE/HTTP MCP：
  ```bash
  claude mcp add --transport sse github-server https://api.github.com/mcp
  ```
- 互動驗證：
  ```
  /mcp
  ```
- 完成 OAuth 流程後即可連線

#### Postgres MCP 範例

```bash
claude mcp add postgres-server /path/to/postgres-mcp-server --connection-string "postgresql://user:pass@localhost:5432/mydb"
```

#### MCP 資源參考與斜線命令

- 於 prompt 輸入 `@` 可自動補全所有 MCP 資源
- 參考格式：`@server:protocol://resource/path`
  - 例：`@github:issue://123`、`@docs:file://api/authentication`
- 多資源參考：
  - 例：`Compare @postgres:schema://users with @docs:file://database/user-model`
- MCP 斜線命令自動發現：
  - `/mcp__github__list_prs`
  - `/mcp__jira__create_issue "Bug in login flow" high`

---

> **本區塊依據 2025-07-14 官方 MCP 文件整理，完整支援所有最新指令、範圍、資源與自動化。**

---

## 5. 常見工作流程範例

- **理解新程式碼庫**：
  - > give me an overview of this codebase
  - > explain the main architecture patterns used here
- **尋找相關程式碼**：
  - > find the files that handle user authentication
  - > how do these authentication files work together?
- **錯誤修復與重構**：
  - > I'm seeing an error when I run npm test
  - > suggest a few ways to fix the @ts-ignore in user.ts
  - > refactor utils.js to use ES2024 features while maintaining the same behavior
- **測試與覆蓋**：
  - > find functions in NotificationsService.swift that are not covered by tests
  - > add tests for the notification service
- **建立 PR**：
  - > summarize the changes I've made to the authentication module
  - > create a pr
- **文件與圖像分析**：
  - > find functions without proper JSDoc comments in the auth module
  - > add JSDoc comments to the undocumented functions in auth.js
  - > What does this image show?
- **進階推理與架構規劃**：
  - > I need to implement a new authentication system using OAuth2 for our API. Think deeply about the best approach for implementing this in our codebase.

---

### 5.1 常見工作流程範例

> 來源：[常見工作流程](https://docs.anthropic.com/zh-TW/docs/claude-code/common-workflows)

- 快速理解新程式碼庫、架構、資料模型
- 搜尋與分析特定功能、流程、錯誤
- 高效修復錯誤、重構、測試、文件產生
- 建立與優化 PR、文件、測試覆蓋
- 圖片分析、結構化輸出、延伸思考（Interleaved Thinking）
- 多 worktree 並行、Unix 工具整合、管道輸入/輸出、格式控制
- 自訂與團隊共用斜線命令

---

## 6. MCP（模型上下文協議）整合

MCP 是一個開放協議，讓 Claude Code 能存取外部工具與資料來源。

- 支援本地、SSE、HTTP 等多種伺服器型態
- 可設定不同範圍（本地、專案、使用者）
- 支援 OAuth 2.0 驗證、Postgres MCP、JSON 設定、從 Desktop 匯入
- 可將 Claude Code 本身作為 MCP 伺服器
- MCP 資源可用 @server:protocol://resource/path 參考
- MCP 提示可變成斜線命令

---

### 6.1 MCP（模型上下文協議）整合

> 來源：[MCP](https://docs.anthropic.com/zh-TW/docs/claude-code/mcp)

- 支援 MCP Stdio/SSE/HTTP 伺服器，跨專案、團隊、用戶範圍
- 連接第三方工具、資料庫（如 Postgres）、API
- MCP 伺服器管理指令：`claude mcp add/list/get/remove`
- 支援 OAuth 2.0 驗證、JSON 設定、從 Desktop 匯入
- MCP 提示可轉為斜線命令，支援參數與多資源參考

---

## 7. 設定與自訂（Hooks）

- 支援 PreToolUse、PostToolUse、Notification、Stop、SubagentStop 等事件
- 可針對特定工具、MCP 工具、檔案模式等設置 shell 命令
- 支援 JSON 輸出進階控制
- 設定檔案位置：~/.claude/settings.json、.claude/settings.json、.claude/settings.local.json
- 常見應用：自動格式化、通知、記錄、權限自訂等
- 安全注意：Hooks 會以完整使用者權限執行，請謹慎設計

---

### 7.1 設定與自訂（Hooks、配置）

> 來源：[Hooks](https://docs.anthropic.com/zh-TW/docs/claude-code/hooks)、[配置](https://docs.anthropic.com/zh-TW/docs/claude-code/configuration)

- 支援 PreToolUse、PostToolUse、Notification、Stop、SubagentStop 等事件
- 可自訂 shell 指令於生命週期各階段自動執行
- 典型應用：自動格式化、通知、權限控管、審查、記錄
- 設定檔位置：`~/.claude/settings.json`、`.claude/settings.json`、`.claude/settings.local.json`
- JSON 結構範例與安全建議詳見官方

---

## 8. 安全性設計與最佳實踐

- 嚴格的權限架構，所有敏感操作需明確批准
- 只能存取啟動目錄及子目錄，無法向上存取
- 內建多層防護（命令封鎖、網路請求批准、上下文隔離、信任驗證等）
- 使用者需檢查所有建議更改與命令
- 建議敏感專案使用專案特定權限、開發容器、定期審核權限
- 支援企業管理政策與 OpenTelemetry 監控
- 發現安全問題請透過官方管道回報

---

## 9. 疑難排解與常見問題

- Linux 權限問題：建議將 npm 前綴設為家目錄，避免 sudo
- WSL 安裝問題：需使用 Linux npm/node，勿用 Windows 版本
- 自動更新失敗：檢查 npm 權限與 DISABLE_AUTOUPDATER 變數
- 驗證問題：/logout 後重新登入，或刪除 ~/.config/claude-code/auth.json
- 高資源消耗：定期 /compact，關閉重啟，忽略大型目錄
- JetBrains 終端機 ESC 鍵衝突：調整 IDE 快捷鍵
- 其他問題：/bug 回報、/doctor 健康檢查、查閱官方支援

---

## 10. 版本更新與資源連結

- [官方概覽](https://docs.anthropic.com/zh-TW/docs/claude-code/overview)
- [快速入門](https://docs.anthropic.com/zh-TW/docs/claude-code/quickstart)
- [設定說明](https://docs.anthropic.com/zh-TW/docs/claude-code/setup)
- [CLI 參考](https://docs.anthropic.com/zh-TW/docs/claude-code/cli-reference)
- [常見工作流程](https://docs.anthropic.com/zh-TW/docs/claude-code/common-workflows)
- [MCP 協議](https://docs.anthropic.com/zh-TW/docs/claude-code/mcp)
- [Hooks 設定](https://docs.anthropic.com/zh-TW/docs/claude-code/hooks)
- [斜線命令](https://docs.anthropic.com/zh-TW/docs/claude-code/slash-commands)
- [安全性](https://docs.anthropic.com/zh-TW/docs/claude-code/security)
- [疑難排解](https://docs.anthropic.com/zh-TW/docs/claude-code/troubleshooting)
- [Release Notes](https://docs.anthropic.com/zh-TW/docs/claude-code/release-notes)

---

## 11. 最新 Claude Code API 實作與進階用法（2025 最新）

> **資料來源：** [Anthropic Claude Code 官方文件](https://docs.anthropic.com/en/docs/claude-code/overview)  
> **Context7 技術文檔**：[context7/docs_anthropic_com-en-docs-claude-code-overview]

### 11.1 Python SDK 基本訊息傳送

```python
import anthropic

client = anthropic.Anthropic(api_key="my_api_key")
message = client.messages.create(
    model="claude-opus-4-20250514",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello, Claude"}]
)
print(message.content)
```

### 11.2 Messages API 工具整合（Tool Use）

```shell
curl https://api.anthropic.com/v1/messages \
  -H "content-type: application/json" \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-opus-4-20250514",
    "max_tokens": 1024,
    "tools": [
      {
        "name": "get_weather",
        "description": "Get the current weather in a given location",
        "input_schema": {
          "type": "object",
          "properties": {
            "location": {"type": "string", "description": "The city and state, e.g. San Francisco, CA"}
          },
          "required": ["location"]
        }
      }
    ],
    "messages": [
      {"role": "user", "content": "What is the weather like in San Francisco?"}
    ]
  }'
```

### 11.3 Interleaved Thinking（交錯思考）進階推理

```python
import anthropic

client = anthropic.Anthropic()

calculator_tool = {
    "name": "calculator",
    "description": "Perform mathematical calculations",
    "input_schema": {
        "type": "object",
        "properties": {
            "expression": {"type": "string", "description": "Mathematical expression to evaluate"}
        },
        "required": ["expression"]
    }
}

database_tool = {
    "name": "database_query",
    "description": "Query product database",
    "input_schema": {
        "type": "object",
        "properties": {
            "query": {"type": "string", "description": "SQL query to execute"}
        },
        "required": ["query"]
    }
}

response = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=16000,
    thinking={"type": "enabled", "budget_tokens": 10000},
    tools=[calculator_tool, database_tool],
    extra_headers={"anthropic-beta": "interleaved-thinking-2025-05-14"},
    messages=[{"role": "user", "content": "What's the total revenue if we sold 150 units of product A at $50 each, and how does this compare to our average monthly revenue from the database?"}]
)
# 處理 response.content 以獲得 thinking/tool_use/text 區塊
```

### 11.4 多輪對話與 JSON 輸出格式

```json
[
  { "role": "user", "content": "Hello there." },
  { "role": "assistant", "content": "Hi, I'm Claude. How can I help you?" },
  { "role": "user", "content": "Can you explain LLMs in plain English?" }
]
```

### 11.5 模型選擇與功能比較（2025 最新）

| 模型       | API 名稱                   | 最大輸出 | 支援多語 | 支援 Vision | Extended Thinking | 訓練截止 |
| ---------- | -------------------------- | -------- | -------- | ----------- | ----------------- | -------- |
| Opus 4     | claude-opus-4-20250514     | 32,000   | 是       | 是          | 是                | 2025/3   |
| Sonnet 4   | claude-sonnet-4-20250514   | 64,000   | 是       | 是          | 是                | 2025/3   |
| Sonnet 3.7 | claude-3-7-sonnet-20250219 | 64,000   | 是       | 是          | 是                | 2024/11  |
| Haiku 3.5  | claude-3-5-haiku-20241022  | 8,192    | 是       | 是          | 否                | 2024/7   |

> 詳細比較與完整 API 參數請參考 [官方模型比較表](https://docs.anthropic.com/en/docs/claude-code/overview/en/docs/legacy-model-guide)

### 11.6 內容審查與結構化輸出

```python
unsafe_category_definitions = {
    'Child Exploitation': 'Content that depicts child nudity or that enables, encourages, excuses, or depicts the sexual abuse of children.',
    ...
}

def moderate_message_with_definitions(message, unsafe_category_definitions):
    # ...（詳見 context7 文件）
    response = client.messages.create(
        model="claude-3-haiku-20240307",
        max_tokens=200,
        temperature=0,
        messages=[{"role": "user", "content": assessment_prompt}]
    )
    assessment = json.loads(response.content[0].text)
    return assessment['violation'], assessment.get('categories', []), assessment.get('explanation')
```

---

> **Context7 來源：** `/context7/docs_anthropic_com-en-docs-claude-code-overview`  
> **官方 API 文件與更多範例**：[https://docs.anthropic.com/en/docs/claude-code/overview](https://docs.anthropic.com/en/docs/claude-code/overview)

---

## 12. 進階細節與 API 實例

> 來源：[官方 API 文件](https://docs.anthropic.com/zh-TW/docs/claude-code/overview)、[SDK/工具整合](https://docs.anthropic.com/zh-TW/docs/claude-code/reference)

### 12.1 Python SDK 基本用法

```python
import anthropic

client = anthropic.Anthropic(api_key="your_api_key")
message = client.messages.create(
    model="claude-opus-4-20250514",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello, Claude"}]
)
print(message.content)
```

- 用途：自動化對話、程式化批次任務、結合自訂工具鏈。
- 參數：`model` 可選最新模型，`max_tokens` 控制回應長度。

### 12.2 Messages API 工具整合（Tool Use）

```shell
curl https://api.anthropic.com/v1/messages \
  -H "content-type: application/json" \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-opus-4-20250514",
    "max_tokens": 1024,
    "messages": [
      {"role": "user", "content": "請幫我摘要這段程式碼..."}
    ],
    "tools": [
      {"name": "web_search", "description": "搜尋網路最新技術文件"}
    ]
  }'
```

- 支援功能：自動摘要、程式碼審查、網路搜尋、結構化輸出等。

### 12.3 交錯思考（Interleaved Thinking）

```shell
> Think step by step about how to refactor the authentication module for async/await.
```

- 效果：Claude 會自動分段思考、產生多層次建議，適合架構設計、除錯、規劃。

### 12.4 JSON 輸出與結構化回應

```shell
> summarize this code and output as JSON with fields: filename, summary, issues
```

- 搭配：`--output-format json` 標誌，或於 prompt 明確要求。

### 12.5 多模型選擇與比較

| 模型       | API 名稱                   | 最大輸出 | 支援多語 | 支援 Vision | Extended Thinking | 訓練截止 |
| ---------- | -------------------------- | -------- | -------- | ----------- | ----------------- | -------- |
| Opus 4     | claude-opus-4-20250514     | 32,000   | 是       | 是          | 是                | 2025/3   |
| Sonnet 4   | claude-sonnet-4-20250514   | 64,000   | 是       | 是          | 是                | 2025/3   |
| Sonnet 3.7 | claude-3-7-sonnet-20250219 | 64,000   | 是       | 是          | 是                | 2024/11  |
| Haiku 3.5  | claude-3-5-haiku-20241022  | 8,192    | 是       | 是          | 否                | 2024/7   |

- 切換方式：CLI `--model` 標誌或 API 參數
- 應用建議：大型重構/分析用 Opus，日常開發用 Sonnet，快速回饋用 Haiku

### 12.6 進階自動化與腳本範例

**自動化批次審查所有 PR：**

```shell
for pr in $(gh pr list --json number -q '.[].number'); do
  claude -p "review pull request #$pr for security and code quality"
done
```

**結合 Unix 工具進行批次分析：**

```shell
cat error.log | claude -p "請分析這份錯誤日誌並給出修正建議" --output-format json
```

### 12.7 MCP 工具與資料庫查詢

**連接 Postgres MCP 伺服器：**

```shell
claude mcp add postgres-server /path/to/postgres-mcp-server --connection-string "postgresql://user:pass@localhost:5432/mydb"
```

**查詢資料庫：**

```shell
> describe the schema of our users table
```

### 12.8 斜線命令自動化範例

**建立專案自訂指令：**

```shell
mkdir -p .claude/commands
echo "請審查 @src/utils/helpers.js 的安全性" > .claude/commands/security-review.md
```

**使用：**

```
/project:security-review
```

### 12.9 內容審查與安全性

- Claude 會自動檢查命令、程式碼、網路請求的安全性
- 敏感操作需明確授權，支援權限白名單與審計
- 建議於生產環境啟用 OpenTelemetry 監控

### 12.10 參考資源

- [Claude Code 官方 API 文件](https://docs.anthropic.com/zh-TW/docs/claude-code/overview)
- [SDK/CLI 參考](https://docs.anthropic.com/zh-TW/docs/claude-code/cli-reference)
- [MCP 整合](https://docs.anthropic.com/zh-TW/docs/claude-code/mcp)
- [安全性最佳實踐](https://docs.anthropic.com/zh-TW/docs/claude-code/security)

---

## 目錄（重新整理）

1. 產品概覽
2. 安裝與系統需求
3. 快速入門
4. CLI 指令與斜線命令
5. 常見工作流程範例
6. MCP（模型上下文協議）整合
7. 設定與自訂（Hooks）
8. 安全性設計與最佳實踐
9. 疑難排解與常見問題
10. 版本更新與資源連結
11. 最新 Claude Code API 實作與進階用法（2025 最新）
12. 進階細節與 API 實例

---

> **本說明書所有內容均依據 Anthropic Claude Code 官方文件（2025-07-14）彙整，並標註各章節來源網址。**
