# Agents 中文說明書

> **資料來源：**
>
> - [GitHub 專案](https://github.com/wshobson/agents)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [MCP 協議文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)
> - **文件整理時間：2025-08-15T00:44:00+08:00**
> - **專案最後更新：2025-08-10T10:51:19-04:00**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 子代理分類](#2-子代理分類)
- [3. 安裝與配置](#3-安裝與配置)
- [4. 使用指南](#4-使用指南)
- [5. 進階功能](#5-進階功能)
- [6. 最佳實踐](#6-最佳實踐)
- [7. 疑難排解](#7-疑難排解)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 專案簡介

Agents 是一個包含 61 個專業子代理的 Claude Code 擴展專案，每個子代理都是特定領域的專家，能夠根據上下文自動調用或根據需要明確調用。所有代理都根據任務複雜性配置了特定的 Claude 模型，以實現最佳效能和成本效益。

### 1.1 核心特色

- **專業化分工**：61 個專業子代理，涵蓋開發、設計、測試等各個領域
- **智能調度**：根據上下文自動選擇最適合的代理
- **模型優化**：根據任務複雜性選擇最適合的 Claude 模型
- **成本控制**：優化 API 使用，降低開發成本
- **無縫整合**：與 Claude Code 完全相容

### 1.2 使用場景

- **大型專案開發**：多領域協作開發
- **專業任務處理**：特定領域的專業化任務
- **團隊協作**：不同角色的開發者使用對應代理
- **學習與培訓**：學習特定技術領域的最佳實踐

---

## 2. 子代理分類

### 2.1 開發與架構

#### 後端開發
- **[backend-architect](backend-architect.md)** - 設計 RESTful API、微服務邊界和資料庫架構
- **[graphql-architect](graphql-architect.md)** - 設計 GraphQL 架構、解析器和聯邦
- **[architect-reviewer](architect-review.md)** - 審查程式碼變更的架構一致性和模式

#### 前端開發
- **[frontend-developer](frontend-developer.md)** - 建構 React 元件、實作響應式佈局和處理客戶端狀態管理
- **[ui-ux-designer](ui-ux-designer.md)** - 創建介面設計、線框圖和設計系統
- **[mobile-developer](mobile-developer.md)** - 開發 React Native 或 Flutter 應用程式，整合原生功能

### 2.2 語言專家

#### 程式語言
- **[python-pro](python-pro.md)** - 撰寫慣用 Python 程式碼，包含進階功能和優化
- **[ruby-pro](ruby-pro.md)** - 撰寫慣用 Ruby 程式碼，包含元程式設計、Rails 模式、gem 開發和測試框架
- **[golang-pro](golang-pro.md)** - 撰寫慣用 Go 程式碼，包含 goroutines、channels 和介面
- **[rust-pro](rust-pro.md)** - 撰寫慣用 Rust，包含所有權模式、生命週期和特徵實作
- **[c-pro](c-pro.md)** - 撰寫高效 C 程式碼，包含適當的記憶體管理和系統呼叫
- **[cpp-pro](cpp-pro.md)** - 撰寫慣用 C++ 程式碼，包含現代功能、RAII、智能指標和 STL 演算法

#### 腳本語言
- **[javascript-pro](javascript-pro.md)** - 撰寫現代 JavaScript/TypeScript，包含 ES6+ 功能和最佳實踐
- **[php-pro](php-pro.md)** - 撰寫慣用 PHP，包含 Laravel 模式、Composer 和測試
- **[java-pro](java-pro.md)** - 撰寫慣用 Java，包含 Spring Boot、JUnit 和設計模式
- **[csharp-pro](csharp-pro.md)** - 撰寫慣用 C#，包含 .NET Core、Entity Framework 和 LINQ

### 2.3 資料與基礎設施

#### 資料庫與儲存
- **[database-architect](database-architect.md)** - 設計資料庫架構、索引策略和查詢優化
- **[data-engineer](data-engineer.md)** - 建構資料管道、ETL 流程和資料倉儲
- **[ml-engineer](ml-engineer.md)** - 實作機器學習模型、特徵工程和模型部署

#### 雲端與 DevOps
- **[cloud-architect](cloud-architect.md)** - 設計雲端架構、微服務和容器化策略
- **[devops-engineer](devops-engineer.md)** - 實作 CI/CD 流程、基礎設施即程式碼和監控
- **[security-engineer](security-engineer.md)** - 實作安全最佳實踐、漏洞掃描和合規檢查

### 2.4 測試與品質

#### 測試專家
- **[test-engineer](test-engineer.md)** - 設計測試策略、自動化測試和測試覆蓋率
- **[qa-engineer](qa-engineer.md)** - 實作品質保證流程、手動測試和測試計劃
- **[performance-engineer](performance-engineer.md)** - 優化應用程式效能、負載測試和瓶頸分析

#### 品質管理
- **[code-reviewer](code-reviewer.md)** - 進行程式碼審查、品質檢查和最佳實踐建議
- **[documentation-writer](documentation-writer.md)** - 撰寫技術文件、API 文件和用戶指南

---

## 3. 安裝與配置

### 3.1 前置需求

- Claude Code CLI 已安裝
- Anthropic API 金鑰已設定
- 適當的權限設定

### 3.2 安裝步驟

```bash
# 克隆專案
git clone https://github.com/wshobson/agents.git
cd agents

# 安裝依賴（如果有的話）
npm install  # 或 pip install -r requirements.txt

# 設定環境變數
export ANTHROPIC_API_KEY="your-api-key-here"
```

### 3.3 配置設定

#### 基本配置
```yaml
# .claude/config.yml
agents:
  enabled: true
  auto_select: true
  model_mapping:
    simple: "claude-3-haiku-20240307"
    medium: "claude-3-sonnet-20240229"
    complex: "claude-3-opus-20240229"
  
  specializations:
    backend: "backend-architect"
    frontend: "frontend-developer"
    database: "database-architect"
    security: "security-engineer"
```

#### 代理權限設定
```yaml
# .claude/permissions.yml
permissions:
  backend-architect:
    tools: ["Edit", "Bash", "Read"]
    file_patterns: ["src/backend/**", "api/**", "database/**"]
    
  frontend-developer:
    tools: ["Edit", "Read"]
    file_patterns: ["src/frontend/**", "public/**", "components/**"]
    
  security-engineer:
    tools: ["Read", "Bash"]
    file_patterns: ["**/*"]
    restricted_operations: ["Edit"]
```

---

## 4. 使用指南

### 4.1 基本使用

#### 自動代理選擇
```bash
# Claude Code 會根據上下文自動選擇最適合的代理
claude "設計一個 RESTful API 架構"
# 會自動調用 backend-architect

claude "優化這個 React 元件的效能"
# 會自動調用 frontend-developer
```

#### 明確代理調用
```bash
# 明確指定使用特定代理
claude --agent backend-architect "設計微服務架構"
claude --agent security-engineer "檢查程式碼安全漏洞"
claude --agent test-engineer "為這個功能撰寫測試"
```

### 4.2 進階使用

#### 多代理協作
```bash
# 讓多個代理協作完成複雜任務
claude "請 backend-architect 和 frontend-developer 協作設計一個完整的用戶認證系統"
```

#### 代理鏈式調用
```bash
# 一個代理完成後自動調用下一個代理
claude "請 backend-architect 設計 API，然後讓 test-engineer 為其撰寫測試"
```

### 4.3 代理配置自訂

#### 自訂代理行為
```yaml
# .claude/agents/custom-backend-architect.yml
name: "custom-backend-architect"
base_agent: "backend-architect"
customizations:
  preferred_patterns:
    - "microservices"
    - "event-driven"
    - "CQRS"
  
  model_preference: "claude-3-opus-20240229"
  response_format: "markdown"
  include_examples: true
```

#### 代理組合
```yaml
# .claude/agent-groups.yml
groups:
  full_stack:
    name: "Full Stack Development"
    agents:
      - "backend-architect"
      - "frontend-developer"
      - "database-architect"
      - "test-engineer"
    
  security_focused:
    name: "Security-First Development"
    agents:
      - "security-engineer"
      - "backend-architect"
      - "code-reviewer"
```

---

## 5. 進階功能

### 5.1 代理學習與適應

#### 使用模式學習
```yaml
# 代理會學習您的偏好和專案模式
learning:
  enabled: true
  patterns:
    - "preferred_architecture_style"
    - "coding_standards"
    - "testing_approaches"
    - "deployment_strategies"
```

#### 自訂知識庫
```yaml
# 為特定代理添加專案特定的知識
custom_knowledge:
  backend-architect:
    - "company_api_standards.md"
    - "microservices_patterns.md"
    - "database_conventions.md"
```

### 5.2 效能優化

#### 模型選擇策略
```yaml
# 根據任務複雜性自動選擇最適合的模型
model_selection:
  simple_tasks:
    - "claude-3-haiku-20240307"
    - "claude-3-sonnet-20240229"
  
  complex_tasks:
    - "claude-3-opus-20240229"
  
  cost_optimization: true
  performance_threshold: 0.8
```

#### 快取與重用
```yaml
# 快取代理回應以提高效能
caching:
  enabled: true
  ttl: 3600  # 1 小時
  max_size: 1000
  include_context: true
```

---

## 6. 最佳實踐

### 6.1 代理使用策略

#### 任務分解
```bash
# 將複雜任務分解為多個子任務，使用不同代理
claude "請 backend-architect 設計資料庫架構"
claude "請 frontend-developer 設計用戶介面"
claude "請 test-engineer 設計測試策略"
```

#### 代理組合
```bash
# 使用代理組合處理複雜專案
claude "請使用 full-stack 代理組合設計一個電商平台"
```

### 6.2 效能優化

#### 模型選擇
- **簡單任務**：使用 Haiku 模型，快速且成本低
- **中等任務**：使用 Sonnet 模型，平衡效能和成本
- **複雜任務**：使用 Opus 模型，最高品質

#### 上下文管理
```yaml
# 優化上下文長度
context_optimization:
  max_tokens: 4000
  include_relevant_only: true
  compress_history: true
```

### 6.3 成本控制

#### API 使用優化
```yaml
# 監控和控制 API 使用
cost_control:
  daily_limit: 1000
  model_usage_tracking: true
  cost_alerts: true
  preferred_models: ["haiku", "sonnet"]
```

---

## 7. 疑難排解

### 7.1 常見問題

#### 代理無法調用
```bash
# 檢查代理配置
claude --list-agents

# 檢查權限設定
claude --check-permissions

# 重新載入代理
claude --reload-agents
```

#### 效能問題
```yaml
# 檢查模型選擇
model_diagnostics:
  enabled: true
  log_performance: true
  suggest_optimizations: true
```

### 7.2 除錯技巧

#### 詳細日誌
```bash
# 啟用詳細日誌
claude --verbose --debug --agent backend-architect "設計 API"
```

#### 代理狀態檢查
```bash
# 檢查代理狀態
claude --agent-status
claude --agent-health backend-architect
```

---

## 8. 延伸閱讀

### 8.1 官方資源

- [Agents GitHub 專案](https://github.com/wshobson/agents)
- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [MCP 協議文檔](https://docs.anthropic.com/en/docs/claude-code/mcp)

### 8.2 相關專案

- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)
- [Claude Code Hooks](https://github.com/aliceric27/claude-code-hooks)
- [Claude Code Spec](https://github.com/gotalab/claude-code-spec)

### 8.3 學習資源

- [代理架構設計模式](https://en.wikipedia.org/wiki/Software_agent)
- [微服務架構最佳實踐](https://microservices.io/)
- [測試驅動開發](https://en.wikipedia.org/wiki/Test-driven_development)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/wshobson/agents) 與相關文檔。
>
> **版本資訊**：Agents - 61 個專業子代理  
> **最後更新**：2025-08-15T00:44:00+08:00
