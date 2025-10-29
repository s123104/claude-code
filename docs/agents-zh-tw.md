# Claude Code Plugins 插件市場中文說明書

> **⚡ 已更新至 Sonnet 4.5 & Haiku 4.5** — 所有代理已針對最新模型優化，採用混合編排策略
>
> **🎯 代理技能已啟用** — 47 個專業技能透過漸進式揭露擴展 Claude 在插件中的能力

## 概述

這是一個完整的生產就緒系統，結合了 **85 個專業 AI 代理**、**15 個多代理工作流編排器**、**47 個代理技能** 和 **44 個開發工具**，組織為 **63 個專注、單一用途的插件**，專為 [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) 設計。

> **專案資訊**
>
> - **專案名稱**：Claude Code Plugins
> - **專案版本**：v2.0.0
> - **專案最後更新**：2025-10-24
> - **文件整理時間**：2025-10-29T02:00:00+08:00
>
> **核心定位**
>
> - **功能**：85 個專業 AI 代理 + 15 個多代理編排器 + 47 個代理技能 + 44 個開發工具，組織為 63 個插件
> - **場景**：全端開發、AI工程、DevOps自動化、安全加固、ML管道、事件響應
> - **客群**：專業開發者、企業團隊、AI研究人員、DevOps工程師、安全專家
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/wshobson/agents)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [Plugins 官方指南](https://docs.claude.com/en/docs/claude-code/plugins)
> - [Agent Skills 官方規範](https://github.com/anthropics/skills/blob/main/agent_skills_spec.md)

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心特色](#2-核心特色)
- [3. 快速開始](#3-快速開始)
- [4. 插件分類](#4-插件分類)
- [5. 代理技能系統](#5-代理技能系統)
- [6. 85 個專業代理總覽](#6-85-個專業代理總覽)
- [7. 使用指南](#7-使用指南)
- [8. 多代理工作流](#8-多代理工作流)
- [9. 最佳實踐](#9-最佳實踐)
- [10. 延伸閱讀](#10-延伸閱讀)

---

## 1. 專案簡介

此統一儲存庫提供了現代軟體開發所需的智能自動化和多代理編排的完整解決方案：

### 1.1 系統組成

- **63 個專注插件** - 細粒度、單一用途的插件，優化最小 token 使用和可組合性
- **85 個專業代理** - 涵蓋架構、語言、基礎設施、品質、資料/AI、文檔、業務營運和 SEO 的領域專家
- **47 個代理技能** - 模組化知識套件，採用漸進式揭露的專業知識
- **15 個工作流編排器** - 用於複雜操作的多代理協調系統，如全端開發、安全加固、ML 管道和事件響應
- **44 個開發工具** - 優化的工具，包括專案腳手架、安全掃描、測試自動化和基礎設施設定

### 1.2 核心理念

**插件市場架構**：每個插件完全獨立，擁有自己的代理、命令和技能：

- **只安裝需要的** - 每個插件只載入其特定的代理、命令和技能
- **最小 token 使用** - 不載入不必要的資源到上下文
- **混合搭配** - 組合多個插件以實現複雜工作流
- **清晰邊界** - 每個插件都有單一、專注的目的
- **漸進式揭露** - 技能只在啟動時載入知識

**範例**：安裝 `python-development` 載入 3 個 Python 代理、1 個腳手架工具，並使 5 個技能可用（~300 tokens），而不是整個市場。

### 1.3 使用場景

- **大型專案開發**：使用插件組合處理複雜的全端專案
- **專業化任務**：針對特定領域使用專門的代理和技能
- **團隊協作**：不同角色的開發者安裝對應的插件
- **學習與培訓**：透過技能系統學習特定技術領域的最佳實踐
- **DevOps 自動化**：使用基礎設施和 CI/CD 插件自動化部署
- **安全加固**：使用安全插件進行全面的安全審查

---

## 2. 核心特色

### 2.1 細粒度插件架構

- **單一職責**：每個插件做好一件事
- **最小 token 使用**：平均每個插件 3.4 個元件（遵循 Anthropic 的 2-8 模式）
- **可組合性**：混合搭配複雜工作流
- **100% 覆蓋**：所有 85 個代理可透過插件存取

### 2.2 漸進式揭露（技能）

三層架構實現 token 效率：

1. **元資料** - 名稱和啟動條件（始終載入）
2. **指令** - 核心指導（啟動時載入）
3. **資源** - 範例和模板（按需載入）

### 2.3 混合模型編排

策略性模型分配，實現最佳效能和成本：

- **47 個 Haiku 代理** - 確定性任務的快速執行
- **97 個 Sonnet 代理** - 複雜推理和架構設計
- **編排模式**：`Sonnet（規劃）→ Haiku（執行）→ Sonnet（審查）`

### 2.4 完整工具鏈

- **44 個開發工具**：專案腳手架、安全掃描、測試自動化
- **44 個斜線命令**：Git 工作流、測試生成、部署自動化
- **15 個編排器**：多代理協調處理複雜操作

---

## 3. 快速開始

### 3.1 步驟一：新增市場

將此市場新增到 Claude Code：

```bash
/plugin marketplace add wshobson/agents
```

這使所有 63 個插件可供安裝，但 **不會載入任何代理或工具** 到您的上下文。

### 3.2 步驟二：安裝插件

瀏覽可用插件：

```bash
/plugin
```

安裝您需要的插件：

```bash
# 基本開發插件
/plugin install python-development          # Python，含 5 個專業技能
/plugin install javascript-typescript       # JS/TS，含 4 個專業技能
/plugin install backend-development         # 後端 API，含 3 個架構技能

# 基礎設施與維運
/plugin install kubernetes-operations       # K8s，含 4 個部署技能
/plugin install cloud-infrastructure        # AWS/Azure/GCP，含 4 個雲端技能

# 安全與品質
/plugin install security-scanning           # SAST，含安全技能
/plugin install code-review-ai             # AI 驅動的程式碼審查

# 全端編排
/plugin install full-stack-orchestration   # 多代理工作流
```

每個安裝的插件只載入 **其特定的代理、命令和技能** 到 Claude 的上下文中。

### 3.3 步驟三：使用插件

#### 透過斜線命令

```bash
# 生成 FastAPI 專案
/python-development:python-scaffold fastapi-microservice

# 進行安全掃描
/security-scanning:security-hardening --level comprehensive

# 全端功能開發
/full-stack-orchestration:full-stack-feature "使用者認證與 OAuth2"
```

#### 透過自然語言

```
"使用 backend-architect 設計一個 RESTful API"
"讓 kubernetes-architect 建立生產級 Kubernetes 部署"
"請 security-auditor 進行 OWASP 合規檢查"
```

---

## 4. 插件分類

**23 個類別，63 個插件：**

### 🎨 開發類（4 個插件）

| 插件                            | 描述                              | 安裝指令                                      |
| ------------------------------- | --------------------------------- | --------------------------------------------- |
| **debugging-toolkit**           | 互動式除錯和開發者體驗優化        | `/plugin install debugging-toolkit`           |
| **backend-development**         | 後端 API 設計與 GraphQL、TDD      | `/plugin install backend-development`         |
| **frontend-mobile-development** | 前端 UI 和行動應用開發            | `/plugin install frontend-mobile-development` |
| **multi-platform-apps**         | 跨平台應用協調（web/iOS/Android） | `/plugin install multi-platform-apps`         |

### 📚 文檔類（2 個插件）

| 插件                         | 描述                             | 安裝指令                                   |
| ---------------------------- | -------------------------------- | ------------------------------------------ |
| **code-documentation**       | 文檔生成和程式碼說明             | `/plugin install code-documentation`       |
| **documentation-generation** | OpenAPI 規格、Mermaid 圖表、教學 | `/plugin install documentation-generation` |

### 🔄 工作流類（3 個插件）

| 插件                         | 描述                 | 安裝指令                                   |
| ---------------------------- | -------------------- | ------------------------------------------ |
| **git-pr-workflows**         | Git 自動化和 PR 增強 | `/plugin install git-pr-workflows`         |
| **full-stack-orchestration** | 端到端功能編排       | `/plugin install full-stack-orchestration` |
| **tdd-workflows**            | 測試驅動開發方法論   | `/plugin install tdd-workflows`            |

### ✅ 測試類（2 個插件）

| 插件              | 描述                                  | 安裝指令                        |
| ----------------- | ------------------------------------- | ------------------------------- |
| **unit-testing**  | 自動單元測試生成（Python/JavaScript） | `/plugin install unit-testing`  |
| **tdd-workflows** | 測試驅動開發方法論                    | `/plugin install tdd-workflows` |

### 🔍 品質類（3 個插件）

| 插件                        | 描述                         | 安裝指令                                  |
| --------------------------- | ---------------------------- | ----------------------------------------- |
| **code-review-ai**          | AI 驅動的程式碼審查          | `/plugin install code-review-ai`          |
| **comprehensive-review**    | 多角度分析（架構/安全/效能） | `/plugin install comprehensive-review`    |
| **application-performance** | 應用程式效能分析和優化       | `/plugin install application-performance` |

### 🤖 AI & ML 類（4 個插件）

| 插件                     | 描述                    | 安裝指令                               |
| ------------------------ | ----------------------- | -------------------------------------- |
| **llm-application-dev**  | LLM 應用、RAG、提示工程 | `/plugin install llm-application-dev`  |
| **agent-orchestration**  | 多代理系統和協調        | `/plugin install agent-orchestration`  |
| **context-engineering**  | 上下文優化和提示設計    | `/plugin install context-engineering`  |
| **machine-learning-ops** | MLOps 管道和模型服務    | `/plugin install machine-learning-ops` |

### 📊 資料類（2 個插件）

| 插件                      | 描述               | 安裝指令                                |
| ------------------------- | ------------------ | --------------------------------------- |
| **data-engineering**      | ETL 管道、資料倉儲 | `/plugin install data-engineering`      |
| **data-validation-suite** | 資料品質和驗證     | `/plugin install data-validation-suite` |

### 🗄️ 資料庫類（2 個插件）

| 插件                    | 描述                  | 安裝指令                              |
| ----------------------- | --------------------- | ------------------------------------- |
| **database-design**     | 資料庫架構和設計      | `/plugin install database-design`     |
| **database-migrations** | Schema 遷移和版本控制 | `/plugin install database-migrations` |

### 🚨 維運類（4 個插件）

| 插件                         | 描述            | 安裝指令                                   |
| ---------------------------- | --------------- | ------------------------------------------ |
| **incident-response**        | 生產事件管理    | `/plugin install incident-response`        |
| **error-diagnostics**        | 錯誤診斷和分析  | `/plugin install error-diagnostics`        |
| **distributed-debugging**    | 分散式系統追蹤  | `/plugin install distributed-debugging`    |
| **observability-monitoring** | 監控、追蹤、SLO | `/plugin install observability-monitoring` |

### ⚡ 效能類（2 個插件）

| 插件                            | 描述                 | 安裝指令                                      |
| ------------------------------- | -------------------- | --------------------------------------------- |
| **application-performance**     | 應用程式效能優化     | `/plugin install application-performance`     |
| **database-cloud-optimization** | 資料庫和雲端成本優化 | `/plugin install database-cloud-optimization` |

### ☁️ 基礎設施類（5 個插件）

| 插件                          | 描述                      | 安裝指令                                    |
| ----------------------------- | ------------------------- | ------------------------------------------- |
| **deployment-automation**     | 部署自動化和 CI/CD        | `/plugin install deployment-automation`     |
| **infrastructure-validation** | IaC 驗證和測試            | `/plugin install infrastructure-validation` |
| **kubernetes-operations**     | K8s 操作和 GitOps         | `/plugin install kubernetes-operations`     |
| **cloud-infrastructure**      | AWS/Azure/GCP 架構        | `/plugin install cloud-infrastructure`      |
| **ci-cd-automation**          | GitHub Actions、GitLab CI | `/plugin install ci-cd-automation`          |

### 🔒 安全類（4 個插件）

| 插件                         | 描述              | 安裝指令                                   |
| ---------------------------- | ----------------- | ------------------------------------------ |
| **security-scanning**        | SAST、依賴掃描    | `/plugin install security-scanning`        |
| **security-compliance**      | SOC2、HIPAA、GDPR | `/plugin install security-compliance`      |
| **backend-api-security**     | 後端/API 安全     | `/plugin install backend-api-security`     |
| **frontend-mobile-security** | 前端/行動安全     | `/plugin install frontend-mobile-security` |

### 💻 程式語言類（7 個插件）

| 插件                       | 描述                           | 安裝指令                                 |
| -------------------------- | ------------------------------ | ---------------------------------------- |
| **python-development**     | Python 專案腳手架（含 5 技能） | `/plugin install python-development`     |
| **javascript-typescript**  | JS/TS 腳手架（含 4 技能）      | `/plugin install javascript-typescript`  |
| **systems-programming**    | C、C++、Rust、Go               | `/plugin install systems-programming`    |
| **jvm-languages**          | Java、Scala、C#                | `/plugin install jvm-languages`          |
| **web-scripting**          | Ruby、PHP                      | `/plugin install web-scripting`          |
| **functional-programming** | Elixir、Haskell                | `/plugin install functional-programming` |
| **embedded-systems**       | ARM Cortex-M、嵌入式           | `/plugin install embedded-systems`       |

### 🔗 區塊鏈類（1 個插件）

| 插件                | 描述                              | 安裝指令                          |
| ------------------- | --------------------------------- | --------------------------------- |
| **blockchain-web3** | 智能合約、DeFi、Web3（含 4 技能） | `/plugin install blockchain-web3` |

### 💰 金融類（1 個插件）

| 插件                     | 描述               | 安裝指令                               |
| ------------------------ | ------------------ | -------------------------------------- |
| **quantitative-trading** | 量化交易、風險管理 | `/plugin install quantitative-trading` |

### 💳 支付類（1 個插件）

| 插件                   | 描述                              | 安裝指令                             |
| ---------------------- | --------------------------------- | ------------------------------------ |
| **payment-processing** | Stripe、PayPal、帳單（含 4 技能） | `/plugin install payment-processing` |

### 🎮 遊戲類（1 個插件）

| 插件                 | 描述                  | 安裝指令                           |
| -------------------- | --------------------- | ---------------------------------- |
| **game-development** | Unity、Minecraft 插件 | `/plugin install game-development` |

### 📢 行銷類（4 個插件）

| 插件                           | 描述          | 安裝指令                                     |
| ------------------------------ | ------------- | -------------------------------------------- |
| **seo-content-creation**       | SEO 內容創作  | `/plugin install seo-content-creation`       |
| **seo-technical-optimization** | 技術 SEO 優化 | `/plugin install seo-technical-optimization` |
| **seo-analysis-monitoring**    | SEO 分析監控  | `/plugin install seo-analysis-monitoring`    |
| **content-marketing**          | 內容行銷策略  | `/plugin install content-marketing`          |

### 💼 業務類（3 個插件）

| 插件                          | 描述           | 安裝指令                                    |
| ----------------------------- | -------------- | ------------------------------------------- |
| **business-analytics**        | 業務分析和報告 | `/plugin install business-analytics`        |
| **hr-legal-compliance**       | HR 和法律合規  | `/plugin install hr-legal-compliance`       |
| **customer-sales-automation** | 客戶支援和銷售 | `/plugin install customer-sales-automation` |

**完整插件清單**: 共 23 個類別、63 個插件。查看 [完整插件目錄](https://github.com/wshobson/agents/blob/main/docs/plugins.md)。

---

## 5. 代理技能系統

### 5.1 什麼是代理技能？

代理技能是由模型控制的配置（檔案、腳本、資源等），使 Claude Code 能夠執行需要特定知識或能力的專業任務。遵循 Anthropic 的 [Agent Skills 規範](https://github.com/anthropics/skills/blob/main/agent_skills_spec.md)。

### 5.2 技能運作方式

#### 自動啟動

技能會在 Claude 檢測到您請求中的匹配模式時自動啟動：

```
"建立生產級 Kubernetes 部署與 Helm chart"
→ 自動啟動：k8s-manifest-generator、helm-chart-scaffolding
```

#### 漸進式載入

```
階段 1：元資料（始終載入）→ 技能名稱、啟動條件
階段 2：指令（啟動時）→ 核心知識和指導
階段 3：資源（按需）→ 範例、模板、參考
```

### 5.3 47 個技能分類

#### Kubernetes 操作（4 個技能）

- **k8s-manifest-generator** - 生產級 Kubernetes manifests
- **helm-chart-scaffolding** - Helm charts 設計和管理
- **gitops-workflow** - ArgoCD 和 Flux GitOps 工作流
- **k8s-security-policies** - NetworkPolicy、RBAC

#### LLM 應用開發（4 個技能）

- **langchain-architecture** - LangChain 框架設計
- **prompt-engineering-patterns** - 進階提示工程技術
- **rag-implementation** - RAG 系統與向量資料庫
- **llm-evaluation** - LLM 評估策略和基準測試

#### 後端開發（3 個技能）

- **api-design-principles** - REST 和 GraphQL API 設計
- **architecture-patterns** - Clean Architecture、DDD
- **microservices-patterns** - 微服務邊界和事件驅動

#### Python 開發（5 個技能）

- **async-python-patterns** - AsyncIO 和並發程式設計
- **python-testing-patterns** - pytest 和 fixtures
- **python-packaging** - PyPI 套件發布
- **python-performance-optimization** - 效能優化
- **uv-package-manager** - UV 快速依賴管理

#### JavaScript/TypeScript（4 個技能）

- **typescript-advanced-types** - 進階型別系統
- **nodejs-backend-patterns** - Node.js 服務開發
- **javascript-testing-patterns** - Jest、Vitest 測試
- **modern-javascript-patterns** - ES6+ 功能程式設計

#### CI/CD 自動化（4 個技能）

- **deployment-pipeline-design** - 多階段 CI/CD 管道
- **github-actions-templates** - GitHub Actions 工作流
- **gitlab-ci-patterns** - GitLab CI/CD 管道
- **secrets-management** - Vault、AWS Secrets Manager

#### 雲端基礎設施（4 個技能）

- **terraform-module-library** - 可重用 Terraform 模組
- **multi-cloud-architecture** - 多雲架構設計
- **hybrid-cloud-networking** - 混合雲網路配置
- **cost-optimization** - 雲端成本優化

#### 區塊鏈 & Web3（4 個技能）

- **defi-protocol-templates** - DeFi 協議模板
- **nft-standards** - ERC-721、ERC-1155 標準
- **solidity-security** - 智能合約安全
- **web3-testing** - Hardhat、Foundry 測試

#### 支付處理（4 個技能）

- **stripe-integration** - Stripe 付款整合
- **paypal-integration** - PayPal 付款整合
- **pci-compliance** - PCI DSS 合規
- **billing-automation** - 自動化帳單系統

#### 其他技能

- **可觀測性與監控**（4 個）：Prometheus、Grafana、分散式追蹤、SLO
- **框架遷移**（4 個）：React、Angular、資料庫、依賴升級
- **開發者必備**（8 個）：Git 進階、SQL 優化、錯誤處理、程式碼審查、E2E 測試、認證、除錯、Monorepo
- **機器學習操作**（1 個）：ML 管道工作流
- **API 腳手架**（1 個）：FastAPI 模板
- **安全掃描**（1 個）：SAST 配置

**完整技能文檔**: [Agent Skills 指南](https://github.com/wshobson/agents/blob/main/docs/agent-skills.md)

---

## 6. 85 個專業代理總覽

### 6.1 架構與系統設計（12 個代理）

#### 核心架構

| 代理                       | 模型   | 描述                                        |
| -------------------------- | ------ | ------------------------------------------- |
| **backend-architect**      | Opus   | RESTful API 設計、微服務邊界、資料庫 schema |
| **frontend-developer**     | Sonnet | React 元件、響應式佈局、客戶端狀態管理      |
| **graphql-architect**      | Opus   | GraphQL schema、resolvers、federation 架構  |
| **architect-reviewer**     | Opus   | 架構一致性分析和模式驗證                    |
| **cloud-architect**        | Opus   | AWS/Azure/GCP 基礎設施設計和成本優化        |
| **hybrid-cloud-architect** | Opus   | 跨雲端和本地環境的多雲策略                  |
| **kubernetes-architect**   | Opus   | 雲原生基礎設施與 Kubernetes、GitOps         |

#### UI/UX 與行動

| 代理                    | 模型   | 描述                             |
| ----------------------- | ------ | -------------------------------- |
| **ui-ux-designer**      | Sonnet | 介面設計、線框圖、設計系統       |
| **ui-visual-validator** | Sonnet | 視覺回歸測試和 UI 驗證           |
| **mobile-developer**    | Sonnet | React Native 和 Flutter 應用開發 |
| **ios-developer**       | Sonnet | Swift/SwiftUI 原生 iOS 開發      |
| **flutter-expert**      | Sonnet | 進階 Flutter 開發與狀態管理      |

### 6.2 程式語言專家（25 個代理）

#### 系統與低階

| 代理           | 模型   | 描述                                 |
| -------------- | ------ | ------------------------------------ |
| **c-pro**      | Sonnet | 系統程式設計與記憶體管理             |
| **cpp-pro**    | Sonnet | 現代 C++（RAII、智能指標、STL）      |
| **rust-pro**   | Sonnet | 記憶體安全系統程式設計               |
| **golang-pro** | Sonnet | 並發程式設計（goroutines、channels） |

#### Web 與應用

| 代理               | 模型   | 描述                                    |
| ------------------ | ------ | --------------------------------------- |
| **javascript-pro** | Sonnet | 現代 JavaScript（ES6+、async、Node.js） |
| **typescript-pro** | Sonnet | 進階 TypeScript 型別系統                |
| **python-pro**     | Sonnet | Python 開發與進階功能                   |
| **ruby-pro**       | Sonnet | Ruby 元程式設計、Rails、gem 開發        |
| **php-pro**        | Sonnet | 現代 PHP 框架和效能優化                 |

#### 企業與 JVM

| 代理           | 模型   | 描述                                 |
| -------------- | ------ | ------------------------------------ |
| **java-pro**   | Sonnet | 現代 Java（streams、並發、JVM 優化） |
| **scala-pro**  | Sonnet | 企業 Scala 函數式程式設計            |
| **csharp-pro** | Sonnet | C# 開發與 .NET 框架                  |

#### 專業平台（12 個）

- **elixir-pro**、**django-pro**、**fastapi-pro**、**unity-developer**、**minecraft-bukkit-pro**、**sql-pro** 等

### 6.3 基礎設施與維運（15 個代理）

#### DevOps 與部署

| 代理                      | 模型   | 描述                         |
| ------------------------- | ------ | ---------------------------- |
| **devops-troubleshooter** | Sonnet | 生產除錯、日誌分析           |
| **deployment-engineer**   | Sonnet | CI/CD 管道、容器化、雲端部署 |
| **terraform-specialist**  | Sonnet | Terraform IaC 和狀態管理     |
| **dx-optimizer**          | Sonnet | 開發者體驗優化               |

#### 資料庫管理

| 代理                   | 模型   | 描述                   |
| ---------------------- | ------ | ---------------------- |
| **database-optimizer** | Sonnet | 查詢優化、索引設計     |
| **database-admin**     | Sonnet | 資料庫操作、備份、複製 |
| **database-architect** | Opus   | 從零開始的資料庫設計   |

#### 事件響應與網路

| 代理                   | 模型   | 描述               |
| ---------------------- | ------ | ------------------ |
| **incident-responder** | Opus   | 生產事件管理和解決 |
| **network-engineer**   | Sonnet | 網路除錯、負載平衡 |

### 6.4 品質保證與安全（13 個代理）

#### 程式碼品質與審查

| 代理                        | 模型 | 描述                       |
| --------------------------- | ---- | -------------------------- |
| **code-reviewer**           | Opus | 程式碼審查（安全和可靠性） |
| **security-auditor**        | Opus | 漏洞評估和 OWASP 合規      |
| **backend-security-coder**  | Opus | 安全後端編碼實踐           |
| **frontend-security-coder** | Opus | XSS 防護、CSP 實作         |
| **mobile-security-coder**   | Opus | 行動安全模式               |

#### 測試與除錯

| 代理                 | 模型   | 描述                   |
| -------------------- | ------ | ---------------------- |
| **test-automator**   | Sonnet | 全面測試套件建立       |
| **tdd-orchestrator** | Sonnet | TDD 方法論指導         |
| **debugger**         | Sonnet | 錯誤解決和測試失敗分析 |
| **error-detective**  | Sonnet | 日誌分析和錯誤模式識別 |

#### 效能與可觀測性

| 代理                       | 模型  | 描述                          |
| -------------------------- | ----- | ----------------------------- |
| **performance-engineer**   | Opus  | 應用程式分析和優化            |
| **observability-engineer** | Opus  | 生產監控、分散式追蹤、SLI/SLO |
| **search-specialist**      | Haiku | 進階網路研究和資訊綜合        |

### 6.5 資料與 AI（7 個代理）

#### 資料工程與分析

| 代理               | 模型   | 描述                         |
| ------------------ | ------ | ---------------------------- |
| **data-scientist** | Opus   | 資料分析、SQL 查詢、BigQuery |
| **data-engineer**  | Sonnet | ETL 管道、資料倉儲、串流架構 |

#### 機器學習與 AI

| 代理                 | 模型 | 描述                            |
| -------------------- | ---- | ------------------------------- |
| **ai-engineer**      | Opus | LLM 應用、RAG 系統、提示管道    |
| **ml-engineer**      | Opus | ML 管道、模型服務、特徵工程     |
| **mlops-engineer**   | Opus | ML 基礎設施、實驗追蹤、模型註冊 |
| **prompt-engineer**  | Opus | LLM 提示優化和工程              |
| **context-engineer** | Opus | 上下文優化和 token 效率         |

### 6.6 文檔與技術寫作（5 個代理）

| 代理                  | 模型   | 描述                            |
| --------------------- | ------ | ------------------------------- |
| **docs-architect**    | Opus   | 全面的技術文檔生成              |
| **api-documenter**    | Sonnet | OpenAPI/Swagger 規格            |
| **reference-builder** | Haiku  | 技術參考和 API 文檔             |
| **tutorial-engineer** | Sonnet | 逐步教學和教育內容              |
| **mermaid-expert**    | Sonnet | 圖表建立（流程圖、序列圖、ERD） |

### 6.7 業務與營運（13 個代理）

#### 業務分析與金融

| 代理                 | 模型   | 描述                     |
| -------------------- | ------ | ------------------------ |
| **business-analyst** | Sonnet | 指標分析、報告、KPI 追蹤 |
| **quant-analyst**    | Opus   | 金融建模、交易策略       |
| **risk-manager**     | Sonnet | 投資組合風險監控         |

#### 行銷與銷售（10 個 SEO 和內容代理）

- **seo-content-auditor**、**seo-meta-optimizer**、**seo-keyword-strategist** 等
- **content-marketer**、**sales-automator**

#### 支援與法律

| 代理                 | 模型   | 描述                    |
| -------------------- | ------ | ----------------------- |
| **customer-support** | Sonnet | 支援工單、FAQ、客戶溝通 |
| **hr-pro**           | Opus   | HR 營運、政策、員工關係 |
| **legal-advisor**    | Opus   | 隱私政策、服務條款      |

### 6.8 專業領域（5 個代理）

| 代理                     | 模型   | 描述                   |
| ------------------------ | ------ | ---------------------- |
| **arm-cortex-expert**    | Sonnet | ARM Cortex-M 韌體開發  |
| **blockchain-developer** | Sonnet | Web3、智能合約、DeFi   |
| **payment-integration**  | Sonnet | Stripe、PayPal 整合    |
| **seo-analyst**          | Sonnet | 全面 SEO 審計          |
| **compliance-auditor**   | Opus   | SOC2、HIPAA、GDPR 合規 |

**完整代理參考**: [85 個代理完整清單](https://github.com/wshobson/agents/blob/main/docs/agents.md)

---

## 7. 使用指南

### 7.1 插件管理

#### 安裝和移除

```bash
# 安裝插件
/plugin install python-development

# 移除插件
/plugin remove python-development

# 列出已安裝的插件
/plugin list

# 搜尋插件
/plugin search kubernetes
```

#### 更新插件

```bash
# 更新單一插件
/plugin update python-development

# 更新所有插件
/plugin update --all
```

### 7.2 斜線命令使用

#### 基本語法

```bash
/插件名稱:命令名稱 [參數]
```

#### 常用命令範例

```bash
# Python 專案腳手架
/python-development:python-scaffold fastapi-microservice

# 安全加固
/security-scanning:security-hardening --level comprehensive

# 全端功能開發
/full-stack-orchestration:full-stack-feature "使用者認證"

# 生成單元測試
/unit-testing:test-generate src/auth.py

# Git PR 工作流
/git-pr-workflows:git-pr "修復使用者登入 bug"

# Kubernetes 部署
/kubernetes-operations:k8s-deploy production
```

### 7.3 自然語言調用

Claude 會自動選擇和協調適當的代理：

```
"使用 backend-architect 設計認證 API"
→ 啟動：backend-architect 代理

"建立生產級 Kubernetes 部署與 Helm chart 和 GitOps"
→ 啟動：kubernetes-architect 代理
→ 技能：k8s-manifest-generator、helm-chart-scaffolding、gitops-workflow

"進行全面的安全審查"
→ 啟動：security-auditor、code-reviewer、security-scanner
```

### 7.4 技能啟動

#### 自動啟動

技能會根據您的請求自動啟動：

```
"建立 FastAPI 微服務，包含非同步模式"
→ 自動啟動技能：
  - fastapi-templates
  - async-python-patterns
  - python-testing-patterns
```

#### 手動參考技能

```
"使用 terraform-module-library 技能建立 AWS VPC 模組"
```

---

## 8. 多代理工作流

### 8.1 全端功能開發

```bash
/full-stack-orchestration:full-stack-feature "使用者認證與 OAuth2"
```

**協調 7+ 代理**：

```
backend-architect → database-architect → frontend-developer
→ test-automator → security-auditor → deployment-engineer
→ observability-engineer
```

### 8.2 安全加固

```bash
/security-scanning:security-hardening --level comprehensive
```

**多代理安全評估**：

- SAST 掃描
- 依賴漏洞掃描
- 程式碼審查
- 合規檢查

### 8.3 ML 管道開發

```bash
/machine-learning-ops:ml-pipeline "推薦系統"
```

**協調**：

```
data-engineer → ml-engineer → mlops-engineer → observability-engineer
```

### 8.4 事件響應

```bash
/incident-response:incident-response "API 伺服器回應緩慢"
```

**快速分類和解決**：

```
incident-responder → devops-troubleshooter → performance-engineer
→ database-optimizer → observability-engineer
```

### 8.5 基礎設施設定

```bash
/cloud-infrastructure:terraform-scaffold aws-infrastructure
```

**協調**：

```
cloud-architect → terraform-specialist → security-auditor
→ deployment-engineer
```

**完整工作流範例**: [多代理工作流文檔](https://github.com/wshobson/agents/blob/main/docs/usage.md#multi-agent-workflow-examples)

---

## 9. 最佳實踐

### 9.1 插件選擇策略

#### 根據專案類型

**全端 Web 應用**：

```bash
/plugin install backend-development
/plugin install frontend-mobile-development
/plugin install full-stack-orchestration
/plugin install security-scanning
```

**資料科學專案**：

```bash
/plugin install python-development
/plugin install data-engineering
/plugin install machine-learning-ops
```

**雲端基礎設施**：

```bash
/plugin install cloud-infrastructure
/plugin install kubernetes-operations
/plugin install observability-monitoring
```

#### 根據團隊角色

**後端工程師**：

```bash
/plugin install backend-development
/plugin install database-design
/plugin install api-scaffolding
```

**DevOps 工程師**：

```bash
/plugin install cloud-infrastructure
/plugin install ci-cd-automation
/plugin install incident-response
```

**安全工程師**：

```bash
/plugin install security-scanning
/plugin install security-compliance
/plugin install backend-api-security
```

### 9.2 效能優化

#### Token 效率

- **只安裝需要的插件**：減少上下文大小
- **使用斜線命令**：直接調用，避免自然語言推理開銷
- **技能自動啟動**：讓 Claude 按需載入專業知識

#### 成本控制

- **混合模型策略**：Haiku 用於確定性任務，Sonnet 用於複雜推理
- **批次操作**：組合多個命令減少 API 呼叫
- **快取利用**：重複使用已載入的技能和代理

### 9.3 工作流組織

#### 專案結構

```
your-project/
├── .claude/
│   └── config.json          # 已安裝的插件列表
├── src/
├── tests/
└── README.md
```

#### 插件配置

```json
{
  "plugins": [
    "python-development",
    "backend-development",
    "security-scanning",
    "unit-testing"
  ],
  "preferences": {
    "model_strategy": "hybrid",
    "skill_disclosure": "progressive"
  }
}
```

### 9.4 團隊協作

#### 統一插件配置

```bash
# 團隊成員共享相同的插件設定
cat .claude/config.json

# 所有成員安裝相同插件
/plugin install-from-config .claude/config.json
```

#### 自訂團隊技能

```bash
# 建立團隊特定技能
mkdir -p .claude/skills/
cp team-specific-skills/*.md .claude/skills/
```

---

## 10. 延伸閱讀

### 10.1 官方資源

- [Agents GitHub 專案](https://github.com/wshobson/agents)
- [插件參考文檔](https://github.com/wshobson/agents/blob/main/docs/plugins.md)
- [代理參考文檔](https://github.com/wshobson/agents/blob/main/docs/agents.md)
- [代理技能指南](https://github.com/wshobson/agents/blob/main/docs/agent-skills.md)
- [使用指南](https://github.com/wshobson/agents/blob/main/docs/usage.md)
- [架構文檔](https://github.com/wshobson/agents/blob/main/docs/architecture.md)

### 10.2 Claude Code 官方文檔

- [Claude Code 概覽](https://docs.claude.com/en/docs/claude-code/overview)
- [Plugins 指南](https://docs.claude.com/en/docs/claude-code/plugins)
- [Subagents 指南](https://docs.claude.com/en/docs/claude-code/sub-agents)
- [Agent Skills 指南](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)
- [Slash Commands 參考](https://docs.claude.com/en/docs/claude-code/slash-commands)

### 10.3 相關專案

- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)
- [Claude Code Spec](https://github.com/gotalab/claude-code-spec)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

### 10.4 學習資源

- [代理架構設計模式](https://en.wikipedia.org/wiki/Software_agent)
- [微服務架構最佳實踐](https://microservices.io/)
- [Kubernetes 官方文檔](https://kubernetes.io/docs/)
- [Terraform 最佳實踐](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

---

## 11. 架構亮點

### 11.1 儲存庫結構

```
claude-agents/
├── .claude-plugin/
│   └── marketplace.json          # 63 個插件定義
├── plugins/
│   ├── python-development/
│   │   ├── agents/               # 3 個 Python 專家
│   │   ├── commands/             # 腳手架工具
│   │   └── skills/               # 5 個專業技能
│   ├── kubernetes-operations/
│   │   ├── agents/               # K8s 架構師
│   │   ├── commands/             # 部署工具
│   │   └── skills/               # 4 個 K8s 技能
│   └── ... (61 個更多插件)
├── docs/                          # 完整文檔
└── README.md
```

### 11.2 設計原則

- **細粒度設計**：每個插件做一件事，做好它
- **最小 token 使用**：平均每個插件 3.4 個元件
- **可組合性**：混合搭配複雜工作流
- **100% 覆蓋**：所有 85 個代理可跨插件存取

### 11.3 貢獻

要新增代理、技能或命令：

1. 在 `plugins/` 中識別或建立適當的插件目錄
2. 在適當的子目錄中建立 `.md` 檔案：
   - `agents/` - 專業代理
   - `commands/` - 工具和工作流
   - `skills/` - 模組化知識套件
3. 遵循命名規範（小寫、短橫線分隔）
4. 撰寫清晰的啟動條件和全面的內容
5. 更新 `.claude-plugin/marketplace.json` 中的插件定義

詳見 [架構文檔](https://github.com/wshobson/agents/blob/main/docs/architecture.md)。

---

## 授權

MIT License - 詳見 [LICENSE](https://github.com/wshobson/agents/blob/main/LICENSE) 檔案。

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/wshobson/agents) 與相關文檔。
>
> **版本資訊**：Claude Code Plugins - 85 個專業代理 + 63 個插件 + 47 個技能  
> **最後更新**：2025-10-28T01:30:00+08:00
