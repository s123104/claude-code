---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/plugins-reference.md"
fetched_at: "2025-10-29T14:11:20+08:00"
---

# 插件參考

> Claude Code 插件系統的完整技術參考，包括架構、CLI 命令和組件規格。

<Tip>
  如需實際操作教程和實用用法，請參閱[插件](/zh-TW/docs/claude-code/plugins)。如需跨團隊和社群的插件管理，請參閱[插件市場](/zh-TW/docs/claude-code/plugin-marketplaces)。
</Tip>

此參考提供 Claude Code 插件系統的完整技術規格，包括組件架構、CLI 命令和開發工具。

## 插件組件參考

本節記錄插件可以提供的五種組件類型。

### 命令

插件添加自定義斜線命令，與 Claude Code 的命令系統無縫整合。

**位置**：插件根目錄中的 `commands/` 目錄

**檔案格式**：帶有前置資料的 Markdown 檔案

如需插件命令結構、調用模式和功能的完整詳細資訊，請參閱[插件命令](/zh-TW/docs/claude-code/slash-commands#plugin-commands)。

### 代理

插件可以為特定任務提供專門的子代理，Claude 可以在適當時自動調用。

**位置**：插件根目錄中的 `agents/` 目錄

**檔案格式**：描述代理能力的 Markdown 檔案

**代理結構**：

```markdown  theme={null}
---
description: 此代理專精的領域
capabilities: ["task1", "task2", "task3"]
---

# 代理名稱

代理角色、專業知識以及 Claude 何時應該調用它的詳細描述。

## 能力
- 代理擅長的特定任務
- 另一個專門能力
- 何時使用此代理而非其他代理

## 上下文和範例
提供何時應該使用此代理以及它解決什麼類型問題的範例。
```

**整合點**：

* 代理出現在 `/agents` 介面中
* Claude 可以根據任務上下文自動調用代理
* 用戶可以手動調用代理
* 插件代理與內建的 Claude 代理一起工作

### 技能

插件可以提供擴展 Claude 能力的代理技能。技能是模型調用的——Claude 根據任務上下文自主決定何時使用它們。

**位置**：插件根目錄中的 `skills/` 目錄

**檔案格式**：包含帶有前置資料的 `SKILL.md` 檔案的目錄

**技能結構**：

```
skills/
├── pdf-processor/
│   ├── SKILL.md
│   ├── reference.md (可選)
│   └── scripts/ (可選)
└── code-reviewer/
    └── SKILL.md
```

**整合行為**：

* 插件技能在插件安裝時自動發現
* Claude 根據匹配的任務上下文自主調用技能
* 技能可以包含 SKILL.md 旁邊的支援檔案

如需 SKILL.md 格式和完整技能編寫指導，請參閱：

* [在 Claude Code 中使用技能](/zh-TW/docs/claude-code/skills)
* [代理技能概述](/zh-TW/docs/agents-and-tools/agent-skills/overview#skill-structure)

### 鉤子

插件可以提供自動響應 Claude Code 事件的事件處理器。

**位置**：插件根目錄中的 `hooks/hooks.json`，或在 plugin.json 中內聯

**格式**：帶有事件匹配器和動作的 JSON 配置

**鉤子配置**：

```json  theme={null}
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format-code.sh"
          }
        ]
      }
    ]
  }
}
```

**可用事件**：

* `PreToolUse`：在 Claude 使用任何工具之前
* `PostToolUse`：在 Claude 使用任何工具之後
* `UserPromptSubmit`：當用戶提交提示時
* `Notification`：當 Claude Code 發送通知時
* `Stop`：當 Claude 嘗試停止時
* `SubagentStop`：當子代理嘗試停止時
* `SessionStart`：在會話開始時
* `SessionEnd`：在會話結束時
* `PreCompact`：在對話歷史被壓縮之前

**鉤子類型**：

* `command`：執行 shell 命令或腳本
* `validation`：驗證檔案內容或專案狀態
* `notification`：發送警報或狀態更新

### MCP 伺服器

插件可以捆綁模型上下文協議 (MCP) 伺服器，將 Claude Code 與外部工具和服務連接。

**位置**：插件根目錄中的 `.mcp.json`，或在 plugin.json 中內聯

**格式**：標準 MCP 伺服器配置

**MCP 伺服器配置**：

```json  theme={null}
{
  "mcpServers": {
    "plugin-database": {
      "command": "${CLAUDE_PLUGIN_ROOT}/servers/db-server",
      "args": ["--config", "${CLAUDE_PLUGIN_ROOT}/config.json"],
      "env": {
        "DB_PATH": "${CLAUDE_PLUGIN_ROOT}/data"
      }
    },
    "plugin-api-client": {
      "command": "npx",
      "args": ["@company/mcp-server", "--plugin-mode"],
      "cwd": "${CLAUDE_PLUGIN_ROOT}"
    }
  }
}
```

**整合行為**：

* 插件 MCP 伺服器在插件啟用時自動啟動
* 伺服器作為標準 MCP 工具出現在 Claude 的工具包中
* 伺服器能力與 Claude 現有工具無縫整合
* 插件伺服器可以獨立於用戶 MCP 伺服器進行配置

***

## 插件清單架構

`plugin.json` 檔案定義您插件的元資料和配置。本節記錄所有支援的欄位和選項。

### 完整架構

```json  theme={null}
{
  "name": "plugin-name",
  "version": "1.2.0",
  "description": "簡短插件描述",
  "author": {
    "name": "作者姓名",
    "email": "author@example.com",
    "url": "https://github.com/author"
  },
  "homepage": "https://docs.example.com/plugin",
  "repository": "https://github.com/author/plugin",
  "license": "MIT",
  "keywords": ["keyword1", "keyword2"],
  "commands": ["./custom/commands/special.md"],
  "agents": "./custom/agents/",
  "hooks": "./config/hooks.json",
  "mcpServers": "./mcp-config.json"
}
```

### 必需欄位

| 欄位     | 類型     | 描述                    | 範例                   |
| :----- | :----- | :-------------------- | :------------------- |
| `name` | string | 唯一識別符（kebab-case，無空格） | `"deployment-tools"` |

### 元資料欄位

| 欄位            | 類型     | 描述        | 範例                                             |
| :------------ | :----- | :-------- | :--------------------------------------------- |
| `version`     | string | 語義版本      | `"2.1.0"`                                      |
| `description` | string | 插件用途的簡短說明 | `"部署自動化工具"`                                    |
| `author`      | object | 作者資訊      | `{"name": "開發團隊", "email": "dev@company.com"}` |
| `homepage`    | string | 文檔 URL    | `"https://docs.example.com"`                   |
| `repository`  | string | 原始碼 URL   | `"https://github.com/user/plugin"`             |
| `license`     | string | 許可證識別符    | `"MIT"`、`"Apache-2.0"`                         |
| `keywords`    | array  | 發現標籤      | `["deployment", "ci-cd"]`                      |

### 組件路徑欄位

| 欄位           | 類型             | 描述            | 範例                                    |
| :----------- | :------------- | :------------ | :------------------------------------ |
| `commands`   | string\|array  | 額外的命令檔案/目錄    | `"./custom/cmd.md"` 或 `["./cmd1.md"]` |
| `agents`     | string\|array  | 額外的代理檔案       | `"./custom/agents/"`                  |
| `hooks`      | string\|object | 鉤子配置路徑或內聯配置   | `"./hooks.json"`                      |
| `mcpServers` | string\|object | MCP 配置路徑或內聯配置 | `"./mcp.json"`                        |

### 路徑行為規則

**重要**：自定義路徑補充預設目錄——它們不會替換它們。

* 如果 `commands/` 存在，它會與自定義命令路徑一起載入
* 所有路徑必須相對於插件根目錄並以 `./` 開頭
* 來自自定義路徑的命令使用相同的命名和命名空間規則
* 可以將多個路徑指定為陣列以提供靈活性

**路徑範例**：

```json  theme={null}
{
  "commands": [
    "./specialized/deploy.md",
    "./utilities/batch-process.md"
  ],
  "agents": [
    "./custom-agents/reviewer.md",
    "./custom-agents/tester.md"
  ]
}
```

### 環境變數

**`${CLAUDE_PLUGIN_ROOT}`**：包含插件目錄的絕對路徑。在鉤子、MCP 伺服器和腳本中使用此變數，以確保無論安裝位置如何都能獲得正確的路徑。

```json  theme={null}
{
  "hooks": {
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/process.sh"
          }
        ]
      }
    ]
  }
}
```

***

## 插件目錄結構

### 標準插件佈局

完整的插件遵循此結構：

```
enterprise-plugin/
├── .claude-plugin/           # 元資料目錄
│   └── plugin.json          # 必需：插件清單
├── commands/                 # 預設命令位置
│   ├── status.md
│   └──  logs.md
├── agents/                   # 預設代理位置
│   ├── security-reviewer.md
│   ├── performance-tester.md
│   └── compliance-checker.md
├── skills/                   # 代理技能
│   ├── code-reviewer/
│   │   └── SKILL.md
│   └── pdf-processor/
│       ├── SKILL.md
│       └── scripts/
├── hooks/                    # 鉤子配置
│   ├── hooks.json           # 主要鉤子配置
│   └── security-hooks.json  # 額外鉤子
├── .mcp.json                # MCP 伺服器定義
├── scripts/                 # 鉤子和實用腳本
│   ├── security-scan.sh
│   ├── format-code.py
│   └── deploy.js
├── LICENSE                  # 許可證檔案
└── CHANGELOG.md             # 版本歷史
```

<Warning>
  `.claude-plugin/` 目錄包含 `plugin.json` 檔案。所有其他目錄（commands/、agents/、skills/、hooks/）必須在插件根目錄，而不是在 `.claude-plugin/` 內。
</Warning>

### 檔案位置參考

| 組件          | 預設位置                         | 用途                  |
| :---------- | :--------------------------- | :------------------ |
| **清單**      | `.claude-plugin/plugin.json` | 必需的元資料檔案            |
| **命令**      | `commands/`                  | 斜線命令 markdown 檔案    |
| **代理**      | `agents/`                    | 子代理 markdown 檔案     |
| **技能**      | `skills/`                    | 帶有 SKILL.md 檔案的代理技能 |
| **鉤子**      | `hooks/hooks.json`           | 鉤子配置                |
| **MCP 伺服器** | `.mcp.json`                  | MCP 伺服器定義           |

***

## 除錯和開發工具

### 除錯命令

使用 `claude --debug` 查看插件載入詳細資訊：

```bash  theme={null}
claude --debug
```

這會顯示：

* 正在載入哪些插件
* 插件清單中的任何錯誤
* 命令、代理和鉤子註冊
* MCP 伺服器初始化

### 常見問題

| 問題        | 原因                         | 解決方案                                         |
| :-------- | :------------------------- | :------------------------------------------- |
| 插件未載入     | 無效的 `plugin.json`          | 驗證 JSON 語法                                   |
| 命令未出現     | 錯誤的目錄結構                    | 確保 `commands/` 在根目錄，而不是在 `.claude-plugin/` 中 |
| 鉤子未觸發     | 腳本不可執行                     | 執行 `chmod +x script.sh`                      |
| MCP 伺服器失敗 | 缺少 `${CLAUDE_PLUGIN_ROOT}` | 對所有插件路徑使用變數                                  |
| 路徑錯誤      | 使用了絕對路徑                    | 所有路徑必須是相對的並以 `./` 開頭                         |

***

## 分發和版本控制參考

### 版本管理

遵循語義版本控制進行插件發布：

```json  theme={null}

## 另請參閱

- [插件](/zh-TW/docs/claude-code/plugins) - 教程和實際用法
- [插件市場](/zh-TW/docs/claude-code/plugin-marketplaces) - 創建和管理市場
- [斜線命令](/zh-TW/docs/claude-code/slash-commands) - 命令開發詳細資訊
- [子代理](/zh-TW/docs/claude-code/sub-agents) - 代理配置和能力
- [代理技能](/zh-TW/docs/claude-code/skills) - 擴展 Claude 的能力
- [鉤子](/zh-TW/docs/claude-code/hooks) - 事件處理和自動化
- [MCP](/zh-TW/docs/claude-code/mcp) - 外部工具整合
- [設定](/zh-TW/docs/claude-code/settings) - 插件的配置選項
```

