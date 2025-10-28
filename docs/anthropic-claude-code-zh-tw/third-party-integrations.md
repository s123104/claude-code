---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/third-party-integrations.md"
fetched_at: "2025-10-28T19:19:52+08:00"
---

# 企業部署概述

> 了解 Claude Code 如何與各種第三方服務和基礎設施整合，以滿足企業部署需求。

本頁面提供可用部署選項的概述，並幫助您為組織選擇正確的配置。

## 提供商比較

<table>
  <thead>
    <tr>
      <th>功能</th>
      <th>Anthropic</th>
      <th>Amazon Bedrock</th>
      <th>Google Vertex AI</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>區域</td>
      <td>支援的[國家](https://www.anthropic.com/supported-countries)</td>
      <td>多個 AWS [區域](https://docs.aws.amazon.com/bedrock/latest/userguide/models-regions.html)</td>
      <td>多個 GCP [區域](https://cloud.google.com/vertex-ai/generative-ai/docs/learn/locations)</td>
    </tr>

    <tr>
      <td>提示快取</td>
      <td>預設啟用</td>
      <td>預設啟用</td>
      <td>預設啟用</td>
    </tr>

    <tr>
      <td>身份驗證</td>
      <td>API 金鑰</td>
      <td>AWS 憑證 (IAM)</td>
      <td>GCP 憑證 (OAuth/服務帳戶)</td>
    </tr>

    <tr>
      <td>成本追蹤</td>
      <td>儀表板</td>
      <td>AWS Cost Explorer</td>
      <td>GCP Billing</td>
    </tr>

    <tr>
      <td>企業功能</td>
      <td>團隊、使用監控</td>
      <td>IAM 政策、CloudTrail</td>
      <td>IAM 角色、Cloud Audit Logs</td>
    </tr>
  </tbody>
</table>

## 雲端提供商

<CardGroup cols={2}>
  <Card title="Amazon Bedrock" icon="aws" href="/zh-TW/docs/claude-code/amazon-bedrock">
    透過 AWS 基礎設施使用 Claude 模型，具備基於 IAM 的身份驗證和 AWS 原生監控
  </Card>

  <Card title="Google Vertex AI" icon="google" href="/zh-TW/docs/claude-code/google-vertex-ai">
    透過 Google Cloud Platform 存取 Claude 模型，具備企業級安全性和合規性
  </Card>
</CardGroup>

## 企業基礎設施

<CardGroup cols={2}>
  <Card title="企業網路" icon="shield" href="/zh-TW/docs/claude-code/network-config">
    配置 Claude Code 以與您組織的代理伺服器和 SSL/TLS 需求配合使用
  </Card>

  <Card title="LLM 閘道" icon="server" href="/zh-TW/docs/claude-code/llm-gateway">
    部署集中式模型存取，具備使用追蹤、預算編列和稽核記錄功能
  </Card>
</CardGroup>

## 配置概述

Claude Code 支援靈活的配置選項，允許您結合不同的提供商和基礎設施：

<Note>
  了解以下差異：

  * **企業代理**：用於路由流量的 HTTP/HTTPS 代理（透過 `HTTPS_PROXY` 或 `HTTP_PROXY` 設定）
  * **LLM 閘道**：處理身份驗證並提供與提供商相容端點的服務（透過 `ANTHROPIC_BASE_URL`、`ANTHROPIC_BEDROCK_BASE_URL` 或 `ANTHROPIC_VERTEX_BASE_URL` 設定）

  兩種配置可以同時使用。
</Note>

### 使用 Bedrock 搭配企業代理

透過企業 HTTP/HTTPS 代理路由 Bedrock 流量：

```bash  theme={null}
# 啟用 Bedrock
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1

# 配置企業代理
export HTTPS_PROXY='https://proxy.example.com:8080'
```

### 使用 Bedrock 搭配 LLM 閘道

使用提供 Bedrock 相容端點的閘道服務：

```bash  theme={null}
# 啟用 Bedrock
export CLAUDE_CODE_USE_BEDROCK=1

# 配置 LLM 閘道
export ANTHROPIC_BEDROCK_BASE_URL='https://your-llm-gateway.com/bedrock'
export CLAUDE_CODE_SKIP_BEDROCK_AUTH=1  # 如果閘道處理 AWS 身份驗證
```

### 使用 Vertex AI 搭配企業代理

透過企業 HTTP/HTTPS 代理路由 Vertex AI 流量：

```bash  theme={null}
# 啟用 Vertex
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_VERTEX_PROJECT_ID=your-project-id

# 配置企業代理
export HTTPS_PROXY='https://proxy.example.com:8080'
```

### 使用 Vertex AI 搭配 LLM 閘道

結合 Google Vertex AI 模型與 LLM 閘道進行集中管理：

```bash  theme={null}
# 啟用 Vertex
export CLAUDE_CODE_USE_VERTEX=1

# 配置 LLM 閘道
export ANTHROPIC_VERTEX_BASE_URL='https://your-llm-gateway.com/vertex'
export CLAUDE_CODE_SKIP_VERTEX_AUTH=1  # 如果閘道處理 GCP 身份驗證
```

### 身份驗證配置

Claude Code 在需要時使用 `ANTHROPIC_AUTH_TOKEN` 作為 `Authorization` 標頭。`SKIP_AUTH` 標誌（`CLAUDE_CODE_SKIP_BEDROCK_AUTH`、`CLAUDE_CODE_SKIP_VERTEX_AUTH`）用於 LLM 閘道情境，其中閘道處理提供商身份驗證。

## 選擇正確的部署配置

選擇部署方法時請考慮以下因素：

### 直接提供商存取

最適合以下組織：

* 希望最簡單的設定
* 擁有現有的 AWS 或 GCP 基礎設施
* 需要提供商原生監控和合規性

### 企業代理

最適合以下組織：

* 有現有的企業代理需求
* 需要流量監控和合規性
* 必須透過特定網路路徑路由所有流量

### LLM 閘道

最適合以下組織：

* 需要跨團隊的使用追蹤
* 希望在模型之間動態切換
* 需要自訂速率限制或預算
* 需要集中式身份驗證管理

## 除錯

除錯部署時：

* 使用 `claude /status` [斜線命令](/zh-TW/docs/claude-code/slash-commands)。此命令提供對任何已套用的身份驗證、代理和 URL 設定的可觀察性。
* 設定環境變數 `export ANTHROPIC_LOG=debug` 來記錄請求。

## 組織最佳實務

### 1. 投資於文件和記憶

我們強烈建議投資於文件，讓 Claude Code 了解您的程式碼庫。組織可以在多個層級部署 CLAUDE.md 檔案：

* **組織範圍**：部署到系統目錄，如 `/Library/Application Support/ClaudeCode/CLAUDE.md`（macOS）用於公司範圍的標準
* **儲存庫層級**：在儲存庫根目錄建立包含專案架構、建置命令和貢獻指南的 `CLAUDE.md` 檔案。將這些檔案檢入原始碼控制，讓所有使用者受益

  [了解更多](/zh-TW/docs/claude-code/memory)。

### 2. 簡化部署

如果您有自訂開發環境，我們發現建立「一鍵」安裝 Claude Code 的方式是在組織內推廣採用的關鍵。

### 3. 從引導使用開始

鼓勵新使用者嘗試使用 Claude Code 進行程式碼庫問答，或處理較小的錯誤修復或功能請求。要求 Claude Code 制定計劃。檢查 Claude 的建議，如果偏離軌道請給予回饋。隨著時間推移，當使用者更好地理解這種新範式時，他們將更有效地讓 Claude Code 更自主地運行。

### 4. 配置安全政策

安全團隊可以配置 Claude Code 允許和不允許執行的託管權限，這些權限無法被本地配置覆寫。[了解更多](/zh-TW/docs/claude-code/security)。

### 5. 利用 MCP 進行整合

MCP 是為 Claude Code 提供更多資訊的絕佳方式，例如連接到票務管理系統或錯誤日誌。我們建議由一個中央團隊配置 MCP 伺服器，並將 `.mcp.json` 配置檢入程式碼庫，讓所有使用者受益。[了解更多](/zh-TW/docs/claude-code/mcp)。

在 Anthropic，我們信任 Claude Code 為每個 Anthropic 程式碼庫的開發提供動力。我們希望您像我們一樣享受使用 Claude Code！

## 後續步驟

* [設定 Amazon Bedrock](/zh-TW/docs/claude-code/amazon-bedrock) 進行 AWS 原生部署
* [配置 Google Vertex AI](/zh-TW/docs/claude-code/google-vertex-ai) 進行 GCP 部署
* [配置企業網路](/zh-TW/docs/claude-code/network-config) 滿足網路需求
* [部署 LLM 閘道](/zh-TW/docs/claude-code/llm-gateway) 進行企業管理
* [設定](/zh-TW/docs/claude-code/settings) 配置選項和環境變數

