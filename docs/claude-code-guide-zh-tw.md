# Claude Code Guide 中文全解（繁體中文版）

## 概述

Claude Code Guide 是一份社群驅動的完整 Claude Code 使用指南，涵蓋從**基礎安裝**到**進階功能**的全方位內容。本指南整合官方文檔與社群最佳實踐，提供 **CLI 指令參考**、**Subagents 多代理協作**、**Agent Skills 技能系統**、**MCP 協議整合**、**Hooks 自動化**等完整說明。

適合所有層級的 Claude Code 使用者，從新手入門到專家優化，都能在本指南中找到所需的資訊和實用範例。

> **專案資訊**
>
> - **專案名稱**：Claude Code Guide
> - **專案版本**：v1.5
> - **專案最後更新**：2025-12-23
> - **文件整理時間**：2025-12-24T01:59:00+08:00
> - **Claude Code 版本**：v2.0+ (支援 Subagents + Agent Skills + MCP)
>
> **核心定位**
>
> - **功能**：完整的 Claude Code 社群指南，涵蓋 CLI、Subagents、Agent Skills、MCP、Hooks 等全部功能
> - **場景**：學習入門、功能探索、最佳實踐、疑難排解、進階優化
> - **客群**：Claude Code 新手、專業開發者、團隊領導、技術探索者
>
> **資料來源**
>
> - [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide) 社群指南
> - [Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [Claude Code CLI 參考](https://docs.anthropic.com/en/docs/claude-code/cli-reference)
> - [Subagents 官方文檔](https://docs.anthropic.com/en/docs/claude-code/subagents)
> - [Agent Skills 官方文檔](https://docs.claude.com/en/docs/claude-code/skills)
> - [MCP 協議官方規範](https://docs.anthropic.com/en/docs/claude-code/mcp)
> - [Hooks 系統文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)

---

## 目錄

1. [產品概覽](#1-產品概覽)
2. [安裝與系統需求](#2-安裝與系統需求)
3. [快速入門](#3-快速入門)
4. [核心指令與參數](#4-核心指令與參數)
5. [Session/Config/MCP 指令](#5-sessionconfigmcp-指令)
6. [CLAUDE.md 與記憶體管理](#6-claudemd-與記憶體管理)
7. [自動化與腳本整合](#7-自動化與腳本整合)
8. [進階功能與最佳實踐](#8-進階功能與最佳實踐)
9. [疑難排解與常見問題](#9-疑難排解與常見問題)
10. [社群資源與延伸閱讀](#10-社群資源與延伸閱讀)

---

## 1. 產品概覽

Claude Code 是 Anthropic 推出的 AI 編程助手，支援自然語言指令、程式碼自動修復、MCP 多代理協作、專案記憶體管理等功能，適用於 VSCode、Cursor、終端機與多種開發環境。

### 1.1 最新版本特色

- **Claude Code v2.0+**：支援 Subagents、Agent Skills、MCP 協議
- **完整命令參考**：涵蓋所有可發現的 Claude Code 命令和參數
- **進階功能文檔**：包含許多未廣泛知曉或基礎教程中未記錄的功能
- **社群驅動**：每日同步官方發布說明和更新
- **完整配置指南**：環境變數、全域配置、專案配置完整說明
- **MCP 整合**：詳細的 MCP 伺服器配置和使用指南
- **Subagents 系統**：多代理協作完整指南

### 1.2 官方資源

- 官方文件：[Anthropic Claude Code Docs](https://claude.ai/code)
- 社群指南：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)
- 狀態：Active（活躍維護中）

---

## 2. 安裝與系統需求

### 2.1 系統需求

- Node.js 18+（建議 LTS 版）
- 支援 macOS、Linux、WSL/Windows
- 建議於純 Ubuntu WSL 環境安裝，避免 Windows 路徑汙染

### 2.2 安裝方式

- **NPM（官方推薦，通用方法）**

  ```bash
  npm install -g @anthropic-ai/claude-code
  ```

- **Windows**

  ```bash
  # 透過 CMD
  npm install -g @anthropic-ai/claude-code

  # 透過 PowerShell（自動安裝腳本）
  irm https://claude.ai/install.ps1 | iex
  ```

- **WSL/Git Bash**

  ```bash
  # 透過終端
  npm install -g @anthropic-ai/claude-code

  # 透過安裝腳本
  curl -fsSL https://claude.ai/install.sh | bash
  ```

- **MacOS**

  ```bash
  brew install node && npm install -g @anthropic-ai/claude-code
  ```

- **Linux**

  ```bash
  # 安裝 Node.js
  sudo apt update && sudo apt install -y nodejs npm

  # 安裝 Claude Code
  npm install -g @anthropic-ai/claude-code

  # 或使用安裝腳本
  curl -fsSL https://claude.ai/install.sh | bash
  ```

- **Arch Linux AUR**

  ```bash
  yay -S claude-code
  # 或
  paru -S claude-code
  ```

- **Docker 容器化**

  ```bash
  # Windows (CMD)
  docker run -it --rm -v "%cd%:/workspace" -e ANTHROPIC_API_KEY="sk-your-key" node:20-slim bash -lc "npm i -g @anthropic-ai/claude-code && cd /workspace && claude"

  # macOS/Linux (bash/zsh)
  docker run -it --rm -v "$PWD:/workspace" -e ANTHROPIC_API_KEY="sk-your-key" node:20-slim bash -lc 'npm i -g @anthropic-ai/claude-code && cd /workspace && claude'

  # 無 bash 後備方案
  docker run -it --rm -v "$PWD:/workspace" -e ANTHROPIC_API_KEY="sk-your-key" node:20-slim sh -lc 'npm i -g @anthropic-ai/claude-code && cd /workspace && claude'
  ```

#### 驗證安裝

```bash
# Linux
which claude

# Windows
where claude

# 通用
claude --version
```

#### 常見管理命令

```bash
claude config          # 配置設定
claude mcp list        # 設定 MCP 伺服器（可用 add/remove 替換 list）
claude /agents         # 配置/設定不同任務的 Subagents
claude update          # 更新至最新版本
```

> 來源：[官方文檔](https://docs.anthropic.com/en/docs/claude-code/docs/get-started)｜[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 3. 快速入門

- 啟動互動模式：
  ```bash
  claude
  claude "你的問題"
  ```
- 一次性查詢：
  ```bash
  claude -p "分析這段程式碼"
  cat file.js | claude -p "修正 bug"
  ```
- 專案整合（VSCode/Cursor）：
  ```bash
  cursor .
  # 或
  code .
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 4. 核心指令與參數

### 4.1 常用指令

| 指令                     | 說明                                           |
| ------------------------ | ---------------------------------------------- |
| `claude`                 | 啟動互動 REPL                                  |
| `claude "prompt"`        | 啟動 REPL 並預設提示                           |
| `claude -p "prompt"`     | 一次性查詢（非互動模式）                       |
| `claude -c`              | 繼續最近的對話（`--continue` 的別名）          |
| `claude -r "<id>"`       | 恢復特定會話（`--resume` 的別名）              |
| `claude config`          | 設定管理（互動式配置精靈）                     |
| `claude update`          | 升級至最新版                                   |
| `claude mcp`             | MCP 伺服器管理                                 |
| `claude /agents`         | 管理自訂 AI Subagents                          |
| `claude /memory`         | 編輯 CLAUDE.md 記憶檔案                        |
| `claude /model`          | 選擇或變更 AI 模型                             |
| `claude /cost`           | 顯示 token 使用統計和帳單資訊                  |
| `claude /permissions`    | 查看或更新工具權限                             |
| `claude /review`         | 請求程式碼審查                                 |
| `claude /status`         | 查看帳戶和系統狀態                             |
| `claude /doctor`         | 檢查 Claude Code 安裝的健康狀況                |
| `claude /bug`            | 回報錯誤（將對話發送給 Anthropic）             |
| `claude /clear`          | 清除對話歷史                                   |
| `claude /compact`        | 壓縮對話（可選焦點指令）                       |
| `claude /login`          | 切換 Anthropic 帳戶                            |
| `claude /logout`         | 登出 Anthropic 帳戶                            |
| `claude /vim`            | 進入 vim 模式                                  |
| `claude /terminal-setup` | 安裝 Shift+Enter 鍵綁定（僅 iTerm2 和 VSCode） |

### 4.2 命令列參數參考

| 參數                             | 說明                                                                           |
| -------------------------------- | ------------------------------------------------------------------------------ |
| `-d, --debug`                    | 啟用除錯模式（顯示詳細除錯輸出）                                               |
| `--verbose`                      | 覆蓋配置中的 verbose 模式設定（顯示擴展日誌/逐輪輸出）                         |
| `-p, --print`                    | 列印回應並退出（適用於管道輸出）                                               |
| `--output-format <format>`       | 輸出格式（僅與 `--print` 一起使用）：`text`（預設）、`json`、`stream-json`     |
| `--input-format <format>`        | 輸入格式（僅與 `--print` 一起使用）：`text`（預設）、`stream-json`             |
| `--replay-user-messages`         | 將用戶訊息從 stdin 重新發送到 stdout 以確認（僅與 `stream-json` 格式一起使用） |
| `--allowedTools <tools...>`      | 允許的工具名稱列表（逗號/空格分隔，如 `"Bash(git:*) Edit"`）                   |
| `--disallowedTools <tools...>`   | 拒絕的工具名稱列表（逗號/空格分隔）                                            |
| `--mcp-config <configs...>`      | 從 JSON 檔案或字串載入 MCP 伺服器（空格分隔）                                  |
| `--strict-mcp-config`            | 僅使用 `--mcp-config` 中的 MCP 伺服器，忽略其他 MCP 配置                       |
| `--append-system-prompt`         | 附加系統提示到預設系統提示（僅在 print 模式中有效）                            |
| `--permission-mode <mode>`       | 會話的權限模式（選項：`acceptEdits`、`bypassPermissions`、`default`、`plan`）  |
| `--permission-prompt-tool`       | 指定 MCP 工具在非互動模式下處理權限提示                                        |
| `--fallback-model <model>`       | 當預設模型過載時自動回退到指定模型（注意：僅與 `--print` 一起使用）            |
| `--model <model>`                | 當前會話的模型（接受別名如 `sonnet`/`opus` 或完整模型名稱）                    |
| `--settings <file-or-json>`      | 從 JSON 檔案或 JSON 字串載入額外設定                                           |
| `--add-dir <directories...>`     | 允許工具存取的額外目錄                                                         |
| `--ide`                          | 如果恰好有一個有效的 IDE 可用，在啟動時自動連接到 IDE                          |
| `-c, --continue`                 | 繼續當前目錄中最最近的對話                                                     |
| `-r, --resume [sessionId]`       | 恢復對話；提供會話 ID 或互動式選擇一個                                         |
| `--session-id <uuid>`            | 為對話使用特定的會話 ID（必須是有效的 UUID）                                   |
| `--dangerously-skip-permissions` | 繞過所有權限檢查（僅用於受信任的沙盒）                                         |
| `-v, --version`                  | 顯示已安裝的 `claude` CLI 版本                                                 |
| `-h, --help`                     | 顯示幫助/使用說明                                                              |
| `--include-partial-messages`     | 透過 CLI 標誌支援部分訊息串流                                                  |
| `--mcp-debug`                    | [已棄用] MCP 除錯模式（顯示 MCP 伺服器錯誤）。改用 `--debug`                   |

#### 常見組合範例

- **安全審查**：

  ```bash
  claude -p "檢查 secrets" --allowedTools "View"
  ```

- **JSON 輸出（用於腳本）**：

  ```bash
  claude -p "分析這個專案" --output-format json
  ```

- **串流 JSON（即時串流）**：

  ```bash
  claude -p "查詢" --output-format stream-json --input-format stream-json
  ```

- **多目錄分析**：

  ```bash
  claude --add-dir ../apps ../lib "分析微服務架構"
  ```

- **特定工具權限**：

  ```bash
  claude --allowedTools "Bash(git log:*)" "Read" "分析 git 歷史"
  claude --disallowedTools "Edit" "只讀分析"
  ```

- **權限模式**：

  ```bash
  claude --permission-mode plan "制定計劃"
  ```

- **模型選擇**：
  ```bash
  claude --model sonnet "使用 Sonnet 模型"
  claude --model claude-sonnet-4-20250514 "使用特定版本"
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 5. Session/Config/MCP 指令

### 5.1 Session 指令

- `claude` 啟動互動模式
- `claude "prompt"` 啟動單次查詢

### 5.2 Config 指令

#### 基本配置命令

- `claude config` - 互動式配置精靈
- `claude config get <key>` - 取得設定值（例如：`claude config get theme`）
- `claude config set <key> <value>` - 設定值（例如：`claude config set theme dark`）
- `claude config add <key> <vals...>` - 附加到陣列類型鍵（例如：`claude config add env DEV=1`）
- `claude config remove <key> <vals...>` - 從列表類型鍵移除項目
- `claude config list` - 顯示所有當前設定（專案範圍是預設）

#### 專案範圍設定範例

```bash
claude config set model "claude-3-5-sonnet-20241022"   # 覆蓋此專案的預設模型
claude config set includeCoAuthoredBy false            # 在 git/PR 中停用 "co-authored-by Claude" 署名
claude config set forceLoginMethod claudeai            # 限制登入流程：claudeai | console
claude config set enableAllProjectMcpServers true      # 自動批准來自 .mcp.json 的所有 MCP 伺服器
claude config set defaultMode "acceptEdits"            # 設定預設權限模式
```

#### 管理列表設定（專案範圍）

```bash
claude config add enabledMcpjsonServers github         # 批准來自 .mcp.json 的特定 MCP 伺服器
claude config add enabledMcpjsonServers memory         # 添加另一個
claude config remove enabledMcpjsonServers memory      # 移除一個項目
claude config add disabledMcpjsonServers filesystem    # 明確拒絕特定的 MCP 伺服器
```

#### 全域範圍設定（使用 `-g` 或 `--global`）

```bash
claude config set -g autoUpdates false                 # 全域關閉自動更新
claude config set --global preferredNotifChannel iterm2_with_bell
claude config set -g theme dark                        # 主題：dark | light | light-daltonized | dark-daltonized
claude config set -g verbose true                      # 到處顯示完整的 bash/命令輸出
claude config get -g theme                             # 確認全域值
```

#### 設定優先順序

設定優先順序：**Enterprise > CLI 參數 > 本地專案 > 共享專案 > 用戶（~/.claude）**

> **注意**：專案範圍是 `claude config` 的預設值；使用 `-g/--global` 影響所有專案。`add`/`remove` 僅用於列表類型鍵（例如 `enabledMcpjsonServers`）。

### 5.3 MCP 指令

#### MCP 管理命令

- `claude mcp` - 啟動 MCP 精靈/配置 MCP 伺服器
- `claude mcp list` - 列出已配置的 MCP 伺服器
- `claude mcp get <name>` - 顯示伺服器的詳細資訊
- `claude mcp remove <name>` - 移除伺服器
- `claude mcp add <name> <command> [args...]` - 添加本地 stdio 伺服器
- `claude mcp add --transport sse <name> <url>` - 添加遠端 SSE 伺服器
- `claude mcp add --transport http <name> <url>` - 添加遠端 HTTP 伺服器
- `claude mcp add <name> --env KEY=VALUE -- <cmd> [args...]` - 將環境變數傳遞給伺服器命令
- `claude mcp add --transport sse private-api https://api.example/mcp --header "Authorization: Bearer TOKEN"` - 添加帶認證標頭的伺服器
- `claude mcp add-json <name> '<json>'` - 透過 JSON blob 添加伺服器
- `claude mcp add-from-claude-desktop` - 從 Claude Desktop 匯入伺服器
- `claude mcp reset-project-choices` - 重置專案 .mcp.json 伺服器的批准
- `claude mcp serve` - 將 Claude Code 本身作為 MCP stdio 伺服器運行

#### MCP 除錯

- `claude --mcp-debug` - [已棄用] MCP 除錯模式，改用 `--debug`
- `claude --debug` - 啟用除錯模式（顯示詳細除錯輸出，包括 MCP）

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 6. CLAUDE.md 與記憶體管理

### 6.1 記憶體類型

Claude Code 提供四種記憶體位置，採用階層結構，每種都有不同用途：

| 記憶體類型                 | 位置                                                                                                                                                    | 用途                            | 使用案例範例                                    | 共享對象               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- | ----------------------------------------------- | ---------------------- |
| **Enterprise policy**      | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`<br />Linux: `/etc/claude-code/CLAUDE.md`<br />Windows: `C:\ProgramData\ClaudeCode\CLAUDE.md` | 由 IT/DevOps 管理的組織範圍指令 | 公司編碼標準、安全政策、合規要求                | 組織中的所有用戶       |
| **Project memory**         | `./CLAUDE.md`                                                                                                                                           | 專案的團隊共享指令              | 專案架構、編碼標準、常見工作流程                | 透過版本控制的團隊成員 |
| **User memory**            | `~/.claude/CLAUDE.md`                                                                                                                                   | 所有專案的個人偏好              | 程式碼樣式偏好、個人工具快捷方式                | 僅您（所有專案）       |
| **Project memory (local)** | `./CLAUDE.local.md`                                                                                                                                     | 個人專案特定偏好                | _（已棄用，見下方）_ 您的沙盒 URL、首選測試資料 | 僅您（當前專案）       |

> 所有記憶體檔案在啟動時會自動載入到 Claude Code 的上下文中。階層中較高的檔案優先，並首先載入，為更具體的記憶體提供基礎。

### 6.2 記憶體指令

- `claude /memory` - 編輯記憶體檔案
- `claude /memory view` - 檢視記憶體（如果支援）

### 6.3 記憶體快捷方式

- `#` 在開頭 - 記憶快捷方式，添加到 CLAUDE.md（提示選擇檔案）

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 7. 自動化與腳本整合

- 支援管道與腳本：
  ```bash
  cat file.js | claude -p "優化這段程式碼"
  ```
- 文件自動化：
  ```bash
  claude "更新 README.md 為最新 API"
  claude "根據資料庫 schema 產生 TypeScript 型別"
  ```
- CI/CD 整合：
  - 建議於 CI 設定 `--timeout`，避免卡死
  - 產出 `review-results.json` 以利追蹤

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 8. 進階功能與最佳實踐

### 8.1 進階功能深度解析

#### 多目錄整合分析

```bash
# 跨專案分析
claude --add-dir ../frontend ../backend ../shared
claude "分析微服務架構的整體一致性"

# 分層架構分析
claude --add-dir ./src ./tests ./docs
claude "檢查程式碼、測試、文檔的一致性"

# 依賴關係追蹤
claude --add-dir ../packages/*
claude "分析 monorepo 中的依賴關係和循環依賴"
```

#### MCP 多代理協作進階應用

```bash
# 啟動多代理模式
claude mcp

# 配置專門代理
claude mcp add code-reviewer /path/to/review-agent
claude mcp add security-scanner /path/to/security-agent
claude mcp add performance-analyzer /path/to/perf-agent

# 協作式程式碼審查
claude "請 code-reviewer 和 security-scanner 同時檢查 auth.js"
```

#### Extended Thinking 深度分析

```bash
# 啟用深度思考模式
claude --thinking-budget 10000 "設計一個可擴展的微服務架構"

# API 層級的深度思考
curl -H "anthropic-beta: extended-thinking-2024-12-10" \
     -H "Content-Type: application/json" \
     -d '{
       "model": "claude-3-5-sonnet-20241022",
       "thinking": {"budget_tokens": 20000},
       "messages": [{"role": "user", "content": "分析這個複雜系統的架構"}]
     }' \
     https://api.anthropic.com/v1/messages
```

### 8.2 企業級最佳實踐

#### 安全性強化策略

```json
// ~/.claude/security-policy.json
{
  "defaultTools": ["View", "Read"],
  "restrictedPaths": ["/.env*", "/secrets/", "/**/private/**"],
  "allowedDomains": ["github.com", "docs.company.com"],
  "auditLogging": true,
  "requireConfirmation": ["Edit", "Bash", "Write"]
}
```

#### 團隊模板標準化

```json
// ~/.claude/templates/team-frontend.json
{
  "name": "前端團隊標準配置",
  "allowedTools": ["View", "Edit", "Bash"],
  "hooks": {
    "preEdit": ["prettier --check", "eslint --quiet"],
    "postEdit": ["npm test -- --related"]
  },
  "slashCommands": [
    "/component-review",
    "/accessibility-check",
    "/performance-audit"
  ],
  "mcpServers": ["design-system", "component-library"]
}
```

#### 效能優化配置

```bash
# 大型專案優化設定
export CLAUDE_CACHE_SIZE=1000
export CLAUDE_PARALLEL_ANALYSIS=4
export CLAUDE_MEMORY_LIMIT=8192

# 分段處理策略
claude --max-files-per-analysis 50 --timeout 300
```

### 8.3 工作流程自動化

#### CI/CD 整合範例

```yaml
# .github/workflows/claude-review.yml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  claude-review:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Setup Claude Code
        run: |
          npm install -g @anthropic-ai/claude-code
          echo "${{ secrets.ANTHROPIC_API_KEY }}" > ~/.claude/api-key

      - name: Run Claude Review
        run: |
          claude --output-format json \
                 --allowedTools "View" \
                 "Review the changes in this PR for security, performance, and best practices" \
                 > review-results.json

      - name: Post Review Comments
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const results = JSON.parse(fs.readFileSync('review-results.json', 'utf8'));

            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: `## Claude Code 自動審查結果\n\n${results.summary}`
            });
```

#### 開發環境自動化

```bash
# dev-setup.sh
#!/bin/bash

# 初始化 Claude Code 開發環境
claude /init

# 設定專案特定配置
claude config set allowedTools '["View", "Edit", "Bash"]'
claude config set outputFormat "json"

# 安裝必要的 MCP 伺服器
claude mcp add github-integration github-mcp-server
claude mcp add database-tools postgres-mcp-server

# 建立開發專用的斜線命令
mkdir -p .claude/commands
cat > .claude/commands/dev-review.md << 'EOF'
# dev-review

快速開發環境程式碼審查

## Examples
/dev-review src/
EOF

echo "Claude Code 開發環境設定完成！"
```

### 8.4 監控與維護

#### 效能監控配置

```javascript
// claude-monitor.js
const ClaudeMonitor = {
  trackUsage: () => {
    // 追蹤 API 使用量
    const usage = JSON.parse(execSync("claude config get usage").toString());

    console.log(`API 使用量: ${usage.tokens}/月`);
    console.log(`剩餘額度: ${usage.remaining}`);

    if (usage.remaining < 1000) {
      console.warn("⚠️  API 額度即將用盡！");
    }
  },

  healthCheck: () => {
    // 系統健康檢查
    execSync("claude /doctor");
  },

  cleanupSessions: () => {
    // 清理舊的 session
    execSync("claude /compact");
  },
};

// 定期執行監控
setInterval(ClaudeMonitor.trackUsage, 3600000); // 每小時
setInterval(ClaudeMonitor.healthCheck, 86400000); // 每日
```

#### 錯誤追蹤與診斷

```bash
# 詳細錯誤診斷
claude --verbose --debug "分析這個錯誤" 2>error.log

# MCP 連接診斷
claude --mcp-debug mcp status

# 記憶體和緩存診斷
claude /doctor --detailed

# 匯出診斷報告
claude /bug --include-logs --include-config
```

### 8.5 高階整合模式

#### 語義搜尋整合

```python
# semantic-search.py
import subprocess
import json

def semantic_code_search(query, project_path):
    """結合 Claude Code 進行語義程式碼搜尋"""

    # 使用 Claude 分析搜尋意圖
    result = subprocess.run([
        'claude', '--output-format', 'json',
        f'在 {project_path} 中搜尋與「{query}」相關的程式碼'
    ], capture_output=True, text=True)

    search_results = json.loads(result.stdout)

    # 進一步分析和排序結果
    analysis = subprocess.run([
        'claude', '--output-format', 'json',
        f'分析這些搜尋結果的相關性：{search_results}'
    ], capture_output=True, text=True)

    return json.loads(analysis.stdout)
```

#### 架構分析自動化

```bash
# architecture-analyzer.sh
#!/bin/bash

echo "🏗️  開始架構分析..."

# 分析整體架構
claude --add-dir src tests docs \
       --output-format json \
       "分析專案架構並提供改進建議" > architecture-report.json

# 依賴關係分析
claude "分析 package.json 和 imports，找出潛在的依賴問題" > dependencies-report.md

# 安全性掃描
claude --allowedTools "View" \
       "掃描程式碼中的潛在安全問題" > security-report.md

# 效能分析
claude "分析程式碼中的效能瓶頸和優化機會" > performance-report.md

echo "✅ 架構分析完成！查看生成的報告文件。"
```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide) | [官方文檔](https://docs.anthropic.com/en/docs/claude-code) | 企業級實踐案例

---

## 9. 疑難排解與常見問題

| 症狀                   | 可能原因              | 解決方式                                         |
| ---------------------- | --------------------- | ------------------------------------------------ |
| 缺少 ANTHROPIC_API_KEY | 未設環境變數          | 設定 export ANTHROPIC_API_KEY=xxx                |
| Rate limit exceeded    | 免費額度用盡          | 升級方案或減少請求                               |
| 權限錯誤               | allowedTools 設定錯誤 | claude config set allowedTools '["Edit","View"]' |
| MCP 問題               | MCP 未啟動或異常      | claude mcp restart --all                         |
| Node 版本錯誤          | Node.js 版本過舊      | 升級 Node.js 至 18+                              |

- 健康檢查：
  ```bash
  claude --version
  claude --help
  claude config list
  claude /doctor
  ```
- 除錯模式：
  ```bash
  claude --verbose
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 10. 社群資源與延伸閱讀

- [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)
- [官方文檔](https://docs.anthropic.com/en/docs/claude-code)
- [CLAUDE.md 範例](https://github.com/zebbern/claude-code-guide/blob/main/CLAUDE.md)
- [Anthropic API 參考](https://docs.anthropic.com/en/docs/claude-code/api/overview)
- [MCP 多代理協作](https://docs.anthropic.com/en/docs/claude-code/docs/agents-and-tools/tool-use/overview)

---

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/zebbern/claude-code-guide) 與 [官方文檔](https://docs.anthropic.com/en/docs/claude-code)。
>
> **版本資訊**：Claude Code Guide v1.5 - 完整的 Claude Code 社群指南  
> **最後更新**：2025-11-24T05:40:00+08:00  
> **專案更新**：2025-11-24T00:41:50+00:00  
> **主要變更**：更新安裝指南、命令參考、配置選項、MCP 整合、Subagents 系統、環境變數說明
