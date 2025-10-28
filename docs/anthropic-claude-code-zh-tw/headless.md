---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/headless.md"
fetched_at: "2025-10-28T19:17:05+08:00"
---

# 無頭模式

> 以程式化方式運行 Claude Code，無需互動式 UI

## 概述

無頭模式允許您從命令列腳本和自動化工具以程式化方式運行 Claude Code，無需任何互動式 UI。

## 基本用法

Claude Code 的主要命令列介面是 `claude` 命令。使用 `--print`（或 `-p`）標誌以非互動模式運行並列印最終結果：

```bash  theme={null}
claude -p "暫存我的變更並為它們寫一組提交" \
  --allowedTools "Bash,Read" \
  --permission-mode acceptEdits
```

## 配置選項

無頭模式利用 Claude Code 中所有可用的 CLI 選項。以下是自動化和腳本編寫的關鍵選項：

| 標誌                         | 描述                                       | 範例                                                                                                                        |
| :------------------------- | :--------------------------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| `--print`, `-p`            | 以非互動模式運行                                 | `claude -p "查詢"`                                                                                                          |
| `--output-format`          | 指定輸出格式（`text`、`json`、`stream-json`）      | `claude -p --output-format json`                                                                                          |
| `--resume`, `-r`           | 透過會話 ID 恢復對話                             | `claude --resume abc123`                                                                                                  |
| `--continue`, `-c`         | 繼續最近的對話                                  | `claude --continue`                                                                                                       |
| `--verbose`                | 啟用詳細記錄                                   | `claude --verbose`                                                                                                        |
| `--append-system-prompt`   | 附加到系統提示（僅與 `--print` 一起使用）               | `claude --append-system-prompt "自訂指令"`                                                                                    |
| `--allowedTools`           | 以空格分隔的允許工具清單，或 <br /><br /> 以逗號分隔的允許工具字串 | `claude --allowedTools mcp__slack mcp__filesystem`<br /><br />`claude --allowedTools "Bash(npm install),mcp__filesystem"` |
| `--disallowedTools`        | 以空格分隔的拒絕工具清單，或 <br /><br /> 以逗號分隔的拒絕工具字串 | `claude --disallowedTools mcp__splunk mcp__github`<br /><br />`claude --disallowedTools "Bash(git commit),mcp__github"`   |
| `--mcp-config`             | 從 JSON 檔案載入 MCP 伺服器                      | `claude --mcp-config servers.json`                                                                                        |
| `--permission-prompt-tool` | 用於處理權限提示的 MCP 工具（僅與 `--print` 一起使用）      | `claude --permission-prompt-tool mcp__auth__prompt`                                                                       |

如需完整的 CLI 選項和功能清單，請參閱 [CLI 參考](/zh-TW/docs/claude-code/cli-reference) 文件。

## 多輪對話

對於多輪對話，您可以恢復對話或從最近的會話繼續：

```bash  theme={null}
# 繼續最近的對話
claude --continue "現在重構這個以獲得更好的效能"

# 透過會話 ID 恢復特定對話
claude --resume 550e8400-e29b-41d4-a716-446655440000 "更新測試"

# 以非互動模式恢復
claude --resume 550e8400-e29b-41d4-a716-446655440000 "修復所有 linting 問題" --no-interactive
```

## 輸出格式

### 文字輸出（預設）

```bash  theme={null}
claude -p "解釋檔案 src/components/Header.tsx"
# 輸出：這是一個 React 元件顯示...
```

### JSON 輸出

返回包含元資料的結構化資料：

```bash  theme={null}
claude -p "資料層如何運作？" --output-format json
```

回應格式：

```json  theme={null}
{
  "type": "result",
  "subtype": "success",
  "total_cost_usd": 0.003,
  "is_error": false,
  "duration_ms": 1234,
  "duration_api_ms": 800,
  "num_turns": 6,
  "result": "回應文字在這裡...",
  "session_id": "abc123"
}
```

### 串流 JSON 輸出

在接收到每個訊息時串流：

