---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/hooks.md"
fetched_at: "2025-10-28T19:17:13+08:00"
---

# Hooks 參考

> 此頁面提供在 Claude Code 中實現 hooks 的參考文檔。

<Tip>
  如需快速入門指南和範例，請參閱 [Claude Code hooks 入門](/zh-TW/docs/claude-code/hooks-guide)。
</Tip>

## 配置

Claude Code hooks 在您的 [設定檔](/zh-TW/docs/claude-code/settings) 中配置：

* `~/.claude/settings.json` - 使用者設定
* `.claude/settings.json` - 專案設定
* `.claude/settings.local.json` - 本機專案設定（未提交）
* 企業管理的政策設定

### 結構

Hooks 按匹配器組織，每個匹配器可以有多個 hooks：

```json  theme={null}
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here"
          }
        ]
      }
    ]
  }
}
```

* **matcher**：匹配工具名稱的模式，區分大小寫（僅適用於 `PreToolUse` 和 `PostToolUse`）
  * 簡單字串精確匹配：`Write` 僅匹配 Write 工具
  * 支援正規表達式：`Edit|Write` 或 `Notebook.*`
  * 使用 `*` 匹配所有工具。您也可以使用空字串 (`""`) 或留空 `matcher`。
* **hooks**：當模式匹配時要執行的命令陣列
  * `type`：目前僅支援 `"command"`
  * `command`：要執行的 bash 命令（可使用 `$CLAUDE_PROJECT_DIR` 環境變數）
  * `timeout`：（可選）命令應執行的時間長度（以秒為單位），超過後取消該特定命令。

對於不使用匹配器的事件，如 `UserPromptSubmit`、`Notification`、`Stop` 和 `SubagentStop`，您可以省略 matcher 欄位：

```json  theme={null}
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/prompt-validator.py"
          }
        ]
      }
    ]
  }
}
```

### 專案特定的 Hook 指令碼

您可以使用環境變數 `CLAUDE_PROJECT_DIR`（僅在 Claude Code 生成 hook 命令時可用）來參考儲存在您專案中的指令碼，確保無論 Claude 的目前目錄如何，它們都能正常運作：

```json  theme={null}
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check-style.sh"
          }
        ]
      }
    ]
  }
}
```

### 外掛程式 hooks

[外掛程式](/zh-TW/docs/claude-code/plugins) 可以提供與您的使用者和專案 hooks 無縫整合的 hooks。啟用外掛程式時，外掛程式 hooks 會自動與您的配置合併。

**外掛程式 hooks 的運作方式**：

* 外掛程式 hooks 在外掛程式的 `hooks/hooks.json` 檔案或由 `hooks` 欄位的自訂路徑指定的檔案中定義。
* 啟用外掛程式時，其 hooks 會與使用者和專案 hooks 合併
* 來自不同來源的多個 hooks 可以回應相同的事件
* 外掛程式 hooks 使用 `${CLAUDE_PLUGIN_ROOT}` 環境變數來參考外掛程式檔案

**外掛程式 hook 配置範例**：

