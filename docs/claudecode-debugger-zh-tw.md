# ClaudeCode-Debugger 中文說明書

## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/888wing/ClaudeCode-Debugger)
> - [PyPI 套件頁面](https://pypi.org/project/claudecode-debugger/)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - **文件整理時間：2025-10-27T23:50:00+08:00**
> - **專案版本：v1.5.0**
> - **專案最後更新：2025-07-30**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 新版本特色](#2-新版本特色)
- [3. 核心功能](#3-核心功能)
- [4. 安裝與配置](#4-安裝與配置)
- [5. 使用指南](#5-使用指南)
- [6. 進階功能](#6-進階功能)
- [7. 疑難排解](#7-疑難排解)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 專案簡介

ClaudeCode-Debugger 是一個專為 Claude Code 設計的 AI 驅動除錯助手，能夠將錯誤訊息轉換為可執行的解決方案。憑藉先進的 AI 分析、多語言支援和原生 Claude Code 命令整合，讓 AI 能夠瞬間理解您的錯誤並提供解決方案。

### 1.1 核心特色

- **AI 驅動除錯**：使用先進的 AI 分析技術理解錯誤
- **多語言支援**：支援 10+ 種程式語言
- **原生整合**：與 Claude Code 無縫整合
- **智能分析**：三種智能分析器：堆疊追蹤、模式和程式碼上下文
- **美觀介面**：豐富多彩的終端機 UI 和進度指示器

### 1.2 使用場景

- **快速除錯**：瞬間理解錯誤訊息並獲得解決方案
- **多語言開發**：支援多種程式語言的錯誤分析
- **團隊協作**：與 Claude Code 工作流程無縫整合
- **學習輔助**：理解錯誤原因和最佳實踐

---

## 2. 新版本特色

### 2.1 v1.5.0 主要更新

#### 🌐 擴展語言支援

- **新增語言**：Shell/Bash、Docker、YAML/JSON、Kotlin、Swift、SQL
- **總計支援**：10+ 種程式語言
- **完整覆蓋**：從腳本語言到行動開發語言

#### 🐳 Docker 與容器分析

- **Dockerfile 分析**：全面的 Dockerfile 錯誤檢測
- **Docker Compose**：Docker Compose 錯誤分析
- **容器化除錯**：容器環境中的錯誤診斷

#### 📄 配置檔案支援

- **YAML/JSON 分析**：智能分析 CI/CD 管道和 Kubernetes 配置
- **配置驗證**：自動檢測配置檔案中的錯誤
- **最佳實踐**：提供配置最佳實踐建議

#### 📱 行動開發支援

- **Kotlin 支援**：完整的 Android 開發錯誤分析
- **Swift 支援**：完整的 iOS 開發錯誤分析
- **行動平台**：針對行動開發的特殊優化

#### 🚀 效能提升

- **60% 更快**：完全重寫的引擎提供更好效能
- **模式匹配**：優化的錯誤模式匹配演算法
- **記憶體優化**：減少記憶體使用和提高響應速度

#### 🎯 增強模式識別

- **新增模式**：每種語言 50+ 個新錯誤模式
- **智能識別**：更準確的錯誤模式識別
- **上下文分析**：考慮程式碼上下文的錯誤分析

---

## 3. 核心功能

### 3.1 多語言支援

#### 支援的語言

- **Web 開發**：JavaScript、TypeScript、Python、Ruby
- **系統開發**：Java、Go、C/C++
- **腳本語言**：Shell/Bash、PowerShell
- **配置語言**：YAML、JSON、TOML
- **容器技術**：Docker、Docker Compose
- **行動開發**：Kotlin (Android)、Swift (iOS)
- **資料庫**：SQL、MongoDB 查詢

#### 國際化支援

- **中文介面**：完整的中文使用者介面
- **英文介面**：英文使用者介面
- **多語言錯誤**：支援多語言錯誤訊息分析

### 3.2 智能分析引擎

#### 堆疊追蹤分析器

- **錯誤追蹤**：分析完整的錯誤堆疊追蹤
- **呼叫鏈分析**：追蹤函數呼叫鏈和錯誤傳播
- **上下文重建**：重建錯誤發生時的程式碼上下文

#### 模式分析器

- **錯誤模式**：預配置的常見錯誤模式
- **智能匹配**：使用 ML 技術匹配錯誤模式
- **解決方案建議**：基於模式的解決方案建議

#### 程式碼上下文分析器

- **程式碼理解**：理解程式碼結構和邏輯
- **依賴分析**：分析程式碼依賴關係
- **最佳實踐檢查**：檢查程式碼是否符合最佳實踐

### 3.3 Claude Code 整合

#### 原生斜線命令

```bash
# 使用 /ccdebug 命令進行除錯
/ccdebug "分析這個錯誤並提供解決方案"

# 自動除錯模式
/ccdebug --auto "自動分析最近的錯誤"
```

#### 工作流程整合

- **無縫整合**：與 Claude Code 工作流程完全整合
- **上下文保持**：保持對話上下文和程式碼狀態
- **自動建議**：根據錯誤自動建議相關的 Claude Code 命令

---

## 4. 安裝與配置

### 4.1 安裝方式

#### 使用 pip 安裝

```bash
# 安裝最新版本
pip install claudecode-debugger

# 安裝特定版本
pip install claudecode-debugger==1.5.0

# 升級到最新版本
pip install --upgrade claudecode-debugger
```

#### 從原始碼安裝

```bash
# 克隆專案
git clone https://github.com/888wing/ClaudeCode-Debugger.git
cd ClaudeCode-Debugger

# 安裝依賴
pip install -r requirements.txt

# 安裝專案
pip install -e .
```

### 4.2 配置設定

#### 基本配置

```yaml
# ~/.claude/debugger.yml
debugger:
  enabled: true
  language: "zh-TW" # 中文繁體

  analysis:
    stack_trace: true
    pattern: true
    context: true

  claude_integration:
    enabled: true
    command: "/ccdebug"
    auto_suggest: true
```

#### 語言特定配置

```yaml
# 語言特定設定
languages:
  python:
    patterns: ["ImportError", "SyntaxError", "TypeError"]
    frameworks: ["Django", "Flask", "FastAPI"]

  javascript:
    patterns: ["ReferenceError", "TypeError", "SyntaxError"]
    frameworks: ["React", "Vue", "Node.js"]

  docker:
    patterns: ["build failed", "container error", "image not found"]
    compose: true
```

### 4.3 環境變數

```bash
# 設定 API 金鑰
export CLAUDE_API_KEY="your-api-key-here"

# 設定語言
export DEBUGGER_LANGUAGE="zh-TW"

# 設定日誌等級
export DEBUGGER_LOG_LEVEL="INFO"

# 設定快取目錄
export DEBUGGER_CACHE_DIR="~/.cache/claudecode-debugger"
```

---

## 5. 使用指南

### 5.1 基本使用

#### 命令列使用

```bash
# 分析錯誤訊息
ccdebug "ImportError: No module named 'requests'"

# 分析檔案中的錯誤
ccdebug --file error.log

# 分析剪貼簿內容
ccdebug --clipboard

# 互動模式
ccdebug --interactive
```

#### Claude Code 整合使用

```bash
# 在 Claude Code 中使用
/ccdebug "分析這個 Python 錯誤：ModuleNotFoundError: No module named 'pandas'"

# 自動除錯模式
/ccdebug --auto

# 詳細分析模式
/ccdebug --verbose "分析這個 JavaScript 錯誤"
```

### 5.2 進階使用

#### 多語言錯誤分析

```bash
# Python 錯誤
ccdebug "TypeError: 'NoneType' object is not subscriptable"

# JavaScript 錯誤
ccdebug "Uncaught TypeError: Cannot read property 'length' of undefined"

# Docker 錯誤
ccdebug "Error: failed to create container: invalid reference format"

# SQL 錯誤
ccdebug "ERROR: syntax error at or near \"SELECT\""
```

#### 配置檔案分析

```bash
# YAML 配置分析
ccdebug --yaml docker-compose.yml

# JSON 配置分析
ccdebug --json config.json

# 多檔案分析
ccdebug --files "*.yml" "*.json"
```

### 5.3 輸出格式

#### 終端機輸出

```bash
# 彩色輸出（預設）
ccdebug "錯誤訊息"

# 純文字輸出
ccdebug --no-color "錯誤訊息"

# JSON 輸出
ccdebug --output json "錯誤訊息"

# 詳細輸出
ccdebug --verbose "錯誤訊息"
```

#### 檔案輸出

```bash
# 輸出到檔案
ccdebug --output-file debug-report.txt "錯誤訊息"

# HTML 報告
ccdebug --output html --output-file report.html "錯誤訊息"

# Markdown 報告
ccdebug --output markdown --output-file report.md "錯誤訊息"
```

---

## 6. 進階功能

### 6.1 自訂錯誤模式

#### 建立自訂模式

```yaml
# ~/.claude/debugger/patterns/custom.yml
custom_patterns:
  - name: "Custom Import Error"
    pattern: "ImportError: No module named '(.*)'"
    language: "python"
    solution: "安裝缺少的模組：pip install {1}"
    confidence: 0.9

  - name: "Custom Docker Error"
    pattern: "Error: failed to (.*) container"
    language: "docker"
    solution: "檢查 Docker 服務狀態：docker system info"
    confidence: 0.8
```

#### 模式管理

```bash
# 列出所有模式
ccdebug --list-patterns

# 新增自訂模式
ccdebug --add-pattern custom.yml

# 移除模式
ccdebug --remove-pattern "Custom Import Error"

# 更新模式
ccdebug --update-patterns
```

### 6.2 機器學習功能

#### 智能建議引擎

```yaml
# ML 配置
machine_learning:
  enabled: true
  confidence_threshold: 0.7
  learning_rate: 0.01
  max_iterations: 1000

  features:
    - "error_type"
    - "language"
    - "context"
    - "user_feedback"
```

#### 使用者回饋

```bash
# 提供回饋
ccdebug --feedback "這個解決方案很有用"

# 報告錯誤
ccdebug --report "解決方案不正確"

# 學習模式
ccdebug --learn "新的錯誤模式"
```

### 6.3 整合與 API

#### REST API

```bash
# 啟動 API 伺服器
ccdebug --api --port 8080

# 使用 API
curl -X POST "http://localhost:8080/api/debug" \
     -H "Content-Type: application/json" \
     -d '{"error": "ImportError: No module named requests", "language": "python"}'
```

#### Webhook 整合

```yaml
# webhook 配置
webhooks:
  - url: "https://your-webhook-url.com/debug-update"
    events: ["error_analyzed", "solution_provided"]
    headers:
      Authorization: "Bearer ${WEBHOOK_TOKEN}"
```

---

## 7. 疑難排解

### 7.1 常見問題

#### 安裝問題

```bash
# 檢查 Python 版本
python --version  # 需要 Python 3.8+

# 檢查 pip 版本
pip --version

# 清理快取
pip cache purge

# 強制重新安裝
pip install --force-reinstall claudecode-debugger
```

#### 配置問題

```bash
# 檢查配置檔案
ccdebug --config-check

# 重設配置
ccdebug --reset-config

# 匯出配置
ccdebug --export-config config-backup.yml

# 匯入配置
ccdebug --import-config config-backup.yml
```

#### 效能問題

```bash
# 檢查記憶體使用
ccdebug --memory-check

# 清理快取
ccdebug --clear-cache

# 效能分析
ccdebug --profile

# 除錯模式
ccdebug --debug-mode
```

### 7.2 除錯技巧

#### 詳細日誌

```bash
# 啟用詳細日誌
ccdebug --log-level DEBUG "錯誤訊息"

# 記錄到檔案
ccdebug --log-file debug.log "錯誤訊息"

# 顯示時間戳
ccdebug --show-timestamps "錯誤訊息"
```

#### 測試模式

```bash
# 測試模式
ccdebug --test-mode "錯誤訊息"

# 模擬錯誤
ccdebug --simulate "ImportError: No module named 'test'"

# 驗證模式
ccdebug --validate "錯誤訊息"
```

---

## 8. 延伸閱讀

### 8.1 官方資源

- [ClaudeCode-Debugger GitHub](https://github.com/888wing/ClaudeCode-Debugger)
- [PyPI 套件頁面](https://pypi.org/project/claudecode-debugger/)
- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [官方部落格](https://github.com/888wing/ClaudeCode-Debugger/blog)

### 8.2 相關專案

- [Claude Code](https://github.com/anthropics/claude-code)
- [Claude Code Usage Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

### 8.3 學習資源

- [Python 除錯指南](https://docs.python.org/3/library/pdb.html)
- [JavaScript 除錯技巧](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)
- [Docker 除錯最佳實踐](https://docs.docker.com/develop/dev-best-practices/)
- [錯誤處理模式](https://en.wikipedia.org/wiki/Error_handling)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/888wing/ClaudeCode-Debugger) 與相關文檔。
>
**版本資訊**：ClaudeCode-Debugger v1.5.0 - AI 驅動除錯助手  
> **最後更新**：2025-08-20T00:13:54+08:00
