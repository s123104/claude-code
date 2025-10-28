---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/statusline.md"
fetched_at: "2025-10-28T19:19:12+08:00"
---

# 狀態列配置

> 為 Claude Code 創建自定義狀態列以顯示上下文信息

使用自定義狀態列讓 Claude Code 成為您專屬的工具，該狀態列顯示在 Claude Code 界面底部，類似於 Oh-my-zsh 等 shell 中終端提示符 (PS1) 的工作方式。

## 創建自定義狀態列

您可以選擇：

* 運行 `/statusline` 讓 Claude Code 幫助您設置自定義狀態列。默認情況下，它會嘗試重現您終端的提示符，但您可以向 Claude Code 提供關於所需行為的額外指令，例如 `/statusline show the model name in orange`

* 直接在您的 `.claude/settings.json` 中添加 `statusLine` 命令：

```json  theme={null}
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0 // 可選：設置為 0 讓狀態列延伸到邊緣
  }
}
```

## 工作原理

* 狀態列在對話消息更新時更新
* 更新最多每 300ms 運行一次
* 您命令的 stdout 第一行成為狀態列文本
* 支持 ANSI 顏色代碼來設置狀態列樣式
* Claude Code 通過 stdin 將當前會話的上下文信息（模型、目錄等）作為 JSON 傳遞給您的腳本

## JSON 輸入結構

您的狀態列命令通過 stdin 接收 JSON 格式的結構化數據：

```json  theme={null}
{
  "hook_event_name": "Status",
  "session_id": "abc123...",
  "transcript_path": "/path/to/transcript.json",
  "cwd": "/current/working/directory",
  "model": {
    "id": "claude-opus-4-1",
    "display_name": "Opus"
  },
  "workspace": {
    "current_dir": "/current/working/directory",
    "project_dir": "/original/project/directory"
  },
  "version": "1.0.80",
  "output_style": {
    "name": "default"
  },
  "cost": {
    "total_cost_usd": 0.01234,
    "total_duration_ms": 45000,
    "total_api_duration_ms": 2300,
    "total_lines_added": 156,
    "total_lines_removed": 23
  }
}
```

## 示例腳本

### 簡單狀態列

```bash  theme={null}
#!/bin/bash
# 從 stdin 讀取 JSON 輸入
input=$(cat)

# 使用 jq 提取值
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')

echo "[$MODEL_DISPLAY] 📁 ${CURRENT_DIR##*/}"
```

### Git 感知狀態列

```bash  theme={null}
#!/bin/bash
# 從 stdin 讀取 JSON 輸入
input=$(cat)

# 使用 jq 提取值
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')

# 如果在 git 倉庫中則顯示 git 分支
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        GIT_BRANCH=" | 🌿 $BRANCH"
    fi
fi

echo "[$MODEL_DISPLAY] 📁 ${CURRENT_DIR##*/}$GIT_BRANCH"
```

### Python 示例

```python  theme={null}
#!/usr/bin/env python3
import json
import sys
import os

# 從 stdin 讀取 JSON
data = json.load(sys.stdin)

# 提取值
model = data['model']['display_name']
current_dir = os.path.basename(data['workspace']['current_dir'])

# 檢查 git 分支
git_branch = ""
if os.path.exists('.git'):
    try:
        with open('.git/HEAD', 'r') as f:
            ref = f.read().strip()
            if ref.startswith('ref: refs/heads/'):
                git_branch = f" | 🌿 {ref.replace('ref: refs/heads/', '')}"
    except:
        pass

print(f"[{model}] 📁 {current_dir}{git_branch}")
```

### Node.js 示例

```javascript  theme={null}
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// 從 stdin 讀取 JSON
let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
    const data = JSON.parse(input);
    
    // 提取值
    const model = data.model.display_name;
    const currentDir = path.basename(data.workspace.current_dir);
    
    // 檢查 git 分支
    let gitBranch = '';
    try {
        const headContent = fs.readFileSync('.git/HEAD', 'utf8').trim();
        if (headContent.startsWith('ref: refs/heads/')) {
            gitBranch = ` | 🌿 ${headContent.replace('ref: refs/heads/', '')}`;
        }
    } catch (e) {
        // 不是 git 倉庫或無法讀取 HEAD
    }
    
    console.log(`[${model}] 📁 ${currentDir}${gitBranch}`);
});
```

### 輔助函數方法

對於更複雜的 bash 腳本，您可以創建輔助函數：

```bash  theme={null}
#!/bin/bash
# 一次性讀取 JSON 輸入
input=$(cat)

# 常見提取的輔助函數
get_model_name() { echo "$input" | jq -r '.model.display_name'; }
get_current_dir() { echo "$input" | jq -r '.workspace.current_dir'; }
get_project_dir() { echo "$input" | jq -r '.workspace.project_dir'; }
get_version() { echo "$input" | jq -r '.version'; }
get_cost() { echo "$input" | jq -r '.cost.total_cost_usd'; }
get_duration() { echo "$input" | jq -r '.cost.total_duration_ms'; }
get_lines_added() { echo "$input" | jq -r '.cost.total_lines_added'; }
get_lines_removed() { echo "$input" | jq -r '.cost.total_lines_removed'; }

# 使用輔助函數
MODEL=$(get_model_name)
DIR=$(get_current_dir)
echo "[$MODEL] 📁 ${DIR##*/}"
```

## 提示

* 保持狀態列簡潔 - 它應該適合一行
* 使用表情符號（如果您的終端支持）和顏色使信息易於掃描
* 在 Bash 中使用 `jq` 進行 JSON 解析（參見上面的示例）
* 通過使用模擬 JSON 輸入手動運行來測試您的腳本：`echo '{"model":{"display_name":"Test"},"workspace":{"current_dir":"/test"}}' | ./statusline.sh`
* 如果需要，考慮緩存昂貴的操作（如 git status）

## 故障排除

* 如果您的狀態列沒有出現，檢查您的腳本是否可執行（`chmod +x`）
* 確保您的腳本輸出到 stdout（而不是 stderr）