```json  theme={null}
{
  "description": "Automatic code formatting",
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

<Note>
  外掛程式 hooks 使用與一般 hooks 相同的格式，並可選擇使用 `description` 欄位來說明 hook 的用途。
</Note>

<Note>
  外掛程式 hooks 與您的自訂 hooks 並行執行。如果多個 hooks 匹配一個事件，它們都會並行執行。
</Note>

**外掛程式的環境變數**：

* `${CLAUDE_PLUGIN_ROOT}`：外掛程式目錄的絕對路徑
* `${CLAUDE_PROJECT_DIR}`：專案根目錄（與專案 hooks 相同）
* 所有標準環境變數都可用

有關建立外掛程式 hooks 的詳細資訊，請參閱 [外掛程式元件參考](/zh-TW/docs/claude-code/plugins-reference#hooks)。

## Hook 事件

### PreToolUse

在 Claude 建立工具參數之後、處理工具呼叫之前執行。

**常見匹配器：**

* `Task` - 子代理工作（請參閱 [子代理文檔](/zh-TW/docs/claude-code/sub-agents)）
* `Bash` - Shell 命令
* `Glob` - 檔案模式匹配
* `Grep` - 內容搜尋
* `Read` - 檔案讀取
* `Edit` - 檔案編輯
* `Write` - 檔案寫入
* `WebFetch`、`WebSearch` - 網路操作

### PostToolUse

在工具成功完成後立即執行。

識別與 PreToolUse 相同的匹配器值。

### Notification

在 Claude Code 傳送通知時執行。通知在以下情況下傳送：

1. Claude 需要您的許可才能使用工具。範例："Claude needs your permission to use Bash"
2. 提示輸入已閒置至少 60 秒。"Claude is waiting for your input"

### UserPromptSubmit

在使用者提交提示時執行，在 Claude 處理之前。這允許您根據提示/對話新增額外內容、驗證提示或阻止某些類型的提示。

### Stop

在主 Claude Code 代理完成回應時執行。如果停止是由於使用者中斷而發生的，則不執行。

### SubagentStop

在 Claude Code 子代理（Task 工具呼叫）完成回應時執行。

### PreCompact

在 Claude Code 即將執行壓縮操作之前執行。

**匹配器：**

* `manual` - 從 `/compact` 呼叫
* `auto` - 從自動壓縮呼叫（由於上下文視窗已滿）

### SessionStart

在 Claude Code 啟動新會話或恢復現有會話時執行（目前在幕後啟動新會話）。適用於載入開發內容（如現有問題或程式碼庫的最近變更）、安裝依賴項或設定環境變數。

**匹配器：**

* `startup` - 從啟動呼叫
* `resume` - 從 `--resume`、`--continue` 或 `/resume` 呼叫
* `clear` - 從 `/clear` 呼叫
* `compact` - 從自動或手動壓縮呼叫。

#### 持久化環境變數

SessionStart hooks 可以存取 `CLAUDE_ENV_FILE` 環境變數，該變數提供一個檔案路徑，您可以在其中持久化環境變數供後續 bash 命令使用。

**範例：設定個別環境變數**

```bash  theme={null}
#!/bin/bash

if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=production' >> "$CLAUDE_ENV_FILE"
  echo 'export API_KEY=your-api-key' >> "$CLAUDE_ENV_FILE"
  echo 'export PATH="$PATH:./node_modules/.bin"' >> "$CLAUDE_ENV_FILE"
fi

exit 0
```

**範例：持久化 hook 中的所有環境變更**

當您的設定修改環境時（例如 `nvm use`），通過比較環境來捕獲並持久化所有變更：

```bash  theme={null}
#!/bin/bash

ENV_BEFORE=$(export -p | sort)

# Run your setup commands that modify the environment
source ~/.nvm/nvm.sh
nvm use 20

if [ -n "$CLAUDE_ENV_FILE" ]; then
  ENV_AFTER=$(export -p | sort)
  comm -13 <(echo "$ENV_BEFORE") <(echo "$ENV_AFTER") >> "$CLAUDE_ENV_FILE"
fi

exit 0
```

寫入此檔案的任何變數都將在 Claude Code 在會話期間執行的所有後續 bash 命令中可用。

<Note>
  `CLAUDE_ENV_FILE` 僅適用於 SessionStart hooks。其他 hook 類型無法存取此變數。
</Note>

### SessionEnd

在 Claude Code 會話結束時執行。適用於清理工作、記錄會話統計資訊或儲存會話狀態。

hook 輸入中的 `reason` 欄位將是以下之一：

* `clear` - 使用 /clear 命令清除會話
* `logout` - 使用者登出
* `prompt_input_exit` - 使用者在提示輸入可見時退出
* `other` - 其他退出原因

## Hook 輸入

Hooks 通過 stdin 接收包含會話資訊和事件特定資料的 JSON 資料：

```typescript  theme={null}
{
  // 常見欄位
  session_id: string
  transcript_path: string  // 對話 JSON 的路徑
  cwd: string              // 呼叫 hook 時的目前工作目錄
  permission_mode: string  // 目前許可模式："default"、"plan"、"acceptEdits" 或 "bypassPermissions"

  // 事件特定欄位
  hook_event_name: string
  ...
}
```

### PreToolUse 輸入

`tool_input` 的確切架構取決於工具。

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "/Users/.../.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "cwd": "/Users/...",
  "permission_mode": "default",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.txt",
    "content": "file content"
  }
}
```

### PostToolUse 輸入

