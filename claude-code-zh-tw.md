# Claude Code 中文文件整合專案

> **完整的 Claude Code 說明書集合**  
> 最後更新時間：2025-07-17T23:45:15+08:00  
> 文件語言：繁體中文  
> 版本：v2.1.0 - 僅包含官方確認指令與旗標參考

---

## 📋 目錄

- [📋 目錄](#-目錄)
- [🎯 專案簡介](#-專案簡介)
- [📚 官方功能索引](#-官方功能索引)
- [💻 安裝步驟](#-安裝步驟)
  - [🔧 基本環境需求](#-基本環境需求)
  - [📦 推薦安裝方式](#-推薦安裝方式)
  - [🖥️ 各平台安裝指引](#️-各平台安裝指引)
- [🔐 認證與連線設定](#-認證與連線設定)
- [🚀 快速開始指引](#-快速開始指引)
- [⭐ 主要功能特色](#-主要功能特色)
- [📖 CLI 指令完整參考](#-cli-指令完整參考)
  - [基本指令](#基本指令)
  - [進階旗標與選項](#進階旗標與選項)
  - [MCP 管理指令](#mcp-管理指令)
  - [斜線命令系統](#斜線命令系統)
- [🎯 常用旗標快查](#-常用旗標快查)
- [❓ 常見問題與疑難排解](#-常見問題與疑難排解)
- [🌟 官方資源與延伸閱讀](#-官方資源與延伸閱讀)

---

## 🎯 專案簡介

本專案是一個完整的 **Claude Code 中文文件整合庫**，收錄了 Claude Code 的官方功能使用指南。涵蓋從基礎安裝到進階功能、從日常開發到生產部署的完整流程。

### 專案特色

- **🌐 全繁體中文化**：所有文件均為繁體中文，符合華語使用者習慣
- **📋 官方驗證**：所有功能與旗標均經過官方文檔驗證
- **⚡ 實戰導向**：包含實用範例、最佳實踐和疑難排解方案
- **🔄 持續更新**：跟隨 Claude Code 版本更新，確保內容時效性
- **📱 完整指令參考**：整合官方最新 CLI 選項、旗標、MCP 命令等

### 適用對象

- **AI 輔助開發初學者**：想要開始使用 Claude Code 進行程式開發
- **專業開發者**：希望提升開發效率，整合 AI 工具到工作流程
- **架構師**：需要了解 Claude Code 的架構設計和效能優化
- **團隊領導**：計畫在團隊中導入 Claude Code，需要監控和管理功能
- **DevOps 工程師**：負責 Claude Code 的部署、監控和維運

---

## 📚 官方功能索引

### 🎯 核心功能

| 功能類別     | 主要內容           | 官方支援旗標                                 | 使用場景           |
| ------------ | ------------------ | -------------------------------------------- | ------------------ |
| **基礎操作** | CLI 介面、互動模式 | `--print` `--continue` `--resume`            | 日常開發、基礎操作 |
| **模型控制** | 模型選擇、輸出格式 | `--model` `--output-format` `--input-format` | 客製化行為控制     |
| **權限管理** | 工具權限、安全控制 | `--allowedTools` `--disallowedTools`         | 安全控制、權限管理 |
| **進階設定** | 系統提示、會話管理 | `--system-prompt` `--append-system-prompt`   | 進階客製化         |
| **MCP 整合** | 外部工具整合       | `--mcp-config` `--permission-prompt-tool`    | 擴展功能           |

---

## 💻 安裝步驟

### 🔧 基本環境需求

- **Node.js 18+**（建議使用 LTS 版本）
- **作業系統支援**：macOS、Linux、WSL/Windows
- **推薦環境**：純 Ubuntu WSL 環境，避免 Windows 路徑汙染

### 📦 推薦安裝方式

**NPM 官方安裝（推薦）：**

```bash
# 全域安裝 Claude Code
npm install -g @anthropic-ai/claude-code

# 驗證安裝
which claude
claude --version
```

**驗證安裝成功：**

```bash
# 檢查 Claude Code 是否正確安裝
claude --help

# 設定 API Key（多種方式）
export ANTHROPIC_API_KEY=your_api_key_here

# 測試基本功能
claude "Hello, Claude Code!"
```

### 🖥️ 各平台安裝指引

#### macOS

```bash
# 使用 Homebrew 安裝 Node.js
brew install node

# 安裝 Claude Code
npm install -g @anthropic-ai/claude-code
```

#### Linux (Ubuntu/Debian)

```bash
# 更新套件管理器
sudo apt update

# 安裝 Node.js 和 npm
sudo apt install -y nodejs npm

# 安裝 Claude Code
npm install -g @anthropic-ai/claude-code
```

#### Windows/WSL

```bash
# 在 WSL Ubuntu 環境中執行
sudo apt update && sudo apt install -y nodejs npm
npm install -g @anthropic-ai/claude-code
```

---

## 🔐 認證與連線設定

### 🌐 HTTP 網頁認證（推薦）

**方式 1：Anthropic Console 登入**

```bash
# 首次使用建議透過網頁認證
claude  # 會自動開啟瀏覽器登入頁面

# 或手動前往
# https://console.anthropic.com/login
```

**適用場景：**

- 個人開發者首次使用
- 需要完整功能存取
- 支援 OAuth 2.0 認證流程

### 🔑 API Token 認證

**方式 2：環境變數設定**

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

## 🚀 快速開始指引

### 初次使用者

1. **安裝與認證**：完成 Claude Code 的安裝和 API 認證設定
2. **學習基礎操作**：掌握基本的 CLI 指令和互動模式
3. **探索進階功能**：根據需求使用 MCP 整合和自訂設定

### 依使用場景快速導航

```yaml
基礎開發: claude --help → claude -p "查詢" → claude --continue
進階設定: claude --model → claude --system-prompt → claude --mcp-config
安全控制: claude --allowedTools → claude --disallowedTools
```

---

## ⭐ 主要功能特色

### 🤖 AI 輔助開發

- **自然語言指令**：使用自然語言與 Claude Code 互動
- **智能程式碼生成**：根據需求自動生成程式碼
- **錯誤自動修復**：自動偵測並修復程式碼問題
- **文件自動產生**：根據程式碼自動生成文件

### 🔧 進階功能

- **MCP 多代理協作**：支援多個 AI 代理同時協作
- **專案記憶體管理**：透過 CLAUDE.md 管理專案記憶
- **Slash Commands**：快速執行常用指令
- **會話管理**：支援會話恢復和繼續功能

### 📊 監控與管理

- **權限管理**：精細的工具權限控制
- **安全控制**：支援安全模式和權限限制
- **會話追蹤**：完整的操作記錄和追蹤

### 🖥️ 使用者介面

- **CLI 介面**：強大的命令列介面
- **互動模式**：支援 REPL 互動式對話
- **IDE 整合**：支援 VSCode、Cursor 等編輯器

---

## 📖 CLI 指令完整參考

### 基本指令

| 指令                | 功能          | 範例                       | 說明               |
| ------------------- | ------------- | -------------------------- | ------------------ |
| `claude`            | 啟動互動 REPL | `claude`                   | 進入交互式對話模式 |
| `claude "query"`    | 直接執行查詢  | `claude "分析這個專案"`    | 執行單次查詢後退出 |
| `claude -p "query"` | 非互動查詢    | `claude -p "解釋這個函數"` | 查詢後立即退出     |
| `claude -c`         | 繼續最近對話  | `claude -c`                | 恢復上次對話狀態   |
| `claude update`     | 更新版本      | `claude update`            | 升級到最新版本     |
| `claude mcp`        | MCP 管理      | `claude mcp list`          | 管理 MCP 伺服器    |

### 進階旗標與選項

| 旗標                             | 功能     | 範例                             | 適用場景               |
| -------------------------------- | -------- | -------------------------------- | ---------------------- |
| `--model`                        | 指定模型 | `--model claude-sonnet-4`        | 選擇特定 AI 模型       |
| `--verbose`                      | 詳細輸出 | `claude --verbose`               | 除錯和詳細記錄         |
| `--output-format`                | 輸出格式 | `--output-format json`           | 結構化輸出             |
| `--input-format`                 | 輸入格式 | `--input-format stream-json`     | 結構化輸入             |
| `--allowedTools`                 | 允許工具 | `--allowedTools "Edit,View"`     | 安全控制               |
| `--disallowedTools`              | 禁用工具 | `--disallowedTools "Bash"`       | 安全控制               |
| `--max-turns`                    | 限制回合 | `--max-turns 5`                  | 控制對話長度           |
| `--add-dir`                      | 添加目錄 | `--add-dir ../shared`            | 擴展專案範圍           |
| `--resume`                       | 恢復會話 | `--resume session_id`            | 恢復特定會話           |
| `--continue`                     | 繼續對話 | `--continue`                     | 繼續最近對話           |
| `--system-prompt`                | 系統提示 | `--system-prompt "規則"`         | 自訂行為規則           |
| `--append-system-prompt`         | 附加提示 | `--append-system-prompt "注意"`  | 補充行為規則           |
| `--mcp-config`                   | MCP 配置 | `--mcp-config config.json`       | 載入 MCP 設定          |
| `--permission-prompt-tool`       | 權限工具 | `--permission-prompt-tool tool`  | 權限處理工具           |
| `--dangerously-skip-permissions` | 跳過權限 | `--dangerously-skip-permissions` | 危險：跳過所有權限檢查 |

### MCP 管理指令

| 指令                              | 功能             | 範例                                                           | 說明                           |
| --------------------------------- | ---------------- | -------------------------------------------------------------- | ------------------------------ |
| `claude mcp add`                  | 新增 MCP 伺服器  | `claude mcp add weather /path/to/server`                       | 添加本地 stdio 伺服器          |
| `claude mcp add --transport sse`  | 新增 SSE 伺服器  | `claude mcp add --transport sse api https://api.example.com`   | 添加遠端 SSE 伺服器            |
| `claude mcp add --transport http` | 新增 HTTP 伺服器 | `claude mcp add --transport http rest https://api.example.com` | 添加 HTTP API 伺服器           |
| `claude mcp list`                 | 列出伺服器       | `claude mcp list`                                              | 查看所有已配置的伺服器         |
| `claude mcp get`                  | 查看伺服器詳情   | `claude mcp get weather`                                       | 檢視特定伺服器配置             |
| `claude mcp remove`               | 移除伺服器       | `claude mcp remove weather`                                    | 刪除指定伺服器                 |
| `claude mcp serve`                | 啟動伺服器模式   | `claude mcp serve`                                             | 將 Claude Code 作為 MCP 伺服器 |

### 斜線命令系統

| 命令      | 功能       | 範例           | 用途            |
| --------- | ---------- | -------------- | --------------- |
| `/help`   | 顯示幫助   | `/help`        | 查看可用命令    |
| `/clear`  | 清除歷史   | `/clear`       | 重置對話狀態    |
| `/memory` | 記憶體管理 | `/memory view` | 管理專案記憶    |
| `/config` | 配置管理   | `/config list` | 查看和修改設定  |
| `/doctor` | 健康檢查   | `/doctor`      | 診斷系統狀態    |
| `/init`   | 初始化專案 | `/init`        | 創建 CLAUDE.md  |
| `/mcp`    | MCP 管理   | `/mcp`         | 互動式 MCP 管理 |
| `/review` | 程式碼審查 | `/review src/` | 審查指定目錄    |

---

## 🎯 常用旗標快查

| 動作     | 推薦旗標組合                            | 使用範例                                                    |
| -------- | --------------------------------------- | ----------------------------------------------------------- |
| 基礎查詢 | `--print --output-format`               | `claude -p "解釋程式碼" --output-format json`               |
| 安全模式 | `--allowedTools --disallowedTools`      | `claude --allowedTools "Edit,View" "分析程式碼"`            |
| 會話管理 | `--continue --resume`                   | `claude --continue "繼續討論"`                              |
| 進階設定 | `--model --system-prompt`               | `claude --model claude-sonnet-4 --system-prompt "你是專家"` |
| MCP 整合 | `--mcp-config --permission-prompt-tool` | `claude --mcp-config config.json "執行任務"`                |
| 除錯模式 | `--verbose --max-turns`                 | `claude --verbose --max-turns 3 "測試功能"`                 |

---

## ❓ 常見問題與疑難排解

### 🔑 API Key 相關問題

**問題**：缺少 ANTHROPIC_API_KEY  
**解決**：設定環境變數 `export ANTHROPIC_API_KEY=your_api_key_here`

**問題**：Rate limit exceeded  
**解決**：升級方案或減少請求頻率

### 🔧 安裝與設定問題

**問題**：Node.js 版本過舊  
**解決**：升級 Node.js 至 18+ 版本

**問題**：權限錯誤  
**解決**：設定 `claude --allowedTools "Edit,View,Bash"`

### 🤖 MCP 相關問題

**問題**：MCP 服務異常  
**解決**：檢查 MCP 配置並重新啟動

**問題**：MCP 無法啟動  
**解決**：檢查 MCP 配置文件和網路連線

### 🔍 診斷與健康檢查

```bash
# 健康檢查指令
claude --version          # 檢查版本
claude --help            # 顯示幫助
claude /doctor           # 診斷模式

# 除錯模式
claude --verbose         # 詳細輸出
```

---

## 🌟 官方資源與延伸閱讀

### 📚 官方資源

- [Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
- [GitHub 官方倉庫](https://github.com/anthropics/claude-code)
- [API 參考文檔](https://docs.anthropic.com/en/docs/claude-code/api/overview)

### 🎯 最佳實踐

- [Claude Code 最佳實踐指南](https://www.anthropic.com/engineering/claude-code-best-practices)
- [官方快速入門教學](https://docs.anthropic.com/en/docs/claude-code/quickstart)
- [MCP 整合指南](https://docs.anthropic.com/en/docs/claude-code/mcp)

---

## 💡 使用建議

1. **始終使用官方文檔**：確保使用的旗標和功能都是官方支援的
2. **根據需求選擇旗標**：不要使用不必要的進階旗標
3. **保持版本更新**：定期檢查官方倉庫的最新版本
4. **實踐導向**：邊閱讀邊實作，將理論知識轉化為實際技能
5. **善用指令參考**：本文件提供完整的官方 CLI 選項和旗標說明

---

**📝 文件維護說明**

- **內容驗證**：所有功能與旗標均經過官方文檔驗證
- **使用者體驗**：專注於官方支援的功能，確保穩定性
- **指令同步**：定期檢查官方文檔更新，保持指令參考的準確性

---

_最後更新：2025-07-17 | 語言：繁體中文 | 基於：Anthropic 官方文檔_
