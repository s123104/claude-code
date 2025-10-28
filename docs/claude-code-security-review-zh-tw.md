# Claude Code Security Reviewer 中文說明書

## 概述

Claude Code Security Reviewer 是 **Anthropic 官方** 開發的 AI 驅動安全審查 GitHub Action，能夠分析程式碼變更以檢測安全漏洞。使用 Claude Code 工具進行**深度語義安全分析**，為 Pull Request 提供智能、上下文感知的安全評估。

自動化 CI/CD 整合，支援自訂審查規則，並生成詳細的安全報告。適合希望在開發流程中引入自動化安全檢查的團隊，提升程式碼品質和安全性。

> **專案資訊**
>
> - **專案名稱**：Claude Code Security Reviewer
> - **專案版本**：v1.0
> - **專案最後更新**：2025-08-12
> - **文件整理時間**：2025-10-28T19:00:00+08:00
>
> **核心定位**
> - **功能**：AI 驅動的 GitHub Action 安全審查工具，提供深度語義分析和自動化 CI/CD 整合
> - **場景**：Pull Request 安全檢查、CI/CD 自動化、程式碼審查、安全漏洞檢測
> - **客群**：開發團隊、安全工程師、DevSecOps 實踐者、專案管理者
>
> **資料來源**
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
- [7. 疑難排解](#7-疑難排解)
- [8. 延伸閱讀](#8-延伸閱讀)

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

### 1.2 使用場景

- **自動化安全審查**：在 PR 合併前自動檢測安全問題
- **持續安全監控**：整合到 CI/CD 流程中
- **團隊安全意識**：提升開發團隊的安全意識
- **合規性檢查**：滿足安全合規要求

---

## 2. 核心功能

### 2.1 安全漏洞檢測

- **注入攻擊**：SQL 注入、命令注入、XSS 等
- **認證與授權**：權限提升、會話管理問題
- **資料洩露**：敏感資訊暴露、日誌洩露
- **加密問題**：弱加密算法、金鑰管理不當
- **輸入驗證**：緩衝區溢出、格式字串漏洞

### 2.2 智能分析能力

- **語義理解**：理解程式碼的實際意圖和上下文
- **上下文感知**：考慮專案架構和依賴關係
- **誤報減少**：使用 AI 推理減少誤報
- **優先級排序**：根據風險等級排序發現的問題

### 2.3 整合功能

- **GitHub Actions**：無縫整合到 CI/CD 流程
- **PR 評論**：自動在 PR 上添加安全評論
- **報告生成**：生成詳細的安全審查報告
- **通知系統**：支援多種通知方式

---

## 3. 快速開始

### 3.1 基本配置

在您的儲存庫的 `.github/workflows/security.yml` 中添加以下內容：

```yaml
name: Security Review

permissions:
  pull-requests: write # 需要此權限來留下 PR 評論
  contents: read

on:
  pull_request:

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Run Security Review
        uses: anthropics/claude-code-security-review@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
```

### 3.2 環境變數設定

在您的 GitHub 儲存庫設定中添加以下密鑰：

1. 前往 **Settings** → **Secrets and variables** → **Actions**
2. 點擊 **New repository secret**
3. 名稱：`ANTHROPIC_API_KEY`
4. 值：您的 Anthropic API 金鑰

---

## 4. 安裝與配置

### 4.1 前置需求

- GitHub 儲存庫
- Anthropic API 金鑰
- GitHub Actions 啟用

### 4.2 完整配置範例

```yaml
name: Comprehensive Security Review

permissions:
  pull-requests: write
  contents: read
  security-events: write

on:
  pull_request:
    types: [opened, synchronize, reopened]
  push:
    branches: [main, develop]

jobs:
  security-review:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        include:
          - name: "Security Review"
            command: "review"
          - name: "Vulnerability Scan"
            command: "scan"

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0 # 完整歷史記錄

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "18"
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Run Security Review
        uses: anthropics/claude-code-security-review@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          command: ${{ matrix.command }}
          output_format: "detailed"
          include_patterns: "src/**,tests/**"
          exclude_patterns: "node_modules/**,dist/**"

      - name: Upload Security Report
        uses: actions/upload-artifact@v3
        with:
          name: security-report-${{ matrix.command }}
          path: security-report-*.json

      - name: Comment on PR
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const reportPath = `security-report-${context.job}.json`;

            if (fs.existsSync(reportPath)) {
              const report = JSON.parse(fs.readFileSync(reportPath, 'utf8'));
              
              const comment = `## 🔒 Security Review Results
              
              **Status**: ${report.status}
              **Vulnerabilities Found**: ${report.vulnerabilities.length}
              **Risk Level**: ${report.overall_risk}
              
              ${report.vulnerabilities.map(vuln => 
                `### ${vuln.severity}: ${vuln.title}
                - **File**: ${vuln.file}
                - **Line**: ${vuln.line}
                - **Description**: ${vuln.description}
                - **Recommendation**: ${vuln.recommendation}
                `
              ).join('\n\n')}
              
              ---
              *This review was automatically generated by Claude Code Security Reviewer*
              `;
              
              github.rest.issues.createComment({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                body: comment
              });
            }
```

### 4.3 進階配置選項

```yaml
- name: Run Security Review
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    # 基本配置
    command: "review"
    output_format: "detailed"

    # 檔案過濾
    include_patterns: "src/**,tests/**,config/**"
    exclude_patterns: "node_modules/**,dist/**,build/**"

    # 掃描選項
    scan_depth: "deep"
    max_files: 1000
    timeout_minutes: 30

    # 報告配置
    report_format: "json"
    include_recommendations: true
    include_examples: true

    # 通知配置
    notify_on_failure: true
    notify_on_success: false
    slack_webhook: ${{ secrets.SLACK_WEBHOOK }}
```

---

## 5. 使用指南

### 5.1 觸發安全審查

#### 自動觸發

- **PR 開啟**：新 PR 時自動觸發
- **PR 更新**：PR 內容變更時觸發
- **分支推送**：推送到特定分支時觸發

#### 手動觸發

```yaml
on:
  workflow_dispatch:
    inputs:
      scan_type:
        description: "Scan Type"
        required: true
        default: "full"
        type: choice
        options:
          - quick
          - full
          - deep
```

### 5.2 查看結果

#### PR 評論

安全審查完成後，會在 PR 上自動添加評論，包含：

- 發現的漏洞數量
- 風險等級評估
- 詳細的漏洞描述
- 修復建議

#### 工作流程摘要

在 GitHub Actions 頁面查看：

- 執行狀態
- 掃描結果摘要
- 詳細日誌

#### 下載報告

- JSON 格式的詳細報告
- 可整合到其他安全工具
- 支援自訂報告格式

### 5.3 自訂掃描規則

#### 專案特定規則

```yaml
# .claude/security-rules.yml
rules:
  - name: "Custom SQL Injection Check"
    pattern: "executeQuery"
    severity: "high"
    message: "Potential SQL injection vulnerability"

  - name: "API Key Validation"
    pattern: "API_KEY"
    severity: "critical"
    message: "API key should not be hardcoded"

  - name: "Input Validation"
    pattern: "userInput"
    severity: "medium"
    message: "User input should be validated"
```

#### 忽略規則

```yaml
# .claude/security-ignore.yml
ignore:
  - file: "tests/**"
    reason: "Test files are safe to ignore"

  - pattern: "TODO.*FIXME"
    reason: "Development notes"

  - file: "docs/**"
    reason: "Documentation files"
```

---

## 6. 進階配置

### 6.1 多環境配置

#### 開發環境

```yaml
- name: Development Security Review
  if: github.ref == 'refs/heads/develop'
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    command: "quick"
    output_format: "summary"
    notify_on_failure: false
```

#### 生產環境

```yaml
- name: Production Security Review
  if: github.ref == 'refs/heads/main'
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    command: "deep"
    output_format: "detailed"
    notify_on_failure: true
    slack_webhook: ${{ secrets.SLACK_WEBHOOK }}
```

### 6.2 整合其他安全工具

#### SonarQube 整合

```yaml
- name: SonarQube Analysis
  uses: sonarqube-quality-gate-action@master
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

- name: Security Review
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    previous_results: "sonarqube-results.json"
```

#### OWASP ZAP 整合

```yaml
- name: OWASP ZAP Scan
  uses: zaproxy/action-full-scan@v0.8.0
  with:
    target: "https://example.com"

- name: Security Review
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    zap_results: "zap-report.json"
```

### 6.3 自訂通知

#### Slack 通知

```yaml
- name: Security Review
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    slack_webhook: ${{ secrets.SLACK_WEBHOOK }}
    slack_channel: "#security-alerts"
    slack_username: "Security Bot"
```

#### 電子郵件通知

```yaml
- name: Send Email Notification
  if: always()
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 587
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: "Security Review Results - ${{ github.repository }}"
    to: ${{ secrets.SECURITY_TEAM_EMAIL }}
    body: |
      Security review completed for ${{ github.repository }}

      Status: ${{ job.status }}
      Vulnerabilities: ${{ steps.security.outputs.vulnerability_count }}

      View details: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

---

## 7. 疑難排解

### 7.1 常見問題

#### API 金鑰問題

```bash
# 檢查 API 金鑰是否正確設定
echo $ANTHROPIC_API_KEY

# 測試 API 連線
curl -H "x-api-key: $ANTHROPIC_API_KEY" \
     -H "content-type: application/json" \
     https://api.anthropic.com/v1/messages
```

#### 權限問題

```yaml
# 確保有足夠的權限
permissions:
  pull-requests: write # 需要寫入 PR 評論
  contents: read # 需要讀取程式碼
  security-events: write # 需要寫入安全事件
```

#### 掃描超時

```yaml
# 增加超時時間
- name: Security Review
  uses: anthropics/claude-code-security-review@v1
  with:
    timeout_minutes: 60 # 預設 30 分鐘
    max_files: 500 # 減少掃描檔案數量
```

### 7.2 效能優化

#### 快取配置

```yaml
- name: Cache dependencies
  uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

#### 並行執行

```yaml
jobs:
  security-review:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        include:
          - name: "Frontend Security"
            path: "frontend/**"
          - name: "Backend Security"
            path: "backend/**"
          - name: "Infrastructure Security"
            path: "infra/**"
```

### 7.3 除錯技巧

#### 詳細日誌

```yaml
- name: Security Review
  uses: anthropics/claude-code-security-review@v1
  with:
    anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
    debug: true
    verbose: true
```

#### 本地測試

```bash
# 在本地測試安全審查
npm install -g @anthropic-ai/claude-code
claude --security-review --path ./src --output-format json
```

---

## 8. 延伸閱讀

### 8.1 官方資源

- [Claude Code Security Reviewer GitHub](https://github.com/anthropics/claude-code-security-review)
- [官方部落格文章](https://www.anthropic.com/news/automate-security-reviews-with-claude-code)
- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [GitHub Actions 文檔](https://docs.github.com/en/actions)

### 8.2 相關專案

- [OWASP ZAP](https://owasp.org/www-project-zap/) - 網頁應用程式安全測試工具
- [SonarQube](https://www.sonarqube.org/) - 程式碼品質和安全分析
- [Snyk](https://snyk.io/) - 依賴漏洞掃描
- [CodeQL](https://codeql.github.com/) - GitHub 的程式碼分析引擎

### 8.3 安全最佳實踐

- [OWASP Top 10](https://owasp.org/www-project-top-ten/) - 網頁應用程式安全風險
- [CWE](https://cwe.mitre.org/) - 常見弱點列舉
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework) - 網路安全框架

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/anthropics/claude-code-security-review) 與相關文檔。
>
**版本資訊**：Claude Code Security Reviewer - 最新版本  
> **最後更新**：2025-08-20T00:13:54+08:00
