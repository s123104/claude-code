# ccusage 中文說明書

## 概述

ccusage 是一個專為 Claude Code 設計的**用量分析工具**，能夠從本地 JSONL 檔案快速分析您的 Claude Code token 使用量和成本。已發展成完整的 **ccusage Family 生態系統**，包含 `ccusage`（Claude Code 分析器）、`@ccusage/codex`（OpenAI Codex 分析器）和 `@ccusage/mcp`（MCP 伺服器）。

憑藉極小的 bundle 尺寸（高效打包）、美觀的表格輸出和豐富的功能集（日報、月報、會話追蹤、即時監控），ccusage 為開發者提供了深入了解 AI 開發成本的強大工具。

> **專案資訊**
>
> - **專案名稱**：ccusage
> - **專案版本**：v17.1.6
> - **專案最後更新**：2025-11-20
> - **文件整理時間**：2025-11-24T05:30:00+08:00
>
> **核心定位**
>
> - **功能**：Claude Code 用量分析工具，支援 GPT-5 Codex，提供日報、月報、會話追蹤、即時監控功能
> - **場景**：成本監控、用量分析、預算管理、會話追蹤、團隊管理
> - **客群**：專業開發者、團隊領導、財務管理、個人開發者
>
> **資料來源**
>
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

### 2.4 最新版本亮點（v17.1.6）

- **即時監控**：`blocks --live` 提供即時儀表板，顯示活躍會話進度、token 消耗率和成本預測
- **5 小時區塊報告**：`blocks` 命令追蹤 Claude 計費視窗內的使用情況
- **狀態列整合**：`statusline` 命令提供緊湊的使用量顯示（Beta）
- **多實例支援**：`--instances` 標誌按專案分組使用情況，`--project` 過濾特定專案
- **時區和本地化**：`--timezone` 和 `--locale` 選項支援自訂日期/時間格式
- **緊湊模式**：`--compact` 標誌強制緊湊表格佈局，適合截圖和分享
- **模型細分**：`--breakdown` 標誌顯示每個模型的成本細分
- **配置檔案**：JSON 配置檔案支援，包含 IDE 自動完成和驗證
- **離線模式**：`--offline` 標誌使用預快取的定價資料（僅限 Claude 模型）
- **串流處理**：使用串流處理大型 JSONL 檔案，提升效能
- **JSON 輸出**：`--json` 標誌匯出結構化 JSON 格式資料

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

#### 基本命令

```bash
# 顯示每日報告（預設）
npx ccusage@latest

# 每日 token 使用量和成本
npx ccusage@latest daily

# 每月彙總報告
npx ccusage@latest monthly

# 按會話分組的使用情況
npx ccusage@latest session

# 5 小時計費區塊報告
npx ccusage@latest blocks

# 緊湊狀態列（Beta）
npx ccusage@latest statusline
```

#### 即時監控

```bash
# 即時使用儀表板
npx ccusage@latest blocks --live

# 顯示活躍區塊和預測
npx ccusage@latest blocks --active

# 顯示最近 3 天的區塊（包含活躍）
npx ccusage@latest blocks --recent
```

#### 過濾和選項

```bash
# 日期範圍過濾
npx ccusage@latest daily --since 20250525 --until 20250530

# JSON 輸出
npx ccusage@latest daily --json

# 每個模型的成本細分
npx ccusage@latest daily --breakdown

# 時區設定
npx ccusage@latest daily --timezone UTC

# 本地化設定（日期/時間格式）
npx ccusage@latest daily --locale ja-JP

# 按專案分組
npx ccusage@latest daily --instances

# 過濾特定專案
npx ccusage@latest daily --project myproject

# 組合使用
npx ccusage@latest daily --instances --project myproject --json

# 緊湊模式（適合截圖/分享）
npx ccusage@latest --compact
npx ccusage@latest monthly --compact

# 離線模式（使用預快取定價）
npx ccusage@latest daily --offline
```

### 4.2 進階使用

#### 5 小時區塊分析

