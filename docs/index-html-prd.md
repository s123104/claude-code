# index.html 產品需求文檔 (PRD)

> **文檔版本**: 1.0.0  
> **建立時間**: 2025-12-24  
> **目的**: 作為 UI/UX 重構的功能規格基準

---

## 1. 頁面概述

**頁面名稱**: Claude Code 中文指南官方展示頁面  
**頁面 URL**: `index.html`  
**語言**: 繁體中文 (zh-TW)  
**頁面類型**: 單頁應用 (SPA) - 文檔展示 + 功能導覽

---

## 2. 頁面結構總覽

頁面由以下主要區塊組成（由上至下）：

| 順序 | 區塊 ID                  | 區塊名稱                 | 類型     |
| ---- | ------------------------ | ------------------------ | -------- |
| 1    | `loading-overlay`        | 載入動畫                 | 系統層   |
| 2    | `header`                 | 導覽列                   | 固定導覽 |
| 3    | -                        | Hero Section             | 內容區   |
| 4    | `features`               | 功能特色                 | 內容區   |
| 5    | `installation`           | 快速安裝                 | 內容區   |
| 6    | `official-guide`         | 官方功能介紹專區         | 內容區   |
| 7    | `docs-index`             | 完整專案文檔導覽         | 內容區   |
| 8    | -                        | GitHub 開源專案資訊      | 內容區   |
| 9    | `real-features-quickref` | Claude Code 真實功能速查 | 內容區   |
| 10   | `workflows-examples`     | 工作流程與實戰範例       | 內容區   |
| 11   | `faq`                    | 常見問題與疑難排解       | 內容區   |
| 12   | `contact`                | Footer                   | 頁尾     |
| 13   | `easter-egg`             | 隱藏彩蛋                 | 互動功能 |

---

## 3. 各區塊功能詳細規格

### 3.1 載入動畫 (`loading-overlay`)

**功能描述**:

- 全螢幕覆蓋層，顯示旋轉載入指示器
- 頁面完全載入後自動淡出並隱藏

**行為邏輯**:

1. 初始狀態：顯示
2. `window.load` 事件觸發後延遲 500ms
3. 淡出動畫 (opacity → 0)
4. 延遲 300ms 後設為 `display: none`

---

### 3.2 Header 導覽列

**功能描述**:

- 固定於頁面頂部 (sticky)
- 玻璃形態效果 (glass-effect)
- 響應式設計，支援桌面與行動裝置

#### 3.2.1 Logo 區域

**功能**:

- 顯示 "CLAUDE" + "Code" 文字 Logo
- 每個字母具獨立互動效果
- 點擊觸發 `logoClickEffect()` 特效
- 支援 hover 動畫效果

**互動功能**:

- 字母 hover：個別縮放、旋轉、色彩變化動畫
- Logo 點擊：觸發視覺爆炸效果
- 秘密組合偵測：特定字母點擊順序觸發彩蛋

#### 3.2.2 桌面導覽連結

**導覽項目**:
| 連結文字 | 目標錨點 |
|----------|----------|
| 官方指南 | `#official-guide` |
| 文檔導覽 | `#docs-index` |
| 工作流程 | `#workflows-examples` |
| 常見問題 | `#faq` |

**外部連結**:

- GitHub 圖示按鈕 → `https://github.com/s123104/claude-code`

#### 3.2.3 行動版漢堡選單

**功能**:

- 漢堡按鈕 (`mobile-menu-btn`) 切換顯示/隱藏
- 點擊時圖示在 `fa-bars` ↔ `fa-times` 之間切換
- 展開後顯示相同導覽連結
- 點擊導覽連結後自動關閉選單

---

### 3.3 Hero Section

**功能描述**:
首屏展示區，提供產品概述和主要行動呼籲

**內容元素**:

| 元素         | 說明                                                        |
| ------------ | ----------------------------------------------------------- |
| 主標題       | "Claude Code" (漸層文字效果)                                |
| 副標題       | "AI 驅動的終端開發助手，讓您的編程工作流程更加智能化與高效" |
| 終端機模擬區 | 模擬 CLI 安裝與使用流程，含閃爍游標動畫                     |

