# ClaudeCode-Debugger 中文說明書

## 概述

ClaudeCode-Debugger 是一個專為 Claude Code 設計的 **AI 驅動除錯助手**，能夠將錯誤訊息轉換為可執行的解決方案。憑藉先進的 AI 分析技術、**10+ 種程式語言支援**和原生 Claude Code 命令整合，ClaudeCode-Debugger 配備 **3 種智能分析器**（堆疊追蹤、模式和程式碼上下文），能夠瞬間理解您的錯誤並提供精準的解決方案。

具備美觀的 Rich UI 終端介面、即時進度指示器和詳細的錯誤分析報告，讓除錯過程既高效又直觀。

> **專案資訊**
>
> - **專案名稱**：ClaudeCode-Debugger
> - **專案版本**：v1.5.0
> - **專案最後更新**：2025-07-30
> - **文件整理時間**：2025-12-24T01:59:00+08:00
>
> **核心定位**
>
> - **功能**：AI 驅動的智能除錯助手，支援 10+ 種語言，配備 3 種分析器和美觀的終端 UI
> - **場景**：快速除錯、多語言開發、團隊協作、學習輔助、錯誤分析
> - **客群**：全棧開發者、多語言開發者、團隊協作者、程式學習者
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/888wing/ClaudeCode-Debugger)
> - [PyPI 套件頁面](https://pypi.org/project/claudecode-debugger/)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)

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

### 2.1 v1.5.0 主要更新（2025-01-29）

#### 🌐 擴展語言支援

- **新增語言**：Shell/Bash、Docker、YAML/JSON、Kotlin、Swift、SQL
- **總計支援**：10+ 種程式語言和配置格式
- **完整覆蓋**：從腳本語言到行動開發語言、容器技術和配置檔案

**詳細語言支援**：

- **Shell/Bash**：腳本錯誤、命令未找到、語法問題、權限和路徑相關錯誤、陣列和變數展開問題
- **Docker**：Dockerfile 語法錯誤、構建錯誤、運行時錯誤、Docker Compose 配置問題、映像構建失敗
- **YAML/JSON**：YAML 語法和縮排問題、JSON 解析錯誤、Kubernetes 清單驗證、CI/CD 管道配置（GitHub Actions、GitLab CI、CircleCI）
- **Kotlin**：空安全違規、類型推斷問題、協程錯誤、Android 特定模式
- **Swift**：可選處理、協議一致性、記憶體管理、SwiftUI 錯誤
- **SQL**：語法錯誤、JOIN 問題、效能提示、Schema 違規

#### 🐳 Docker 與容器分析

- **Dockerfile 分析**：全面的 Dockerfile 錯誤檢測和最佳實踐建議
- **Docker Compose**：Docker Compose 錯誤分析和配置驗證
- **容器化除錯**：容器環境中的錯誤診斷和運行時問題檢測
- **映像構建**：構建失敗分析和可執行的解決方案

#### 📄 配置檔案支援

- **YAML/JSON 分析**：智能分析 CI/CD 管道和 Kubernetes 配置
- **配置驗證**：自動檢測配置檔案中的錯誤和類型驗證
- **最佳實踐**：提供配置最佳實踐建議和語法修正
- **CI/CD 整合**：支援 GitHub Actions、GitLab CI、CircleCI 等

#### 📱 行動開發支援

- **Kotlin 支援**：完整的 Android 開發錯誤分析，包括空安全、協程、Android 特定模式
- **Swift 支援**：完整的 iOS 開發錯誤分析，包括可選處理、協議、SwiftUI
- **行動平台**：針對行動開發的特殊優化和平台特定錯誤模式

#### 🚀 效能提升

- **60% 更快**：完全重寫的模式匹配引擎，提供更好的效能
- **模式匹配優化**：優化的錯誤模式匹配演算法，95%+ 模式識別率
- **記憶體優化**：減少記憶體使用和提高響應速度，優化大型錯誤日誌處理
- **多行錯誤支援**：更好的複雜錯誤訊息處理

#### 🎯 增強模式識別

- **500+ 錯誤模式**：總計 500+ 個錯誤模式，每種語言 50+ 個新錯誤模式
- **智能識別**：更準確的錯誤模式識別和分類
- **上下文分析**：考慮程式碼上下文的錯誤分析，改進檔案路徑和行號追蹤
- **信心評分**：新的演算法提供更準確的建議可靠性指標
- **跨語言專案**：改進對混合語言程式碼庫的支援

---

## 3. 核心功能

### 3.1 多語言支援（v1.5.0 擴展）

#### 支援的語言（10+ 種）

**Web 開發**：

- JavaScript、TypeScript、Python、Ruby

**系統開發**：

- Java、Go、C/C++

**腳本語言**（v1.5.0 新增）：

- Shell/Bash：腳本錯誤、語法問題、命令未找到
- PowerShell：Windows 腳本錯誤

**配置語言**（v1.5.0 新增）：

- YAML：CI/CD 管道、Kubernetes 清單、配置檔案
- JSON：配置檔案、API 回應
- TOML：專案配置

**容器技術**（v1.5.0 新增）：

- Docker：Dockerfile 語法、構建錯誤、運行時錯誤
- Docker Compose：配置驗證、服務錯誤

**行動開發**（v1.5.0 新增）：

- Kotlin (Android)：空安全、協程、Android 特定模式
- Swift (iOS)：可選處理、協議一致性、SwiftUI

**資料庫**（v1.5.0 新增）：

- SQL：查詢語法、JOIN 問題、效能提示
- MongoDB 查詢：查詢語法錯誤

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

### 3.3 Claude Code 整合（v1.1.0+）

#### 原生斜線命令 `/ccdebug`

**基本使用**：

```bash
# 分析最後一個錯誤
/ccdebug --last

# 分析特定錯誤訊息
/ccdebug "分析這個錯誤並提供解決方案"

# 中文介面
/ccdebug --last --zh

# 深度分析模式
/ccdebug --last --zh --deep
```

**分析模式**：

```bash
# 快速分析（基本模式匹配）
/ccdebug --quick "錯誤訊息"

# 深度分析（堆疊追蹤 + 模式 + 建議）
/ccdebug --deep "錯誤訊息"

# 完整分析（包含程式碼上下文）
/ccdebug --full "錯誤訊息"
```

**輸入來源**：

```bash
# 分析最後一個命令錯誤
/ccdebug --last

# 從剪貼簿讀取
/ccdebug --clipboard

# 從檔案讀取
/ccdebug --file error.log

# 分析選取的文字
/ccdebug --selection
```

**命令別名**：

- `/ccdb` - `/ccdebug` 的簡短別名
- `/cczh` - `/ccdebug --zh --deep` 的別名
- `/ccen` - `/ccdebug --en --deep` 的別名
- `/ccquick` - `/ccdebug --quick` 的別名
- `/ccfull` - `/ccdebug --full` 的別名

#### 自動錯誤檢測

當您在 Claude Code 中執行產生錯誤的命令時，CCDebugger 會自動：

- **即時檢測**：自動檢測錯誤模式
- **提取上下文**：提取錯誤上下文和堆疊追蹤
- **生成建議**：生成 AI 驅動的除錯建議
- **即時解決方案**：提供中文或英文的即時解決方案

#### 工作流程整合

- **無縫整合**：與 Claude Code 工作流程完全整合
- **上下文保持**：保持對話上下文和程式碼狀態
- **自動建議**：根據錯誤自動建議相關的 Claude Code 命令
- **歷史追蹤**：自動錯誤歷史追蹤（JSON 儲存）
- **監控模式**：持續錯誤檢測的監控模式

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

# 設定 Claude Code 整合（重要！）
python setup_claude_code.py
```

#### Claude Code 整合設定

安裝後，需要設定 Claude Code 整合：

```bash
# 執行整合腳本
python setup_claude_code.py

# 或使用安裝腳本
./install_claude_integration.sh
```

這會自動：

- 建立 `/ccdebug` 斜線命令
- 設定配置檔案
- 安裝必要的模板
- 配置自動錯誤檢測

### 4.2 配置設定

#### 基本配置

```json
# ~/.ccdebugrc
{
  "defaultLanguage": "zh",
  "defaultMode": "deep",
  "autoSuggest": true,
  "copyToClipboard": true,
  "contextLines": 10,
  "favoriteFrameworks": ["django", "react", "vue"],
  "customPatterns": {
    "myapp": {
      "errorPattern": "MyAppError:",
      "suggestion": "Check MyApp configuration"
    }
  }
}
```

#### Claude Code 整合配置

```json
# ~/.claude/ccdebug.json
{
  "ccdebug": {
    "defaultLanguage": "zh",
    "defaultMode": "deep",
    "autoSuggest": true,
    "copyToClipboard": true,
    "contextLines": 10,
    "autoAnalyze": {
      "testFailures": true,
      "buildErrors": true,
      "runtimeErrors": true
    }
  }
}
```

#### 專案配置

```json
# .ccdebugrc（專案根目錄）
{
  "language": "zh",
  "severity": "medium",
  "exclude": ["node_modules", ".git"],
  "autoAnalyze": {
    "testFailures": true,
    "buildErrors": true,
    "runtimeErrors": true
  }
}
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

  bash:
    patterns: ["command not found", "syntax error", "permission denied"]
    shell: "bash"

  kotlin:
    patterns: ["NullPointerException", "Type mismatch", "Unresolved reference"]
    android: true

  swift:
    patterns:
      [
        "Value of optional type",
        "Cannot convert value",
        "Use of unresolved identifier",
      ]
    ios: true
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
# 分析錯誤訊息（中文介面）
ccdebug "ImportError: No module named 'requests'" --lang zh

# 分析檔案中的錯誤
ccdebug --file error.log

# 分析剪貼簿內容
ccdebug --clipboard

# 互動模式
ccdebug --interactive

# 快速中文分析
cczh "錯誤信息"

# 完整中文分析
ccfull
```

#### Claude Code 整合使用

```bash
# 分析最後一個錯誤（中文）
/ccdebug --last --zh

# 分析最後一個錯誤（深度分析）
/ccdebug --last --zh --deep

# 分析特定錯誤
/ccdebug "分析這個 Python 錯誤：ModuleNotFoundError: No module named 'pandas'"

# 快速分析模式
/ccdebug --quick "錯誤訊息"

# 完整分析模式（包含程式碼上下文）
/ccdebug --full "錯誤訊息"

# 從剪貼簿分析
/ccdebug --clipboard --zh

# 從檔案分析
/ccdebug --file error.log --zh
```

#### 語言特定命令

```bash
# 中文介面快速命令
cczh "錯誤信息"  # 快速中文分析
ccfull           # 完整中文分析

# 英文介面快速命令
ccen "error message"  # 快速英文分析
ccdebug --lang en     # 明確指定英文
```

### 5.2 進階使用

#### 多語言錯誤分析（v1.5.0 擴展）

**Web 開發語言**：

```bash
# Python 錯誤
ccdebug "TypeError: 'NoneType' object is not subscriptable"

# JavaScript 錯誤
ccdebug "Uncaught TypeError: Cannot read property 'length' of undefined"

# TypeScript 錯誤
ccdebug "Type 'string' is not assignable to type 'number'"
```

**Shell/Bash 錯誤**（v1.5.0 新增）：

```bash
# 語法錯誤
ccdebug "./deploy.sh: line 42: syntax error near unexpected token 'fi'"

# 命令未找到
ccdebug "command not found: docker-compose"

# 權限錯誤
ccdebug "Permission denied: ./script.sh"
```

**Docker 錯誤**（v1.5.0 新增）：

```bash
# Dockerfile 構建錯誤
ccdebug "Service 'web' failed to build: COPY failed: no source files"

# Docker 運行時錯誤
ccdebug "Error: failed to create container: invalid reference format"

# Docker Compose 錯誤
ccdebug "docker-compose.yml: invalid service definition"
```

**YAML/JSON 配置錯誤**（v1.5.0 新增）：

```bash
# Kubernetes YAML 錯誤
ccdebug "error validating data: ValidationError(Deployment.spec.replicas): invalid type"

# CI/CD 配置錯誤
ccdebug "GitHub Actions workflow syntax error: unexpected 'on'"

# JSON 解析錯誤
ccdebug "JSON parse error: Expecting ',' delimiter: line 5 column 3"
```

**行動開發錯誤**（v1.5.0 新增）：

```bash
# Kotlin 錯誤
ccdebug "Only safe (?.) or non-null asserted (!!.) calls are allowed on a nullable receiver"

# Swift 錯誤
ccdebug "Value of optional type 'String?' must be unwrapped"
```

**SQL 錯誤**（v1.5.0 新增）：

```bash
# SQL 語法錯誤
ccdebug "ERROR: syntax error at or near \"SELECT\""

# JOIN 錯誤
ccdebug "ERROR: column reference is ambiguous"
```

#### 配置檔案分析（v1.5.0 新增）

```bash
# YAML 配置分析
ccdebug --yaml docker-compose.yml

# JSON 配置分析
ccdebug --json config.json

# Kubernetes 清單驗證
ccdebug --k8s deployment.yaml

# CI/CD 管道分析
ccdebug --ci .github/workflows/ci.yml

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
    category: "import"
    severity: "medium"

  - name: "Custom Docker Error"
    pattern: "Error: failed to (.*) container"
    language: "docker"
    solution: "檢查 Docker 服務狀態：docker system info"
    confidence: 0.8
    category: "runtime"
    severity: "high"

  - name: "Custom Shell Error"
    pattern: "bash: (.*): command not found"
    language: "bash"
    solution: "安裝缺少的命令：{1}"
    confidence: 0.95
    category: "command"
    severity: "medium"
```

#### 模式管理

```bash
# 列出所有模式
ccdebug --list-patterns

# 列出特定語言的模式
ccdebug --list-patterns --language python

# 新增自訂模式
ccdebug --add-pattern custom.yml

# 移除模式
ccdebug --remove-pattern "Custom Import Error"

# 更新模式
ccdebug --update-patterns

# 驗證模式語法
ccdebug --validate-patterns
```

#### 模式統計（v1.5.0 新增）

```bash
# 查看模式統計
ccdebug --pattern-stats

# 查看特定語言的模式數量
ccdebug --pattern-stats --language docker
```

### 6.2 機器學習功能（ML-Ready）

#### 智能建議引擎

```python
# Python API 使用
from claudecode_debugger.suggestions import SuggestionEngine

engine = SuggestionEngine()
suggestions = engine.generate_suggestions(
    error_type="AttributeError",
    error_patterns=["null_reference"],
    stack_trace_info=stack_info
)
# 返回：帶有信心評分的排序建議
```

#### ML 配置

```yaml
# ~/.ccdebugrc
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
    - "error_severity"
    - "code_context"
```

#### 信心評分（v1.5.0 改進）

v1.5.0 引入了新的信心評分演算法：

- **更準確的可靠性指標**：95%+ 模式識別率
- **更好的建議優先級**：根據信心評分排序建議
- **上下文感知評分**：考慮程式碼上下文的評分

#### 使用者回饋

```bash
# 提供回饋
ccdebug --feedback "這個解決方案很有用"

# 報告錯誤
ccdebug --report "解決方案不正確"

# 學習模式
ccdebug --learn "新的錯誤模式"

# 查看學習歷史
ccdebug --learning-history
```

### 6.3 Claude Code 整合功能

#### 批次處理

```bash
# 分析目錄中的所有錯誤日誌
/ccdebug --batch --dir logs/

# 監控檔案並分析新錯誤
/ccdebug --watch server.log

# 分析測試失敗
/ccdebug --test-mode --batch
```

#### 整合模式

```bash
# Git 提交 Hook 模式
/ccdebug --git-hook

# CI/CD 整合模式
/ccdebug --ci-mode --save report.md

# 測試失敗分析模式
/ccdebug --test-mode
```

#### 過濾功能

```bash
# 僅分析 Python 錯誤
/ccdebug --type python

# 僅高嚴重性錯誤
/ccdebug --severity high

# 最近一小時的錯誤
/ccdebug --recent 1h
```

#### 輸出選項

```bash
# 複製結果到剪貼簿
/ccdebug --copy

# 儲存到檔案
/ccdebug --save report.md

# 生成可分享連結
/ccdebug --share
```

### 6.4 整合與 API

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
> **版本資訊**：ClaudeCode-Debugger v1.5.0 - AI 驅動除錯助手（擴展語言支援）  
> **最後更新**：2025-11-25T02:35:00+08:00  
> **專案更新**：2025-07-30T05:06:57+01:00  
> **主要變更**：v1.5.0 新增 Shell/Bash、Docker、YAML/JSON、Kotlin、Swift、SQL 支援，500+ 錯誤模式，60% 效能提升，增強的 Claude Code 整合（/ccdebug 命令），改進的信心評分演算法