`tool_input` 和 `tool_response` 的確切架構取決於工具。

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "/Users/.../.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "cwd": "/Users/...",
  "permission_mode": "default",
  "hook_event_name": "PostToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.txt",
    "content": "file content"
  },
  "tool_response": {
    "filePath": "/path/to/file.txt",
    "success": true
  }
}
```

### Notification 輸入

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "/Users/.../.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "cwd": "/Users/...",
  "permission_mode": "default",
  "hook_event_name": "Notification",
  "message": "Task completed successfully"
}
```

### UserPromptSubmit 輸入

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "/Users/.../.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "cwd": "/Users/...",
  "permission_mode": "default",
  "hook_event_name": "UserPromptSubmit",
  "prompt": "Write a function to calculate the factorial of a number"
}
```

### Stop 和 SubagentStop 輸入

當 Claude Code 已作為 stop hook 的結果繼續時，`stop_hook_active` 為 true。檢查此值或處理文字記錄以防止 Claude Code 無限執行。

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "permission_mode": "default",
  "hook_event_name": "Stop",
  "stop_hook_active": true
}
```

### PreCompact 輸入

對於 `manual`，`custom_instructions` 來自使用者傳入 `/compact` 的內容。對於 `auto`，`custom_instructions` 為空。

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "permission_mode": "default",
  "hook_event_name": "PreCompact",
  "trigger": "manual",
  "custom_instructions": ""
}
```

### SessionStart 輸入

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "permission_mode": "default",
  "hook_event_name": "SessionStart",
  "source": "startup"
}
```

### SessionEnd 輸入

```json  theme={null}
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
  "cwd": "/Users/...",
  "permission_mode": "default",
  "hook_event_name": "SessionEnd",
  "reason": "exit"
}
```

## Hook 輸出

Hooks 有兩種方式將輸出返回給 Claude Code。輸出傳達是否應阻止以及應向 Claude 和使用者顯示的任何回饋。

### 簡單：退出代碼

Hooks 通過退出代碼、stdout 和 stderr 傳達狀態：

* **退出代碼 0**：成功。`stdout` 在文字記錄模式 (CTRL-R) 中顯示給使用者，除了 `UserPromptSubmit` 和 `SessionStart`，其中 stdout 被新增到上下文。
* **退出代碼 2**：阻止錯誤。`stderr` 被反饋給 Claude 自動處理。請參閱下面的每個 hook 事件行為。
* **其他退出代碼**：非阻止錯誤。`stderr` 顯示給使用者，執行繼續。

<Warning>
  提醒：如果退出代碼為 0，Claude Code 看不到 stdout，除了 `UserPromptSubmit` hook，其中 stdout 被注入為上下文。
</Warning>

#### 退出代碼 2 行為

| Hook 事件            | 行為                         |
| ------------------ | -------------------------- |
| `PreToolUse`       | 阻止工具呼叫，向 Claude 顯示 stderr  |
| `PostToolUse`      | 向 Claude 顯示 stderr（工具已執行）  |
| `Notification`     | 不適用，僅向使用者顯示 stderr         |
| `UserPromptSubmit` | 阻止提示處理，清除提示，僅向使用者顯示 stderr |
| `Stop`             | 阻止停止，向 Claude 顯示 stderr    |
| `SubagentStop`     | 阻止停止，向 Claude 子代理顯示 stderr |
| `PreCompact`       | 不適用，僅向使用者顯示 stderr         |
| `SessionStart`     | 不適用，僅向使用者顯示 stderr         |
| `SessionEnd`       | 不適用，僅向使用者顯示 stderr         |

### 進階：JSON 輸出

Hooks 可以在 `stdout` 中返回結構化 JSON 以進行更複雜的控制：

#### 常見 JSON 欄位

所有 hook 類型都可以包含這些可選欄位：

```json  theme={null}
{
  "continue": true, // Claude 在 hook 執行後是否應繼續（預設值：true）
  "stopReason": "string", // 當 continue 為 false 時顯示的訊息

  "suppressOutput": true, // 在文字記錄模式中隱藏 stdout（預設值：false）
  "systemMessage": "string" // 可選的警告訊息，顯示給使用者
}
```

如果 `continue` 為 false，Claude 在 hooks 執行後停止處理。

* 對於 `PreToolUse`，這與 `"permissionDecision": "deny"` 不同，後者僅阻止特定工具呼叫並向 Claude 提供自動回饋。
* 對於 `PostToolUse`，這與 `"decision": "block"` 不同，後者向 Claude 提供自動化回饋。
* 對於 `UserPromptSubmit`，這防止提示被處理。
* 對於 `Stop` 和 `SubagentStop`，這優先於任何 `"decision": "block"` 輸出。
* 在所有情況下，`"continue" = false` 優先於任何 `"decision": "block"` 輸出。

