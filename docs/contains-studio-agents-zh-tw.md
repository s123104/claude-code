# Contains Studio Agents 中文說明書

> **版本**: 最新版本


## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/contains-studio/agents)
> - [Claude Code Subagents 官方文檔](https://docs.anthropic.com/en/docs/claude-code/subagents)
> - **文件整理時間：2025-10-28T04:00:00+08:00**
> - **專案版本：v1.2**
> - **專案最後更新：2025-08-16**

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

- **🎯 專業化分工**：每個代理專精於特定領域
- **⚡ 自動觸發**：根據任務描述自動選擇合適的代理
- **🔄 明確調用**：可以明確指定使用特定代理
- **📦 即插即用**：簡單複製即可使用
- **🔧 可客製化**：可根據需求修改代理行為

### 1.2 代理覆蓋領域

- **開發專業**：前後端、全端、行動應用開發
- **資料與 AI**：資料科學、機器學習、AI 工程
- **基礎設施**：DevOps、雲端架構、安全工程
- **設計與內容**：UI/UX 設計、內容創作、技術寫作
- **專案管理**：產品管理、專案規劃、品質保證

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

### 3.1 開發類代理

#### 前端開發

- **frontend-specialist**: 前端開發專家，精通 React、Vue、Angular
- **ui-ux-designer**: UI/UX 設計師，專注用戶體驗設計
- **css-expert**: CSS 專家，精通樣式設計和動畫

#### 後端開發

- **backend-architect**: 後端架構師，API 設計和系統架構
- **database-expert**: 資料庫專家，SQL/NoSQL 設計優化
- **api-designer**: API 設計師，RESTful/GraphQL 專家

#### 全端與行動

- **fullstack-developer**: 全端開發者，端到端開發
- **mobile-developer**: 行動應用開發，iOS/Android/跨平台

### 3.2 資料與 AI 類代理

#### 資料科學

- **data-scientist**: 資料科學家，統計分析和機器學習
- **data-engineer**: 資料工程師，ETL 和資料管道
- **analytics-expert**: 分析專家，商業智能和報表

#### AI 與機器學習

- **ml-engineer**: 機器學習工程師，模型訓練和部署
- **ai-researcher**: AI 研究員，前沿技術研究
- **nlp-specialist**: 自然語言處理專家

### 3.3 基礎設施類代理

#### DevOps 與雲端

- **devops-engineer**: DevOps 工程師，CI/CD 和自動化
- **cloud-architect**: 雲端架構師，AWS/GCP/Azure 專家
- **kubernetes-expert**: Kubernetes 專家，容器編排

#### 安全與監控

- **security-engineer**: 安全工程師，網路安全和合規
- **monitoring-specialist**: 監控專家，可觀測性和效能
- **network-engineer**: 網路工程師，網路架構設計

### 3.4 設計與內容類代理

#### 設計專業

- **graphic-designer**: 平面設計師，視覺設計和品牌
- **product-designer**: 產品設計師，用戶體驗研究
- **motion-designer**: 動態設計師，動畫和互動設計

#### 內容創作

- **technical-writer**: 技術文件撰寫師
- **content-strategist**: 內容策略師，內容規劃和管理
- **copywriter**: 文案撰寫師，行銷文案創作

### 3.5 專案管理類代理

#### 管理專業

- **product-manager**: 產品經理，產品策略和規劃
- **project-manager**: 專案經理，專案執行和協調
- **scrum-master**: Scrum Master，敏捷開發流程

#### 品質保證

- **qa-engineer**: QA 工程師，測試策略和執行
- **performance-tester**: 效能測試師，系統效能優化
- **accessibility-expert**: 無障礙專家，可及性設計

---

## 4. 使用指南

### 4.1 自動代理選擇

Claude Code 會根據任務描述自動選擇最適合的代理：

```bash
# 前端任務 - 自動選擇 frontend-specialist
> 建立一個響應式的電商產品卡片組件

# 後端任務 - 自動選擇 backend-architect
> 設計一個用戶認證和授權系統的 API

# 資料任務 - 自動選擇 data-scientist
> 分析用戶行為資料並建立推薦模型
```

### 4.2 明確代理調用

您也可以明確指定使用特定代理：

```bash
# 明確調用前端專家
> 請 frontend-specialist 幫我優化 React 組件的效能

# 明確調用資料庫專家
> 請 database-expert 設計電商系統的資料庫架構

# 明確調用 DevOps 工程師
> 請 devops-engineer 建立 CI/CD 管道
```

### 4.3 多代理協作

```bash
# 讓多個代理協作
> 請 product-manager 和 frontend-specialist 協作設計用戶儀表板

# 順序協作
> 請 backend-architect 先設計 API，然後 frontend-specialist 建立前端介面
```

---

## 5. 專業代理詳解

### 5.1 Frontend Specialist

```yaml
專長領域:
  - React/Vue/Angular 框架開發
  - 現代 CSS 和樣式框架
  - 前端效能優化
  - 響應式網頁設計
  - 前端測試策略

常用場景:
  - 組件設計和實作
  - 前端架構規劃
  - 使用者介面優化
  - 跨瀏覽器相容性
  - 前端工具鏈配置
```

### 5.2 Backend Architect

```yaml
專長領域:
  - RESTful/GraphQL API 設計
  - 微服務架構
  - 資料庫設計和優化
  - 快取策略
  - 系統擴展性設計

常用場景:
  - 系統架構設計
  - API 端點規劃
  - 資料流程設計
  - 效能瓶頸分析
  - 安全性架構
```

### 5.3 Data Scientist

```yaml
專長領域:
  - 統計分析和機器學習
  - 資料視覺化
  - 預測模型建立
  - A/B 測試設計
  - 商業洞察分析

常用場景:
  - 資料探索分析
  - 機器學習模型
  - 商業智能報表
  - 用戶行為分析
  - 預測模型部署
```

### 5.4 DevOps Engineer

```yaml
專長領域:
  - CI/CD 管道建立
  - 基礎設施即程式碼
  - 容器化和編排
  - 監控和日誌
  - 自動化部署

常用場景:
  - 建置和部署自動化
  - 基礎設施管理
  - 效能監控設定
  - 災害恢復計劃
  - 成本優化策略
```

### 5.5 Product Manager

```yaml
專長領域:
  - 產品策略規劃
  - 使用者需求分析
  - 功能優先級排序
  - 市場競爭分析
  - 產品路線圖

常用場景:
  - 產品需求文件
  - 功能規格定義
  - 使用者故事撰寫
  - 產品路線圖規劃
  - 市場研究分析
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
  簡單: "建立一個按鈕組件" → frontend-specialist
  複雜: "建立完整的電商平台" → 多個代理協作
```

#### 根據專案階段

```yaml
規劃階段:
  - product-manager: 需求分析
  - ui-ux-designer: 設計規劃
  - backend-architect: 架構設計

開發階段:
  - frontend-specialist: 前端實作
  - backend-architect: 後端開發
  - database-expert: 資料庫實作

測試階段:
  - qa-engineer: 測試策略
  - performance-tester: 效能測試
  - security-engineer: 安全測試

部署階段:
  - devops-engineer: 部署自動化
  - monitoring-specialist: 監控設定
  - cloud-architect: 基礎設施
```

### 6.2 協作模式

#### 並行協作

```bash
# 同時進行的任務
> 請 frontend-specialist 設計用戶介面，同時 backend-architect 設計 API 架構
```

#### 順序協作

```bash
# 有依賴關係的任務
> 請 product-manager 先定義需求，然後 ui-ux-designer 基於需求設計介面
```

#### 審查協作

```bash
# 程式碼審查流程
> 請 security-engineer 審查這個認證系統的安全性
```

### 6.3 品質保證

#### 程式碼品質

```yaml
品質檢查流程: 1. 開發代理實作功能
  2. qa-engineer 建立測試案例
  3. security-engineer 進行安全檢查
  4. performance-tester 執行效能測試
  5. technical-writer 撰寫文檔
```

#### 最佳實踐

- **明確需求**：提供清晰的任務描述
- **適當分工**：根據代理專長分配任務
- **階段檢查**：在關鍵節點進行檢查
- **持續改進**：根據結果優化流程

---

## 7. 延伸閱讀

### 7.1 官方資源

- [Contains Studio Agents GitHub](https://github.com/contains-studio/agents)
- [Claude Code Sub-Agents 文檔](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [Contains Studio](https://contains.studio)

### 7.2 相關專案

- [wshobson/agents](https://github.com/wshobson/agents)
- [iannuttall/claude-agents](https://github.com/iannuttall/claude-agents)
- [Claude Code](https://github.com/anthropics/claude-code)

### 7.3 學習資源

- [AI 代理架構設計](https://docs.anthropic.com/en/docs/claude-code)
- [軟體開發最佳實踐](https://github.com/contains-studio)
- [團隊協作模式](https://contains.studio/blog)

### 7.4 社群支援

- [GitHub Issues](https://github.com/contains-studio/agents/issues)
- [功能建議](https://github.com/contains-studio/agents/discussions)
- [Contains Studio 社群](https://contains.studio/community)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/contains-studio/agents) 與相關文檔。
>
> **版本資訊**：Contains Studio Agents - 專業 AI 代理集合  
> **最後更新**：2025-08-18T00:00:00+08:00
