# Claude Code 中文文件整合專案

> **完整的 Claude Code 與 Cursor AI 整合說明書集合**  
> 最後更新時間：2025-07-15T14:09:32+08:00  
> 文件語言：繁體中文  
> 版本：v2.0.0 - 包含官方最新指令與完整旗標參考

---

## 📋 目錄

- [📋 目錄](#-目錄)
- [🎯 專案簡介](#-專案簡介)
- [📚 文件清單與功能索引](#-文件清單與功能索引)
  - [🎯 主要文件](#-主要文件)
  - [🔧 功能專門文件](#-功能專門文件)
- [💻 安裝步驟](#-安裝步驟)
  - [🔧 基本環境需求](#-基本環境需求)
  - [📦 推薦安裝方式](#-推薦安裝方式)
  - [🖥️ 各平台安裝指引](#️-各平台安裝指引)
- [🚀 快速開始指引](#-快速開始指引)
  - [初次使用者](#初次使用者)
  - [依使用場景快速導航](#依使用場景快速導航)
  - [依角色推薦](#依角色推薦)
- [⭐ 主要功能特色](#-主要功能特色)
  - [🤖 AI 輔助開發](#-ai-輔助開發)
  - [🔧 進階功能](#-進階功能)
  - [📊 監控與管理](#-監控與管理)
  - [🖥️ 使用者介面](#️-使用者介面)
- [📖 CLI 指令完整參考](#-cli-指令完整參考)
  - [基本指令](#基本指令)
  - [進階旗標與選項](#進階旗標與選項)
  - [MCP 管理指令](#mcp-管理指令)
  - [斜線命令系統](#斜線命令系統)
- [🎯 常用旗標快查](#-常用旗標快查)
- [📖 文件內容導覽](#-文件內容導覽)
  - [📚 文件總覽 (README.md)](#-文件總覽-readmemd)
  - [🎯 綜合代理主控手冊 (cursor-claude-master-guide-zh-tw.md)](#-綜合代理主控手冊-cursor-claude-master-guide-zh-twmd)
  - [📖 基礎 API 指南 (claude-code-guide-zh-tw.md)](#-基礎-api-指南-claude-code-guide-zh-twmd)
  - [⭐ 社群最佳實踐 (awesome-claude-code-zh-tw.md)](#-社群最佳實踐-awesome-claude-code-zh-twmd)
  - [📊 用量監控與安全 (claude-code-usage-monitor-zh-tw.md)](#-用量監控與安全-claude-code-usage-monitor-zh-twmd)
  - [🖥️ Web UI 與視覺化 (claudecodeui-zh-tw.md)](#️-web-ui-與視覺化-claudecodeui-zh-twmd)
  - [⚡ 效能優化策略 (bplustree3-zh-tw.md)](#-效能優化策略-bplustree3-zh-twmd)
  - [🔧 高階旗標系統 (superclaude-zh-tw.md)](#-高階旗標系統-superclaude-zh-twmd)
- [❓ 常見問題與疑難排解](#-常見問題與疑難排解)
- [🌟 社群資源與延伸閱讀](#-社群資源與延伸閱讀)

---

## 🎯 專案簡介

本專案是一個完整的 **Claude Code 中文文件整合庫**，收錄了 Claude Code 與 Cursor AI 的全方位使用指南。涵蓋從基礎安裝到進階功能、從日常開發到生產部署、從個人使用到團隊協作的完整流程。

### 專案特色

- **🌐 全繁體中文化**：所有文件均為繁體中文，符合華語使用者習慣
- **📋 系統化整理**：8 個專門文件涵蓋不同使用場景和功能領域
- **🎯 場景導向**：根據用戶類型（初學者、開發者、架構師、團隊領導）提供差異化指引
- **⚡ 實戰導向**：包含大量實用範例、最佳實踐和疑難排解方案
- **🔄 持續更新**：跟隨 Claude Code 版本更新，確保內容時效性
- **📱 完整指令參考**：整合官方最新 CLI 選項、旗標、MCP 命令等

### 適用對象

- **AI 輔助開發初學者**：想要開始使用 Claude Code 進行程式開發
- **專業開發者**：希望提升開發效率，整合 AI 工具到工作流程
- **架構師**：需要了解 Claude Code 的架構設計和效能優化
- **團隊領導**：計畫在團隊中導入 Claude Code，需要監控和管理功能
- **DevOps 工程師**：負責 Claude Code 的部署、監控和維運

---

## 📚 文件清單與功能索引

### 🎯 主要文件

| 文件名稱 | 核心功能 | 適用對象 | 快速連結 |
|----------|----------|----------|----------|
| **[cursor-claude-master-guide-zh-tw.md](docs/cursor-claude-master-guide-zh-tw.md)** | 綜合代理主控手冊 | 所有用戶 | **必讀** |

### 🔧 功能專門文件

| 文件名稱 | 主要內容 | 關鍵旗標 | 使用場景 |
|----------|----------|----------|----------|
| [awesome-claude-code-zh-tw.md](docs/awesome-claude-code-zh-tw.md) | 社群最佳實踐 | `--hooks` `--workflow` | 專案初始化、團隊協作 |
| [superclaude-zh-tw.md](docs/superclaude-zh-tw.md) | 高階旗標系統 | `--persona` `--advanced` | 複雜任務自動化 |
| [claude-code-guide-zh-tw.md](docs/claude-code-guide-zh-tw.md) | 基礎 API 指南 | `--api` `--mcp` `--session` | 日常開發、基礎操作 |
| [claude-code-usage-monitor-zh-tw.md](docs/claude-code-usage-monitor-zh-tw.md) | 用量監控與安全 | `--monitor` `--limit` `--audit` | 生產環境、成本控制 |
| [claudecodeui-zh-tw.md](docs/claudecodeui-zh-tw.md) | Web UI 與視覺化 | `--ui` `--pwa` `--dashboard` | 圖形介面、遠端管理 |
| [bplustree3-zh-tw.md](docs/bplustree3-zh-tw.md) | 效能優化策略 | `--cache` `--optimize` `--profile` | 大型專案、效能調優 |

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

# 設定 API Key
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

#### Arch Linux

```bash
# 使用 AUR 套件管理器
yay -S claude-code
# 或
paru -S claude-code
```

#### Windows/WSL

```bash
# 在 WSL Ubuntu 環境中執行
sudo apt update && sudo apt install -y nodejs npm
npm install -g @anthropic-ai/claude-code
```

#### Docker 容器化部署

```bash
# 參考 claudebox 專案
git clone https://github.com/RchGrav/claudebox
cd claudebox
docker build -t claude-code .
docker run -it claude-code
```

---

## 🚀 快速開始指引

### 初次使用者

1. **閱讀主控手冊**：從 [cursor-claude-master-guide-zh-tw.md](docs/cursor-claude-master-guide-zh-tw.md) 開始，了解整體架構
2. **學習基礎操作**：參考 [claude-code-guide-zh-tw.md](docs/claude-code-guide-zh-tw.md) 掌握基本指令
3. **探索進階功能**：根據需求查閱其他專門文件

### 依使用場景快速導航

```yaml
專案建立: awesome-claude-code-zh-tw.md + superclaude-zh-tw.md
程式碼修復: claude-code-guide-zh-tw.md + awesome-claude-code-zh-tw.md
生產部署: claude-code-usage-monitor-zh-tw.md + claudecodeui-zh-tw.md
效能優化: bplustree3-zh-tw.md + claude-code-usage-monitor-zh-tw.md
團隊協作: awesome-claude-code-zh-tw.md + claudecodeui-zh-tw.md
```

### 依角色推薦

- **初學者**：guide → awesome → ui
- **開發者**：guide → superclaude → monitor
- **團隊領導**：monitor → awesome → ui
- **架構師**：bplustree → guide → superclaude

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
- **自訂 Hooks**：在開發流程中整合自訂腳本
- **Slash Commands**：快速執行常用指令

### 📊 監控與管理

- **用量監控**：即時監控 API 使用量和成本
- **安全控制**：權限管理和安全掃描
- **效能分析**：程式碼效能分析和優化建議
- **稽核日誌**：完整的操作記錄和追蹤

### 🖥️ 使用者介面

- **CLI 介面**：強大的命令列介面
- **Web UI**：直觀的網頁管理介面
- **PWA 支援**：可安裝到桌面和行動裝置
- **IDE 整合**：支援 VSCode、Cursor 等編輯器

---

## 📖 CLI 指令完整參考

### 基本指令

| 指令 | 功能 | 範例 | 說明 |
|------|------|------|------|
| `claude` | 啟動互動 REPL | `claude` | 進入交互式對話模式 |
| `claude "query"` | 直接執行查詢 | `claude "分析這個專案"` | 執行單次查詢後退出 |
| `claude -p "query"` | 非互動查詢 | `claude -p "解釋這個函數"` | 查詢後立即退出 |
| `claude -c` | 繼續最近對話 | `claude -c` | 恢復上次對話狀態 |
| `claude update` | 更新版本 | `claude update` | 升級到最新版本 |
| `claude mcp` | MCP 管理 | `claude mcp list` | 管理 MCP 伺服器 |

### 進階旗標與選項

| 旗標 | 功能 | 範例 | 適用場景 |
|------|------|------|----------|
| `--model` | 指定模型 | `--model claude-opus-4` | 選擇特定 AI 模型 |
| `--verbose` | 詳細輸出 | `claude --verbose` | 除錯和詳細記錄 |
| `--output-format` | 輸出格式 | `--output-format json` | 結構化輸出 |
| `--allowedTools` | 允許工具 | `--allowedTools "Edit,View"` | 安全控制 |
| `--timeout` | 逾時設定 | `--timeout 60` | 設定命令逾時 |
| `--stream` | 串流輸出 | `--stream` | 大型輸出加速 |
| `--add-dir` | 添加目錄 | `--add-dir ../shared` | 擴展專案範圍 |

### MCP 管理指令

| 指令 | 功能 | 範例 | 說明 |
|------|------|------|------|
| `claude mcp add` | 新增 MCP 伺服器 | `claude mcp add weather /path/to/server` | 添加本地 stdio 伺服器 |
| `claude mcp add --transport sse` | 新增 SSE 伺服器 | `claude mcp add --transport sse api https://api.example.com` | 添加遠端 SSE 伺服器 |
| `claude mcp add --transport http` | 新增 HTTP 伺服器 | `claude mcp add --transport http rest https://api.example.com` | 添加 HTTP API 伺服器 |
| `claude mcp list` | 列出伺服器 | `claude mcp list` | 查看所有已配置的伺服器 |
| `claude mcp get` | 查看伺服器詳情 | `claude mcp get weather` | 檢視特定伺服器配置 |
| `claude mcp remove` | 移除伺服器 | `claude mcp remove weather` | 刪除指定伺服器 |
| `claude mcp serve` | 啟動伺服器模式 | `claude mcp serve` | 將 Claude Code 作為 MCP 伺服器 |

### 斜線命令系統

| 命令 | 功能 | 範例 | 用途 |
|------|------|------|------|
| `/help` | 顯示幫助 | `/help` | 查看可用命令 |
| `/clear` | 清除歷史 | `/clear` | 重置對話狀態 |
| `/memory` | 記憶體管理 | `/memory view` | 管理專案記憶 |
| `/config` | 配置管理 | `/config list` | 查看和修改設定 |
| `/doctor` | 健康檢查 | `/doctor` | 診斷系統狀態 |
| `/init` | 初始化專案 | `/init` | 創建 CLAUDE.md |
| `/mcp` | MCP 管理 | `/mcp` | 互動式 MCP 管理 |
| `/review` | 程式碼審查 | `/review src/` | 審查指定目錄 |

---

## 🎯 常用旗標快查

| 動作 | 推薦旗標組合 | 參考文件 | 使用範例 |
|------|-------------|----------|----------|
| 建立專案 | `--create --template --mcp` | superclaude + guide | `claude --create --template=react --mcp` |
| 修復錯誤 | `--scan --fix --lint --test` | awesome + monitor | `claude "修復所有錯誤" --scan --fix` |
| 部署上線 | `--build --deploy --monitor` | guide + ui | `claude "部署到生產" --build --deploy` |
| 效能調優 | `--profile --optimize --cache` | bplustree + monitor | `claude "優化效能" --profile --optimize` |
| 安全檢查 | `--security --audit --scan` | monitor + awesome | `claude "安全掃描" --security --audit` |
| 程式碼審查 | `--review --verbose --format=json` | guide + awesome | `claude /review --verbose --output-format json` |

---

## 📖 文件內容導覽

### 📚 文件總覽 (README.md)

**主要內容：**
- 完整的文件索引和分類
- 快速導航和使用建議
- 按角色和任務的推薦閱讀順序

**重點章節：**
- 文件清單與功能對應
- 常用旗標快速查詢
- 文件更新機制說明

### 🎯 綜合代理主控手冊 (cursor-claude-master-guide-zh-tw.md)

**主要內容：**
- 模糊需求解析引擎
- 統一旗標索引系統
- Sequential-Thinking 執行流程
- 安全控制與監控機制

**重點章節：**
- 核心架構與角色定義
- 自動化指令映射表
- 錯誤處理與修復流程
- 實戰範例與使用場景

### 📖 基礎 API 指南 (claude-code-guide-zh-tw.md)

**主要內容：**
- Claude Code 產品概覽
- 安裝與系統需求
- 核心指令與旗標
- CLAUDE.md 與記憶體管理

**重點章節：**
- 快速入門指南
- Session/Config/MCP 指令
- 自動化與腳本整合
- 疑難排解與常見問題

### ⭐ 社群最佳實踐 (awesome-claude-code-zh-tw.md)

**主要內容：**
- Workflow & Knowledge Guides
- Tooling & IDE 整合
- Hooks 實例與最佳實踐
- Slash-Commands 精選

**重點章節：**
- CLAUDE.md 實戰範例
- MCP 整合與自動化
- 社群貢獻與參與
- 官方文檔與延伸閱讀

### 📊 用量監控與安全 (claude-code-usage-monitor-zh-tw.md)

**主要內容：**
- 產品簡介與特色
- 多種安裝方式詳解
- 啟動與基本用法
- 進階設定與參數

**重點章節：**
- Docker/Web Dashboard
- 常見問題與除錯
- 開發、測試與貢獻
- ML/未來規劃

### 🖥️ Web UI 與視覺化 (claudecodeui-zh-tw.md)

**主要內容：**
- 產品概覽與特色
- 安裝與環境設置
- 啟動與開發模式
- PWA 圖示與資源生成

**重點章節：**
- CLI 與 Claude Code 整合
- 開發流程與常用指令
- 最佳實踐與疑難排解
- Service Worker 整合

### ⚡ 效能優化策略 (bplustree3-zh-tw.md)

**主要內容：**
- 設計理念與資料結構
- 核心 API 與用法
- 範例程式碼
- 常見操作與進階技巧

**重點章節：**
- 最佳實踐與效能建議
- 疑難排解與常見問題
- 應用場景與實作範例
- 社群資源與延伸閱讀

### 🔧 高階旗標系統 (superclaude-zh-tw.md)

**主要內容：**
- 安裝與啟動
- 指令分類與旗標
- 代表性 Workflow 範例
- MCP、Persona、旗標整合

**重點章節：**
- 專案結構與自訂
- 社群貢獻與參與
- 最佳實踐與使用建議
- 常見問題與延伸閱讀

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
**解決**：設定 `claude config set allowedTools '["Edit","View","Bash"]'`

### 🤖 MCP 相關問題

**問題**：MCP 服務異常  
**解決**：執行 `claude mcp restart --all`

**問題**：MCP 無法啟動  
**解決**：檢查 MCP 配置並重新安裝

### 🔍 診斷與健康檢查

```bash
# 健康檢查指令
claude --version          # 檢查版本
claude --help            # 顯示幫助
claude config list       # 查看配置
claude /doctor           # 診斷模式

# 除錯模式
claude --verbose         # 詳細輸出
claude --mcp-debug       # MCP 除錯
```

---

## 🌟 社群資源與延伸閱讀

### 📚 官方資源

- [Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
- [GitHub 官方倉庫](https://github.com/anthropic/claude-code)
- [API 參考文檔](https://docs.anthropic.com/en/docs/claude-code/api/overview)

### 🌐 社群專案

- [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide) - 社群指南
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - 精選資源
- [NomenAK/SuperClaude](https://github.com/NomenAK/SuperClaude) - 高階配置框架
- [siteboon/claudecodeui](https://github.com/siteboon/claudecodeui) - Web UI 界面

### 🔧 監控與工具

- [Maciek-roboblog/Claude-Code-Usage-Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) - 用量監控
- [RchGrav/claudebox](https://github.com/RchGrav/claudebox) - Docker 容器化

### 🎯 特殊用途

- [KentBeck/BPlusTree3](https://github.com/KentBeck/BPlusTree3) - 效能優化資料結構

---

## 💡 使用建議

1. **建議將 `cursor-claude-master-guide-zh-tw.md` 設為書籤**，它包含所有其他文件的精華整合與快速查詢功能
2. **根據你的角色選擇閱讀順序**：初學者從基礎開始，專家直接查看進階功能
3. **保持文件更新**：定期檢查官方倉庫和社群資源的最新版本
4. **實踐導向**：邊閱讀邊實作，將理論知識轉化為實際技能
5. **善用指令參考**：本文件提供完整的 CLI 選項和旗標說明，可快速查找所需功能

---

**📝 文件維護說明**

- **版本更新**：當任一子文件更新時，需同步更新本索引
- **內容完整性**：確保所有重要功能都有對應的文件說明
- **使用者體驗**：持續優化導航結構和內容組織
- **指令同步**：定期檢查官方文檔更新，保持指令參考的最新性

---

*最後更新：2025-07-15 | 語言：繁體中文 | 專案維護者：Claude Code 中文社群*