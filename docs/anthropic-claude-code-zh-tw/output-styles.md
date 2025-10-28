---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/output-styles.md"
fetched_at: "2025-10-28T19:18:18+08:00"
---

# 輸出樣式

> 調整 Claude Code 以用於軟體工程以外的用途

輸出樣式讓您可以將 Claude Code 用作任何類型的代理，同時保持其核心功能，例如執行本地腳本、讀取/寫入檔案和追蹤 TODO。

## 內建輸出樣式

Claude Code 的**預設**輸出樣式是現有的系統提示，旨在幫助您高效完成軟體工程任務。

還有兩種額外的內建輸出樣式，專注於教您程式碼庫和 Claude 的運作方式：

* **解釋性**：在幫助您完成軟體工程任務的過程中提供教育性的「洞察」。幫助您理解實作選擇和程式碼庫模式。

* **學習**：協作式的邊做邊學模式，Claude 不僅會在編碼時分享「洞察」，還會要求您自己貢獻小而策略性的程式碼片段。Claude Code 會在您的程式碼中添加 `TODO(human)` 標記供您實作。

## 輸出樣式的運作方式

輸出樣式直接修改 Claude Code 的系統提示。

* 非預設輸出樣式排除了通常內建在 Claude Code 中特定於程式碼生成和高效輸出的指令（例如簡潔回應和用測試驗證程式碼）。
* 相反，這些輸出樣式有自己的自訂指令添加到系統提示中。

## 更改您的輸出樣式

您可以：

* 執行 `/output-style` 來存取選單並選擇您的輸出樣式（這也可以從 `/config` 選單存取）

* 執行 `/output-style [樣式]`，例如 `/output-style explanatory`，直接切換到某個樣式

這些更改適用於[本地專案層級](/zh-TW/docs/claude-code/settings)，並保存在 `.claude/settings.local.json` 中。

## 建立自訂輸出樣式

要在 Claude 的幫助下設定新的輸出樣式，請執行
`/output-style:new I want an output style that ...`

預設情況下，透過 `/output-style:new` 建立的輸出樣式會以 markdown 檔案的形式保存在使用者層級的 `~/.claude/output-styles` 中，並可跨專案使用。它們具有以下結構：

```markdown  theme={null}
---
name: My Custom Style
description:
  A brief description of what this style does, to be displayed to the user
---

# Custom Style Instructions

You are an interactive CLI tool that helps users with software engineering
tasks. [Your custom instructions here...]

## Specific Behaviors

[Define how the assistant should behave in this style...]
```

您也可以建立自己的輸出樣式 Markdown 檔案，並將它們保存在使用者層級（`~/.claude/output-styles`）或專案層級（`.claude/output-styles`）。

## 與相關功能的比較

### 輸出樣式 vs. CLAUDE.md vs. --append-system-prompt

輸出樣式完全「關閉」Claude Code 預設系統提示中特定於軟體工程的部分。CLAUDE.md 和 `--append-system-prompt` 都不會編輯 Claude Code 的預設系統提示。CLAUDE.md 將內容作為使用者訊息添加在 Claude Code 預設系統提示\_之後\_。`--append-system-prompt` 將內容附加到系統提示。

### 輸出樣式 vs. [代理](/zh-TW/docs/claude-code/sub-agents)

輸出樣式直接影響主代理迴圈，只影響系統提示。代理被調用來處理特定任務，可以包括額外的設定，如要使用的模型、它們可用的工具，以及關於何時使用代理的一些上下文。

### 輸出樣式 vs. [自訂斜線指令](/zh-TW/docs/claude-code/slash-commands)

您可以將輸出樣式視為「儲存的系統提示」，將自訂斜線指令視為「儲存的提示」。