```bash  theme={null}
claude -p "建立一個應用程式" --output-format stream-json
```

每個對話都以初始的 `init` 系統訊息開始，接著是使用者和助理訊息清單，最後是包含統計資料的最終 `result` 系統訊息。每個訊息都作為單獨的 JSON 物件發出。

## 輸入格式

### 文字輸入（預設）

```bash  theme={null}
# 直接參數
claude -p "解釋這段程式碼"

# 從 stdin
echo "解釋這段程式碼" | claude -p
```

### 串流 JSON 輸入

透過 `stdin` 提供的訊息串流，其中每個訊息代表一個使用者輪次。這允許多輪對話而無需重新啟動 `claude` 二進位檔案，並允許在模型處理請求時提供指導。

每個訊息都是一個 JSON「使用者訊息」物件，遵循與輸出訊息架構相同的格式。訊息使用 [jsonl](https://jsonlines.org/) 格式格式化，其中每行輸入都是一個完整的 JSON 物件。串流 JSON 輸入需要 `-p` 和 `--output-format stream-json`。

```bash  theme={null}
echo '{"type":"user","message":{"role":"user","content":[{"type":"text","text":"解釋這段程式碼"}]}}' | claude -p --output-format=stream-json --input-format=stream-json --verbose
```

## 代理整合範例

### SRE 事件回應機器人

```bash  theme={null}
#!/bin/bash

# 自動化事件回應代理
investigate_incident() {
    local incident_description="$1"
    local severity="${2:-medium}"

    claude -p "事件：$incident_description（嚴重性：$severity）" \
      --append-system-prompt "您是 SRE 專家。診斷問題、評估影響並提供即時行動項目。" \
      --output-format json \
      --allowedTools "Bash,Read,WebSearch,mcp__datadog" \
      --mcp-config monitoring-tools.json
}

# 用法
investigate_incident "付款 API 返回 500 錯誤" "high"
```

### 自動化安全審查

```bash  theme={null}
# 拉取請求的安全稽核代理
audit_pr() {
    local pr_number="$1"

    gh pr diff "$pr_number" | claude -p \
      --append-system-prompt "您是安全工程師。審查此 PR 是否存在漏洞、不安全模式和合規問題。" \
      --output-format json \
      --allowedTools "Read,Grep,WebSearch"
}

# 用法並儲存到檔案
audit_pr 123 > security-report.json
```

### 多輪法律助理

```bash  theme={null}
# 具有會話持久性的法律文件審查
session_id=$(claude -p "開始法律審查會話" --output-format json | jq -r '.session_id')

# 分多個步驟審查合約
claude -p --resume "$session_id" "審查 contract.pdf 的責任條款"
claude -p --resume "$session_id" "檢查 GDPR 要求的合規性"
claude -p --resume "$session_id" "生成風險的執行摘要"
```

## 最佳實務

* **使用 JSON 輸出格式** 進行回應的程式化解析：

  ```bash  theme={null}
  # 使用 jq 解析 JSON 回應
  result=$(claude -p "生成程式碼" --output-format json)
  code=$(echo "$result" | jq -r '.result')
  cost=$(echo "$result" | jq -r '.cost_usd')
  ```

* **優雅地處理錯誤** - 檢查退出代碼和 stderr：

  ```bash  theme={null}
  if ! claude -p "$prompt" 2>error.log; then
      echo "發生錯誤：" >&2
      cat error.log >&2
      exit 1
  fi
  ```

* **使用會話管理** 在多輪對話中維護上下文

* **考慮超時** 對於長時間運行的操作：

  ```bash  theme={null}
  timeout 300 claude -p "$complex_prompt" || echo "5 分鐘後超時"
  ```

* **尊重速率限制** 在進行多個請求時，透過在呼叫之間添加延遲

## 相關資源

* [CLI 用法和控制](/zh-TW/docs/claude-code/cli-reference) - 完整的 CLI 文件
* [常見工作流程](/zh-TW/docs/claude-code/common-workflows) - 常見用例的逐步指南

