---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/third-party-integrations"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/third-party-integrations)

本頁面提供可用部署選項的概覽，並幫助您為組織選擇正確的配置。

## 提供商比較

| 功能     | Anthropic                                                   | Amazon Bedrock                                                                            | Google Vertex AI                                                                       |
| -------- | ----------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| 地區     | 支援的[國家](https://www.anthropic.com/supported-countries) | 多個 AWS [地區](https://docs.aws.amazon.com/bedrock/latest/userguide/models-regions.html) | 多個 GCP [地區](https://cloud.google.com/vertex-ai/generative-ai/docs/learn/locations) |
| 提示快取 | 預設啟用                                                    | 預設啟用                                                                                  | 聯絡 Google 以啟用                                                                     |
| 身份驗證 | API 金鑰                                                    | AWS 憑證 (IAM)                                                                            | GCP 憑證 (OAuth/服務帳戶)                                                              |
| 成本追蹤 | 儀表板                                                      | AWS Cost Explorer                                                                         | GCP Billing                                                                            |
| 企業功能 | 團隊、使用監控                                              | IAM 政策、CloudTrail                                                                      | IAM 角色、Cloud Audit Logs                                                             |

## 雲端提供商

## 企業基礎設施

## 配置概覽

Claude Code 支援靈活的配置選項，允許您結合不同的提供商和基礎設施：

### 使用 Bedrock 與企業代理

透過企業 HTTP/HTTPS 代理路由 Bedrock 流量：

### 使用 Bedrock 與 LLM 閘道

使用提供 Bedrock 相容端點的閘道服務：

### 使用 Vertex AI 與企業代理

透過企業 HTTP/HTTPS 代理路由 Vertex AI 流量：

### 使用 Vertex AI 與 LLM 閘道

結合 Google Vertex AI 模型與 LLM 閘道進行集中管理：

### 身份驗證配置

Claude Code 在需要時使用 `ANTHROPIC_AUTH_TOKEN` 作為 `Authorization` 和 `Proxy-Authorization` 標頭。`SKIP_AUTH` 標誌（`CLAUDE_CODE_SKIP_BEDROCK_AUTH`、`CLAUDE_CODE_SKIP_VERTEX_AUTH`）用於 LLM 閘道場景，其中閘道處理提供商身份驗證。

## 選擇正確的部署配置

在選擇部署方法時考慮以下因素：

### 直接提供商存取

最適合以下組織：

- 希望最簡單的設定
- 擁有現有的 AWS 或 GCP 基礎設施
- 需要提供商原生監控和合規性

### 企業代理

最適合以下組織：

- 有現有的企業代理需求
- 需要流量監控和合規性
- 必須透過特定網路路徑路由所有流量

### LLM 閘道

最適合以下組織：

- 需要跨團隊的使用追蹤
- 希望在模型之間動態切換
- 需要自訂速率限制或預算
- 需要集中式身份驗證管理

## 除錯

在除錯部署時：

- 使用 `claude /status` [斜線命令](/zh-TW/docs/claude-code/slash-commands)。此命令提供對任何已套用的身份驗證、代理和 URL 設定的可觀察性。
- 設定環境變數 `export ANTHROPIC_LOG=debug` 以記錄請求。

## 組織最佳實務

1. 我們強烈建議投資於文件，以便 Claude Code 了解您的程式碼庫。許多組織在儲存庫根目錄中建立 `CLAUDE.md` 檔案（我們也稱之為記憶），其中包含系統架構、如何執行測試和其他常見命令，以及對程式碼庫貢獻的最佳實務。此檔案通常會檢入原始碼控制，以便所有使用者都能受益。[了解更多](/zh-TW/docs/claude-code/memory)。
2. 如果您有自訂開發環境，我們發現建立「一鍵」安裝 Claude Code 的方式是在組織中推廣採用的關鍵。
3. 鼓勵新使用者嘗試使用 Claude Code 進行程式碼庫問答，或處理較小的錯誤修復或功能請求。要求 Claude Code 制定計劃。檢查 Claude 的建議，如果偏離軌道則給予回饋。隨著時間推移，當使用者更好地理解這種新範式時，他們將更有效地讓 Claude Code 更自主地運行。
4. 安全團隊可以配置 Claude Code 允許和不允許執行的管理權限，這些權限無法被本地配置覆寫。[了解更多](/zh-TW/docs/claude-code/security)。
5. MCP 是為 Claude Code 提供更多資訊的絕佳方式，例如連接到票務管理系統或錯誤日誌。我們建議由一個中央團隊配置 MCP 伺服器，並將 `.mcp.json` 配置檢入程式碼庫，以便所有使用者都能受益。[了解更多](/zh-TW/docs/claude-code/mcp)。

在 Anthropic，我們信任 Claude Code 為每個 Anthropic 程式碼庫的開發提供動力。我們希望您像我們一樣享受使用 Claude Code！

## 後續步驟

- [設定 Amazon Bedrock](/zh-TW/docs/claude-code/amazon-bedrock) 進行 AWS 原生部署
- [配置 Google Vertex AI](/zh-TW/docs/claude-code/google-vertex-ai) 進行 GCP 部署
- [實施企業代理](/zh-TW/docs/claude-code/corporate-proxy) 滿足網路需求
- [部署 LLM 閘道](/zh-TW/docs/claude-code/llm-gateway) 進行企業管理
- [設定](/zh-TW/docs/claude-code/settings) 配置選項和環境變數
