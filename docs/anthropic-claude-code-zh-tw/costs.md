---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/costs.md"
fetched_at: "2025-10-29T14:10:10+08:00"
---

# 有效管理成本

> 了解如何在使用 Claude Code 時追蹤和優化代幣使用量和成本。

Claude Code 每次互動都會消耗代幣。平均成本為每位開發者每天 $6，90% 的用戶每日成本保持在 $12 以下。

對於團隊使用，Claude Code 按 API 代幣消耗量收費。平均而言，使用 Sonnet 4.5 的 Claude Code 每位開發者每月成本約為 \$100-200，但根據用戶運行的實例數量以及是否在自動化中使用，會有很大的差異。

## 追蹤您的成本

### 使用 `/cost` 命令

<Note>
  `/cost` 命令不適用於 Claude Max 和 Pro 訂閱者。
</Note>

`/cost` 命令為您的當前會話提供詳細的代幣使用統計：

```
Total cost:            $0.55
Total duration (API):  6m 19.7s
Total duration (wall): 6h 33m 10.2s
Total code changes:    0 lines added, 0 lines removed
```

### 其他追蹤選項

在 Claude Console 中檢查[歷史使用情況](https://support.claude.com/en/articles/9534590-cost-and-usage-reporting-in-console)（需要管理員或計費角色）並為 Claude Code 工作區設置[工作區支出限制](https://support.claude.com/en/articles/9796807-creating-and-managing-workspaces)（需要管理員角色）。

<Note>
  當您首次使用 Claude Console 帳戶驗證 Claude Code 時，會自動為您創建一個名為「Claude Code」的工作區。此工作區為您組織中的所有 Claude Code 使用提供集中的成本追蹤和管理。您無法為此工作區創建 API 金鑰 - 它專門用於 Claude Code 驗證和使用。
</Note>

## 為團隊管理成本

使用 Claude API 時，您可以限制 Claude Code 工作區的總支出。要配置，請[按照這些說明操作](https://support.claude.com/en/articles/9796807-creating-and-managing-workspaces)。管理員可以通過[按照這些說明操作](https://support.claude.com/en/articles/9534590-cost-and-usage-reporting-in-console)查看成本和使用情況報告。

在 Bedrock 和 Vertex 上，Claude Code 不會從您的雲端發送指標。為了獲取成本指標，幾家大型企業報告使用了 [LiteLLM](/zh-TW/docs/claude-code/bedrock-vertex-proxies#litellm)，這是一個開源工具，幫助公司[按金鑰追蹤支出](https://docs.litellm.ai/docs/proxy/virtual_keys#tracking-spend)。此項目與 Anthropic 無關，我們尚未審核其安全性。

### 速率限制建議

為團隊設置 Claude Code 時，請根據您的組織規模考慮以下每用戶每分鐘代幣數（TPM）和每分鐘請求數（RPM）建議：

| 團隊規模       | 每用戶 TPM   | 每用戶 RPM   |
| ---------- | --------- | --------- |
| 1-5 用戶     | 200k-300k | 5-7       |
| 5-20 用戶    | 100k-150k | 2.5-3.5   |
| 20-50 用戶   | 50k-75k   | 1.25-1.75 |
| 50-100 用戶  | 25k-35k   | 0.62-0.87 |
| 100-500 用戶 | 15k-20k   | 0.37-0.47 |
| 500+ 用戶    | 10k-15k   | 0.25-0.35 |

例如，如果您有 200 個用戶，您可能為每個用戶請求 20k TPM，或總共 400 萬 TPM（200\*20,000 = 400 萬）。

隨著團隊規模的增長，每用戶 TPM 會減少，因為我們預期在較大的組織中同時使用 Claude Code 的用戶會較少。這些速率限制適用於組織級別，而不是每個個人用戶，這意味著當其他人沒有積極使用服務時，個人用戶可以暫時消耗超過其計算份額。

<Note>
  如果您預期會出現異常高並發使用的情況（例如大型群組的現場培訓課程），您可能需要為每個用戶分配更高的 TPM。
</Note>

## 減少代幣使用量

* **緊湊對話：**

  * Claude 默認在上下文超過 95% 容量時使用自動緊湊
  * 切換自動緊湊：運行 `/config` 並導航到「Auto-compact enabled」
  * 當上下文變大時手動使用 `/compact`
  * 添加自定義指令：`/compact Focus on code samples and API usage`
  * 通過添加到 CLAUDE.md 來自定義緊湊：

    ```markdown  theme={null}
    # Summary instructions

    When you are using compact, please focus on test output and code changes
    ```

* **編寫具體查詢：** 避免觸發不必要掃描的模糊請求

* **分解複雜任務：** 將大型任務分解為專注的互動

* **在任務之間清除歷史：** 使用 `/clear` 重置上下文

成本可能會根據以下因素顯著變化：

* 被分析代碼庫的大小
* 查詢的複雜性
* 被搜索或修改的文件數量
* 對話歷史的長度
* 緊湊對話的頻率

## 背景代幣使用

Claude Code 即使在空閒時也會為某些背景功能使用代幣：

* **對話摘要**：為 `claude --resume` 功能摘要先前對話的背景作業
* **命令處理**：某些命令如 `/cost` 可能會生成請求來檢查狀態

這些背景進程即使沒有主動互動也會消耗少量代幣（通常每個會話低於 \$0.04）。

## 追蹤版本變更和更新

### 當前版本信息

要檢查您當前的 Claude Code 版本和安裝詳細信息：

```bash  theme={null}
claude doctor
```

此命令顯示您的版本、安裝類型和系統信息。

### 了解 Claude Code 行為變化

Claude Code 定期接收可能改變功能工作方式的更新，包括成本報告：

* **版本追蹤**：使用 `claude doctor` 查看您的當前版本
* **行為變化**：像 `/cost` 這樣的功能可能在不同版本中顯示不同的信息
* **文檔訪問**：Claude 始終可以訪問最新文檔，這可以幫助解釋當前功能行為

### 當成本報告發生變化時

如果您注意到成本顯示方式的變化（例如 `/cost` 命令顯示不同的信息）：

1. **驗證您的版本**：運行 `claude doctor` 確認您的當前版本
2. **查閱文檔**：直接詢問 Claude 當前功能行為，因為它可以訪問最新文檔
3. **聯繫支持**：對於具體的計費問題，請通過您的 Console 帳戶聯繫 Anthropic 支持

<Note>
  對於團隊部署，我們建議從小型試點群組開始建立使用模式，然後再進行更廣泛的推廣。
</Note>

