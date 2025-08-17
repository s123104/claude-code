# Claude Code MCP 伺服器設置指南 📚

## 概述

此專案提供了完整的功能說明。


> **基於官方文檔的完整 MCP 配置指南**  
> 最後更新時間：2025-07-20T10:45:00+08:00  
> 文件語言：繁體中文  
> 版本：v1.0.0

---

## 🚀 快速導航

- [自動導入 Claude Desktop MCP](#自動導入-claude-desktop-mcp)
- [手動配置 MCP 伺服器](#手動配置-mcp-伺服器)
- [常用 MCP 伺服器列表](#常用-mcp-伺服器列表)
- [故障排除](#故障排除)
- [最佳實踐](#最佳實踐)

---

## 🎯 概述

Model Context Protocol (MCP) 是 Claude Code 的核心功能，允許您連接各種外部服務和工具，大幅擴展 Claude Code 的能力。

### 支援的傳輸類型

| 類型      | 描述               | 適用場景             |
| --------- | ------------------ | -------------------- |
| **stdio** | 標準輸入輸出       | 本地工具、CLI 應用   |
| **HTTP**  | HTTP 協議          | REST API、Web 服務   |
| **SSE**   | Server-Sent Events | 即時數據流、事件推送 |

### 作用域類型

| 作用域      | 描述       | 配置方式     |
| ----------- | ---------- | ------------ |
| **local**   | 僅當前專案 | 預設值       |
| **user**    | 所有專案   | `-s user`    |
| **project** | 團隊共享   | `-s project` |

---

## 🔄 自動導入 Claude Desktop MCP

### 方法一：使用官方導入功能

```bash
# 啟動互動式導入流程
claude mcp add-from-claude-desktop
```

### 方法二：使用自動化腳本

```bash
# 執行自動導入腳本
./scripts/import-mcp-servers.sh
```

**腳本功能**：

- ✅ 自動檢測 Claude Desktop 配置
- ✅ 解析 MCP 伺服器設定
- ✅ 批量導入到 Claude Code
- ✅ 備份現有配置
- ✅ 錯誤處理和日誌記錄

---

## 🔧 手動配置 MCP 伺服器

### 基本語法

```bash
# 添加 stdio 伺服器
claude mcp add <name> <command> [args...]

# 添加 HTTP 伺服器
claude mcp add --transport http <name> <url>

# 添加 SSE 伺服器
claude mcp add --transport sse <name> <url>

# 使用 JSON 配置
claude mcp add-json <name> '<json-config>'
```

### 常用 MCP 伺服器配置

#### 1. Context7 技術文檔伺服器

```bash
claude mcp add-json context7 '{
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp@latest"],
  "env": {}
}'
```

#### 2. 時間伺服器

```bash
claude mcp add-json time '{
  "type": "stdio",
  "command": "uvx",
  "args": ["mcp-server-time", "--local-timezone=Asia/Taipei"],
  "env": {}
}'
```

#### 3. 網頁抓取伺服器

```bash
claude mcp add-json fetch '{
  "type": "stdio",
  "command": "uvx",
  "args": ["mcp-server-fetch"],
  "env": {}
}'
```

#### 4. Puppeteer 瀏覽器自動化

```bash
claude mcp add-json puppeteer '{
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-puppeteer", "--no-sandbox"],
  "env": {}
}'
```

#### 5. 順序思考伺服器

```bash
claude mcp add-json sequential-thinking '{
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
  "env": {}
}'
```

---

## 📋 常用 MCP 伺服器列表

### 開發工具

| 伺服器                  | 功能         | 安裝指令                                                  |
| ----------------------- | ------------ | --------------------------------------------------------- |
| **context7**            | 技術文檔查詢 | `npx -y @upstash/context7-mcp@latest`                     |
| **puppeteer**           | 瀏覽器自動化 | `npx -y @modelcontextprotocol/server-puppeteer`           |
| **sequential-thinking** | 順序思考     | `npx -y @modelcontextprotocol/server-sequential-thinking` |

### 實用工具

| 伺服器         | 功能       | 安裝指令               |
| -------------- | ---------- | ---------------------- |
| **time**       | 時間查詢   | `uvx mcp-server-time`  |
| **fetch**      | 網頁抓取   | `uvx mcp-server-fetch` |
| **memory**     | 記憶體管理 | Docker 容器            |
| **everything** | 萬能工具   | Docker 容器            |

### 資料庫

| 伺服器       | 功能       | 安裝指令 |
| ------------ | ---------- | -------- |
| **postgres** | PostgreSQL | 需要編譯 |
| **mysql**    | MySQL      | 需要編譯 |
| **mongodb**  | MongoDB    | 需要編譯 |

---

## 🎯 使用 MCP 伺服器

### 在 Claude Code 中使用

```bash
# 啟動 Claude Code
claude

# 使用斜線命令執行 MCP 功能
/mcp__time__get_current_time
/mcp__fetch__fetch "https://api.example.com"
/mcp__context7__resolve-library-id "react"
```

### 外部資源引用

```bash
# 引用 GitHub Issue
Can you analyze @github:issue://123 and suggest a fix?

# 引用文檔
Please review the API documentation at @docs:file://api/authentication

# 引用資料庫
Compare @postgres:schema://users with @docs:file://database/user-model
```

---

## 🔍 管理 MCP 伺服器

### 查看伺服器列表

```bash
claude mcp list
```

### 查看伺服器詳情

```bash
claude mcp get <server-name>
```

### 移除伺服器

```bash
claude mcp remove <server-name>
```

### 重啟伺服器

```bash
claude mcp restart <server-name>
```

---

## 🛠️ 故障排除

### 常見問題

#### 1. 伺服器連接失敗

**症狀**：`claude mcp list` 顯示伺服器但無法使用

**解決方案**：

```bash
# 檢查命令是否可用
which <command>

# 重新安裝依賴
npm install -g <package-name>

# 檢查權限
chmod +x <executable-path>
```

#### 2. JSON 配置錯誤

**症狀**：`claude mcp add-json` 失敗

**解決方案**：

```bash
# 驗證 JSON 格式
echo '{"type":"stdio","command":"test","args":[],"env":{}}' | jq .

# 使用簡單配置
claude mcp add test-server test-command
```

#### 3. 權限問題

**症狀**：無法執行某些命令

**解決方案**：

```bash
# 檢查 Claude Code 權限設定
claude config list

# 允許特定工具
claude config set allowedTools '["Edit","View","Bash","mcp__*"]'
```

### 診斷工具

```bash
# 檢查 Claude Code 健康狀態
claude doctor

# 詳細輸出模式
claude --verbose

# 檢查環境變數
env | grep CLAUDE
```

---

## 🏆 最佳實踐

### 1. 伺服器命名規範

```bash
# 使用描述性名稱
claude mcp add postgres-db /path/to/postgres-mcp
claude mcp add github-api /path/to/github-mcp
claude mcp add weather-service /path/to/weather-mcp
```

### 2. 環境變數管理

```bash
# 使用環境變數而非硬編碼
claude mcp add-json secure-server '{
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "my-mcp-server"],
  "env": {
    "API_KEY": "$API_KEY",
    "DATABASE_URL": "$DATABASE_URL"
  }
}'
```

### 3. 專案級別配置

```bash
# 為團隊專案配置共享伺服器
claude mcp add shared-db -s project /path/to/db-server

# 這會創建 .mcp.json 檔案
```

### 4. 安全性考量

```bash
# 限制危險命令
claude config set disallowedTools '["Bash(rm:*)", "Bash(sudo:*)"]'

# 使用計劃模式
claude --permission-mode plan
```

---

## 📚 延伸資源

### 官方文檔

- [Claude Code MCP 文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)
- [MCP 協議規範](https://modelcontextprotocol.io/)
- [Claude Code CLI 參考](https://docs.anthropic.com/en/docs/claude-code/cli-reference)

### 社群資源

- [MCP 伺服器目錄](https://github.com/modelcontextprotocol/server-registry)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)
- [MCP 討論區](https://github.com/modelcontextprotocol/mcp/discussions)

### 相關工具

- [jq](https://stedolan.github.io/jq/) - JSON 處理工具
- [uvx](https://github.com/astral-sh/uv) - Python 套件執行器
- [npx](https://www.npmjs.com/package/npx) - Node.js 套件執行器

---

## 🔄 更新記錄

### v1.0.0 (2025-07-20)

- ✅ 新增自動導入腳本
- ✅ 完整的手動配置指南
- ✅ 常用 MCP 伺服器列表
- ✅ 故障排除章節
- ✅ 最佳實踐建議

---

**📖 Claude Code MCP 設置指南 - 您的 MCP 配置權威參考**

_基於官方文檔 | 100% 實用範例 | 持續更新維護_
