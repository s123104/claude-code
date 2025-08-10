---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/quickstart"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/quickstart)

這個快速開始指南將讓您在短短幾分鐘內使用 AI 驅動的編程輔助。完成後，您將了解如何使用 Claude Code 進行常見的開發任務。

## 開始之前

確保您有：

- 打開的終端或命令提示符
- 要使用的代碼項目

## 步驟 1：安裝 Claude Code

### NPM 安裝

如果您已經[安裝了 Node.js 18 或更新版本](https://nodejs.org/en/download/)：

### 原生安裝

**macOS、Linux、WSL：**

**Windows PowerShell：**

## 步驟 2：開始您的第一個會話

在任何項目目錄中打開您的終端並啟動 Claude Code：

您將在新的互動會話中看到 Claude Code 提示符：

## 步驟 3：提出您的第一個問題

讓我們從了解您的代碼庫開始。試試這些命令之一：

Claude 將分析您的文件並提供摘要。您也可以提出更具體的問題：

您也可以詢問 Claude 關於其自身能力的問題：

## 步驟 4：進行您的第一次代碼更改

現在讓我們讓 Claude Code 做一些實際的編程工作。試試一個簡單的任務：

Claude Code 將：

1. 找到適當的文件
2. 向您展示建議的更改
3. 請求您的批准
4. 進行編輯

## 步驟 5：在 Claude Code 中使用 Git

Claude Code 使 Git 操作變得對話化：

您也可以提示更複雜的 Git 操作：

## 步驟 6：修復錯誤或添加功能

Claude 擅長調試和功能實現。

用自然語言描述您想要的：

或修復現有問題：

Claude Code 將：

- 定位相關代碼
- 理解上下文
- 實現解決方案
- 如果可用則運行測試

## 步驟 7：測試其他常見工作流程

有多種方式與 Claude 合作：

**重構代碼**

**編寫測試**

**更新文檔**

**代碼審查**

## 基本命令

以下是日常使用最重要的命令：

| 命令                | 功能                     | 示例                                |
| ------------------- | ------------------------ | ----------------------------------- |
| `claude`            | 啟動互動模式             | `claude`                            |
| `claude "task"`     | 運行一次性任務           | `claude "fix the build error"`      |
| `claude -p "query"` | 運行一次性查詢，然後退出 | `claude -p "explain this function"` |
| `claude -c`         | 繼續最近的對話           | `claude -c`                         |
| `claude -r`         | 恢復之前的對話           | `claude -r`                         |
| `claude commit`     | 創建 Git 提交            | `claude commit`                     |
| `/clear`            | 清除對話歷史             | `> /clear`                          |
| `/help`             | 顯示可用命令             | `> /help`                           |
| `exit` 或 Ctrl+C    | 退出 Claude Code         | `> exit`                            |

查看[CLI 參考](/zh-TW/docs/claude-code/cli-reference)獲取完整的命令列表。

## 初學者專業提示

## 下一步是什麼？

現在您已經學會了基礎知識，探索更高級的功能：

## 獲取幫助

- **在 Claude Code 中**：輸入 `/help` 或詢問「how do I…」
- **文檔**：您就在這裡！瀏覽其他指南
- **社區**：加入我們的 [Discord](https://www.anthropic.com/discord) 獲取提示和支持
