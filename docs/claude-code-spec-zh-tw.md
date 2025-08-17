# Claude Code Spec-Driven Development 中文說明書

> **版本**: 最新版本


> **資料來源：**
>
> - [GitHub 專案](https://github.com/gotalab/claude-code-spec)
> - [Zenn 文章](https://zenn.dev/gotalab/articles/3db0621ce3d6d2)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - **文件整理時間：2025-08-17T23:40:00+08:00**
> - **專案最後更新：2025-08-17T15:35:00+09:00**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心概念](#2-核心概念)
- [3. 安裝與設定](#3-安裝與設定)
- [4. 開發流程](#4-開發流程)
- [5. Slash Commands 詳解](#5-slash-commands-詳解)
- [6. 最佳實踐](#6-最佳實踐)
- [7. 進階應用](#7-進階應用)
- [8. 疑難排解](#8-疑難排解)
- [9. 延伸閱讀](#9-延伸閱讀)

---

## 1. 專案簡介

Claude Code Spec-Driven Development 是一個基於 Claude Code 的規格驅動開發框架，透過結構化的 Slash Commands 和 CLAUDE.md 配置，實現系統性的開發流程。這個專案完整重現了 Kiro IDE 的規格驅動開發流程，讓開發者能夠在 Claude Code 環境中享受相同的開發體驗。

### 1.1 核心特色

- **規格驅動**：從需求分析到程式碼實作的完整驅動流程
- **結構化命令**：15+ 個專業化的 Slash Commands
- **標準化流程**：遵循 Kiro IDE 的成熟開發流程
- **即插即用**：簡單的檔案複製即可導入現有專案
- **品質保證**：內建測試、審查和文檔生成流程

### 1.2 使用場景

- **新專案啟動**：規格驅動的專案初始化和架構設計
- **功能開發**：從規格設計到程式碼實作的完整流程
- **程式碼品質**：結構化的測試、審查和重構流程
- **團隊協作**：標準化的開發流程和文檔管理
- **維護升級**：系統性的功能擴展和維護策略

---

## 2. 核心概念

### 2.1 規格驅動開發 (Spec-Driven Development)

規格驅動開發是一種以規格為中心的開發方法論：

1. **需求分析** → 建立詳細的功能規格
2. **規格設計** → 定義介面和行為規範
3. **程式碼實作** → 基於規格進行開發
4. **測試驗證** → 確保實作符合規格
5. **迭代優化** → 基於回饋持續改進

### 2.2 Kiro IDE 開發流程

本專案完整重現 Kiro IDE 的開發流程：

- **Steering Document**：專案方向性文檔
- **Spec Document**：詳細功能規格
- **Implementation**：程式碼實作
- **Testing**：測試驗證
- **Documentation**：文檔生成

### 2.3 目錄結構

```
your-project/
├── .claude/
│   └── commands/          # Slash Commands 定義
├── .kiro/
│   ├── steering/          # 方向性文檔
│   ├── specs/            # 功能規格
│   ├── implementations/   # 實作記錄
│   └── tests/            # 測試文檔
├── CLAUDE.md             # Claude Code 配置
└── [your project files]
```

---

## 3. 安裝與設定

### 3.1 快速安裝

#### 步驟 1：複製必要檔案

```bash
# 克隆專案
git clone https://github.com/gotalab/claude-code-spec.git

# 複製到您的專案
cp -r claude-code-spec/.claude/commands/ your-project/.claude/
cp claude-code-spec/CLAUDE.md your-project/
```

#### 步驟 2：調整專案配置

```bash
# 編輯 CLAUDE.md 以符合您的專案需求
vim your-project/CLAUDE.md
```

#### 步驟 3：初始化專案

```bash
# 移動到專案目錄
cd your-project

# 啟動 Claude Code
claude

# 執行初始化指令
/kiro:spec-init "您的專案詳細描述"
```

### 3.2 配置檔案

#### CLAUDE.md 範例

```markdown
# 專案：[您的專案名稱]

## 專案概述

[詳細的專案描述]

## 技術棧

- 後端：[技術棧]
- 前端：[技術棧]
- 資料庫：[資料庫選擇]

## 開發規範

### 程式碼風格

- 使用 TypeScript strict 模式
- 遵循 ESLint 規範
- 函數必須有 JSDoc 註解

### 測試要求

- 單元測試覆蓋率 ≥ 80%
- 整合測試覆蓋核心流程
- E2E 測試覆蓋關鍵用戶流程

## Kiro 規格驅動開發流程

本專案採用規格驅動開發模式，請依照以下流程：

1. 先建立或更新 steering document (`/kiro:steering`)
2. 為新功能建立詳細規格 (`/kiro:spec`)
3. 基於規格實作程式碼 (`/kiro:implement`)
4. 撰寫並執行測試 (`/kiro:test`)
5. 生成文檔 (`/kiro:doc`)
```

---

## 4. 開發流程

### 4.1 專案啟動流程

#### 1. 建立 Steering Document

```bash
# 建立專案方向性文檔
/kiro:steering
```

這會創建一個高階的專案方向文檔，包含：

- 專案目標和願景
- 核心功能概述
- 技術架構決策
- 開發里程碑

#### 2. 初始化功能規格

```bash
# 為核心功能建立規格
/kiro:spec-init "用戶認證系統實作"
```

### 4.2 功能開發流程

#### 1. 建立功能規格

```bash
# 為新功能建立詳細規格
/kiro:spec "實作 OAuth2 登入功能"
```

規格文檔包含：

- 功能需求描述
- API 介面定義
- 資料結構設計
- 錯誤處理策略

#### 2. 程式碼實作

```bash
# 基於規格實作程式碼
/kiro:implement
```

實作過程會：

- 參考已建立的規格
- 遵循專案的程式碼風格
- 實作完整的錯誤處理
- 加入適當的日誌記錄

#### 3. 測試開發

```bash
# 撰寫並執行測試
/kiro:test
```

測試流程包含：

- 單元測試撰寫
- 整合測試設計
- 測試執行和結果分析
- 覆蓋率報告生成

#### 4. 文檔生成

```bash
# 生成或更新文檔
/kiro:doc
```

### 4.3 程式碼維護流程

#### 重構和優化

```bash
# 程式碼重構
/kiro:refactor

# 效能優化
/kiro:optimize

# 程式碼審查
/kiro:review
```

---

## 5. Slash Commands 詳解

### 5.1 專案管理指令

#### `/kiro:steering`

- **功能**：建立或更新專案方向性文檔
- **用途**：定義專案高階目標和架構決策
- **輸出**：`.kiro/steering/` 目錄下的文檔

```bash
# 使用範例
/kiro:steering
```

#### `/kiro:spec-init`

- **功能**：初始化新功能的規格文檔
- **語法**：`/kiro:spec-init "功能描述"`
- **輸出**：`.kiro/specs/` 目錄下的規格文檔

```bash
# 使用範例
/kiro:spec-init "用戶管理系統"
```

### 5.2 規格開發指令

#### `/kiro:spec`

- **功能**：建立詳細的功能規格
- **語法**：`/kiro:spec "功能詳細描述"`
- **特色**：包含 API 設計、資料結構、錯誤處理

```bash
# 使用範例
/kiro:spec "實作用戶註冊和驗證功能"
```

#### `/kiro:spec-update`

- **功能**：更新現有規格文檔
- **用途**：根據新需求或回饋修改規格
- **特色**：保持規格與實作的同步

```bash
# 使用範例
/kiro:spec-update
```

### 5.3 實作開發指令

#### `/kiro:implement`

- **功能**：基於規格實作程式碼
- **特色**：嚴格遵循規格要求
- **輸出**：完整的程式碼實作和說明

```bash
# 使用範例
/kiro:implement
```

#### `/kiro:implement-api`

- **功能**：專注於 API 層實作
- **特色**：包含路由、中介軟體、驗證邏輯
- **最佳實踐**：RESTful 設計原則

```bash
# 使用範例
/kiro:implement-api
```

### 5.4 測試相關指令

#### `/kiro:test`

- **功能**：撰寫和執行測試
- **覆蓋範圍**：單元測試、整合測試、E2E 測試
- **輸出**：測試程式碼和執行報告

```bash
# 使用範例
/kiro:test
```

#### `/kiro:test-unit`

- **功能**：專注於單元測試
- **特色**：高覆蓋率、邊界條件測試
- **工具整合**：Jest、Mocha 等測試框架

```bash
# 使用範例
/kiro:test-unit
```

### 5.5 品質保證指令

#### `/kiro:review`

- **功能**：程式碼審查和品質檢查
- **檢查項目**：程式碼風格、安全性、效能
- **輸出**：審查報告和改進建議

```bash
# 使用範例
/kiro:review
```

#### `/kiro:refactor`

- **功能**：程式碼重構建議和實作
- **重構類型**：結構優化、效能改善、可讀性提升
- **安全性**：保證功能不變的前提下進行重構

```bash
# 使用範例
/kiro:refactor
```

### 5.6 文檔管理指令

#### `/kiro:doc`

- **功能**：生成或更新專案文檔
- **文檔類型**：API 文檔、使用指南、架構說明
- **格式**：Markdown、OpenAPI 規格

```bash
# 使用範例
/kiro:doc
```

#### `/kiro:changelog`

- **功能**：生成變更日誌
- **特色**：基於 git 歷史和規格變更
- **格式**：遵循 Keep a Changelog 標準

```bash
# 使用範例
/kiro:changelog
```

---

## 6. 最佳實踐

### 6.1 規格撰寫最佳實踐

#### 規格文檔結構

````markdown
# 功能名稱

## 概述

[功能的高階描述]

## 需求分析

- 功能需求
- 非功能需求
- 約束條件

## API 設計

### 端點定義

- `POST /api/users` - 建立用戶
- `GET /api/users/:id` - 獲取用戶資訊

### 資料結構

```json
{
  "user": {
    "id": "string",
    "email": "string",
    "createdAt": "datetime"
  }
}
```
````

## 錯誤處理

- 400 Bad Request - 請求資料無效
- 401 Unauthorized - 未授權存取
- 500 Internal Server Error - 伺服器錯誤

## 測試計劃

- 單元測試：覆蓋所有公開方法
- 整合測試：API 端點完整測試
- E2E 測試：完整用戶流程測試

````

#### 規格品質檢查清單

- [ ] 需求描述清晰明確
- [ ] API 介面完整定義
- [ ] 資料結構詳細說明
- [ ] 錯誤情況完整覆蓋
- [ ] 測試計劃具體可行
- [ ] 效能要求明確定義

### 6.2 開發流程最佳實踐

#### 工作流程規範

1. **規格優先**：任何程式碼變更前先更新規格
2. **小步迭代**：將大功能分解為小的可測試單元
3. **測試驅動**：基於規格先撰寫測試再實作
4. **持續審查**：定期審查程式碼和規格的一致性
5. **文檔同步**：確保文檔與實作保持同步

#### 版本控制整合

```bash
# Git 提交訊息範例
git commit -m "feat: implement user authentication according to spec #123"
git commit -m "docs: update API spec for user management"
git commit -m "test: add unit tests for authentication service"
````

### 6.3 團隊協作最佳實踐

#### 規格審查流程

1. **規格撰寫**：由功能負責人撰寫初版規格
2. **技術審查**：技術團隊審查可行性和技術細節
3. **產品審查**：產品團隊確認需求符合度
4. **最終確認**：所有相關人員簽名確認規格

#### 知識分享機制

- **週會分享**：定期分享規格驅動開發心得
- **內部文檔**：建立團隊內部的最佳實踐文檔
- **程式碼審查**：在審查中強化規格驅動思維
- **培訓計劃**：為新成員提供規格驅動開發培訓

---

## 7. 進階應用

### 7.1 多專案整合

#### 微服務架構支援

```bash
# 為每個微服務建立獨立的規格
/kiro:spec "用戶服務 API 規格"
/kiro:spec "訂單服務 API 規格"
/kiro:spec "支付服務 API 規格"

# 建立服務間介面規格
/kiro:spec "服務間通訊協議"
```

#### 共享規格管理

```yaml
# .kiro/config.yml
shared_specs:
  - path: "../shared-specs/"
    type: "api-contracts"
  - path: "../common-models/"
    type: "data-models"

import_rules:
  - pattern: "*.api.md"
    target: "specs/apis/"
  - pattern: "*.model.md"
    target: "specs/models/"
```

### 7.2 CI/CD 整合

#### GitHub Actions 整合

```yaml
# .github/workflows/spec-validation.yml
name: Spec Validation
on: [push, pull_request]

jobs:
  validate-specs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Validate Specifications
        run: |
          # 檢查規格格式
          npm run spec:validate

          # 檢查規格與程式碼一致性
          npm run spec:check-consistency

          # 生成規格報告
          npm run spec:report
```

#### 自動化品質檢查

```bash
# package.json scripts
{
  "scripts": {
    "spec:validate": "kiro-cli validate .kiro/specs/",
    "spec:check-consistency": "kiro-cli check-consistency",
    "spec:report": "kiro-cli generate-report",
    "spec:sync": "kiro-cli sync-with-code"
  }
}
```

### 7.3 客製化擴展

#### 自訂 Slash Commands

```markdown
# .claude/commands/custom/database-migration.md

# database-migration

基於規格建立資料庫遷移腳本

## Description

分析規格中的資料模型變更，自動生成資料庫遷移腳本

## Usage

/database-migration

## Implementation

1. 分析 .kiro/specs/ 中的資料模型
2. 比較與現有資料庫架構的差異
3. 生成安全的遷移腳本
4. 包含回滾機制
```

#### 規格模板客製化

```markdown
# .kiro/templates/api-spec.md

# API 規格模板

## 端點資訊

- **路徑**:
- **方法**:
- **描述**:

## 請求格式

### Headers

### Parameters

### Body

## 回應格式

### 成功回應

### 錯誤回應

## 商業邏輯

### 驗證規則

### 處理流程

### 副作用

## 測試案例

### 正常情況

### 邊界情況

### 錯誤情況
```

---

## 8. 疑難排解

### 8.1 常見問題

#### 規格與實作不一致

**問題**：程式碼實作與規格文檔有差異

**解決方案**：

```bash
# 檢查一致性
/kiro:review

# 更新規格以反映實作
/kiro:spec-update

# 或修改程式碼以符合規格
/kiro:implement
```

#### 命令執行失敗

**問題**：Slash Commands 無法正常執行

**檢查清單**：

- [ ] `.claude/commands/` 目錄是否存在
- [ ] `CLAUDE.md` 檔案是否正確配置
- [ ] Claude Code 是否為最新版本
- [ ] 專案目錄結構是否正確

#### 文檔生成問題

**問題**：文檔生成不完整或格式錯誤

**解決方案**：

```bash
# 檢查規格格式
/kiro:spec-validate

# 重新生成文檔
/kiro:doc --force

# 檢查 CLAUDE.md 中的文檔配置
```

### 8.2 效能優化

#### 大型專案效能調優

- **規格分片**：將大型規格分解為多個小檔案
- **快取機制**：啟用 Claude Code 的快取功能
- **並行處理**：使用多個 Claude 實例處理不同模組

#### 記憶體使用優化

```yaml
# .claude/config.yml
performance:
  cache_size: 1024MB
  max_context_length: 10000
  batch_processing: true
```

---

## 9. 延伸閱讀

### 9.1 官方資源

- [Claude Code Spec-Driven Development GitHub](https://github.com/gotalab/claude-code-spec)
- [Kiro 仕様書駆動開発プロセス - Zenn](https://zenn.dev/gotalab/articles/3db0621ce3d6d2)
- [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)

### 9.2 相關專案

- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
- [Claude Code Hooks](https://github.com/aliceric27/claude-code-hooks)
- [SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)

### 9.3 學習資源

- [規格驅動開發方法論](https://en.wikipedia.org/wiki/Specification-driven_development)
- [API 設計最佳實踐](https://swagger.io/resources/articles/best-practices-in-api-design/)
- [軟體架構文檔化](https://c4model.com/)
- [測試驅動開發](https://testdriven.io/)

### 9.4 社群支援

- [Gotalab Community](https://github.com/gotalab)
- [Claude Code Discord](https://discord.com/channels/claude-code)
- [規格驅動開發討論群](https://github.com/gotalab/claude-code-spec/discussions)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/gotalab/claude-code-spec) 與相關文檔。
>
> **版本資訊**：Claude Code Spec-Driven Development - 規格驅動開發框架  
> **最後更新**：2025-08-17T23:40:00+08:00
