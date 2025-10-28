---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/amazon-bedrock.md"
fetched_at: "2025-10-28T19:12:16+08:00"
---

# Amazon Bedrock 上的 Claude Code

> 了解如何透過 Amazon Bedrock 配置 Claude Code，包括設定、IAM 配置和疑難排解。

## 先決條件

在使用 Bedrock 配置 Claude Code 之前，請確保您具備：

* 已啟用 Bedrock 存取權限的 AWS 帳戶
* 在 Bedrock 中存取所需的 Claude 模型（例如 Claude Sonnet 4.5）
* 已安裝並配置的 AWS CLI（可選 - 僅在您沒有其他取得憑證機制時才需要）
* 適當的 IAM 權限

## 設定

### 1. 啟用模型存取

首先，確保您在 AWS 帳戶中擁有所需 Claude 模型的存取權限：

1. 導航至 [Amazon Bedrock 控制台](https://console.aws.amazon.com/bedrock/)
2. 在左側導航中前往**模型存取**
3. 請求存取所需的 Claude 模型（例如 Claude Sonnet 4.5）
4. 等待核准（大多數地區通常是即時的）

### 2. 配置 AWS 憑證

Claude Code 使用預設的 AWS SDK 憑證鏈。使用以下方法之一設定您的憑證：

**選項 A：AWS CLI 配置**

```bash  theme={null}
aws configure
```

**選項 B：環境變數（存取金鑰）**

```bash  theme={null}
export AWS_ACCESS_KEY_ID=your-access-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-access-key
export AWS_SESSION_TOKEN=your-session-token
```

**選項 C：環境變數（SSO 設定檔）**

```bash  theme={null}
aws sso login --profile=<your-profile-name>

export AWS_PROFILE=your-profile-name
```

**選項 D：Bedrock API 金鑰**

```bash  theme={null}
export AWS_BEARER_TOKEN_BEDROCK=your-bedrock-api-key
```

Bedrock API 金鑰提供了一種更簡單的身份驗證方法，無需完整的 AWS 憑證。[了解更多關於 Bedrock API 金鑰的資訊](https://aws.amazon.com/blogs/machine-learning/accelerate-ai-development-with-amazon-bedrock-api-keys/)。

#### 進階憑證配置

Claude Code 支援 AWS SSO 和企業身份提供者的自動憑證刷新。將這些設定新增至您的 Claude Code 設定檔案（請參閱[設定](/zh-TW/docs/claude-code/settings)以了解檔案位置）。

當 Claude Code 偵測到您的 AWS 憑證已過期（基於本地時間戳或當 Bedrock 回傳憑證錯誤時），它將自動執行您配置的 `awsAuthRefresh` 和/或 `awsCredentialExport` 命令以取得新憑證，然後重試請求。

##### 範例配置

```json  theme={null}
{
  "awsAuthRefresh": "aws sso login --profile myprofile",
  "env": {
    "AWS_PROFILE": "myprofile"
  }
}
```

##### 配置設定說明

**`awsAuthRefresh`**：用於修改 `.aws` 目錄的命令（例如更新憑證、SSO 快取或配置檔案）。輸出會顯示給使用者（但不支援使用者輸入），適合基於瀏覽器的身份驗證流程，其中 CLI 顯示要在瀏覽器中輸入的代碼。

**`awsCredentialExport`**：僅在您無法修改 `.aws` 且必須直接回傳憑證時使用。輸出會被靜默擷取（不顯示給使用者）。命令必須以此格式輸出 JSON：

```json  theme={null}
{
  "Credentials": {
    "AccessKeyId": "value",
    "SecretAccessKey": "value",
    "SessionToken": "value"
  }
}
```

### 3. 配置 Claude Code

設定以下環境變數以啟用 Bedrock：

```bash  theme={null}
# 啟用 Bedrock 整合
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1  # 或您偏好的地區

# 可選：覆蓋小型/快速模型（Haiku）的地區
export ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION=us-west-2
```

為 Claude Code 啟用 Bedrock 時，請記住以下幾點：

* `AWS_REGION` 是必需的環境變數。Claude Code 不會從 `.aws` 配置檔案讀取此設定。
* 使用 Bedrock 時，`/login` 和 `/logout` 命令會被停用，因為身份驗證是透過 AWS 憑證處理的。
* 您可以使用設定檔案來設定像 `AWS_PROFILE` 這樣您不希望洩露給其他程序的環境變數。請參閱[設定](/zh-TW/docs/claude-code/settings)以了解更多資訊。

### 4. 模型配置

Claude Code 為 Bedrock 使用這些預設模型：

| 模型類型    | 預設值                                                |
| :------ | :------------------------------------------------- |
| 主要模型    | `global.anthropic.claude-sonnet-4-5-20250929-v1:0` |
| 小型/快速模型 | `us.anthropic.claude-haiku-4-5-20251001-v1:0`      |

<Note>
  對於 Bedrock 使用者，Claude Code 不會自動從 Haiku 3.5 升級到 Haiku 4.5。要手動切換到較新的 Haiku 模型，請將 `ANTHROPIC_DEFAULT_HAIKU_MODEL` 環境變數設定為完整的模型名稱（例如 `us.anthropic.claude-haiku-4-5-20251001-v1:0`）。
</Note>

要自訂模型，請使用以下方法之一：

```bash  theme={null}
# 使用推理設定檔 ID
export ANTHROPIC_MODEL='global.anthropic.claude-sonnet-4-5-20250929-v1:0'
export ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-haiku-4-5-20251001-v1:0'

# 使用應用程式推理設定檔 ARN
export ANTHROPIC_MODEL='arn:aws:bedrock:us-east-2:your-account-id:application-inference-profile/your-model-id'

# 可選：如需要可停用提示快取
export DISABLE_PROMPT_CACHING=1
```

<Note>
  [提示快取](/zh-TW/docs/build-with-claude/prompt-caching)可能不適用於所有地區
</Note>

### 5. 輸出權杖配置

在 Amazon Bedrock 上使用 Claude Code 時，我們建議以下權杖設定：

```bash  theme={null}
# Bedrock 建議的輸出權杖設定
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=4096
export MAX_THINKING_TOKENS=1024
```

**為什麼使用這些值：**

* **`CLAUDE_CODE_MAX_OUTPUT_TOKENS=4096`**：Bedrock 的燃盡節流邏輯將最少 4096 個權杖設定為 max\_token 懲罰。設定更低的值不會降低成本，但可能會切斷長工具使用，導致 Claude Code 代理循環持續失敗。Claude Code 通常在沒有延伸思考的情況下使用少於 4096 個輸出權杖，但對於涉及大量檔案建立或寫入工具使用的任務可能需要這個餘量。

* **`MAX_THINKING_TOKENS=1024`**：這為延伸思考提供空間，而不會切斷工具使用回應，同時仍保持專注的推理鏈。這種平衡有助於防止軌跡變化，這對於編碼任務來說並不總是有幫助的。

## IAM 配置

為 Claude Code 建立具有所需權限的 IAM 政策：

```json  theme={null}
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "bedrock:InvokeModel",
        "bedrock:InvokeModelWithResponseStream",
        "bedrock:ListInferenceProfiles"
      ],
      "Resource": [
        "arn:aws:bedrock:*:*:inference-profile/*",
        "arn:aws:bedrock:*:*:application-inference-profile/*"
      ]
    }
  ]
}
```

為了更嚴格的權限，您可以將資源限制為特定的推理設定檔 ARN。

詳情請參閱 [Bedrock IAM 文件](https://docs.aws.amazon.com/bedrock/latest/userguide/security-iam.html)。

<Note>
  我們建議為 Claude Code 建立專用的 AWS 帳戶，以簡化成本追蹤和存取控制。
</Note>

## 疑難排解

如果您遇到地區問題：

* 檢查模型可用性：`aws bedrock list-inference-profiles --region your-region`
* 切換到支援的地區：`export AWS_REGION=us-east-1`
* 考慮使用推理設定檔進行跨地區存取

如果您收到「不支援隨需輸送量」錯誤：

* 將模型指定為[推理設定檔](https://docs.aws.amazon.com/bedrock/latest/userguide/inference-profiles-support.html) ID

Claude Code 使用 Bedrock [Invoke API](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_InvokeModelWithResponseStream.html)，不支援 Converse API。

## 其他資源

* [Bedrock 文件](https://docs.aws.amazon.com/bedrock/)
* [Bedrock 定價](https://aws.amazon.com/bedrock/pricing/)
* [Bedrock 推理設定檔](https://docs.aws.amazon.com/bedrock/latest/userguide/inference-profiles-support.html)
* [Amazon Bedrock 上的 Claude Code：快速設定指南](https://community.aws/content/2tXkZKrZzlrlu0KfH8gST5Dkppq/claude-code-on-amazon-bedrock-quick-setup-guide)
* [Claude Code 監控實作（Bedrock）](https://github.com/aws-solutions-library-samples/guidance-for-claude-code-with-amazon-bedrock/blob/main/assets/docs/MONITORING.md)

