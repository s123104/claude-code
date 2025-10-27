# Claude Code CHANGELOG 高品質繁體中文翻譯

## 2.0.27

- 權限提示新增全新 UI 介面
- 會話恢復畫面新增當前分支篩選和搜尋功能，方便導航
- 修復目錄 @-提及導致「找不到助理訊息」錯誤的問題
- VSCode 擴充套件：新增設定選項，可在檔案搜尋中包含 .gitignore 的檔案
- VSCode 擴充套件：修復不相關的「Warmup」對話錯誤，以及設定偶爾被重置為預設值的問題

## 2.0.25

- 移除舊版 SDK 進入點。請遷移至 @anthropic-ai/claude-agent-sdk 以獲取未來的 SDK 更新：https://docs.claude.com/en/docs/claude-code/sdk/migration-guide

## 2.0.24

- 修復專案層級技能在指定 --setting-sources 'project' 時無法載入的錯誤
- Claude Code Web：支援 Web -> CLI 傳送
- 沙箱：在 Linux 和 Mac 上為 BashTool 發布沙箱模式

## 2.0.22

- 修復捲動斜線指令時的內容版面跳動問題
- IDE：新增啟用/停用思考的切換開關
- 修復平行工具呼叫時出現重複權限提示的錯誤
- 新增對企業管理的 MCP 允許清單和拒絕清單的支援

## 2.0.21

- 支援 MCP 工具回應中的 `structuredContent` 欄位
- 新增互動式問題工具
- Claude 現在在計劃模式下會更頻繁地向您提問
- Pro 使用者新增 Haiku 4.5 作為模型選項
- 修復佇列指令無法存取先前訊息輸出的問題

## 2.0.20

- 新增對 Claude Skills 的支援

## 2.0.19

- 長時間執行的 bash 指令現在會自動轉為背景執行，而非終止。可透過 BASH_DEFAULT_TIMEOUT_MS 自訂
- 修復列印模式下不必要地呼叫 Haiku 的錯誤

## 2.0.17

