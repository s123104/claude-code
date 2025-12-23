# Claude Code Security Reviewer 中文說明書

## 概述

Claude Code Security Reviewer 是 **Anthropic 官方** 開發的 AI 驅動安全審查 GitHub Action，能夠分析程式碼變更以檢測安全漏洞。使用 Claude Code 工具進行**深度語義安全分析**，為 Pull Request 提供智能、上下文感知的安全評估。

自動化 CI/CD 整合，支援自訂審查規則，並生成詳細的安全報告。適合希望在開發流程中引入自動化安全檢查的團隊，提升程式碼品質和安全性。

> **專案資訊**
>
> - **專案名稱**：Claude Code Security Reviewer
> - **專案版本**：v1.0
> - **專案最後更新**：2025-08-25
> - **文件整理時間**：2025-12-24T00:42:00+08:00
>
> **核心定位**
>
> - **功能**：AI 驅動的 GitHub Action 安全審查工具，提供深度語義分析和自動化 CI/CD 整合
> - **場景**：Pull Request 安全檢查、CI/CD 自動化、程式碼審查、安全漏洞檢測
> - **客群**：開發團隊、安全工程師、DevSecOps 實踐者、專案管理者
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/anthropics/claude-code-security-review)（Anthropic 官方）
> - [官方部落格文章](https://www.anthropic.com/news/automate-security-reviews-with-claude-code)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [GitHub Actions 官方文檔](https://docs.github.com/en/actions)

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心功能](#2-核心功能)
- [3. 快速開始](#3-快速開始)
- [4. 安裝與配置](#4-安裝與配置)
- [5. 使用指南](#5-使用指南)
- [6. 進階配置](#6-進階配置)
- [7. Claude Code 整合](#7-claude-code-整合)
- [8. 疑難排解](#8-疑難排解)
- [9. 延伸閱讀](#9-延伸閱讀)

---

## 1. 專案簡介

Claude Code Security Reviewer 是一個使用 Claude 進行 AI 驅動安全審查的 GitHub Action，能夠分析程式碼變更以檢測安全漏洞。此 Action 使用 Anthropic 的 Claude Code 工具進行深度語義安全分析，為 Pull Request 提供智能、上下文感知的安全分析。

### 1.1 專案特色

- **AI 驅動分析**：使用 Claude 的先進推理能力檢測安全漏洞，具備深度語義理解
- **差異感知掃描**：針對 PR，僅分析變更的檔案
- **PR 評論**：自動在 PR 上留下安全發現的評論
- **上下文理解**：超越模式匹配，理解程式碼語義
- **語言無關**：支援任何程式語言
- **誤報過濾**：進階過濾減少噪音，專注於真實漏洞
- **快取機制**：防止同一 PR 重複執行，減少誤報
- **Claude Code 整合**：支援 `/security-review` 斜線命令

### 1.2 使用場景

- **自動化安全審查**：在 PR 合併前自動檢測安全問題
- **持續安全監控**：整合到 CI/CD 流程中
- **團隊安全意識**：提升開發團隊的安全意識
- **合規性檢查**：滿足安全合規要求

---

## 2. 核心功能

### 2.1 安全漏洞檢測

#### 檢測的漏洞類型

- **注入攻擊**：SQL 注入、命令注入、LDAP 注入、XPath 注入、NoSQL 注入、XXE
- **認證與授權**：認證繞過、權限提升、會話管理缺陷、JWT 漏洞、授權邏輯繞過
- **資料洩露**：硬編碼密鑰、敏感資料日誌、資訊洩露、PII 處理違規
- **加密問題**：弱加密算法、不當的金鑰管理、不安全的隨機數生成、憑證驗證繞過
- **輸入驗證**：缺少驗證、不當的清理、緩衝區溢出
- **業務邏輯缺陷**：競爭條件、TOCTOU（Time-of-Check-Time-of-Use）問題
- **配置安全**：不安全的預設值、缺少安全標頭、過於寬鬆的 CORS
- **供應鏈**：易受攻擊的依賴、域名搶注風險
- **程式碼執行**：透過反序列化的 RCE、pickle 注入、eval 注入
- **跨站腳本攻擊（XSS）**：反射型、儲存型、DOM 型 XSS

### 2.2 智能分析能力

- **語義理解**：理解程式碼的實際意圖和上下文
- **上下文感知**：考慮專案架構和依賴關係
- **誤報減少**：使用 AI 推理減少誤報
- **優先級排序**：根據風險等級排序發現的問題

### 2.3 誤報過濾

工具會自動排除以下低影響和容易誤報的發現，專注於高影響漏洞：

- 拒絕服務（DoS）漏洞
- 速率限制問題
- 記憶體/CPU 耗盡問題
- 沒有實際影響的通用輸入驗證
- 開放重定向漏洞

誤報過濾可以根據專案的特定安全目標進行調整。

### 2.4 整合功能

- **GitHub Actions**：無縫整合到 CI/CD 流程
- **PR 評論**：自動在 PR 上添加安全評論
- **報告生成**：生成詳細的安全審查報告（JSON 格式）
- **Artifact 上傳**：自動上傳掃描結果作為 GitHub Actions artifacts

---

## 3. 快速開始

### 3.1 基本配置

在您的儲存庫的 `.github/workflows/security.yml` 中添加以下內容：

```yaml
name: Security Review

permissions:
  pull-requests: write  # 需要此權限來留下 PR 評論
  contents: read

on:
  pull_request:

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.pull_request.head.sha || github.sha }}
          fetch-depth: 2
      
      - uses: anthropics/claude-code-security-review@main
        with:
          comment-pr: true
          claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
```

### 3.2 API 金鑰設定

**重要**：API 金鑰需要同時啟用 Claude API 和 Claude Code 使用權限。

在您的 GitHub 儲存庫設定中添加以下密鑰：

1. 前往 **Settings** → **Secrets and variables** → **Actions**
2. 點擊 **New repository secret**
3. 名稱：`CLAUDE_API_KEY`
4. 值：您的 Anthropic API 金鑰（需要同時啟用 Claude API 和 Claude Code）

---

## 4. 安裝與配置

### 4.1 前置需求

- GitHub 儲存庫
- Anthropic API 金鑰（需要同時啟用 Claude API 和 Claude Code）
- GitHub Actions 啟用

### 4.2 Action 輸入參數

| 輸入參數 | 描述 | 預設值 | 必填 |
|---------|------|--------|------|
| `claude-api-key` | Anthropic Claude API 金鑰（需要同時啟用 Claude API 和 Claude Code） | 無 | 是 |
| `comment-pr` | 是否在 PR 上留下發現的評論 | `true` | 否 |
| `upload-results` | 是否將結果上傳為 artifacts | `true` | 否 |
| `exclude-directories` | 要從掃描中排除的目錄列表（逗號分隔） | 無 | 否 |
| `claude-model` | 要使用的 Claude [模型名稱](https://docs.anthropic.com/en/docs/about-claude/models/overview#model-names)，預設為 Opus 4.1 | `claude-opus-4-1-20250805` | 否 |
| `claudecode-timeout` | ClaudeCode 分析的超時時間（分鐘） | `20` | 否 |
| `run-every-commit` | 在每個 commit 上運行 ClaudeCode（跳過快取檢查）。警告：在有很多 commit 的 PR 上可能會增加誤報 | `false` | 否 |
| `false-positive-filtering-instructions` | 自訂誤報過濾指令文字檔的路徑 | 無 | 否 |
| `custom-security-scan-instructions` | 要附加到審計提示的自訂安全掃描指令文字檔路徑 | 無 | 否 |

### 4.3 Action 輸出

| 輸出 | 描述 |
|------|------|
| `findings-count` | 安全發現的總數 |
| `results-file` | 結果 JSON 檔案的路徑 |

### 4.4 完整配置範例

```yaml
name: Security Review

permissions:
  pull-requests: write
  contents: read

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  security-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.pull_request.head.sha || github.sha }}
          fetch-depth: 2
      
      - uses: anthropics/claude-code-security-review@main
        with:
          comment-pr: true
          upload-results: true
          claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
          exclude-directories: "node_modules,dist,build,.git"
          claude-model: "claude-opus-4-1-20250805"
          claudecode-timeout: 30
          false-positive-filtering-instructions: ".github/false-positive-filtering.txt"
          custom-security-scan-instructions: ".github/custom-security-scan-instructions.txt"
```

---

## 5. 使用指南

### 5.1 觸發安全審查

#### 自動觸發

- **PR 開啟**：新 PR 時自動觸發
- **PR 更新**：PR 內容變更時觸發（`synchronize` 事件）
- **PR 重新開啟**：關閉的 PR 重新開啟時觸發

#### 快取機制

Action 使用快取機制防止同一 PR 重複執行：

- **預設行為**：每個 PR 只執行一次，後續 commit 會跳過
- **強制執行**：設定 `run-every-commit: true` 可在每個 commit 上執行（可能增加誤報）

### 5.2 查看結果

#### PR 評論

安全審查完成後，會在 PR 上自動添加評論，包含：

- 發現的漏洞數量
- 風險等級評估
- 詳細的漏洞描述
- 修復建議
- 具體的檔案和行號

#### 工作流程摘要

在 GitHub Actions 頁面查看：

- 執行狀態
- 掃描結果摘要
- 詳細日誌
- 錯誤日誌（如果有）

#### 下載報告

- **Artifacts**：掃描結果會自動上傳為 artifacts
  - `findings.json`：發現的漏洞列表
  - `claudecode-results.json`：完整的掃描結果
  - `claudecode-error.log`：錯誤日誌（如果有）
- **JSON 格式**：可整合到其他安全工具
- **保留期限**：Artifacts 預設保留 7 天

### 5.3 自訂掃描配置

#### 自訂誤報過濾指令

建立自訂誤報過濾指令檔案（例如 `.github/false-positive-filtering.txt`）：

```text
HARD EXCLUSIONS - Automatically exclude findings matching these patterns:
1. All DOS/resource exhaustion - we have k8s resource limits and autoscaling
2. Missing rate limiting - handled by our API gateway
3. Test files (ending in _test.go, _test.js, or in __tests__ directories)
4. Documentation files (*.md, *.rst)
5. Memory safety in Rust, Go, or managed languages

SIGNAL QUALITY CRITERIA - For remaining findings, assess:
1. Can an unauthenticated external attacker exploit this?
2. Is there actual data exfiltration or system compromise potential?
3. Is this exploitable in our production Kubernetes environment?

PRECEDENTS - 
1. We use AWS Cognito for all authentication - auth bypass must defeat Cognito
2. All APIs require valid JWT tokens validated at the gateway level
3. SQL injection is only valid if using raw queries (we use Prisma ORM everywhere)
```

在 workflow 中使用：

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    false-positive-filtering-instructions: ".github/false-positive-filtering.txt"
```

#### 自訂安全掃描指令

建立自訂安全掃描指令檔案（例如 `.github/custom-security-scan-instructions.txt`）：

```text
**Compliance-Specific Checks:**
- GDPR Article 17 "Right to Erasure" implementation gaps
- HIPAA PHI encryption at rest violations
- PCI DSS credit card data retention beyond allowed periods

**Financial Services Security:**
- Transaction replay attacks in payment processing
- Double-spending vulnerabilities in ledger systems
- Interest calculation manipulation through timing attacks

**E-commerce Specific:**
- Shopping cart manipulation for price changes
- Inventory race conditions allowing overselling
- Coupon/discount stacking exploits
```

在 workflow 中使用：

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    custom-security-scan-instructions: ".github/custom-security-scan-instructions.txt"
```

---

## 6. 進階配置

### 6.1 排除目錄

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    exclude-directories: "node_modules,dist,build,.git,vendor"
```

### 6.2 選擇 Claude 模型

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    claude-model: "claude-sonnet-4-20250514"  # 使用 Sonnet 4
```

### 6.3 調整超時時間

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    claudecode-timeout: 30  # 30 分鐘超時
```

### 6.4 每個 Commit 執行

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    run-every-commit: true  # 警告：可能增加誤報
```

---

## 7. Claude Code 整合

### 7.1 `/security-review` 斜線命令

Claude Code 預設提供 `/security-review` [斜線命令](https://docs.anthropic.com/en/docs/claude-code/slash-commands)，提供與 GitHub Action 工作流程相同的安全分析功能，但直接整合到您的 Claude Code 開發環境中。

#### 使用方式

在 Claude Code 中執行：

```
/security-review
```

這會對所有待處理的變更執行全面的安全審查。

### 7.2 自訂命令

您可以自訂 `/security-review` 命令以符合您的特定安全需求：

1. 從此儲存庫複製 [`security-review.md`](https://github.com/anthropics/claude-code-security-review/blob/main/.claude/commands/security-review.md) 檔案到您專案的 `.claude/commands/` 資料夾
2. 編輯 `security-review.md` 以自訂安全分析。例如，您可以添加組織特定的誤報過濾指令

---

## 8. 疑難排解

### 8.1 常見問題

#### API 金鑰問題

**錯誤訊息**：`ANTHROPIC_API_KEY is not set`

**解決方案**：

1. 確認已在 GitHub Secrets 中設定 `CLAUDE_API_KEY`
2. 確認 API 金鑰同時啟用了 Claude API 和 Claude Code 使用權限
3. 檢查 workflow 檔案中的 secret 名稱是否正確

#### 權限問題

**錯誤訊息**：無法在 PR 上留下評論

**解決方案**：

```yaml
permissions:
  pull-requests: write  # 需要寫入 PR 評論
  contents: read        # 需要讀取程式碼
```

#### 掃描超時

**錯誤訊息**：ClaudeCode 分析超時

**解決方案**：

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    claudecode-timeout: 30  # 增加超時時間（預設 20 分鐘）
```

#### 快取問題

如果快取導致問題，可以強制執行：

```yaml
- uses: anthropics/claude-code-security-review@main
  with:
    claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
    run-every-commit: true  # 跳過快取檢查
```

### 8.2 除錯技巧

#### 查看詳細日誌

在 GitHub Actions 頁面查看：

- **ClaudeCode Environment**：環境變數和配置
- **ClaudeCode Execution**：執行過程和結果
- **Error Log**：錯誤日誌（如果有）

#### 檢查結果檔案

下載 artifacts 並檢查：

- `claudecode-results.json`：完整的掃描結果
- `claudecode-error.log`：錯誤日誌
- `findings.json`：發現的漏洞列表

### 8.3 本地測試

使用評估框架在本地測試安全掃描器：

```bash
cd claude-code-security-review
# 查看評估框架文檔
cat claudecode/evals/README.md
```

---

## 9. 延伸閱讀

### 9.1 官方資源

- [Claude Code Security Reviewer GitHub](https://github.com/anthropics/claude-code-security-review)
- [官方部落格文章](https://www.anthropic.com/news/automate-security-reviews-with-claude-code)
- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [GitHub Actions 文檔](https://docs.github.com/en/actions)

### 9.2 相關專案

- [OWASP ZAP](https://owasp.org/www-project-zap/) - 網頁應用程式安全測試工具
- [SonarQube](https://www.sonarqube.org/) - 程式碼品質和安全分析
- [Snyk](https://snyk.io/) - 依賴漏洞掃描
- [CodeQL](https://codeql.github.com/) - GitHub 的程式碼分析引擎

### 9.3 安全最佳實踐

- [OWASP Top 10](https://owasp.org/www-project-top-ten/) - 網頁應用程式安全風險
- [CWE](https://cwe.mitre.org/) - 常見弱點列舉
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework) - 網路安全框架

### 9.4 自訂配置文檔

- [自訂誤報過濾指令](https://github.com/anthropics/claude-code-security-review/blob/main/docs/custom-filtering-instructions.md)
- [自訂安全掃描指令](https://github.com/anthropics/claude-code-security-review/blob/main/docs/custom-security-scan-instructions.md)
- [範例檔案](https://github.com/anthropics/claude-code-security-review/tree/main/examples)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/anthropics/claude-code-security-review) 與相關文檔。
>
> **版本資訊**：Claude Code Security Reviewer v1.0 - AI 驅動的 GitHub Action 安全審查工具  
> **最後更新**：2025-11-25T00:15:00+08:00  
> **專案更新**：2025-08-25T14:16:53-07:00  
> **主要變更**：更新 Action 輸入參數說明、新增快取機制說明、新增 Claude Code 整合章節、更新自訂配置說明、更新誤報過濾說明
