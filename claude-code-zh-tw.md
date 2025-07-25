# Claude Code 官方驗證使用手冊 📚

> **經官方文檔驗證的完整 Claude Code 中文指南**  
> 最後更新時間：2025-07-18T02:48:57+08:00  
> 文件語言：繁體中文  
> 版本：v5.0.0 - 完整百科全書版本，初階中階高階全覆蓋  
> GitHub 作者：[s123104](https://github.com/s123104) 整理
>
> **🎯 本手冊特色**
>
> - ✅ 100% 官方文檔驗證
> - ✅ 深度結構化內容
> - ✅ LLM 查詢優化
> - ✅ 跨平台完整支援

---

## 🚀 快速導航

### 依角色快速開始

- **初學者** → [安裝指南](#-安裝指南) → [基礎操作](#-基礎操作) → [常用指令](#-常用指令速查)
- **開發者** → [CLI 完整參考](#-cli-完整參考) → [進階功能](#-進階功能) → [最佳實踐](#-最佳實踐)
- **團隊管理** → [權限管理](#-權限管理) → [安全控制](#-安全控制) → [企業部署](#-企業部署)

### 依需求快速查找

- 🔍 **查找指令** → [指令索引](#-指令索引)
- 🚩 **查找旗標** → [旗標參考](#-旗標完整參考)
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
- [旗標完整參考](#-旗標完整參考)
- [斜線命令系統](#-斜線命令系統)
- [常用指令速查](#-常用指令速查)

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

本手冊是一份**經過官方文檔完整驗證**的 Claude Code 中文使用指南，所有功能、指令與旗標均已透過 Anthropic 官方文檔交叉比對確認。涵蓋從基礎安裝到進階功能、從日常開發到企業部署的完整流程。

### 📋 官方驗證說明

**驗證依據**：

- Anthropic 官方 CLI Reference (2025-07-18)
- Claude Code 官方文檔 (docs.anthropic.com)
- 官方 GitHub 倉庫最新資訊

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

**標準 npm 安裝（推薦）：**

```bash
# 官方推薦的標準安裝方式
npm install -g @anthropic-ai/claude-code
```

**Alpha 原生二進制安裝（測試階段）：**

```bash
# Alpha 原生安裝腳本（平台自動檢測）
curl -fsSL https://claude.ai/install.sh | bash

# 或從現有安裝遷移
claude install
```

**重要提醒**：

- 官方強調**勿使用 sudo**
- 如遇權限問題，使用 `claude migrate-installer`
- Alpha 版本目前支援：macOS、Linux、Windows (via WSL)

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
# 全域安裝
npm install -g @anthropic-ai/claude-code

# 驗證安裝
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
# 使用 Homebrew
brew install node
npm install -g @anthropic-ai/claude-code
```

#### Linux (Ubuntu/Debian)

```bash
# 更新套件管理器
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
claude  # 會自動開啟瀏覽器登入頁面

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

## 🚩 旗標完整參考

### 基本控制旗標

| 旗標         | 短參數 | 描述                   | 範例                             |
| ------------ | ------ | ---------------------- | -------------------------------- |
| `--print`    | `-p`   | 非互動模式，查詢後退出 | `claude -p "解釋程式碼"`         |
| `--continue` | `-c`   | 繼續最近對話           | `claude -c "繼續討論"`           |
| `--resume`   |        | 恢復特定會話           | `claude --resume abc123 "query"` |
| `--help`     | `-h`   | 顯示幫助               | `claude --help`                  |
| `--version`  | `-v`   | 顯示版本               | `claude --version`               |

### 模型與輸出控制

| 旗標              | 描述       | 可用選項                                     | 範例                   |
| ----------------- | ---------- | -------------------------------------------- | ---------------------- |
| `--model`         | 指定模型   | `sonnet`, `opus`, `claude-sonnet-4-20250514` | `--model sonnet`       |
| `--output-format` | 輸出格式   | `text`, `json`, `stream-json`                | `--output-format json` |
| `--input-format`  | 輸入格式   | `text`, `stream-json`                        | `--input-format text`  |
| `--verbose`       | 詳細輸出   | 無參數                                       | `claude --verbose`     |
| `--max-turns`     | 最大回合數 | 數字                                         | `--max-turns 3`        |

### 安全與權限控制

| 旗標                             | 描述            | 語法格式             | 範例                                         |
| -------------------------------- | --------------- | -------------------- | -------------------------------------------- |
| `--allowedTools`                 | 允許的工具      | 工具清單             | `--allowedTools "Edit" "View" "Bash(git:*)"` |
| `--disallowedTools`              | 禁用的工具      | 工具清單             | `--disallowedTools "Bash"`                   |
| `--permission-mode`              | 權限模式        | `plan`, `always-ask` | `--permission-mode plan`                     |
| `--permission-prompt-tool`       | 權限處理工具    | MCP 工具名稱         | `--permission-prompt-tool mcp_auth_tool`     |
| `--dangerously-skip-permissions` | ⚠️ 跳過權限檢查 | 無參數               | `--dangerously-skip-permissions`             |

### 系統設定

| 旗標        | 描述         | 範例                       |
| ----------- | ------------ | -------------------------- |
| `--add-dir` | 添加工作目錄 | `--add-dir ../apps ../lib` |

### SDK 專用旗標（僅限 Print Mode）

| 旗標                     | 描述         | 範例                                             |
| ------------------------ | ------------ | ------------------------------------------------ |
| `--system-prompt`        | 覆蓋系統提示 | `claude -p "查詢" --system-prompt "您是專家"`    |
| `--append-system-prompt` | 附加系統提示 | `claude -p "查詢" --append-system-prompt "額外"` |

**注意**：這些旗標僅在 SDK 的 print mode (`-p`) 中有效，不適用於互動模式。

### 旗標組合範例

```bash
# 腳本化查詢
claude -p "分析程式碼" --output-format json --model sonnet

# 安全模式開發
claude --allowedTools "Edit" "View" --permission-mode plan

# 除錯模式
claude --verbose --max-turns 3

# SDK 系統提示範例
claude -p "建立 API" --system-prompt "您是後端架構師，專注安全性與效能"
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

| 命令      | 功能     | 語法                       | 範例           |
| --------- | -------- | -------------------------- | -------------- |
| `/config` | 配置管理 | `/config [list\|set\|get]` | `/config list` |
| `/doctor` | 健康檢查 | `/doctor`                  | `/doctor`      |
| `/status` | 狀態查詢 | `/status`                  | `/status`      |
| `/cost`   | 成本查詢 | `/cost`                    | `/cost`        |

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

| 命令   | 功能     | 語法                                | 範例        |
| ------ | -------- | ----------------------------------- | ----------- |
| `/mcp` | MCP 管理 | `/mcp [list\|add\|remove\|restart]` | `/mcp list` |

### 開發工具

| 命令           | 功能        | 語法                     | 範例                      |
| -------------- | ----------- | ------------------------ | ------------------------- |
| `/review`      | 程式碼審查  | `/review <path>`         | `/review src/`            |
| `/compact`     | 壓縮對話    | `/compact [description]` | `/compact "保留核心討論"` |
| `/bug`         | 問題回報    | `/bug`                   | `/bug`                    |
| `/pr_comments` | PR 評論查看 | `/pr_comments`           | `/pr_comments`            |

### 編輯器整合

| 命令              | 功能         | 語法              | 範例              |
| ----------------- | ------------ | ----------------- | ----------------- |
| `/vim`            | Vim 編輯模式 | `/vim`            | `/vim`            |
| `/terminal-setup` | 終端機設定   | `/terminal-setup` | `/terminal-setup` |

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

### 學習資源

- [快速入門指南](https://docs.anthropic.com/en/docs/claude-code/quickstart)
- [常見工作流程](https://docs.anthropic.com/en/docs/claude-code/common-workflows)
- [最佳實踐指南](https://www.anthropic.com/engineering/claude-code-best-practices)

### 社群支援

- [Discord 社群](https://discord.gg/anthropic)
- [GitHub 討論區](https://github.com/anthropics/claude-code/discussions)
- [問題回報](https://github.com/anthropics/claude-code/issues)

---

## 📊 更新記錄

### v5.0.0 (2025-07-18) - 完整百科全書版本

**重大新增**：

- 🪝 **完整 Hooks 功能章節**：包含生命週期事件、配置方式、實戰範例和安全考量
- ⚙️ **詳細設定檔案與環境變數**：分層設定系統、企業政策、完整環境變數參考
- 🛠️ **工具完整參考**：所有 Claude Code 可用工具的詳細說明和權限控制
- 📊 **企業級監控與遙測**：OpenTelemetry 設定、監控指標、告警配置
- 🔗 **第三方整合**：LLM Gateway、AWS Bedrock、Google Vertex AI、GitHub Actions
- 🏢 **企業部署進階功能**：代理設定、SSL 憑證、SDK 整合

**內容更新**：

- ✅ 完整官方文檔驗證與校正（v4.1.0 基礎）
- ✅ 新增缺失的官方旗標：`--permission-mode`、`--permission-prompt-tool`
- ✅ 正確分類 SDK 專用功能：`--system-prompt`、`--append-system-prompt`
- ✅ 新增 Alpha 原生二進制安裝選項
- ✅ 更新斜線命令清單，新增 `/pr_comments`

**企業功能**：

- 🏭 **分層設定系統**：使用者、專案、企業政策設定
- 📈 **完整監控方案**：指標收集、儀表板、告警設定
- 🔐 **進階安全控制**：權限細分、審計追蹤、合規性
- 🌐 **多雲支援**：AWS、GCP、企業代理整合
- 🤖 **自動化工作流程**：Hooks 系統、CI/CD 整合

**開發者體驗**：

- 📚 **百科全書式組織**：初階、中階、高階完整覆蓋
- 🔍 **快速查詢優化**：結構化目錄、分類索引
- 💡 **實戰範例豐富**：涵蓋各種使用場景
- 🎯 **角色導向指南**：依照使用者需求分類

**技術規格**：

- 📄 **文檔長度**：約 1000+ 行，完整覆蓋所有功能
- 🔗 **交叉引用**：章節間相互連結，便於導航
- 📋 **表格化資訊**：旗標、命令、設定選項系統性整理
- 🛡️ **安全性強調**：每個功能都包含安全考量說明

---

## 🎉 結語

本手冊經過完整的官方文檔驗證，確保所有功能、指令與旗標均為 Anthropic 官方支援。透過深度結構化的組織方式，無論是 LLM 查詢還是人工閱讀，都能快速找到所需資訊。

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