**終端機模擬內容**:

```
$ npm install -g @anthropic-ai/claude-code
✓ 安裝成功
$ claude "幫我分析這個專案的架構"
正在分析專案結構...█
```

**CTA 按鈕**:
| 按鈕文字 | 類型 | 目標 |
|----------|------|------|
| 立即開始 | 主要 | `#installation` |
| GitHub 專案 | 次要 | 外部連結 (新分頁) |
| 查看官方安裝方式（npm） | 次要 | `#installation` |

---

### 3.4 功能特色區 (`features`)

**功能描述**:
展示 Claude Code 六大核心功能

**功能卡片列表**:

| #   | 圖示            | 標題           | 說明重點                            |
| --- | --------------- | -------------- | ----------------------------------- |
| 1   | `fa-brain`      | 智能程式碼理解 | AI 分析代碼結構、改進建議、問題檢測 |
| 2   | `fa-terminal`   | 終端機整合     | 自然語言指令、無縫開發體驗          |
| 3   | `fa-code`       | 代碼生成       | 多語言框架支援、高品質程式碼生成    |
| 4   | `fa-bug`        | 智能調試       | 自動錯誤識別修復、調試建議          |
| 5   | `fa-chart-line` | 效能監控       | 實時監控、優化建議、資源分析        |
| 6   | `fa-users`      | 團隊協作       | 多人協作、代碼風格統一、最佳實踐    |

**卡片互動**:

- Hover 縮放效果 (`scale-105`)
- 進場動畫 (Intersection Observer)

---

### 3.5 快速安裝區 (`installation`)

**功能描述**:
提供跨平台安裝指南

#### 3.5.1 平台安裝說明 (2x2 Grid)

**Windows 用戶**:

- 原生安裝指令 (無需 WSL)
- Git Bash 路徑設定

**Linux/WSL 用戶**:

- npm 安裝指令
- WSL OS 誤判修復指令
- 環境特色列表（健康檢查、MCP 管理、通知設定）

**macOS 用戶**:

- Homebrew + npm 安裝
- 驗證指令
- 環境特色列表

#### 3.5.2 文檔統計區

**統計卡片** (4 欄):
| 數值 | 標籤 | 說明 |
|------|------|------|
| 52 | 總計文檔 | 完整覆蓋 |
| 19 | 專案指南 | 繁體中文 |
| 29 | 專案文檔 | 獨立專案 |
| 100% | 自動化 CI/CD | 持續整合 |

#### 3.5.3 安裝特色 (4 欄)

| 圖示                 | 標題           | 說明                      |
| -------------------- | -------------- | ------------------------- |
| `fa-magic`           | 一鍵全環境安裝 | WSL2、Node.js、CLI 全自動 |
| `fa-tools`           | 智能問題修復   | npm/nvm 衝突修復          |
| `fa-network-wired`   | 網路連線優化   | DNS 檢測、GitHub 連線測試 |
| `fa-clipboard-check` | 完整驗證測試   | 所有組件正常運作確認      |

#### 3.5.4 一鍵安裝流程 (3 欄卡片)

各平台安裝流程詳細說明：

- **Windows**: WSL2 配置、Ubuntu 預裝、系統需求檢測
- **Linux/WSL**: bash/zsh 版本檢測、套件管理器適配
- **macOS**: zsh/bash 優先檢測、Homebrew 整合

---

### 3.6 官方功能介紹專區 (`official-guide`)

**功能描述**:
官方文檔展示與下載功能區

#### 3.6.1 介紹卡片 (4 欄)

| 圖示                | 標題         | 說明                |
| ------------------- | ------------ | ------------------- |
| `fa-book-open`      | 完整百科全書 | 62 個文檔整合說明   |
| `fa-robot`          | LLM 查詢優化 | 結構化內容設計      |
| `fa-graduation-cap` | 互動式學習   | 上傳至 LLM 互動學習 |
| `fa-rocket`         | 快速上手     | 一鍵安裝腳本        |

#### 3.6.2 官方手冊內容區 (左 2/3 + 右 1/3)

**左側內容**:

