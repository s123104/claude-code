---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/hooks-guide"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/hooks-guide)

Claude Code hooks 是使用者定義的 shell 命令，在 Claude Code 生命週期的各個階段執行。Hooks 提供對 Claude Code 行為的確定性控制，確保某些動作總是會發生，而不是依賴 LLM 選擇執行它們。

hooks 的範例使用案例包括：

- 通知
- 自動格式化
- 記錄
- 回饋
- 自訂權限

## Hook 事件概覽

- PreToolUse、PostToolUse、Notification、Stop、Subagent Stop

## 快速開始

安裝 jq → `/hooks` → 新增 Bash 匹配器 → 新增命令 → 儲存 → 測試。

## 更多範例

程式碼格式化、通知、檔案保護。

## 了解更多

參閱 [Hooks 參考](/zh-TW/docs/claude-code/hooks)。