`stopReason` 伴隨 `continue` 提供向使用者顯示的原因，不向 Claude 顯示。

#### `PreToolUse` 決策控制

`PreToolUse` hooks 可以控制工具呼叫是否進行。

* `"allow"` 繞過許可系統。`permissionDecisionReason` 向使用者顯示但不向 Claude 顯示。
* `"deny"` 防止工具呼叫執行。`permissionDecisionReason` 向 Claude 顯示。
* `"ask"` 要求使用者在 UI 中確認工具呼叫。`permissionDecisionReason` 向使用者顯示但不向 Claude 顯示。

此外，hooks 可以在執行前使用 `updatedInput` 修改工具輸入：

* `updatedInput` 允許您在工具執行前修改工具的輸入參數。這是一個 `Record<string, unknown>` 物件，包含您想要變更或新增的欄位。
* 這在 `"permissionDecision": "allow"` 時最有用，可以修改和批准工具呼叫。

```json  theme={null}
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow"
    "permissionDecisionReason": "My reason here",
    "updatedInput": {
      "field_to_modify": "new value"
    }
  }
}
```

<Note>
  `decision` 和 `reason` 欄位已針對 PreToolUse hooks 棄用。
  改用 `hookSpecificOutput.permissionDecision` 和
  `hookSpecificOutput.permissionDecisionReason`。已棄用的欄位
  `"approve"` 和 `"block"` 對應到 `"allow"` 和 `"deny"`。
</Note>

#### `PostToolUse` 決策控制

`PostToolUse` hooks 可以在工具執行後向 Claude 提供回饋。

* `"block"` 自動提示 Claude 使用 `reason`。
* `undefined` 不執行任何操作。`reason` 被忽略。
* `"hookSpecificOutput.additionalContext"` 為 Claude 新增要考慮的上下文。

```json  theme={null}
{
  "decision": "block" | undefined,
  "reason": "Explanation for decision",
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse",
    "additionalContext": "Additional information for Claude"
  }
}
```

#### `UserPromptSubmit` 決策控制

`UserPromptSubmit` hooks 可以控制使用者提示是否被處理。

* `"block"` 防止提示被處理。提交的提示從上下文中清除。`"reason"` 向使用者顯示但不新增到上下文。
* `undefined` 允許提示正常進行。`"reason"` 被忽略。
* `"hookSpecificOutput.additionalContext"` 如果未被阻止，將字串新增到上下文。

```json  theme={null}
{
  "decision": "block" | undefined,
  "reason": "Explanation for decision",
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "My additional context here"
  }
}
```

#### `Stop`/`SubagentStop` 決策控制

`Stop` 和 `SubagentStop` hooks 可以控制 Claude 是否必須繼續。

* `"block"` 防止 Claude 停止。您必須填入 `reason` 以便 Claude 知道如何進行。
* `undefined` 允許 Claude 停止。`reason` 被忽略。

```json  theme={null}
{
  "decision": "block" | undefined,
  "reason": "Must be provided when Claude is blocked from stopping"
}
```

#### `SessionStart` 決策控制

`SessionStart` hooks 允許您在會話開始時載入上下文。

* `"hookSpecificOutput.additionalContext"` 將字串新增到上下文。
* 多個 hooks 的 `additionalContext` 值被連接。

```json  theme={null}
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "My additional context here"
  }
}
```

#### `SessionEnd` 決策控制

`SessionEnd` hooks 在會話結束時執行。它們無法阻止會話終止，但可以執行清理工作。

#### 退出代碼範例：Bash 命令驗證

```python  theme={null}
#!/usr/bin/env python3
import json
import re
import sys

# Define validation rules as a list of (regex pattern, message) tuples
VALIDATION_RULES = [
    (
        r"\bgrep\b(?!.*\|)",
        "Use 'rg' (ripgrep) instead of 'grep' for better performance and features",
    ),
    (
        r"\bfind\s+\S+\s+-name\b",
        "Use 'rg --files | rg pattern' or 'rg --files -g pattern' instead of 'find -name' for better performance",
    ),
]


def validate_command(command: str) -> list[str]:
    issues = []
    for pattern, message in VALIDATION_RULES:
        if re.search(pattern, command):
            issues.append(message)
    return issues


try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError as e:
    print(f"Error: Invalid JSON input: {e}", file=sys.stderr)
    sys.exit(1)

tool_name = input_data.get("tool_name", "")
tool_input = input_data.get("tool_input", {})
command = tool_input.get("command", "")

if tool_name != "Bash" or not command:
    sys.exit(1)

# Validate the command
issues = validate_command(command)

if issues:
    for message in issues:
        print(f"• {message}", file=sys.stderr)
    # Exit code 2 blocks tool call and shows stderr to Claude
    sys.exit(2)
```

