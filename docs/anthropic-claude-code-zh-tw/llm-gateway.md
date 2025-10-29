---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/llm-gateway.md"
fetched_at: "2025-10-29T14:11:06+08:00"
---

# LLM 閘道配置

> 學習如何使用 LLM 閘道解決方案配置 Claude Code，包括 LiteLLM 設定、身份驗證方法，以及使用追蹤和預算管理等企業功能。

LLM 閘道在 Claude Code 和模型提供商之間提供集中式代理層，提供：

* **集中式身份驗證** - API 金鑰管理的單一入口點
* **使用追蹤** - 監控團隊和專案的使用情況
* **成本控制** - 實施預算和速率限制
* **稽核日誌** - 追蹤所有模型互動以符合合規要求
* **模型路由** - 在不更改程式碼的情況下切換提供商

## LiteLLM 配置

<Note>
  LiteLLM 是第三方代理服務。Anthropic 不認可、維護或稽核 LiteLLM 的安全性或功能。本指南僅供參考，可能會過時。請自行斟酌使用。
</Note>

### 先決條件

* Claude Code 已更新至最新版本
* LiteLLM Proxy Server 已部署且可存取
* 透過您選擇的提供商存取 Claude 模型

### 基本 LiteLLM 設定

**配置 Claude Code**：

#### 身份驗證方法

##### 靜態 API 金鑰

使用固定 API 金鑰的最簡單方法：

```bash  theme={null}
# 在環境中設定
export ANTHROPIC_AUTH_TOKEN=sk-litellm-static-key

# 或在 Claude Code 設定中
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk-litellm-static-key"
  }
}
```

此值將作為 `Authorization` 標頭發送。

##### 使用輔助程式的動態 API 金鑰

用於輪換金鑰或每個使用者身份驗證：

1. 建立 API 金鑰輔助程式腳本：

```bash  theme={null}
#!/bin/bash
# ~/bin/get-litellm-key.sh

# 範例：從保險庫取得金鑰
vault kv get -field=api_key secret/litellm/claude-code

# 範例：產生 JWT 權杖
jwt encode \
  --secret="${JWT_SECRET}" \
  --exp="+1h" \
  '{"user":"'${USER}'","team":"engineering"}'
```

2. 配置 Claude Code 設定以使用輔助程式：

```json  theme={null}
{
  "apiKeyHelper": "~/bin/get-litellm-key.sh"
}
```

3. 設定權杖重新整理間隔：

```bash  theme={null}
# 每小時重新整理（3600000 毫秒）
export CLAUDE_CODE_API_KEY_HELPER_TTL_MS=3600000
```

此值將作為 `Authorization` 和 `X-Api-Key` 標頭發送。`apiKeyHelper` 的優先順序低於 `ANTHROPIC_AUTH_TOKEN` 或 `ANTHROPIC_API_KEY`。

#### 統一端點（建議）

使用 LiteLLM 的 [Anthropic 格式端點](https://docs.litellm.ai/docs/anthropic_unified)：

```bash  theme={null}
export ANTHROPIC_BASE_URL=https://litellm-server:4000
```

**統一端點相對於直通端點的優勢：**

* 負載平衡
* 故障轉移
* 一致支援成本追蹤和終端使用者追蹤

#### 提供商特定的直通端點（替代方案）

##### 透過 LiteLLM 的 Claude API

使用[直通端點](https://docs.litellm.ai/docs/pass_through/anthropic_completion)：

```bash  theme={null}
export ANTHROPIC_BASE_URL=https://litellm-server:4000/anthropic
```

##### 透過 LiteLLM 的 Amazon Bedrock

使用[直通端點](https://docs.litellm.ai/docs/pass_through/bedrock)：

```bash  theme={null}
export ANTHROPIC_BEDROCK_BASE_URL=https://litellm-server:4000/bedrock
export CLAUDE_CODE_SKIP_BEDROCK_AUTH=1
export CLAUDE_CODE_USE_BEDROCK=1
```

##### 透過 LiteLLM 的 Google Vertex AI

使用[直通端點](https://docs.litellm.ai/docs/pass_through/vertex_ai)：

```bash  theme={null}
export ANTHROPIC_VERTEX_BASE_URL=https://litellm-server:4000/vertex_ai/v1
export ANTHROPIC_VERTEX_PROJECT_ID=your-gcp-project-id
export CLAUDE_CODE_SKIP_VERTEX_AUTH=1
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5
```

### 模型選擇

預設情況下，模型將使用[模型配置](/zh-TW/docs/claude-code/bedrock-vertex-proxies#model-configuration)中指定的模型。

如果您在 LiteLLM 中配置了自訂模型名稱，請將上述環境變數設定為這些自訂名稱。

如需更詳細的資訊，請參閱 [LiteLLM 文件](https://docs.litellm.ai/)。

## 其他資源

* [LiteLLM 文件](https://docs.litellm.ai/)
* [Claude Code 設定](/zh-TW/docs/claude-code/settings)
* [企業網路配置](/zh-TW/docs/claude-code/network-config)
* [第三方整合概述](/zh-TW/docs/claude-code/third-party-integrations)