- 標題：Claude Code 官方驗證使用手冊
- 版本標籤：v6.0.0、100% 官方驗證、繁體中文
- 功能分類列表 (4 區塊 x 2 欄)：
  - 快速開始內容
  - 進階功能
  - 第三方整合
  - 實戰應用
- 統計數據 (4 欄)：
  - 2000+ 行內容
  - 15+ 主要章節
  - 50+ 實用範例
  - 100% 官方驗證

**右側操作面板**:
| 按鈕 | 功能 | 行為 |
|------|------|------|
| 線上閱讀 | 開啟 Markdown 文件 | 新分頁開啟 `claude-code-zh-tw.md` |
| 下載文檔 | 下載 Markdown | `download` 屬性下載 |
| 複製全文 | 複製文檔內容 | 觸發 `setupCopyGuideContent()` |

**使用建議列表**:

- 下載文檔後上傳至 LLM
- 複製特定章節內容
- 結合實際專案需求
- 查詢疑難排解章節

#### 3.6.3 內容預覽區 (3 欄)

| 標題       | 內容重點                           |
| ---------- | ---------------------------------- |
| 快速開始   | 安裝指令、啟動互動模式             |
| Hooks 功能 | PreToolUse/PostToolUse、自動格式化 |
| 環境變數   | ANTHROPIC_API_KEY、AWS/GCP 整合    |

#### 3.6.4 智能教學功能說明

**功能卡片** (4 欄):

- 智能分級教學
- AI 教學助手
- 個人化教學
- 五級分類
- 循序漸進
- 實戰導向

---

### 3.7 文檔導覽區 (`docs-index`)

**功能描述**:
專案文檔篩選、搜尋與瀏覽

#### 3.7.1 搜尋功能

**搜尋欄位** (`search-projects`):

- 即時篩選功能
- 搜尋專案名稱或功能標籤
- 與分類篩選聯動

#### 3.7.2 分類篩選標籤 (`filter-tabs`)

| 分類     | 篩選值        | 數量 |
| -------- | ------------- | ---- |
| 全部項目 | `all`         | 20   |
| 核心文檔 | `core`        | 3    |
| 增強框架 | `framework`   | 2    |
| AI 代理  | `agents`      | 3    |
| 監控分析 | `monitoring`  | 2    |
| 介面工具 | `interface`   | 3    |
| 效能優化 | `performance` | 1    |
| 安全審查 | `security`    | 1    |
| 指南教學 | `guides`      | 3    |
| 專業工具 | `tools`       | 4    |

**篩選行為**:

- 點擊切換 active 狀態
- 與搜尋欄位聯動篩選
- 即時更新可見專案卡片

#### 3.7.3 專案卡片網格 (`projects-grid`)

**卡片資料結構**:

```
data-category: 分類標籤
data-tags: 搜尋關鍵字
```

**專案卡片列表** (20 個):

| 分類        | 專案名稱                     | 檔案連結                                    |
| ----------- | ---------------------------- | ------------------------------------------- |
| core        | Claude Code 官方手冊         | `claude-code-zh-tw.md`                      |
| core        | 綜合代理主控手冊             | `docs/cursor-claude-master-guide-zh-tw.md`  |
| core        | 完整文檔導覽索引             | `docs/README.md`                            |
| framework   | Awesome Claude Code 資源集   | `docs/awesome-claude-code-zh-tw.md`         |
| framework   | SuperClaude 專業框架         | `docs/superclaude-zh-tw.md`                 |
| agents      | Claude Code Plugins 插件市場 | `docs/agents-zh-tw.md`                      |
| agents      | Contains Studio 代理集合     | `docs/contains-studio-agents-zh-tw.md`      |
| monitoring  | ccusage Family 極速分析      | `docs/ccusage-zh-tw.md`                     |
| interface   | ClaudeCodeUI 全端介面        | `docs/claudecodeui-zh-tw.md`                |
| interface   | opcode 桌面應用              | `docs/opcode-zh-tw.md`                      |
| interface   | Vibe Kanban 專案管理         | `docs/vibe-kanban-zh-tw.md`                 |
| performance | BPlusTree3 效能優化          | `docs/bplustree3-zh-tw.md`                  |
| security    | Claude Code 安全審查工具     | `docs/claude-code-security-review-zh-tw.md` |
| guides      | Claude Code 基礎 API 指南    | `docs/claude-code-guide-zh-tw.md`           |
| guides      | Context Engineering 方法論   | `docs/context-engineering-intro-zh-tw.md`   |
| guides      | MCP 設定指南                 | `docs/mcp-setup-guide-zh-tw.md`             |
| tools       | cc-sdd AI 規格驅動開發       | `docs/claude-code-spec-zh-tw.md`            |