#### JSON 輸出範例：UserPromptSubmit 以新增上下文和驗證

<Note>
  對於 `UserPromptSubmit` hooks，您可以使用任一方法注入上下文：

  * 退出代碼 0 加 stdout：Claude 看到上下文（`UserPromptSubmit` 的特殊情況）
  * JSON 輸出：提供對行為的更多控制
</Note>

```python  theme={null}
#!/usr/bin/env python3
import json
import sys
import re
import datetime

# Load input from stdin
try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError as e:
    print(f"Error: Invalid JSON input: {e}", file=sys.stderr)
    sys.exit(1)

prompt = input_data.get("prompt", "")

# Check for sensitive patterns
sensitive_patterns = [
    (r"(?i)\b(password|secret|key|token)\s*[:=]", "Prompt contains potential secrets"),
]

for pattern, message in sensitive_patterns:
    if re.search(pattern, prompt):
        # Use JSON output to block with a specific reason
        output = {
            "decision": "block",
            "reason": f"Security policy violation: {message}. Please rephrase your request without sensitive information."
        }
        print(json.dumps(output))
        sys.exit(0)

# Add current time to context
context = f"Current time: {datetime.datetime.now()}"
print(context)

"""
The following is also equivalent:
print(json.dumps({
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": context,
  },
}))
"""

# Allow the prompt to proceed with the additional context
sys.exit(0)
```

#### JSON 輸出範例：PreToolUse 與批准

```python  theme={null}
#!/usr/bin/env python3
import json
import sys

# Load input from stdin
try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError as e:
    print(f"Error: Invalid JSON input: {e}", file=sys.stderr)
    sys.exit(1)

tool_name = input_data.get("tool_name", "")
tool_input = input_data.get("tool_input", {})

# Example: Auto-approve file reads for documentation files
if tool_name == "Read":
    file_path = tool_input.get("file_path", "")
    if file_path.endswith((".md", ".mdx", ".txt", ".json")):
        # Use JSON output to auto-approve the tool call
        output = {
            "decision": "approve",
            "reason": "Documentation file auto-approved",
            "suppressOutput": True  # Don't show in transcript mode
        }
        print(json.dumps(output))
        sys.exit(0)

# For other cases, let the normal permission flow proceed
sys.exit(0)
```

## 使用 MCP 工具

Claude Code hooks 與 [Model Context Protocol (MCP) 工具](/zh-TW/docs/claude-code/mcp) 無縫協作。當 MCP 伺服器提供工具時，它們會以特殊命名模式出現，您可以在 hooks 中匹配。

### MCP 工具命名

MCP 工具遵循模式 `mcp__<server>__<tool>`，例如：

* `mcp__memory__create_entities` - Memory 伺服器的建立實體工具
* `mcp__filesystem__read_file` - Filesystem 伺服器的讀取檔案工具
* `mcp__github__search_repositories` - GitHub 伺服器的搜尋工具

### 為 MCP 工具配置 Hooks

您可以針對特定 MCP 工具或整個 MCP 伺服器：

```json  theme={null}
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__memory__.*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Memory operation initiated' >> ~/mcp-operations.log"
          }
        ]
      },
      {
        "matcher": "mcp__.*__write.*",
        "hooks": [
          {
            "type": "command",
            "command": "/home/user/scripts/validate-mcp-write.py"
          }
        ]
      }
    ]
  }
}
```

## 範例

