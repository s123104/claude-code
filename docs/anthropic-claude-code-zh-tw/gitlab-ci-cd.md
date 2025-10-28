---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/gitlab-ci-cd.md"
fetched_at: "2025-10-28T19:17:01+08:00"
---

# Claude Code GitLab CI/CD

> 了解如何將 Claude Code 整合到您的 GitLab CI/CD 開發工作流程中

<Info>
  Claude Code for GitLab CI/CD 目前處於測試版。隨著我們改進體驗，功能和功能性可能會演變。

  此整合由 GitLab 維護。如需支援，請參閱以下 [GitLab 問題](https://gitlab.com/gitlab-org/gitlab/-/issues/573776)。
</Info>

<Note>
  此整合建立在 [Claude Code CLI 和 SDK](/zh-TW/docs/claude-code/sdk) 之上，可在您的 CI/CD 工作和自訂自動化工作流程中以程式設計方式使用 Claude。
</Note>

## 為什麼要在 GitLab 中使用 Claude Code？

* **即時 MR 建立**：描述您需要的內容，Claude 會提出包含變更和說明的完整 MR
* **自動化實現**：使用單一命令或提及將問題轉變為可運作的程式碼
* **專案感知**：Claude 遵循您的 `CLAUDE.md` 指南和現有程式碼模式
* **簡單設定**：在 `.gitlab-ci.yml` 中新增一個工作和一個遮罩 CI/CD 變數
* **企業就緒**：選擇 Claude API、AWS Bedrock 或 Google Vertex AI 以滿足資料駐留和採購需求
* **預設安全**：在您的 GitLab 執行器中執行，具有您的分支保護和核准

## 運作方式

Claude Code 使用 GitLab CI/CD 在隔離的工作中執行 AI 任務，並透過 MR 將結果提交回去：

1. **事件驅動的編排**：GitLab 監聽您選擇的觸發器（例如，在問題、MR 或審查執行緒中提及 `@claude` 的評論）。該工作從執行緒和儲存庫收集上下文，從該輸入建立提示，並執行 Claude Code。

2. **提供者抽象**：使用適合您環境的提供者：
   * Claude API (SaaS)
   * AWS Bedrock (IAM 型存取、跨區域選項)
   * Google Vertex AI (GCP 原生、工作負載身份聯盟)

3. **沙箱執行**：每個互動都在具有嚴格網路和檔案系統規則的容器中執行。Claude Code 強制執行工作區範圍的權限以限制寫入。每個變更都流經 MR，以便審查者看到差異並且核准仍然適用。

選擇區域端點以減少延遲並滿足資料主權要求，同時使用現有的雲端協議。

## Claude 可以做什麼？

Claude Code 支援強大的 CI/CD 工作流程，改變您與程式碼的互動方式：

* 從問題描述或評論建立和更新 MR
* 分析效能迴歸並提出最佳化建議
* 直接在分支中實現功能，然後開啟 MR
* 修復由測試或評論識別的錯誤和迴歸
* 回應後續評論以反覆進行所要求的變更

## 設定

### 快速設定

開始使用的最快方式是在 `.gitlab-ci.yml` 中新增最小工作並將您的 API 金鑰設定為遮罩變數。

1. **新增遮罩 CI/CD 變數**
   * 前往 **Settings** → **CI/CD** → **Variables**
   * 新增 `ANTHROPIC_API_KEY`（遮罩，根據需要保護）

2. **在 `.gitlab-ci.yml` 中新增 Claude 工作**

```yaml  theme={null}
stages:
  - ai

claude:
  stage: ai
  image: node:24-alpine3.21
  # 調整規則以符合您想要觸發工作的方式：
  # - 手動執行
  # - 合併請求事件
  # - 當評論包含 '@claude' 時的 web/API 觸發
  rules:
    - if: '$CI_PIPELINE_SOURCE == "web"'
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
  variables:
    GIT_STRATEGY: fetch
  before_script:
    - apk update
    - apk add --no-cache git curl bash
    - npm install -g @anthropic-ai/claude-code
  script:
    # 選用：如果您的設定提供，啟動 GitLab MCP 伺服器
    - /bin/gitlab-mcp-server || true
    # 透過 web/API 觸發並使用上下文負載時使用 AI_FLOW_* 變數
    - echo "$AI_FLOW_INPUT for $AI_FLOW_CONTEXT on $AI_FLOW_EVENT"
    - >
      claude
      -p "${AI_FLOW_INPUT:-'Review this MR and implement the requested changes'}"
      --permission-mode acceptEdits
      --allowedTools "Bash(*) Read(*) Edit(*) Write(*) mcp__gitlab"
      --debug
```

新增工作和 `ANTHROPIC_API_KEY` 變數後，透過從 **CI/CD** → **Pipelines** 手動執行工作進行測試，或從 MR 觸發它以讓 Claude 在分支中提出更新並在需要時開啟 MR。

<Note>
  若要改用 AWS Bedrock 或 Google Vertex AI 而不是 Claude API，請參閱下面的 [使用 AWS Bedrock 和 Google Vertex AI](#using-with-aws-bedrock--google-vertex-ai) 部分以了解驗證和環境設定。
</Note>

### 手動設定（建議用於生產環境）

如果您偏好更受控的設定或需要企業提供者：

1. **設定提供者存取**：
   * **Claude API**：建立並將 `ANTHROPIC_API_KEY` 儲存為遮罩 CI/CD 變數
   * **AWS Bedrock**：**設定 GitLab** → **AWS OIDC** 並為 Bedrock 建立 IAM 角色
   * **Google Vertex AI**：**為 GitLab 設定工作負載身份聯盟** → **GCP**

2. **為 GitLab API 操作新增專案認證**：
   * 預設使用 `CI_JOB_TOKEN`，或建立具有 `api` 範圍的專案存取權杖
   * 如果使用 PAT，將其儲存為 `GITLAB_ACCESS_TOKEN`（遮罩）

3. **在 `.gitlab-ci.yml` 中新增 Claude 工作**（請參閱下面的範例）

4. **（選用）啟用提及驅動的觸發器**：
   * 為「評論（備註）」新增專案 webhook 到您的事件監聽器（如果您使用的話）
   * 當評論包含 `@claude` 時，讓監聽器使用 `AI_FLOW_INPUT` 和 `AI_FLOW_CONTEXT` 等變數呼叫管道觸發 API

## 範例使用案例

### 將問題轉變為 MR

在問題評論中：

```
@claude implement this feature based on the issue description
```

Claude 分析問題和程式碼庫，在分支中寫入變更，並開啟 MR 供審查。

### 取得實現幫助

在 MR 討論中：

```
@claude suggest a concrete approach to cache the results of this API call
```

Claude 提出變更、新增適當快取的程式碼，並更新 MR。

### 快速修復錯誤

在問題或 MR 評論中：

```
@claude fix the TypeError in the user dashboard component
```

Claude 定位錯誤、實現修復，並更新分支或開啟新 MR。

## 使用 AWS Bedrock 和 Google Vertex AI

對於企業環境，您可以在雲端基礎設施上完全執行 Claude Code，具有相同的開發人員體驗。

<Tabs>
  <Tab title="AWS Bedrock">
    ### 先決條件

    在使用 AWS Bedrock 設定 Claude Code 之前，您需要：

    1. 具有 Amazon Bedrock 存取所需 Claude 模型的 AWS 帳戶
    2. 在 AWS IAM 中設定為 OIDC 身份提供者的 GitLab
    3. 具有 Bedrock 權限和信任政策的 IAM 角色，限制為您的 GitLab 專案/參考
    4. 用於角色假設的 GitLab CI/CD 變數：
       * `AWS_ROLE_TO_ASSUME`（角色 ARN）
       * `AWS_REGION`（Bedrock 區域）

    ### 設定說明

    設定 AWS 以允許 GitLab CI 工作透過 OIDC 假設 IAM 角色（無靜態金鑰）。

    **必需的設定：**

    1. 啟用 Amazon Bedrock 並要求存取您的目標 Claude 模型
    2. 如果尚未存在，為 GitLab 建立 IAM OIDC 提供者
    3. 建立由 GitLab OIDC 提供者信任的 IAM 角色，限制為您的專案和受保護的參考
    4. 為 Bedrock 呼叫 API 附加最小權限

    **要儲存在 CI/CD 變數中的必需值：**

    * `AWS_ROLE_TO_ASSUME`
    * `AWS_REGION`

    在 Settings → CI/CD → Variables 中新增變數：

    ```yaml  theme={null}
    # 對於 AWS Bedrock：
    - AWS_ROLE_TO_ASSUME
    - AWS_REGION
    ```

    使用上面的 AWS Bedrock 工作範例在執行時交換 GitLab 工作令牌以取得臨時 AWS 認證。
  </Tab>

  <Tab title="Google Vertex AI">
    ### 先決條件

    在使用 Google Vertex AI 設定 Claude Code 之前，您需要：

    1. 具有以下條件的 Google Cloud 專案：
       * 啟用 Vertex AI API
       * 設定工作負載身份聯盟以信任 GitLab OIDC
    2. 具有僅所需 Vertex AI 角色的專用服務帳戶
    3. 用於 WIF 的 GitLab CI/CD 變數：
       * `GCP_WORKLOAD_IDENTITY_PROVIDER`（完整資源名稱）
       * `GCP_SERVICE_ACCOUNT`（服務帳戶電子郵件）

    ### 設定說明

    設定 Google Cloud 以允許 GitLab CI 工作透過工作負載身份聯盟模擬服務帳戶。

    **必需的設定：**

    1. 啟用 IAM 認證 API、STS API 和 Vertex AI API
    2. 為 GitLab OIDC 建立工作負載身份池和提供者
    3. 建立具有 Vertex AI 角色的專用服務帳戶
    4. 授予 WIF 主體權限以模擬服務帳戶

    **要儲存在 CI/CD 變數中的必需值：**

    * `GCP_WORKLOAD_IDENTITY_PROVIDER`
    * `GCP_SERVICE_ACCOUNT`

    在 Settings → CI/CD → Variables 中新增變數：

    ```yaml  theme={null}
    # 對於 Google Vertex AI：
    - GCP_WORKLOAD_IDENTITY_PROVIDER
    - GCP_SERVICE_ACCOUNT
    - CLOUD_ML_REGION（例如 us-east5）
    ```

    使用上面的 Google Vertex AI 工作範例進行驗證，無需儲存金鑰。
  </Tab>
</Tabs>

## 設定範例

以下是您可以調整到管道的現成程式碼片段。

### 基本 .gitlab-ci.yml (Claude API)

```yaml  theme={null}
stages:
  - ai

claude:
  stage: ai
  image: node:24-alpine3.21
  rules:
    - if: '$CI_PIPELINE_SOURCE == "web"'
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
  variables:
    GIT_STRATEGY: fetch
  before_script:
    - apk update
    - apk add --no-cache git curl bash
    - npm install -g @anthropic-ai/claude-code
  script:
    - /bin/gitlab-mcp-server || true
    - >
      claude
      -p "${AI_FLOW_INPUT:-'Summarize recent changes and suggest improvements'}"
      --permission-mode acceptEdits
      --allowedTools "Bash(*) Read(*) Edit(*) Write(*) mcp__gitlab"
      --debug
  # Claude Code 將使用 CI/CD 變數中的 ANTHROPIC_API_KEY
```

### AWS Bedrock 工作範例 (OIDC)

**先決條件：**

* 啟用 Amazon Bedrock 並存取您選擇的 Claude 模型
* 在 AWS 中設定 GitLab OIDC，具有信任您的 GitLab 專案和參考的角色
* 具有 Bedrock 權限的 IAM 角色（建議最小權限）

**必需的 CI/CD 變數：**

* `AWS_ROLE_TO_ASSUME`：Bedrock 存取的 IAM 角色的 ARN
* `AWS_REGION`：Bedrock 區域（例如 `us-west-2`）

```yaml  theme={null}
claude-bedrock:
  stage: ai
  image: node:24-alpine3.21
  rules:
    - if: '$CI_PIPELINE_SOURCE == "web"'
  before_script:
    - apk add --no-cache bash curl jq git python3 py3-pip
    - pip install --no-cache-dir awscli
    - npm install -g @anthropic-ai/claude-code
    # 交換 GitLab OIDC 令牌以取得 AWS 認證
    - export AWS_WEB_IDENTITY_TOKEN_FILE="${CI_JOB_JWT_FILE:-/tmp/oidc_token}"
    - if [ -n "${CI_JOB_JWT_V2}" ]; then printf "%s" "$CI_JOB_JWT_V2" > "$AWS_WEB_IDENTITY_TOKEN_FILE"; fi
    - >
      aws sts assume-role-with-web-identity
      --role-arn "$AWS_ROLE_TO_ASSUME"
      --role-session-name "gitlab-claude-$(date +%s)"
      --web-identity-token "file://$AWS_WEB_IDENTITY_TOKEN_FILE"
      --duration-seconds 3600 > /tmp/aws_creds.json
    - export AWS_ACCESS_KEY_ID="$(jq -r .Credentials.AccessKeyId /tmp/aws_creds.json)"
    - export AWS_SECRET_ACCESS_KEY="$(jq -r .Credentials.SecretAccessKey /tmp/aws_creds.json)"
    - export AWS_SESSION_TOKEN="$(jq -r .Credentials.SessionToken /tmp/aws_creds.json)"
  script:
    - /bin/gitlab-mcp-server || true
    - >
      claude
      -p "${AI_FLOW_INPUT:-'Implement the requested changes and open an MR'}"
      --permission-mode acceptEdits
      --allowedTools "Bash(*) Read(*) Edit(*) Write(*) mcp__gitlab"
      --debug
  variables:
    AWS_REGION: "us-west-2"
```

<Note>
  Bedrock 的模型 ID 包括區域特定的前綴和版本後綴（例如 `us.anthropic.claude-sonnet-4-5-20250929-v1:0`）。透過工作設定或提示傳遞所需的模型（如果您的工作流程支援的話）。
</Note>

### Google Vertex AI 工作範例（工作負載身份聯盟）

**先決條件：**

* 在您的 GCP 專案中啟用 Vertex AI API
* 設定工作負載身份聯盟以信任 GitLab OIDC
* 具有 Vertex AI 權限的服務帳戶

**必需的 CI/CD 變數：**

* `GCP_WORKLOAD_IDENTITY_PROVIDER`：完整提供者資源名稱
* `GCP_SERVICE_ACCOUNT`：服務帳戶電子郵件
* `CLOUD_ML_REGION`：Vertex 區域（例如 `us-east5`）

```yaml  theme={null}
claude-vertex:
  stage: ai
  image: gcr.io/google.com/cloudsdktool/google-cloud-cli:slim
  rules:
    - if: '$CI_PIPELINE_SOURCE == "web"'
  before_script:
    - apt-get update && apt-get install -y git nodejs npm && apt-get clean
    - npm install -g @anthropic-ai/claude-code
    # 透過 WIF 驗證到 Google Cloud（無下載的金鑰）
    - >
      gcloud auth login --cred-file=<(cat <<EOF
      {
        "type": "external_account",
        "audience": "${GCP_WORKLOAD_IDENTITY_PROVIDER}",
        "subject_token_type": "urn:ietf:params:oauth:token-type:jwt",
        "service_account_impersonation_url": "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/${GCP_SERVICE_ACCOUNT}:generateAccessToken",
        "token_url": "https://sts.googleapis.com/v1/token"
      }
      EOF
      )
    - gcloud config set project "$(gcloud projects list --format='value(projectId)' --filter="name:${CI_PROJECT_NAMESPACE}" | head -n1)" || true
  script:
    - /bin/gitlab-mcp-server || true
    - >
      CLOUD_ML_REGION="${CLOUD_ML_REGION:-us-east5}"
      claude
      -p "${AI_FLOW_INPUT:-'Review and update code as requested'}"
      --permission-mode acceptEdits
      --allowedTools "Bash(*) Read(*) Edit(*) Write(*) mcp__gitlab"
      --debug
  variables:
    CLOUD_ML_REGION: "us-east5"
```

<Note>
  使用工作負載身份聯盟，您無需儲存服務帳戶金鑰。使用儲存庫特定的信任條件和最小權限服務帳戶。
</Note>

## 最佳實踐

### CLAUDE.md 設定

在儲存庫根目錄建立 `CLAUDE.md` 檔案以定義編碼標準、審查標準和專案特定規則。Claude 在執行期間讀取此檔案並在提出變更時遵循您的慣例。

### 安全考量

永遠不要將 API 金鑰或雲端認證提交到您的儲存庫！始終使用 GitLab CI/CD 變數：

* 將 `ANTHROPIC_API_KEY` 新增為遮罩變數（如果需要，保護它）
* 盡可能使用提供者特定的 OIDC（無長期金鑰）
* 限制工作權限和網路出口
* 像審查任何其他貢獻者一樣審查 Claude 的 MR

### 最佳化效能

* 保持 `CLAUDE.md` 專注和簡潔
* 提供清晰的問題/MR 描述以減少反覆
* 設定合理的工作逾時以避免失控執行
* 在可能的情況下在執行器中快取 npm 和套件安裝

### CI 成本

使用 Claude Code 與 GitLab CI/CD 時，請注意相關成本：

* **GitLab 執行器時間**：
  * Claude 在您的 GitLab 執行器上執行並消耗計算分鐘數
  * 有關詳細資訊，請參閱您的 GitLab 計畫的執行器計費

* **API 成本**：
  * 每個 Claude 互動根據提示和回應大小消耗令牌
  * 令牌使用因任務複雜性和程式碼庫大小而異
  * 有關詳細資訊，請參閱 [Anthropic 定價](/zh-TW/docs/about-claude/pricing)

* **成本最佳化提示**：
  * 使用特定的 `@claude` 命令以減少不必要的轉向
  * 設定適當的 `max_turns` 和工作逾時值
  * 限制並行以控制平行執行

## 安全和治理

* 每個工作都在具有受限網路存取的隔離容器中執行
* Claude 的變更流經 MR，以便審查者看到每個差異
* 分支保護和核准規則適用於 AI 生成的程式碼
* Claude Code 使用工作區範圍的權限以限制寫入
* 成本保持在您的控制下，因為您帶來自己的提供者認證

## 疑難排解

### Claude 未回應 @claude 命令

* 驗證您的管道正在被觸發（手動、MR 事件或透過備註事件監聽器/webhook）
* 確保 CI/CD 變數（`ANTHROPIC_API_KEY` 或雲端提供者設定）存在且未遮罩
* 檢查評論是否包含 `@claude`（不是 `/claude`）以及您的提及觸發器是否已設定

### 工作無法寫入評論或開啟 MR

* 確保 `CI_JOB_TOKEN` 對專案具有足夠的權限，或使用具有 `api` 範圍的專案存取權杖
* 檢查 `mcp__gitlab` 工具是否在 `--allowedTools` 中啟用
* 確認工作在 MR 的上下文中執行或透過 `AI_FLOW_*` 變數有足夠的上下文

### 驗證錯誤

* **對於 Claude API**：確認 `ANTHROPIC_API_KEY` 有效且未過期
* **對於 Bedrock/Vertex**：驗證 OIDC/WIF 設定、角色模擬和祕密名稱；確認區域和模型可用性

## 進階設定

### 常見參數和變數

Claude Code 支援這些常用輸入：

* `prompt` / `prompt_file`：內聯提供說明（`-p`）或透過檔案
* `max_turns`：限制來回反覆的次數
* `timeout_minutes`：限制總執行時間
* `ANTHROPIC_API_KEY`：Claude API 所需（不用於 Bedrock/Vertex）
* 提供者特定環境：`AWS_REGION`、Vertex 的專案/區域變數

<Note>
  確切的旗標和參數可能因 `@anthropic-ai/claude-code` 的版本而異。在您的工作中執行 `claude --help` 以查看支援的選項。
</Note>

### 自訂 Claude 的行為

您可以透過兩種主要方式指導 Claude：

1. **CLAUDE.md**：定義編碼標準、安全要求和專案慣例。Claude 在執行期間讀取此檔案並遵循您的規則。
2. **自訂提示**：透過工作中的 `prompt`/`prompt_file` 傳遞任務特定說明。為不同的工作使用不同的提示（例如審查、實現、重構）。

