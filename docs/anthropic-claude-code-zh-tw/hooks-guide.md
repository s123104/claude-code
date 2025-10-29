---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/hooks-guide.md"
fetched_at: "2025-10-29T14:10:42+08:00"
---

# 開始使用 Claude Code hooks

> 學習如何透過註冊 shell 命令來自訂和擴展 Claude Code 的行為

Claude Code hooks 是使用者定義的 shell 命令，在 Claude Code 生命週期的各個時間點執行。Hooks 提供對 Claude Code 行為的確定性控制，確保某些動作總是會發生，而不是依賴 LLM 選擇執行它們。

<Tip>
  有關 hooks 的參考文件，請參閱 [Hooks 參考](/zh-TW/docs/claude-code/hooks)。
</Tip>

hooks 的範例使用案例包括：

* **通知**：自訂當 Claude Code 等待您的輸入或執行權限時如何收到通知。
* **自動格式化**：在每次檔案編輯後對 .ts 檔案執行 `prettier`，對 .go 檔案執行 `gofmt` 等。
* **記錄**：追蹤和計算所有執行的命令以符合合規性或除錯需求。
* **回饋**：當 Claude Code 產生不符合您程式碼庫慣例的程式碼時提供自動回饋。
* **自訂權限**：阻止對生產檔案或敏感目錄的修改。

透過將這些規則編碼為 hooks 而不是提示指令，您將建議轉換為應用程式層級的程式碼，每次預期執行時都會執行。

