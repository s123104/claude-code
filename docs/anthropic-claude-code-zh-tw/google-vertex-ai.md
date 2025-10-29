---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/google-vertex-ai.md"
fetched_at: "2025-10-29T14:10:33+08:00"
---

# Claude Code on Google Vertex AI

> 了解如何透過 Google Vertex AI 設定 Claude Code，包括設定、IAM 設定和故障排除。

## 先決條件

在使用 Vertex AI 設定 Claude Code 之前，請確保您具有：

* 已啟用計費的 Google Cloud Platform (GCP) 帳戶
* 已啟用 Vertex AI API 的 GCP 專案
* 存取所需的 Claude 模型（例如 Claude Sonnet 4.5）
* 已安裝並設定 Google Cloud SDK (`gcloud`)
* 在所需的 GCP 區域中分配的配額

## 區域設定

Claude Code 可與 Vertex AI [全球](https://cloud.google.com/blog/products/ai-machine-learning/global-endpoint-for-claude-models-generally-available-on-vertex-ai)和區域端點一起使用。

<Note>
  Vertex AI 可能不支援所有區域上的 Claude Code 預設模型。您可能需要切換到[支援的區域或模型](https://cloud.google.com/vertex-ai/generative-ai/docs/learn/locations#genai-partner-models)。
</Note>

<Note>
  Vertex AI 可能不支援全球端點上的 Claude Code 預設模型。您可能需要切換到區域端點或[支援的模型](https://cloud.google.com/vertex-ai/generative-ai/docs/partner-models/use-partner-models#supported_models)。
</Note>

## 設定

### 1. 啟用 Vertex AI API

在您的 GCP 專案中啟用 Vertex AI API：

```bash  theme={null}
# 設定您的專案 ID
gcloud config set project YOUR-PROJECT-ID

# 啟用 Vertex AI API
gcloud services enable aiplatform.googleapis.com
```

### 2. 要求模型存取

要求在 Vertex AI 中存取 Claude 模型：

1. 導覽至 [Vertex AI Model Garden](https://console.cloud.google.com/vertex-ai/model-garden)
2. 搜尋「Claude」模型
3. 要求存取所需的 Claude 模型（例如 Claude Sonnet 4.5）
4. 等待核准（可能需要 24-48 小時）

### 3. 設定 GCP 認證

Claude Code 使用標準 Google Cloud 驗證。

如需詳細資訊，請參閱 [Google Cloud 驗證文件](https://cloud.google.com/docs/authentication)。

<Note>
  進行驗證時，Claude Code 將自動使用來自 `ANTHROPIC_VERTEX_PROJECT_ID` 環境變數的專案 ID。若要覆寫此設定，請設定以下其中一個環境變數：`GCLOUD_PROJECT`、`GOOGLE_CLOUD_PROJECT` 或 `GOOGLE_APPLICATION_CREDENTIALS`。
</Note>

### 4. 設定 Claude Code

設定下列環境變數：

```bash  theme={null}
# 啟用 Vertex AI 整合
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=global
export ANTHROPIC_VERTEX_PROJECT_ID=YOUR-PROJECT-ID

# 選用：如需要，停用提示快取
export DISABLE_PROMPT_CACHING=1

# 當 CLOUD_ML_REGION=global 時，覆寫不支援模型的區域
export VERTEX_REGION_CLAUDE_3_5_HAIKU=us-east5

# 選用：覆寫其他特定模型的區域
export VERTEX_REGION_CLAUDE_3_5_SONNET=us-east5
export VERTEX_REGION_CLAUDE_3_7_SONNET=us-east5
export VERTEX_REGION_CLAUDE_4_0_OPUS=europe-west1
export VERTEX_REGION_CLAUDE_4_0_SONNET=us-east5
export VERTEX_REGION_CLAUDE_4_1_OPUS=europe-west1
```

<Note>
  當您指定 `cache_control` 暫時旗標時，[提示快取](/zh-TW/docs/build-with-claude/prompt-caching)會自動支援。若要停用它，請設定 `DISABLE_PROMPT_CACHING=1`。如需提高速率限制，請聯絡 Google Cloud 支援。
</Note>

<Note>
  使用 Vertex AI 時，`/login` 和 `/logout` 命令已停用，因為驗證是透過 Google Cloud 認證處理的。
</Note>

### 5. 模型設定

Claude Code 為 Vertex AI 使用這些預設模型：

| 模型類型    | 預設值                          |
| :------ | :--------------------------- |
| 主要模型    | `claude-sonnet-4-5@20250929` |
| 小型/快速模型 | `claude-haiku-4-5@20251001`  |

<Note>
  對於 Vertex AI 使用者，Claude Code 不會自動從 Haiku 3.5 升級到 Haiku 4.5。若要手動切換到較新的 Haiku 模型，請將 `ANTHROPIC_DEFAULT_HAIKU_MODEL` 環境變數設定為完整模型名稱（例如 `claude-haiku-4-5@20251001`）。
</Note>

若要自訂模型：

```bash  theme={null}
export ANTHROPIC_MODEL='claude-opus-4-1@20250805'
export ANTHROPIC_SMALL_FAST_MODEL='claude-haiku-4-5@20251001'
```

## IAM 設定

指派必要的 IAM 權限：

`roles/aiplatform.user` 角色包含必要的權限：

* `aiplatform.endpoints.predict` - 模型呼叫和權杖計數所需

如需更嚴格的權限，請建立只包含上述權限的自訂角色。

如需詳細資訊，請參閱 [Vertex IAM 文件](https://cloud.google.com/vertex-ai/docs/general/access-control)。

<Note>
  我們建議為 Claude Code 建立專用的 GCP 專案，以簡化成本追蹤和存取控制。
</Note>

## 1M 權杖內容視窗

Claude Sonnet 4 和 Sonnet 4.5 在 Vertex AI 上支援 [1M 權杖內容視窗](/zh-TW/docs/build-with-claude/context-windows#1m-token-context-window)。

<Note>
  1M 權杖內容視窗目前處於測試版。若要使用擴展內容視窗，請在您的 Vertex AI 要求中包含 `context-1m-2025-08-07` 測試版標頭。
</Note>

## 故障排除

如果您遇到配額問題：

* 透過 [Cloud Console](https://cloud.google.com/docs/quotas/view-manage) 檢查目前配額或要求增加配額

如果您遇到「找不到模型」404 錯誤：

* 確認模型在 [Model Garden](https://console.cloud.google.com/vertex-ai/model-garden) 中已啟用
* 驗證您有權存取指定的區域
* 如果使用 `CLOUD_ML_REGION=global`，請檢查您的模型是否在 [Model Garden](https://console.cloud.google.com/vertex-ai/model-garden) 中的「支援的功能」下支援全球端點。對於不支援全球端點的模型，請執行下列其中一項：
  * 透過 `ANTHROPIC_MODEL` 或 `ANTHROPIC_SMALL_FAST_MODEL` 指定支援的模型，或
  * 使用 `VERTEX_REGION_<MODEL_NAME>` 環境變數設定區域端點

如果您遇到 429 錯誤：

* 對於區域端點，請確保主要模型和小型/快速模型在您選定的區域中受支援
* 考慮切換到 `CLOUD_ML_REGION=global` 以獲得更好的可用性

## 其他資源

* [Vertex AI 文件](https://cloud.google.com/vertex-ai/docs)
* [Vertex AI 定價](https://cloud.google.com/vertex-ai/pricing)
* [Vertex AI 配額和限制](https://cloud.google.com/vertex-ai/docs/quotas)

