# Claude Code Custom Agents 中文說明書

## 概述

Claude Code Custom Agents 是一個專為 Claude Code 設計的自訂代理集合，提供 **7 個專業化的 AI 助手**，涵蓋**程式碼重構**、**前端設計**、**專案規劃**、**安全審查**、**內容撰寫**等多個開發領域。這些代理經過精心設計，能夠獨立或協作處理從程式碼優化到專案管理的各種開發需求。

支援專案特定和全域部署兩種模式，開發者可以根據需求靈活選擇。每個代理都遵循 Claude Code 的 Subagent 架構，提供一致的調用介面和協作機制。

> **專案資訊**
>
> - **專案名稱**：Claude Code Custom Agents
> - **專案版本**：v1.0
> - **專案最後更新**：2025-07-25
> - **文件整理時間**：2025-11-24T05:35:00+08:00
>
> **核心定位**
>
> - **功能**：7 個專業化 AI 代理，提供程式碼重構、前端設計、專案規劃、安全審查、內容撰寫等全方位支援
> - **場景**：程式碼開發、專案管理、內容創作、學習輔助、安全審查
> - **客群**：全端開發者、專案經理、技術寫作者、學習者
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/iannuttall/claude-agents)
> - [Claude Code Subagents 官方文檔](https://docs.anthropic.com/en/docs/claude-code/subagents)
> - [MCP 協議文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 可用代理](#2-可用代理)
- [3. 安裝與配置](#3-安裝與配置)
- [4. 使用指南](#4-使用指南)
- [5. 代理詳解](#5-代理詳解)
- [6. 自訂與擴展](#6-自訂與擴展)
- [7. 最佳實踐](#7-最佳實踐)
- [8. 疑難排解](#8-疑難排解)
- [9. 延伸閱讀](#9-延伸閱讀)

---

## 1. 專案簡介

Claude Code Custom Agents 是一個專為 Claude Code 設計的自訂代理集合，提供多種專業化的 AI 助手，協助開發者在不同領域和任務中獲得更好的支援。這些代理經過精心設計，能夠處理從程式碼重構到專案規劃的各種開發需求。

### 1.1 核心特色

- **專業化代理**：7 個專門設計的代理，涵蓋不同開發領域
- **即插即用**：簡單的安裝和配置流程
- **靈活部署**：支援專案特定和全域使用
- **持續更新**：定期更新和改進代理功能
- **社群驅動**：基於社群需求開發和優化

### 1.2 使用場景

- **程式碼開發**：程式碼重構、前端設計、安全審查
- **專案管理**：專案規劃、任務分解、需求文件撰寫
- **內容創作**：技術文件、內容撰寫、設計指導
- **學習輔助**：程式設計指導、最佳實踐學習

---

## 2. 可用代理

### 2.1 開發輔助代理

#### **code-refactorer**

- **功能**：程式碼重構輔助，改善程式碼結構、可讀性和可維護性，同時保持功能不變
- **適用場景**：
  - 清理混亂的程式碼
  - 減少重複代碼
  - 改善命名
  - 簡化複雜邏輯
  - 重組程式碼以提高清晰度
- **特色**：
  - 系統化分析（重複、命名、複雜度、函數大小、設計模式）
  - 具體重構建議（說明問題和原因）
  - 保持功能一致性
  - 增量改進而非完全重寫
- **工具**：Edit, MultiEdit, Write, NotebookEdit, Grep, LS, Read

#### **frontend-designer**

- **功能**：將設計稿、線框圖或視覺概念轉換為詳細的技術規格和實作指南
- **適用場景**：
  - 分析 UI/UX 設計
  - 創建設計系統
  - 生成元件架構
  - 產生開發者可用的完整文件
- **特色**：
  - 視覺分解（原子設計模式、顏色、字體、間距）
  - 生成設計 Schema（JSON 格式）
  - 元件架構規劃
  - 響應式設計規範
- **工具**：Edit, MultiEdit, Write, NotebookEdit, Grep, LS, Read

### 2.2 專案管理代理

#### **project-task-planner**

- **功能**：從產品需求文件（PRD）創建完整的開發任務清單
- **適用場景**：
  - 從 PRD 生成開發路線圖
  - 創建結構化任務清單
  - 涵蓋從初始設置到部署維護的所有方面
- **特色**：
  - 需要 PRD 作為輸入
  - 生成 `plan.md` 文件
  - 包含主要開發階段（專案設置、後端開發、前端開發、整合）
  - 每個功能包含後端和前端任務
- **工具**：Task, Bash, Edit, MultiEdit, Write, NotebookEdit, Grep, LS, Read, ExitPlanMode, TodoWrite, WebSearch

#### **prd-writer**

- **功能**：產品需求文件撰寫
- **適用場景**：產品規劃、需求分析、規格文件
- **特色**：結構化模板、需求追蹤

### 2.3 品質與安全代理

#### **security-auditor**

- **功能**：執行全面的安全審計，識別漏洞並生成詳細的安全報告
- **適用場景**：
  - 程式碼庫安全審計
  - API 安全檢查
  - 認證機制審查
  - 依賴項安全檢查
- **特色**：
  - 系統化檢查（認證、輸入驗證、資料保護、API 安全、依賴項、配置）
  - 生成 `security-report.md` 文件
  - 漏洞嚴重性評級（Critical, High, Medium, Low）
  - 具體修復步驟（Markdown 檢查清單）
  - 參考相關安全標準
- **工具**：Task, Bash, Edit, MultiEdit, Write, NotebookEdit

#### **vibe-coding-coach**

- **功能**：程式設計指導和教練
- **適用場景**：學習新技術、最佳實踐指導、問題解決
- **特色**：互動式學習、漸進式指導

### 2.4 內容創作代理

#### **content-writer**

- **功能**：內容撰寫輔助
- **適用場景**：技術文件、部落格文章、說明文件
- **特色**：SEO 優化、內容結構化

---

## 3. 安裝與配置

### 3.1 專案特定使用

為特定專案安裝代理：

```bash
# 在專案根目錄建立代理目錄
mkdir -p .claude/agents

# 複製所有代理到專案目錄
cp agents/*.md .claude/agents/
```

### 3.2 全域使用（所有專案）

為所有專案安裝代理：

```bash
# 建立全域代理目錄
mkdir -p ~/.claude/agents

# 複製所有代理到全域目錄
cp agents/*.md ~/.claude/agents/
```

### 3.3 驗證安裝

安裝完成後，Claude Code 會自動檢測並在適當的任務中使用這些代理。您無需手動調用，Claude Code 會根據您的任務自動選擇最適合的代理。

代理文件格式遵循 Claude Code Subagents 規範，包含：

- `name`: 代理名稱
- `description`: 代理描述和使用場景
- `tools`: 代理可用的工具列表
- `color`: 代理在介面中顯示的顏色

---

## 4. 使用指南

### 4.1 基本使用

#### 自動代理選擇（推薦）

Claude Code 會根據您的任務自動選擇最適合的代理。您只需要描述您的需求：

```bash
# 程式碼重構需求
claude "我剛完成了用戶認證系統的實作，可以幫我清理一下嗎？"
# Claude Code 會自動調用 code-refactorer 代理

# 前端設計需求
claude "我有一個 Figma 設計稿，需要幫我實作成 React 元件"
# Claude Code 會自動調用 frontend-designer 代理

# 專案規劃需求
claude "我有一個 PRD，需要創建開發任務清單"
# Claude Code 會自動調用 project-task-planner 代理

# 安全審計需求
claude "可以幫我進行安全審計嗎？"
# Claude Code 會自動調用 security-auditor 代理
```

#### 明確指定代理

如果需要明確指定使用特定代理，可以在對話中提及：

```bash
claude "使用 code-refactorer 代理重構這個函數"
claude "使用 frontend-designer 代理分析這個設計稿"
claude "使用 security-auditor 代理檢查這個 API 的安全性"
```

### 4.2 進階使用

#### 代理協作

Claude Code 支援多代理協作，可以讓不同代理處理任務的不同方面：

```bash
# 先進行安全審計，然後重構程式碼
claude "先使用 security-auditor 檢查這個程式碼的安全性，然後使用 code-refactorer 進行重構"
```

#### 代理輸出文件

某些代理會生成文件供後續使用：

- **project-task-planner**: 生成 `plan.md` 開發計劃文件
- **security-auditor**: 生成 `security-report.md` 安全報告文件
- **frontend-designer**: 生成設計 Schema 和元件架構文件

---

## 5. 代理詳解

### 5.1 code-refactorer 代理

#### 主要功能

- **初始評估**：完全理解程式碼的當前功能，絕不建議會改變行為的變更
- **重構目標**：詢問用戶的具體優先級（效能、可讀性、維護痛點、團隊標準）
- **系統化分析**：檢查以下改進機會：
  - **重複**：識別可提取為可重用函數的重複代碼塊
  - **命名**：找出不清楚或誤導性的變數、函數和類別名稱
  - **複雜度**：定位深度巢狀條件、長參數列表或過於複雜的表達式
  - **函數大小**：識別做太多事情的函數，需要分解
  - **設計模式**：識別可以使用已建立模式簡化結構的地方
  - **組織**：發現屬於不同模組或需要更好分組的程式碼
  - **效能**：找出明顯的低效率（如不必要的迴圈或冗餘計算）
- **重構建議**：為每個建議的改進提供具體程式碼區段、問題說明、原因解釋和重構版本

#### 使用範例

```bash
# 清理剛完成的實作
claude "我剛完成了用戶認證系統的實作，可以幫我清理一下嗎？"

# 重構長函數
claude "這個函數可以運作，但它有 200 行，很難理解"

# 處理程式碼審查意見
claude "程式碼審查指出了幾個有重複邏輯和命名不佳的區域"
```

#### 邊界限制

code-refactorer 代理**不會**：

- 添加新功能或能力
- 改變程式的外部行為或 API
- 對未見的程式碼做假設
- 建議沒有具體程式碼範例的理論改進
- 重構已經乾淨且結構良好的程式碼

### 5.2 frontend-designer 代理

#### 主要功能

- **初始發現過程**：
  - 評估框架和技術棧（React, Vue, Angular, Next.js, Tailwind, Material-UI 等）
  - 收集設計資產（UI mockups、線框圖、Figma/Sketch 文件、品牌指南）
- **設計分析過程**：
  - **視覺分解**：系統化分析每個視覺元素
  - 識別原子設計模式（atoms, molecules, organisms）
  - 提取顏色調色板、字體比例、間距系統
  - 映射元件層次結構和關係
  - 記錄互動模式和微動畫
  - 注意響應式行為指標
- **生成設計 Schema**：創建詳細的 JSON schema，包含設計系統、元件規格、響應式斷點等
- **實作指南**：產生開發者可直接使用的詳細實作指南

#### 使用範例

```bash
# 從 Figma mockup 實作 React 元件
claude "我有一個 dashboard 的 Figma 設計稿，需要幫我實作成 React"

# 從現有截圖提取設計系統
claude "這些是我們當前應用的截圖，需要從中提取一致的設計系統"

# 從線框圖創建元件規格
claude "我畫了這個用戶資料頁面的線框圖，應該如何結構化元件？"
```

### 5.3 project-task-planner 代理

#### 主要功能

- **PRD 要求**：需要產品需求文件（PRD）作為輸入，如果沒有 PRD 會要求提供
- **技術澄清**：可能需要詢問技術方面以確定：
  - 資料庫技術偏好
  - 前端框架偏好
  - 認證需求
  - API 設計考量
  - 編碼標準和實踐
- **生成計劃文件**：在用戶指定的位置創建 `plan.md` 文件（如果未指定，會建議位置）
- **開發階段**：必須包含以下主要開發階段（按順序）：
  1. 初始專案設置（資料庫、儲存庫、CI/CD 等）
  2. 後端開發（API 端點、控制器、模型等）
  3. 前端開發（UI 元件、頁面、功能）
  4. 整合（連接前端和後端）
- **功能任務**：每個需求功能都包含後端任務（API 端點、資料庫操作、業務邏輯）和前端任務（UI 元件、狀態管理、用戶互動）

#### 使用範例

```bash
# 從 PRD 創建開發任務清單
claude "我有一個新電商平台的 PRD，可以創建任務清單嗎？"

# 創建 SaaS 產品的開發計劃
claude "我需要為我們的新 SaaS 產品創建開發計劃"
# 代理會先要求提供 PRD
```

#### 輸出格式

生成的 `plan.md` 文件包含：

- 專案設置（儲存庫設置、開發環境配置、資料庫設置、初始專案腳手架）
- 後端基礎（資料庫遷移和模型、認證系統、核心服務和工具、基礎 API 結構）
- 功能特定後端（每個功能的 API 端點、業務邏輯實作）
- 功能特定前端（UI 元件、狀態管理、用戶互動）

### 5.4 security-auditor 代理

#### 主要功能

- **系統化檢查**：系統化檢查整個程式碼庫，專注於：
  - 認證和授權機制
  - 輸入驗證和清理
  - 資料處理和儲存實踐
  - API 端點保護
  - 依賴項管理
  - 配置檔案和環境變數
  - 錯誤處理和日誌記錄
  - 會話管理
  - 加密和雜湊實作
- **生成安全報告**：在用戶指定的位置創建 `security-report.md` 文件（如果未指定，會建議位置）
- **漏洞類別檢查**：
  - **認證與授權**：弱密碼策略、會話管理、JWT 實作缺陷、權限提升向量等
  - **輸入驗證與清理**：SQL/NoSQL 注入、XSS、命令注入、路徑遍歷等
  - **資料保護**：敏感資料暴露、加密問題、資料洩露風險等
  - **API 安全**：端點保護、速率限制、CORS 配置等
  - **依賴項安全**：已知漏洞、過時套件、許可證問題等
- **報告內容**：
  - 發現摘要
  - 漏洞詳細資訊（嚴重性評級：Critical, High, Medium, Low）
  - 突出問題區域的程式碼片段
  - 詳細修復步驟（Markdown 檢查清單）
  - 相關安全標準或最佳實踐的參考

#### 使用範例

```bash
# 執行安全審計
claude "可以幫我進行安全審計嗎？"

# 檢查 API 安全性
claude "我擔心我們的 API 端點可能有安全問題"

# 檢查新功能的安全性
claude "我們剛為應用添加了用戶認證，可以檢查是否安全嗎？"
```

### 5.5 prd-writer 代理

#### 主要功能

- **需求分析**：分析產品需求和功能規格
- **文件撰寫**：撰寫結構化的產品需求文件
- **規格定義**：定義詳細的功能規格和驗收標準
- **需求追蹤**：建立需求追蹤和變更管理流程

#### 使用範例

```bash
# 撰寫 PRD
claude --agent prd-writer "為這個電商平台撰寫產品需求文件"

# 功能規格
claude --agent prd-writer "定義用戶管理功能的詳細規格"

# 需求分析
claude --agent prd-writer "分析這個功能的用戶需求和業務價值"
```

### 5.6 vibe-coding-coach 代理

#### 主要功能

- **技術指導**：提供新技術的學習指導
- **最佳實踐**：教授程式設計最佳實踐
- **問題解決**：協助解決程式設計問題
- **學習路徑**：制定個人化的學習路徑

#### 使用範例

```bash
# 學習新技術
claude --agent vibe-coding-coach "教我如何使用 React Hooks"

# 最佳實踐
claude --agent vibe-coding-coach "解釋 SOLID 原則並提供範例"

# 問題解決
claude --agent vibe-coding-coach "幫我解決這個非同步程式設計問題"
```

### 5.7 content-writer 代理

#### 主要功能

- **內容創作**：撰寫高品質的技術內容
- **SEO 優化**：優化內容以提高搜尋引擎排名
- **結構化寫作**：創建結構化的技術文件
- **內容策略**：制定內容創作和發布策略

#### 使用範例

```bash
# 技術文件
claude --agent content-writer "為這個 API 撰寫技術文件"

# 部落格文章
claude --agent content-writer "撰寫一篇關於微服務架構的技術文章"

# 說明文件
claude --agent content-writer "為這個專案撰寫用戶說明文件"
```

---

## 6. 自訂與擴展

### 6.1 自訂代理

#### 創建自訂代理

您可以基於現有代理創建自訂版本，或創建全新的代理。代理文件使用 Markdown 格式，包含 YAML front matter：

```markdown
---
name: custom-code-refactorer
description: 自訂的程式碼重構代理，專注於 JavaScript/TypeScript
tools: Edit, MultiEdit, Write, NotebookEdit, Grep, LS, Read
color: blue
---

您是一個專注於 JavaScript 和 TypeScript 的資深軟體開發者...
```

#### 代理文件結構

每個代理文件包含：

- **YAML front matter**：
  - `name`: 代理名稱（必需）
  - `description`: 代理描述和使用場景（必需）
  - `tools`: 代理可用的工具列表（可選）
  - `color`: 代理在介面中顯示的顏色（可選）
- **代理指令**：Markdown 格式的詳細指令，描述代理的行為和功能

### 6.2 代理擴展

#### 修改現有代理

您可以複製現有代理文件並進行修改：

```bash
# 複製現有代理
cp .claude/agents/code-refactorer.md .claude/agents/custom-refactorer.md

# 編輯自訂代理
# 修改 name、description 和指令內容
```

#### 代理工具配置

代理可以使用的工具包括：

- `Edit`: 編輯單一檔案
- `MultiEdit`: 同時編輯多個檔案
- `Write`: 創建新檔案
- `NotebookEdit`: 編輯 Jupyter notebook
- `Grep`: 搜尋程式碼
- `LS`: 列出目錄內容
- `Read`: 讀取檔案
- `Task`: 創建任務
- `Bash`: 執行 shell 命令
- `TodoWrite`: 寫入 TODO 清單
- `WebSearch`: 網路搜尋
- `ExitPlanMode`: 退出計劃模式

---

## 7. 最佳實踐

### 7.1 代理選擇策略

#### 根據任務類型選擇

- **程式碼相關**：code-refactorer, vibe-coding-coach
- **設計相關**：frontend-designer, content-writer
- **規劃相關**：project-task-planner, prd-writer
- **安全相關**：security-auditor

#### 根據專案階段選擇

- **規劃階段**：project-task-planner, prd-writer
- **設計階段**：frontend-designer, content-writer
- **開發階段**：code-refactorer, vibe-coding-coach
- **測試階段**：security-auditor, code-refactorer

### 7.2 效能優化

#### 代理快取

```yaml
# 啟用代理快取
caching:
  enabled: true
  ttl: 3600 # 1 小時
  max_size: 100
```

#### 模型選擇

```yaml
# 根據任務複雜性選擇模型
model_selection:
  simple_tasks: "claude-3-haiku-20240307"
  medium_tasks: "claude-3-sonnet-20240229"
  complex_tasks: "claude-3-opus-20240229"
```

### 7.3 成本控制

#### 使用量監控

```yaml
# 監控代理使用量
usage_monitoring:
  enabled: true
  daily_limit: 100
  cost_alerts: true
  preferred_models: ["haiku", "sonnet"]
```

---

## 8. 疑難排解

### 8.1 常見問題

#### 代理無法被自動選擇

**問題**：Claude Code 沒有自動選擇預期的代理

**解決方案**：

- 確保代理文件位於正確的位置（`.claude/agents/` 或 `~/.claude/agents/`）
- 檢查代理文件的格式是否正確（YAML front matter 和 Markdown 內容）
- 在對話中明確提及代理名稱或功能
- 確保代理的 `description` 中包含相關關鍵字

#### 代理文件格式錯誤

**問題**：代理文件無法被 Claude Code 識別

**解決方案**：

```bash
# 檢查文件格式
cat .claude/agents/code-refactorer.md | head -10

# 確保 YAML front matter 格式正確
# 應該以 --- 開始和結束
# name 和 description 欄位是必需的
```

#### 代理工具不可用

**問題**：代理嘗試使用未配置的工具

**解決方案**：

- 檢查代理文件的 `tools` 欄位
- 確保列出的工具是 Claude Code 支援的工具
- 如果不需要特定工具，可以從 `tools` 列表中移除

### 8.2 除錯技巧

#### 檢查代理文件

```bash
# 列出所有已安裝的代理
ls -la .claude/agents/

# 檢查特定代理的內容
cat .claude/agents/code-refactorer.md

# 驗證 YAML front matter
head -10 .claude/agents/code-refactorer.md
```

#### 測試代理

```bash
# 明確指定代理進行測試
claude "使用 code-refactorer 代理重構這個函數：[貼上程式碼]"

# 檢查代理是否正確回應
# 如果代理沒有被調用，檢查描述中的關鍵字是否匹配您的請求
```

#### 代理文件最佳實踐

- **清晰的描述**：`description` 欄位應該清楚說明代理的用途和使用場景
- **範例**：在 `description` 中包含使用範例可以幫助 Claude Code 更好地匹配代理
- **工具選擇**：只列出代理實際需要的工具，避免不必要的工具
- **顏色標識**：使用 `color` 欄位幫助在介面中識別不同代理

---

## 9. 延伸閱讀

### 9.1 官方資源

- [Claude Code Custom Agents GitHub](https://github.com/iannuttall/claude-agents)
- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [MCP 協議文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)

### 9.2 相關專案

- [wshobson/agents](https://github.com/wshobson/agents)
- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)
- [Claude Code Hooks](https://github.com/aliceric27/claude-code-hooks)

### 9.3 學習資源

- [代理架構設計](https://en.wikipedia.org/wiki/Software_agent)
- [程式碼重構最佳實踐](https://refactoring.com/)
- [前端設計原則](https://www.nngroup.com/articles/design-principles/)
- [專案管理方法論](https://www.pmi.org/)

---

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/iannuttall/claude-agents) 與相關文檔。
>
> **版本資訊**：Claude Code Custom Agents v1.0 - 7 個專業化 AI 代理  
> **最後更新**：2025-11-24T05:35:00+08:00  
> **專案更新**：2025-07-25T12:08:37+01:00  
> **主要變更**：更新代理功能描述、使用指南、代理詳解、自訂與擴展說明、疑難排解指南