<Tip>
  如需實用範例，包括程式碼格式化、通知和檔案保護，請參閱入門指南中的 [更多範例](/zh-TW/docs/claude-code/hooks-guide#more-examples)。
</Tip>

## 安全考慮

### 免責聲明

**使用風險自負**：Claude Code hooks 在您的系統上自動執行任意 shell 命令。使用 hooks，您確認：

* 您對配置的命令單獨負責
* Hooks 可以修改、刪除或存取您的使用者帳戶可以存取的任何檔案
* 惡意或編寫不當的 hooks 可能導致資料遺失或系統損壞
* Anthropic 不提供任何保證，對因 hook 使用而導致的任何損壞不承擔任何責任
* 您應在生產使用前在安全環境中徹底測試 hooks

在將任何 hook 命令新增到您的配置之前，始終檢查並理解它們。

### 安全最佳實踐

以下是編寫更安全 hooks 的一些關鍵實踐：

1. **驗證和清理輸入** - 永遠不要盲目信任輸入資料
2. **始終引用 shell 變數** - 使用 `"$VAR"` 而不是 `$VAR`
3. **阻止路徑遍歷** - 檢查檔案路徑中的 `..`
4. **使用絕對路徑** - 為指令碼指定完整路徑（使用 `"$CLAUDE_PROJECT_DIR"` 表示專案路徑）
5. **跳過敏感檔案** - 避免 `.env`、`.git/`、金鑰等

### 配置安全

直接編輯設定檔中的 hooks 不會立即生效。Claude Code：

1. 在啟動時捕獲 hooks 的快照
2. 在整個會話中使用此快照
3. 如果 hooks 被外部修改，發出警告
4. 需要在 `/hooks` 功能表中檢查變更才能應用

這可防止惡意 hook 修改影響您目前的會話。

## Hook 執行詳細資訊

* **超時**：預設 60 秒執行限制，每個命令可配置。
  * 個別命令的超時不會影響其他命令。
* **並行化**：所有匹配的 hooks 並行執行
* **去重**：多個相同的 hook 命令會自動去重
* **環境**：在目前目錄中以 Claude Code 的環境執行
  * `CLAUDE_PROJECT_DIR` 環境變數可用，包含專案根目錄的絕對路徑（Claude Code 啟動的位置）
  * `CLAUDE_CODE_REMOTE` 環境變數指示 hook 是在遠端（網路）環境 (`"true"`) 還是本機 CLI 環境（未設定或空）中執行。使用此變數根據執行上下文執行不同的邏輯。
* **輸入**：通過 stdin 的 JSON
* **輸出**：
  * PreToolUse/PostToolUse/Stop/SubagentStop：進度顯示在文字記錄中 (Ctrl-R)
  * Notification/SessionEnd：記錄到偵錯 (`--debug`)
  * UserPromptSubmit/SessionStart：stdout 作為 Claude 的上下文新增

## 偵錯

### 基本故障排除

如果您的 hooks 不起作用：

1. **檢查配置** - 執行 `/hooks` 查看您的 hook 是否已註冊
2. **驗證語法** - 確保您的 JSON 設定有效
3. **測試命令** - 首先手動執行 hook 命令
4. **檢查許可** - 確保指令碼可執行
5. **檢查日誌** - 使用 `claude --debug` 查看 hook 執行詳細資訊

常見問題：

* **引號未轉義** - 在 JSON 字串中使用 `\"`
* **匹配器錯誤** - 檢查工具名稱精確匹配（區分大小寫）
* **找不到命令** - 為指令碼使用完整路徑

### 進階偵錯

對於複雜的 hook 問題：

1. **檢查 hook 執行** - 使用 `claude --debug` 查看詳細的 hook 執行
2. **驗證 JSON 架構** - 使用外部工具測試 hook 輸入/輸出
3. **檢查環境變數** - 驗證 Claude Code 的環境是否正確
4. **測試邊界情況** - 嘗試使用不尋常的檔案路徑或輸入的 hooks
5. **監控系統資源** - 檢查 hook 執行期間是否有資源耗盡
6. **使用結構化日誌** - 在 hook 指令碼中實現日誌記錄

### 偵錯輸出範例

使用 `claude --debug` 查看 hook 執行詳細資訊：

```
[DEBUG] Executing hooks for PostToolUse:Write
[DEBUG] Getting matching hook commands for PostToolUse with query: Write
[DEBUG] Found 1 hook matchers in settings
[DEBUG] Matched 1 hooks for query "Write"
[DEBUG] Found 1 hook commands to execute
[DEBUG] Executing hook command: <Your command> with timeout 60000ms
[DEBUG] Hook command completed with status 0: <Your stdout>
```

進度訊息出現在文字記錄模式 (Ctrl-R) 中，顯示：

* 哪個 hook 正在執行
* 正在執行的命令
* 成功/失敗狀態
* 輸出或錯誤訊息

