---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/cli-reference.md"
fetched_at: "2025-10-29T14:09:46+08:00"
---

# CLI 參考

> Claude Code 命令列介面的完整參考，包括命令和標誌。

## CLI 命令

| 命令                                 | 描述                  | 範例                                                     |
| :--------------------------------- | :------------------ | :----------------------------------------------------- |
| `claude`                           | 啟動互動式 REPL          | `claude`                                               |
| `claude "query"`                   | 使用初始提示啟動 REPL       | `claude "explain this project"`                        |
| `claude -p "query"`                | 透過 SDK 查詢，然後退出      | `claude -p "explain this function"`                    |
| `cat file \| claude -p "query"`    | 處理管道內容              | `cat logs.txt \| claude -p "explain"`                  |
| `claude -c`                        | 繼續最近的對話             | `claude -c`                                            |
| `claude -c -p "query"`             | 透過 SDK 繼續           | `claude -c -p "Check for type errors"`                 |
| `claude -r "<session-id>" "query"` | 透過 ID 恢復會話          | `claude -r "abc123" "Finish this PR"`                  |
| `claude update`                    | 更新到最新版本             | `claude update`                                        |
| `claude mcp`                       | 配置模型上下文協定 (MCP) 伺服器 | 請參閱 [Claude Code MCP 文件](/zh-TW/docs/claude-code/mcp)。 |

## CLI 標誌

使用這些命令列標誌自訂 Claude Code 的行為：

| 標誌                               | 描述                                                                            | 範例                                                                                                 |
| :------------------------------- | :---------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------- |
| `--add-dir`                      | 新增額外的工作目錄供 Claude 存取（驗證每個路徑是否存在為目錄）                                           | `claude --add-dir ../apps ../lib`                                                                  |
| `--agents`                       | 透過 JSON 動態定義自訂[子代理](/zh-TW/docs/claude-code/sub-agents)（格式請見下方）               | `claude --agents '{"reviewer":{"description":"Reviews code","prompt":"You are a code reviewer"}}'` |
| `--allowedTools`                 | 除了 [settings.json 檔案](/zh-TW/docs/claude-code/settings) 之外，應該允許而不提示使用者許可的工具清單 | `"Bash(git log:*)" "Bash(git diff:*)" "Read"`                                                      |
| `--disallowedTools`              | 除了 [settings.json 檔案](/zh-TW/docs/claude-code/settings) 之外，應該禁止而不提示使用者許可的工具清單 | `"Bash(git log:*)" "Bash(git diff:*)" "Edit"`                                                      |
| `--print`, `-p`                  | 列印回應而不使用互動模式（程式化使用詳情請參閱 [SDK 文件](/zh-TW/docs/claude-code/sdk)）                | `claude -p "query"`                                                                                |
| `--append-system-prompt`         | 附加到系統提示（僅與 `--print` 一起使用）                                                    | `claude --append-system-prompt "Custom instruction"`                                               |
| `--output-format`                | 指定列印模式的輸出格式（選項：`text`、`json`、`stream-json`）                                   | `claude -p "query" --output-format json`                                                           |
| `--input-format`                 | 指定列印模式的輸入格式（選項：`text`、`stream-json`）                                          | `claude -p --output-format json --input-format stream-json`                                        |
| `--include-partial-messages`     | 在輸出中包含部分串流事件（需要 `--print` 和 `--output-format=stream-json`）                    | `claude -p --output-format stream-json --include-partial-messages "query"`                         |
| `--verbose`                      | 啟用詳細記錄，顯示完整的回合輸出（在列印和互動模式中對除錯都很有幫助）                                           | `claude --verbose`                                                                                 |
| `--max-turns`                    | 限制非互動模式中的代理回合數                                                                | `claude -p --max-turns 3 "query"`                                                                  |
| `--model`                        | 使用最新模型的別名（`sonnet` 或 `opus`）或模型的完整名稱設定目前會話的模型                                 | `claude --model claude-sonnet-4-5-20250929`                                                        |
| `--permission-mode`              | 以指定的[許可模式](iam#permission-modes)開始                                            | `claude --permission-mode plan`                                                                    |
| `--permission-prompt-tool`       | 指定 MCP 工具在非互動模式中處理許可提示                                                        | `claude -p --permission-prompt-tool mcp_auth_tool "query"`                                         |
| `--resume`                       | 透過 ID 恢復特定會話，或在互動模式中選擇                                                        | `claude --resume abc123 "query"`                                                                   |
| `--continue`                     | 載入目前目錄中最近的對話                                                                  | `claude --continue`                                                                                |
| `--dangerously-skip-permissions` | 跳過許可提示（請謹慎使用）                                                                 | `claude --dangerously-skip-permissions`                                                            |

<Tip>
  `--output-format json` 標誌對於腳本和自動化特別有用，允許您以程式化方式解析 Claude 的回應。
</Tip>

### 代理標誌格式

`--agents` 標誌接受定義一個或多個自訂子代理的 JSON 物件。每個子代理需要一個唯一名稱（作為鍵）和一個包含以下欄位的定義物件：

| 欄位            | 必需 | 描述                                                         |
| :------------ | :- | :--------------------------------------------------------- |
| `description` | 是  | 何時應該呼叫子代理的自然語言描述                                           |
| `prompt`      | 是  | 指導子代理行為的系統提示                                               |
| `tools`       | 否  | 子代理可以使用的特定工具陣列（例如，`["Read", "Edit", "Bash"]`）。如果省略，則繼承所有工具 |
| `model`       | 否  | 要使用的模型別名：`sonnet`、`opus` 或 `haiku`。如果省略，則使用預設子代理模型         |

範例：

```bash  theme={null}
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer. Focus on code quality, security, and best practices.",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  },
  "debugger": {
    "description": "Debugging specialist for errors and test failures.",
    "prompt": "You are an expert debugger. Analyze errors, identify root causes, and provide fixes."
  }
}'
```

有關建立和使用子代理的更多詳情，請參閱[子代理文件](/zh-TW/docs/claude-code/sub-agents)。

有關列印模式（`-p`）的詳細資訊，包括輸出格式、串流、詳細記錄和程式化使用，請參閱 [SDK 文件](/zh-TW/docs/claude-code/sdk)。

## 另請參閱

* [互動模式](/zh-TW/docs/claude-code/interactive-mode) - 快捷鍵、輸入模式和互動功能
* [斜線命令](/zh-TW/docs/claude-code/slash-commands) - 互動會話命令
* [快速入門指南](/zh-TW/docs/claude-code/quickstart) - Claude Code 入門
* [常見工作流程](/zh-TW/docs/claude-code/common-workflows) - 進階工作流程和模式
* [設定](/zh-TW/docs/claude-code/settings) - 配置選項
* [SDK 文件](/zh-TW/docs/claude-code/sdk) - 程式化使用和整合