<Warning>
  您必須考慮新增 hooks 時的安全影響，因為 hooks 會在代理迴圈期間使用您當前環境的憑證自動執行。
  例如，惡意的 hooks 程式碼可能會洩露您的資料。在註冊 hooks 之前，請務必檢查您的 hooks 實作。

  有關完整的安全最佳實務，請參閱 hooks 參考文件中的[安全考量](/zh-TW/docs/claude-code/hooks#security-considerations)。
</Warning>

## Hook 事件概覽

Claude Code 提供幾個在工作流程不同時間點執行的 hook 事件：

* **PreToolUse**：在工具呼叫之前執行（可以阻止它們）
* **PostToolUse**：在工具呼叫完成後執行
* **UserPromptSubmit**：當使用者提交提示時執行，在 Claude 處理之前
* **Notification**：當 Claude Code 發送通知時執行
* **Stop**：當 Claude Code 完成回應時執行
* **SubagentStop**：當子代理任務完成時執行
* **PreCompact**：在 Claude Code 即將執行壓縮操作之前執行
* **SessionStart**：當 Claude Code 開始新會話或恢復現有會話時執行
* **SessionEnd**：當 Claude Code 會話結束時執行

每個事件接收不同的資料，並可以以不同的方式控制 Claude 的行為。

## 快速開始

在這個快速開始中，您將新增一個記錄 Claude Code 執行的 shell 命令的 hook。

### 先決條件

安裝 `jq` 用於命令列中的 JSON 處理。

### 步驟 1：開啟 hooks 設定

執行 `/hooks` [斜線命令](/zh-TW/docs/claude-code/slash-commands) 並選擇 `PreToolUse` hook 事件。

`PreToolUse` hooks 在工具呼叫之前執行，可以阻止它們並向 Claude 提供關於如何做不同事情的回饋。

### 步驟 2：新增匹配器

選擇 `+ Add new matcher…` 以僅在 Bash 工具呼叫上執行您的 hook。

為匹配器輸入 `Bash`。

<Note>您可以使用 `*` 來匹配所有工具。</Note>

### 步驟 3：新增 hook

選擇 `+ Add new hook…` 並輸入此命令：

```bash  theme={null}
jq -r '"\(.tool_input.command) - \(.tool_input.description // "No description")"' >> ~/.claude/bash-command-log.txt
```

### 步驟 4：儲存您的設定

對於儲存位置，選擇 `User settings`，因為您正在記錄到您的主目錄。這個 hook 將適用於所有專案，而不僅僅是您當前的專案。

然後按 Esc 直到您返回到 REPL。您的 hook 現在已註冊！

### 步驟 5：驗證您的 hook

再次執行 `/hooks` 或檢查 `~/.claude/settings.json` 以查看您的設定：

```json  theme={null}
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '\"\\(.tool_input.command) - \\(.tool_input.description // \"No description\")\"' >> ~/.claude/bash-command-log.txt"
          }
        ]
      }
    ]
  }
}
```

### 步驟 6：測試您的 hook

要求 Claude 執行一個簡單的命令，如 `ls`，並檢查您的記錄檔案：

```bash  theme={null}
cat ~/.claude/bash-command-log.txt
```

您應該看到類似以下的條目：

```
ls - Lists files and directories
```

## 更多範例

<Note>
  有關完整的範例實作，請參閱我們公開程式碼庫中的 [bash 命令驗證器範例](https://github.com/anthropics/claude-code/blob/main/examples/hooks/bash_command_validator_example.py)。
</Note>

### 程式碼格式化 Hook

編輯後自動格式化 TypeScript 檔案：

```json  theme={null}
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | { read file_path; if echo \"$file_path\" | grep -q '\\.ts$'; then npx prettier --write \"$file_path\"; fi; }"
          }
        ]
      }
    ]
  }
}
```

### Markdown 格式化 Hook

自動修復 markdown 檔案中缺少的語言標籤和格式問題：

```json  theme={null}
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/markdown_formatter.py"
          }
        ]
      }
    ]
  }
}
```

使用此內容建立 `.claude/hooks/markdown_formatter.py`：

````python  theme={null}
#!/usr/bin/env python3
"""
Markdown formatter for Claude Code output.
Fixes missing language tags and spacing issues while preserving code content.
"""
import json
import sys
import re
import os

def detect_language(code):
    """Best-effort language detection from code content."""
    s = code.strip()
    
    # JSON detection
    if re.search(r'^\s*[{\[]', s):
        try:
            json.loads(s)
            return 'json'
        except:
            pass
    
    # Python detection
    if re.search(r'^\s*def\s+\w+\s*\(', s, re.M) or \
       re.search(r'^\s*(import|from)\s+\w+', s, re.M):
        return 'python'
    
    # JavaScript detection  
    if re.search(r'\b(function\s+\w+\s*\(|const\s+\w+\s*=)', s) or \
       re.search(r'=>|console\.(log|error)', s):
        return 'javascript'
    
    # Bash detection
    if re.search(r'^#!.*\b(bash|sh)\b', s, re.M) or \
       re.search(r'\b(if|then|fi|for|in|do|done)\b', s):
        return 'bash'
    
    # SQL detection
    if re.search(r'\b(SELECT|INSERT|UPDATE|DELETE|CREATE)\s+', s, re.I):
        return 'sql'
        
    return 'text'

def format_markdown(content):
    """Format markdown content with language detection."""
    # Fix unlabeled code fences
    def add_lang_to_fence(match):
        indent, info, body, closing = match.groups()
        if not info.strip():
            lang = detect_language(body)
            return f"{indent}```{lang}\n{body}{closing}\n"
        return match.group(0)
    
    fence_pattern = r'(?ms)^([ \t]{0,3})```([^\n]*)\n(.*?)(\n\1```)\s*$'
    content = re.sub(fence_pattern, add_lang_to_fence, content)
    
    # Fix excessive blank lines (only outside code fences)
    content = re.sub(r'\n{3,}', '\n\n', content)
    
    return content.rstrip() + '\n'

# Main execution
try:
    input_data = json.load(sys.stdin)
    file_path = input_data.get('tool_input', {}).get('file_path', '')
    
    if not file_path.endswith(('.md', '.mdx')):
        sys.exit(0)  # Not a markdown file
    
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        formatted = format_markdown(content)
        
        if formatted != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(formatted)
            print(f"✓ Fixed markdown formatting in {file_path}")
    
except Exception as e:
    print(f"Error formatting markdown: {e}", file=sys.stderr)
    sys.exit(1)
````

使腳本可執行：

```bash  theme={null}
chmod +x .claude/hooks/markdown_formatter.py
```

此 hook 自動：

* 檢測未標記程式碼區塊中的程式語言
* 為語法高亮新增適當的語言標籤
* 修復過多的空白行同時保留程式碼內容
* 僅處理 markdown 檔案（`.md`、`.mdx`）

### 自訂通知 Hook

當 Claude 需要輸入時獲得桌面通知：

```json  theme={null}
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "notify-send 'Claude Code' 'Awaiting your input'"
          }
        ]
      }
    ]
  }
}
```

### 檔案保護 Hook

阻止對敏感檔案的編輯：

```json  theme={null}
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "python3 -c \"import json, sys; data=json.load(sys.stdin); path=data.get('tool_input',{}).get('file_path',''); sys.exit(2 if any(p in path for p in ['.env', 'package-lock.json', '.git/']) else 0)\""
          }
        ]
      }
    ]
  }
}
```

## 了解更多

* 有關 hooks 的參考文件，請參閱 [Hooks 參考](/zh-TW/docs/claude-code/hooks)。
* 有關全面的安全最佳實務和安全指南，請參閱 hooks 參考文件中的[安全考量](/zh-TW/docs/claude-code/hooks#security-considerations)。
* 有關故障排除步驟和除錯技術，請參閱 hooks 參考文件中的[除錯](/zh-TW/docs/claude-code/hooks#debugging)。

