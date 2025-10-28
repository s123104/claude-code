---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/terminal-config.md"
fetched_at: "2025-10-28T19:19:51+08:00"
---

# 優化您的終端機設定

> Claude Code 在您的終端機正確配置時運作最佳。請遵循這些指導原則來優化您的體驗。

### 主題和外觀

Claude 無法控制您終端機的主題。這是由您的終端機應用程式處理的。您可以隨時透過 `/config` 命令將 Claude Code 的主題與您的終端機匹配。

如需進一步自訂 Claude Code 介面本身，您可以配置一個[自訂狀態列](/zh-TW/docs/claude-code/statusline)來在終端機底部顯示上下文資訊，如目前模型、工作目錄或 git 分支。

### 換行

您有幾個選項可以在 Claude Code 中輸入換行：

* **快速跳脫**：輸入 `\` 然後按 Enter 來建立新行
* **鍵盤快捷鍵**：設定按鍵綁定來插入新行

#### 設定 Shift+Enter（VS Code 或 iTerm2）：

在 Claude Code 中執行 `/terminal-setup` 來自動配置 Shift+Enter。

#### 設定 Option+Enter（VS Code、iTerm2 或 macOS Terminal.app）：

**對於 Mac Terminal.app：**

1. 開啟設定 → 描述檔 → 鍵盤
2. 勾選「使用 Option 作為 Meta 鍵」

**對於 iTerm2 和 VS Code 終端機：**

1. 開啟設定 → 描述檔 → 按鍵
2. 在一般設定下，將左/右 Option 鍵設為「Esc+」

### 通知設定

透過適當的通知配置，永遠不會錯過 Claude 完成任務的時機：

#### iTerm 2 系統通知

對於 iTerm 2 在任務完成時的警示：

1. 開啟 iTerm 2 偏好設定
2. 導航至描述檔 → 終端機
3. 啟用「靜音鈴聲」和篩選警示 → 「傳送跳脫序列產生的警示」
4. 設定您偏好的通知延遲

請注意，這些通知是 iTerm 2 特有的，在預設的 macOS 終端機中不可用。

#### 自訂通知掛鉤

對於進階通知處理，您可以建立[通知掛鉤](/zh-TW/docs/claude-code/hooks#notification)來執行您自己的邏輯。

### 處理大型輸入

在處理大量程式碼或長指令時：

* **避免直接貼上**：Claude Code 可能會在處理非常長的貼上內容時遇到困難
* **使用基於檔案的工作流程**：將內容寫入檔案並要求 Claude 讀取它
* **注意 VS Code 限制**：VS Code 終端機特別容易截斷長貼上內容

### Vim 模式

Claude Code 支援 Vim 按鍵綁定的子集，可以透過 `/vim` 啟用或透過 `/config` 配置。

支援的子集包括：

* 模式切換：`Esc`（到 NORMAL）、`i`/`I`、`a`/`A`、`o`/`O`（到 INSERT）
* 導航：`h`/`j`/`k`/`l`、`w`/`e`/`b`、`0`/`$`/`^`、`gg`/`G`
* 編輯：`x`、`dw`/`de`/`db`/`dd`/`D`、`cw`/`ce`/`cb`/`cc`/`C`、`.`（重複）

