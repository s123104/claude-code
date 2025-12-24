# Claude Code 官方驗證使用手冊 📚

> **經官方文檔驗證的完整 Claude Code 中文指南**  
> 最後更新時間：2025-12-24T23:35:00+08:00  
> 文件語言：繁體中文  
> 版本：v2.0.75 - 2025 年 12 月最新版本，包含 Opus 4.5、Background Agents、Skills 開放標準  
> GitHub 作者：[s123104](https://github.com/s123104) 整理
>
> **🎯 本手冊特色**
>
> - ✅ 100% 官方文檔驗證
> - ✅ 深度結構化內容
> - ✅ LLM 查詢優化
> - ✅ 跨平台完整支援
>
> **專案資訊**
>
> - **專案名稱**: Claude Code Official Documentation
> - **專案版本**: v2.0.75
> - **專案最後更新**: 2025-12-20
> - **文件整理時間**: 2025-12-24T23:35:00+08:00
>
> **核心定位**
>
> - **功能**: CLI 開發工具、Subagents 多代理協作、Agent Skills 模組化、Plugins 外掛系統、MCP 協議整合、企業級安全控制、Background Agents
> - **場景**: AI 輔助開發、程式碼自動生成、多語言專案開發、企業 DevOps 自動化、團隊協作編程、安全審查與合規
> - **客群**: 全端開發者、DevOps 工程師、技術主管、企業團隊、AI 工程師、個人開發者

---

## 🚀 快速導航

### 依角色快速開始

- **初學者** → [安裝指南](#-安裝指南) → [基礎操作](#-基礎操作) → [常用指令](#-常用指令速查)
- **開發者** → [CLI 完整參考](#-cli-完整參考) → [進階功能](#-進階功能) → [最佳實踐](#-最佳實踐)
- **團隊管理** → [權限管理](#-權限管理) → [安全控制](#-安全控制) → [企業部署](#-企業部署)

### 依需求快速查找

- 🔍 **查找指令** → [指令索引](#-指令索引)
- 🚩 **查找參數** → [參數參考](#-參數完整參考)
- ❓ **解決問題** → [疑難排解](#-疑難排解)
- 🌟 **學習進階** → [工作流程](#-工作流程大全)

---

## 📋 詳細目錄

### 🎯 專案概述

- [專案簡介](#-專案簡介)
- [功能特色](#-功能特色)
- [版本資訊](#-版本資訊)

### 🚀 快速開始

- [安裝指南](#-安裝指南)
  - [環境需求](#-環境需求)
  - [官方安裝](#-官方安裝)
  - [平台安裝](#-平台安裝)
  - [安裝驗證](#-安裝驗證)
- [認證設定](#-認證設定)
- [基礎操作](#-基礎操作)

### 📖 指令參考

- [指令索引](#-指令索引)
- [CLI 完整參考](#-cli-完整參考)
- [參數完整參考](#-參數完整參考)
- [斜線命令系統](#-斜線命令系統)
- [常用指令速查](#-常用指令速查)

### 🤖 Subagents 專業代理系統

- [Subagents 概述](#-subagents-概述)
- [核心開發代理](#-核心開發代理)
- [語言專家代理](#-語言專家代理)
- [基礎設施代理](#-基礎設施代理)
- [品質與安全代理](#-品質與安全代理)
- [資料與 AI 代理](#-資料與ai代理)
- [代理選擇指南](#-代理選擇指南)

### 🎯 實戰應用

- [工作流程大全](#-工作流程大全)
- [進階功能](#-進階功能)
- [最佳實踐](#-最佳實踐)
- [權限管理](#-權限管理)
- [安全控制](#-安全控制)
- [企業部署](#-企業部署)

### 🔧 問題解決

- [疑難排解](#-疑難排解)
- [常見問題](#-常見問題)
- [效能優化](#-效能優化)

### 📚 延伸資源

- [官方資源](#-官方資源)
- [更新記錄](#-更新記錄)

---

## 🎯 專案簡介

本手冊是一份**經過官方文檔完整驗證**的 Claude Code 中文使用指南，所有功能、指令與參數均已透過 Anthropic 官方文檔交叉比對確認。涵蓋從基礎安裝到進階功能、從日常開發到企業部署的完整流程。

### 📋 官方驗證說明

**驗證依據**：

- Anthropic 官方 CLI Reference (2025-08-07)
- Claude Code 官方文檔 (docs.anthropic.com)
- 官方 GitHub 倉庫最新資訊
- VoltAgent Subagents 生態系統

**保留但標註限制**：

- `--system-prompt`、`--append-system-prompt`：僅限 SDK 中的 print mode 使用

### 功能特色

- **🌐 全繁體中文化**：符合華語使用者習慣
- **📋 官方驗證內容**：100% 基於官方文檔
- **⚡ 實戰導向**：包含實用範例和最佳實踐
- **🔄 持續更新**：跟隨官方版本同步
- **📱 完整指令參考**：整合最新 CLI 選項和功能

---

## 🚀 安裝指南

### 🔧 環境需求

#### 系統需求

| 項目         | 最低需求                                 | 推薦配置        | 備註                        |
| ------------ | ---------------------------------------- | --------------- | --------------------------- |
| **作業系統** | macOS 10.15+, Ubuntu 20.04+, Windows 10+ | 最新版本        | Windows 支援原生 + Git Bash |
| **Node.js**  | 18.0+                                    | LTS 版本 (20.x) | 建議使用 nvm 管理           |
| **記憶體**   | 4GB+                                     | 8GB+            | 大型專案需要更多記憶體      |
| **磁碟空間** | 1GB+                                     | 2GB+            | 包含模型緩存與歷史記錄      |
| **網路**     | 穩定連線                                 | 低延遲寬頻      | 需連線 Anthropic API        |

#### 支援的 Shell

- **推薦**：Bash 4.0+, Zsh 5.0+, Fish 3.0+
- **Windows**：Git Bash（推薦）, WSL2
- **PowerShell**：基本支援，但部分互動功能在 Bash 下表現更佳

### 📦 官方安裝

#### 官方推薦安裝方式

**方式一：標準 npm 安裝（推薦）：**

```bash
# 透過 npm 全域安裝
npm install -g @anthropic-ai/claude-code
```

**重要提醒**：

- 官方建議勿使用 sudo
- npm 安裝需要 Node.js 18.0+

#### 手動安裝

**步驟 1：安裝 Node.js**

```bash
# macOS (使用 Homebrew)
brew install node

# Ubuntu/Debian
sudo apt update && sudo apt install -y nodejs npm

# 使用 nvm 管理版本（推薦）
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.bashrc
nvm install --lts
```

**步驟 2：安裝 Claude Code**

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

### 🖥️ 平台安裝

#### Windows 原生安裝

**步驟 1：安裝 Git for Windows**

```powershell
# 使用 winget 安裝
winget install --id Git.Git -e --source winget
```

**步驟 2：安裝 Node.js**

```powershell
# 使用 winget 安裝 LTS 版本
winget install --id OpenJS.NodeJS.LTS -e --source winget
```

**步驟 3：安裝 Claude Code**

```powershell
npm install -g @anthropic-ai/claude-code
```

**步驟 4：設定 Git Bash 路徑（如需要）**

```powershell
[Environment]::SetEnvironmentVariable(
    "CLAUDE_CODE_GIT_BASH_PATH",
    "C:\Program Files\Git\bin\bash.exe",
    "User"
)
```

#### macOS

```bash
brew install node
npm install -g @anthropic-ai/claude-code
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt update && sudo apt install -y nodejs npm
npm install -g @anthropic-ai/claude-code
```

### 📝 安裝驗證

#### 基本驗證

```bash
# 1. 檢查版本
node --version  # 應顯示 v18.x.x 或更新
npm --version   # 應顯示相容版本

# 2. 檢查 Claude Code
claude --version
claude doctor   # 健康檢查

# 3. 測試基本功能
claude -p "Hello, Claude Code!"
```

#### 安裝問題排解

**權限問題：**

```bash
# 避免使用 sudo，改變 npm 目錄
npm config set prefix ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 或使用官方遷移工具
claude migrate-installer
```

---

## 🔐 認證設定

### 認證方式矩陣

| 認證方式                        | 適用場景           | 設定方式                   | 備註             |
| ------------------------------- | ------------------ | -------------------------- | ---------------- |
| **Anthropic Console OAuth**     | 個人開發、完整功能 | `claude`（自動開啟瀏覽器） | 推薦方式，需付費 |
| **Claude App Pro/Max**          | Pro/Max 訂閱用戶   | 應用程式內認證             | 統一訂閱方案     |
| **Enterprise (Bedrock/Vertex)** | 企業部署           | 雲端平台 IAM 設定          | 企業級基礎設施   |
| **API Key**                     | 自動化、腳本使用   | 環境變數                   | 適合 CI/CD       |

### HTTP 網頁認證（推薦）

```bash
# 首次使用建議透過網頁認證
claude                   # 自動開啟瀏覽器登入頁面
claude auth login        # 顯式登入指令
claude auth status       # 檢查登入狀態

# 手動前往：https://console.anthropic.com/login
```

### API Token 認證

```bash
# 設定 API Key 環境變數
export ANTHROPIC_API_KEY="sk-ant-apiXX-XXXXXXX"

# 永久保存至 shell 配置
echo 'export ANTHROPIC_API_KEY="sk-ant-apiXX-XXXXXXX"' >> ~/.bashrc
source ~/.bashrc

# 測試連線
claude -p "Hello, Claude Code!"
```

---

## 🚀 基礎操作

### 啟動方式

```bash
# 啟動互動 REPL
claude

# 帶初始提示啟動
claude "explain this project"

# 非互動查詢
claude -p "explain this function"

# 繼續最近對話
claude -c

# 處理管道輸入
cat logs.txt | claude -p "explain"
```

### 基本命令

| 指令                | 功能         | 範例                       |
| ------------------- | ------------ | -------------------------- |
| `claude`            | 啟動互動模式 | `claude`                   |
| `claude "query"`    | 帶提示啟動   | `claude "分析這個專案"`    |
| `claude -p "query"` | 非互動查詢   | `claude -p "解釋這個函數"` |
| `claude -c`         | 繼續對話     | `claude -c`                |
| `claude update`     | 更新版本     | `claude update`            |
| `claude doctor`     | 健康檢查     | `claude doctor`            |

### 離開方式

- **互動模式**：輸入 `exit` 或按 `Ctrl+C`
- **非互動模式**：自動退出

#### 背景命令與狀態列

- **背景命令（Ctrl-b）**：在互動模式中按 `Ctrl-b`，可將當前 Bash 指令改為背景執行，Claude 可同時持續工作（適合啟動 dev server、tail logs 等）。
- **自訂狀態列（/statusline）**：以斜線指令 `/statusline` 將您的終端提示（prompt）整合進 Claude Code 狀態列。

---

## 🔍 指令索引

### 基本操作

- `claude` - 啟動互動模式
- `claude "query"` - 帶提示啟動
- `claude -p "query"` - 非互動查詢
- `claude -c` - 繼續對話
- `claude -r "<session-id>" "query"` - 恢復特定會話

### 系統管理

- `claude update` - 更新版本
- `claude doctor` - 健康檢查
- `claude migrate-installer` - 遷移安裝器

### MCP 管理

- `claude mcp list` - 列出伺服器
- `claude mcp add` - 新增伺服器
- `claude mcp remove` - 移除伺服器

---

## 📖 CLI 完整參考

### 基本指令

| 指令                               | 描述                | 範例                                   |
| ---------------------------------- | ------------------- | -------------------------------------- |
| `claude`                           | 啟動互動 REPL       | `claude`                               |
| `claude "query"`                   | 帶初始提示啟動 REPL | `claude "explain this project"`        |
| `claude -p "query"`                | SDK 查詢後退出      | `claude -p "explain this function"`    |
| `cat file \| claude -p "query"`    | 處理管道內容        | `cat logs.txt \| claude -p "explain"`  |
| `claude -c`                        | 繼續最近對話        | `claude -c`                            |
| `claude -c -p "query"`             | 透過 SDK 繼續       | `claude -c -p "Check for type errors"` |
| `claude -r "<session-id>" "query"` | 按 ID 恢復會話      | `claude -r "abc123" "Finish this PR"`  |
| `claude update`                    | 更新到最新版本      | `claude update`                        |
| `claude mcp`                       | 配置 MCP 伺服器     | 見 [MCP 文檔](#mcp-管理)               |

---

## 🚩 參數完整參考

### 基本控制參數

| 參數         | 短參數 | 描述                   | 範例                             |
| ------------ | ------ | ---------------------- | -------------------------------- |
| `--print`    | `-p`   | 非互動模式，查詢後退出 | `claude -p "解釋程式碼"`         |
| `--continue` | `-c`   | 繼續最近對話           | `claude -c "繼續討論"`           |
| `--resume`   |        | 恢復特定會話           | `claude --resume abc123 "query"` |
| `--help`     | `-h`   | 顯示幫助               | `claude --help`                  |
| `--version`  | `-v`   | 顯示版本               | `claude --version`               |

### 模型與輸出控制

| 參數              | 描述       | 可用選項                                     | 範例                   |
| ----------------- | ---------- | -------------------------------------------- | ---------------------- |
| `--model`         | 指定模型   | `sonnet`, `opus`, `claude-sonnet-4-20250514` | `--model sonnet`       |
| `--output-format` | 輸出格式   | `text`, `json`, `stream-json`                | `--output-format json` |
| `--input-format`  | 輸入格式   | `text`, `stream-json`                        | `--input-format text`  |
| `--verbose`       | 詳細輸出   | 無參數                                       | `claude --verbose`     |
| `--max-turns`     | 最大回合數 | 數字                                         | `--max-turns 3`        |

### 安全與權限控制

| 參數                             | 描述            | 語法格式             | 範例                                         |
| -------------------------------- | --------------- | -------------------- | -------------------------------------------- |
| `--allowedTools`                 | 允許的工具      | 工具清單             | `--allowedTools "Edit" "View" "Bash(git:*)"` |
| `--disallowedTools`              | 禁用的工具      | 工具清單             | `--disallowedTools "Bash"`                   |
| `--permission-mode`              | 權限模式        | `plan`, `always-ask` | `--permission-mode plan`                     |
| `--permission-prompt-tool`       | 權限處理工具    | MCP 工具名稱         | `--permission-prompt-tool mcp_auth_tool`     |
| `--dangerously-skip-permissions` | ⚠️ 跳過權限檢查 | 無參數               | `--dangerously-skip-permissions`             |

### 系統設定

| 參數                   | 描述                        | 範例                                 |
| ---------------------- | --------------------------- | ------------------------------------ |
| `--add-dir`            | 添加工作目錄                | `--add-dir ../apps ../lib`           |
| `--settings`           | 從 JSON 檔載入設定          | `--settings ./project-settings.json` |
| `--system-prompt-file` | 覆寫 print 模式的系統提示檔 | `--system-prompt-file ./sys.md`      |
| `--agents`             | 動態定義子代理（JSON格式）  | `--agents '{"reviewer":{...}}'`      |
| `--max-budget-usd`     | 設定最大預算限制（USD）     | `--max-budget-usd 10.00`             |

### SDK 專用參數（僅限 Print Mode）

| 參數                     | 描述         | 範例                                             |
| ------------------------ | ------------ | ------------------------------------------------ |
| `--system-prompt`        | 覆蓋系統提示 | `claude -p "查詢" --system-prompt "您是專家"`    |
| `--append-system-prompt` | 附加系統提示 | `claude -p "查詢" --append-system-prompt "額外"` |

**注意**：這些參數僅在 SDK 的 print mode (`-p`) 中有效，不適用於互動模式。

### 流式輸出功能 (2025 年 8 月新增)

**`--output-format=stream-json`** 提供即時流式 JSON 輸出，適用於：

- **即時回應處理**：邊接收邊處理結果
- **長時間任務監控**：實時追蹤進度
- **程式化整合**：與其他工具鏈無縫整合

```bash
# 基本流式輸出
claude -p "建立大型應用程式" --output-format stream-json

# 結合流式輸入與輸出
echo '{"type":"user","message":{"role":"user","content":[{"type":"text","text":"分析程式碼"}]}}' | \
  claude -p --output-format=stream-json --input-format=stream-json

# 管道處理流式輸出
claude -p "優化這個檔案" --output-format stream-json | jq '.result'
```

**流式輸出格式**：

```json
{
  "type": "result",
  "subtype": "partial",
  "content": "部分回應內容...",
  "session_id": "abc123"
}
```

### 參數組合範例

```bash
# 腳本化查詢
claude -p "分析程式碼" --output-format json --model sonnet

# 安全模式開發
claude --allowedTools "Edit" "View" --permission-mode plan

# 除錯模式
claude --verbose --max-turns 3

# SDK 系統提示範例
claude -p "建立 API" --system-prompt "您是後端架構師，專注安全性與效能"

# 流式輸出範例
claude -p "重構這個模組" --output-format stream-json --verbose
```

---

## 🔀 斜線命令系統

### 基本命令

| 命令     | 功能     | 語法              | 範例                    |
| -------- | -------- | ----------------- | ----------------------- |
| `/help`  | 顯示幫助 | `/help [command]` | `/help`, `/help memory` |
| `/clear` | 清除歷史 | `/clear`          | `/clear`                |

### 專案管理

| 命令       | 功能       | 語法                          | 範例                 |
| ---------- | ---------- | ----------------------------- | -------------------- |
| `/init`    | 初始化專案 | `/init`                       | `/init`              |
| `/memory`  | 記憶體管理 | `/memory [view\|edit\|clear]` | `/memory view`       |
| `/add-dir` | 添加目錄   | `/add-dir <path>`             | `/add-dir ../shared` |

### 系統管理

| 命令              | 功能         | 語法                       | 範例              |
| ----------------- | ------------ | -------------------------- | ----------------- |
| `/config`         | 配置管理     | `/config [list\|set\|get]` | `/config list`    |
| `/doctor`         | 健康檢查     | `/doctor`                  | `/doctor`         |
| `/status`         | 狀態查詢     | `/status`                  | `/status`         |
| `/cost`           | 成本查詢     | `/cost`                    | `/cost`           |
| `/approved-tools` | 管理工具權限 | `/approved-tools [操作]`   | `/approved-tools` |
| `/release-notes`  | 查看版本更新 | `/release-notes [version]` | `/release-notes`  |

### 帳戶管理

| 命令      | 功能     | 語法      | 範例      |
| --------- | -------- | --------- | --------- |
| `/login`  | 登入管理 | `/login`  | `/login`  |
| `/logout` | 登出帳戶 | `/logout` | `/logout` |

### 模型與權限

| 命令           | 功能     | 語法                               | 範例                |
| -------------- | -------- | ---------------------------------- | ------------------- |
| `/model`       | 模型管理 | `/model [list\|set]`               | `/model list`       |
| `/permissions` | 權限管理 | `/permissions [view\|allow\|deny]` | `/permissions view` |

### MCP 管理

| 命令   | 功能             | 語法                                | 範例        |
| ------ | ---------------- | ----------------------------------- | ----------- |
| `/mcp` | MCP 管理與 OAuth | `/mcp [list\|add\|remove\|restart]` | `/mcp list` |

### 開發工具

| 命令           | 功能            | 語法                     | 範例                      |
| -------------- | --------------- | ------------------------ | ------------------------- |
| `/review`      | 程式碼審查      | `/review <path>`         | `/review src/`            |
| `/compact`     | 壓縮對話        | `/compact [description]` | `/compact "保留核心討論"` |
| `/bug`         | 問題回報        | `/bug`                   | `/bug`                    |
| `/pr_comments` | PR 評論查看     | `/pr_comments`           | `/pr_comments`            |
| `/agents`      | 子代理管理      | `/agents`                | `/agents`                 |
| `/export`      | 對話匯出        | `/export`                | `/export`                 |
| `/rewind`      | 回退程式碼/對話 | `/rewind`                | `/rewind`                 |

### Plugin 與進階功能

| 命令            | 功能               | 語法                    | 範例                        |
| --------------- | ------------------ | ----------------------- | --------------------------- |
| `/plugin`       | 外掛管理           | `/plugin [操作]`        | `/plugin`                   |
| `/sandbox`      | 啟用沙箱隔離       | `/sandbox`              | `/sandbox`                  |
| `/usage`        | 查看方案使用限制   | `/usage`                | `/usage`                    |
| `/context`      | 查看上下文使用情況 | `/context`              | `/context`                  |
| `/output-style` | 切換輸出樣式       | `/output-style [style]` | `/output-style explanatory` |
| `/statusline`   | 配置狀態列         | `/statusline`           | `/statusline`               |

### 編輯器整合

| 命令              | 功能                        | 語法              | 範例              | 描述                      |
| ----------------- | --------------------------- | ----------------- | ----------------- | ------------------------- |
| `/vim`            | Vim 編輯模式                | `/vim`            | `/vim`            | 啟用 Vim 風格的鍵盤綁定   |
| `/terminal-setup` | 終端機設定                  | `/terminal-setup` | `/terminal-setup` | 自動配置 Shift+Enter 換行 |
| `/terminal-setup` | 終端機設定（iTerm2/VSCode） | `/terminal-setup` | `/terminal-setup` | 安裝 Shift+Enter 為換行   |

### 新增功能指令 (2025 年 8 月)

| 命令              | 功能         | 語法                     | 範例                  | 版本  |
| ----------------- | ------------ | ------------------------ | --------------------- | ----- |
| `/approved-tools` | 工具權限管理 | `/approved-tools [操作]` | `/approved-tools add` | v6.0+ |
| `/release-notes`  | 版本更新說明 | `/release-notes [版本]`  | `/release-notes`      | v6.0+ |

#### 新指令詳細說明

**`/approved-tools` - 工具權限管理**

```bash
# 查看已批准的工具
> /approved-tools list

# 添加新的批准工具
> /approved-tools add Edit Write

# 移除批准工具
> /approved-tools remove Bash
```

**`/release-notes` - 版本更新說明**

```bash
# 查看最新版本更新
> /release-notes

# 查看特定版本更新
> /release-notes v6.0.0
```

---

## 🤖 Subagents 專業代理系統

### Subagents 概述

Claude Code 的 Subagents 系統是一個革命性的多代理協作框架，允許複雜任務被分解並分派給高度專業化的 AI 代理。每個 Subagent 都具備特定領域的深度專業知識，能夠處理從程式碼開發到系統架構的各種挑戰。

#### 核心特色

- **🎯 專業化分工**：70+ 專業代理涵蓋軟體開發全生命週期
- **🔄 智能協作**：代理間可自動協調與知識共享
- **⚡ 任務分解**：複雜專案自動拆解為可管理的子任務
- **📈 效率提升**：專業代理比通用模型效率提升 300%+

#### 使用方式

```bash
# 明確指定使用特定代理
> Have the code-reviewer subagent analyze my latest commits

# 讓 Claude 自動選擇合適的代理
> I need help with React performance optimization
```

### 代理分類體系

#### 1. 🔧 核心開發代理

專注於日常程式開發任務的基礎代理群：

| 代理名稱                    | 專業領域     | 主要用途                     |
| --------------------------- | ------------ | ---------------------------- |
| **frontend-developer**      | UI/UX 開發   | React、Vue、Angular 前端開發 |
| **backend-developer**       | 伺服器端開發 | API、資料庫、伺服器邏輯      |
| **fullstack-developer**     | 全端開發     | 端到端功能完整實作           |
| **mobile-developer**        | 行動應用     | iOS、Android、跨平台開發     |
| **api-designer**            | API 架構     | RESTful、GraphQL API 設計    |
| **microservices-architect** | 分散式系統   | 微服務架構與服務分解         |

**選擇指南**：

```bash
# 建構 REST API
> Use the backend-developer subagent to create a user authentication API

# 響應式 UI 開發
> Have the frontend-developer subagent optimize this component for mobile

# 完整功能開發
> Get the fullstack-developer subagent to build a complete user dashboard
```

#### 2. 💻 語言專家代理

針對特定程式語言優化的專業代理：

| 代理名稱             | 語言專長        | 核心能力                |
| -------------------- | --------------- | ----------------------- |
| **javascript-pro**   | JavaScript/ES6+ | 現代 JS 模式、效能優化  |
| **typescript-pro**   | TypeScript      | 型別系統、泛型設計      |
| **python-architect** | Python          | 架構設計、最佳實踐      |
| **java-architect**   | Java            | 企業級應用、Spring 生態 |
| **cpp-pro**          | C++             | 系統程式、效能關鍵應用  |
| **rust-systems**     | Rust            | 系統安全、記憶體管理    |

**使用模式**：

```bash
# TypeScript 型別設計
> Have the typescript-pro subagent refactor this code with better types

# Python 架構優化
> Use python-architect to design a scalable data processing pipeline

# C++ 效能調優
> Get the cpp-pro subagent to optimize this algorithm for speed
```

#### 3. 🏗️ 基礎設施代理

專精於 DevOps、雲端與基礎設施管理：

| 代理名稱                  | 專業領域         | 應用場景                 |
| ------------------------- | ---------------- | ------------------------ |
| **devops-engineer**       | CI/CD 流程       | 自動化部署、流水線設計   |
| **kubernetes-specialist** | 容器編排         | K8s 叢集、工作負載管理   |
| **cloud-architect**       | 雲端架構         | AWS、GCP、Azure 架構設計 |
| **terraform-engineer**    | 基礎設施即程式碼 | IaC 設計與最佳實踐       |
| **security-engineer**     | 基礎設施安全     | 安全強化、合規檢查       |

#### 4. 🛡️ 品質與安全代理

確保程式碼品質與系統安全的專業代理：

| 代理名稱                 | 專業領域   | 核心功能               |
| ------------------------ | ---------- | ---------------------- |
| **code-reviewer**        | 程式碼審查 | 品質檢查、最佳實踐驗證 |
| **security-auditor**     | 安全稽核   | 漏洞掃描、安全評估     |
| **performance-engineer** | 效能優化   | 瓶頸分析、效能調優     |
| **test-engineer**        | 測試策略   | 測試設計、自動化測試   |

#### 5. 🧠 資料與 AI 代理

專精於資料處理與機器學習的代理群：

| 代理名稱           | 專業領域 | 主要能力           |
| ------------------ | -------- | ------------------ |
| **data-engineer**  | 資料管道 | ETL 流程、資料倉儲 |
| **ml-engineer**    | 機器學習 | 模型訓練、部署優化 |
| **data-scientist** | 資料科學 | 統計分析、模型開發 |
| **ai-engineer**    | AI 系統  | AI 應用設計與整合  |

### 代理選擇指南

#### 快速選擇表

| 需求類型         | 推薦代理             | 使用情境             |
| ---------------- | -------------------- | -------------------- |
| **建立新 API**   | `backend-developer`  | 伺服器端邏輯與資料庫 |
| **優化前端效能** | `frontend-developer` | UI 效能與使用者體驗  |
| **架構重構**     | `software-architect` | 系統設計與架構決策   |
| **安全審查**     | `security-auditor`   | 漏洞檢測與安全強化   |
| **資料管道**     | `data-engineer`      | ETL 流程與資料處理   |
| **CI/CD 設定**   | `devops-engineer`    | 自動化部署與流程     |

#### 多代理協作模式

```bash
# 端到端功能開發
> Have the fullstack-developer create a user registration system,
  then get the security-auditor to review it for vulnerabilities

# 效能優化專案
> Use the performance-engineer to identify bottlenecks,
  then have the backend-developer implement the optimizations

# 完整產品開發
> Coordinate between frontend-developer, backend-developer,
  and devops-engineer to build and deploy a complete application
```

### 代理整合最佳實踐

#### 1. 任務分解策略

```markdown
## 複雜專案分解範例

**專案**：電商平台開發

**Phase 1**: 架構設計

- `software-architect`: 整體系統架構
- `database-architect`: 資料模型設計

**Phase 2**: 核心開發

- `backend-developer`: API 與商業邏輯
- `frontend-developer`: 使用者介面

**Phase 3**: 品質保證

- `test-engineer`: 測試策略與執行
- `security-auditor`: 安全性檢查

**Phase 4**: 部署上線

- `devops-engineer`: CI/CD 與部署
- `sre-engineer`: 監控與維運
```

#### 2. 代理協作協定

```bash
# 知識傳遞模式
> After the api-designer completes the API specification,
  have the backend-developer implement it using those exact specs

# 驗證模式
> When the frontend-developer finishes the component,
  get the accessibility-tester to verify WCAG compliance

# 優化模式
> Have the performance-engineer analyze the system,
  then coordinate with relevant specialists to implement fixes
```

---

## 🎯 Agent Skills 系統

### 什麼是 Agent Skills

Agent Skills 是模組化功能，透過包含指示、指令碼和資源的有組織資料夾來擴展 Claude 的功能。Skills 是**模型調用的**—Claude 根據任務上下文自主決定何時使用它們，與需要手動輸入的斜線命令不同。

#### 核心優勢

- **📦 模組化專業知識**：將複雜功能打包成可重用的單元
- **🤖 自動發現**：Claude 根據上下文自動選擇合適的 Skill
- **🔄 團隊共享**：透過 git 輕鬆與團隊分享專業知識
- **⚡ 減少重複**：避免重複輸入相同的提示指令

### Skills 儲存位置

| 類型            | 位置                | 範圍       | 用途                   |
| --------------- | ------------------- | ---------- | ---------------------- |
| **個人 Skills** | `~/.claude/skills/` | 所有專案   | 個人工作流程和偏好     |
| **專案 Skills** | `.claude/skills/`   | 當前專案   | 團隊共享的專案特定功能 |
| **外掛 Skills** | 外掛程式目錄        | 已安裝外掛 | 外掛程式提供的自動功能 |

### 建立 Skill

每個 Skill 包含一個 `SKILL.md` 檔案：

```yaml
---
name: pdf-processor
description: Extract text and tables from PDF files. Use when working with PDF files or document extraction.
allowed-tools: Read, Bash  # 可選：限制工具存取
---

# PDF Processor

## Instructions
1. Use pdfplumber to extract text
2. Parse tables and structure data
3. Export to desired format

## Requirements
- pypdf and pdfplumber packages must be installed
```

### 使用 Skills

Skills 由 Claude 自動調用，無需手動觸發：

```bash
# Claude 會自動使用 pdf-processor Skill
> Can you extract the data from this PDF file?

# 或明確請求
> Use the PDF processor Skill to analyze document.pdf
```

### Skills vs 斜線命令 vs 子代理

| 特性         | Skills        | 斜線命令 | 子代理         |
| ------------ | ------------- | -------- | -------------- |
| **調用方式** | 模型自動      | 手動輸入 | 自動或手動     |
| **檔案結構** | 目錄+SKILL.md | 單一 .md | 單一 .md       |
| **複雜度**   | 中等到高      | 簡單     | 中等           |
| **工具限制** | 可配置        | 可配置   | 可配置         |
| **適用場景** | 複雜功能      | 快速提示 | 特定任務工作流 |

---

## 🔌 Plugin 外掛系統

### 什麼是 Plugins

Plugins（外掛程式）是可安裝的擴展包，可包含：

- 自訂斜線命令
- 專門的子代理
- Agent Skills
- Hooks 事件處理器
- MCP 伺服器整合

#### 核心優勢

- **📦 打包分發**：一次安裝獲得多個功能
- **🏪 市場系統**：從 Plugin Marketplace 輕鬆發現和安裝
- **👥 團隊協作**：透過 `.claude/settings.json` 自動安裝團隊外掛
- **🔄 版本管理**：支援版本控制和自動更新

### Plugin 管理

```bash
# 開啟 Plugin 管理介面
/plugin

# 新增 Marketplace
/plugin marketplace add your-org/claude-plugins

# 安裝 Plugin
/plugin install formatter@your-org

# 啟用/停用
/plugin enable plugin-name@marketplace
/plugin disable plugin-name@marketplace

# 移除
/plugin uninstall plugin-name@marketplace
```

### Plugin 結構

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # 外掛清單（必需）
├── commands/                 # 自訂斜線命令
│   └── custom.md
├── agents/                   # 子代理定義
│   └── reviewer.md
├── skills/                   # Agent Skills
│   └── my-skill/
│       └── SKILL.md
├── hooks/                    # 事件處理器
│   └── hooks.json
└── .mcp.json                # MCP 伺服器配置
```

### 團隊 Plugin 設定

在 `.claude/settings.json` 中配置自動安裝：

```json
{
  "extraKnownMarketplaces": {
    "company-tools": {
      "source": {
        "source": "github",
        "repo": "company/claude-plugins"
      }
    }
  },
  "enabledPlugins": {
    "formatter@company-tools": true,
    "deployer@company-tools": true
  }
}
```

當團隊成員信任專案資料夾時，外掛程式會自動安裝。

---

## 🛠️ 工具完整參考

### Claude Code 可用工具

Claude Code 擁有一套強大的工具集，幫助 Claude 理解和修改您的程式碼庫：

| 工具             | 描述                             | 需要權限 | 主要用途             |
| ---------------- | -------------------------------- | -------- | -------------------- |
| **Agent**        | 執行子代理處理複雜的多步驟任務   | 否       | 複雜任務分解         |
| **Bash**         | 在您的環境中執行 shell 命令      | 是       | 系統操作、建置、測試 |
| **Edit**         | 對特定檔案進行精準編輯           | 是       | 程式碼修改           |
| **Glob**         | 基於模式匹配尋找檔案             | 否       | 檔案搜尋             |
| **Grep**         | 在檔案內容中搜尋模式             | 否       | 內容搜尋             |
| **LS**           | 列出檔案和目錄                   | 否       | 目錄瀏覽             |
| **MultiEdit**    | 對單一檔案執行多個原子性編輯     | 是       | 批量修改             |
| **NotebookEdit** | 修改 Jupyter notebook 儲存格     | 是       | Notebook 編輯        |
| **NotebookRead** | 讀取並顯示 Jupyter notebook 內容 | 否       | Notebook 瀏覽        |
| **Read**         | 讀取檔案內容                     | 否       | 程式碼瀏覽           |
| **TodoRead**     | 讀取當前會話的任務清單           | 否       | 任務追蹤             |
| **TodoWrite**    | 建立和管理結構化任務清單         | 否       | 任務管理             |
| **WebFetch**     | 從指定 URL 獲取內容              | 是       | 網路內容獲取         |
| **WebSearch**    | 執行帶域名過濾的網路搜尋         | 是       | 資訊搜尋             |
| **Write**        | 建立或覆寫檔案                   | 是       | 檔案建立             |

### 工具詳細說明

#### 檔案操作工具

**Read 工具**

- **功能**：讀取檔案內容，支援指定行數範圍
- **語法**：`Read(檔案路徑)`
- **權限規則範例**：`"Read(src/**/*.ts)"` - 僅允許讀取 TypeScript 檔案

**Edit 工具**

- **功能**：對檔案進行精準的字串替換編輯
- **特色**：支援多行編輯、保持格式
- **權限規則範例**：`"Edit(src/**/*.{js,ts})"` - 僅允許編輯特定類型檔案

**Write 工具**

- **功能**：建立新檔案或完全覆寫現有檔案
- **安全考量**：具有覆寫風險，建議謹慎設定權限
- **權限規則範例**：`"Write(temp/**/*)"` - 僅允許在臨時目錄寫入

**MultiEdit 工具**

- **功能**：在單一檔案中執行多個編輯操作，確保原子性
- **優勢**：避免部分編輯導致的不一致狀態
- **使用場景**：大規模重構、批量變更

#### 搜尋與瀏覽工具

**Glob 工具**

- **功能**：使用萬用字元模式尋找檔案
- **模式範例**：
  - `*.js` - 所有 JavaScript 檔案
  - `src/**/*.test.ts` - 所有測試檔案
  - `{*.json,*.yaml}` - JSON 和 YAML 檔案

**Grep 工具**

- **功能**：在檔案內容中搜尋文字模式
- **支援功能**：
  - 正規表示式搜尋
  - 不區分大小寫搜尋
  - 行號顯示
- **使用範例**：搜尋 TODO 註解、函數定義、錯誤模式

**LS 工具**

- **功能**：列出目錄內容，類似 `ls` 命令
- **顯示資訊**：檔案大小、修改時間、權限
- **用途**：專案結構探索、檔案狀態檢查

#### 系統操作工具

**Bash 工具**

- **功能**：執行任意 shell 命令
- **安全特性**：
  - 可設定逾時
  - 支援權限細分控制
  - 輸出長度限制
- **權限控制範例**：
  ```json
  {
    "allow": ["Bash(git diff:*)", "Bash(npm run test:*)", "Bash(docker ps:*)"],
    "deny": ["Bash(rm:*)", "Bash(sudo:*)"]
  }
  ```

#### 任務管理工具

**TodoRead 工具**

- **功能**：讀取當前會話的結構化任務清單
- **資料格式**：JSON 結構，包含狀態、優先級、描述

**TodoWrite 工具**

- **功能**：建立、更新、管理任務清單
- **支援操作**：
  - 新增任務
  - 更新狀態
  - 設定優先級
  - 合併任務清單

#### 網路工具

**WebFetch 工具**

- **功能**：獲取指定 URL 的內容
- **支援格式**：HTML、JSON、文字
- **使用場景**：API 文檔查詢、程式碼範例獲取

**WebSearch 工具**

- **功能**：執行網路搜尋並返回結果
- **特色**：支援域名過濾，提高結果相關性
- **用途**：技術問題搜尋、最佳實踐查詢

#### Jupyter Notebook 工具

**NotebookRead 工具**

- **功能**：讀取並解析 Jupyter notebook 檔案
- **顯示內容**：程式碼儲存格、Markdown 儲存格、輸出結果

**NotebookEdit 工具**

- **功能**：修改 notebook 儲存格內容
- **支援操作**：
  - 編輯儲存格程式碼
  - 新增/刪除儲存格
  - 修改儲存格類型

#### 代理工具

**Agent 工具**

- **功能**：啟動子代理執行複雜任務
- **應用場景**：
  - 多檔案協調修改
  - 複雜演算法實作
  - 端到端功能開發
- **特色**：
  - 獨立的上下文空間
  - 可並行執行
  - 結果可合併到主會話

### 權限控制進階設定

#### 模式匹配語法

```json
{
  "permissions": {
    "allow": [
      "Read", // 允許所有讀取操作
      "Edit(src/**/*.{js,ts})", // 僅允許編輯特定檔案
      "Bash(git *)", // 允許所有 git 命令
      "Bash(npm run test:*)", // 允許執行測試腳本
      "WebFetch(https://docs.*)" // 僅允許獲取文檔網站內容
    ],
    "deny": [
      "Bash(rm:*)", // 禁止刪除命令
      "Bash(sudo:*)", // 禁止 sudo 命令
      "Write(.env*)", // 禁止修改環境變數檔案
      "Edit(package.json)" // 禁止修改套件設定
    ]
  }
}
```

#### 工作目錄控制

```json
{
  "permissions": {
    "additionalDirectories": [
      "../shared-lib/", // 允許存取共享程式庫
      "../docs/", // 允許存取文檔目錄
      "~/templates/" // 允許存取範本目錄
    ]
  }
}
```

---

## 🎯 工作流程大全

### 基礎開發流程

#### 專案初始化

```bash
# 啟動 Claude Code
claude

# 初始化專案記憶
/init

# 設定權限
/permissions allow "Edit" "View" "Bash(git:*)"

# 開始開發
claude "分析這個專案並建議改進"
```

#### 探索、規劃、編碼、提交

```bash
# 1. 探索階段
claude "請讀取相關檔案，了解專案結構，但先不要寫程式碼"

# 2. 規劃階段
claude "請制定解決這個問題的計劃，使用 think 進行深度思考"

# 3. 實作階段
claude "請實作解決方案"

# 4. 提交階段
claude "請提交變更並建立 pull request"
```

### 測試驅動開發

```bash
# 1. 撰寫測試
claude "基於預期輸入輸出撰寫測試，不要建立 mock 實作"

# 2. 確認測試失敗
claude "執行測試並確認失敗，請不要寫實作程式碼"

# 3. 提交測試
claude "提交測試程式碼"

# 4. 實作功能
claude "撰寫通過測試的程式碼，不要修改測試"

# 5. 提交程式碼
claude "提交實作程式碼"
```

### MCP 整合開發

```bash
# 設定 MCP 伺服器
claude mcp add weather-api ./weather-server.js
claude mcp add database --transport http https://api.example.com

# 使用 MCP 工具
claude --allowedTools "mcp__weather__get_forecast" "查詢明天天氣"
```

### 安全 YOLO 模式

```bash
# 在容器中使用（建議）
claude --dangerously-skip-permissions "修復所有 lint 錯誤"
```

**⚠️ 警告**：建議僅在隔離環境中使用，該指令可能導致資料遺失或系統損壞。

---

## 🔧 進階功能

### CLAUDE.md 專案記憶

#### 建立與管理

```bash
# 初始化專案記憶
/init

# 檢視記憶內容
/memory view

# 編輯記憶
/memory edit

# 清除記憶
/memory clear
```

#### CLAUDE.md 範例

```markdown
# 專案記憶

## Bash 指令

- npm run build: 建置專案
- npm run test: 執行測試
- npm run lint: 程式碼檢查

## 程式碼風格

- 使用 ES modules (import/export)
- 優先使用解構賦值
- 遵循 TypeScript strict 模式

## 工作流程

- 完成變更後務必執行 typecheck
- 優先執行單一測試而非整個測試套件
- 使用 Git Flow 分支策略
```

### 模型控制

#### 可用模型

```bash
# 查看可用模型
/model list

# 使用別名
claude --model sonnet
claude --model opus

# 使用完整型號（含日期標籤）
claude --model claude-sonnet-4-20250514
```

#### 當前支援模型

- **Claude Opus 4**：最強大的推理模型
- **Claude 4 Sonnet**：最新混合推理模型
- **Claude 3.7 Sonnet**：快速混合推理模型

### 權限管理

#### 權限模式

```bash
# 計劃模式（推薦）
claude --permission-mode plan

# 總是詢問模式
claude --permission-mode always-ask
```

#### 工具權限

```bash
# 允許特定工具
claude --allowedTools "Edit" "View" "Bash(git:*)"

# 禁用危險工具
claude --disallowedTools "Bash(rm:*)" "Bash(sudo:*)"

# 精細權限控制
claude --allowedTools "Bash(git log:*)" "Bash(git diff:*)" "Read"
```

### 會話管理

#### 會話操作

```bash
# 繼續最近對話
claude -c

# 恢復特定會話
claude -r "abc123" "繼續這個功能開發"

# 壓縮對話歷史
/compact "保留重要討論"

# 清除歷史
/clear
```

### 檢查點與回退系統

#### 自動追蹤編輯

Claude Code 會在每次編輯前自動捕獲程式碼狀態，讓您可以快速撤銷不需要的變更：

- **自動檢查點**：每個使用者提示建立新檢查點
- **跨會話持續**：檢查點在會話間保留（30 天）
- **選擇性恢復**：可分別恢復程式碼或對話

#### 回退操作

```bash
# 開啟回退選單
按兩次 Esc（Esc + Esc）
# 或使用指令
/rewind
```

**回退選項**：

1. **僅對話**：回退對話但保留程式碼變更
2. **僅程式碼**：還原檔案變更但保留對話
3. **程式碼和對話**：兩者都恢復到先前時間點

#### 限制說明

**不追蹤的變更**：

- Bash 指令修改的檔案（如 `rm`、`mv`、`cp`）
- Claude Code 外部的手動變更
- 其他並行會話的編輯

**最佳實踐**：

- 檢查點補充但不取代 Git 版本控制
- 將檢查點視為「本地撤銷」
- 將 Git 視為「永久歷史」

### 沙箱隔離系統

#### 什麼是沙箱

沙箱隔離提供作業系統層級的安全邊界，限制 bash 命令的檔案系統和網路存取：

**核心功能**：

- **檔案系統隔離**：限制寫入存取特定目錄
- **網路隔離**：僅允許存取批准的域名
- **減少提示**：沙箱內的安全命令自動批准
- **提升安全性**：防止提示注入和惡意操作

#### 啟用沙箱

```bash
# 在會話中啟用
/sandbox

# 配置檔案啟用（.claude/settings.json）
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "excludedCommands": ["docker", "git"],
    "network": {
      "allowUnixSockets": ["~/.ssh/agent-socket"],
      "allowLocalBinding": true
    }
  }
}
```

#### 安全優勢

**防止提示注入**：

- 無法修改系統檔案（如 `~/.bashrc`、`/bin/`）
- 無法洩露資料到未授權伺服器
- 無法下載惡意指令碼
- 所有違規嘗試在作業系統層級被阻止

**攻擊面減少**：

- 限制惡意依賴項的影響
- 防止被破壞的建置指令碼
- 阻止社交工程攻擊

#### 作業系統支援

- **Linux**：使用 [bubblewrap](https://github.com/containers/bubblewrap)
- **macOS**：使用 Seatbelt 沙箱
- **Windows**：計劃中

---

## 🪝 Hooks 功能（進階自動化）

### 什麼是 Hooks

Claude Code Hooks 是使用者定義的 shell 命令，在 Claude Code 生命週期的各個時點自動執行。Hooks 提供對 Claude Code 行為的確定性控制，確保某些動作總是會發生，而不是依賴 LLM 選擇執行它們。

#### 主要優勢

- **確定性控制**：將建議轉換為應用程式層級的程式碼，每次預期執行時都會執行
- **自動化工作流程**：無需手動干預即可執行重複任務
- **整合外部工具**：輕鬆整合現有的開發工具和腳本
- **提升安全性**：可攔截危險操作，實施安全策略

#### 常見使用案例

| 用途           | 範例                                                | Hook 事件              |
| -------------- | --------------------------------------------------- | ---------------------- |
| **自動格式化** | 對 .ts 檔案執行 `prettier`，對 .go 檔案執行 `gofmt` | PostToolUse            |
| **安全控制**   | 阻止對生產檔案或敏感目錄的修改                      | PreToolUse             |
| **通知系統**   | 自訂當 Claude Code 等待輸入時的通知方式             | Notification           |
| **記錄追蹤**   | 追蹤和計算所有執行的命令以符合合規性                | PreToolUse/PostToolUse |
| **程式碼回饋** | 當程式碼不符合規範時提供自動回饋                    | PostToolUse            |

### Hook 生命週期事件

| 事件               | 觸發時機                  | 常見用途                           |
| ------------------ | ------------------------- | ---------------------------------- |
| `PreToolUse`       | 工具執行前                | 權限判斷、程式碼靜態分析、安全檢查 |
| `PostToolUse`      | 工具成功後                | 自動格式化、日誌記錄、程式碼驗證   |
| `Notification`     | Claude Code 發送通知時    | 桌面提醒、Slack 通知               |
| `UserPromptSubmit` | 使用者送出 prompt 時      | 敏感詞過濾、內容檢查               |
| `Stop`             | 主代理回應完畢時          | 連續工作流、觸發次級任務           |
| `SubagentStop`     | 子代理回應完畢時          | 子任務完成處理                     |
| `PreCompact`       | Claude 執行 `/compact` 前 | 追加自訂摘要規則                   |
| `SessionStart`     | 會話開始或恢復時          | 載入開發內容、設定環境變數         |
| `SessionEnd`       | 會話結束時                | 清理工作、記錄會話統計             |

### 配置方式

#### 互動式配置

```bash
# 在 REPL 中
claude
/hooks

# 選擇事件類型 → 新增匹配器 → 新增 hook 命令
```

#### JSON 設定檔配置

**設定檔位置**：

- `~/.claude/settings.json`（全域設定）
- `.claude/settings.json`（專案設定，納入版控）
- `.claude/settings.local.json`（本地設定，不進版控）

**基本結構**：

```json
{
  "hooks": {
    "事件名稱": [
      {
        "matcher": "工具模式",
        "hooks": [
          {
            "type": "command",
            "command": "要執行的命令",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

#### Matcher 語法規則

| 類型           | 語法         | 範例                  | 說明               |
| -------------- | ------------ | --------------------- | ------------------ |
| **精確匹配**   | 字串         | `"Edit"`              | 僅匹配 Edit 工具   |
| **正規表示式** | 模式         | `"Edit\|Write"`       | 匹配 Edit 或 Write |
| **萬用匹配**   | 空字串或省略 | `""`                  | 匹配所有工具       |
| **MCP 工具**   | 模式         | `"mcp__server__tool"` | 匹配特定 MCP 工具  |

### Hook 輸入輸出機制

#### 輸入格式

Hook 透過 stdin 接收 JSON 格式的事件資料：

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "hook_event_name": "PreToolUse",
  "cwd": "/current/working/directory",
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "/path/to/file.txt",
    "content": "檔案內容"
  }
}
```

#### 輸出控制機制

##### 簡單：退出代碼

| 代碼     | 效果       | 行為說明                                 |
| -------- | ---------- | ---------------------------------------- |
| **0**    | 成功       | `stdout` 不給 Claude；內容只在記錄中可見 |
| **2**    | 阻擋錯誤   | `stderr` 回饋 Claude，阻擋或修改後續行為 |
| **其他** | 非阻擋錯誤 | 顯示錯誤訊息，流程照常進行               |

##### 進階：JSON 輸出

```json
{
  "decision": "block|approve",
  "continue": false,
  "reason": "決策說明",
  "suppressOutput": true
}
```

### 實戰範例

#### 自動程式碼格式化

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "if [[ \"$FILE\" =~ \\.(ts|js|tsx|jsx)$ ]]; then npx prettier --write \"$FILE\"; fi",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

#### 敏感檔案保護

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "python3 ~/.claude/scripts/check-sensitive-files.py",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

**保護腳本範例**：

```python
#!/usr/bin/env python3
import json
import sys

# 讀取 hook 輸入
input_data = json.load(sys.stdin)
file_path = input_data.get("tool_input", {}).get("file_path", "")

# 敏感檔案檢查
sensitive_patterns = [".env", ".key", ".pem", "secrets/"]

for pattern in sensitive_patterns:
    if pattern in file_path:
        print(f"禁止修改敏感檔案: {file_path}", file=sys.stderr)
        sys.exit(2)  # 阻擋操作

sys.exit(0)  # 允許操作
```

#### 自動桌面通知

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "notify-send 'Claude Code' \"$(echo '$INPUT' | jq -r '.message')\""
          }
        ]
      }
    ]
  }
}
```

#### MCP 工具整合

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__github__.*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'GitHub API 操作記錄' >> ~/github-operations.log"
          }
        ]
      }
    ]
  }
}
```

### 安全考量

#### ⚠️ 重要免責聲明

**使用風險自負**：Claude Code hooks 會在您的系統上自動執行任意 shell 命令。使用前請確認：

- 您對設定的命令負全責
- Hooks 可存取您帳戶能存取的任何檔案
- 惡意或錯誤的 hooks 可能導致資料遺失
- Anthropic 不對因使用 hook 導致的損壞承擔責任

#### 安全最佳實踐

1. **輸入驗證**：永遠驗證和清理輸入資料
2. **引號保護**：使用 `"$VAR"` 而不是 `$VAR`
3. **路徑檢查**：阻止路徑遍歷攻擊 (`..`)
4. **絕對路徑**：為腳本指定完整路徑
5. **敏感檔案**：避免處理 `.env`、`.git/`、金鑰等

#### 設定安全機制

- 啟動時擷取 hooks 快照，整個會話使用此快照
- 外部修改 hooks 時會警告
- 需要在 `/hooks` 選單中檢閱才能應用變更

### 除錯與監控

#### 除錯步驟

1. 檢查 `/hooks` 選單顯示的設定
2. 驗證 JSON 格式正確性
3. 手動測試命令
4. 檢查退出代碼和輸出格式
5. 使用 `claude --debug` 查看詳細執行資訊

#### 監控輸出

```bash
# 啟用除錯模式
claude --debug

# 成功 hook 輸出範例：
[DEBUG] Executing hooks for PostToolUse:Write
[DEBUG] Found 1 hook commands to execute
[DEBUG] Hook command completed with status 0
```

#### 記錄模式檢視

按 `Ctrl-R` 進入記錄模式，可檢視：

- Hook 執行狀況
- 命令輸出
- 成功/失敗狀態
- 錯誤訊息

---

## 🔒 安全控制

### 憲政 AI 框架

Claude Code 整合了多層安全機制：

1. **憲政 AI**：內建倫理規範指導模型行為
2. **RLHF**：基於人類回饋的強化學習
3. **紅隊測試**：主動攻擊測試安全性
4. **即時監控**：異常行為模式檢測

### 安全最佳實踐

```bash
# 生產環境安全設定
claude --allowedTools "Edit" "View" --permission-mode always-ask

# 敏感操作避免跳過權限
# 避免：claude --dangerously-skip-permissions

# 定期檢查權限設定
/permissions view

# 使用計劃模式進行複雜操作
claude --permission-mode plan "重構整個模組"
```

### 企業安全控制

```bash
# 限制工具存取
echo '{
  "allowedTools": ["Edit", "View", "Bash(git:*)"],
  "disallowedTools": ["Bash(rm:*)", "Bash(sudo:*)"]
}' > .claude/settings.json

# 設定最大回合數
claude --max-turns 5 --permission-mode always-ask
```

---

## ⚙️ 設定檔案與環境變數

### 設定檔案層級

Claude Code 支援分層設定系統，按優先順序排列：

1. **企業管理政策**（最高優先級）
2. **命令列參數**
3. **本地專案設定**
4. **共享專案設定**
5. **使用者設定**（最低優先級）

#### 設定檔案位置

| 檔案           | 位置                          | 用途                     | 版本控制   |
| -------------- | ----------------------------- | ------------------------ | ---------- |
| **使用者設定** | `~/.claude/settings.json`     | 全域設定，適用於所有專案 | 不納入     |
| **專案設定**   | `.claude/settings.json`       | 專案共享設定，團隊使用   | 納入版控   |
| **本地設定**   | `.claude/settings.local.json` | 個人實驗設定，不共享     | 自動忽略   |
| **企業政策**   | 平台特定位置                  | 管理員強制設定           | 管理員控制 |

#### 企業管理政策位置

| 平台          | 路徑                                                            |
| ------------- | --------------------------------------------------------------- |
| **macOS**     | `/Library/Application Support/ClaudeCode/managed-settings.json` |
| **Linux/WSL** | `/etc/claude-code/managed-settings.json`                        |
| **Windows**   | `C:\ProgramData\ClaudeCode\managed-settings.json`               |

### 設定選項詳細說明

#### 基本設定

| 選項                  | 類型    | 預設值      | 說明                       | 範例                           |
| --------------------- | ------- | ----------- | -------------------------- | ------------------------------ |
| `model`               | string  | 最新 Sonnet | 指定預設模型               | `"claude-3-5-sonnet-20241022"` |
| `cleanupPeriodDays`   | number  | 30          | 對話記錄保留天數           | `20`                           |
| `includeCoAuthoredBy` | boolean | true        | Git 提交中包含 Claude 署名 | `false`                        |

#### 認證設定

| 選項               | 說明                  | 範例                              |
| ------------------ | --------------------- | --------------------------------- |
| `apiKeyHelper`     | 動態 API 金鑰生成腳本 | `"/bin/generate_temp_api_key.sh"` |
| `forceLoginMethod` | 強制特定登入方式      | `"claudeai"` 或 `"console"`       |

#### MCP 伺服器設定

| 選項                         | 說明                        | 範例                   |
| ---------------------------- | --------------------------- | ---------------------- |
| `enableAllProjectMcpServers` | 自動批准所有專案 MCP 伺服器 | `true`                 |
| `enabledMcpjsonServers`      | 批准特定 MCP 伺服器清單     | `["memory", "github"]` |
| `disabledMcpjsonServers`     | 拒絕特定 MCP 伺服器清單     | `["filesystem"]`       |

#### 權限設定結構

```json
{
  "permissions": {
    "allow": ["Bash(npm run lint)", "Bash(npm run test:*)", "Read(~/.zshrc)"],
    "deny": ["Bash(curl:*)", "WebFetch"],
    "additionalDirectories": ["../docs/", "../shared-lib/"],
    "defaultMode": "acceptEdits",
    "disableBypassPermissionsMode": "disable"
  }
}
```

#### 完整設定範例

```json
{
  "model": "claude-3-5-sonnet-20241022",
  "cleanupPeriodDays": 20,
  "includeCoAuthoredBy": false,
  "forceLoginMethod": "console",
  "enableAllProjectMcpServers": false,
  "enabledMcpjsonServers": ["memory", "github"],
  "permissions": {
    "allow": ["Bash(npm run lint)", "Bash(git diff:*)"],
    "deny": ["WebFetch", "Bash(curl:*)"],
    "defaultMode": "acceptEdits"
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_METRICS_EXPORTER": "otlp"
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx prettier --write \"$FILE\"",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### 環境變數參考

#### 核心認證變數

| 變數                       | 用途                        | 範例                   |
| -------------------------- | --------------------------- | ---------------------- |
| `ANTHROPIC_API_KEY`        | API 金鑰（X-Api-Key 標頭）  | `sk-ant-apiXX-XXXXXXX` |
| `ANTHROPIC_AUTH_TOKEN`     | 自訂認證令牌（Bearer 前綴） | `sk-custom-token`      |
| `ANTHROPIC_CUSTOM_HEADERS` | 自訂請求標頭                | `"X-Custom: value"`    |

#### 模型設定變數

| 變數                            | 用途                  | 範例                        |
| ------------------------------- | --------------------- | --------------------------- |
| `ANTHROPIC_MODEL`               | 自訂模型名稱          | `claude-opus-4-20250514`    |
| `ANTHROPIC_SMALL_FAST_MODEL`    | 背景任務用 Haiku 模型 | `claude-3-5-haiku-20241022` |
| `CLAUDE_CODE_MAX_OUTPUT_TOKENS` | 最大輸出令牌數        | `8192`                      |
| `MAX_THINKING_TOKENS`           | 思考模式令牌預算      | `1024`                      |

#### 第三方平台變數

| 變數                            | 用途                  | 範例        |
| ------------------------------- | --------------------- | ----------- |
| `CLAUDE_CODE_USE_BEDROCK`       | 啟用 AWS Bedrock      | `1`         |
| `CLAUDE_CODE_USE_VERTEX`        | 啟用 Google Vertex AI | `1`         |
| `CLAUDE_CODE_SKIP_BEDROCK_AUTH` | 跳過 Bedrock 認證     | `1`         |
| `CLAUDE_CODE_SKIP_VERTEX_AUTH`  | 跳過 Vertex 認證      | `1`         |
| `AWS_REGION`                    | AWS 區域              | `us-east-1` |
| `CLOUD_ML_REGION`               | Google Cloud 區域     | `us-east5`  |

#### Bash 工具控制變數

| 變數                                       | 用途              | 預設值 | 範例     |
| ------------------------------------------ | ----------------- | ------ | -------- |
| `BASH_DEFAULT_TIMEOUT_MS`                  | Bash 命令預設逾時 | 30000  | `60000`  |
| `BASH_MAX_TIMEOUT_MS`                      | Bash 命令最大逾時 | 300000 | `600000` |
| `BASH_MAX_OUTPUT_LENGTH`                   | Bash 輸出最大長度 | 100000 | `200000` |
| `CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR` | 維持專案工作目錄  | false  | `1`      |

#### MCP 設定變數

| 變數                    | 用途                   | 預設值 | 範例     |
| ----------------------- | ---------------------- | ------ | -------- |
| `MCP_TIMEOUT`           | MCP 伺服器啟動逾時     | 30000  | `60000`  |
| `MCP_TOOL_TIMEOUT`      | MCP 工具執行逾時       | 60000  | `120000` |
| `MAX_MCP_OUTPUT_TOKENS` | MCP 工具回應最大令牌數 | 25000  | `50000`  |

#### 系統行為控制變數

| 變數                                       | 用途               | 效果             |
| ------------------------------------------ | ------------------ | ---------------- |
| `DISABLE_AUTOUPDATER`                      | 停用自動更新       | 設為 `1` 停用    |
| `DISABLE_BUG_COMMAND`                      | 停用 `/bug` 命令   | 設為 `1` 停用    |
| `DISABLE_COST_WARNINGS`                    | 停用成本警告       | 設為 `1` 停用    |
| `DISABLE_ERROR_REPORTING`                  | 停用錯誤回報       | 設為 `1` 停用    |
| `DISABLE_TELEMETRY`                        | 停用遙測           | 設為 `1` 停用    |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | 停用非必要網路流量 | 等同上述四個變數 |

#### 代理設定變數

| 變數                  | 用途                 | 範例                              |
| --------------------- | -------------------- | --------------------------------- |
| `HTTP_PROXY`          | HTTP 代理伺服器      | `http://proxy.company.com:8080`   |
| `HTTPS_PROXY`         | HTTPS 代理伺服器     | `https://proxy.company.com:8080`  |
| `SSL_CERT_FILE`       | SSL 憑證檔案路徑     | `/path/to/certificate-bundle.crt` |
| `NODE_EXTRA_CA_CERTS` | Node.js 額外 CA 憑證 | `/path/to/certificate-bundle.crt` |

### 設定管理命令

```bash
# 檢視設定
claude config list                    # 列出所有設定
claude config get <key>               # 查看特定設定值

# 修改設定
claude config set <key> <value>       # 設定值
claude config add <key> <value>       # 新增到清單
claude config remove <key> <value>    # 從清單移除

# 全域設定（加 -g 或 --global）
claude config set -g theme dark       # 設定全域主題
claude config list -g                 # 列出全域設定
```

#### 全域設定選項

| 選項                    | 說明         | 可用值                                                 | 預設值   |
| ----------------------- | ------------ | ------------------------------------------------------ | -------- |
| `autoUpdates`           | 自動更新開關 | `true`/`false`                                         | `true`   |
| `preferredNotifChannel` | 通知方式     | `iterm2`, `terminal_bell`, `notifications_disabled`    | `iterm2` |
| `theme`                 | 主題         | `dark`, `light`, `light-daltonized`, `dark-daltonized` | `dark`   |
| `verbose`               | 詳細輸出     | `true`/`false`                                         | `false`  |

---

## 🏢 企業部署

### DevContainer 整合

#### .devcontainer/devcontainer.json 範例

```json
{
  "name": "Claude Code Development",
  "image": "mcr.microsoft.com/devcontainers/typescript-node:18",
  "features": {
    "ghcr.io/devcontainers/features/git:1": {}
  },
  "postCreateCommand": "npm install -g @anthropic-ai/claude-code",
  "customizations": {
    "vscode": {
      "extensions": ["anthropic.claude-code"]
    }
  }
}
```

### CI/CD 整合

#### GitHub Actions 範例

```yaml
name: Claude Code Quality Check
on: [push, pull_request]

jobs:
  claude-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: "20"
      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code
      - name: Health Check
        run: claude doctor --json
      - name: Code Review
        run: claude -p "請審查這個 PR 的變更" --output-format json
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

### 企業級監控與遙測

#### OpenTelemetry 監控設定

Claude Code 支援完整的 OpenTelemetry 監控，提供指標、日誌和追蹤功能：

**基本啟用**：

```bash
# 啟用遙測
export CLAUDE_CODE_ENABLE_TELEMETRY=1

# 設定 OTLP 匯出器
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
```

**進階設定範例**：

```bash
# 完整監控設定
export CLAUDE_CODE_ENABLE_TELEMETRY=1

# 多重匯出器
export OTEL_METRICS_EXPORTER=console,otlp,prometheus
export OTEL_LOGS_EXPORTER=console,otlp

# 不同協定設定
export OTEL_EXPORTER_OTLP_METRICS_PROTOCOL=http/protobuf
export OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://metrics.company.com:4318
export OTEL_EXPORTER_OTLP_LOGS_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=http://logs.company.com:4317

# 認證設定
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer company-token"

# 除錯用快速匯出
export OTEL_METRIC_EXPORT_INTERVAL=10000  # 10 秒
export OTEL_LOGS_EXPORT_INTERVAL=5000     # 5 秒
```

#### 監控指標類型

| 指標類別     | 描述                 | 範例指標                 |
| ------------ | -------------------- | ------------------------ |
| **使用統計** | 使用者活動和會話資訊 | 活躍使用者、會話時長     |
| **模型呼叫** | API 呼叫和令牌使用   | 請求次數、令牌消耗、延遲 |
| **工具使用** | 工具執行統計         | 工具呼叫頻率、執行時間   |
| **錯誤追蹤** | 錯誤和例外監控       | 錯誤率、錯誤類型分佈     |
| **效能指標** | 系統效能監控         | 回應時間、記憶體使用     |

#### 企業監控最佳實踐

**1. 集中化監控**：

```json
{
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_METRICS_EXPORTER": "otlp",
    "OTEL_LOGS_EXPORTER": "otlp",
    "OTEL_EXPORTER_OTLP_PROTOCOL": "grpc",
    "OTEL_EXPORTER_OTLP_ENDPOINT": "http://collector.company.com:4317",
    "OTEL_EXPORTER_OTLP_HEADERS": "Authorization=Bearer company-token"
  }
}
```

**2. 資料隱私保護**：

```bash
# 停用使用者提示內容記錄（預設已停用）
# export OTEL_LOG_USER_PROMPTS=1  # 僅在需要時啟用

# 停用非必要遙測
export DISABLE_TELEMETRY=1  # 完全停用 Statsig 遙測
```

**3. 效能監控設定**：

```bash
# 監控設定
claude doctor --json          # 系統健康檢查（JSON 格式）
/cost                         # 成本追蹤和分析
/status                       # 即時狀態監控
claude --debug               # 詳細除錯資訊
```

#### 監控儀表板範例指標

**關鍵效能指標（KPI）**：

- **使用者採用率**：活躍使用者 / 授權使用者
- **生產力指標**：每日完成任務數、程式碼行數變更
- **品質指標**：錯誤率、重試次數
- **成本效益**：每任務成本、ROI 分析

**技術指標**：

- **API 效能**：平均回應時間、P95 延遲、錯誤率
- **資源使用**：令牌消耗率、頻寬使用、儲存空間
- **工具效能**：各工具平均執行時間、成功率

#### 告警設定建議

```yaml
alerts:
  high_token_usage:
    condition: "token_usage_per_hour > 10000"
    action: "notify_admin"

  high_error_rate:
    condition: "error_rate > 5%"
    action: "escalate_to_engineering"

  slow_response:
    condition: "avg_response_time > 30s"
    action: "check_infrastructure"

  security_violations:
    condition: "permission_denials > threshold"
    action: "security_review"
```

---

## 🔗 第三方整合與 LLM Gateway

### LLM Gateway 整合

LLM Gateway 提供統一的 API 端點，簡化多個 LLM 提供商的管理：

#### LiteLLM 整合設定

**基本設定**：

```bash
# 使用 LiteLLM 統一端點
export ANTHROPIC_BASE_URL=https://litellm-server:4000

# 使用靜態 API 金鑰
export ANTHROPIC_AUTH_TOKEN=sk-litellm-static-key
```

**動態金鑰管理**：

```json
{
  "apiKeyHelper": "~/bin/get-litellm-key.sh",
  "env": {
    "CLAUDE_CODE_API_KEY_HELPER_TTL_MS": "3600000"
  }
}
```

**金鑰獲取腳本範例**：

```bash
#!/bin/bash
# ~/bin/get-litellm-key.sh
curl -s -X POST "https://auth.company.com/api/token" \
  -H "Authorization: Bearer $COMPANY_API_KEY" \
  -d '{"service": "litellm"}' | jq -r '.access_token'
```

#### AWS Bedrock 整合

**基本設定**：

```bash
# 啟用 Bedrock
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1

# 使用特定模型
export ANTHROPIC_MODEL='us.anthropic.claude-opus-4-20250514-v1:0'
export ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0'
```

**透過 LLM Gateway 使用 Bedrock**：

```bash
export ANTHROPIC_BEDROCK_BASE_URL=https://litellm-server:4000/bedrock
export CLAUDE_CODE_SKIP_BEDROCK_AUTH=1
export CLAUDE_CODE_USE_BEDROCK=1
```

**AWS SSO 設定**：

```bash
# 登入 AWS SSO
aws sso login --profile=your-profile-name
export AWS_PROFILE=your-profile-name
```

#### Google Vertex AI 整合

**基本設定**：

```bash
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_VERTEX_PROJECT_ID=your-project-id

# 可選：停用提示快取（如果未啟用）
export DISABLE_PROMPT_CACHING=1
```

**透過 LLM Gateway 使用 Vertex AI**：

```bash
# 客戶端認證
gcloud auth application-default login
export ANTHROPIC_VERTEX_BASE_URL=https://litellm-server:4000/vertex_ai/v1
export ANTHROPIC_VERTEX_PROJECT_ID=your-gcp-project-id
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5

# 或代理認證
export CLAUDE_CODE_SKIP_VERTEX_AUTH=1
```

### GitHub Actions 整合

#### 基本工作流程

```yaml
name: Claude Code AI Assistant
on: [push, pull_request]

jobs:
  claude-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: AI Code Review
        run: |
          claude -p "請審查這個 PR 的變更，關注安全性和效能" \
            --output-format json \
            --max-turns 1
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

#### 使用 Vertex AI 的 GitHub Actions

```yaml
name: Claude Code with Vertex AI
on: [push, pull_request]

jobs:
  claude-vertex-review:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Authenticate to Google Cloud
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: ${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
          service_account: ${{ secrets.GCP_SERVICE_ACCOUNT }}

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: AI Review with Vertex AI
        run: |
          claude -p "分析程式碼品質並提供改進建議" \
            --output-format json
        env:
          CLAUDE_CODE_USE_VERTEX: "1"
          CLOUD_ML_REGION: "us-east5"
          ANTHROPIC_VERTEX_PROJECT_ID: ${{ secrets.GCP_PROJECT_ID }}
```

#### 快速 GitHub App 設定

```bash
# 在 Claude Code 中執行
/install-github-app

# 會自動開啟瀏覽器並引導您完成：
# 1. GitHub App 建立
# 2. 權限設定
# 3. 安裝到倉庫
# 4. 密鑰設定
```

### 企業代理設定

#### 基本 HTTP/HTTPS 代理

```bash
# HTTPS 代理（推薦）
export HTTPS_PROXY=https://proxy.example.com:8080

# HTTP 代理（如果 HTTPS 不可用）
export HTTP_PROXY=http://proxy.example.com:8080

# 帶認證的代理
export HTTPS_PROXY=http://username:password@proxy.example.com:8080
```

#### 自訂 SSL 憑證

```bash
# 設定自訂憑證路徑
export SSL_CERT_FILE=/path/to/certificate-bundle.crt
export NODE_EXTRA_CA_CERTS=/path/to/certificate-bundle.crt
```

#### 企業代理 + Bedrock 設定

```bash
# 完整企業設定
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1
export HTTPS_PROXY='https://proxy.example.com:8080'
export SSL_CERT_FILE='/etc/ssl/certs/company-ca-bundle.crt'
export NODE_EXTRA_CA_CERTS='/etc/ssl/certs/company-ca-bundle.crt'
```

### SDK 整合

#### Python SDK 使用

```python
from claude_code_sdk import query, ClaudeCodeOptions
from pathlib import Path

# 基本設定
options = ClaudeCodeOptions(
    max_turns=3,
    system_prompt="你是一位資深軟體架構師",
    cwd=Path("/path/to/project"),
    allowed_tools=["Read", "Write", "Bash"],
    permission_mode="acceptEdits"
)

# 執行查詢
async for message in query(prompt="分析這個專案的架構", options=options):
    print(message)
```

#### MCP 伺服器設定

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/files"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "your-github-token"
      }
    }
  }
}
```

#### CLI 與 MCP 整合

```bash
# 載入 MCP 伺服器設定
claude -p "列出專案中的所有檔案" --mcp-config mcp-servers.json

# 明確允許 MCP 工具
claude -p "搜尋 TODO 註解" \
  --mcp-config mcp-servers.json \
  --allowedTools "mcp__filesystem__read_file,mcp__filesystem__list_directory"

# 使用 MCP 工具處理權限提示
claude -p "部署應用程式" \
  --mcp-config mcp-servers.json \
  --allowedTools "mcp__permissions__approve" \
  --permission-prompt-tool mcp__permissions__approve
```

#### 提示中引用 MCP 資源

在互動或 print 模式中，可直接以 `@server:protocol://path` 引用 MCP 資源，例如：

```bash
claude -p "請閱讀 @drive:https://docs.example.com/path/to/doc 並摘要重點"
```

### 除錯與監控

#### 除錯設定

```bash
# 啟用詳細除錯
export ANTHROPIC_LOG=debug
claude --debug

# 檢查系統狀態
claude /status
claude doctor --json
```

#### 效能監控

```bash
# 企業監控設定
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://collector.company.com:4317
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer company-token"
```

---

## 🔧 疑難排解

### 常見問題分類

#### 安裝相關

**Node.js 版本問題**

```bash
# 檢查版本
node --version

# 升級到 LTS
nvm install --lts
nvm use --lts
```

**權限問題**

```bash
# 避免 sudo，使用官方解決方案
claude migrate-installer

# 或設定 npm 前綴
npm config set prefix ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
```

#### 認證相關

**API Key 問題**

```bash
# 設定環境變數
export ANTHROPIC_API_KEY="sk-ant-apiXX-XXXXXXX"

# 測試連線
claude -p "Hello" --verbose
```

**登入問題**

```bash
# 重新登入
/logout
/login

# 清除認證快取
rm -rf ~/.claude/auth
```

#### 執行相關

**權限被拒**

```bash
# 檢查權限設定
/permissions view

# 允許特定工具
/permissions allow Edit
```

**會話問題**

```bash
# 清除並重啟
/clear
claude
```

### 診斷工具

```bash
# 完整系統診斷
claude doctor

# 詳細輸出模式
claude --verbose -p "測試查詢"

# 檢查環境
echo $ANTHROPIC_API_KEY
which claude
```

---

## 📚 官方資源

### 主要文檔

- [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
- [CLI 參考文檔](https://docs.anthropic.com/en/docs/claude-code/cli-reference)
- [GitHub 官方倉庫](https://github.com/anthropics/claude-code)

### 本地鏡像索引（繁中）

- [docs/anthropic-claude-code-zh-tw/README.md](docs/anthropic-claude-code-zh-tw/README.md) — Anthropic 官方文檔（繁中）本地鏡像索引
  > 來源: https://docs.anthropic.com/zh-TW/docs/claude-code/overview · 抓取時間: 2025-10-29T14:12:31+08:00

### 學習資源

- [快速入門指南](https://docs.anthropic.com/en/docs/claude-code/quickstart)
- [常見工作流程](https://docs.anthropic.com/en/docs/claude-code/common-workflows)
- [最佳實踐指南](https://www.anthropic.com/engineering/claude-code-best-practices)

### 社群支援

- [Discord 社群](https://discord.gg/anthropic)
- [GitHub 討論區](https://github.com/anthropics/claude-code/discussions)
- [問題回報](https://github.com/anthropics/claude-code/issues)

### 本庫文件索引

- [docs/README.md](docs/README.md) — 文檔索引與快速參考
- [docs/cursor-claude-master-guide-zh-tw.md](docs/cursor-claude-master-guide-zh-tw.md) — 綜合代理主控手冊（起點）
- [docs/claude-code-guide-zh-tw.md](docs/claude-code-guide-zh-tw.md) — 基礎 API 與 CLI 指南
- [docs/awesome-claude-code-zh-tw.md](docs/awesome-claude-code-zh-tw.md) — 社群最佳實踐與 Hooks
- [docs/superclaude-zh-tw.md](docs/superclaude-zh-tw.md) — 高階功能系統與進階工作流
- [docs/claude-code-usage-monitor-zh-tw.md](docs/claude-code-usage-monitor-zh-tw.md) — 用量監控、安全與部署
- [docs/claudecodeui-zh-tw.md](docs/claudecodeui-zh-tw.md) — Web UI 與 PWA 介面
- [docs/bplustree3-zh-tw.md](docs/bplustree3-zh-tw.md) — 效能優化與 B+Tree 策略

---

### CHANGELOG 新功能摘錄（依版本，來源：GitHub CHANGELOG）

> 📋 **最新版本**：v2.0.75（2025-12-20）
> 完整版本歷史請參考 [claudefa.st/changelog](https://claudefa.st/blog/guide/changelog)

## 2.0.75（2025-12-20）

- 精簡任務工具指令
- 移除工具呼叫前不使用冒號的指令

## 2.0.65

- **模型切換**：使用 Alt+P（Mac 為 Option+P）在提示中途切換模型
- **上下文資訊**：檢視詳細的上下文視窗資訊
- **檔案建議**：新增設定以配置檔案建議行為
- **Shell 偵測**：新增用於自訂 shell 偵測的環境變數
- **提示歷史修復**：修復提示歷史導航問題
- **圖片格式**：改善圖片格式偵測

## 2.0.64

- **即時自動壓縮**：更快的上下文管理，即時自動壓縮
- **非同步執行**：代理和 bash 命令現可非同步執行
- **統計指令**：`/stats` 指令顯示使用指標和統計資料
- **命名會話**：支援透過 `/rename` 和 `/resume` 指令命名會話
- **規則目錄**：支援 `.claude/rules/` 目錄存放專案規則
- **圖片中繼資料**：新增圖片尺寸中繼資料支援
- **環境檔案**：修復環境檔案自動載入問題
- **VSCode 剪貼簿**：在 VSCode 擴充套件中新增剪貼簿按鈕
- **Windows ARM64**：修復 Windows ARM64 相容性問題
- **統一 TaskOutputTool**：整合代理輸出處理

## 2.0.60

- **背景代理**：代理在您工作時於背景執行
- **CLI 參數**：新增 `--disable-slash-commands` CLI 參數以停用所有斜線命令
- **提交署名**：在「Co-Authored-By」提交訊息中加入模型名稱
- **MCP 切換**：`/mcp enable [server-name]` 或 `/mcp disable [server-name]` 快速切換
- **Fetch 優化**：更新 Fetch 以跳過預先批准網站的摘要
- **VSCode 多客戶端**：新增支援多個終端機客戶端連接至 IDE 伺服器

## 2.0.58

- **Opus 4.5 for Pro**：Pro 用戶現可使用 Opus 4.5
- **計時器修復**：修復計時器顯示「11m 60s」而非「12m 0s」的問題
- **Windows 路徑**：受管設定現優先使用 `C:\Program Files\ClaudeCode`

## 2.0.51

- **Opus 4.5 發布**：[Opus 4.5](https://www.anthropic.com/news/claude-opus-4-5) 現已推出
- **Claude Code for Desktop**：推出 [Claude Code for Desktop](https://claude.com/download)
- **更新使用限制**：更新 Claude Code 用戶限制
- **Pro 額外用量**：Pro 用戶可購買 Opus 4.5 額外用量
- **計劃模式改善**：更精確的計劃和更徹底的執行
- **用量通知**：更易理解的用量限制通知

## 2.0.45

- **Microsoft Foundry**：新增支援 Microsoft Foundry
- **PermissionRequest hook**：透過自訂邏輯自動批准或拒絕工具權限請求
- **Web 背景任務**：透過以 `&` 開頭的訊息發送背景任務至 Claude Code on the web

## 2.0.28

- 計劃模式：推出全新的 Plan 子代理
- 子代理：Claude 現在可以選擇恢復子代理
- 子代理：Claude 可以動態選擇其子代理使用的模型
- SDK：新增 --max-budget-usd 參數
- 自訂斜線命令、子代理和輸出樣式的發現不再遵循 .gitignore
- 停止 `/terminal-setup` 在 VS Code 中為 `Shift + Enter` 添加反斜線
- 為基於 git 的外掛程式和市場新增分支和標籤支援，使用片段語法（例如 `owner/repo#branch`）
- 修復從主目錄啟動時初始啟動會顯示 macOS 權限提示的錯誤
- 各種其他錯誤修復

## 2.0.27

- 權限提示新增全新 UI 介面
- 會話恢復畫面新增當前分支篩選和搜尋功能，方便導航
- 修復目錄 @-提及導致「找不到助理訊息」錯誤的問題
- VSCode 擴充套件：新增設定選項，可在檔案搜尋中包含 .gitignore 的檔案
- VSCode 擴充套件：修復不相關的「Warmup」對話錯誤，以及設定偶爾被重置為預設值的問題

## 2.0.25

- 移除舊版 SDK 進入點。請遷移至 @anthropic-ai/claude-agent-sdk 以獲取未來的 SDK 更新：https://docs.claude.com/en/docs/claude-code/sdk/migration-guide

## 2.0.24

- 修復專案層級技能在指定 --setting-sources 'project' 時無法載入的錯誤
- Claude Code Web：支援 Web -> CLI 傳送
- 沙箱：在 Linux 和 Mac 上為 BashTool 發布沙箱模式

## 2.0.22

- 修復捲動斜線指令時的內容版面跳動問題
- IDE：新增啟用/停用思考的切換開關
- 修復平行工具呼叫時出現重複權限提示的錯誤
- 新增對企業管理的 MCP 允許清單和拒絕清單的支援

## 2.0.21

- 支援 MCP 工具回應中的 `structuredContent` 欄位
- 新增互動式問題工具
- Claude 現在在計劃模式下會更頻繁地向您提問
- Pro 使用者新增 Haiku 4.5 作為模型選項
- 修復佇列指令無法存取先前訊息輸出的問題

## 2.0.20

- 新增對 Claude Skills 的支援

## 2.0.19

- 長時間執行的 bash 指令現在會自動轉為背景執行，而非終止。可透過 BASH_DEFAULT_TIMEOUT_MS 自訂
- 修復列印模式下不必要地呼叫 Haiku 的錯誤

## 2.0.17

- 模型選擇器新增 Haiku 4.5！
- Haiku 4.5 在計劃模式自動使用 Sonnet，執行時使用 Haiku（即預設為 SonnetPlan）
- 第三方平台（Bedrock 和 Vertex）尚未自動升級。可透過設定 `ANTHROPIC_DEFAULT_HAIKU_MODEL` 手動升級
- 推出 Explore 子代理。由 Haiku 驅動，將有效搜尋您的程式碼庫以節省上下文！
- OTEL：支援 HTTP_PROXY 和 HTTPS_PROXY
- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` 現在會停用版本資訊取得

## 2.0.15

- 修復恢復時需要重新讀取先前建立的檔案才能寫入的錯誤
- 修復 `-p` 模式下需要重新讀取 @-提及的檔案才能寫入的錯誤

## 2.0.14

- 修復 @-提及 MCP 伺服器以切換開關的功能
- 改善帶有行內環境變數的 bash 權限檢查
- 修復 ultrathink + 思考切換
- 減少不必要的登入
- 新增 --system-prompt 文件
- 多項渲染改善
- 外掛 UI 優化

## 2.0.13

- 修復 `/plugin` 在原生建置版本無法運作的問題

## 2.0.12

- **外掛系統發布**：透過市集的自訂指令、代理、hooks 和 MCP 伺服器擴展 Claude Code
- `/plugin install`、`/plugin enable/disable`、`/plugin marketplace` 指令用於外掛管理
- 透過 `extraKnownMarketplaces` 進行儲存庫層級的外掛設定，以便團隊協作
- `/plugin validate` 指令用於驗證外掛結構和設定
- 外掛公告部落格文章：https://www.anthropic.com/news/claude-code-plugins
- 外掛文件：https://docs.claude.com/en/docs/claude-code/plugins
- 透過 `/doctor` 指令提供完整的錯誤訊息和診斷
- 避免 `/model` 選擇器閃爍
- `/help` 改善
- 避免在 `/resume` 摘要中提及 hooks
- `/config` 中的「verbose」設定變更現在會在會話間保持

## 2.0.11

- 系統提示大小減少 1.4k tokens
- IDE：修復鍵盤快捷鍵和焦點問題，提供更流暢的互動
- 修復 Opus 回退速率限制錯誤不正確顯示的問題
- 修復 /add-dir 指令選擇錯誤預設分頁的問題

## 2.0.10

- 重寫終端渲染器，提供極致流暢的 UI
- 透過 @-提及或在 /mcp 中啟用/停用 MCP 伺服器
- bash 模式下新增 shell 指令的 tab 自動完成
- PreToolUse hooks 現在可以修改工具輸入
- 按 Ctrl-G 在系統設定的文字編輯器中編輯提示
- 修復帶有環境變數的 bash 權限檢查

## 2.0.9

- 修復 bash 背景執行停止運作的問題

## 2.0.8

- 更新 Bedrock 預設 Sonnet 模型為 `global.anthropic.claude-sonnet-4-5-20250929-v1:0`
- IDE：聊天中新增檔案和資料夾的拖放支援
- /context：修復思考區塊的計數
- 改善深色終端上淺色主題使用者的訊息渲染
- 移除已棄用的 .claude.json 設定選項（allowedTools、ignorePatterns、env、todoFeatureEnabled），改為在 settings.json 中設定

## 2.0.5

- IDE：修復使用 Enter 和 Tab 時 IME 意外提交訊息的問題
- IDE：登入畫面新增「在終端開啟」連結
- 修復未處理的 OAuth 過期 401 API 錯誤
- SDK：新增 SDKUserMessageReplay.isReplay 以防止重複訊息

## 2.0.1

- Bedrock 和 Vertex 跳過 Sonnet 4.5 預設模型設定變更
- 各種錯誤修復和呈現改善

## 2.0.0

- 全新原生 VS Code 擴充套件
- 整個應用程式全新外觀
- /rewind 回退對話以撤銷程式碼變更
- /usage 指令查看計劃限制
- Tab 切換思考（跨會話保持）
- Ctrl-R 搜尋歷史記錄
- 未發布的 claude config 指令
- Hooks：減少 PostToolUse 的 'tool_use' id 找不到 'tool_result' 區塊的錯誤
- SDK：Claude Code SDK 現在是 Claude Agent SDK
- 使用 `--agents` 參數動態新增子代理

## 1.0.126

- 為 Bedrock 和 Vertex 啟用 /context 指令
- 為基於 HTTP 的 OpenTelemetry 匯出器新增 mTLS 支援

## 1.0.124

- 將 `CLAUDE_BASH_NO_LOGIN` 環境變數設為 1 或 true 以跳過 BashTool 的登入 shell
- 修復 Bedrock 和 Vertex 環境變數將所有字串評估為真值的問題
- 不再在權限被拒時通知 Claude 允許的工具清單
- 修復 Bash 工具權限檢查中的安全漏洞
- 改善 VSCode 擴充套件對大型檔案的效能

## 1.0.123

- Bash 權限規則現在在比對時支援輸出重導向（例如 `Bash(python:*)` 比對 `python script.py > output.txt`）
- 修復否定片語（如「don't think」）觸發思考模式的問題
- 修復 token 串流期間的渲染效能下降問題
- 新增 SlashCommand 工具，讓 Claude 可以調用您的斜線指令。https://docs.claude.com/en/docs/claude-code/slash-commands#SlashCommand-tool
- 增強 BashTool 環境快照記錄
- 修復在無頭模式下恢復對話有時會不必要地啟用思考的錯誤
- 將 --debug 記錄遷移到檔案，以便輕鬆追蹤和篩選

## 1.0.120

- 修復輸入時的延遲，在大型提示下特別明顯
- 改善 VSCode 擴充套件指令註冊和會話對話框使用者體驗
- 增強會話對話框回應能力和視覺回饋
- 透過移除工作樹支援檢查修復 IDE 相容性問題
- 修復可透過前綴比對繞過 Bash 工具權限檢查的安全漏洞

## 1.0.119

- 修復 Windows 上進入互動模式時程序視覺凍結的問題
- 透過 headersHelper 設定支援 MCP 伺服器的動態標頭
- 修復無頭會話中思考模式無法運作的問題
- 修復斜線指令現在正確更新允許的工具而非替換它們

## 1.0.117

- 新增 Ctrl-R 歷史記錄搜尋，像 bash/zsh 一樣回憶先前的指令
- 修復輸入時的延遲，尤其是在 Windows 上
- acceptEdits 模式下將 sed 指令新增到自動允許的指令
- 修復 Windows PATH 比較，使磁碟機代號不區分大小寫
- /add-dir 輸出新增權限管理提示

## 1.0.115

- 改善思考模式顯示，增強視覺效果
- 在提示中輸入 /t 暫時停用思考模式
- 改善 glob 和 grep 工具的路徑驗證
- 顯示工具後 hooks 的簡潔輸出以減少視覺混亂
- 修復載入狀態完成時的視覺回饋
- 改善權限請求對話框的 UI 一致性

**📅 最後更新時間**: 2025-10-29  
**📊 資料來源**: [GitHub CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)  
**🔄 翻譯方式**: 人工高品質翻譯
**📌 版本範圍**: 1.0.115 - 2.0.28（最新）

---

## 🎉 結語

本手冊經過完整的官方文檔驗證，確保所有功能、指令與參數均為 Anthropic 官方支援。透過深度結構化的組織方式，無論是 LLM 查詢還是人工閱讀，都能快速找到所需資訊。

### 使用建議

1. **新手入門**：按序閱讀安裝 → 基礎操作 → 常用指令
2. **快速查詢**：使用目錄導航或搜尋功能
3. **深度學習**：參考工作流程和最佳實踐章節
4. **問題解決**：查看疑難排解分類索引

### 持續更新

- 📅 定期同步官方文檔
- 🔍 持續驗證功能準確性
- 💬 歡迎透過 GitHub Issues 回饋
- 🌐 支援社群貢獻與交流

---

**📖 Claude Code 官方驗證使用手冊 - 您的 AI 輔助開發權威指南**

_基於 Anthropic 官方文檔 | 100% 官方驗證 | 持續同步更新_