```bash
# 顯示所有區塊
npx ccusage@latest blocks

# 顯示活躍區塊和預測
npx ccusage@latest blocks --active

# 即時監控儀表板
npx ccusage@latest blocks --live

# 設定 token 限制警告
npx ccusage@latest blocks --token-limit 1000000
npx ccusage@latest blocks --token-limit max

# JSON 輸出
npx ccusage@latest blocks --json
```

#### 專案分析

```bash
# 按專案/實例分組
npx ccusage@latest daily --instances

# 過濾特定專案
npx ccusage@latest daily --project myproject

# 組合：按專案分組並過濾
npx ccusage@latest daily --instances --project myproject --json
```

#### 成本分析

```bash
# 每個模型的成本細分
npx ccusage@latest daily --breakdown

# 每月成本細分
npx ccusage@latest monthly --breakdown

# 會話成本細分
npx ccusage@latest session --breakdown
```

#### 時區和本地化

```bash
# 使用 UTC 時區
npx ccusage@latest daily --timezone UTC

# 使用特定時區
npx ccusage@latest daily --timezone Asia/Taipei

# 使用日語本地化
npx ccusage@latest daily --locale ja-JP

# 使用德語本地化
npx ccusage@latest daily --locale de-DE

# 使用美式英語本地化
npx ccusage@latest daily --locale en-US
```

### 4.3 配置檔案

ccusage 支援 JSON 配置檔案，提供 IDE 自動完成和驗證。配置檔案位置：

- `~/.config/ccusage/config.json`（使用者配置）
- `./ccusage.json`（專案配置）

#### 配置檔案範例

```json
{
  "defaultCommand": "daily",
  "timezone": "Asia/Taipei",
  "locale": "zh-TW",
  "compact": false,
  "json": false,
  "breakdown": false,
  "instances": false,
  "project": null,
  "offline": false
}
```

#### 配置檔案功能

- **IDE 自動完成**：使用 `config-schema.json` 提供完整的設定 Schema
- **自動驗證**：配置檔案會自動驗證格式和值
- **預設值**：設定常用選項的預設值，減少命令長度
- **專案特定配置**：每個專案可以有獨立的配置檔案

#### 使用配置檔案

配置檔案會自動載入，無需額外命令。如果同時存在使用者配置和專案配置，專案配置會覆蓋使用者配置。

---

## 5. 進階功能

### 5.1 資料過濾

#### 時間過濾

```bash
# 過濾特定日期範圍（使用 YYYYMMDD 格式）
npx ccusage@latest daily --since 20250525 --until 20250530

# 使用 ISO 格式
npx ccusage@latest daily --since 2025-05-25 --until 2025-05-30
```

#### 專案過濾

```bash
# 過濾特定專案
npx ccusage@latest daily --project myproject

# 按專案分組（顯示所有專案）
npx ccusage@latest daily --instances

# 組合：按專案分組並過濾
npx ccusage@latest daily --instances --project myproject
```

#### 輸出格式過濾

```bash
# JSON 輸出
npx ccusage@latest daily --json

# 緊湊模式（適合窄終端或截圖）
npx ccusage@latest daily --compact

# 模型細分
npx ccusage@latest daily --breakdown
```

### 5.2 成本分析

#### 成本計算模式

```bash
# 自動模式（預設，根據資料可用性自動選擇）
npx ccusage@latest daily --mode auto

# 強制計算成本（即使資料不完整）
npx ccusage@latest daily --mode calculate

# 僅顯示成本（不計算）
npx ccusage@latest daily --mode display
```

#### 成本細分

```bash
# 每個模型的成本細分
npx ccusage@latest daily --breakdown

# 每月成本細分
npx ccusage@latest monthly --breakdown

# 會話成本細分
npx ccusage@latest session --breakdown
```

#### 即時成本監控

```bash
# 即時儀表板顯示成本預測
npx ccusage@latest blocks --live

# 顯示活躍區塊的成本預測
npx ccusage@latest blocks --active
```

#### Token 限制警告

```bash
# 設定 token 限制警告
npx ccusage@latest blocks --token-limit 1000000

# 使用最大 token 限制
npx ccusage@latest blocks --token-limit max
```

### 5.3 即時監控

#### 即時儀表板

```bash
# 啟動即時監控儀表板
npx ccusage@latest blocks --live

# 顯示活躍區塊和預測
npx ccusage@latest blocks --active

# 顯示最近 3 天的區塊
npx ccusage@latest blocks --recent
```

