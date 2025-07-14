# Claude Code Guide 中文全解（繁體中文版）

> 本文件彙整自 [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)、官方文檔、CLAUDE.md 及 Context7 技術文檔，涵蓋所有指令、旗標、MCP、最佳實踐與疑難排解。資料來源皆標註於各節，取得時間：2025-07-14T11:51:25+08:00。

---

## 目錄

1. [產品概覽](#1-產品概覽)
2. [安裝與系統需求](#2-安裝與系統需求)
3. [快速入門](#3-快速入門)
4. [核心指令與旗標](#4-核心指令與旗標)
5. [Session/Config/MCP 指令](#5-sessionconfigmcp-指令)
6. [CLAUDE.md 與記憶體管理](#6-claudemd-與記憶體管理)
7. [自動化與腳本整合](#7-自動化與腳本整合)
8. [進階功能與最佳實踐](#8-進階功能與最佳實踐)
9. [疑難排解與常見問題](#9-疑難排解與常見問題)
10. [社群資源與延伸閱讀](#10-社群資源與延伸閱讀)

---

## 1. 產品概覽

Claude Code 是 Anthropic 推出的 AI 編程助手，支援自然語言指令、程式碼自動修復、MCP 多代理協作、專案記憶體管理等功能，適用於 VSCode、Cursor、終端機與多種開發環境。

- 官方文件：[Anthropic Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- 社群指南：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 2. 安裝與系統需求

### 2.1 系統需求

- Node.js 18+（建議 LTS 版）
- 支援 macOS、Linux、WSL/Windows
- 建議於純 Ubuntu WSL 環境安裝，避免 Windows 路徑汙染

### 2.2 安裝方式

- **NPM（官方推薦）**
  ```bash
  npm install -g @anthropic-ai/claude-code
  ```
- **MacOS**
  ```bash
  brew install node
  npm install -g @anthropic-ai/claude-code
  ```
- **Arch Linux AUR**
  ```bash
  yay -S claude-code
  # 或 paru -S claude-code
  ```
- **Docker 容器化**
  參考 [claudebox](https://github.com/RchGrav/claudebox)
- **Windows/WSL**
  1. 啟用 WSL2 並安裝 Ubuntu
  2. 於 Ubuntu 執行：
     ```bash
     sudo apt update && sudo apt install -y nodejs npm
     npm install -g @anthropic-ai/claude-code
     ```

#### 驗證安裝

```bash
which claude
claude --version
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

## 4. 核心指令與旗標

### 4.1 常用指令

| 指令               | 說明           |
| ------------------ | -------------- |
| claude             | 啟動互動 REPL  |
| claude -p "prompt" | 一次性查詢     |
| claude config      | 設定管理       |
| claude update      | 升級至最新版   |
| claude mcp         | MCP 伺服器管理 |

### 4.2 旗標參考

| 旗標                           | 說明                                |
| ------------------------------ | ----------------------------------- |
| --allowedTools                 | 指定允許工具（如 View, Edit, Bash） |
| --apply-patch                  | 啟用自動修復（beta）                |
| --output-format                | 指定輸出格式（如 json, cyclonedx）  |
| --timeout                      | 設定逾時秒數                        |
| --stream                       | 大型 diff 建議加速                  |
| --dangerously-skip-permissions | 跳過權限檢查（僅限測試/容器）       |

#### 常見組合範例

- 安全審查：
  ```bash
  claude -p "檢查 secrets" --allowedTools "View"
  ```
- 自動修復：
  ```bash
  claude -p "修正 lint" --allowedTools "View,Write" --apply-patch
  ```
- 產生 SBOM：
  ```bash
  claude -p "產生 SBOM" --allowedTools "View" --output-format cyclonedx
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 5. Session/Config/MCP 指令

### 5.1 Session 指令

- `claude` 啟動互動模式
- `claude "prompt"` 啟動單次查詢

### 5.2 Config 指令

- `claude config list` 查看所有設定
- `claude config get <key>` 取得設定值
- `claude config set <key> <value>` 設定參數
- `claude config import <file>` 匯入團隊模板

### 5.3 MCP 指令

- `claude mcp` 進入 MCP 管理
- `claude mcp status` 檢查 MCP 狀態
- `claude mcp restart --all` 重啟所有 MCP
- `claude --mcp-debug` 啟用 MCP 除錯

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 6. CLAUDE.md 與記憶體管理

- **CLAUDE.md**：專案根目錄下的記憶體檔案，記錄架構、目標、開發規範等。
- **記憶體指令**：
  - `claude /memory` 編輯記憶體
  - `claude /memory view` 檢視記憶體

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

### 8.1 進階功能

- **多目錄分析**：
  ```bash
  claude --add-dir ../frontend ../backend ../shared
  claude "分析整體架構"
  ```
- **MCP 多代理協作**：
  - `claude mcp` 進入多代理協作模式
  - 支援自訂工具、記憶體、思考鏈
- **思考鏈（Chain of Thought）**：
  - Claude 會於 <thinking> 標籤內先分析再執行工具
  - 可於 API 請求啟用 extended thinking

### 8.2 最佳實踐

- **安全**：
  - 預設僅開啟 View 權限
  - 機密資訊用環境變數
  - 避免於生產環境使用 `--dangerously-skip-permissions`
- **效能**：
  - 大型專案分目錄分析
  - 適當設定 `--output-format`、`--timeout`
- **團隊協作**：
  - 建立團隊模板（如 ~/.claude/templates/team-frontend.json）
  - 統一審查標準與自動化流程

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)｜[官方文檔](https://docs.anthropic.com/en/docs/claude-code)

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

> 本文件最後更新：2025-07-14T11:51:25+08:00
>
> 主要參考來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)、[Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
