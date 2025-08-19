# Claude Code Custom Agents 中文說明書

> **版本**: 最新版本


## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/iannuttall/claude-agents)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [MCP 協議文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)
> - **文件整理時間：2025-08-15T00:46:00+08:00**
> - **專案最後更新：2025-07-25T12:08:37+01:00**

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

- **功能**：程式碼重構輔助
- **適用場景**：程式碼優化、架構改進、效能提升
- **特色**：智能重構建議、最佳實踐指導

#### **frontend-designer**

- **功能**：前端設計輔助
- **適用場景**：UI/UX 設計、響應式佈局、元件設計
- **特色**：現代設計原則、使用者體驗優化

### 2.2 專案管理代理

#### **project-task-planner**

- **功能**：專案規劃和任務分解
- **適用場景**：專案啟動、里程碑規劃、資源分配
- **特色**：敏捷方法論、任務優先級管理

#### **prd-writer**

- **功能**：產品需求文件撰寫
- **適用場景**：產品規劃、需求分析、規格文件
- **特色**：結構化模板、需求追蹤

### 2.3 品質與安全代理

#### **security-auditor**

- **功能**：安全審查輔助
- **適用場景**：程式碼安全檢查、漏洞掃描、合規審查
- **特色**：安全最佳實踐、風險評估

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

```bash
# 檢查代理是否正確安裝
claude --list-agents

# 檢查特定代理狀態
claude --agent-status code-refactorer
```

---

## 4. 使用指南

### 4.1 基本使用

#### 調用特定代理

```bash
# 使用程式碼重構代理
claude --agent code-refactorer "請幫我重構這個函數"

# 使用前端設計代理
claude --agent frontend-designer "設計一個響應式導航欄"

# 使用專案規劃代理
claude --agent project-task-planner "為這個電商專案制定開發計劃"
```

#### 自動代理選擇

```bash
# Claude Code 會根據上下文自動選擇最適合的代理
claude "重構這個程式碼以提高效能"
# 會自動調用 code-refactorer

claude "設計一個現代化的使用者介面"
# 會自動調用 frontend-designer
```

### 4.2 進階使用

#### 多代理協作

```bash
# 讓多個代理協作完成複雜任務
claude "請 code-refactorer 和 security-auditor 協作檢查並優化這個程式碼"
```

#### 代理鏈式調用

```bash
# 一個代理完成後自動調用下一個代理
claude "請 project-task-planner 制定計劃，然後讓 prd-writer 撰寫需求文件"
```

---

## 5. 代理詳解

### 5.1 code-refactorer 代理

#### 主要功能

- **程式碼分析**：分析現有程式碼的結構和品質
- **重構建議**：提供具體的重構建議和實作方案
- **效能優化**：識別效能瓶頸並提供優化建議
- **最佳實踐**：應用現代程式設計最佳實踐

#### 使用範例

```bash
# 重構特定函數
claude --agent code-refactorer "請重構這個函數以提高可讀性和效能"

# 整體架構重構
claude --agent code-refactorer "請分析這個類別的設計並提供重構建議"

# 效能優化
claude --agent code-refactorer "請檢查這個演算法的效能並提供優化建議"
```

### 5.2 frontend-designer 代理

#### 主要功能

- **UI 設計**：創建現代化的使用者介面設計
- **響應式佈局**：設計適配不同裝置的響應式佈局
- **元件設計**：設計可重用的 UI 元件
- **使用者體驗**：優化使用者體驗和互動流程

#### 使用範例

```bash
# 設計登入頁面
claude --agent frontend-designer "設計一個現代化的登入頁面"

# 響應式導航
claude --agent frontend-designer "設計一個響應式導航欄"

# 元件庫設計
claude --agent frontend-designer "設計一個按鈕元件庫"
```

### 5.3 project-task-planner 代理

#### 主要功能

- **專案規劃**：制定完整的專案開發計劃
- **任務分解**：將大型任務分解為可管理的小任務
- **時間估算**：提供準確的時間估算和里程碑規劃
- **資源分配**：建議適當的資源分配策略

#### 使用範例

```bash
# 專案啟動規劃
claude --agent project-task-planner "為這個電商平台制定 3 個月的開發計劃"

# 任務分解
claude --agent project-task-planner "將用戶認證功能分解為具體的開發任務"

# 里程碑規劃
claude --agent project-task-planner "為這個專案制定關鍵里程碑"
```

### 5.4 security-auditor 代理

#### 主要功能

- **安全檢查**：檢查程式碼中的安全漏洞
- **最佳實踐**：應用安全開發最佳實踐
- **風險評估**：評估潛在的安全風險
- **合規檢查**：確保符合安全合規要求

#### 使用範例

```bash
# 程式碼安全檢查
claude --agent security-auditor "檢查這個認證系統的安全性"

# 漏洞掃描
claude --agent security-auditor "掃描這個 API 的潛在安全漏洞"

# 安全最佳實踐
claude --agent security-auditor "為這個專案制定安全開發指南"
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

### 6.1 自訂代理行為

#### 修改代理配置

```yaml
# .claude/agents/custom-code-refactorer.yml
name: "custom-code-refactorer"
base_agent: "code-refactorer"
customizations:
  preferred_languages: ["JavaScript", "TypeScript", "Python"]
  refactoring_style: "aggressive"
  include_tests: true
  documentation_style: "JSDoc"
```

#### 創建新代理

```yaml
# .claude/agents/custom-agent.yml
name: "custom-agent"
description: "自訂代理描述"
specializations:
  - "特定領域 1"
  - "特定領域 2"

preferences:
  model: "claude-3-sonnet-20240229"
  response_format: "markdown"
  include_examples: true
```

### 6.2 代理組合

#### 建立代理組合

```yaml
# .claude/agent-groups.yml
groups:
  full_stack_development:
    name: "全端開發"
    agents:
      - "code-refactorer"
      - "frontend-designer"
      - "project-task-planner"
      - "security-auditor"

  content_creation:
    name: "內容創作"
    agents:
      - "content-writer"
      - "prd-writer"
      - "vibe-coding-coach"
```

#### 使用代理組合

```bash
# 使用代理組合
claude --agent-group full_stack_development "設計並開發一個完整的用戶管理系統"
```

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

#### 代理無法調用

```bash
# 檢查代理安裝
ls -la .claude/agents/

# 檢查代理權限
claude --check-permissions

# 重新載入代理
claude --reload-agents
```

#### 代理回應異常

```bash
# 檢查代理配置
claude --agent-config code-refactorer

# 檢查模型設定
claude --model-status

# 啟用除錯模式
claude --verbose --debug
```

### 8.2 除錯技巧

#### 詳細日誌

```bash
# 啟用詳細日誌
claude --verbose --agent code-refactorer "重構這個程式碼"

# 記錄到檔案
claude --log-file agent-debug.log --agent code-refactorer "重構這個程式碼"
```

#### 代理狀態檢查

```bash
# 檢查代理狀態
claude --agent-status

# 檢查代理健康狀況
claude --agent-health code-refactorer

# 檢查代理配置
claude --agent-config code-refactorer
```

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

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/iannuttall/claude-agents) 與相關文檔。
>
**版本資訊**：Claude Code Custom Agents - 7 個專業代理  
> **最後更新**：2025-08-20T00:13:54+08:00
