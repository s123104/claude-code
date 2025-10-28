---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/overview.md"
fetched_at: "2025-10-28T19:18:19+08:00"
---

# Claude Code 概覽

> 了解 Claude Code，Anthropic 的智能編程工具，它存在於您的終端中，幫助您比以往更快地將想法轉化為代碼。

## 30 秒內開始使用

先決條件：

* [Node.js 18 或更新版本](https://nodejs.org/en/download/)
* 一個 [Claude.ai](https://claude.ai)（推薦）或 [Claude Console](https://console.anthropic.com/) 帳戶

```bash  theme={null}
# 安裝 Claude Code
npm install -g @anthropic-ai/claude-code

# 導航到您的專案
cd your-awesome-project

# 開始使用 Claude 編程
claude
# 首次使用時會提示您登入
```

就是這樣！您已準備好開始使用 Claude 編程。[繼續快速入門（5 分鐘）→](/zh-TW/docs/claude-code/quickstart)

（有特定設定需求或遇到問題？請參閱[進階設定](/zh-TW/docs/claude-code/setup)或[故障排除](/zh-TW/docs/claude-code/troubleshooting)。）

<Note>
  **新的 VS Code 擴展（測試版）**：偏好圖形界面？我們新的 [VS Code 擴展](/zh-TW/docs/claude-code/vs-code)提供易於使用的原生 IDE 體驗，無需熟悉終端。只需從市場安裝並直接在側邊欄中開始使用 Claude 編程。
</Note>

## Claude Code 為您做什麼

* **從描述構建功能**：用簡單的英語告訴 Claude 您想要構建什麼。它會制定計劃、編寫代碼並確保其正常工作。
* **調試和修復問題**：描述錯誤或粘貼錯誤訊息。Claude Code 將分析您的代碼庫，識別問題並實施修復。
* **導航任何代碼庫**：詢問有關您團隊代碼庫的任何問題，並獲得周到的回答。Claude Code 保持對您整個專案結構的認知，可以從網路找到最新資訊，並且通過 [MCP](/zh-TW/docs/claude-code/mcp) 可以從外部數據源如 Google Drive、Figma 和 Slack 提取資訊。
* **自動化繁瑣任務**：修復複雜的 lint 問題、解決合併衝突並編寫發布說明。在您的開發機器上通過單個命令完成所有這些，或在 CI 中自動完成。

## 為什麼開發者喜愛 Claude Code

* **在您的終端中工作**：不是另一個聊天視窗。不是另一個 IDE。Claude Code 在您已經工作的地方與您會面，使用您已經喜愛的工具。
* **採取行動**：Claude Code 可以直接編輯檔案、運行命令並創建提交。需要更多？[MCP](/zh-TW/docs/claude-code/mcp) 讓 Claude 讀取您在 Google Drive 中的設計文檔、更新您在 Jira 中的票據，或使用您的自定義開發工具。
* **Unix 哲學**：Claude Code 是可組合和可腳本化的。`tail -f app.log | claude -p "如果您在此日誌流中看到任何異常，請通過 Slack 通知我"` 是有效的。您的 CI 可以運行 `claude -p "如果有新的文本字符串，將它們翻譯成法語並為 @lang-fr-team 提出 PR 以供審查"`。
* **企業就緒**：使用 Claude API，或在 AWS 或 GCP 上託管。企業級[安全性](/zh-TW/docs/claude-code/security)、[隱私](/zh-TW/docs/claude-code/data-usage)和[合規性](https://trust.anthropic.com/)是內建的。

## 下一步

<CardGroup>
  <Card title="快速入門" icon="rocket" href="/zh-TW/docs/claude-code/quickstart">
    通過實際範例查看 Claude Code 的實際應用
  </Card>

  <Card title="常見工作流程" icon="graduation-cap" href="/zh-TW/docs/claude-code/common-workflows">
    常見工作流程的逐步指南
  </Card>

  <Card title="故障排除" icon="wrench" href="/zh-TW/docs/claude-code/troubleshooting">
    Claude Code 常見問題的解決方案
  </Card>

  <Card title="IDE 設定" icon="laptop" href="/zh-TW/docs/claude-code/ide-integrations">
    將 Claude Code 添加到您的 IDE
  </Card>
</CardGroup>

## 其他資源

<CardGroup>
  <Card title="在 AWS 或 GCP 上託管" icon="cloud" href="/zh-TW/docs/claude-code/third-party-integrations">
    使用 Amazon Bedrock 或 Google Vertex AI 配置 Claude Code
  </Card>

  <Card title="設定" icon="gear" href="/zh-TW/docs/claude-code/settings">
    為您的工作流程自定義 Claude Code
  </Card>

  <Card title="命令" icon="terminal" href="/zh-TW/docs/claude-code/cli-reference">
    了解 CLI 命令和控制
  </Card>

  <Card title="參考實現" icon="code" href="https://github.com/anthropics/claude-code/tree/main/.devcontainer">
    克隆我們的開發容器參考實現
  </Card>

  <Card title="安全性" icon="shield" href="/zh-TW/docs/claude-code/security">
    發現 Claude Code 的安全保障和安全使用最佳實踐
  </Card>

  <Card title="隱私和數據使用" icon="lock" href="/zh-TW/docs/claude-code/data-usage">
    了解 Claude Code 如何處理您的數據
  </Card>
</CardGroup>

