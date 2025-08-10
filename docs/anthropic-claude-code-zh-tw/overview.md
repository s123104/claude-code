---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/overview"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/overview)

## 30 秒內開始使用

先決條件：[Node.js 18 或更新版本](https://nodejs.org/en/download/)

就是這樣！您已經準備好開始使用 Claude 編程了。[繼續快速入門（5 分鐘）→](/zh-TW/docs/claude-code/quickstart)

（有特定的設置需求或遇到問題？請參閱[高級設置](/zh-TW/docs/claude-code/setup)或[故障排除](/zh-TW/docs/claude-code/troubleshooting)。）

- **從描述構建功能**：用簡單的英語告訴 Claude 您想要構建什麼。它會制定計劃、編寫代碼並確保其正常工作。
- **調試和修復問題**：描述一個錯誤或粘貼錯誤消息。Claude Code 將分析您的代碼庫，識別問題並實施修復。
- **導航任何代碼庫**：詢問有關您團隊代碼庫的任何問題，並獲得深思熟慮的答案。Claude Code 保持對您整個項目結構的感知，可以從網絡上找到最新信息，並且通過 [MCP](/zh-TW/docs/claude-code/mcp) 可以從外部數據源（如 Google Drive、Figma 和 Slack）提取信息。
- **自動化繁瑣任務**：修復繁瑣的 lint 問題、解決合併衝突並編寫發布說明。在您的開發機器上通過單個命令完成所有這些，或在 CI 中自動完成。

## 為什麼開發者喜愛 Claude Code

- **在您的終端中工作**：不是另一個聊天窗口。不是另一個 IDE。Claude Code 在您已經工作的地方與您會面，使用您已經喜愛的工具。
- **採取行動**：Claude Code 可以直接編輯文件、運行命令並創建提交。需要更多？[MCP](/zh-TW/docs/claude-code/mcp) 讓 Claude 讀取您在 Google Drive 中的設計文檔、更新您在 Jira 中的工單，或使用\_您的\_自定義開發工具。
- **Unix 哲學**：Claude Code 是可組合和可腳本化的。`tail -f app.log | claude -p "如果您在此日誌流中看到任何異常出現，請通過 Slack 通知我"` 有效。您的 CI 可以運行 `claude -p "如果有新的文本字符串，請將它們翻譯成法語並為 @lang-fr-team 提出 PR 進行審查"`。
- **企業就緒**：使用 Anthropic 的 API，或在 AWS 或 GCP 上託管。企業級[安全性](/zh-TW/docs/claude-code/security)、[隱私](/zh-TW/docs/claude-code/data-usage)和[合規性](https://trust.anthropic.com/)是內置的。

## 下一步

## 其他資源

Was this page helpful?