**卡片互動**:

- Hover 縮放效果
- 點擊跳轉至對應文檔（新分頁）
- 進場動畫

---

### 3.8 GitHub 開源專案資訊區

**功能描述**:
GitHub 專案連結與貢獻引導

**按鈕列表**:
| 按鈕 | 連結目標 |
|------|----------|
| 查看源碼 | `https://github.com/s123104/claude-code` |
| 問題回報 | `https://github.com/s123104/claude-code/issues` |
| 參與貢獻 | `https://github.com/s123104/claude-code/blob/main/CONTRIBUTING.md` |

---

### 3.9 真實功能速查區 (`real-features-quickref`)

**功能描述**:
官方驗證功能快速參考

**功能卡片** (6 個 - 3x2 Grid):

| 標題                    | 指令範例                      | 說明                        |
| ----------------------- | ----------------------------- | --------------------------- |
| CLI 互動模式            | `claude-code`                 | 終端機與 Claude 對話        |
| Subagents 多代理協作    | `/agents list`                | 75+ 專業代理系統            |
| MCP 協議整合            | `claude mcp add`              | Model Context Protocol 擴展 |
| Slash Commands 斜線指令 | `/approved-tools`             | 內建快速操作                |
| 流式輸出模式            | `--output-format stream-json` | 即時串流輸出                |
| 權限與設定管理          | `--permission-mode`           | 精細化權限控制              |

---

### 3.10 工作流程與實戰範例區 (`workflows-examples`)

**功能描述**:
實際開發場景最佳實踐

**範例卡片** (4 個 - 2x2 Grid):

| 標題                         | 內容重點                                            |
| ---------------------------- | --------------------------------------------------- |
| Sequential-Thinking 標準流程 | 需求分析 → 計畫拆解 → 逐步執行 → 結果彙整           |
| MCP 多代理協作與自動化       | 外部工具連接、Claude Code 作為 MCP 伺服器、斜線命令 |
| 錯誤修復與自動診斷           | 自動修復語法/相依/部署錯誤、測試框架整合            |
| Web UI 與遠端管理            | PWA、行動裝置、Dashboard、Session 管理、REST API    |

---

### 3.11 常見問題區 (`faq`)

**功能描述**:
問題分類解答

**FAQ 分類** (4 個 - 2x2 Grid):

| 分類           | 內容要點                                             |
| -------------- | ---------------------------------------------------- |
| 安裝與啟動問題 | Node.js 版本、WSL 環境、npm 設定、API 金鑰           |
| 權限與安全問題 | OpenTelemetry 監控、View 權限、避免 skip-permissions |
| 常見錯誤與排查 | npm 配置污染、node/npm 路徑、虛擬化、WSL 2、磁碟空間 |
| 效能與最佳實踐 | 大型專案分析、管道整合、/compact、--cache            |

---

### 3.12 Footer (`contact`)

**功能描述**:
頁面底部資訊

**內容元素**:

- Logo 文字
- 社群連結圖示：
  - GitHub (`fa-github`)
  - 官方文檔 (`fa-book`)
- 版權聲明：© 2025 Claude Code 中文社群
- 更新資訊：最後更新時間、版本號、文檔數量
- MIT License 連結

---

### 3.13 隱藏彩蛋 (`easter-egg`)

**功能描述**:
隱藏互動彩蛋按鈕

**位置**: 固定於右下角 (4x4 像素，初始透明)

**互動行為**:
| 點擊次數 | 訊息 |
|----------|------|
| 1 | 🎉 您找到了隱藏彩蛋！ |
| 3 | 🚀 Claude Code 讓開發更有趣！ |
| 5 | 💡 試試在終端機輸入 "claude --help" |
| 10 | 🎊 您是真正的探索者！+ 彩帶效果 |

