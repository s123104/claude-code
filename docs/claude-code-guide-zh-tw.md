# Claude Code Guide 中文全解（繁體中文版）

## 概述

Claude Code Guide 是一份社群驅動的完整 Claude Code 使用指南，涵蓋從**基礎安裝**到**進階功能**的全方位內容。本指南整合官方文檔與社群最佳實踐，提供 **CLI 指令參考**、**Subagents 多代理協作**、**Agent Skills 技能系統**、**MCP 協議整合**、**Hooks 自動化**等完整說明。

適合所有層級的 Claude Code 使用者，從新手入門到專家優化，都能在本指南中找到所需的資訊和實用範例。

> **專案資訊**
>
> - **專案名稱**：Claude Code Guide
> - **專案版本**：v1.5
> - **專案最後更新**：2025-08-10
> - **文件整理時間**：2025-10-28T19:00:00+08:00
> - **Claude Code 版本**：v2.0+ (支援 Subagents + Agent Skills)
>
> **核心定位**
> - **功能**：完整的 Claude Code 社群指南，涵蓋 CLI、Subagents、Agent Skills、MCP、Hooks 等全部功能
> - **場景**：學習入門、功能探索、最佳實踐、疑難排解、進階優化
> - **客群**：Claude Code 新手、專業開發者、團隊領導、技術探索者
>
> **資料來源**
> - [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide) 社群指南
> - [Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [Claude Code CLI 參考](https://docs.anthropic.com/en/docs/claude-code/cli-reference)
> - [Subagents 官方文檔](https://docs.anthropic.com/en/docs/claude-code/subagents)
> - [Agent Skills 官方文檔](https://docs.claude.com/en/docs/claude-code/skills)
> - [MCP 協議官方規範](https://docs.anthropic.com/en/docs/claude-code/mcp)
> - [Hooks 系統文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)

---

## 目錄

1. [產品概覽](#1-產品概覽)
2. [安裝與系統需求](#2-安裝與系統需求)
3. [快速入門](#3-快速入門)
4. [核心指令與參數](#4-核心指令與參數)
5. [Session/Config/MCP 指令](#5-sessionconfigmcp-指令)
6. [CLAUDE.md 與記憶體管理](#6-claudemd-與記憶體管理)
7. [自動化與腳本整合](#7-自動化與腳本整合)
8. [進階功能與最佳實踐](#8-進階功能與最佳實踐)
9. [疑難排解與常見問題](#9-疑難排解與常見問題)
10. [社群資源與延伸閱讀](#10-社群資源與延伸閱讀)

---

## 1. 產品概覽

Claude Code 是 Anthropic 推出的 AI 編程助手，支援自然語言指令、程式碼自動修復、MCP 多代理協作、專案記憶體管理等功能，適用於 VSCode、Cursor、終端機與多種開發環境。

### 1.1 最新版本特色

- **Claude Code v1.0.72**：最新穩定版本
- **完整命令參考**：涵蓋所有可發現的 Claude Code 命令
- **進階功能文檔**：包含許多未廣泛知曉或基礎教程中未記錄的功能
- **社群驅動**：持續更新和改進

### 1.2 官方資源

- 官方文件：[Anthropic Claude Code Docs](https://claude.ai/code)
- 社群指南：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)
- 狀態：Active（活躍維護中）

---

## 2. 安裝與系統需求

### 2.1 系統需求

- Node.js 18+（建議 LTS 版）
- 支援 macOS、Linux、WSL/Windows
- 建議於純 Ubuntu WSL 環境安裝，避免 Windows 路徑汙染

### 2.2 安裝方式

- **NPM（官方推薦）**
  ```bash
  npm install -g @anthropic-ai/claude-code
  ```
- **MacOS**
  ```bash
  brew install node
  npm install -g @anthropic-ai/claude-code
  ```
- **Arch Linux AUR**
  ```bash
  yay -S claude-code
  # 或 paru -S claude-code
  ```
- **Docker 容器化**
  參考 [claudebox](https://github.com/RchGrav/claudebox)
- **Windows/WSL**
  1. 啟用 WSL2 並安裝 Ubuntu
  2. 於 Ubuntu 執行：
     ```bash
     sudo apt update && sudo apt install -y nodejs npm
     npm install -g @anthropic-ai/claude-code
     ```

#### 驗證安裝

```bash
which claude
claude --version
```

> 來源：[官方文檔](https://docs.anthropic.com/en/docs/claude-code/docs/get-started)｜[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 3. 快速入門

- 啟動互動模式：
  ```bash
  claude
  claude "你的問題"
  ```
- 一次性查詢：
  ```bash
  claude -p "分析這段程式碼"
  cat file.js | claude -p "修正 bug"
  ```
- 專案整合（VSCode/Cursor）：
  ```bash
  cursor .
  # 或
  code .
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 4. 核心指令與參數

### 4.1 常用指令

| 指令               | 說明           |
| ------------------ | -------------- |
| claude             | 啟動互動 REPL  |
| claude -p "prompt" | 一次性查詢     |
| claude config      | 設定管理       |
| claude update      | 升級至最新版   |
| claude mcp         | MCP 伺服器管理 |

### 4.2 參數參考

| 參數                           | 說明                                |
| ------------------------------ | ----------------------------------- |
| --allowedTools                 | 指定允許工具（如 View, Edit, Bash） |
| --apply-patch                  | 啟用自動修復（beta）                |
| --output-format                | 指定輸出格式（如 json, cyclonedx）  |
| --timeout                      | 設定逾時秒數                        |
| --stream                       | 大型 diff 建議加速                  |
| --dangerously-skip-permissions | 跳過權限檢查（僅限測試/容器）       |

#### 常見組合範例

- 安全審查：
  ```bash
  claude -p "檢查 secrets" --allowedTools "View"
  ```
- 自動修復：
  ```bash
  claude -p "修正 lint" --allowedTools "View,Write" --apply-patch
  ```
- 產生 SBOM：
  ```bash
  claude -p "產生 SBOM" --allowedTools "View" --output-format cyclonedx
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 5. Session/Config/MCP 指令

### 5.1 Session 指令

- `claude` 啟動互動模式
- `claude "prompt"` 啟動單次查詢

### 5.2 Config 指令

- `claude config list` 查看所有設定
- `claude config get <key>` 取得設定值
- `claude config set <key> <value>` 設定參數
- `claude config import <file>` 匯入團隊模板

### 5.3 MCP 指令

- `claude mcp` 進入 MCP 管理
- `claude mcp status` 檢查 MCP 狀態
- `claude mcp restart --all` 重啟所有 MCP
- `claude --mcp-debug` 啟用 MCP 除錯

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 6. CLAUDE.md 與記憶體管理

- **CLAUDE.md**：專案根目錄下的記憶體檔案，記錄架構、目標、開發規範等。
- **記憶體指令**：
  - `claude /memory` 編輯記憶體
  - `claude /memory view` 檢視記憶體

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 7. 自動化與腳本整合

- 支援管道與腳本：
  ```bash
  cat file.js | claude -p "優化這段程式碼"
  ```
- 文件自動化：
  ```bash
  claude "更新 README.md 為最新 API"
  claude "根據資料庫 schema 產生 TypeScript 型別"
  ```
- CI/CD 整合：
  - 建議於 CI 設定 `--timeout`，避免卡死
  - 產出 `review-results.json` 以利追蹤

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 8. 進階功能與最佳實踐

### 8.1 進階功能深度解析

#### 多目錄整合分析
```bash
# 跨專案分析
claude --add-dir ../frontend ../backend ../shared
claude "分析微服務架構的整體一致性"

# 分層架構分析
claude --add-dir ./src ./tests ./docs
claude "檢查程式碼、測試、文檔的一致性"

# 依賴關係追蹤
claude --add-dir ../packages/*
claude "分析 monorepo 中的依賴關係和循環依賴"
```

#### MCP 多代理協作進階應用
```bash
# 啟動多代理模式
claude mcp

# 配置專門代理
claude mcp add code-reviewer /path/to/review-agent
claude mcp add security-scanner /path/to/security-agent
claude mcp add performance-analyzer /path/to/perf-agent

# 協作式程式碼審查
claude "請 code-reviewer 和 security-scanner 同時檢查 auth.js"
```

#### Extended Thinking 深度分析
```bash
# 啟用深度思考模式
claude --thinking-budget 10000 "設計一個可擴展的微服務架構"

# API 層級的深度思考
curl -H "anthropic-beta: extended-thinking-2024-12-10" \
     -H "Content-Type: application/json" \
     -d '{
       "model": "claude-3-5-sonnet-20241022",
       "thinking": {"budget_tokens": 20000},
       "messages": [{"role": "user", "content": "分析這個複雜系統的架構"}]
     }' \
     https://api.anthropic.com/v1/messages
```

### 8.2 企業級最佳實踐

#### 安全性強化策略
```json
// ~/.claude/security-policy.json
{
  "defaultTools": ["View", "Read"],
  "restrictedPaths": [
    "/.env*",
    "/secrets/",
    "/**/private/**"
  ],
  "allowedDomains": [
    "github.com",
    "docs.company.com"
  ],
  "auditLogging": true,
  "requireConfirmation": [
    "Edit",
    "Bash",
    "Write"
  ]
}
```

#### 團隊模板標準化
```json
// ~/.claude/templates/team-frontend.json
{
  "name": "前端團隊標準配置",
  "allowedTools": ["View", "Edit", "Bash"],
  "hooks": {
    "preEdit": ["prettier --check", "eslint --quiet"],
    "postEdit": ["npm test -- --related"]
  },
  "slashCommands": [
    "/component-review",
    "/accessibility-check",
    "/performance-audit"
  ],
  "mcpServers": [
    "design-system",
    "component-library"
  ]
}
```

#### 效能優化配置
```bash
# 大型專案優化設定
export CLAUDE_CACHE_SIZE=1000
export CLAUDE_PARALLEL_ANALYSIS=4
export CLAUDE_MEMORY_LIMIT=8192

# 分段處理策略
claude --max-files-per-analysis 50 --timeout 300
```

### 8.3 工作流程自動化

#### CI/CD 整合範例
```yaml
# .github/workflows/claude-review.yml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  claude-review:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
      with:
        fetch-depth: 0
    
    - name: Setup Claude Code
      run: |
        npm install -g @anthropic-ai/claude-code
        echo "${{ secrets.ANTHROPIC_API_KEY }}" > ~/.claude/api-key
    
    - name: Run Claude Review
      run: |
        claude --output-format json \
               --allowedTools "View" \
               "Review the changes in this PR for security, performance, and best practices" \
               > review-results.json
    
    - name: Post Review Comments
      uses: actions/github-script@v6
      with:
        script: |
          const fs = require('fs');
          const results = JSON.parse(fs.readFileSync('review-results.json', 'utf8'));
          
          github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: `## Claude Code 自動審查結果\n\n${results.summary}`
          });
```

#### 開發環境自動化
```bash
# dev-setup.sh
#!/bin/bash

# 初始化 Claude Code 開發環境
claude /init

# 設定專案特定配置
claude config set allowedTools '["View", "Edit", "Bash"]'
claude config set outputFormat "json"

# 安裝必要的 MCP 伺服器
claude mcp add github-integration github-mcp-server
claude mcp add database-tools postgres-mcp-server

# 建立開發專用的斜線命令
mkdir -p .claude/commands
cat > .claude/commands/dev-review.md << 'EOF'
# dev-review

快速開發環境程式碼審查

## Examples
/dev-review src/
EOF

echo "Claude Code 開發環境設定完成！"
```

### 8.4 監控與維護

#### 效能監控配置
```javascript
// claude-monitor.js
const ClaudeMonitor = {
  trackUsage: () => {
    // 追蹤 API 使用量
    const usage = JSON.parse(
      execSync('claude config get usage').toString()
    );
    
    console.log(`API 使用量: ${usage.tokens}/月`);
    console.log(`剩餘額度: ${usage.remaining}`);
    
    if (usage.remaining < 1000) {
      console.warn('⚠️  API 額度即將用盡！');
    }
  },
  
  healthCheck: () => {
    // 系統健康檢查
    execSync('claude /doctor');
  },
  
  cleanupSessions: () => {
    // 清理舊的 session
    execSync('claude /compact');
  }
};

// 定期執行監控
setInterval(ClaudeMonitor.trackUsage, 3600000); // 每小時
setInterval(ClaudeMonitor.healthCheck, 86400000); // 每日
```

#### 錯誤追蹤與診斷
```bash
# 詳細錯誤診斷
claude --verbose --debug "分析這個錯誤" 2>error.log

# MCP 連接診斷
claude --mcp-debug mcp status

# 記憶體和緩存診斷
claude /doctor --detailed

# 匯出診斷報告
claude /bug --include-logs --include-config
```

### 8.5 高階整合模式

#### 語義搜尋整合
```python
# semantic-search.py
import subprocess
import json

def semantic_code_search(query, project_path):
    """結合 Claude Code 進行語義程式碼搜尋"""
    
    # 使用 Claude 分析搜尋意圖
    result = subprocess.run([
        'claude', '--output-format', 'json',
        f'在 {project_path} 中搜尋與「{query}」相關的程式碼'
    ], capture_output=True, text=True)
    
    search_results = json.loads(result.stdout)
    
    # 進一步分析和排序結果
    analysis = subprocess.run([
        'claude', '--output-format', 'json',
        f'分析這些搜尋結果的相關性：{search_results}'
    ], capture_output=True, text=True)
    
    return json.loads(analysis.stdout)
```

#### 架構分析自動化
```bash
# architecture-analyzer.sh
#!/bin/bash

echo "🏗️  開始架構分析..."

# 分析整體架構
claude --add-dir src tests docs \
       --output-format json \
       "分析專案架構並提供改進建議" > architecture-report.json

# 依賴關係分析
claude "分析 package.json 和 imports，找出潛在的依賴問題" > dependencies-report.md

# 安全性掃描
claude --allowedTools "View" \
       "掃描程式碼中的潛在安全問題" > security-report.md

# 效能分析
claude "分析程式碼中的效能瓶頸和優化機會" > performance-report.md

echo "✅ 架構分析完成！查看生成的報告文件。"
```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide) | [官方文檔](https://docs.anthropic.com/en/docs/claude-code) | 企業級實踐案例

---

## 9. 疑難排解與常見問題

| 症狀                   | 可能原因              | 解決方式                                         |
| ---------------------- | --------------------- | ------------------------------------------------ |
| 缺少 ANTHROPIC_API_KEY | 未設環境變數          | 設定 export ANTHROPIC_API_KEY=xxx                |
| Rate limit exceeded    | 免費額度用盡          | 升級方案或減少請求                               |
| 權限錯誤               | allowedTools 設定錯誤 | claude config set allowedTools '["Edit","View"]' |
| MCP 問題               | MCP 未啟動或異常      | claude mcp restart --all                         |
| Node 版本錯誤          | Node.js 版本過舊      | 升級 Node.js 至 18+                              |

- 健康檢查：
  ```bash
  claude --version
  claude --help
  claude config list
  claude /doctor
  ```
- 除錯模式：
  ```bash
  claude --verbose
  ```

> 來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)

---

## 10. 社群資源與延伸閱讀

- [zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)
- [官方文檔](https://docs.anthropic.com/en/docs/claude-code)
- [CLAUDE.md 範例](https://github.com/zebbern/claude-code-guide/blob/main/CLAUDE.md)
- [Anthropic API 參考](https://docs.anthropic.com/en/docs/claude-code/api/overview)
- [MCP 多代理協作](https://docs.anthropic.com/en/docs/claude-code/docs/agents-and-tools/tool-use/overview)

---

> 本文件最後更新：2025-08-15T00:40:00+08:00
>
> 主要參考來源：[zebbern/claude-code-guide](https://github.com/zebbern/claude-code-guide)、[Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
>
> **專案版本**：Claude Code v1.0.72 | **專案更新**：2025-08-10T23:24:41+02:00
