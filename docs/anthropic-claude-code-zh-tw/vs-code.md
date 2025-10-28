---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/vs-code.md"
fetched_at: "2025-10-28T19:20:11+08:00"
---

# Visual Studio Code

> 透過我們的原生擴充功能或 CLI 整合在 Visual Studio Code 中使用 Claude Code

<img src="https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=600835067c8b03557a0529978e3f0261" alt="Claude Code VS Code 擴充功能介面" data-og-width="2500" width="2500" data-og-height="1155" height="1155" data-path="images/vs-code-extension-interface.jpg" data-optimize="true" data-opv="3" srcset="https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?w=280&fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=c11a25932f84ca58124a368156b476d2 280w, https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?w=560&fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=3642697ed4d8a6c02396c403bf7aae44 560w, https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?w=840&fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=fb3cb16e752060fbeb0f5e8ba775798b 840w, https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?w=1100&fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=1c6073edc8fcfcbc8e237cbf5f25cdc6 1100w, https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?w=1650&fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=152628678fe3301018b79e932706c430 1650w, https://mintcdn.com/anthropic-claude-docs/Xfpgr-ckk38MZnw3/images/vs-code-extension-interface.jpg?w=2500&fit=max&auto=format&n=Xfpgr-ckk38MZnw3&q=85&s=7ac83b2db00366c9a745380571a748ab 2500w" />

## VS Code 擴充功能（測試版）

VS Code 擴充功能現已推出測試版，讓您透過整合在 IDE 中的原生圖形介面即時查看 Claude 的變更。VS Code 擴充功能使偏好使用視覺介面而非終端的使用者更容易存取和互動 Claude Code。

### 功能

VS Code 擴充功能提供：

* **原生 IDE 體驗**：透過 Spark 圖示存取的專用 Claude Code 側邊欄面板
* **計畫模式與編輯**：在接受前檢視和編輯 Claude 的計畫
* **自動接受編輯模式**：在 Claude 進行變更時自動套用
* **檔案管理**：使用 @-mention 檔案或透過系統檔案選擇器附加檔案和影像
* **MCP 伺服器使用**：使用透過 CLI 設定的 Model Context Protocol 伺服器
* **對話歷史**：輕鬆存取過去的對話
* **多個工作階段**：同時執行多個 Claude Code 工作階段
* **鍵盤快捷鍵**：支援 CLI 中的大多數快捷鍵
* **斜線命令**：直接在擴充功能中存取大多數 CLI 斜線命令

### 需求

* VS Code 1.98.0 或更高版本

### 安裝

從 [Visual Studio Code 擴充功能市集](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code) 下載並安裝擴充功能。

### 運作方式

安裝後，您可以透過 VS Code 介面開始使用 Claude Code：

1. 點擊編輯器側邊欄中的 Spark 圖示以開啟 Claude Code 面板
2. 以與在終端中相同的方式提示 Claude Code
3. 觀看 Claude 分析您的程式碼並建議變更
4. 直接在介面中檢視和接受編輯
   * **提示**：將側邊欄拖寬以查看內嵌差異，然後點擊以展開查看完整詳細資訊

### 使用第三方提供者（Vertex 和 Bedrock）

VS Code 擴充功能支援使用 Claude Code 搭配第三方提供者，例如 Amazon Bedrock 和 Google Vertex AI。使用這些提供者設定時，擴充功能不會提示登入。若要使用第三方提供者，請在 VS Code 擴充功能設定中設定環境變數：

1. 開啟 VS Code 設定
2. 搜尋「Claude Code: Environment Variables」
3. 新增必要的環境變數

#### 環境變數

| 變數                            | 說明                     | 必要           | 範例                                               |
| :---------------------------- | :--------------------- | :----------- | :----------------------------------------------- |
| `CLAUDE_CODE_USE_BEDROCK`     | 啟用 Amazon Bedrock 整合   | Bedrock 必要   | `"1"` 或 `"true"`                                 |
| `CLAUDE_CODE_USE_VERTEX`      | 啟用 Google Vertex AI 整合 | Vertex AI 必要 | `"1"` 或 `"true"`                                 |
| `ANTHROPIC_API_KEY`           | 第三方存取的 API 金鑰          | 必要           | `"your-api-key"`                                 |
| `AWS_REGION`                  | Bedrock 的 AWS 區域       |              | `"us-east-2"`                                    |
| `AWS_PROFILE`                 | Bedrock 驗證的 AWS 設定檔    |              | `"your-profile"`                                 |
| `CLOUD_ML_REGION`             | Vertex AI 的區域          |              | `"global"` 或 `"us-east5"`                        |
| `ANTHROPIC_VERTEX_PROJECT_ID` | Vertex AI 的 GCP 專案 ID  |              | `"your-project-id"`                              |
| `ANTHROPIC_MODEL`             | 覆寫主要模型                 | 覆寫模型 ID      | `"us.anthropic.claude-sonnet-4-5-20250929-v1:0"` |
| `ANTHROPIC_SMALL_FAST_MODEL`  | 覆寫小型/快速模型              | 選用           | `"us.anthropic.claude-3-5-haiku-20241022-v1:0"`  |
| `CLAUDE_CODE_SKIP_AUTH_LOGIN` | 停用所有登入提示               | 選用           | `"1"` 或 `"true"`                                 |