---

## 4. JavaScript 功能規格

### 4.1 核心功能函數

| 函數名稱                               | 功能說明                        |
| -------------------------------------- | ------------------------------- |
| `showToast(message, type)`             | 顯示 Toast 通知 (success/error) |
| `handleCopySuccess()`                  | 複製成功處理                    |
| `handleCopyError()`                    | 複製失敗處理                    |
| `confettiEffect()`                     | 彩帶動畫效果                    |
| `logoClickEffect()`                    | Logo 點擊特效                   |
| `createLogoExplosion(container)`       | Logo 爆炸動畫                   |
| `setupClaudeLetters()`                 | 字母互動設置                    |
| `checkClaudeSecrets()`                 | 秘密組合檢測                    |
| `activateSecret(secretId, effect)`     | 啟動秘密效果                    |
| `triggerLetterEffect(letter)`          | 字母特效觸發                    |
| `createMatrixRain()`                   | Matrix 雨效果                   |
| `createMirrorEffect()`                 | 鏡像效果                        |
| `createRainbowWave()`                  | 彩虹波浪效果                    |
| `initAdvancedLogoAnimations()`         | 進階 Logo 動畫初始化            |
| `setupKeyboardSecrets()`               | 鍵盤秘密組合設置                |
| `setupMouseSecrets()`                  | 滑鼠秘密組合設置                |
| `setupTimeBasedSecrets()`              | 時間觸發秘密設置                |
| `createKeyboardRipple()`               | 鍵盤漣漪效果                    |
| `createFloatingLetters()`              | 浮動字母效果                    |
| `createBinaryRain()`                   | 二進制雨效果                    |
| `createKonamiEffect()`                 | Konami 秘技效果                 |
| `isCircularPattern(pattern)`           | 圓形模式檢測                    |
| `createCircularWave(x, y)`             | 圓形波浪效果                    |
| `createClickExplosion(x, y)`           | 點擊爆炸效果                    |
| `createIdleAnimation()`                | 閒置動畫                        |
| `createLeetEffect()`                   | L33t 效果                       |
| `createMidnightEffect()`               | 午夜效果                        |
| `setupCopyGuideContent()`              | 複製指南內容設置                |
| `showManualCopyModal(text)`            | 手動複製 Modal                  |
| `initProjectFiltering()`               | 專案篩選初始化                  |
| `filterProjects(category, searchTerm)` | 專案篩選執行                    |

### 4.2 事件監聽

| 事件         | 對象              | 處理                 |
| ------------ | ----------------- | -------------------- |
| `click`      | `mobile-menu-btn` | 行動選單切換         |
| `click`      | `a[href^="#"]`    | 平滑捲動             |
| `load`       | `window`          | 載入動畫隱藏、初始化 |
| `click`      | `easter-egg`      | 彩蛋計數與訊息       |
| `mouseenter` | Hero 標題         | 脈動動畫             |
| `mouseleave` | Hero 標題         | 移除脈動             |
| `click`      | 篩選按鈕          | 專案篩選             |
| `input`      | 搜尋欄位          | 即時搜尋篩選         |

### 4.3 Intersection Observer

**用途**: 進場動畫觸發

**目標元素**: `.observe-fade` 類別

**配置**:

```javascript
threshold: 0.1;
rootMargin: "0px 0px -50px 0px";
```

**行為**: 元素進入視窗時添加 `in-view` 類別

---

## 5. 響應式斷點

| 斷點 | 寬度   | 說明     |
| ---- | ------ | -------- |
| sm   | 640px  | 小型裝置 |
| md   | 768px  | 平板裝置 |
| lg   | 1024px | 桌面裝置 |
| xl   | 1280px | 大型桌面 |

**行動版特殊處理**:

- 導覽列：漢堡選單取代橫向導覽
- Grid 佈局：從多欄調整為單欄
- 表格：水平捲動 (`overflow-x: auto`)
- 字體大小：調整為適合觸控操作

---

## 6. 外部資源依賴

### 6.1 CDN 資源

