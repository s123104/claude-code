---
source: "https://docs.anthropic.com/en/docs/claude-code/mcp"
fetched_at: "2025-08-20T01:40:00+08:00"
updated_features: "2025-08-20 - 新增 SSE/HTTP 傳輸、OAuth 認證、企業級 MCP 伺服器整合"
---

[原始文件連結](https://docs.anthropic.com/en/docs/claude-code/mcp)

# Model Context Protocol (MCP) 完整指南

模型上下文協議 (MCP) 是 Claude Code 的強大擴展系統，讓 AI 能夠連接外部工具、服務和資料源。本指南涵蓋 MCP 伺服器設定、範圍管理、OAuth 認證、企業級整合，以及如何將 Claude Code 作為 MCP 伺服器使用。

## 什麼是 MCP？

MCP 允許 Claude Code 存取：
- **問題追蹤系統**：從 JIRA 問題實現功能並在 GitHub 上創建 PR
- **監控資料**：檢查 Sentry 和 Statsig 的功能使用情況
- **資料庫查詢**：基於 Postgres 資料庫尋找使用者
- **設計整合**：根據 Slack 中發佈的新 Figma 設計更新範本
- **工作流程自動化**：建立 Gmail 草稿邀請使用者參與意見回饋會議

## MCP 伺服器類型

### 1. Stdio 伺服器（本地指令）
本地執行的指令行工具：

```bash
# 基本語法
claude mcp add <name> <command> [args...]

# 範例：新增本地伺服器
claude mcp add my-server -e API_KEY=123 -- /path/to/server arg1 arg2
```

### 2. SSE 伺服器（即時串流）
使用 Server-Sent Events 的遠程伺服器：

```bash
# 基本語法
claude mcp add --transport sse <name> <url>

# 範例：Linear 整合
claude mcp add --transport sse linear https://mcp.linear.app/sse

# 含認證標頭
claude mcp add --transport sse private-api https://api.company.com/mcp \
  --header "X-API-Key: your-key-here"
```

### 3. HTTP 伺服器（RESTful API）
使用 HTTP 的伺服器：

```bash
# 基本語法
claude mcp add --transport http <name> <url>

# 範例：HTTP 伺服器
claude mcp add --transport http http-server https://example.com/mcp

# 含認證
claude mcp add --transport http secure-server https://api.example.com/mcp \
  -e Authorization="Bearer your-token"
```

## 企業級 MCP 伺服器整合

### 主流服務整合

#### 專案管理與協作
```bash
# Linear - 問題追蹤
claude mcp add --transport sse linear https://mcp.linear.app/sse

# Asana - 專案管理
claude mcp add --transport sse asana https://mcp.asana.com/sse

# Atlassian - Jira & Confluence
claude mcp add --transport sse atlassian https://mcp.atlassian.com/v1/sse

# ClickUp - 任務管理
claude mcp add --env CLICKUP_API_KEY=YOUR_KEY --env CLICKUP_TEAM_ID=YOUR_ID -- npx -y @hauptsache.net/clickup-mcp
```

#### 監控與分析
```bash
# Sentry - 錯誤監控與除錯
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

# 使用 /mcp 進行認證
> /mcp

# 除錯生產問題範例
> "What are the most common errors in the last 24 hours?"
> "Show me the stack trace for error ID abc123"
> "Which deployment introduced these new errors?"
```

#### 支付與商務
```bash
# Stripe - 支付處理
claude mcp add --transport http stripe https://mcp.stripe.com

# PayPal - 交易管理
claude mcp add --transport http paypal https://mcp.paypal.com/mcp

# Square - 支付與庫存管理
claude mcp add --transport sse square https://mcp.squareup.com/sse
```

#### 設計與內容
```bash
# Figma - 設計整合（需要 Desktop 版本在本地運行）
claude mcp add --transport sse figma http://127.0.0.1:3845/sse

# Notion - 文檔與頁面管理
claude mcp add --transport http notion https://mcp.notion.com/mcp

# Invideo - 影片創作
claude mcp add --transport sse invideo https://mcp.invideo.io/sse
```

#### 客戶服務與通訊
```bash
# Intercom - 即時客戶對話與票券
claude mcp add --transport http intercom https://mcp.intercom.com/mcp
```

#### 安全與依賴管理
```bash
# Socket - 依賴安全分析
claude mcp add --transport http socket https://mcp.socket.dev/
```

#### 自動化與整合平台
```bash
# Zapier - 連接數千個應用程式
# 在 mcp.zapier.com 生成用戶特定 URL

# Workato - 企業級自動化
# 程式化生成 MCP 伺服器，提供廣泛應用程式與工作流程存取

# Airtable - 雲端資料庫
claude mcp add airtable --env AIRTABLE_API_KEY=YOUR_KEY -- npx -y airtable-mcp-server
```

### 雲端平台整合
```bash
# Cloudflare - DevOps 服務
# 功能：建置應用程式、流量分析、效能監控、安全設定管理
# 特定伺服器 URL 因服務而異，請參閱 Cloudflare 文檔
```

## 資料庫整合

### PostgreSQL 設定
```bash
claude mcp add postgres-server /path/to/postgres-mcp-server \
  --connection-string "postgresql://user:pass@localhost:5432/mydb"
```

### 自然語言資料庫查詢
```bash
> describe the schema of our users table
> what are the most recent orders in the system?
> show me the relationship between customers and invoices
> find emails of 10 random users who used feature ENG-4521
```

## MCP 伺服器範圍管理

### 三層範圍系統（優先順序：高→低）

#### 1. 本地範圍（Local）- 預設
專案私有，不共享：
```bash
# 預設為本地範圍
claude mcp add my-private-server /path/to/server

# 明確指定本地範圍
claude mcp add my-private-server --scope local /path/to/server
```

#### 2. 專案範圍（Project）
團隊共享，儲存於 `.mcp.json`：
```bash
claude mcp add shared-server --scope project /path/to/server
```

#### 3. 使用者範圍（User）
跨專案全域可用：
```bash
claude mcp add my-user-server --scope user /path/to/server
```

### 專案級配置檔案
`.mcp.json` 範例：
```json
{
  "mcpServers": {
    "shared-server": {
      "command": "/path/to/server",
      "args": [],
      "env": {}
    },
    "team-database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {"DB_CONNECTION_STRING": "postgresql://..."}
    }
  }
}
```

### 範圍重置與管理
```bash
# 重置專案選擇，重新提示批准
claude mcp reset-project-choices
```

## OAuth 認證與安全管理

### 互動式認證管理
```bash
# 開啟 MCP 管理介面
> /mcp
```

**管理介面功能**：
- 🔍 查看所有配置的伺服器
- 🔌 檢查連接狀態
- 🔐 OAuth 伺服器認證
- 🧹 清除認證令牌
- 🛠️ 查看可用工具和提示

### 認證令牌管理
```bash
# 清除所有認證令牌
claude mcp clear-auth

# 清除特定範圍的認證
claude mcp clear-auth --scope user
claude mcp clear-auth --scope project
```

### 安全最佳實踐
- ✅ **信任來源**：僅使用來自信任提供者的 MCP 伺服器
- 🔄 **定期審查**：定期檢查和更新伺服器權限
- 🔒 **環境變數**：使用環境變數管理敏感資訊
- 🧹 **定期清理**：定期清理未使用的認證令牌
- 📋 **權限控制**：為每個伺服器配置適當的工具權限

## 從 Claude Desktop 匯入

### 自動匯入現有配置
```bash
# 互動式匯入流程
claude mcp add-from-claude-desktop

# 驗證匯入結果
claude mcp list
```

**支援平台**：
- ✅ macOS
- ✅ Windows Subsystem for Linux (WSL)

**匯入內容**：
- 所有已配置的 MCP 伺服器
- 環境變數與認證設定
- 伺服器範圍偏好

## JSON 配置進階設定

### 複雜伺服器配置
```bash
# 基本語法
claude mcp add-json <name> '<json>'

# 範例：天氣 API 伺服器
claude mcp add-json weather-api '{
  "type":"stdio",
  "command":"/path/to/weather-cli",
  "args":["--api-key","abc123"],
  "env":{"CACHE_DIR":"/tmp"}
}'

# 驗證配置
claude mcp get weather-api
```

### SDK 配置檔案範例
```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {"SLACK_TOKEN": "your-slack-token"}
    },
    "jira": {
      "command": "npx", 
      "args": ["-y", "@modelcontextprotocol/server-jira"],
      "env": {"JIRA_TOKEN": "your-jira-token"}
    },
    "database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {"DB_CONNECTION_STRING": "your-db-url"}
    }
  }
}
```

## MCP 斜線指令系統

### 動態提示發現與執行
MCP 伺服器暴露的自訂提示會自動轉換為斜線指令：

**格式**：`/mcp__<伺服器名稱>__<提示名稱>`

```bash
# 無參數提示
> /mcp__github__list_prs

# 含參數提示（空格分隔）
> /mcp__github__pr_review 456
> /mcp__jira__create_issue "Bug in login flow" high
```

### 命名規範化
- 伺服器和提示名稱自動正規化
- 空格和特殊字符轉換為底線
- 所有名稱轉換為小寫保持一致性

### 斜線指令特性
- 🔄 **動態發現**：從連接的 MCP 伺服器自動發現
- 📝 **參數處理**：支援多種參數類型
- 🎯 **結果注入**：結果直接注入對話中

## 資源引用系統

### @ 符號引用語法
在 Claude Code 提示中引用外部資源：

```bash
# GitHub 問題分析
> Can you analyze @github:issue://123 and suggest a fix?

# API 文檔引用
> Please review the API documentation at @docs:file://api/authentication

# 資料庫架構比較
> Compare @postgres:schema://users with @docs:file://database/user-model

# 設計資源整合
> Update our standard email template based on @figma:design://template-id
```

**支援的資源類型**：
- `@github:issue://` - GitHub 問題
- `@docs:file://` - 文檔檔案
- `@postgres:schema://` - 資料庫架構
- `@figma:design://` - Figma 設計
- 以及更多 MCP 伺服器特定的資源類型

## 將 Claude Code 作為 MCP 伺服器

### 啟動 Claude Code MCP 服務
```bash
# 啟動 stdio MCP 伺服器
claude mcp serve
```

### 外部客戶端連接
其他 MCP 客戶端（如 Claude Desktop）可以連接到 Claude Code：

```json
{
  "mcpServers": {
    "claude-code": {
      "command": "claude",
      "args": ["mcp", "serve"],
      "env": {}
    }
  }
}
```

**提供功能**：
- Claude Code 的整合工具
- 檔案操作功能
- 程式碼執行能力
- Git 工作流程
- 專案管理功能

## MCP 伺服器管理指令

### 核心管理指令
```bash
# 列出所有配置的伺服器
claude mcp list

# 獲取特定伺服器詳情
claude mcp get <server-name>

# 移除伺服器
claude mcp remove <server-name>

# 檢查伺服器狀態（在 Claude Code 內）
> /mcp
```

### 環境配置
```bash
# 設定伺服器啟動逾時
export MCP_TIMEOUT=30

# Windows 特殊配置（使用 cmd /c 包裝 npx 指令）
claude mcp add my-server -- cmd /c npx -y @some/package
```

## 實戰使用案例

### 案例 1：全端開發工作流程
```bash
# 1. 設定開發環境
claude mcp add --transport sse github https://api.github.com/mcp
claude mcp add --transport sse linear https://mcp.linear.app/sse
claude mcp add postgres-db /path/to/postgres-server --connection-string "postgresql://..."

# 2. 實現功能
> "Add the feature described in JIRA issue ENG-4521 and create a PR on GitHub"

# 3. 分析使用情況
> "Check Sentry and Statsig to check the usage of the feature described in ENG-4521"

# 4. 使用者研究
> "Find emails of 10 random users who used feature ENG-4521, based on our Postgres database"
```

### 案例 2：設計到實現工作流程
```bash
# 1. 設定設計工具
claude mcp add --transport sse figma http://127.0.0.1:3845/sse
claude mcp add slack-server /path/to/slack-server

# 2. 根據設計更新程式碼
> "Update our standard email template based on the new Figma designs that were posted in Slack"
```

### 案例 3：客戶回饋自動化
```bash
# 1. 設定客戶工具
claude mcp add airtable --env AIRTABLE_API_KEY=YOUR_KEY -- npx -y airtable-mcp-server

# 2. 自動化邀請流程
> "Create Gmail drafts inviting these 10 users to a feedback session about the new feature"
```

## 開發與自訂 MCP 伺服器

### MCP SDK 資源
- **官方 SDK**：https://modelcontextprotocol.io/quickstart/server
- **社群伺服器**：https://github.com/modelcontextprotocol/servers

### 建置自訂伺服器
1. 使用 MCP SDK 開發自訂功能
2. 發布為 npm 包或獨立執行檔
3. 透過 `claude mcp add` 整合到工作流程

### 社群生態系統
- 數百個社群開發的 MCP 伺服器
- 涵蓋各種 API 和服務整合
- 持續擴大的生態系統