- 模型選擇器新增 Haiku 4.5！
- Haiku 4.5 在計劃模式自動使用 Sonnet，執行時使用 Haiku（即預設為 SonnetPlan）
- 第三方平台（Bedrock 和 Vertex）尚未自動升級。可透過設定 `ANTHROPIC_DEFAULT_HAIKU_MODEL` 手動升級
- 推出 Explore 子代理。由 Haiku 驅動，將有效搜尋您的程式碼庫以節省上下文！
- OTEL：支援 HTTP_PROXY 和 HTTPS_PROXY
- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` 現在會停用版本資訊取得

## 2.0.15

- 修復恢復時需要重新讀取先前建立的檔案才能寫入的錯誤
- 修復 `-p` 模式下需要重新讀取 @-提及的檔案才能寫入的錯誤

## 2.0.14

- 修復 @-提及 MCP 伺服器以切換開關的功能
- 改善帶有行內環境變數的 bash 權限檢查
- 修復 ultrathink + 思考切換
- 減少不必要的登入
- 新增 --system-prompt 文件
- 多項渲染改善
- 外掛 UI 優化

## 2.0.13

- 修復 `/plugin` 在原生建置版本無法運作的問題

## 2.0.12

- **外掛系統發布**：透過市集的自訂指令、代理、hooks 和 MCP 伺服器擴展 Claude Code
- `/plugin install`、`/plugin enable/disable`、`/plugin marketplace` 指令用於外掛管理
- 透過 `extraKnownMarketplaces` 進行儲存庫層級的外掛設定，以便團隊協作
- `/plugin validate` 指令用於驗證外掛結構和設定
- 外掛公告部落格文章：https://www.anthropic.com/news/claude-code-plugins
- 外掛文件：https://docs.claude.com/en/docs/claude-code/plugins
- 透過 `/doctor` 指令提供完整的錯誤訊息和診斷
- 避免 `/model` 選擇器閃爍
- `/help` 改善
- 避免在 `/resume` 摘要中提及 hooks
- `/config` 中的「verbose」設定變更現在會在會話間保持

## 2.0.11

- 系統提示大小減少 1.4k tokens
- IDE：修復鍵盤快捷鍵和焦點問題，提供更流暢的互動
- 修復 Opus 回退速率限制錯誤不正確顯示的問題
- 修復 /add-dir 指令選擇錯誤預設分頁的問題

## 2.0.10

- 重寫終端渲染器，提供極致流暢的 UI
- 透過 @-提及或在 /mcp 中啟用/停用 MCP 伺服器
- bash 模式下新增 shell 指令的 tab 自動完成
- PreToolUse hooks 現在可以修改工具輸入
- 按 Ctrl-G 在系統設定的文字編輯器中編輯提示
- 修復帶有環境變數的 bash 權限檢查

## 2.0.9

- 修復 bash 背景執行停止運作的問題

## 2.0.8

- 更新 Bedrock 預設 Sonnet 模型為 `global.anthropic.claude-sonnet-4-5-20250929-v1:0`
- IDE：聊天中新增檔案和資料夾的拖放支援
- /context：修復思考區塊的計數
- 改善深色終端上淺色主題使用者的訊息渲染
- 移除已棄用的 .claude.json 設定選項（allowedTools、ignorePatterns、env、todoFeatureEnabled），改為在 settings.json 中設定

## 2.0.5

- IDE：修復使用 Enter 和 Tab 時 IME 意外提交訊息的問題
- IDE：登入畫面新增「在終端開啟」連結
- 修復未處理的 OAuth 過期 401 API 錯誤
- SDK：新增 SDKUserMessageReplay.isReplay 以防止重複訊息

## 2.0.1

- Bedrock 和 Vertex 跳過 Sonnet 4.5 預設模型設定變更
- 各種錯誤修復和呈現改善

## 2.0.0

- 全新原生 VS Code 擴充套件
- 整個應用程式全新外觀
- /rewind 回退對話以撤銷程式碼變更
- /usage 指令查看計劃限制
- Tab 切換思考（跨會話保持）
- Ctrl-R 搜尋歷史記錄
- 未發布的 claude config 指令
- Hooks：減少 PostToolUse 的 'tool_use' id 找不到 'tool_result' 區塊的錯誤
- SDK：Claude Code SDK 現在是 Claude Agent SDK
- 使用 `--agents` 參數動態新增子代理

## 1.0.126

- 為 Bedrock 和 Vertex 啟用 /context 指令
- 為基於 HTTP 的 OpenTelemetry 匯出器新增 mTLS 支援

## 1.0.124

- 將 `CLAUDE_BASH_NO_LOGIN` 環境變數設為 1 或 true 以跳過 BashTool 的登入 shell
- 修復 Bedrock 和 Vertex 環境變數將所有字串評估為真值的問題
- 不再在權限被拒時通知 Claude 允許的工具清單
- 修復 Bash 工具權限檢查中的安全漏洞
- 改善 VSCode 擴充套件對大型檔案的效能

## 1.0.123

- Bash 權限規則現在在比對時支援輸出重導向（例如 `Bash(python:*)` 比對 `python script.py > output.txt`）
- 修復否定片語（如「don't think」）觸發思考模式的問題
- 修復 token 串流期間的渲染效能下降問題
- 新增 SlashCommand 工具，讓 Claude 可以調用您的斜線指令。https://docs.claude.com/en/docs/claude-code/slash-commands#SlashCommand-tool
- 增強 BashTool 環境快照記錄
- 修復在無頭模式下恢復對話有時會不必要地啟用思考的錯誤
- 將 --debug 記錄遷移到檔案，以便輕鬆追蹤和篩選

## 1.0.120

- 修復輸入時的延遲，在大型提示下特別明顯
- 改善 VSCode 擴充套件指令註冊和會話對話框使用者體驗
- 增強會話對話框回應能力和視覺回饋
- 透過移除工作樹支援檢查修復 IDE 相容性問題
- 修復可透過前綴比對繞過 Bash 工具權限檢查的安全漏洞

## 1.0.119

- 修復 Windows 上進入互動模式時程序視覺凍結的問題
- 透過 headersHelper 設定支援 MCP 伺服器的動態標頭
- 修復無頭會話中思考模式無法運作的問題
- 修復斜線指令現在正確更新允許的工具而非替換它們

## 1.0.117

- 新增 Ctrl-R 歷史記錄搜尋，像 bash/zsh 一樣回憶先前的指令
- 修復輸入時的延遲，尤其是在 Windows 上
- acceptEdits 模式下將 sed 指令新增到自動允許的指令
- 修復 Windows PATH 比較，使磁碟機代號不區分大小寫
- /add-dir 輸出新增權限管理提示

## 1.0.115

- 改善思考模式顯示，增強視覺效果
- 在提示中輸入 /t 暫時停用思考模式
- 改善 glob 和 grep 工具的路徑驗證
- 顯示工具後 hooks 的簡潔輸出以減少視覺混亂
- 修復載入狀態完成時的視覺回饋
- 改善權限請求對話框的 UI 一致性

**📅 最後更新時間**: 2025-10-27  
**📊 資料來源**: [GitHub CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)  
**🔄 翻譯方式**: 人工高品質翻譯
**📌 版本範圍**: 1.0.115 - 2.0.27（最新）

