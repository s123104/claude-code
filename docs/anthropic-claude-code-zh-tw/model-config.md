---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/model-config.md"
fetched_at: "2025-10-29T14:11:11+08:00"
---

# 模型配置

> 了解 Claude Code 模型配置，包括像 `opusplan` 這樣的模型別名

## 可用模型

對於 Claude Code 中的 `model` 設定，您可以配置：

* 一個**模型別名**
* 一個完整的\*\*[模型名稱](/zh-TW/docs/about-claude/models/overview#model-names)\*\*
* 對於 Bedrock，一個 ARN

### 模型別名

模型別名提供了一種便利的方式來選擇模型設定，而無需記住確切的版本號：

| 模型別名             | 行為                                                                                                               |
| ---------------- | ---------------------------------------------------------------------------------------------------------------- |
| **`default`**    | 推薦的模型設定，取決於您的帳戶類型                                                                                                |
| **`sonnet`**     | 使用最新的 Sonnet 模型（目前為 Sonnet 4.5）進行日常編碼任務                                                                          |
| **`opus`**       | 使用 Opus 模型（目前為 Opus 4.1）進行專業的複雜推理任務                                                                              |
| **`haiku`**      | 使用快速且高效的 Haiku 模型進行簡單任務                                                                                          |
| **`sonnet[1m]`** | 使用具有 [100 萬個 token 上下文視窗](/zh-TW/docs/build-with-claude/context-windows#1m-token-context-window)的 Sonnet 進行長時間會話 |
| **`opusplan`**   | 特殊模式，在計劃模式下使用 `opus`，然後切換到 `sonnet` 進行執行                                                                         |

### 設定您的模型

您可以通過多種方式配置您的模型，按優先順序列出：

1. **會話期間** - 使用 `/model <alias|name>` 在會話中途切換模型
2. **啟動時** - 使用 `claude --model <alias|name>` 啟動
3. **環境變數** - 設定 `ANTHROPIC_MODEL=<alias|name>`
4. **設定** - 使用 `model` 欄位在您的設定檔中永久配置。

使用範例：

```bash  theme={null}
# 使用 Opus 啟動
claude --model opus

# 在會話期間切換到 Sonnet
/model sonnet
```

設定檔範例：

```
{
    "permissions": {
        ...
    },
    "model": "opus"
}
```

## 特殊模型行為

### `default` 模型設定

`default` 的行為取決於您的帳戶類型。

對於某些 Max 用戶，如果您使用 Opus 達到使用閾值，Claude Code 將自動回退到 Sonnet。

### `opusplan` 模型設定

`opusplan` 模型別名提供了一種自動化的混合方法：

* **在計劃模式下** - 使用 `opus` 進行複雜推理和架構決策
* **在執行模式下** - 自動切換到 `sonnet` 進行程式碼生成和實作

這為您提供了兩全其美的效果：Opus 在規劃方面的卓越推理能力，以及 Sonnet 在執行方面的效率。

### 使用 \[1m] 擴展上下文

對於 Console/API 用戶，可以在完整模型名稱後添加 `[1m]` 後綴來啟用 [100 萬個 token 上下文視窗](/zh-TW/docs/build-with-claude/context-windows#1m-token-context-window)。

```bash  theme={null}
# 使用帶有 [1m] 後綴的完整模型名稱的範例
/model anthropic.claude-sonnet-4-5-20250929-v1:0[1m]
```

注意：擴展上下文模型有[不同的定價](/zh-TW/docs/about-claude/pricing#long-context-pricing)。

## 檢查您當前的模型

您可以通過多種方式查看您當前使用的模型：

1. 在[狀態列](/zh-TW/docs/claude-code/statusline)中（如果已配置）
2. 在 `/status` 中，這也會顯示您的帳戶資訊。

## 環境變數

您可以使用以下環境變數（必須是完整的**模型名稱**）來控制別名映射到的模型名稱。

| 環境變數                             | 描述                                                                           |
| -------------------------------- | ---------------------------------------------------------------------------- |
| `ANTHROPIC_DEFAULT_OPUS_MODEL`   | 用於 `opus` 的模型，或當計劃模式啟用時用於 `opusplan` 的模型。                                    |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | 用於 `sonnet` 的模型，或當計劃模式未啟用時用於 `opusplan` 的模型。                                 |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL`  | 用於 `haiku` 的模型，或[背景功能](/zh-TW/docs/claude-code/costs#background-token-usage) |
| `CLAUDE_CODE_SUBAGENT_MODEL`     | 用於[子代理](/zh-TW/docs/claude-code/sub-agents)的模型                               |

注意：`ANTHROPIC_SMALL_FAST_MODEL` 已棄用，改用 `ANTHROPIC_DEFAULT_HAIKU_MODEL`。

### 提示快取配置

Claude Code 自動使用[提示快取](/zh-TW/docs/build-with-claude/prompt-caching)來優化性能並降低成本。您可以全域禁用提示快取或針對特定模型層級禁用：

| 環境變數                            | 描述                               |
| ------------------------------- | -------------------------------- |
| `DISABLE_PROMPT_CACHING`        | 設定為 `1` 以禁用所有模型的提示快取（優先於每個模型的設定） |
| `DISABLE_PROMPT_CACHING_HAIKU`  | 設定為 `1` 以僅禁用 Haiku 模型的提示快取       |
| `DISABLE_PROMPT_CACHING_SONNET` | 設定為 `1` 以僅禁用 Sonnet 模型的提示快取      |
| `DISABLE_PROMPT_CACHING_OPUS`   | 設定為 `1` 以僅禁用 Opus 模型的提示快取        |

這些環境變數為您提供了對提示快取行為的細粒度控制。全域 `DISABLE_PROMPT_CACHING` 設定優先於特定模型的設定，允許您在需要時快速禁用所有快取。每個模型的設定對於選擇性控制很有用，例如在調試特定模型或使用可能有不同快取實作的雲端提供商時。

