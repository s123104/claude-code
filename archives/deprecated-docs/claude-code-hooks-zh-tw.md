# Claude Code Hooks 完整指南

> ⚠️ **歸檔警告**
>
> 本文檔已於 **2025-12-24** 歸檔。此專案已停止維護（最後更新 2025-07-20），建議改用：
>
> - **官方 Hooks 文檔**：[docs.anthropic.com/en/docs/claude-code/hooks](https://docs.anthropic.com/en/docs/claude-code/hooks)
> - **官方繁中文檔**：[/docs/anthropic-claude-code-zh-tw/hooks.md](/docs/anthropic-claude-code-zh-tw/hooks.md)
>
> 以下內容僅供歷史參考。

---

> 透過註冊 shell 命令，客製化並擴展您的 Claude Code 工作流程。

## 概述

Claude Code Hooks 是一個完整的 Hooks 系統指南，展示如何在 Claude Code 中使用 hooks（生命週期鉤子）來自動化工作流程、增強安全性、提升開發效率。本指南提供從基礎到進階的完整教學，包含實用範例和最佳實踐。

> **專案資訊**
>
> - **專案名稱**：Claude Code Hooks
> - **專案版本**：無（教學專案）
> - **專案最後更新**：2025-07-20
> - **文件整理時間**：2025-12-24T01:59:00+08:00
>
> **核心定位**
>
> - **功能**：完整的 Claude Code Hooks 使用指南，包含入門教學、核心概念、實用範例、安全考量、疑難排解
> - **場景**：學習 hooks、理解生命週期、自訂工作流程、自動化開發任務、安全防護
> - **客群**：Claude Code 使用者、開發者、工作流程設計者、DevOps 工程師
>
> **資料來源**
>
> - [GitHub 專案](https://github.com/aliceric27/claude-code-hooks)
> - [Claude Code 官方 Hooks 文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)

---

## 📖 目錄

- [總覽](#總覽)
  - [什麼是 Hooks？](#什麼是-hooks)
  - [為什麼要使用 Hooks？](#為什麼要使用-hooks)
- [入門教學](#入門教學)
  - [步驟 1：您的第一個 Hook - 檔案變更日誌](#步驟-1您的第一個-hook---檔案變更日誌)
  - [步驟 2：加入條件 - 使用匹配器](#步驟-2加入條件---使用匹配器)
  - [步驟 3：與 Claude 互動 - 記錄執行的命令](#步驟-3與-claude-互動---記錄執行的命令)
- [核心概念](#核心概念)
  - [Hook 事件生命週期](#hook-事件生命週期)
  - [Hook 的輸入 (stdin)](#hook-的輸入-stdin)
  - [Hook 的輸出與控制](#hook-的輸出與控制)
  - [設定檔位置](#設定檔位置)
- [實用範例庫](#實用範例庫)
  - [程式碼自動格式化](#1-程式碼自動格式化)
  - [進階：使用 Python 腳本進行智慧驗證](#2-進階使用-python-腳本進行智慧驗證)
  - [自訂通知系統](#3-自訂通知系統)
  - [安全防護範例](#4-安全防護範例)
  - [官方範例：Bash 命令驗證](#5-官方範例bash-命令驗證)
  - [官方範例：使用者提示驗證與上下文添加](#6-官方範例使用者提示驗證與上下文添加)
  - [智慧備份系統](#7-智慧備份系統)
  - [自動測試執行](#8-自動測試執行)
- [Hook 執行細節](#hook-執行細節)
  - [執行環境與限制](#執行環境與限制)
  - [Hook 匹配規則](#hook-匹配規則)
  - [常見工具匹配器](#常見工具匹配器)
- [進階功能](#進階功能)
  - [MCP 工具整合](#mcp-工具整合)
  - [使用外部腳本](#使用外部腳本)
- [安全考量](#安全考量)
  - [免責聲明](#免責聲明)
  - [重要安全原則](#重要安全原則)
  - [具體防護措施](#具體防護措施)
  - [專案設定安全性](#專案設定安全性)
- [疑難排解](#疑難排解)
  - [常見問題及解決方案](#常見問題及解決方案)
  - [除錯工具](#除錯工具)
- [最佳實踐總結](#最佳實踐總結)
  - [推薦做法](#推薦做法)
  - [避免事項](#避免事項)
  - [進階技巧](#進階技巧)
- [結語](#結語)
- [參考資源](#參考資源)

---

## 總覽

### 什麼是 Hooks？

Hooks 是您定義的 shell 命令，它們會在 Claude Code 生命週期的特定時間點自動執行。您可以把它們想像成是為您的 AI 程式設計夥伴設定的「自動化規則」或「觸發器」。

與其在提示中反覆告訴 Claude 要遵守某些規則，不如將這些規則編碼為 Hooks，使其成為您開發環境中可靠且自動化的一部分。

### 為什麼要使用 Hooks？

Hooks 讓您能夠對 Claude Code 的行為進行確定性的控制，確保某些動作總是會發生。常見的使用情境包括：

- **✍️ 自動格式化**: 在 Claude 每次編輯完畢後，自動對 `.ts` 檔案執行 `prettier`，或對 `.go` 檔案執行 `gofmt`。
- **🔔 自訂通知**: 當 Claude 等待您的指令或執行權限時，透過系統通知或聲音提醒您。
- **🛡️ 安全防護**: 阻止 Claude 執行危險的命令（例如 `rm -rf`）或修改生產環境的設定檔。
- **📝 合規性記錄**: 追蹤所有由 Claude 執行的 shell 命令，以滿足稽核或除錯需求。
- **💡 自動回饋**: 當 Claude 產生的程式碼不符合您的專案規範時，自動向它提供修正建議。

---

## 入門教學

本教學將引導您建立三個 Hooks，從簡單到複雜，逐步掌握核心概念。

### 步驟 1：您的第一個 Hook - 檔案變更日誌

我們的第一個 Hook 非常簡單：每當 Claude 儲存一個檔案時，我們就在一個日誌檔中記錄下來。這個範例不需要任何外部工具。

1.  在終端機中執行 `/hooks` 命令，打開 Hooks 設定介面。
2.  從事件列表中選擇 `PostToolUse`。這個事件會在 Claude 成功執行工具**之後**觸發。
3.  選擇 `+ Add new matcher…`，輸入 `Write|Edit|MultiEdit` 來匹配檔案操作工具。
4.  選擇 `+ Add new hook…`，然後輸入以下命令：
    ```bash
    echo "Claude edited a file at $(date)" >> ~/.claude/file-edit-log.txt
    ```
5.  按 `Enter` 儲存 Hook。系統會詢問您儲存位置，選擇 `User settings`（使用者設定），這樣這個 Hook 就會在您所有的專案中生效。
6.  按 `Esc` 退出設定介面。

**驗證一下**：現在，請 Claude 隨意修改您專案中的任何一個檔案。完成後，檢查日誌檔的內容：

```bash
cat ~/.claude/file-edit-log.txt
```

您應該會看到類似 "Claude edited a file at [日期時間]" 的訊息。恭喜，您已經成功建立了第一個 Hook！

### 步驟 2：加入條件 - 使用匹配器

上一個 Hook 會在**任何**檔案被編輯後觸發。如果我們只想在特定工具被使用時觸發呢？這時就需要使用「匹配器」。

1.  再次執行 `/hooks`，選擇 `PostToolUse` 事件。
2.  選擇 `+ Add new matcher…`，輸入 `Bash`。這樣 Hook 就只會在 Claude 執行 shell 命令後觸發。
3.  新增一個 Hook 命令：
    ```bash
    echo "Claude ran a bash command at $(date)" >> ~/.claude/bash-log.txt
    ```
4.  儲存設定並退出。

**驗證一下**：

- 請 Claude 執行一個 shell 命令，例如「列出目前目錄的檔案」。檢查 `~/.claude/bash-log.txt`，您會發現新增了一條日誌。
- 再請 Claude 編輯一個檔案。這次只會在 `file-edit-log.txt` 中看到記錄，而不會在 `bash-log.txt` 中看到。

匹配器讓您可以精準控制 Hook 的觸發時機與對象。

### 步驟 3：與 Claude 互動 - 記錄執行的命令

現在，我們來挑戰一個更進階的 Hook：記錄 Claude 嘗試執行的所有 shell 命令詳細資訊。這個 Hook 會讀取 Claude 傳遞的資料，並需要 `jq` 工具來解析 JSON。

**先決條件**：請確保您已安裝 `jq`。如果沒有，請使用您的套件管理器安裝：

- macOS: `brew install jq`
- Ubuntu/Debian: `sudo apt-get install jq`
- Windows: 下載自 https://stedolan.github.io/jq/

1.  執行 `/hooks`，這次選擇 `PreToolUse` 事件。這個事件在 Claude **準備**執行一個工具（如 `bash` 命令）**之前**觸發。
2.  為這個 Hook 新增一個匹配器，輸入 `Bash`，這樣它就只會監控 shell 命令。
3.  選擇 `+ Add new hook…` 並輸入以下命令：
    ```bash
    jq -r '"COMMAND: \(.tool_input.command) | DESCRIPTION: \(.tool_input.description // "None")"' >> ~/.claude/bash-command-log.txt
    ```
    這個命令會從傳入的 JSON 資料中提取 `command` 和 `description` 欄位，並將其格式化後寫入日誌檔。
4.  儲存為 `User settings` 並退出。

**驗證一下**：請 Claude 執行一個 shell 命令，例如「列出目前目錄的所有檔案」。在您授權 Claude 執行之前，這個 Hook 就已經被觸發了。檢查日誌檔：

```bash
cat ~/.claude/bash-command-log.txt
```

您應該會看到類似 `COMMAND: ls -l | DESCRIPTION: List all files in the current directory` 的記錄。

透過這個教學，您已經學會了：

- 如何在特定事件上建立 Hook
- 如何使用匹配器來過濾事件
- 如何讀取 Claude 傳遞的上下文資料

---

## 核心概念

### Hook 事件生命週期

Hooks 可以在 Claude Code 生命週期的多個時間點觸發。以下是主要的事件類型：

| 事件名稱           | 觸發時機                                  | 常見用途                                 | 可阻止操作 |
| ------------------ | ----------------------------------------- | ---------------------------------------- | ---------- |
| `UserPromptSubmit` | 使用者提交提示後，Claude 處理**之前**     | 驗證提示、根據提示內容注入額外上下文     | ✅ 是      |
| `PreToolUse`       | 在工具（如 `Bash`）被執行**之前**         | 阻止危險命令、記錄意圖、修改命令         | ✅ 是      |
| `PostToolUse`      | 在工具執行**之後**                        | 記錄執行結果、基於結果觸發下一步         | ❌ 否      |
| `Notification`     | 當需要發送通知時                          | 自訂通知方式、聲音提醒                   | ❌ 否      |
| `Stop`             | 當 Claude 完成任務或遇到錯誤時            | 清理工作、後續處理                       | ✅ 是      |
| `SubagentStop`     | 當子代理（Task 工具）完成時               | 針對子任務的後續處理                     | ✅ 是      |
| `PreCompact`       | 在 Claude 執行上下文壓縮**之前**          | 根據壓縮類型執行不同操作、備份重要上下文 | ❌ 否      |
| `SessionStart`     | 當 Claude Code 開始新會話或恢復現有會話時 | 載入開發內容、安裝依賴項、設定環境變數   | ❌ 否      |
| `SessionEnd`       | 當 Claude Code 會話結束時                 | 清理工作、記錄會話統計資訊、儲存會話狀態 | ❌ 否      |

### Hook 的輸入 (stdin)

每個 Hook 在執行時，都會透過標準輸入（`stdin`）接收一個包含上下文資訊的 JSON 物件。您可以使用 `jq` 或其他工具來解析它。

**通用欄位:**

```json
{
  "session_id": "string",
  "transcript_path": "string", // 對話記錄檔路徑
  "cwd": "string", // Hook 被調用時的當前工作目錄
  "permission_mode": "string", // 目前許可模式："default"、"plan"、"acceptEdits" 或 "bypassPermissions"
  "hook_event_name": "string" // 觸發的 Hook 事件名稱
}
```

**`PreToolUse` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/path/to/project",
  "hook_event_name": "PreToolUse",
  "tool_name": "Bash",
  "tool_input": {
    "command": "ls -a",
    "description": "List all files, including hidden ones."
  }
}
```

**`PostToolUse` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/path/to/project",
  "hook_event_name": "PostToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.ts",
    "content": "console.log('Hello World');"
  },
  "tool_response": {
    "filePath": "/path/to/file.ts",
    "success": true
  }
}
```

**`Notification` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/path/to/project",
  "hook_event_name": "Notification",
  "message": "Claude needs your permission to use Bash"
}
```

**`UserPromptSubmit` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/path/to/project",
  "hook_event_name": "UserPromptSubmit",
  "prompt": "Write a function to calculate the factorial of a number"
}
```

**`Stop` / `SubagentStop` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/path/to/project",
  "hook_event_name": "Stop",
  "stop_hook_active": true
}
```

> `stop_hook_active` 為 `true` 表示 Claude 正在因為前一個 `Stop` Hook 的結果而繼續執行。您可以檢查此值以避免無限循環。

**`PreCompact` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/path/to/project",
  "permission_mode": "default",
  "hook_event_name": "PreCompact",
  "trigger": "manual",
  "custom_instructions": ""
}
```

> - `trigger`: 壓縮觸發原因
>   - `"manual"`: 由使用者透過 `/compact` 命令手動觸發
>   - `"auto"`: 由於上下文視窗已滿而自動觸發
> - `custom_instructions`: 對於 `manual` 觸發，包含使用者傳遞給 `/compact` 的自訂指令；對於 `auto` 觸發，此欄位為空字串

**`SessionStart` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "permission_mode": "default",
  "hook_event_name": "SessionStart",
  "source": "startup"
}
```

> - `source`: 會話啟動來源
>   - `"startup"`: 從啟動呼叫
>   - `"resume"`: 從 `--resume`、`--continue` 或 `/resume` 呼叫
>   - `"clear"`: 從 `/clear` 呼叫
>   - `"compact"`: 從自動或手動壓縮呼叫
>
> **持久化環境變數**: SessionStart hooks 可以存取 `CLAUDE_ENV_FILE` 環境變數，該變數提供一個檔案路徑，您可以在其中持久化環境變數供後續 bash 命令使用。寫入此檔案的任何變數都將在 Claude Code 在會話期間執行的所有後續 bash 命令中可用。
>
> **範例：設定個別環境變數**
>
> ```bash
> #!/bin/bash
> if [ -n "$CLAUDE_ENV_FILE" ]; then
>   echo 'export NODE_ENV=production' >> "$CLAUDE_ENV_FILE"
>   echo 'export API_KEY=your-api-key' >> "$CLAUDE_ENV_FILE"
>   echo 'export PATH="$PATH:./node_modules/.bin"' >> "$CLAUDE_ENV_FILE"
> fi
> exit 0
> ```
>
> **範例：持久化 hook 中的所有環境變更**
>
> ```bash
> #!/bin/bash
> ENV_BEFORE=$(export -p | sort)
> # Run your setup commands that modify the environment
> source ~/.nvm/nvm.sh
> nvm use 20
> if [ -n "$CLAUDE_ENV_FILE" ]; then
>   ENV_AFTER=$(export -p | sort)
>   comm -13 <(echo "$ENV_BEFORE") <(echo "$ENV_AFTER") >> "$CLAUDE_ENV_FILE"
> fi
> exit 0
> ```
>
> ⚠️ **注意**: `CLAUDE_ENV_FILE` 僅適用於 SessionStart hooks。其他 hook 類型無法存取此變數。

**`SessionEnd` 的輸入範例:**

```json
{
  "session_id": "abc123",
  "transcript_path": "~/.claude/projects/.../session.jsonl",
  "cwd": "/Users/...",
  "permission_mode": "default",
  "hook_event_name": "SessionEnd",
  "reason": "exit"
}
```

> - `reason`: 會話結束原因
>   - `"clear"`: 使用 `/clear` 命令清除會話
>   - `"logout"`: 使用者登出
>   - `"prompt_input_exit"`: 使用者在提示輸入可見時退出
>   - `"other"`: 其他退出原因

### Hook 的輸出與控制

Hook 可以透過兩種方式影響 Claude Code 的行為：**簡單的退出碼**或**進階的 JSON 輸出**。輸出主要用來溝通是否要阻止操作，以及應該向 Claude 和使用者顯示什麼回饋。

#### 1. 簡單控制：退出代碼 (Exit Code)

這是最基本的回饋機制。

- **退出代碼 0**: 成功。`stdout` 的內容會以一般資訊的形式顯示給使用者（在 transcript 模式下可見），但 Claude **不會**看到。**例外**：`UserPromptSubmit` 和 `SessionStart` hooks 的 `stdout` 會被新增到 Claude 的上下文中。
- **退出代碼 2**: 阻擋性錯誤。`stderr` 的內容會作為回饋**提供給 Claude** 進行處理。不同事件的具體行為不同（見下表）。
- **其他退出代碼**: 非阻擋性錯誤。`stderr` 的內容只會顯示給使用者，操作會繼續執行。

**退出代碼 2 的行為細節**

| Hook 事件          | 阻擋行為                                      |
| ------------------ | --------------------------------------------- |
| `PreToolUse`       | 阻止工具呼叫，向 Claude 顯示 stderr           |
| `PostToolUse`      | 向 Claude 顯示 stderr（工具已執行）           |
| `Notification`     | 不適用，僅向使用者顯示 stderr                 |
| `UserPromptSubmit` | 阻止提示處理，清除提示，僅向使用者顯示 stderr |
| `Stop`             | 阻止停止，向 Claude 顯示 stderr               |
| `SubagentStop`     | 阻止停止，向 Claude 子代理顯示 stderr         |
| `PreCompact`       | 不適用，僅向使用者顯示 stderr                 |
| `SessionStart`     | 不適用，僅向使用者顯示 stderr                 |
| `SessionEnd`       | 不適用，僅向使用者顯示 stderr                 |

⚠️ **重要提醒**: 當退出代碼為 0 時，Claude Code 看不到 stdout，除了 `UserPromptSubmit` hook，其中 stdout 被注入為上下文。`SessionStart` hook 的 stdout 也會被新增到上下文。

#### 2. 進階控制：JSON 輸出

為了進行更精細的控制，Hook 可以透過 `stdout` 返回一個 JSON 物件。

**通用 JSON 欄位 (適用於所有事件):**

```json
{
  "continue": true,
  "stopReason": "使用者要求的操作已終止",
  "suppressOutput": true,
  "systemMessage": "可選的警告訊息，顯示給使用者"
}
```

- `continue` (`boolean`, 預設 `true`): 設為 `false` 可在 Hook 執行後完全終止 Claude 的後續處理。
- `stopReason` (`string`): 當 `continue` 為 `false` 時，向使用者顯示的停止原因（**不會**顯示給 Claude）。
- `suppressOutput` (`boolean`, 預設 `false`): 設為 `true` 可以隱藏 Hook 的 `stdout`，使其不在 transcript 模式中顯示。
- `systemMessage` (`string`, 可選): 可選的警告訊息，顯示給使用者。

**重要行為說明:**

- 當 `continue` 為 `false` 時，會優先於任何 `"decision": "block"` 設定
- 對於 `PreToolUse`，這與 `"decision": "block"` 不同 - 後者只阻擋特定工具呼叫並提供自動回饋給 Claude
- 對於 `PostToolUse`，這與 `"decision": "block"` 不同 - 後者提供自動回饋給 Claude
- 對於 `UserPromptSubmit`，這會阻止提示被處理
- 對於 `Stop` 和 `SubagentStop`，這會優先於任何 `"decision": "block"` 輸出

**特定事件的決策控制:**

- **`PreToolUse`**: 控制工具是否執行。

  ⚠️ **重要變更**: `decision` 和 `reason` 欄位已針對 PreToolUse hooks 棄用。改用 `hookSpecificOutput.permissionDecision` 和 `hookSpecificOutput.permissionDecisionReason`。已棄用的欄位 `"approve"` 和 `"block"` 對應到 `"allow"` 和 `"deny"`。

  ```json
  {
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "allow" | "deny" | "ask",
      "permissionDecisionReason": "批准或阻擋原因",
      "updatedInput": {
        "field_to_modify": "new value"
      }
    }
  }
  ```

  - `"allow"`: 繞過許可系統，直接執行。`permissionDecisionReason` 向使用者顯示但不向 Claude 顯示。
  - `"deny"`: 防止工具呼叫執行。`permissionDecisionReason` 向 Claude 顯示。
  - `"ask"`: 要求使用者在 UI 中確認工具呼叫。`permissionDecisionReason` 向使用者顯示但不向 Claude 顯示。
  - `updatedInput`: 允許您在工具執行前修改工具的輸入參數。這是一個 `Record<string, unknown>` 物件，包含您想要變更或新增的欄位。這在 `"permissionDecision": "allow"` 時最有用，可以修改和批准工具呼叫。

- **`PostToolUse`**: 控制是否需要 Claude 進行後續處理。

  ```json
  {
    "decision": "block" | undefined,
    "reason": "需要 Claude 處理的回饋資訊",
    "hookSpecificOutput": {
      "hookEventName": "PostToolUse",
      "additionalContext": "為 Claude 新增要考慮的上下文"
    }
  }
  ```

  - `"block"`: 自動提示 Claude 使用 `reason`。
  - `undefined`: 不執行任何操作。`reason` 被忽略。
  - `hookSpecificOutput.additionalContext`: 為 Claude 新增要考慮的上下文。

- **`Stop` / `SubagentStop`**: 控制 Claude 是否必須繼續。

  ```json
  {
    "decision": "block" | undefined,
    "reason": "必須提供當 Claude 被阻止停止時"
  }
  ```

  - `"block"`: 防止 Claude 停止。您必須填入 `reason` 以便 Claude 知道如何進行。
  - `undefined`: 允許 Claude 停止。`reason` 被忽略。

- **`UserPromptSubmit`**: 控制使用者提示是否被處理。

  ```json
  {
    "decision": "block" | undefined,
    "reason": "向使用者顯示的阻擋原因",
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": "如果未被阻止，將字串新增到上下文"
    }
  }
  ```

  - `"block"`: 防止提示被處理。提交的提示從上下文中清除。`"reason"` 向使用者顯示但不新增到上下文。
  - `undefined`: 允許提示正常進行。`"reason"` 被忽略。
  - `hookSpecificOutput.additionalContext`: 如果未被阻止，將字串新增到上下文。

  > **注意**: 對於 `UserPromptSubmit` hooks，您可以使用任一方法注入上下文：
  >
  > - 退出代碼 0 加 stdout：Claude 看到上下文（`UserPromptSubmit` 的特殊情況）
  > - JSON 輸出：提供對行為的更多控制

- **`SessionStart`**: 允許您在會話開始時載入上下文。

  ```json
  {
    "hookSpecificOutput": {
      "hookEventName": "SessionStart",
      "additionalContext": "我的額外上下文"
    }
  }
  ```

  - `hookSpecificOutput.additionalContext`: 將字串新增到上下文。
  - 多個 hooks 的 `additionalContext` 值被連接。

  > **注意**: `SessionStart` hook 的 stdout 也會被新增到上下文。

- **`SessionEnd`**: 在會話結束時執行。它們無法阻止會話終止，但可以執行清理工作。

### 設定檔位置

Claude Code 的設定檔結構如下，您可以將 Hooks 設定放在其中：

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

- `matcher`: 工具名稱模式匹配（例如 `Edit|Write`），支援簡單字串精確匹配和正規表示式，對大小寫敏感。如果省略或為空字串，則會對所有工具生效。
- `hooks`: 一組要執行的命令。
- `command`: 要執行的 shell 命令。
- `timeout` (可選): 命令執行的超時時間（秒）。

**設定檔層級:**

- **使用者設定** (`~/.claude/settings.json`): 在這裡設定的 Hooks 會在您所有的專案中生效。適合通用規則，如通知、日誌記錄。
- **專案設定** (`<project_root>/.claude/settings.json`): 在這裡設定的 Hooks **僅**對當前專案生效。適合專案特定的規則，如程式碼格式化、特定於專案的安全防護。
- **本地專案設定** (`<project_root>/.claude/settings.local.json`): 本地設定，不會被版本控制。
- **企業管理政策設定**: 如果您在企業環境中，管理員可能已配置全域策略設定。

### 專案特定的 Hook 指令碼

您可以使用環境變數 `CLAUDE_PROJECT_DIR`（僅在 Claude Code 生成 hook 命令時可用）來參考儲存在您專案中的指令碼，確保無論 Claude 的目前目錄如何，它們都能正常運作：

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check-style.sh"
          }
        ]
      }
    ]
  }
}
```

### 外掛程式 Hooks

[外掛程式](/zh-TW/docs/claude-code/plugins) 可以提供與您的使用者和專案 hooks 無縫整合的 hooks。啟用外掛程式時，外掛程式 hooks 會自動與您的配置合併。

**外掛程式 hooks 的運作方式**：

- 外掛程式 hooks 在外掛程式的 `hooks/hooks.json` 檔案或由 `hooks` 欄位的自訂路徑指定的檔案中定義。
- 啟用外掛程式時，其 hooks 會與使用者和專案 hooks 合併
- 來自不同來源的多個 hooks 可以回應相同的事件
- 外掛程式 hooks 使用 `${CLAUDE_PLUGIN_ROOT}` 環境變數來參考外掛程式檔案

**外掛程式 hook 配置範例**：

```json
{
  "description": "Automatic code formatting",
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

> **注意**: 外掛程式 hooks 使用與一般 hooks 相同的格式，並可選擇使用 `description` 欄位來說明 hook 的用途。

> **注意**: 外掛程式 hooks 與您的自訂 hooks 並行執行。如果多個 hooks 匹配一個事件，它們都會並行執行。

**外掛程式的環境變數**：

- `${CLAUDE_PLUGIN_ROOT}`：外掛程式目錄的絕對路徑
- `${CLAUDE_PROJECT_DIR}`：專案根目錄（與專案 hooks 相同）
- 所有標準環境變數都可用

⚠️ **重要提醒**: `"matcher": "*"` 是無效的語法。如果要匹配所有工具，請省略 `matcher` 欄位或使用 `"matcher": ""`。

---

## 實用範例庫

這裡有一些可以直接使用的範例，幫助您快速提升效率。

### 1. 程式碼自動格式化

#### TypeScript/JavaScript (Prettier)

在 Claude 每次修改完檔案後，自動執行 Prettier 格式化。

**設定:**

- **事件**: `PostToolUse`
- **匹配器**: `Edit|MultiEdit|Write`
- **Hook 命令**:

```bash
# 檢查是否為 JS/TS 檔案並執行 prettier
file_path=$(jq -r '.tool_input.file_path // ""')
if [[ "$file_path" =~ \.(js|jsx|ts|tsx)$ ]] && [[ -f "$file_path" ]] && [[ -f "package.json" ]]; then
    npx --no-install prettier --write "$file_path"
    echo "✨ 已自動格式化檔案: $file_path"
fi
```

#### Go 程式碼格式化

**設定:**

- **事件**: `PostToolUse`
- **匹配器**: `Edit|MultiEdit|Write`
- **Hook 命令**:

```bash
# 檢查是否為 Go 檔案並執行 gofmt
file_path=$(jq -r '.tool_input.file_path // ""')
if [[ "$file_path" =~ \.go$ ]] && [[ -f "$file_path" ]]; then
    gofmt -w "$file_path"
    echo "✨ 已自動格式化 Go 檔案: $file_path"
fi
```

### 2. 進階：使用 Python 腳本進行智慧驗證

這個範例展示了如何使用 Python 腳本，在 Claude 執行 `Bash` 命令前進行驗證，並使用 **JSON 輸出** 提供結構化的回饋。

**設定:**

- **事件**: `PreToolUse`
- **匹配器**: `Bash`
- **Hook 命令**: `python .claude/hooks/validate_bash.py`

**建立腳本 (`.claude/hooks/validate_bash.py`):**

```python
#!/usr/bin/env python3
import json
import re
import sys

# 定義驗證規則 (正規表示式, 建議訊息)
VALIDATION_RULES = [
    (
        r"\bgrep\b(?!.*\|)",
        "請改用 'rg' (ripgrep)，它在專案範圍內的搜尋效能更好。",
    ),
    (
        r"\bfind\s+\S+\s+-name\b",
        "建議使用 'rg --files | rg <pattern>' 或 'rg -g '<pattern>'' 來取代 'find -name'，速度更快。",
    ),
]

def validate_command(command: str) -> list[str]:
    issues = []
    for pattern, message in VALIDATION_RULES:
        if re.search(pattern, command):
            issues.append(message)
    return issues

try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError:
    sys.exit(1) # 無法解析 JSON，靜默退出

command = input_data.get("tool_input", {}).get("command", "")
if not command:
    sys.exit(0) # 如果沒有命令，則不進行任何操作

issues = validate_command(command)

if issues:
    # 如果發現問題，使用 JSON 輸出格式來阻擋並提供回饋
    # 注意：對於 PreToolUse，應使用 hookSpecificOutput.permissionDecision
    response = {
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": "發現以下可以改進的地方：\n- " + "\n- ".join(issues)
        }
    }
    print(json.dumps(response))
else:
    # 如果沒有問題，可以明確批准或不輸出任何東西讓流程繼續
    # 注意：對於 PreToolUse，應使用 hookSpecificOutput.permissionDecision
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "allow",
            "permissionDecisionReason": "命令檢查通過"
        }
    }))

sys.exit(0)
```

### 3. 自訂通知系統

#### macOS 語音通知

當 Claude 等待您授權時，發出語音提醒。

**設定:**

- **事件**: `Notification`
- **匹配器**: (留空，適用於所有通知)
- **Hook 命令**:

```bash
message=$(jq -r '.message // "Claude Code notification"')
say "Claude says: $message"
```

#### Linux 桌面通知

**設定:**

- **事件**: `Notification`
- **匹配器**: (留空)
- **Hook 命令**:

```bash
# 需要安裝 libnotify-bin
title=$(jq -r '.title // "Claude Code"')
message=$(jq -r '.message // "Notification from Claude"')
notify-send "$title" "$message"
```

### 4. 安全防護範例

#### 防止危險命令執行

阻止 Claude 執行可能危險的命令。

**設定:**

- **事件**: `PreToolUse`
- **匹配器**: `Bash`
- **Hook 命令**:

```bash
command=$(jq -r '.tool_input.command // ""')

# 檢查危險命令模式
dangerous_patterns=("rm -rf" "sudo rm" "dd if=" "mkfs" "fdisk" "> /dev/")

for pattern in "${dangerous_patterns[@]}"; do
    if [[ "$command" == *"$pattern"* ]]; then
        # 使用退出碼 2 來阻擋操作，並將 stderr 的內容傳遞給 Claude
        echo "🚫 安全警告: 已阻止潛在危險命令: $command" >&2
        echo "💡 建議: 請使用更安全的替代方案或明確指定檔案" >&2
        exit 2
    fi
done

echo "✅ 命令安全檢查通過: $command"
```

#### 保護敏感檔案

防止 Claude 修改重要的設定檔案。

**設定:**

- **事件**: `PreToolUse`
- **匹配器**: `Edit|MultiEdit|Write`
- **Hook 命令**:

```bash
file_path=$(jq -r '.tool_input.file_path // ""')

# 敏感檔案模式
sensitive_files=(".env" ".env.local" ".env.production" "id_rsa" "id_ed25519" "package-lock.json" "yarn.lock")

for pattern in "${sensitive_files[@]}"; do
    if [[ "$file_path" == *"$pattern"* ]]; then
        reason=""
        case "$pattern" in
            "package-lock.json"|"yarn.lock")
                reason="💡 提示: 如需更新依賴，請讓 Claude 使用 'npm install' 或 'yarn install'"
                ;;
            ".env"*)
                reason="💡 提示: 環境變數檔案包含敏感資訊，請手動編輯"
                ;;
            "id_rsa"|"id_ed25519")
                reason="💡 提示: SSH 金鑰檔案不應被 Claude 修改"
                ;;
            *)
                reason="🔒 安全限制: 不允許 Claude 修改敏感檔案: $file_path"
                ;;
        esac
        # 使用 JSON 輸出阻擋操作
        # 注意：對於 PreToolUse，應使用 hookSpecificOutput.permissionDecision
        jq -n --arg reason "$reason" '{
          hookSpecificOutput: {
            hookEventName: "PreToolUse",
            permissionDecision: "deny",
            permissionDecisionReason: $reason
          }
        }'
        exit 0
    fi
done
```

### 5. 官方範例：Bash 命令驗證

以下是官方提供的 Python 腳本範例，展示如何使用 JSON 輸出進行 Bash 命令驗證：

**設定:**

- **事件**: `PreToolUse`
- **匹配器**: `Bash`
- **Hook 命令**: `python /path/to/bash-validator.py`

**腳本內容 (`bash-validator.py`):**

```python
#!/usr/bin/env python3
import json
import re
import sys

# 定義驗證規則為 (正規表示式模式, 訊息) 的元組列表
VALIDATION_RULES = [
    (
        r"\bgrep\b(?!.*\|)",
        "建議使用 'rg' (ripgrep) 而非 'grep'，效能和功能都更好",
    ),
    (
        r"\bfind\s+\S+\s+-name\b",
        "建議使用 'rg --files | rg pattern' 或 'rg --files -g pattern' 而非 'find -name'，效能更好",
    ),
]

def validate_command(command: str) -> list[str]:
    issues = []
    for pattern, message in VALIDATION_RULES:
        if re.search(pattern, command):
            issues.append(message)
    return issues

try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError as e:
    print(f"錯誤: 無效的 JSON 輸入: {e}", file=sys.stderr)
    sys.exit(1)

tool_name = input_data.get("tool_name", "")
tool_input = input_data.get("tool_input", {})
command = tool_input.get("command", "")

if tool_name != "Bash" or not command:
    sys.exit(1)

# 驗證命令
issues = validate_command(command)

if issues:
    for message in issues:
        print(f"• {message}", file=sys.stderr)
    # 退出代碼 2 阻擋工具執行並將 stderr 傳遞給 Claude
    sys.exit(2)
```

### 6. 官方範例：使用者提示驗證與上下文添加

**設定:**

- **事件**: `UserPromptSubmit`
- **Hook 命令**: `python /path/to/prompt-validator.py`

**腳本內容 (`prompt-validator.py`):**

```python
#!/usr/bin/env python3
import json
import sys
import re
import datetime

# 從 stdin 載入輸入
try:
    input_data = json.load(sys.stdin)
except json.JSONDecodeError as e:
    print(f"錯誤: 無效的 JSON 輸入: {e}", file=sys.stderr)
    sys.exit(1)

prompt = input_data.get("prompt", "")

# 檢查敏感模式
sensitive_patterns = [
    (r"(?i)\b(password|secret|key|token)\s*[:=]", "提示包含潛在的機密資訊"),
]

for pattern, message in sensitive_patterns:
    if re.search(pattern, prompt):
        # 使用 JSON 輸出阻擋並提供特定原因
        output = {
            "decision": "block",
            "reason": f"安全政策違規: {message}。請重新表述您的請求，不要包含敏感資訊。"
        }
        print(json.dumps(output))
        sys.exit(0)

# 添加當前時間到上下文
context = f"當前時間: {datetime.datetime.now()}"
print(context)

# 允許提示繼續處理，並包含額外的上下文
sys.exit(0)
```

### 7. 智慧備份系統

在重要檔案被修改前自動建立備份。

**設定:**

- **事件**: `PreToolUse`
- **匹配器**: `Edit|MultiEdit|Write`
- **Hook 命令**:

```bash
file_path=$(jq -r '.tool_input.file_path // ""')

# 需要備份的重要檔案模式
important_patterns=("config" "settings" ".json" ".yaml" ".yml" "Dockerfile" "Makefile")

should_backup=false
for pattern in "${important_patterns[@]}"; do
    if [[ "$file_path" == *"$pattern"* ]]; then
        should_backup=true
        break
    fi
done

if [ "$should_backup" = true ] && [ -f "$file_path" ]; then
    backup_dir="$(dirname "$file_path")/.claude-backups"
    mkdir -p "$backup_dir"

    timestamp=$(date +"%Y%m%d_%H%M%S")
    backup_file="$backup_dir/$(basename "$file_path").backup.$timestamp"

    cp "$file_path" "$backup_file"
    echo "💾 已建立備份: $backup_file"
fi
```

### 8. 自動測試執行

在程式碼修改後自動執行測試。

**設定:**

- **事件**: `PostToolUse`
- **匹配器**: `Edit|MultiEdit|Write`
- **Hook 命令**:

```bash
file_path=$(jq -r '.tool_input.file_path // ""')

# 檢查是否為測試相關檔案或源碼檔案
if [[ "$file_path" =~ \.(test|spec)\. ]] || [[ "$file_path" =~ /src/ ]]; then
    echo "🧪 檢測到程式碼變更，執行相關測試..."

    # 檢查專案類型並執行適當的測試命令
    if [ -f "package.json" ]; then
        # --no-install 避免在沒有 node_modules 時的交互提示
        if jq -e '.scripts.test' package.json > /dev/null; then
            npm test -- --testPathPattern="$(basename "$file_path" | sed 's/\.[^.]*$//')"
        fi
    elif [ -f "go.mod" ]; then
        go test ./...
    elif [ -f "Cargo.toml" ]; then
        cargo test
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        python -m pytest -xvs
    fi
fi
```

---

## Hook 執行細節

### 執行環境與限制

- **執行超時**: 預設 60 秒執行限制，可針對個別命令設定 `timeout` 參數
  - 個別命令的超時不會影響其他命令
- **並行執行**: 所有匹配的 Hooks 會並行執行
- **執行環境**: 在當前目錄中執行，使用 Claude Code 的環境變數
  - `CLAUDE_PROJECT_DIR` 環境變數可用，包含專案根目錄的絕對路徑（Claude Code 啟動的位置）
  - `CLAUDE_CODE_REMOTE` 環境變數指示 hook 是在遠端（網路）環境 (`"true"`) 還是本機 CLI 環境（未設定或空）中執行。使用此變數根據執行上下文執行不同的邏輯。
- **輸入方式**: 透過 stdin 接收 JSON 資料
- **輸出處理**:
  - `PreToolUse`/`PostToolUse`/`Stop`/`SubagentStop`: 進度顯示在文字記錄中 (Ctrl-R)
  - `Notification`/`SessionEnd`: 記錄到偵錯 (`--debug`)
  - `UserPromptSubmit`/`SessionStart`: stdout 作為 Claude 的上下文新增
- **去重**: 多個相同的 hook 命令會自動去重

### Hook 匹配規則

**對於 `PreToolUse` 和 `PostToolUse` 事件:**

- `matcher` 是必要的，用於指定要監控的工具
- 支援精確字串匹配：`"Write"` 只匹配 Write 工具
- 支援正規表示式：`"Edit|Write"` 或 `"Notebook.*"`
- 大小寫敏感
- 如果省略或為空字串，則匹配所有工具

**對於其他事件:**

- `UserPromptSubmit`, `Notification`, `Stop`, `SubagentStop`, `PreCompact` 不使用 matcher
- 可以省略 `matcher` 欄位或將其設為空字串

### 常見工具匹配器

以下是可以在 `PreToolUse` 和 `PostToolUse` 中使用的常見工具名稱：

- `Task` - 代理任務
- `Bash` - Shell 命令
- `Glob` - 檔案模式匹配
- `Grep` - 內容搜尋
- `Read` - 檔案讀取
- `Edit`, `MultiEdit` - 檔案編輯
- `Write` - 檔案寫入
- `WebFetch`, `WebSearch` - 網路操作

---

## 進階功能

### MCP 工具整合

Claude Code 支援 MCP (Model Context Protocol) 工具，您也可以為這些工具設定 Hooks。MCP 工具遵循 `mcp__<server>__<tool>` 的命名模式。

**範例：監控記憶體操作**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__memory__.*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Memory operation: ' $(jq -r '.tool_name') >> ~/.claude/memory-log.txt"
          }
        ]
      }
    ]
  }
}
```

### 使用外部腳本

對於複雜的邏輯，建議建立獨立的腳本檔案：

**建立腳本檔案** (`.claude/hooks/security_check.js`):

```javascript
#!/usr/bin/env node

async function main() {
  const chunks = [];
  for await (const chunk of process.stdin) {
    chunks.push(chunk);
  }

  const toolData = JSON.parse(Buffer.concat(chunks).toString());
  const command = toolData.tool_input?.command || "";

  // 複雜的安全檢查邏輯
  const dangerousPatterns = [
    /rm\s+-rf\s+\//, // 刪除根目錄
    /sudo\s+rm/, // sudo 刪除
    /chmod\s+777/, // 過於寬鬆的權限
  ];

  for (const pattern of dangerousPatterns) {
    if (pattern.test(command)) {
      console.error(`🚫 檢測到危險命令模式: ${command}`);
      process.exit(2);
    }
  }

  console.log(`✅ 安全檢查通過`);
  process.exit(0);
}

main().catch(console.error);
```

**在 Hook 中使用腳本**:

```bash
# 方式一：使用 node 命令執行（推薦）
node .claude/hooks/security_check.js

# 方式二：直接執行（需要 shebang 行和執行權限）
# 確保腳本第一行包含: #!/usr/bin/env node
# 並設定執行權限: chmod +x .claude/hooks/security_check.js
.claude/hooks/security_check.js
```

---

## 安全考量

### ⚠️ 免責聲明

**風險自負**: Claude Code Hooks 會在您的系統上自動執行任意 shell 命令。使用 Hooks 表示您確認：

- 您對配置的命令承擔全部責任
- Hooks 可以修改、刪除或存取您的使用者帳戶能存取的任何檔案
- 惡意或編寫不當的 Hooks 可能導致資料遺失或系統損害
- Anthropic 不提供任何保證，並且不對 Hook 使用導致的任何損害承擔責任
- 您應該在生產環境使用前，在安全環境中徹底測試 Hooks

在添加到您的配置之前，請務必審查並理解任何 Hook 命令。

### 🛡️ 重要安全原則

1. **最小權限原則**: 只授予 Hook 完成任務所需的最小權限
2. **輸入驗證**: 始終驗證來自 Claude 的輸入資料
3. **避免命令注入**: 如果使用來自 Claude 的資料建構命令，請正確轉義
4. **定期審查**: 定期檢查您的 Hook 設定和執行日誌
5. **使用絕對路徑**: 在腳本中盡量使用絕對路徑指定命令，避免 PATH 被劫持
6. **避開敏感檔案**: 設定規則以跳過 `.env`, `.git/`, SSH 金鑰等檔案

### 具體防護措施

#### 輸入清理範例

```bash
# 安全地處理檔案路徑
file_path=$(jq -r '.tool_input.file_path // ""' | sed 's/[^a-zA-Z0-9._/-]//g')

# 防止路徑遍歷攻擊
if [[ "$file_path" == *".."* ]]; then
    echo "❌ 不允許路徑遍歷操作"
    exit 2
fi
```

#### 權限檢查

```bash
# 檢查檔案是否在允許的目錄中
allowed_dirs=("/home/user/projects" "/tmp")
file_path=$(jq -r '.tool_input.file_path // ""')

is_allowed=false
for dir in "${allowed_dirs[@]}"; do
    if [[ "$file_path" == "$dir"* ]]; then
        is_allowed=true
        break
    fi
done

if [ "$is_allowed" = false ]; then
    echo "❌ 檔案路徑不在允許的目錄中: $file_path"
    exit 2
fi
```

### 專案設定安全性

當您載入包含專案級別 Hooks 的專案時，Claude Code 會顯示警告並要求您確認。這是為了防止惡意設定檔。

#### 配置安全機制

對設定檔的直接編輯不會立即生效。Claude Code 採用以下安全措施：

1. **啟動時快照**: Claude Code 在啟動時擷取 Hooks 設定的快照
2. **全程使用快照**: 整個對話期間使用該快照
3. **外部變更警告**: 如果 Hooks 設定檔被外部修改，Claude Code 會發出警告
4. **需要審查確認**: 變更後的 Hooks 需要在 `/hooks` 管理介面中審查後才能生效

這可以防止惡意 Hook 修改在您目前的對話期間生效。

**請務必：**

1. **仔細檢查** `.claude/settings.json` 中的所有 Hook 命令
2. **理解每個命令的作用**，特別是那些您不熟悉的
3. **在沙盒環境中測試**未知的 Hook 配置
4. **不要盲目信任**來自網路的專案設定

---

## 疑難排解

### 常見問題及解決方案

#### Hook 沒有執行

**可能原因及解決方法：**

1. **事件類型或匹配器錯誤**

   ```bash
   # 檢查設定檔語法
   cat ~/.claude/settings.json | jq .
   ```

2. **命令路徑問題**

   ```bash
   # 使用絕對路徑
   /usr/bin/echo "test" >> ~/.claude/debug.log
   ```

3. **權限問題**
   ```bash
   # 檢查腳本權限
   chmod +x .claude/hooks/your-script.sh
   ```

#### 調試 Hook 執行

**在 Hook 中加入調試輸出：**

```bash
# 在命令開頭加入
set -x # 打開 shell 的詳細執行日誌
echo "Hook executed at $(date)" >> ~/.claude/hook-debug.log
echo "Input: $(cat)" >> ~/.claude/hook-debug.log
set +x # 關閉詳細日誌
```

**檢查 Claude 傳遞的資料：**

```bash
# 將完整輸入保存到檔案
cat > /tmp/claude-hook-input-$(date +%s).json
```

#### JSON 解析錯誤

**安全的 JSON 處理：**

```bash
# 檢查 JSON 是否有效
if echo "$input" | jq . > /dev/null 2>&1; then
    # JSON 有效，繼續處理
    command=$(echo "$input" | jq -r '.tool_input.command // ""')
else
    echo "❌ 無效的 JSON 輸入" >&2
    exit 1
fi
```

### 除錯工具

#### 基本除錯步驟

如果您的 Hooks 無法正常運作，請依序檢查：

1. **檢查配置** - 執行 `/hooks` 查看您的 Hook 是否已註冊
2. **驗證語法** - 確保 JSON 設定有效
3. **測試命令** - 先手動執行 Hook 命令
4. **檢查權限** - 確保腳本檔案具有執行權限
5. **查看日誌** - 使用 `claude --debug` 查看詳細的 Hook 執行資訊

**常見問題:**

- **引號未跳脫** - JSON 字串中使用 `\"`
- **匹配器錯誤** - 檢查工具名稱是否精確匹配（大小寫敏感）
- **命令找不到** - 使用腳本的完整路徑

#### 啟用詳細日誌

使用 `--debug` 標誌啟動 Claude Code 以查看詳細的日誌輸出：

```bash
claude --debug
```

您將會看到類似以下的日誌：

```
[DEBUG] Executing hooks for PostToolUse:Write
[DEBUG] Getting matching hook commands for PostToolUse with query: Write
[DEBUG] Found 1 hook matchers in settings
[DEBUG] Matched 1 hooks for query "Write"
[DEBUG] Found 1 hook commands to execute
[DEBUG] Executing hook command: <Your command> with timeout 60000ms
[DEBUG] Hook command completed with status 0: <Your stdout>
```

進度訊息會出現在 transcript 模式 (Ctrl-R) 中，顯示：

- 正在執行哪個 Hook
- 執行的命令
- 成功/失敗狀態
- 輸出或錯誤訊息

#### 進階除錯技巧

對於複雜的 Hook 問題：

1. **檢查 Hook 執行** - 使用 `claude --debug` 查看詳細的 Hook 執行過程
2. **驗證 JSON Schema** - 使用外部工具測試 Hook 輸入/輸出
3. **檢查環境變數** - 驗證 Claude Code 的環境是否正確
4. **測試邊緣情況** - 嘗試 Hook 處理異常檔案路徑或輸入
5. **監控系統資源** - 檢查 Hook 執行期間是否有資源耗盡
6. **使用結構化記錄** - 在 Hook 腳本中實作日誌記錄

#### Hook 執行監控

```bash
# 建立全域監控 Hook
echo 'echo "$(date): Hook executed" >> ~/.claude/all-hooks.log' > ~/.claude/hooks/monitor.sh
chmod +x ~/.claude/hooks/monitor.sh
```

---

## 最佳實踐總結

### ✅ 推薦做法

1. **從簡單開始**: 先實作基本的日誌記錄，再逐步加入複雜功能
2. **分層設定**: 通用規則放在使用者設定，專案特定規則放在專案設定
3. **充分測試**: 在安全環境中測試所有 Hook 再部署到生產環境
4. **詳細註釋**: 在設定檔中為每個 Hook 添加說明註釋
5. **定期維護**: 定期檢查和更新 Hook 設定，移除不需要的規則

### ❌ 避免事項

1. **過度複雜化**: 避免在單一 Hook 中包含過多邏輯
2. **忽略錯誤處理**: 確保 Hook 能夠妥善處理異常情況
3. **硬編碼路徑**: 使用相對路徑或環境變數而非絕對路徑
4. **忽略效能**: 避免在 Hook 中執行耗時操作
5. **盲目信任**: 不要無條件信任來自外部的 Hook 設定

### 🚀 進階技巧

1. **條件執行**: 使用環境變數控制 Hook 行為

   ```bash
   if [ "$CLAUDE_ENV" = "production" ]; then
       # 生產環境專用邏輯
   fi
   ```

2. **並行處理**: 對於獨立的操作，可以使用背景執行

   ```bash
   long_running_task &
   echo "Task started in background"
   ```

3. **狀態追蹤**: 使用暫存檔案追蹤 Hook 狀態

   ```bash
   echo "$(date): Hook started" > /tmp/claude-hook-status
   ```

4. **整合外部服務**: 透過 API 與外部服務整合
   ```bash
   curl -X POST "https://api.slack.com/..." -d "text=Claude completed task"
   ```

---

## 結語

Claude Code Hooks 是一個強大的自動化工具，能夠顯著提升您的開發效率和程式碼品質。透過合理的設定和使用，您可以：

- 🎯 **自動化重複性任務**: 格式化程式碼、執行測試、產生文件
- 🛡️ **增強安全性**: 防止危險操作、保護敏感檔案
- 📊 **提升可見度**: 記錄操作歷史、監控系統狀態
- 🔄 **優化工作流程**: 整合現有工具鏈、自訂通知機制

記住，Hooks 的真正價值在於讓您專注於創造性的工作，而將重複性的、規則化的任務交給自動化系統處理。

開始您的 Claude Code Hooks 之旅，讓 AI 助手成為您開發團隊中最可靠的成員！

---

## 參考資源

- [Claude Code 官方文件](https://docs.anthropic.com/zh-TW/docs/claude-code/hooks)
- [jq 官方教學](https://stedolan.github.io/jq/tutorial/)
- [Shell 腳本最佳實踐](https://google.github.io/styleguide/shellguide.html)
- [JSON Schema 驗證](https://json-schema.org/)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/aliceric27/claude-code-hooks) 與 [官方文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)。
>
> **版本資訊**：Claude Code Hooks - 完整的 Hooks 使用指南  
> **最後更新**：2025-11-25T00:04:00+08:00  
> **專案更新**：2025-07-20T17:56:11+08:00  
> **主要變更**：根據官方文檔更新 PreToolUse 決策控制（使用 hookSpecificOutput.permissionDecision）、新增 SessionStart/SessionEnd 詳細說明、新增外掛程式 hooks 說明、更新退出代碼行為說明、新增 permission_mode 和 systemMessage 欄位、新增 updatedInput 和 additionalContext 功能、修正範例中的舊 API 用法
