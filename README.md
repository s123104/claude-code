<div align="center">
  <img src="img/logo.png" alt="Claude Code Logo" width="200" height="160" />
  
  # Claude Code 中文文件整合專案
  
  **🚀 完整的 Claude Code 與 Cursor AI 整合說明書集合**
  
  [![Version](https://img.shields.io/badge/Version-4.0.0-brightgreen.svg)](https://github.com/s123104/claude-code)
  [![Language](https://img.shields.io/badge/Language-繁體中文-blue.svg)](README.md)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
  [![Claude Code](https://img.shields.io/badge/Claude%20Code-v2.0.27-purple.svg)](https://docs.anthropic.com/en/docs/claude-code)
  [![Documentation](https://img.shields.io/badge/Documentation-19_Projects_100%25-green.svg)](docs/)
  [![Node.js](https://img.shields.io/badge/Node.js-18%2B-green.svg)](https://nodejs.org/)
  [![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)]()
  [![Stars](https://img.shields.io/github/stars/s123104/claude-code?style=social)](https://github.com/s123104/claude-code/stargazers)
  
  > 最後更新：2025-10-28T05:30:00+08:00 | 語言：繁體中文 | 資料來源：Anthropic 官方文件與社群專案  
  > 📊 涵蓋 18 個專案完整文檔 + 超級工作流程大全 + 自動化更新工具鏈
</div>

---

## 📋 目錄

- [🎯 專案簡介](#-專案簡介)
- [🚀 快速開始](#-快速開始)
- [📚 文件清單](#-文件清單)
- [⭐ 主要功能](#-主要功能)
- [🔧 進階使用](#-進階使用)
- [❓ 常見問題](#-常見問題)
- [🌐 社群資源](#-社群資源)
- [🤝 貢獻指南](#-貢獻指南)
- [📜 授權條款](#-授權條款)

---

## 🎯 專案簡介

本專案是一個完整的 **Claude Code 中文文件整合庫**，收錄了 Claude Code 與 Cursor AI 的全方位使用指南。涵蓋從基礎安裝到進階功能、從日常開發到生產部署、從個人使用到團隊協作的完整流程。

### ✨ 專案特色

- **🌐 全繁體中文化** - 所有文件均為繁體中文，符合華語使用者習慣
- **📋 系統化整理** - 19 個專案結構化文檔 + 超級工作流程大全
- **🎯 場景導向** - 根據用戶類型提供差異化指引（新手→專家）
- **⚡ 實戰導向** - 包含大量實用範例、最佳實踐和疑難排解方案
- **🔄 持續更新** - 跟隨 Claude Code v2.0.27 最新版本，100% 覆蓋率
- **🖥️ 現代化介面** - 響應式 Web 介面，支援所有裝置
- **🤖 自動化工具鏈** - 專業的文檔同步與版本追蹤系統
- **📚 完整工作流** - 6 大 Agent 角色 + 3 核心工作流 + 可複用 Prompt 模板

### 👥 適用對象

| 角色                  | 需求                 | 推薦文件                                            |
| --------------------- | -------------------- | --------------------------------------------------- |
| **AI 輔助開發初學者** | 快速上手 Claude Code | [基礎指南](docs/claude-code-guide-zh-tw.md)         |
| **專業開發者**        | 提升開發效率         | [最佳實踐](docs/awesome-claude-code-zh-tw.md)       |
| **架構師**            | 系統架構設計         | [效能優化](docs/bplustree3-zh-tw.md)                |
| **團隊領導**          | 監控管理功能         | [用量監控](docs/claude-code-usage-monitor-zh-tw.md) |
| **DevOps 工程師**     | 部署維運             | [Web UI](docs/claudecodeui-zh-tw.md)                |

---

## 🚀 快速開始

### 📋 系統需求

- **Node.js 18+** (建議使用 LTS 版本)
- **作業系統**: Windows 10+, macOS 10.15+, Ubuntu 20.04+
- **記憶體**: 至少 2GB RAM
- **網路**: 穩定的網路連線

### ⚡ 一鍵安裝

<details>
<summary><strong>🐧 Linux/WSL 用戶</strong></summary>

```bash
# 安裝 Node.js 18+（依發行版）
npm install -g @anthropic-ai/claude-code
claude --version

# WSL 環境修復（如需要）
npm config set os linux
npm install -g @anthropic-ai/claude-code --force --no-os-check
```

</details>

<details>
<summary><strong>🍎 macOS 用戶</strong></summary>

```bash
brew install node
npm install -g @anthropic-ai/claude-code
claude --version
```

</details>

<details>
<summary><strong>🖥️ Windows 用戶（原生）</strong></summary>

```powershell
# 方法一：使用 winget
winget install --id OpenJS.NodeJS.LTS -e --source winget
npm install -g @anthropic-ai/claude-code
claude --version

# 方法二：手動安裝
# 1. 下載並安裝Node.js LTS from https://nodejs.org/
# 2. 開啟 PowerShell 或 CMD
npm install -g @anthropic-ai/claude-code

# 可選：Git Bash 路徑設定
$env:CLAUDE_CODE_GIT_BASH_PATH = "C:\Program Files\Git\bin\bash.exe"
```

</details>

### 🔑 認證設定

```bash
# 方法一：網頁認證（推薦）
claude auth login

# 方法二：API Key 環境變數
export ANTHROPIC_API_KEY=your_api_key_here

# 驗證設定
claude auth status
claude "Hello, Claude Code!"
```

### ✅ 安裝驗證

```bash
# 檢查版本
claude --version

# 執行健康檢查
claude doctor

# 測試基本功能
claude "測試連線成功"
```

---

## 📚 Claude Code 生態系統文件清單

### 🌟 核心官方文件

| 文件                                                                                   | 說明             | 適用對象        | 版本   | 專案獨立性 |
| -------------------------------------------------------------------------------------- | ---------------- | --------------- | ------ | ---------- |
| **[📚 claude-code-zh-tw.md](claude-code-zh-tw.md)**                                    | 官方驗證使用手冊 | 所有用戶 (必讀) | v6.0.0 | 核心文檔   |
| **[🎯 cursor-claude-master-guide-zh-tw.md](docs/cursor-claude-master-guide-zh-tw.md)** | 綜合代理主控手冊 | 所有用戶        | 最新   | 整合文檔   |
| **[📚 docs/anthropic-claude-code-zh-tw/](docs/anthropic-claude-code-zh-tw/)**          | 官方文檔本地鏡像 | 參考查閱        | 即時   | 官方來源   |

---

## 🔧 獨立專案生態系統

### 🎨 增強框架類

專注於擴展 Claude Code 核心功能的框架

| 專案文件                                                             | 專案描述             | 版本     | 最後更新   | 主要功能                              | 獨立性 |
| -------------------------------------------------------------------- | -------------------- | -------- | ---------- | ------------------------------------- | ------ |
| [🔧 superclaude-zh-tw.md](docs/superclaude-zh-tw.md)                 | SuperClaude 專業框架 | v4.1.6   | 2025-10-27 | 26 指令、16 代理、8 MCP、Deep Research | ⭐⭐⭐ |
| [⭐ awesome-claude-code-zh-tw.md](docs/awesome-claude-code-zh-tw.md) | 社群最佳實踐資源集合 | 社群版本 | 2025-08-17 | Hooks、斜線指令、CLAUDE.md 範例       | ⭐⭐⭐ |

#### 適用客群與應用場景（增強框架類）

- **SuperClaude v4.1.6**：功能：26 個斜線指令（`/sc:` 前綴）、16 個專業代理（PM、Deep Research、Security等）、8 個 MCP 伺服器整合、7 種行為模式、深度研究能力（最多 5 次迭代）；應用場景：企業級開發自動化、系統化工作流程、AI 驅動研究與分析、效能優化（減少 30-50% tokens）；適用客群：進階開發者、技術主管、研究團隊、企業開發團隊
- **Awesome Claude Code**：功能：實戰範例與最佳實踐索引；應用場景：專案啟動、流程與 Hooks 實作範本查找；適用客群：所有開發者、技術寫作者
### 🤖 AI 代理類

專業化的 AI 代理和子代理系統

| 專案文件                                                 | 專案描述            | 版本  | 最後更新   | 主要功能                     | 獨立性 |
| -------------------------------------------------------- | ------------------- | ----- | ---------- | ---------------------------- | ------ |
| [🤖 agents-zh-tw.md](docs/agents-zh-tw.md)               | 75 個專業子代理集合 | 最新  | 2025-08-15 | 領域專家代理、智能任務分派   | ⭐⭐⭐ |
| [👥 claude-agents-zh-tw.md](docs/claude-agents-zh-tw.md) | 自訂代理系統        | v1.0+ | 2025-08-14 | 7 個自訂代理、工作流程自動化 | ⭐⭐   |

#### 適用客群與應用場景（AI 代理類）

- **Agents（75 子代理）**：功能：領域專家子代理與智能分工；應用場景：大型專案的多角色協作、按任務自動選用代理；適用客群：產品/工程團隊、專案負責人
- **Claude Agents（自訂 7 代理）**：功能：自訂工作流代理組合；應用場景：專案流程自動化、團隊內客製化協作；適用客群：全端開發者、Tech Lead
### 📊 監控分析類

用量監控、成本分析和效能追蹤工具

| 專案文件                                                                         | 專案描述         | 版本   | 最後更新   | 主要功能                       | 獨立性 |
| -------------------------------------------------------------------------------- | ---------------- | ------ | ---------- | ------------------------------ | ------ |
| [📊 claude-code-usage-monitor-zh-tw.md](docs/claude-code-usage-monitor-zh-tw.md) | 進階用量監控工具 | v3.1.0 | 2025-07-24 | 即時監控、ML 預測、Docker 部署 | ⭐⭐⭐ |
| [⚡ ccusage-zh-tw.md](docs/ccusage-zh-tw.md)                                     | 極速用量分析工具 | v17.1.3 | 2025-10-27 | 快速成本分析、狀態列整合       | ⭐⭐⭐ |

#### 適用客群與應用場景（監控分析類）

- **Usage Monitor**：功能：即時用量監控、ML 預測、Docker 部署；應用場景：生產成本監控、限額預警、趨勢預測；適用客群：產品/技術主管、FinOps、SRE
- **ccusage (v17.1.3)**：功能：極速 CLI 分析、Statusline 狀態列、報表匯出；應用場景：本地開發成本檢視、CI 產出報告；適用客群：日常開發者、資料分析/報表維護
### 🖥️ 介面工具類

Web UI、視覺化界面和開發者工具

| 專案文件                                                             | 專案描述        | 版本 | 最後更新   | 主要功能                     | 獨立性 |
| -------------------------------------------------------------------- | --------------- | ---- | ---------- | ---------------------------- | ------ |
| [🖥️ claudecodeui-zh-tw.md](docs/claudecodeui-zh-tw.md)               | Web UI 管理介面 | 最新 | 2025-08-16 | PWA 支援、專案管理、視覺化   | ⭐⭐⭐ |
| [🐛 claudecode-debugger-zh-tw.md](docs/claudecode-debugger-zh-tw.md) | AI 驅動除錯工具 | 最新 | 2025-08-14 | 多語言錯誤分析、智能修復建議 | ⭐⭐⭐ |

#### 適用客群與應用場景（介面工具類）

- **ClaudeCodeUI**：功能：Web UI、專案/會話管理、PWA；應用場景：遠端/行動端管理、可視化統計；適用客群：DevOps、團隊管理者、移動辦公者
- **Debugger**：功能：AI 驅動除錯、堆疊/模式/上下文分析；應用場景：快速從錯誤到解法、多語言專案維護；適用客群：多語言開發者、維運工程師
### ⚡ 效能優化類

效能調優、資料結構和系統優化

| 專案文件                                           | 專案描述        | 版本 | 最後更新   | 主要功能               | 獨立性 |
| -------------------------------------------------- | --------------- | ---- | ---------- | ---------------------- | ------ |
| [⚡ bplustree3-zh-tw.md](docs/bplustree3-zh-tw.md) | B+Tree 效能優化 | 最新 | 2025-08-17 | 高效資料結構、快取策略 | ⭐⭐⭐ |

#### 適用客群與應用場景（效能優化類）

- **BPlusTree3**：功能：高效 B+Tree（Rust/Python）、範圍查詢與迭代優化；應用場景：大型代碼庫索引、依賴與版本比較、性能基準；適用客群：架構師、性能工程師
### 🛡️ 安全審查類

安全掃描、合規檢查和漏洞分析

| 專案文件                                                                             | 專案描述        | 版本 | 最後更新   | 主要功能                 | 獨立性 |
| ------------------------------------------------------------------------------------ | --------------- | ---- | ---------- | ------------------------ | ------ |
| [🛡️ claude-code-security-review-zh-tw.md](docs/claude-code-security-review-zh-tw.md) | AI 安全審查工具 | 最新 | 2025-08-14 | 自動化安全掃描、合規檢查 | ⭐⭐⭐ |

#### 適用客群與應用場景（安全審查類）

- **Security Review**：功能：PR 差異掃描、PR 評論、報告輸出；應用場景：開發提交流程的安全把關、合規自動化；適用客群：Security/平台團隊、受合規約束團隊
### 📖 指南教學類

基礎教學、API 指南和設定說明

| 專案文件                                                         | 專案描述      | 版本 | 最後更新   | 主要功能              | 獨立性 |
| ---------------------------------------------------------------- | ------------- | ---- | ---------- | --------------------- | ------ |
| [📖 claude-code-guide-zh-tw.md](docs/claude-code-guide-zh-tw.md) | 基礎 API 指南 | 最新 | 2025-08-10 | CLI 操作、基礎設定    | ⭐⭐   |
| [🔧 mcp-setup-guide-zh-tw.md](docs/mcp-setup-guide-zh-tw.md)     | MCP 設定指南  | 最新 | 2025-08-14 | MCP 伺服器配置、OAuth | ⭐⭐   |

#### 適用客群與應用場景（指南教學類）

- **Claude Code Guide**：功能：基礎安裝、CLI/會話操作；應用場景：首次安裝、日常開發指南；適用客群：初學者、日常開發者
- **MCP Setup Guide**：功能：MCP 伺服器配置與 OAuth；應用場景：私有工具鏈/企業整合；適用客群：整合工程師、DevOps

### 🎨 專業工具類

專門工具與特殊應用場景

| 專案文件                                                                             | 專案描述        | 版本 | 最後更新   | 主要功能                     | 獨立性 |
| ------------------------------------------------------------------------------------ | --------------- | ---- | ---------- | ---------------------------- | ------ |
| [📊 claude-code-leaderboard-zh-tw.md](docs/claude-code-leaderboard-zh-tw.md)       | 使用量排行榜    | 最新 | 2025-08-06 | 競爭式用量追蹤、排行榜       | ⭐⭐⭐ |
| [📋 claude-code-spec-zh-tw.md](docs/claude-code-spec-zh-tw.md)                     | 規格驅動開發    | v1.1.5 | 2025-10-27 | cc-sdd CLI、規格驅動開發、12 語言、8 平台     | ⭐⭐⭐ |
| [🖥️ claudia-zh-tw.md](docs/claudia-zh-tw.md)                                       | 桌面 GUI (opcode)   | v0.2.0 | 2025-10-27 | 桌面應用、會話管理、視覺化 ⚠️ 已更名為 opcode   | ⭐⭐⭐ |
| [🎓 context-engineering-intro-zh-tw.md](docs/context-engineering-intro-zh-tw.md)   | 脈絡工程方法論  | 最新 | 2025-08-06 | PRP 方法論、AI 輔助開發      | ⭐⭐   |
| [📋 vibe-kanban-zh-tw.md](docs/vibe-kanban-zh-tw.md)                               | 看板專案管理    | v0.0.111 | 2025-10-27 | Git 整合、多代理協作管理     | ⭐⭐⭐ |
| [🤖 contains-studio-agents-zh-tw.md](docs/contains-studio-agents-zh-tw.md)         | 專業代理庫      | 最新 | 2025-08-16 | 快速開發專業代理、Studio     | ⭐⭐⭐ |

#### 適用客群與應用場景（專業工具類）

- **Leaderboard**：功能：全球使用量排行榜、競爭式追蹤；應用場景：團隊競賽、使用量激勵；適用客群：團隊管理者、社群運營
- **Spec (cc-sdd v1.1.5)**：功能：規格驅動開發工具鏈、cc-sdd CLI、支援 8 個 AI 平台（Claude/Cursor/Gemini/Codex/Copilot/Qwen/Windsurf）、12 種語言、11 個 /kiro:* 斜線指令；應用場景：AI-DLC 開發流程、規格文檔自動化、跨平台 AI 協作；適用客群：架構師、技術寫作者、企業開發團隊
- **opcode (原 Claudia v0.2.0)**：功能：桌面 GUI 應用、CC Agents、會話管理、背景代理執行；應用場景：圖形化專案管理、視覺化監控；適用客群：開發者、PM、設計師
- **Context Engineering**：功能：PRP 方法論、脈絡工程；應用場景：AI 輔助開發最佳實踐、提示工程；適用客群：AI 工程師、研究者
- **Vibe Kanban**：功能：看板管理、Git 整合、多代理協作；應用場景：專案管理、團隊協作；適用客群：專案經理、敏捷團隊
- **Contains Studio Agents**：功能：專業代理庫、快速開發；應用場景：代理快速部署、專業場景定制；適用客群：企業開發者、解決方案架構師
---

## 🎯 專案獨立性說明

### ⭐⭐⭐ 完全獨立專案

- 可單獨安裝使用，不依賴其他專案
- 有自己的 GitHub 倉庫和版本管理
- 具備完整的功能和文檔

### ⭐⭐ 半獨立專案

- 基於 Claude Code 核心功能
- 可獨立使用但功能有限
- 建議搭配其他工具使用

### ⭐ 輔助工具

- 主要為教學或配置用途
- 依賴 Claude Code 主程式
- 提供特定場景解決方案

<!-- 已移除「常用旗標」區塊，統一以真實功能與場景呈現 -->

---

## ⭐ 主要功能

### 🤖 AI 輔助開發

- **自然語言指令** - 使用自然語言與 Claude Code 互動
- **智能程式碼生成** - 根據需求自動生成程式碼
- **錯誤自動修復** - 自動偵測並修復程式碼問題
- **文件自動產生** - 根據程式碼自動生成文件

### 🔧 進階功能

- **MCP 多代理協作** - 支援多個 AI 代理同時協作
- **專案記憶體管理** - 透過 CLAUDE.md 管理專案記憶
- **自訂 Hooks** - 在開發流程中整合自訂腳本
- **Slash Commands** - 快速執行常用指令

### 📊 監控與管理

- **用量監控** - 即時監控 API 使用量和成本
- **安全控制** - 權限管理和安全掃描
- **效能分析** - 程式碼效能分析和優化建議
- **稽核日誌** - 完整的操作記錄和追蹤

### 🖥️ 使用者介面

- **CLI 介面** - 強大的命令列介面
- **Web UI** - 直觀的網頁管理介面
- **PWA 支援** - 可安裝到桌面和行動裝置
- **IDE 整合** - 支援 VSCode、Cursor 等編輯器
- **互動式網頁** - 現代化的 index.html 提供完整的文件瀏覽體驗

---

## 🔧 進階使用

### 🎯 使用場景快速導航

```yaml
專案建立: awesome-claude-code-zh-tw.md + superclaude-zh-tw.md
程式碼修復: claude-code-guide-zh-tw.md + awesome-claude-code-zh-tw.md
生產部署: claude-code-usage-monitor-zh-tw.md + claudecodeui-zh-tw.md
效能優化: bplustree3-zh-tw.md + claude-code-usage-monitor-zh-tw.md
團隊協作: awesome-claude-code-zh-tw.md + claudecodeui-zh-tw.md
```

### 👥 依角色推薦

- **初學者**：guide → awesome → ui
- **開發者**：guide → superclaude → monitor
- **團隊領導**：monitor → awesome → ui
- **架構師**：bplustree → guide → superclaude

### 🛠️ 技術棧

#### 核心技術

- **AI 引擎**: Anthropic Claude 4.0 Sonnet
- **程式語言**: TypeScript / JavaScript
- **執行環境**: Node.js 18+
- **協議支援**: MCP (Model Context Protocol)

#### 支援平台

- **作業系統**: macOS, Linux, Windows
- **開發環境**: VSCode, Cursor, IntelliJ IDEA
- **部署平台**: Docker, Kubernetes, Cloud Functions

---

## ❓ 常見問題

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
claude doctor            # 診斷模式

# 除錯模式
claude --verbose         # 詳細輸出
claude --mcp-debug       # MCP 除錯
```

---

## 🌐 社群資源

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
- [KentBeck/BPlusTree3](https://github.com/KentBeck/BPlusTree3) - 效能優化資料結構

---

## 🤝 貢獻指南

### 如何參與

1. **Fork 專案**到您的 GitHub 帳戶
2. **建立分支** (`git checkout -b feature/amazing-feature`)
3. **提交變更** (`git commit -m 'Add amazing feature'`)
4. **推送分支** (`git push origin feature/amazing-feature`)
5. **發起 Pull Request**

### 貢獻類型

- 🐛 **Bug 修復** - 修復文件錯誤或功能問題
- 📝 **文件更新** - 改善說明文件或新增範例
- 🌟 **新功能** - 新增實用的腳本或工具
- 🎨 **介面改善** - 優化使用者體驗
- 🔧 **效能優化** - 提升系統效能或穩定性

### 社群規範

- 遵循 [GitHub Community Guidelines](https://docs.github.com/en/github/site-policy/github-community-guidelines)
- 使用繁體中文撰寫文件和註解
- 確保程式碼品質和測試覆蓋率
- 尊重所有貢獻者的意見和建議

---

## 📜 授權條款

本專案採用 [MIT License](LICENSE) 授權條款

---

## 🙏 致謝

感謝以下專案和社群的貢獻：

- [Anthropic](https://anthropic.com) - 提供強大的 Claude AI 模型
- [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide) - 社群指南基礎
- [NomenAK/SuperClaude](https://github.com/NomenAK/SuperClaude) - 高階配置框架
- [siteboon/claudecodeui](https://github.com/siteboon/claudecodeui) - Web UI 介面
- [RchGrav/claudebox](https://github.com/RchGrav/claudebox) - Docker 容器化
- [Maciek-roboblog/Claude-Code-Usage-Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) - 用量監控
- [KentBeck/BPlusTree3](https://github.com/KentBeck/BPlusTree3) - 效能優化資料結構

### 特別感謝

- **開發者社群** - 提供寶貴的使用回饋和改進建議
- **文件貢獻者** - 協助完善中文化文件和範例
- **測試用戶** - 協助驗證功能穩定性和可用性

---

## 📞 聯絡我們

- **GitHub Issues**: [提交問題和建議](https://github.com/s123104/claude-code/issues)
- **GitHub Discussions**: [參與社群討論](https://github.com/s123104/claude-code/discussions)
- **官方文檔**: [Anthropic Claude Code](https://docs.anthropic.com/en/docs/claude-code)

---

## 🎉 結語

Claude Code 中文文件整合專案致力於為華語地區的開發者提供最完整、最實用的 AI 輔助開發工具指南。我們相信，透過 AI 技術的力量，每一位開發者都能夠更高效、更愉快地進行程式開發。

### 🚀 立即開始

1. **🔽 安裝 Claude Code** - 使用官方 npm 安裝方式
2. **📚 閱讀文件** - 從主控手冊開始，逐步深入
3. **🎯 實踐應用** - 在您的專案中嘗試各種功能
4. **🤝 參與社群** - 分享經驗，共同成長

### 💡 未來展望

- 🔮 **AI 功能增強** - 持續整合最新的 AI 技術
- 🌍 **多語言支援** - 擴展到更多程式語言和框架
- 🏢 **企業級功能** - 深化企業環境的適配
- 📚 **教育內容** - 增加更多教學和培訓資源

**🌟 如果這個專案對您有幫助，請給我們一個 Star ⭐**

---

**🔖 書籤建議**：將本專案 [README.md](https://github.com/s123104/claude-code) 加入書籤，隨時查閱最新資訊！

---

> **本專案整合 [SuperClaude](./SuperClaude) 智能開發框架，請注意：**
>
> - **授權條款**：本專案與 SuperClaude 均採用 MIT License，詳見 [LICENSE](./LICENSE)
> - **貢獻規範**：請參閱 [CONTRIBUTING.md](./CONTRIBUTING.md)，與 SuperClaude 保持一致
> - **子模組同步**：如需獲取/更新 SuperClaude，請於 clone 後執行：
>   ```bash
>   git submodule update --init --recursive
>   ```
> - **最佳實踐**：fork/clone 本專案時，請務必同步 SuperClaude 以確保功能完整

---

_最後更新：2025-08-20T01:27:23+08:00 | 語言：繁體中文 | 資料來源：Anthropic 官方文件_