#### 即時監控功能

- **活躍會話進度**：顯示當前活躍會話的進度
- **Token 消耗率**：即時顯示 token 消耗速度
- **成本預測**：根據當前使用模式預測成本
- **區塊狀態**：顯示當前計費區塊的狀態

#### 串流處理

ccusage 使用串流處理大型 JSONL 檔案，確保：

- **低記憶體使用**：即使處理數 GB 的日誌檔案
- **快速啟動**：無需等待完整檔案載入
- **即時更新**：在處理過程中即時顯示進度

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

`statusline` 命令提供緊湊的使用量顯示，適合整合到 Claude Code 狀態列 hooks。

#### 基本使用

```bash
# 顯示狀態列
npx ccusage@latest statusline

# JSON 輸出（適合腳本處理）
npx ccusage@latest statusline --json
```

#### 整合到 Claude Code Hooks

在您的 Claude Code hooks 配置中使用：

```bash
# 在狀態列中顯示使用量
ccusage statusline
```

#### 狀態列顯示內容

- Token 使用量（輸入/輸出）
- 成本資訊
- 使用的模型
- Cache 統計
- 會話資訊

#### 注意事項

- **Beta 功能**：statusline 目前處於 Beta 階段，功能可能會變更
- **效能**：設計為輕量級，適合頻繁更新
- **格式**：輸出格式針對終端顯示優化

---

## 7. 疑難排解

### 7.1 常見問題

#### 檔案讀取問題

ccusage 會自動從 Claude Code 的預設位置讀取 JSONL 檔案：

- `~/.claude/projects/*/transcripts/*.jsonl`

如果需要自訂路徑，請設定環境變數或使用配置檔案。

#### 大型檔案處理

ccusage 使用串流處理，可以處理數 GB 的 JSONL 檔案：

```bash
# 串流處理會自動啟用，無需額外配置
npx ccusage@latest daily

# 如果遇到記憶體問題，嘗試使用離線模式
npx ccusage@latest daily --offline
```

#### 離線模式

```bash
# 使用預快取的定價資料（僅限 Claude 模型）
npx ccusage@latest daily --offline

# 離線模式適用場景：
# - 無網路連線
# - 需要快速執行
# - 定價資料已快取
```

#### bunx 用戶注意事項

如果使用 `bunx` 執行 `@ccusage/codex`，**必須包含 `@latest`**：

```bash
# ✅ 正確
bunx @ccusage/codex@latest

# ❌ 錯誤（可能執行錯誤的 codex 命令）
bunx @ccusage/codex
```

這是因為 Bun 1.2.x 的 bunx 會優先查找 PATH 中匹配的 `codex` 二進位檔。

### 7.2 除錯技巧

#### JSON 輸出除錯

```bash
# 使用 JSON 輸出查看原始資料
npx ccusage@latest daily --json

# 將輸出儲存到檔案
npx ccusage@latest daily --json > usage.json

# 使用 jq 處理 JSON 輸出
npx ccusage@latest daily --json | jq '.summary'
```

#### 配置檔案除錯

```bash
# 檢查配置檔案是否正確載入
# 配置檔案位置：
# - ~/.config/ccusage/config.json（使用者配置）
# - ./ccusage.json（專案配置）

# 使用預設配置（忽略配置檔案）
# 目前需要手動移除配置檔案來測試預設行為
```

#### 效能優化

```bash
# 使用離線模式提升速度
npx ccusage@latest daily --offline

# 使用緊湊模式減少輸出處理時間
npx ccusage@latest daily --compact

# 限制日期範圍減少處理資料量
npx ccusage@latest daily --since 20250525 --until 20250530
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

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/ryoppippi/ccusage) 與 [官方文檔](https://ccusage.com/)。
>
> **版本資訊**：ccusage v17.1.6 - 極速 Claude Code 用量分析工具（含 ccusage Family 生態系統）  
> **最後更新**：2025-11-24T05:30:00+08:00  
> **主要變更**：即時監控（blocks --live）、5 小時區塊報告、狀態列整合、多實例支援、時區和本地化、緊湊模式、串流處理優化
