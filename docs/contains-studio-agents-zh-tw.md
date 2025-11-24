# Contains Studio Agents 中文說明書

## 概述

Contains Studio Agents 是一個綜合性的專業 AI 代理集合，專為加速和增強快速開發的各個方面而設計。該專案提供 **37+ 個專業化 AI 代理**，涵蓋**工程開發**、**設計**、**行銷推廣**、**產品**、**專案管理**、**營運支援**、**測試與基準測試**等 7 大部門，每個代理都是其領域的專家，能在需要時被自動或手動調用。

所有代理均為 Claude Code Subagent 架構，支援自動觸發和明確指定兩種調用模式。專為 **6 天衝刺開發流程**優化，幫助團隊快速迭代和交付價值。只需簡單描述您的任務，系統會自動選擇最適合的代理來協助您完成工作。

> **專案資訊**
>
> - **專案名稱**：Contains Studio Agents
> - **專案版本**：最新版本
> - **專案最後更新**：2025-07-28
> - **文件整理時間**：2025-11-25T02:42:00+08:00
>
> **核心定位**
> - **功能**：37+ 個專業 AI 代理，覆蓋工程、設計、行銷、產品、專案管理、營運、測試等 7 大部門，支援 6 天衝刺開發流程
> - **場景**：快速原型開發、全端應用構建、產品設計、社交媒體行銷、測試優化、營運支援、數據驅動決策
> - **客群**：全端開發者、產品經理、設計師、行銷專員、專案經理、創業團隊、快速迭代團隊
>
> **資料來源**
> - [GitHub 專案](https://github.com/contains-studio/agents)
> - [Claude Code Subagents 官方文檔](https://docs.anthropic.com/en/docs/claude-code/subagents)

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 安裝與設定](#2-安裝與設定)
- [3. 代理分類](#3-代理分類)
- [4. 使用指南](#4-使用指南)
- [5. 專業代理詳解](#5-專業代理詳解)
- [6. 最佳實踐](#6-最佳實踐)
- [7. 延伸閱讀](#7-延伸閱讀)

---

## 1. 專案簡介

Contains Studio Agents 是一個專業 AI 代理的綜合集合，專為加速和增強快速開發的各個方面而設計。每個代理都是其領域的專家，當需要其專業知識時可以隨時調用。

### 1.1 核心特色

- **🎯 專業化分工**：37+ 個代理，每個專精於特定領域
- **⚡ 自動觸發**：根據任務描述自動選擇合適的代理
- **🔄 明確調用**：可以明確指定使用特定代理
- **📦 即插即用**：簡單複製即可使用
- **🔧 可客製化**：提供完整的代理自訂指南和檢查清單
- **🚀 6 天衝刺優化**：專為快速迭代和交付價值設計
- **🎯 主動代理**：部分代理會在特定情境下自動觸發
- **📁 部門組織**：按部門分類，易於發現和管理

### 1.2 代理覆蓋領域

- **工程部門**：前端、後端、全端、行動應用、AI/ML、DevOps、快速原型、測試
- **設計部門**：品牌守護、UI 設計、UX 研究、視覺敘事、趣味注入
- **行銷部門**：應用商店優化、內容創作、成長駭客、Instagram、Reddit、TikTok、Twitter
- **產品部門**：反饋綜合、衝刺優先排序、趨勢研究
- **專案管理**：實驗追蹤、專案交付、工作室製作人
- **營運支援**：分析報告、財務追蹤、基礎設施維護、法律合規、客戶支援
- **測試與基準測試**：API 測試、效能基準、測試結果分析、工具評估、工作流程優化
- **獎勵代理**：工作室教練、幽默助手

---

## 2. 安裝與設定

### 2.1 快速安裝

```bash
# 1. 下載專案
git clone https://github.com/contains-studio/agents.git

# 2. 複製到 Claude Code 代理目錄
cp -r agents/* ~/.claude/agents/

# 3. 重新啟動 Claude Code
# 新代理將自動載入
```

### 2.2 手動安裝

```bash
# 手動複製所有代理檔案到代理目錄
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/

# 驗證安裝
ls ~/.claude/agents/
```

### 2.3 驗證安裝

```bash
# 啟動 Claude Code
claude

# 列出可用代理
/agents

# 測試代理調用
> 請 frontend-specialist 幫我設計一個現代化的登入頁面
```

---

## 3. 代理分類

### 3.1 工程部門 (`engineering/`) - 7 個代理

- **ai-engineer**: AI/ML 功能整合專家，確保功能實際交付
- **backend-architect**: 後端架構師，設計可擴展的 API 和伺服器系統
- **devops-automator**: DevOps 自動化專家，持續部署而不出錯
- **frontend-developer**: 前端開發者，建立極速用戶介面
- **mobile-app-builder**: 行動應用建構者，建立原生 iOS/Android 體驗
- **rapid-prototyper**: 快速原型開發者，幾天內建立 MVP，而非幾週
- **test-writer-fixer**: 測試撰寫修復者，撰寫能發現真實錯誤的測試

### 3.2 設計部門 (`design/`) - 5 個代理

- **brand-guardian**: 品牌守護者，保持視覺識別的一致性
- **ui-designer**: UI 設計師，設計開發者能實際建構的介面
- **ux-researcher**: UX 研究員，將用戶洞察轉化為產品改進
- **visual-storyteller**: 視覺敘事者，建立能轉換和分享的視覺內容
- **whimsy-injector**: 趣味注入者，為每個互動增添樂趣（主動觸發）

### 3.3 行銷部門 (`marketing/`) - 7 個代理

- **app-store-optimizer**: 應用商店優化者，主導應用商店搜尋結果
- **content-creator**: 內容創作者，跨平台生成內容
- **growth-hacker**: 成長駭客，發現和利用病毒式成長循環
- **instagram-curator**: Instagram 策展者，掌握視覺內容遊戲
- **reddit-community-builder**: Reddit 社群建構者，在 Reddit 上獲勝而不被封鎖
- **tiktok-strategist**: TikTok 策略師，建立可分享的行銷時刻
- **twitter-engager**: Twitter 參與者，乘趨勢達到病毒式參與

### 3.4 產品部門 (`product/`) - 3 個代理

- **feedback-synthesizer**: 反饋綜合者，將抱怨轉化為功能
- **sprint-prioritizer**: 衝刺優先排序者，6 天內交付最大價值
- **trend-researcher**: 趨勢研究員，識別病毒式機會

### 3.5 專案管理部門 (`project-management/`) - 3 個代理

- **experiment-tracker**: 實驗追蹤者，數據驅動的功能驗證（主動觸發）
- **project-shipper**: 專案交付者，發布不會崩潰的產品
- **studio-producer**: 工作室製作人，讓團隊持續交付，而非開會

### 3.6 營運支援部門 (`studio-operations/`) - 5 個代理

- **analytics-reporter**: 分析報告者，將數據轉化為可操作的洞察
- **finance-tracker**: 財務追蹤者，保持工作室盈利
- **infrastructure-maintainer**: 基礎設施維護者，擴展而不破產
- **legal-compliance-checker**: 法律合規檢查者，快速移動時保持合法
- **support-responder**: 客戶支援回應者，將憤怒的用戶轉化為擁護者

### 3.7 測試與基準測試部門 (`testing/`) - 5 個代理

- **api-tester**: API 測試者，確保 API 在壓力下正常工作
- **performance-benchmarker**: 效能基準測試者，讓一切更快
- **test-results-analyzer**: 測試結果分析者，在測試失敗中找到模式
- **tool-evaluator**: 工具評估者，選擇真正有幫助的工具
- **workflow-optimizer**: 工作流程優化者，消除工作流程瓶頸

### 3.8 獎勵代理 (`bonus/`) - 2 個代理

- **studio-coach**: 工作室教練，集結 AI 團隊追求卓越（主動觸發）
- **joker**: 幽默助手，用技術幽默輕鬆氣氛

---

## 4. 使用指南

### 4.1 快速開始

代理在 Claude Code 中自動可用。只需描述您的任務，適當的代理就會被觸發。您也可以透過提及代理名稱來明確請求特定代理。

**範例使用**：
- "Create a new app for tracking meditation habits" → `rapid-prototyper`
- "What's trending on TikTok that we could build?" → `trend-researcher`
- "Our app reviews are dropping, what's wrong?" → `feedback-synthesizer`
- "Make this loading screen more fun" → `whimsy-injector`

### 4.2 自動代理選擇

Claude Code 會根據任務描述自動選擇最適合的代理：

```bash
# 前端任務 - 自動選擇 frontend-developer
> 建立一個響應式的電商產品卡片組件

# 後端任務 - 自動選擇 backend-architect
> 設計一個用戶認證和授權系統的 API

# 快速原型 - 自動選擇 rapid-prototyper
> 建立一個追蹤冥想習慣的新應用程式
```

### 4.3 明確代理調用

您也可以明確指定使用特定代理：

```bash
# 明確調用前端開發者
> 請 frontend-developer 幫我優化 React 組件的效能

# 明確調用後端架構師
> 請 backend-architect 設計電商系統的 API 架構

# 明確調用 DevOps 自動化專家
> 請 devops-automator 建立 CI/CD 管道
```

### 4.4 主動觸發代理

部分代理會在特定情境下自動觸發：

- **studio-coach**: 當複雜的多代理任務開始或代理需要指導時
- **test-writer-fixer**: 在實作功能、修復錯誤或修改程式碼後（主動觸發）
- **whimsy-injector**: 在 UI/UX 變更後（主動觸發）
- **experiment-tracker**: 當新增功能標記時（主動觸發）

### 4.5 多代理協作

```bash
# 讓多個代理協作
> 請 sprint-prioritizer 和 frontend-developer 協作設計用戶儀表板

# 順序協作
> 請 backend-architect 先設計 API，然後 frontend-developer 建立前端介面

# 跨部門協作
> 請 ui-designer 設計介面，然後 frontend-developer 實作，最後 whimsy-injector 添加趣味元素
```

---

## 5. 專業代理詳解

### 5.1 Rapid Prototyper（快速原型開發者）

```yaml
專長領域:
  - MVP 快速開發
  - 幾天內建立原型
  - 最小可行產品設計
  - 快速迭代
  - 6 天衝刺優化

常用場景:
  - 新應用程式原型
  - 功能概念驗證
  - 快速市場測試
  - 最小可行產品
  - 快速交付價值
```

### 5.2 Frontend Developer（前端開發者）

```yaml
專長領域:
  - React/Vue/Angular 框架開發
  - 現代 CSS 和樣式框架
  - 前端效能優化
  - 響應式網頁設計
  - 極速用戶介面

常用場景:
  - 組件設計和實作
  - 前端架構規劃
  - 使用者介面優化
  - 跨瀏覽器相容性
  - 前端工具鏈配置
```

### 5.3 Backend Architect（後端架構師）

```yaml
專長領域:
  - RESTful/GraphQL API 設計
  - 可擴展的伺服器系統
  - 微服務架構
  - 資料庫設計和優化
  - 系統擴展性設計

常用場景:
  - 系統架構設計
  - API 端點規劃
  - 資料流程設計
  - 效能瓶頸分析
  - 安全性架構
```

### 5.4 AI Engineer（AI 工程師）

```yaml
專長領域:
  - AI/ML 功能整合
  - 實際交付的 AI 功能
  - 機器學習模型部署
  - AI 功能優化
  - 生產環境 AI 系統

常用場景:
  - AI 功能整合
  - ML 模型部署
  - AI 功能優化
  - 生產環境 AI 系統
  - AI 功能測試
```

### 5.5 DevOps Automator（DevOps 自動化專家）

```yaml
專長領域:
  - CI/CD 管道建立
  - 持續部署而不出錯
  - 基礎設施即程式碼
  - 容器化和編排
  - 自動化部署

常用場景:
  - 建置和部署自動化
  - 基礎設施管理
  - 效能監控設定
  - 災害恢復計劃
  - 成本優化策略
```

### 5.6 Sprint Prioritizer（衝刺優先排序者）

```yaml
專長領域:
  - 6 天內交付最大價值
  - 功能優先級排序
  - 衝刺規劃
  - 價值最大化
  - 快速迭代

常用場景:
  - 衝刺規劃
  - 功能優先級排序
  - 價值最大化
  - 快速交付
  - 資源分配
```

### 5.7 Test Writer Fixer（測試撰寫修復者）

```yaml
專長領域:
  - 撰寫能發現真實錯誤的測試
  - 測試自動化
  - 測試覆蓋率優化
  - 測試修復
  - 品質保證

常用場景:
  - 功能實作後的測試
  - 錯誤修復後的測試
  - 程式碼修改後的測試
  - 測試覆蓋率提升
  - 測試品質改進
```

### 5.8 Studio Coach（工作室教練）

```yaml
專長領域:
  - 集結 AI 團隊追求卓越
  - 多代理任務協調
  - 代理指導
  - 團隊協作優化
  - 工作流程改進

常用場景:
  - 複雜多代理任務開始時
  - 代理需要指導時
  - 團隊協作優化
  - 工作流程改進
  - 任務協調
```

---

## 6. 最佳實踐

### 6.1 代理選擇策略

#### 根據任務複雜度

```yaml
簡單任務:
  - 單一代理處理
  - 明確的功能需求
  - 標準化實作

複雜任務:
  - 多代理協作
  - 階段性實作
  - 跨領域整合

範例:
  簡單: "建立一個按鈕組件" → frontend-developer
  複雜: "建立完整的電商平台" → 多個代理協作（rapid-prototyper + frontend-developer + backend-architect）
```

#### 根據專案階段（6 天衝刺）

```yaml
第 1 天 - 規劃階段:
  - sprint-prioritizer: 功能優先級排序
  - trend-researcher: 市場趨勢研究
  - ui-designer: 設計規劃

第 2-4 天 - 開發階段:
  - rapid-prototyper: 快速原型開發
  - frontend-developer: 前端實作
  - backend-architect: 後端開發
  - ai-engineer: AI 功能整合（如需要）

第 5 天 - 測試階段:
  - test-writer-fixer: 測試撰寫和修復（自動觸發）
  - api-tester: API 測試
  - performance-benchmarker: 效能基準測試

第 6 天 - 部署階段:
  - devops-automator: 部署自動化
  - project-shipper: 產品交付
  - analytics-reporter: 分析報告
```

#### 6 天衝刺最佳實踐

1. **讓代理協作**：許多任務受益於多個代理
2. **明確描述**：清晰的任務描述幫助代理表現更好
3. **信任專業**：代理為其特定領域設計
4. **快速迭代**：代理支援 6 天衝刺哲學

### 6.2 協作模式

#### 並行協作

```bash
# 同時進行的任務
> 請 frontend-developer 設計用戶介面，同時 backend-architect 設計 API 架構
```

#### 順序協作

```bash
# 有依賴關係的任務
> 請 sprint-prioritizer 先定義需求優先級，然後 ui-designer 基於優先級設計介面
```

#### 審查協作

```bash
# 程式碼審查流程
> 請 test-writer-fixer 審查這個認證系統的測試覆蓋率
```

#### 主動觸發協作

```bash
# 代理會自動觸發
> 實作新功能後，test-writer-fixer 會自動撰寫測試
> UI 變更後，whimsy-injector 會自動添加趣味元素
> 新增功能標記後，experiment-tracker 會自動追蹤實驗
```

### 6.3 品質保證

#### 程式碼品質

```yaml
品質檢查流程:
  1. 開發代理實作功能（frontend-developer / backend-architect）
  2. test-writer-fixer 自動撰寫測試（主動觸發）
  3. api-tester 進行 API 測試
  4. performance-benchmarker 執行效能測試
  5. test-results-analyzer 分析測試結果
```

#### 代理效能追蹤

追蹤代理有效性透過：
- **任務完成時間**：代理完成任務的速度
- **用戶滿意度**：用戶對代理輸出的滿意程度
- **錯誤率**：代理產生的錯誤頻率
- **功能採用率**：代理建議的功能被採用的比例
- **開發速度**：使用代理後的開發速度提升

#### 最佳實踐

- **明確需求**：提供清晰的任務描述
- **適當分工**：根據代理專長分配任務
- **階段檢查**：在關鍵節點進行檢查
- **持續改進**：根據結果優化流程
- **信任專業**：讓代理在其專長領域發揮
- **快速迭代**：支援 6 天衝刺開發流程

---

## 7. 代理自訂指南

### 7.1 代理結構

每個代理包含：
- **name**: 唯一識別符（kebab-case）
- **description**: 使用時機 + 3-4 個詳細範例（含上下文和註解）
- **color**: 視覺識別（例如：blue、green、purple、indigo）
- **tools**: 代理可存取的特定工具（Write、Read、MultiEdit、Bash 等）
- **System prompt**: 詳細的專業知識和指示（500+ 字）

### 7.2 新增代理步驟

1. 在適當的部門資料夾中建立新的 `.md` 檔案
2. 遵循現有格式，包含 YAML frontmatter
3. 包含 3-4 個詳細使用範例
4. 撰寫完整的系統提示（500+ 字）
5. 使用真實任務測試代理

### 7.3 代理自訂檢查清單

#### 必要元件

- [ ] **YAML Frontmatter**
  - [ ] `name`: 唯一代理識別符（kebab-case）
  - [ ] `description`: 使用時機 + 3-4 個詳細範例（含上下文/註解）
  - [ ] `color`: 視覺識別
  - [ ] `tools`: 代理可存取的特定工具

#### 系統提示要求（500+ 字）

- [ ] **代理身份**：明確的角色定義和專業領域
- [ ] **核心職責**：5-8 個特定主要職責
- [ ] **領域專業知識**：技術技能和知識領域
- [ ] **工作室整合**：代理如何融入 6 天衝刺工作流程
- [ ] **最佳實踐**：特定方法和途徑
- [ ] **約束條件**：代理應該/不應該做什麼
- [ ] **成功指標**：如何衡量代理有效性

#### 測試與驗證

- [ ] **觸發測試**：代理在預期使用案例中正確啟動
- [ ] **工具存取**：代理能正確使用所有指定工具
- [ ] **輸出品質**：回應有幫助且可操作
- [ ] **邊緣案例**：代理處理意外或複雜情境
- [ ] **整合**：與其他代理在多代理工作流程中良好運作
- [ ] **效能**：在合理時間內完成任務

### 7.4 部門特定指南

- **工程** (`engineering/`)：專注實作速度、程式碼品質、測試
- **設計** (`design/`)：強調用戶體驗、視覺一致性、快速迭代
- **行銷** (`marketing/`)：目標病毒式潛力、平台專業知識、成長指標
- **產品** (`product/`)：優先考慮用戶價值、數據驅動決策、市場契合
- **營運** (`studio-operations/`)：優化流程、減少摩擦、擴展系統
- **測試** (`testing/`)：確保品質、發現瓶頸、驗證效能
- **專案管理** (`project-management/`)：協調團隊、準時交付、管理範圍

## 8. 延伸閱讀

### 8.1 官方資源

- [Contains Studio Agents GitHub](https://github.com/contains-studio/agents)
- [Claude Code Sub-Agents 文檔](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [Contains Studio](https://contains.studio)

### 8.2 相關專案

- [wshobson/agents](https://github.com/wshobson/agents)
- [iannuttall/claude-agents](https://github.com/iannuttall/claude-agents)
- [Claude Code](https://github.com/anthropics/claude-code)

### 8.3 學習資源

- [AI 代理架構設計](https://docs.anthropic.com/en/docs/claude-code)
- [軟體開發最佳實踐](https://github.com/contains-studio)
- [團隊協作模式](https://contains.studio/blog)

### 8.4 社群支援

- [GitHub Issues](https://github.com/contains-studio/agents/issues)
- [功能建議](https://github.com/contains-studio/agents/discussions)
- [Contains Studio 社群](https://contains.studio/community)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/contains-studio/agents) 與相關文檔。
>
> **版本資訊**：Contains Studio Agents - 37+ 專業 AI 代理集合（7 大部門）  
> **最後更新**：2025-11-25T02:42:00+08:00  
> **專案更新**：2025-07-28T09:13:43-07:00  
> **主要變更**：更新代理數量（30+ → 37+）、新增測試與基準測試部門、新增獎勵代理、新增主動觸發代理說明、更新 6 天衝刺開發流程、新增代理自訂指南和檢查清單、更新部門組織結構
