---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/github-actions"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/github-actions)

Claude Code GitHub Actions 為您的 GitHub 工作流程帶來 AI 驅動的自動化。只需在任何 PR 或 issue 中簡單地提及 `@claude`，Claude 就能分析您的程式碼、建立拉取請求、實作功能和修復錯誤 - 同時遵循您專案的標準。

- **即時 PR 建立**：描述您需要的內容，Claude 會建立包含所有必要變更的完整 PR
- **自動化程式碼實作**：使用單一指令將 issue 轉換為可運作的程式碼
- **遵循您的標準**：Claude 尊重您的 `CLAUDE.md` 指導原則和現有的程式碼模式
- **簡單設定**：使用我們的安裝程式和 API 金鑰在幾分鐘內開始使用
- **預設安全**：您的程式碼保留在 Github 的執行器上

## Claude 能做什麼？

Claude Code 提供強大的 GitHub Actions，改變您處理程式碼的方式：

### Claude Code Action

這個 GitHub Action 允許您在 GitHub Actions 工作流程中執行 Claude Code。您可以使用它在 Claude Code 之上建立任何自訂工作流程。

[檢視儲存庫 →](https://github.com/anthropics/claude-code-action)

### Claude Code Action (Base)

使用 Claude 建立自訂 GitHub 工作流程的基礎。這個可擴展的框架讓您完全存取 Claude 的能力，用於建立量身定制的自動化。

[檢視儲存庫 →](https://github.com/anthropics/claude-code-base-action)

## 設定

## 快速設定

設定此 action 最簡單的方法是透過終端中的 Claude Code。只需開啟 claude 並執行 `/install-github-app`。

此指令將引導您設定 GitHub 應用程式和必要的密鑰。

## 手動設定

如果 `/install-github-app` 指令失敗或您偏好手動設定，請遵循這些手動設定說明：

1. **安裝 Claude GitHub 應用程式**到您的儲存庫：<https://github.com/apps/claude>
2. **新增 ANTHROPIC_API_KEY** 到您的儲存庫密鑰（[了解如何在 GitHub Actions 中使用密鑰](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)）
3. **複製工作流程檔案**從 [examples/claude.yml](https://github.com/anthropics/claude-code-action/blob/main/examples/claude.yml) 到您儲存庫的 `.github/workflows/`

## 範例使用案例

Claude Code GitHub Actions 可以幫助您處理各種任務。如需完整的工作範例，請參閱 [examples 目錄](https://github.com/anthropics/claude-code-action/tree/main/examples)。

### 將 issue 轉換為 PR

在 issue 評論中：

Claude 將分析 issue、撰寫程式碼，並建立 PR 供審查。

### 獲得實作協助

在 PR 評論中：

Claude 將分析您的程式碼並提供具體的實作指導。

### 快速修復錯誤

在 issue 中：

Claude 將定位錯誤、實作修復，並建立 PR。

## 最佳實務

### CLAUDE.md 配置

在您的儲存庫根目錄建立 `CLAUDE.md` 檔案，以定義程式碼風格指導原則、審查標準、專案特定規則和偏好模式。此檔案指導 Claude 理解您的專案標準。

### 安全考量

始終使用 GitHub Secrets 來存放 API 金鑰：

- 將您的 API 金鑰新增為名為 `ANTHROPIC_API_KEY` 的儲存庫密鑰
- 在工作流程中引用它：`anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}`
- 將 action 權限限制為僅必要的權限
- 在合併前審查 Claude 的建議

始終使用 GitHub Secrets（例如 `${{ secrets.ANTHROPIC_API_KEY }}`），而不是直接在工作流程檔案中硬編碼 API 金鑰。

### 效能最佳化

使用 issue 範本提供上下文，保持您的 `CLAUDE.md` 簡潔且專注，並為您的工作流程配置適當的逾時。

### CI 成本

使用 Claude Code GitHub Actions 時，請注意相關成本：

**GitHub Actions 成本：**

- Claude Code 在 GitHub 託管的執行器上運行，這會消耗您的 GitHub Actions 分鐘數
- 詳細定價和分鐘數限制請參閱 [GitHub 的計費文件](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-actions/about-billing-for-github-actions)

**API 成本：**

- 每次 Claude 互動都會根據提示和回應的長度消耗 API 代幣
- 代幣使用量因任務複雜度和程式碼庫大小而異
- 目前代幣費率請參閱 [Claude 的定價頁面](https://www.anthropic.com/api)

**成本最佳化提示：**

- 使用具體的 `@claude` 指令來減少不必要的 API 呼叫
- 配置適當的 `max_turns` 限制以防止過度迭代
- 設定合理的 `timeout_minutes` 以避免失控的工作流程
- 考慮使用 GitHub 的並發控制來限制並行執行

## 配置範例

針對不同使用案例的即用型工作流程配置，包括：

- issue 和 PR 評論的基本工作流程設定
- 拉取請求的自動化程式碼審查
- 特定需求的自訂實作

請造訪 Claude Code Action 儲存庫中的 [examples 目錄](https://github.com/anthropics/claude-code-action/tree/main/examples)。

## 使用 AWS Bedrock 和 Google Vertex AI

對於企業環境，您可以將 Claude Code GitHub Actions 與您自己的雲端基礎設施一起使用。這種方法讓您控制資料駐留和計費，同時保持相同的功能。

### 先決條件

在使用雲端提供商設定 Claude Code GitHub Actions 之前，您需要：

#### 對於 Google Cloud Vertex AI：

1. 啟用 Vertex AI 的 Google Cloud 專案
2. 為 GitHub Actions 配置的 Workload Identity Federation
3. 具有必要權限的服務帳戶
4. GitHub 應用程式（建議）或使用預設的 GITHUB_TOKEN

#### 對於 AWS Bedrock：

1. 啟用 Amazon Bedrock 的 AWS 帳戶
2. 在 AWS 中配置的 GitHub OIDC Identity Provider
3. 具有 Bedrock 權限的 IAM 角色
4. GitHub 應用程式（建議）或使用預設的 GITHUB_TOKEN

1

2

3

4

建立工作流程檔案

建立與您的雲端提供商整合的 GitHub Actions 工作流程檔案。以下範例顯示 AWS Bedrock 和 Google Vertex AI 的完整配置：

**先決條件：**

- 啟用 AWS Bedrock 存取並具有 Claude 模型權限
- GitHub 配置為 AWS 中的 OIDC 身分提供商
- 具有 Bedrock 權限且信任 GitHub Actions 的 IAM 角色

**必要的 GitHub 密鑰：**

| 密鑰名稱             | 描述                                        |
| -------------------- | ------------------------------------------- |
| `AWS_ROLE_TO_ASSUME` | 用於 Bedrock 存取的 IAM 角色 ARN            |
| `APP_ID`             | 您的 GitHub 應用程式 ID（來自應用程式設定） |
| `APP_PRIVATE_KEY`    | 您為 GitHub 應用程式產生的私鑰              |

**先決條件：**

- 在您的 GCP 專案中啟用 Vertex AI API
- 為 GitHub 配置 Workload Identity Federation
- 具有 Vertex AI 權限的服務帳戶

**必要的 GitHub 密鑰：**

| 密鑰名稱                         | 描述                                        |
| -------------------------------- | ------------------------------------------- |
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | Workload identity 提供商資源名稱            |
| `GCP_SERVICE_ACCOUNT`            | 具有 Vertex AI 存取權限的服務帳戶電子郵件   |
| `APP_ID`                         | 您的 GitHub 應用程式 ID（來自應用程式設定） |
| `APP_PRIVATE_KEY`                | 您為 GitHub 應用程式產生的私鑰              |

## 疑難排解

### Claude 未回應 @claude 指令

驗證 GitHub 應用程式是否正確安裝，檢查工作流程是否已啟用，確保 API 金鑰已在儲存庫密鑰中設定，並確認評論包含 `@claude`（不是 `/claude`）。

### CI 未在 Claude 的提交上執行

確保您使用的是 GitHub 應用程式或自訂應用程式（不是 Actions 使用者），檢查工作流程觸發器包含必要事件，並驗證應用程式權限包含 CI 觸發器。

### 驗證錯誤

確認 API 金鑰有效且具有足夠權限。對於 Bedrock/Vertex，檢查憑證配置並確保密鑰在工作流程中正確命名。

## 進階配置

### Action 參數

Claude Code Action 支援這些關鍵參數：

| 參數                | 描述                   | 必要   |
| ------------------- | ---------------------- | ------ |
| `prompt`            | 要發送給 Claude 的提示 | 是\*   |
| `prompt_file`       | 包含提示的檔案路徑     | 是\*   |
| `anthropic_api_key` | Anthropic API 金鑰     | 是\*\* |
| `max_turns`         | 最大對話輪數           | 否     |
| `timeout_minutes`   | 執行逾時               | 否     |

\*需要 `prompt` 或 `prompt_file` 其中之一  
\*\*直接 Anthropic API 需要，Bedrock/Vertex 不需要

### 替代整合方法

雖然 `/install-github-app` 指令是建議的方法，您也可以：

- **自訂 GitHub 應用程式**：對於需要品牌使用者名稱或自訂驗證流程的組織。建立您自己的 GitHub 應用程式，具有必要權限（contents、issues、pull requests），並使用 actions/create-github-app-token action 在您的工作流程中產生代幣。
- **手動 GitHub Actions**：直接工作流程配置以獲得最大靈活性
- **MCP 配置**：動態載入 Model Context Protocol 伺服器

詳細文件請參閱 [Claude Code Action 儲存庫](https://github.com/anthropics/claude-code-action)。

### 自訂 Claude 的行為

您可以透過兩種方式配置 Claude 的行為：

1. **CLAUDE.md**：在您儲存庫的根目錄中的 `CLAUDE.md` 檔案中定義編碼標準、審查標準和專案特定規則。Claude 在建立 PR 和回應請求時會遵循這些指導原則。查看我們的[記憶文件](/zh-TW/docs/claude-code/memory)以獲得更多詳細資訊。
2. **自訂提示**：在工作流程檔案中使用 `prompt` 參數提供工作流程特定的指示。這允許您為不同的工作流程或任務自訂 Claude 的行為。

Claude 在建立 PR 和回應請求時會遵循這些指導原則。
