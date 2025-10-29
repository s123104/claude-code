---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/quickstart.md"
fetched_at: "2025-10-29T14:11:27+08:00"
---

# 快速入門

> 歡迎使用 Claude Code！

本快速入門指南將在短短幾分鐘內讓您使用 AI 驅動的編碼協助。完成後，您將了解如何使用 Claude Code 進行常見的開發任務。

## 開始前

請確保您有：

* 打開的終端或命令提示符
* 要使用的程式碼專案
* [Claude.ai](https://claude.ai)（推薦）或 [Claude Console](https://console.anthropic.com/) 帳戶

## 步驟 1：安裝 Claude Code

### NPM 安裝

如果您已[安裝 Node.js 18 或更新版本](https://nodejs.org/en/download/)：

```sh  theme={null}
npm install -g @anthropic-ai/claude-code
```

### 原生安裝

<Tip>
  或者，試試我們新的原生安裝，目前處於測試版。
</Tip>

**Homebrew (macOS, Linux)：**

```sh  theme={null}
brew install --cask claude-code
```

**macOS, Linux, WSL：**

```bash  theme={null}
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows PowerShell：**

```powershell  theme={null}
irm https://claude.ai/install.ps1 | iex
```

**Windows CMD：**

```batch  theme={null}
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

## 步驟 2：登入您的帳戶

Claude Code 需要帳戶才能使用。當您使用 `claude` 命令啟動互動式工作階段時，您需要登入：

```bash  theme={null}
claude
# 首次使用時系統會提示您登入
```

```bash  theme={null}
/login
# 按照提示使用您的帳戶登入
```

您可以使用以下任一帳戶類型登入：

* [Claude.ai](https://claude.ai)（訂閱計畫 - 推薦）
* [Claude Console](https://console.anthropic.com/)（具有預付額度的 API 存取）

登入後，您的認證資訊會被儲存，您無需再次登入。

<Note>
  當您首次使用 Claude Console 帳戶驗證 Claude Code 時，系統會自動為您建立一個名為「Claude Code」的工作區。此工作區為您的組織中所有 Claude Code 使用情況提供集中式成本追蹤和管理。
</Note>

<Note>
  您可以在同一電子郵件地址下擁有兩種帳戶類型。如果您需要再次登入或切換帳戶，請在 Claude Code 中使用 `/login` 命令。
</Note>

## 步驟 3：啟動您的第一個工作階段

在任何專案目錄中打開您的終端並啟動 Claude Code：

```bash  theme={null}
cd /path/to/your/project
claude
```

您將看到 Claude Code 歡迎畫面，其中包含您的工作階段資訊、最近的對話和最新更新。輸入 `/help` 查看可用命令，或輸入 `/resume` 繼續之前的對話。

<Tip>
  登入後（步驟 2），您的認證資訊會儲存在您的系統上。在[認證管理](/zh-TW/docs/claude-code/iam#credential-management)中了解更多。
</Tip>

## 步驟 4：提出您的第一個問題

讓我們從了解您的程式碼庫開始。試試以下命令之一：

```
> what does this project do?
```

Claude 將分析您的檔案並提供摘要。您也可以提出更具體的問題：

```
> what technologies does this project use?
```

```
> where is the main entry point?
```

```
> explain the folder structure
```

您也可以詢問 Claude 它自己的功能：

```
> what can Claude Code do?
```

```
> how do I use slash commands in Claude Code?
```

```
> can Claude Code work with Docker?
```

<Note>
  Claude Code 會根據需要讀取您的檔案 - 您無需手動新增上下文。Claude 也可以存取自己的文件，並可以回答有關其功能和特性的問題。
</Note>

## 步驟 5：進行您的第一次程式碼變更

現在讓我們讓 Claude Code 進行一些實際的編碼。試試一個簡單的任務：

```
> add a hello world function to the main file
```

Claude Code 將：

1. 找到適當的檔案
2. 向您顯示建議的變更
3. 要求您的批准
4. 進行編輯

<Note>
  Claude Code 在修改檔案前始終會要求許可。您可以批准個別變更或為工作階段啟用「全部接受」模式。
</Note>

## 步驟 6：在 Claude Code 中使用 Git

Claude Code 使 Git 操作變得對話式：

```
> what files have I changed?
```

```
> commit my changes with a descriptive message
```

您也可以提示進行更複雜的 Git 操作：

```
> create a new branch called feature/quickstart
```

```
> show me the last 5 commits
```

```
> help me resolve merge conflicts
```

## 步驟 7：修復錯誤或新增功能

Claude 擅長除錯和功能實現。

用自然語言描述您想要的內容：

```
> add input validation to the user registration form
```

或修復現有問題：

```
> there's a bug where users can submit empty forms - fix it
```

Claude Code 將：

* 定位相關程式碼
* 理解上下文
* 實現解決方案
* 如果可用，執行測試

## 步驟 8：測試其他常見工作流程

有許多方式可以與 Claude 合作：

**重構程式碼**

```
> refactor the authentication module to use async/await instead of callbacks
```

**編寫測試**

```
> write unit tests for the calculator functions
```

**更新文件**

```
> update the README with installation instructions
```

**程式碼審查**

```
> review my changes and suggest improvements
```

<Tip>
  **記住**：Claude Code 是您的 AI 配對程式設計師。像與有幫助的同事交談一樣與它交談 - 描述您想要達成的目標，它將幫助您實現。
</Tip>

## 基本命令

以下是日常使用中最重要的命令：

| 命令                  | 功能             | 範例                                  |
| ------------------- | -------------- | ----------------------------------- |
| `claude`            | 啟動互動模式         | `claude`                            |
| `claude "task"`     | 執行一次性任務        | `claude "fix the build error"`      |
| `claude -p "query"` | 執行一次性查詢，然後退出   | `claude -p "explain this function"` |
| `claude -c`         | 繼續最近的對話        | `claude -c`                         |
| `claude -r`         | 恢復之前的對話        | `claude -r`                         |
| `claude commit`     | 建立 Git 提交      | `claude commit`                     |
| `/clear`            | 清除對話歷史         | `> /clear`                          |
| `/help`             | 顯示可用命令         | `> /help`                           |
| `exit` 或 Ctrl+C     | 退出 Claude Code | `> exit`                            |

請參閱 [CLI 參考](/zh-TW/docs/claude-code/cli-reference)以取得完整的命令列表。

## 初學者的專業提示

<AccordionGroup>
  <Accordion title="對您的請求要具體">
    不要這樣做：「修復錯誤」

    試試這樣：「修復登入錯誤，使用者輸入錯誤認證後看到空白畫面」
  </Accordion>

  <Accordion title="使用逐步指示">
    將複雜任務分解為步驟：

    ```
    > 1. create a new database table for user profiles
    ```

    ```
    > 2. create an API endpoint to get and update user profiles
    ```

    ```
    > 3. build a webpage that allows users to see and edit their information
    ```
  </Accordion>

  <Accordion title="讓 Claude 先探索">
    在進行變更之前，讓 Claude 了解您的程式碼：

    ```
    > analyze the database schema
    ```

    ```
    > build a dashboard showing products that are most frequently returned by our UK customers
    ```
  </Accordion>

  <Accordion title="使用快捷方式節省時間">
    * 按 `?` 查看所有可用的鍵盤快捷方式
    * 使用 Tab 進行命令完成
    * 按 ↑ 查看命令歷史
    * 輸入 `/` 查看所有斜線命令
  </Accordion>
</AccordionGroup>

## 接下來呢？

現在您已經學習了基礎知識，請探索更多進階功能：

<CardGroup cols={3}>
  <Card title="常見工作流程" icon="graduation-cap" href="/zh-TW/docs/claude-code/common-workflows">
    常見任務的逐步指南
  </Card>

  <Card title="CLI 參考" icon="terminal" href="/zh-TW/docs/claude-code/cli-reference">
    掌握所有命令和選項
  </Card>

  <Card title="設定" icon="gear" href="/zh-TW/docs/claude-code/settings">
    為您的工作流程自訂 Claude Code
  </Card>

  <Card title="網路上的 Claude Code" icon="cloud" href="/zh-TW/docs/claude-code/claude-code-on-the-web">
    在雲端中非同步執行任務
  </Card>
</CardGroup>

## 取得幫助

* **在 Claude Code 中**：輸入 `/help` 或詢問「我如何...」
* **文件**：您在這裡！瀏覽其他指南
* **社群**：加入我們的 [Discord](https://www.anthropic.com/discord) 以獲取提示和支援