| 資源               | 來源                   | 用途     |
| ------------------ | ---------------------- | -------- |
| Tailwind CSS       | `cdn.tailwindcss.com`  | CSS 框架 |
| Font Awesome 6.5.1 | `cdnjs.cloudflare.com` | 圖示庫   |
| Google Fonts       | `fonts.googleapis.com` | 字體     |

### 6.2 字體列表

- Inter (300-900)
- JetBrains Mono (300-700)
- Noto Sans TC (300-700)
- Orbitron (400-900)
- Exo 2 (300-900)
- Rajdhani (300-700)
- Oxanium (300-800)

---

## 7. SEO 與社群分享

### 7.1 Meta 標籤

| 標籤        | 內容                                |
| ----------- | ----------------------------------- |
| title       | Claude Code 中文指南（官方驗證）    |
| description | Claude Code 完整生態系統中文指南... |
| keywords    | Claude Code, AI, 終端, 開發助手...  |
| author      | Claude Code 中文社群                |
| theme-color | #0ea5e9                             |

### 7.2 Open Graph

| 屬性           | 值                                  |
| -------------- | ----------------------------------- |
| og:title       | Claude Code - AI 驅動的終端開發助手 |
| og:description | 完整的 Claude Code 中文指南...      |
| og:type        | website                             |
| og:image       | img/logo.png                        |

### 7.3 Twitter Card

| 屬性                | 值                                  |
| ------------------- | ----------------------------------- |
| twitter:card        | summary_large_image                 |
| twitter:title       | Claude Code - AI 驅動的終端開發助手 |
| twitter:description | 完整的 Claude Code 中文指南...      |

---

## 8. 可存取性 (A11y)

**目標標準**: WCAG 2.1 AA

**已實作功能**:

- 語意化 HTML 結構
- 對比度符合 AA 標準
- 鍵盤導覽支援
- 平滑捲動行為
- 焦點可見狀態

---

## 9. 版本資訊區塊 (頁面內顯示)

**顯示位置**: Footer、安裝區、文檔導覽區

**顯示資訊**:

- 最後更新時間
- 專案版本
- Claude Code 版本
- 文檔數量統計
- 授權資訊 (MIT License)

---

## 10. 附錄：動畫效果清單

| 動畫名稱     | CSS 名稱           | 用途      |
| ------------ | ------------------ | --------- |
| 淡入         | `fadeIn`           | 元素進場  |
| 向上滑入     | `slideUp`          | 元素進場  |
| 向下滑入     | `slideDown`        | 元素進場  |
| 向左滑入     | `slideLeft`        | 元素進場  |
| 向右滑入     | `slideRight`       | 元素進場  |
| 浮動         | `float`            | 裝飾元素  |
| 脈動         | `pulse`            | 強調效果  |
| 終端游標     | `terminalCursor`   | CLI 模擬  |
| 慢速彈跳     | `bounce-slow`      | 裝飾效果  |
| 慢速旋轉     | `spin-slow`        | 載入/裝飾 |
| 漸層動畫     | `gradient`         | 背景/文字 |
| 打字機       | `typing`           | 文字效果  |
| 波浪         | `wave`             | 裝飾效果  |
| 發光         | `glow`             | 強調效果  |
| Logo 旋轉    | `logo-rotate`      | Logo 互動 |
| Logo 脈動    | `logo-pulse`       | Logo 互動 |
| 文字發光     | `text-glow`        | 文字效果  |
| 光環擴展     | `halo-expand`      | Logo 裝飾 |
| 彩虹舞動     | `rainbow-dance`    | 彩蛋效果  |
| Logo 呼吸    | `logo-breath`      | Logo 裝飾 |
| 微光閃爍     | `micro-sparkle`    | 裝飾效果  |
| 神秘光暈     | `mystic-glow`      | 裝飾效果  |
| Premium 漸層 | `premium-gradient` | Logo 字母 |
| 彩帶掉落     | `confetti-fall`    | 彩蛋效果  |

---

## 文檔結束

此 PRD 文檔完整列出 `index.html` 的所有功能與展示內容，可作為 UI/UX 重構的功能規格基準。
