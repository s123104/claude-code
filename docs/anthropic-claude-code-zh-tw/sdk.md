---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/sdk"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/sdk)

Claude Code SDK 能夠將 Claude Code 作為子程序運行，提供了一種構建 AI 驅動的編程助手和工具的方式，利用 Claude 的能力。

SDK 可用於命令列、TypeScript 和 Python 使用。

## 身份驗證

Claude Code SDK 支援多種身份驗證方法：

### Anthropic API 金鑰

要直接使用 Anthropic 的 API 來使用 Claude Code SDK，我們建議創建一個專用的 API 金鑰：

1. 在 [Anthropic Console](https://console.anthropic.com/) 中創建一個 Anthropic API 金鑰
2. 然後，設定 `ANTHROPIC_API_KEY` 環境變數。我們建議安全地儲存此金鑰（例如，使用 Github [secret](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)）

### 第三方 API 憑證

SDK 也支援第三方 API 提供商：

- **Amazon Bedrock**：設定 `CLAUDE_CODE_USE_BEDROCK=1` 環境變數並配置 AWS 憑證
- **Google Vertex AI**：設定 `CLAUDE_CODE_USE_VERTEX=1` 環境變數並配置 Google Cloud 憑證

有關第三方提供商的詳細配置說明，請參閱 [Amazon Bedrock](/zh-TW/docs/claude-code/amazon-bedrock) 和 [Google Vertex AI](/zh-TW/docs/claude-code/google-vertex-ai) 文件。

Claude Code SDK 允許您在應用程式中以非互動模式使用 Claude Code。

### 命令列

以下是命令列 SDK 的一些基本範例：

### TypeScript

TypeScript SDK 包含在 NPM 上的主要 [`@anthropic-ai/claude-code`](https://www.npmjs.com/package/@anthropic-ai/claude-code) 套件中：

TypeScript SDK 接受命令列 SDK 支援的所有參數，以及：

| 參數                         | 描述                         | 預設值                                            |
| ---------------------------- | ---------------------------- | ------------------------------------------------- |
| `abortController`            | 中止控制器                   | `new AbortController()`                           |
| `cwd`                        | 當前工作目錄                 | `process.cwd()`                                   |
| `executable`                 | 要使用的 JavaScript 執行時間 | 使用 Node.js 時為 `node`，使用 Bun 時為 `bun`     |
| `executableArgs`             | 傳遞給可執行檔的參數         | `[]`                                              |
| `pathToClaudeCodeExecutable` | Claude Code 可執行檔的路徑   | 與 `@anthropic-ai/claude-code` 一起提供的可執行檔 |

### Python

Python SDK 在 PyPI 上以 [`claude-code-sdk`](https://github.com/anthropics/claude-code-sdk-python) 的形式提供：

**先決條件：**

- Python 3.10+
- Node.js
- Claude Code CLI：`npm install -g @anthropic-ai/claude-code`

基本使用：

Python SDK 透過 `ClaudeCodeOptions` 類別接受命令列 SDK 支援的所有參數：

## 進階使用

以下文件使用命令列 SDK 作為範例，但也可以與 TypeScript 和 Python SDK 一起使用。

### 多輪對話

對於多輪對話，您可以恢復對話或從最近的會話繼續：

### 自訂系統提示

您可以提供自訂系統提示來指導 Claude 的行為：

您也可以將指令附加到預設系統提示：

### MCP 配置

模型上下文協定（MCP）允許您使用來自外部伺服器的額外工具和資源來擴展 Claude Code。使用 `--mcp-config` 標誌，您可以載入提供專門功能的 MCP 伺服器，如資料庫存取、API 整合或自訂工具。

使用您的 MCP 伺服器創建 JSON 配置檔案：

然後與 Claude Code 一起使用：

### 自訂權限提示工具

可選地，使用 `--permission-prompt-tool` 傳入一個 MCP 工具，我們將使用它來檢查使用者是否授予模型調用給定工具的權限。當模型調用工具時會發生以下情況：

1. 我們首先檢查權限設定：所有 [settings.json 檔案](/zh-TW/docs/claude-code/settings)，以及傳入 SDK 的 `--allowedTools` 和 `--disallowedTools`；如果其中一個允許或拒絕工具調用，我們就繼續進行工具調用
2. 否則，我們調用您在 `--permission-prompt-tool` 中提供的 MCP 工具

`--permission-prompt-tool` MCP 工具會接收工具名稱和輸入，並且必須返回一個帶有結果的 JSON 字串化載荷。載荷必須是以下之一：

例如，TypeScript MCP 權限提示工具實作可能如下所示：

要使用此工具，請新增您的 MCP 伺服器（例如使用 `--mcp-config`），然後像這樣調用 SDK：

使用注意事項：

- 使用 `updatedInput` 告訴模型權限提示改變了其輸入；否則，將 `updatedInput` 設定為原始輸入，如上面的範例所示。例如，如果工具向使用者顯示檔案編輯差異並讓他們手動編輯差異，權限提示工具應該返回該更新的編輯。
- 載荷必須是 JSON 字串化的

## 可用的 CLI 選項

SDK 利用 Claude Code 中可用的所有 CLI 選項。以下是 SDK 使用的關鍵選項：

| 標誌                       | 描述                                                      | 範例                                                                                                           |
| -------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `--print`, `-p`            | 在非互動模式中運行                                        | `claude -p "query"`                                                                                            |
| `--output-format`          | 指定輸出格式（`text`、`json`、`stream-json`）             | `claude -p --output-format json`                                                                               |
| `--resume`, `-r`           | 透過會話 ID 恢復對話                                      | `claude --resume abc123`                                                                                       |
| `--continue`, `-c`         | 繼續最近的對話                                            | `claude --continue`                                                                                            |
| `--verbose`                | 啟用詳細記錄                                              | `claude --verbose`                                                                                             |
| `--max-turns`              | 在非互動模式中限制代理輪次                                | `claude --max-turns 3`                                                                                         |
| `--system-prompt`          | 覆蓋系統提示（僅適用於 `--print`）                        | `claude --system-prompt "Custom instruction"`                                                                  |
| `--append-system-prompt`   | 附加到系統提示（僅適用於 `--print`）                      | `claude --append-system-prompt "Custom instruction"`                                                           |
| `--allowedTools`           | 以空格分隔的允許工具清單，或 以逗號分隔的允許工具字串清單 | `claude --allowedTools mcp__slack mcp__filesystem` `claude --allowedTools "Bash(npm install),mcp__filesystem"` |
| `--disallowedTools`        | 以空格分隔的拒絕工具清單，或 以逗號分隔的拒絕工具字串清單 | `claude --disallowedTools mcp__splunk mcp__github` `claude --disallowedTools "Bash(git commit),mcp__github"`   |
| `--mcp-config`             | 從 JSON 檔案載入 MCP 伺服器                               | `claude --mcp-config servers.json`                                                                             |
| `--permission-prompt-tool` | 用於處理權限提示的 MCP 工具（僅適用於 `--print`）         | `claude --permission-prompt-tool mcp__auth__prompt`                                                            |

有關 CLI 選項和功能的完整清單，請參閱 [CLI 參考](/zh-TW/docs/claude-code/cli-reference) 文件。

## 輸出格式

SDK 支援多種輸出格式：

### 文字輸出（預設）

僅返回回應文字：

### JSON 輸出

返回包含元資料的結構化資料：

回應格式：

### 串流 JSON 輸出

在接收時串流每個訊息：

每個對話都以初始的 `init` 系統訊息開始，接著是使用者和助手訊息清單，最後是帶有統計資料的最終 `result` 系統訊息。每個訊息都作為單獨的 JSON 物件發出。

## 訊息架構

從 JSON API 返回的訊息根據以下架構嚴格類型化：

我們很快會以 JSONSchema 相容格式發布這些類型。我們對主要 Claude Code 套件使用語義版本控制來傳達此格式的重大變更。

`Message` 和 `MessageParam` 類型在 Anthropic SDK 中可用。例如，請參閱 Anthropic [TypeScript](https://github.com/anthropics/anthropic-sdk-typescript) 和 [Python](https://github.com/anthropics/anthropic-sdk-python/) SDK。

## 輸入格式

SDK 支援多種輸入格式：

### 文字輸入（預設）

輸入文字可以作為參數提供：

或者輸入文字可以透過 stdin 管道傳輸：

### 串流 JSON 輸入

透過 `stdin` 提供的訊息串流，其中每個訊息代表一個使用者輪次。這允許多輪對話而無需重新啟動 `claude` 二進位檔案，並允許在模型處理請求時向模型提供指導。

每個訊息都是一個 JSON「使用者訊息」物件，遵循與輸出訊息架構相同的格式。訊息使用 [jsonl](https://jsonlines.org/) 格式格式化，其中每行輸入都是一個完整的 JSON 物件。串流 JSON 輸入需要 `-p` 和 `--output-format stream-json`。

目前這僅限於純文字使用者訊息。

## 範例

### 簡單腳本整合

### 使用 Claude 處理檔案

### 會話管理

## 最佳實務

1. **使用 JSON 輸出格式** 進行程式化解析回應：
2. **優雅地處理錯誤** - 檢查退出代碼和 stderr：
3. **使用會話管理** 在多輪對話中維護上下文
4. **考慮超時** 對於長時間運行的操作：
5. **尊重速率限制** 在進行多個請求時，透過在調用之間添加延遲

## 實際應用

Claude Code SDK 能夠與您的開發工作流程進行強大的整合。一個值得注意的範例是 [Claude Code GitHub Actions](/zh-TW/docs/claude-code/github-actions)，它使用 SDK 直接在您的 GitHub 工作流程中提供自動化程式碼審查、PR 創建和問題分類功能。

## 相關資源

- [CLI 使用和控制](/zh-TW/docs/claude-code/cli-reference) - 完整的 CLI 文件
- [GitHub Actions 整合](/zh-TW/docs/claude-code/github-actions) - 使用 Claude 自動化您的 GitHub 工作流程
- [常見工作流程](/zh-TW/docs/claude-code/common-workflows) - 常見用例的逐步指南
