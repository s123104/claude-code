---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/data-usage.md"
fetched_at: "2025-10-29T14:10:11+08:00"
---

# 資料使用

> 了解 Anthropic 對 Claude 的資料使用政策

## 資料政策

### 資料訓練政策

**消費者使用者（免費、Pro 和 Max 方案）**：
從 2025 年 8 月 28 日開始，我們給予您選擇是否允許您的資料用於改進未來 Claude 模型的權利。

當此設定開啟時，我們將使用來自免費、Pro 和 Max 帳戶的資料來訓練新模型（包括當您從這些帳戶使用 Claude Code 時）。

* 如果您是現有使用者，您現在可以選擇您的偏好設定，您的選擇將立即生效。
  此設定僅適用於 Claude 上的新聊天或已恢復的聊天和編碼工作階段。沒有額外活動的先前聊天將不會用於模型訓練。
* 您有到 2025 年 10 月 8 日的時間來進行選擇。
  如果您是新使用者，您可以在註冊過程中選擇您的模型訓練設定。
  您可以隨時在隱私設定中更改您的選擇。

**商業使用者**：（Team 和 Enterprise 方案、API、第三方平台和 Claude Gov）維持現有政策：除非客戶選擇向我們提供其資料以改進模型（例如 [Developer Partner Program](https://support.claude.com/en/articles/11174108-about-the-development-partner-program)），否則 Anthropic 不會使用在商業條款下發送至 Claude Code 的程式碼或提示來訓練生成模型。

### Development Partner Program

如果您明確選擇加入向我們提供訓練材料的方法，例如透過 [Development Partner Program](https://support.claude.com/en/articles/11174108-about-the-development-partner-program)，我們可能會使用所提供的材料來訓練我們的模型。組織管理員可以明確選擇為其組織加入 Development Partner Program。請注意，此計畫僅適用於 Anthropic 第一方 API，不適用於 Bedrock 或 Vertex 使用者。

### 使用 `/bug` 命令的回饋

如果您選擇使用 `/bug` 命令向我們發送有關 Claude Code 的回饋，我們可能會使用您的回饋來改進我們的產品和服務。透過 `/bug` 共享的文字記錄將保留 5 年。

### 工作階段品質調查

當您在 Claude Code 中看到「Claude 在此工作階段中表現如何？」提示時，回應此調查（包括選擇「關閉」），只會記錄您的數字評分（1、2、3 或關閉）。我們不會收集或儲存任何對話文字記錄、輸入、輸出或其他工作階段資料作為此調查的一部分。與豎起大拇指/向下大拇指回饋或 `/bug` 報告不同，此工作階段品質調查是一個簡單的產品滿意度指標。您對此調查的回應不會影響您的資料訓練偏好設定，也不能用於訓練我們的 AI 模型。

### 資料保留

Anthropic 根據您的帳戶類型和偏好設定保留 Claude Code 資料。

**消費者使用者（免費、Pro 和 Max 方案）**：

* 允許資料用於模型改進的使用者：5 年保留期以支持模型開發和安全改進
* 不允許資料用於模型改進的使用者：30 天保留期
* 隱私設定可以隨時在 [claude.ai/settings/data-privacy-controls](claude.ai/settings/data-privacy-controls) 更改。

**商業使用者（Team、Enterprise 和 API）**：

* 標準：30 天保留期
* 零資料保留：可透過適當配置的 API 金鑰取得 - Claude Code 不會在伺服器上保留聊天文字記錄
* 本機快取：Claude Code 用戶端可能會在本機儲存工作階段長達 30 天以啟用工作階段恢復（可配置）

在我們的 [Privacy Center](https://privacy.anthropic.com/) 中了解更多有關資料保留實踐的資訊。

如需完整詳細資訊，請查閱我們的 [Commercial Terms of Service](https://www.anthropic.com/legal/commercial-terms)（適用於 Team、Enterprise 和 API 使用者）或 [Consumer Terms](https://www.anthropic.com/legal/consumer-terms)（適用於免費、Pro 和 Max 使用者）和 [Privacy Policy](https://www.anthropic.com/legal/privacy)。

## 資料流和依賴項

<img src="https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=4b30069d702719e7bfb974eaaafab21c" alt="Claude Code 資料流圖表" data-og-width="1597" width="1597" data-og-height="1285" height="1285" data-path="images/claude-code-data-flow.png" data-optimize="true" data-opv="3" srcset="https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?w=280&fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=067676caa12f89051cb193e6b3f7d0a0 280w, https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?w=560&fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=5506197deff927f54f2fb5a349f358a8 560w, https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?w=840&fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=bb4febe7974dde5b76b88744f89ab472 840w, https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?w=1100&fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=b51af3074f87b33ccc342aaad655dcbf 1100w, https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?w=1650&fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=8fd96f1dde615877d4e4bbe1874af12d 1650w, https://mintcdn.com/anthropic-claude-docs/LF5WV0SNF6oudpT5/images/claude-code-data-flow.png?w=2500&fit=max&auto=format&n=LF5WV0SNF6oudpT5&q=85&s=056deded541ec30e9b67a67d620f6aaf 2500w" />

Claude Code 從 [NPM](https://www.npmjs.com/package/@anthropic-ai/claude-code) 安裝。Claude Code 在本機執行。為了與 LLM 互動，Claude Code 透過網路發送資料。此資料包括所有使用者提示和模型輸出。資料在傳輸中透過 TLS 加密，在靜止時未加密。Claude Code 與大多數流行的 VPN 和 LLM 代理相容。

Claude Code 建立在 Anthropic 的 API 上。有關我們 API 的安全控制的詳細資訊，包括我們的 API 記錄程序，請參閱 [Anthropic Trust Center](https://trust.anthropic.com) 中提供的合規性文件。

### 雲端執行

<Note>
  上述資料流圖表和描述適用於在您的機器上本機執行的 Claude Code CLI。對於使用 Claude Code 網頁版的雲端工作階段，請參閱下面的部分。
</Note>

使用 [Claude Code 網頁版](/zh-TW/docs/claude-code/claude-code-on-the-web) 時，工作階段在 Anthropic 管理的虛擬機器中執行，而不是在本機執行。在雲端環境中：

* **程式碼儲存**：您的儲存庫被複製到隔離的 VM，並在工作階段完成後自動刪除
* **認證**：GitHub 認證透過安全代理處理；您的 GitHub 認證永遠不會進入沙箱
* **網路流量**：所有出站流量都透過安全代理進行審計記錄和濫用防止
* **資料保留**：程式碼和工作階段資料受您帳戶類型的保留和使用政策約束
* **工作階段資料**：提示、程式碼變更和輸出遵循與本機 Claude Code 使用相同的資料政策

有關雲端執行的安全詳細資訊，請參閱 [Security](/zh-TW/docs/claude-code/security#cloud-execution-security)。

## 遙測服務

Claude Code 從使用者的機器連接到 Statsig 服務以記錄操作指標，例如延遲、可靠性和使用模式。此記錄不包括任何程式碼或檔案路徑。資料在傳輸中使用 TLS 加密，在靜止時使用 256 位 AES 加密。在 [Statsig 安全文件](https://www.statsig.com/trust/security) 中閱讀更多資訊。若要選擇不使用 Statsig 遙測，請設定 `DISABLE_TELEMETRY` 環境變數。

Claude Code 從使用者的機器連接到 Sentry 以進行操作錯誤記錄。資料在傳輸中使用 TLS 加密，在靜止時使用 256 位 AES 加密。在 [Sentry 安全文件](https://sentry.io/security/) 中閱讀更多資訊。若要選擇不進行錯誤記錄，請設定 `DISABLE_ERROR_REPORTING` 環境變數。

當使用者執行 `/bug` 命令時，其完整對話歷史記錄（包括程式碼）的副本會發送到 Anthropic。資料在傳輸中和靜止時都會加密。可選地，在我們的公開儲存庫中建立 Github 問題。若要選擇不進行錯誤報告，請設定 `DISABLE_BUG_COMMAND` 環境變數。

## 按 API 提供者的預設行為

使用 Bedrock 或 Vertex 時，我們預設會停用所有非必要流量（包括錯誤報告、遙測和錯誤報告功能）。您也可以透過設定 `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` 環境變數一次選擇不使用所有這些。以下是完整的預設行為：

| 服務                        | Claude API                                  | Vertex API                                 | Bedrock API                                 |
| ------------------------- | ------------------------------------------- | ------------------------------------------ | ------------------------------------------- |
| **Statsig（指標）**           | 預設開啟。<br />`DISABLE_TELEMETRY=1` 以停用。       | 預設關閉。<br />`CLAUDE_CODE_USE_VERTEX` 必須為 1。 | 預設關閉。<br />`CLAUDE_CODE_USE_BEDROCK` 必須為 1。 |
| **Sentry（錯誤）**            | 預設開啟。<br />`DISABLE_ERROR_REPORTING=1` 以停用。 | 預設關閉。<br />`CLAUDE_CODE_USE_VERTEX` 必須為 1。 | 預設關閉。<br />`CLAUDE_CODE_USE_BEDROCK` 必須為 1。 |
| **Claude API（`/bug` 報告）** | 預設開啟。<br />`DISABLE_BUG_COMMAND=1` 以停用。     | 預設關閉。<br />`CLAUDE_CODE_USE_VERTEX` 必須為 1。 | 預設關閉。<br />`CLAUDE_CODE_USE_BEDROCK` 必須為 1。 |

所有環境變數都可以簽入 `settings.json`（[閱讀更多](/zh-TW/docs/claude-code/settings)）。

