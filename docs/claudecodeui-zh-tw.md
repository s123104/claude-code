# Claude Code UI 中文說明書

## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/siteboon/claudecodeui)
> - [官方網站](https://claudecodeui.siteboon.ai)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [Cursor CLI 文檔](https://docs.cursor.com/en/cli/overview)
> - **文件整理時間：2025-10-28T00:15:00+08:00**
> - **專案版本：v1.8.12**
> - **專案最後更新：2025-10-27**

---

## 目錄

- [1. 產品簡介](#1-產品簡介)
- [2. 核心功能](#2-核心功能)
- [3. 安裝與部署](#3-安裝與部署)
- [4. 使用指南](#4-使用指南)
- [5. 技術架構](#5-技術架構)
- [6. 開發與貢獻](#6-開發與貢獻)
- [7. 常見問題](#7-常見問題)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 產品簡介

Claude Code UI 是一個專為 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 和 [Cursor CLI](https://docs.cursor.com/en/cli/overview) 設計的桌面和行動裝置使用者介面。您可以在本地或遠端使用它來查看 Claude Code 或 Cursor 中的活躍專案和會話，並從任何地方（手機或桌面）對它們進行更改。這為您提供了一個可以在任何地方正常工作的完整介面，真正實現從行動裝置使用 Claude Code 的體驗。

### 1.1 支援的 CLI 與模型

#### CLI 支援
- **Claude Code CLI** - Anthropic 官方命令列介面
- **Cursor CLI** - Cursor 編輯器命令列介面
- **動態切換** - 可在介面中自由切換使用的 CLI

#### 模型支援
- **Claude Sonnet 4** - 最新的 Claude 高效能模型
- **Claude Opus 4.1** - Claude 頂級智能模型
- **GPT-5** - OpenAI 最新一代模型
- 其他 Claude Code 和 Cursor 相容模型

### 1.2 主要特色

- 🖥️ **雙 CLI 支援**：同時支援 Claude Code 和 Cursor CLI
- 📱 **完整行動體驗**：專為觸控裝置優化的介面
- 🌐 **遠端存取**：本地或遠端都能使用
- 🔄 **即時監控**：專案和會話狀態即時更新
- 🎨 **現代化設計**：美觀且易用的使用者體驗
- 🔧 **整合終端**：內建 Shell 終端直接存取 CLI
- 📂 **檔案管理**：互動式檔案樹與即時編輯
- 🔀 **Git 整合**：可視化 Git 操作與分支管理
- 🛡️ **安全優先**：工具預設停用，手動控制權限
- 🤖 **AI 任務管理**：選配 TaskMaster AI 整合

---

## 2. 核心功能

### 2.1 CLI 選擇與切換

- **雙 CLI 支援**：在 Claude Code 和 Cursor CLI 之間選擇
- **統一介面**：無論使用哪個 CLI 都提供一致的體驗
- **即時切換**：可在不同 CLI 之間動態切換
- **配置管理**：為不同 CLI 保存獨立的配置

### 2.2 互動聊天介面

#### 響應式聊天
- **適應性 UI**：使用響應式聊天或切換到 CLI shell
- **即時通訊**：透過 WebSocket 連接串流 AI 回應
- **會話管理**：恢復先前對話或開始新會話
- **訊息歷史**：包含時間戳和中繼資料的完整對話記錄
- **多格式支援**：文字、程式碼區塊和檔案引用

#### 整合終端
- **內建 Shell**：直接存取 Claude Code 或 Cursor CLI
- **即時輸出**：查看命令執行的即時回應
- **互動模式**：完整的 CLI 互動體驗

### 2.3 檔案管理器與編輯器

- **互動式檔案樹**：展開/收合導航瀏覽專案結構
- **即時檔案編輯**：直接在介面中讀取、修改和儲存檔案
- **語法高亮**：支援多種程式語言
- **檔案操作**：建立、重新命名、刪除檔案和目錄
- **搜尋功能**：快速尋找特定檔案

### 2.4 Git Explorer

- **可視化狀態**：查看變更和當前分支狀態
- **暫存操作**：暫存和取消暫存變更
- **提交管理**：建立提交並查看歷史
- **分支切換**：輕鬆切換 Git 分支
- **整合工作流**：直接在 UI 中完成 Git 操作

### 2.5 專案與會話管理

- **自動探索**：自動從 `~/.claude/projects/` 發現專案
- **視覺化瀏覽**：包含中繼資料和會話計數的所有可用專案
- **專案操作**：重新命名、刪除和組織專案
- **智能導航**：快速存取近期專案和會話
- **MCP 支援**：透過 UI 新增您自己的 MCP 伺服器

### 2.6 會話持久化

- **自動儲存**：所有對話自動儲存
- **會話組織**：按專案和時間戳分組
- **會話操作**：重新命名、刪除和匯出對話歷史
- **跨裝置同步**：從任何裝置存取會話

### 2.7 TaskMaster AI 整合（選配）

- **視覺化任務看板**：Kanban 風格的開發任務管理介面
- **PRD 解析器**：建立產品需求文件並解析為結構化任務
- **進度追蹤**：即時狀態更新和完成追蹤
- **AI 驅動規劃**：智能任務生成和依賴管理

### 2.8 行動應用體驗

- **響應式設計**：優化所有螢幕尺寸
- **觸控友好**：滑動手勢和觸控導航
- **行動導航**：底部標籤列便於拇指操作
- **自適應佈局**：可收合側邊欄和智能內容優先級
- **PWA 支援**：新增捷徑到主畫面，行為如原生應用

---

## 3. 安裝與部署

### 3.1 前置需求

- [Node.js](https://nodejs.org/) v20 或更高版本
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) 已安裝並配置，和/或
- [Cursor CLI](https://docs.cursor.com/en/cli/overview) 已安裝並配置

### 3.2 一鍵運行（推薦）

無需安裝，直接運行：

```bash
npx @siteboon/claude-code-ui
```

您的預設瀏覽器將自動開啟 Claude Code UI 介面。

### 3.3 本地開發安裝

#### 1. 克隆專案
```bash
git clone https://github.com/siteboon/claudecodeui.git
cd claudecodeui
```

#### 2. 安裝依賴
```bash
npm install
```

#### 3. 配置環境
```bash
cp .env.example .env
# 編輯 .env 設定您偏好的選項
```

#### 4. 啟動應用程式
```bash
# 開發模式（含熱重載）
npm run dev
```

應用程式將在您於 .env 中指定的埠啟動。

#### 5. 開啟瀏覽器
- 開發模式：`http://localhost:3001`

---

## 4. 安全性與工具配置

**🔒 重要提醒**: 所有 Claude Code 工具預設為**停用狀態**。這可防止潛在的危險操作自動執行。

### 4.1 啟用工具

要使用 Claude Code 的完整功能，您需要手動啟用工具：

1. **開啟工具設定** - 點擊側邊欄的齒輪圖示
2. **選擇性啟用** - 只開啟您需要的工具
3. **套用設定** - 您的偏好設定將保存在本地

**建議做法**: 從基本工具開始啟用，根據需要逐步增加。您可以隨時調整這些設定。

### 4.2 TaskMaster AI 整合（選配）

Claude Code UI 支援 **[TaskMaster AI](https://github.com/eyaltoledano/claude-task-master)**（也稱為 claude-task-master）整合，提供進階專案管理和 AI 驅動的任務規劃。

#### 功能
- AI 驅動的任務生成（從 PRD 產品需求文件）
- 智能任務分解和依賴管理
- 視覺化任務看板和進度追蹤

**設定與文檔**: 訪問 [TaskMaster AI GitHub 儲存庫](https://github.com/eyaltoledano/claude-task-master) 獲取安裝說明、配置指南和使用範例。安裝後，您可以從設定中啟用它。

---

## 5. 使用指南

### 5.1 核心功能使用

#### 專案管理
UI 會自動從 `~/.claude/projects/` 發現 Claude Code 專案，並提供：
- **視覺化專案瀏覽器** - 包含中繼資料和會話數量的所有可用專案
- **專案操作** - 重新命名、刪除和組織專案
- **智能導航** - 快速存取近期專案和會話
- **MCP 支援** - 透過 UI 新增您自己的 MCP 伺服器

#### 聊天介面
- **響應式聊天或 CLI** - 您可以使用適應性聊天介面，或使用 shell 按鈕連接到您選擇的 CLI
- **即時通訊** - 透過 WebSocket 連接串流 Claude 的回應
- **會話管理** - 恢復先前對話或開始新會話
- **訊息歷史** - 包含時間戳和中繼資料的完整對話歷史
- **多格式支援** - 文字、程式碼區塊和檔案引用

#### 檔案總管與編輯器
- **互動式檔案樹** - 使用展開/收合導航瀏覽專案結構
- **即時檔案編輯** - 直接在介面中讀取、修改和儲存檔案
- **語法高亮** - 支援多種程式語言
- **檔案操作** - 建立、重新命名、刪除檔案和目錄

#### Git Explorer
- **可視化 Git 狀態** - 查看變更和當前分支
- **暫存和提交** - 管理您的 Git 工作流
- **分支切換** - 輕鬆切換分支
- **歷史查看** - 檢視提交歷史

#### TaskMaster AI 整合（選配）
- **視覺化任務看板** - Kanban 風格的開發任務管理介面
- **PRD 解析器** - 建立產品需求文件並解析為結構化任務
- **進度追蹤** - 即時狀態更新和完成追蹤

#### 會話管理
- **會話持久化** - 所有對話自動儲存
- **會話組織** - 按專案和時間戳分組會話
- **會話操作** - 重新命名、刪除和匯出對話歷史
- **跨裝置同步** - 從任何裝置存取會話

### 5.2 行動應用
- **響應式設計** - 優化所有螢幕尺寸
- **觸控友好介面** - 滑動手勢和觸控導航
- **行動導航** - 底部標籤列便於拇指操作
- **自適應佈局** - 可收合側邊欄和智能內容優先級
- **新增捷徑到主畫面** - 新增捷徑後應用程式行為如 PWA

---

## 6. 技術架構

### 6.1 系統概覽

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend       │    │  Claude CLI     │
│   (React/Vite)  │◄──►│ (Express/WS)    │◄──►│  Integration    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 6.2 後端 (Node.js + Express)

- **Express Server** - RESTful API 與靜態檔案服務
- **WebSocket Server** - 聊天和專案刷新的通訊
- **CLI 整合（Claude Code / Cursor）** - 程序生成和管理
- **會話管理** - JSONL 解析和對話持久化
- **檔案系統 API** - 為專案提供檔案瀏覽器

### 6.3 前端 (React + Vite)

- **React 18** - 現代元件架構與 hooks
- **CodeMirror** - 進階程式碼編輯器與語法高亮
- **Tailwind CSS** - 實用優先的 CSS 框架
- **React Router** - 客戶端路由
- **WebSocket Client** - 即時通訊

### 6.4 關鍵技術棧

#### 前端依賴
- **UI 元件**: Lucide React 圖示、class-variance-authority
- **程式碼編輯**: @uiw/react-codemirror、CodeMirror 語言套件
- **終端**: xterm.js、xterm-addon-fit、xterm-addon-webgl
- **Markdown**: react-markdown
- **檔案上傳**: react-dropzone

#### 後端依賴
- **伺服器**: Express、WebSocket (ws)、CORS
- **程序管理**: cross-spawn、node-pty
- **認證**: bcrypt、jsonwebtoken
- **資料庫**: better-sqlite3、sqlite3
- **檔案監控**: chokidar
- **工具**: mime-types、multer

---

## 7. 開發與貢獻

我們歡迎貢獻！請遵循以下指南：

### 7.1 開始貢獻

1. **Fork** 專案儲存庫
2. **Clone** 您的 fork: `git clone <your-fork-url>`
3. **安裝** 依賴: `npm install`
4. **建立** 功能分支: `git checkout -b feature/amazing-feature`

### 7.2 開發流程

1. **進行變更** 遵循現有的程式碼風格
2. **徹底測試** - 確保所有功能正常運作
3. **執行品質檢查**: `npm run lint && npm run format`
4. **提交** 使用描述性訊息，遵循 [Conventional Commits](https://conventionalcommits.org/)
5. **推送** 到您的分支: `git push origin feature/amazing-feature`
6. **提交** Pull Request，包含:
   - 清楚的變更描述
   - UI 變更的截圖
   - 測試結果（如適用）

### 7.3 貢獻內容

- **錯誤修復** - 幫助我們改善穩定性
- **新功能** - 增強功能（請先在 issues 中討論）
- **文檔** - 改善指南和 API 文檔
- **UI/UX 改進** - 更好的使用者體驗
- **效能優化** - 讓它更快

---

## 8. 疑難排解

### 8.1 常見問題與解決方案

#### "找不到 Claude 專案"
**問題**: UI 顯示沒有專案或專案列表為空

**解決方案**:
- 確保 [Claude CLI](https://docs.anthropic.com/en/docs/claude-code) 已正確安裝
- 在至少一個專案目錄中執行 `claude` 命令以初始化
- 驗證 `~/.claude/projects/` 目錄存在且有適當權限

#### 檔案總管問題
**問題**: 檔案無法載入、權限錯誤、目錄為空

**解決方案**:
- 檢查專案目錄權限（在終端執行 `ls -la`）
- 驗證專案路徑存在且可存取
- 查看伺服器控制台日誌以取得詳細錯誤訊息
- 確保您不是試圖存取專案範圍外的系統目錄

#### CLI 連接問題
**問題**: 無法連接到 Claude Code 或 Cursor CLI

**解決方案**:
- 確認對應的 CLI 已正確安裝
- 檢查 CLI 是否在系統 PATH 中
- 驗證 API 金鑰配置正確
- 查看終端輸出的錯誤訊息

---

## 9. 延伸閱讀

### 9.1 官方資源

- [官方網站](https://claudecodeui.siteboon.ai)
- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [Cursor CLI 文檔](https://docs.cursor.com/en/cli/overview)
- [Anthropic API 參考](https://docs.anthropic.com/en/api)

### 9.2 社群資源

- [GitHub 專案](https://github.com/siteboon/claudecodeui)
- [GitHub Issues](https://github.com/siteboon/claudecodeui/issues)
- [NPM 套件](https://www.npmjs.com/package/@siteboon/claude-code-ui)

### 9.3 相關專案與技術

#### 建構工具
- **[Claude Code](https://docs.anthropic.com/en/docs/claude-code)** - Anthropic 官方 CLI
- **[Cursor](https://docs.cursor.com)** - AI 驅動的程式碼編輯器
- **[React](https://react.dev/)** - 使用者介面函式庫
- **[Vite](https://vitejs.dev/)** - 快速建置工具和開發伺服器
- **[Tailwind CSS](https://tailwindcss.com/)** - 實用優先的 CSS 框架
- **[CodeMirror](https://codemirror.net/)** - 進階程式碼編輯器
- **[TaskMaster AI](https://github.com/eyaltoledano/claude-task-master)** *(選配)* - AI 驅動的專案管理和任務規劃

### 9.4 支援與社群

#### 保持更新
- **Star** 此儲存庫以表示支持
- **Watch** 獲取更新和新版本通知
- **Follow** 專案以獲取公告

#### 贊助商
- [Siteboon - AI 驅動的網站建構器](https://siteboon.ai)

---

## 授權

GNU General Public License v3.0 - 詳見 [LICENSE](https://github.com/siteboon/claudecodeui/blob/main/LICENSE) 檔案。

此專案是開源的，根據 GPL v3 授權可自由使用、修改和分發。

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/siteboon/claudecodeui) 與 [官方網站](https://claudecodeui.siteboon.ai)。
>
> **版本資訊**：Claude Code UI v1.8.12 - 支援 Claude Code 和 Cursor CLI  
> **最後更新**：2025-10-28T00:15:00+08:00

---

<div align="center">
  <strong>為 Claude Code 社群用心打造。</strong>
</div>
