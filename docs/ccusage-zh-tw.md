# ccusage 中文說明書

## 概述

ccusage 是一個專為 Claude Code 設計的**用量分析工具**，能夠從本地 JSONL 檔案快速分析您的 Claude Code token 使用量和成本。已發展成完整的 **ccusage Family 生態系統**，包含 `ccusage`（Claude Code 分析器）、`@ccusage/codex`（OpenAI Codex 分析器）和 `@ccusage/mcp`（MCP 伺服器）。

憑藉極小的 bundle 尺寸（高效打包）、美觀的表格輸出和豐富的功能集（日報、月報、會話追蹤、即時監控），ccusage 為開發者提供了深入了解 AI 開發成本的強大工具。

> **專案資訊**
>
> - **專案名稱**：ccusage
> - **專案版本**：v17.1.3
> - **專案最後更新**：2025-10-27
> - **文件整理時間**：2025-10-28T19:00:00+08:00
>
> **核心定位**
> - **功能**：Claude Code 用量分析工具，支援 GPT-5 Codex，提供日報、月報、會話追蹤、即時監控功能
> - **場景**：成本監控、用量分析、預算管理、會話追蹤、團隊管理
> - **客群**：專業開發者、團隊領導、財務管理、個人開發者
>
> **資料來源**
> - [GitHub 專案](https://github.com/ryoppippi/ccusage)
> - [NPM 套件頁面](https://npmjs.com/package/ccusage)
> - [官方文檔](https://ccusage.com/)
> - [ClaudeLog 整合](https://claudelog.com/)

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

### 1.1 ccusage Family 生態系統

ccusage 已發展成為完整的使用分析生態系統：

#### 📊 ccusage - Claude Code 使用分析器
- **主要 CLI 工具**：分析 Claude Code 使用量從本地 JSONL 檔案
- **功能特色**：日報、月報、會話追蹤、即時監控
- **特點**：極小 bundle 尺寸、美觀的表格輸出

#### 🤖 @ccusage/codex - OpenAI Codex 使用分析器
- **Codex 專用工具**：為 OpenAI Codex 用戶量身打造
- **模型支援**：GPT-5、1M token 上下文視窗
- **功能**：與 ccusage 相同的強大功能集

#### 🔌 @ccusage/mcp - MCP Server 整合
- **Model Context Protocol 伺服器**：將 ccusage 資料暴露給其他工具
- **整合目標**：Claude Desktop、其他 MCP 相容工具
- **功能**：即時使用追蹤、AI 工作流整合

### 1.2 核心特色

- **極速分析**：憑藉極小的套件大小，提供快速的用量分析
- **成本追蹤**：詳細追蹤 token 使用量和相關成本
- **本地處理**：從本地 JSONL 檔案讀取資料，保護隱私
- **豐富報告**：提供詳細的使用量統計和成本分析
- **多平台支援**：支援 Windows、macOS 和 Linux
- **生態系統整合**：完整的 ccusage family 工具鏈

### 1.3 使用場景

- **成本監控**：追蹤 Claude Code 開發成本
- **用量分析**：分析不同專案和功能的 token 使用情況
- **預算規劃**：根據使用模式規劃 AI 開發預算
- **效能優化**：識別高成本的開發模式並進行優化
- **團隊管理**：監控團隊整體的 AI 工具使用情況
- **Codex 分析**：使用 @ccusage/codex 分析 OpenAI Codex 使用
- **工具整合**：透過 @ccusage/mcp 整合到 AI 工作流

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

# 使用 npx（建議使用 @latest 確保最新版本）
npx ccusage@latest

# 使用 pnpm
pnpm dlx ccusage

# 使用 pnpx
pnpx ccusage

# 使用 deno（含安全旗標）
deno run -E -R=$HOME/.claude/projects/ -S=homedir -N='raw.githubusercontent.com:443' npm:ccusage@latest
```

> 💡 **重要提示**: 強烈建議在使用 npx 時加上 `@latest` 後綴（例如 `npx ccusage@latest`），以確保運行最新版本的功能和錯誤修復。

### 3.1.1 相關工具快速開始

#### Codex CLI

使用我們的配套工具 [@ccusage/codex](https://www.npmjs.com/package/@ccusage/codex) 分析 OpenAI Codex 使用量：

```bash
# 使用 npx（建議使用 @latest）
npx @ccusage/codex@latest

# 使用 bunx（⚠️ 必須包含 @latest）
bunx @ccusage/codex@latest

# 使用 pnpm
pnpm dlx @ccusage/codex

# 使用 deno
deno run -E -R=$HOME/.codex/ -S=homedir -N='raw.githubusercontent.com:443' npm:@ccusage/codex@latest
```

> ⚠️ **bunx 用戶注意**: Bun 1.2.x 的 bunx 在給定作用域套件時會優先查找 PATH 中匹配後綴的二進位檔。對於 `@ccusage/codex`，它會先尋找 `codex` 指令。如果您已安裝其他 `codex` 指令（如 GitHub Copilot 的 codex），該指令會被執行。**務必使用 `bunx @ccusage/codex@latest` 帶版本標籤**來強制 bunx 取得並執行正確的套件。

#### MCP Server

使用 [@ccusage/mcp](https://www.npmjs.com/package/@ccusage/mcp) 將 ccusage 整合到 Claude Desktop：

```bash
# 啟動 MCP server 進行 Claude Desktop 整合
npx @ccusage/mcp@latest --type http --port 8080
```

這可以在 Claude Desktop 對話中啟用即時使用追蹤和分析。

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

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/ryoppippi/ccusage) 與 [官方文檔](https://ccusage.com/)。
>
> **版本資訊**：ccusage v17.1.3 - 極速 Claude Code 用量分析工具（含 ccusage Family 生態系統）  
> **最後更新**：2025-10-28T00:10:00+08:00
