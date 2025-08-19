# ccusage 中文說明書

## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/ryoppippi/ccusage)
> - [NPM 套件頁面](https://npmjs.com/package/ccusage)
> - [ClaudeLog 整合](https://claudelog.com/)
> - **文件整理時間：2025-08-19T23:52:25+08:00**
> - **專案版本：v15.10.0**
> - **專案最後更新：2025-08-19T16:00:22+01:00**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心功能](#2-核心功能)
- [3. 安裝與快速開始](#3-安裝與快速開始)
- [4. 使用指南](#4-使用指南)
- [5. 進階功能](#5-進階功能)
- [6. 整合與擴展](#6-整合與擴展)
- [7. 疑難排解](#7-疑難排解)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 專案簡介

ccusage 是一個專為 Claude Code 設計的用量分析工具，能夠從本地 JSONL 檔案快速分析您的 Claude Code token 使用量和成本。憑藉極小的套件大小和高效的處理能力，ccusage 為開發者提供了深入了解 AI 開發成本的強大工具。

### 1.1 核心特色

- **極速分析**：憑藉極小的套件大小，提供快速的用量分析
- **成本追蹤**：詳細追蹤 token 使用量和相關成本
- **本地處理**：從本地 JSONL 檔案讀取資料，保護隱私
- **豐富報告**：提供詳細的使用量統計和成本分析
- **多平台支援**：支援 Windows、macOS 和 Linux

### 1.2 使用場景

- **成本監控**：追蹤 Claude Code 開發成本
- **用量分析**：分析不同專案和功能的 token 使用情況
- **預算規劃**：根據使用模式規劃 AI 開發預算
- **效能優化**：識別高成本的開發模式並進行優化
- **團隊管理**：監控團隊整體的 AI 工具使用情況

---

## 2. 核心功能

### 2.1 用量分析

- **Token 統計**：詳細的輸入和輸出 token 統計
- **成本計算**：根據不同模型計算精確成本
- **時間分析**：按時間段分析使用模式
- **專案分類**：按專案或功能分類使用情況

### 2.2 報告功能

- **圖表視覺化**：生成直觀的使用量圖表
- **成本趨勢**：追蹤成本變化趨勢
- **使用模式**：分析使用習慣和模式
- **匯出功能**：支援多種格式的報告匯出

### 2.3 整合能力

- **ClaudeLog 整合**：與 ClaudeLog 知識庫系統整合
- **JSONL 支援**：直接讀取 Claude Code 的 JSONL 日誌檔案
- **API 整合**：提供 API 介面供其他工具整合

### 2.4 新版本亮點（v15.10.0）

- 新增 `config-schema.json`，提供完整設定 Schema 與 IDE 智能提示
- 新增 `scripts/generate-json-schema.ts`，可自動產生與同步設定 Schema
- 指令體驗增強：`blocks`、`daily`、`weekly`、`session`、`statusline`
- `docs/guide/*` 文件擴充：`configuration.md`、`statusline.md` 等

---

## 3. 安裝與快速開始

### 3.1 快速開始（推薦）

由於 ccusage 的套件大小極小，您可以直接執行而無需安裝：

```bash
# 使用 bunx（推薦，速度最快）
bunx ccusage

# 使用 npx
npx ccusage

# 使用 pnpm
pnpm dlx ccusage
```

### 3.2 全域安裝

```bash
# 使用 npm
npm install -g ccusage

# 使用 yarn
yarn global add ccusage

# 使用 pnpm
pnpm add -g ccusage

# 使用 bun
bun install -g ccusage
```

### 3.3 本地安裝

```bash
# 克隆專案
git clone https://github.com/ryoppippi/ccusage.git
cd ccusage

# 安裝依賴
npm install

# 建置專案
npm run build

# 執行
npm start
```

---

## 4. 使用指南

### 4.1 基本使用

#### 分析單一檔案

```bash
# 分析指定的 JSONL 檔案
ccusage path/to/your/file.jsonl

# 分析多個檔案
ccusage file1.jsonl file2.jsonl file3.jsonl

# 分析目錄中的所有 JSONL 檔案
ccusage ./logs/
```

#### 基本選項

```bash
# 顯示詳細資訊
ccusage --verbose

# 指定輸出格式
ccusage --output json

# 過濾特定時間範圍
ccusage --start-date 2025-01-01 --end-date 2025-08-15
```

### 4.2 進階使用

#### 成本分析

```bash
# 按模型分析成本
ccusage --group-by model

# 按專案分析成本
ccusage --group-by project

# 按時間分析成本
ccusage --group-by time --time-unit day
```

#### 自訂報告

```bash
# 生成 HTML 報告
ccusage --output html --output-file report.html

# 生成 CSV 報告
ccusage --output csv --output-file usage.csv

# 生成 JSON 報告
ccusage --output json --output-file data.json
```

### 4.3 配置檔案

#### 建立配置檔案

```yaml
# .ccusage.yml
input:
  files:
    - "./logs/*.jsonl"
    - "./claude-logs/*.jsonl"

  filters:
    start_date: "2025-01-01"
    end_date: "2025-12-31"
    models: ["claude-3-sonnet", "claude-3-opus"]

output:
  format: "html"
  file: "usage-report.html"
  include_charts: true
  include_details: true

analysis:
  group_by: ["model", "project", "time"]
  time_unit: "day"
  cost_currency: "USD"
```

#### 使用配置檔案

```bash
# 使用配置檔案
ccusage --config .ccusage.yml

# 驗證配置檔案
ccusage --validate-config .ccusage.yml
```

---

## 5. 進階功能

### 5.1 資料過濾

#### 時間過濾

```bash
# 過濾特定日期範圍
ccusage --start-date 2025-08-01 --end-date 2025-08-15

# 過濾特定時間
ccusage --start-time "09:00" --end-time "18:00"

# 過濾工作日
ccusage --workdays-only
```

#### 模型過濾

```bash
# 只分析特定模型
ccusage --models claude-3-sonnet,claude-3-opus

# 排除特定模型
ccusage --exclude-models claude-3-haiku

# 按模型複雜度過濾
ccusage --min-model-complexity medium
```

#### 專案過濾

```bash
# 只分析特定專案
ccusage --projects "web-app,api-service"

# 排除特定專案
ccusage --exclude-projects "test-project"

# 按專案大小過濾
ccusage --min-project-size 1000
```

### 5.2 成本分析

#### 成本計算

```bash
# 使用自訂匯率
ccusage --exchange-rate 1.35

# 設定成本上限警告
ccusage --cost-warning 100

# 按成本範圍過濾
ccusage --min-cost 1.0 --max-cost 100.0
```

#### 成本優化建議

```bash
# 生成成本優化建議
ccusage --optimization-suggestions

# 分析成本趨勢
ccusage --cost-trends

# 預測未來成本
ccusage --cost-forecast --forecast-days 30
```

### 5.3 效能分析

#### 使用模式分析

```bash
# 分析使用頻率
ccusage --usage-frequency

# 分析峰值使用時間
ccusage --peak-usage-times

# 分析使用效率
ccusage --usage-efficiency
```

#### 效能指標

```bash
# 計算平均回應時間
ccusage --avg-response-time

# 分析 token 使用效率
ccusage --token-efficiency

# 生成效能報告
ccusage --performance-report
```

---

## 6. 整合與擴展

### 6.1 ClaudeLog 整合

#### 基本整合

```bash
# 從 ClaudeLog 匯入資料
ccusage --claudelog-import

# 同步 ClaudeLog 資料
ccusage --claudelog-sync

# 匯出到 ClaudeLog
ccusage --claudelog-export
```

#### 進階整合

```yaml
# claudelog 配置
claudelog:
  enabled: true
  api_key: "${CLAUDELOG_API_KEY}"
  project_id: "your-project-id"

  sync:
    auto: true
    interval: "1h"
    include_metadata: true
```

### 6.2 API 整合

#### REST API

```bash
# 啟動 API 伺服器
ccusage --api --port 3000

# 查詢使用量資料
curl "http://localhost:3000/api/usage?start_date=2025-08-01&end_date=2025-08-15"

# 上傳 JSONL 檔案
curl -X POST -F "file=@usage.jsonl" "http://localhost:3000/api/upload"
```

#### Webhook 整合

```yaml
# webhook 配置
webhooks:
  - url: "https://your-webhook-url.com/usage-update"
    events: ["usage_update", "cost_warning"]
    headers:
      Authorization: "Bearer ${WEBHOOK_TOKEN}"
```

### 6.3 第三方工具整合

#### CI/CD 整合

```yaml
# GitHub Actions 範例
name: Usage Analysis
on:
  schedule:
    - cron: "0 0 * * *" # 每日執行

jobs:
  analyze-usage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: "18"

      - name: Install ccusage
        run: npm install -g ccusage

      - name: Analyze Usage
        run: ccusage --output html --output-file usage-report.html

      - name: Upload Report
        uses: actions/upload-artifact@v3
        with:
          name: usage-report
          path: usage-report.html
```

#### 監控工具整合

```yaml
# Prometheus 整合
prometheus:
  enabled: true
  port: 9090
  metrics:
    - "claude_usage_total"
    - "claude_cost_total"
    - "claude_tokens_total"
```

### 6.4 狀態列整合（Statusline）

#### 指令

```bash
# 互動顯示
ccusage statusline

# 極簡輸出（適合 shell prompt/tmux）
ccusage statusline --minimal --refresh-interval 5s

# 管線輸出到外部狀態列
ccusage statusline --output plain | your-statusbar
```

#### 建議配置

```yaml
# .ccusage.yml（節錄）
statusline:
  enabled: true
  refresh_interval: "5s"
  theme: auto   # auto | dark | light
  fields: [tokens, cost, model, cache]
```

---

## 7. 疑難排解

### 7.1 常見問題

#### 檔案讀取問題

```bash
# 檢查檔案格式
ccusage --validate-file path/to/file.jsonl

# 檢查檔案權限
ls -la path/to/file.jsonl

# 檢查檔案編碼
file -i path/to/file.jsonl
```

#### 記憶體問題

```bash
# 限制記憶體使用
ccusage --max-memory 512MB

# 使用串流處理
ccusage --stream-mode

# 分批處理大檔案
ccusage --batch-size 1000
```

#### 效能問題

```bash
# 啟用快取
ccusage --enable-cache

# 使用多執行緒
ccusage --threads 4

# 優化資料庫查詢
ccusage --optimize-queries
```

### 7.2 除錯技巧

#### 詳細日誌

```bash
# 啟用詳細日誌
ccusage --verbose --debug

# 記錄到檔案
ccusage --log-file ccusage.log

# 顯示執行時間
ccusage --show-timing
```

#### 效能分析

```bash
# 分析執行時間
ccusage --profile

# 記憶體使用分析
ccusage --memory-profile

# CPU 使用分析
ccusage --cpu-profile
```

---

## 8. 延伸閱讀

### 8.1 官方資源

- [ccusage GitHub 專案](https://github.com/ryoppippi/ccusage)
- [NPM 套件頁面](https://npmjs.com/package/ccusage)
- [ClaudeLog 整合](https://claudelog.com/)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

### 8.2 相關專案

- [Claude Code Usage Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)
- [Claude Code](https://github.com/anthropics/claude-code)
- [ClaudeLog](https://claudelog.com/)

### 8.3 學習資源

- [JSONL 格式說明](https://jsonlines.org/)
- [Claude Code 用量追蹤](https://docs.anthropic.com/en/docs/claude-code/usage)
- [成本優化最佳實踐](https://docs.anthropic.com/en/docs/claude-code/costs)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/ryoppippi/ccusage) 與相關文檔。
>
> **版本資訊**：ccusage v15.10.0 - 極速 Claude Code 用量分析工具  
> **最後更新**：2025-08-19T23:52:25+08:00