如需詳細的設定說明和其他設定選項，請參閱：

* [Claude Code on Amazon Bedrock](/zh-TW/docs/claude-code/amazon-bedrock)
* [Claude Code on Google Vertex AI](/zh-TW/docs/claude-code/google-vertex-ai)

### 尚未實作

VS Code 擴充功能中尚未提供以下功能：

* **完整 MCP 伺服器設定**：您需要先[透過 CLI 設定 MCP 伺服器](/zh-TW/docs/claude-code/mcp)，然後擴充功能將使用它們
* **子代理設定**：[透過 CLI 設定子代理](/zh-TW/docs/claude-code/sub-agents)以在 VS Code 中使用
* **檢查點**：在特定點儲存和還原對話狀態
* **進階快捷鍵**：
  * `#` 快捷鍵以新增至記憶體
  * `!` 快捷鍵以直接執行 bash 命令
* **Tab 完成**：使用 Tab 鍵進行檔案路徑完成

我們正在努力在未來的更新中新增這些功能。

## 安全考量

當 Claude Code 在 VS Code 中執行且啟用自動編輯權限時，它可能能夠修改 IDE 設定檔，這些檔案可由您的 IDE 自動執行。這可能會增加在自動編輯模式下執行 Claude Code 的風險，並允許繞過 Claude Code 對 bash 執行的權限提示。

在 VS Code 中執行時，請考慮：

* 為不受信任的工作區啟用 [VS Code 受限模式](https://code.visualstudio.com/docs/editor/workspace-trust#_restricted-mode)
* 使用手動核准模式進行編輯
* 特別注意確保 Claude 僅用於受信任的提示

## 舊版 CLI 整合

我們發佈的第一個 VS Code 整合允許在終端中執行的 Claude Code 與您的 IDE 互動。它提供選擇內容共享（目前選擇/標籤會自動與 Claude Code 共享）、在 IDE 而非終端中檢視差異、檔案參考快捷鍵（在 Mac 上按 `Cmd+Option+K` 或在 Windows/Linux 上按 `Alt+Ctrl+K` 以插入檔案參考，例如 @File#L1-99）和自動診斷共享（lint 和語法錯誤）。

舊版整合會在您從 VS Code 的整合終端執行 `claude` 時自動安裝。只需從終端執行 `claude`，所有功能就會啟動。對於外部終端，使用 `/ide` 命令將 Claude Code 連接到您的 VS Code 執行個體。若要設定，執行 `claude`、輸入 `/config` 並將差異工具設定為 `auto` 以進行自動 IDE 偵測。

擴充功能和 CLI 整合都適用於 Visual Studio Code、Cursor、Windsurf 和 VSCodium。

## 疑難排解

### 擴充功能未安裝

* 確保您有相容的 VS Code 版本（1.85.0 或更高版本）
* 檢查 VS Code 是否有權限安裝擴充功能
* 嘗試直接從市集網站安裝

### 舊版整合無法運作

* 確保您從 VS Code 的整合終端執行 Claude Code
* 確保已安裝 IDE 變體的 CLI：
  * VS Code：`code` 命令應該可用
  * Cursor：`cursor` 命令應該可用
  * Windsurf：`windsurf` 命令應該可用
  * VSCodium：`codium` 命令應該可用
* 如果未安裝命令：
  1. 使用 `Cmd+Shift+P`（Mac）或 `Ctrl+Shift+P`（Windows/Linux）開啟命令面板
  2. 搜尋「Shell Command: Install 'code' command in PATH」（或您的 IDE 的等效項目）

如需其他協助，請參閱我們的[疑難排解指南](/zh-TW/docs/claude-code/troubleshooting)。

