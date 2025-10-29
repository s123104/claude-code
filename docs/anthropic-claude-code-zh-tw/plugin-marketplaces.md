---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/plugin-marketplaces.md"
fetched_at: "2025-10-29T14:11:19+08:00"
---

# 插件市場

> 建立和管理插件市場，以便在團隊和社群中分發 Claude Code 擴充功能。

插件市場是可用插件的目錄，讓您輕鬆發現、安裝和管理 Claude Code 擴充功能。本指南將向您展示如何使用現有市場並為團隊分發建立自己的市場。

## 概述

市場是一個 JSON 檔案，列出可用的插件並描述在哪裡找到它們。市場提供：

* **集中式發現**：在一個地方瀏覽來自多個來源的插件
* **版本管理**：自動追蹤和更新插件版本
* **團隊分發**：在您的組織中共享必需的插件
* **靈活來源**：支援 git 儲存庫、GitHub 儲存庫、本地路徑和套件管理器

### 先決條件

* 已安裝並運行 Claude Code
* 基本熟悉 JSON 檔案格式
* 對於建立市場：Git 儲存庫或本地開發環境

## 新增和使用市場

使用 `/plugin marketplace` 命令新增市場以存取來自不同來源的插件：

### 新增 GitHub 市場

```shell 新增包含 .claude-plugin/marketplace.json 的 GitHub 儲存庫 theme={null}
/plugin marketplace add owner/repo
```

### 新增 Git 儲存庫

```shell 新增任何 git 儲存庫 theme={null}
/plugin marketplace add https://gitlab.com/company/plugins.git
```

### 新增本地市場進行開發

```shell 新增包含 .claude-plugin/marketplace.json 的本地目錄 theme={null}
/plugin marketplace add ./my-marketplace
```

```shell 新增 marketplace.json 檔案的直接路徑 theme={null}
/plugin marketplace add ./path/to/marketplace.json
```

```shell 透過 URL 新增遠端 marketplace.json theme={null}
/plugin marketplace add https://url.of/marketplace.json
```

### 從市場安裝插件

新增市場後，直接安裝插件：

```shell 從任何已知市場安裝 theme={null}
/plugin install plugin-name@marketplace-name
```

```shell 互動式瀏覽可用插件 theme={null}
/plugin
```

### 驗證市場安裝

新增市場後：

1. **列出市場**：執行 `/plugin marketplace list` 確認已新增
2. **瀏覽插件**：使用 `/plugin` 查看來自您市場的可用插件
3. **測試安裝**：嘗試安裝插件以驗證市場正常運作

## 配置團隊市場

透過在 `.claude/settings.json` 中指定必需的市場，為團隊專案設定自動市場安裝：

```json  theme={null}
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "your-org/claude-plugins"
      }
    },
    "project-specific": {
      "source": {
        "source": "git",
        "url": "https://git.company.com/project-plugins.git"
      }
    }
  }
}
```

當團隊成員信任儲存庫資料夾時，Claude Code 會自動安裝這些市場以及在 `enabledPlugins` 欄位中指定的任何插件。

***

## 建立您自己的市場

為您的團隊或社群建立和分發自訂插件集合。

### 建立市場的先決條件

* Git 儲存庫（GitHub、GitLab 或其他 git 託管）
* 了解 JSON 檔案格式
* 一個或多個要分發的插件

### 建立市場檔案

在您的儲存庫根目錄中建立 `.claude-plugin/marketplace.json`：

```json  theme={null}
{
  "name": "company-tools",
  "owner": {
    "name": "DevTools Team",
    "email": "devtools@company.com"
  },
  "plugins": [
    {
      "name": "code-formatter",
      "source": "./plugins/formatter",
      "description": "儲存時自動程式碼格式化",
      "version": "2.1.0",
      "author": {
        "name": "DevTools Team"
      }
    },
    {
      "name": "deployment-tools",
      "source": {
        "source": "github",
        "repo": "company/deploy-plugin"
      },
      "description": "部署自動化工具"
    }
  ]
}
```

### 市場架構

#### 必需欄位

| 欄位        | 類型     | 描述                    |
| :-------- | :----- | :-------------------- |
| `name`    | string | 市場識別符（kebab-case，無空格） |
| `owner`   | object | 市場維護者資訊               |
| `plugins` | array  | 可用插件清單                |

#### 可選元資料

| 欄位                     | 類型     | 描述          |
| :--------------------- | :----- | :---------- |
| `metadata.description` | string | 簡短市場描述      |
| `metadata.version`     | string | 市場版本        |
| `metadata.pluginRoot`  | string | 相對插件來源的基本路徑 |

### 插件條目

<Note>
  插件條目基於*插件清單架構*（所有欄位都設為可選）加上市場特定欄位（`source`、`category`、`tags`、`strict`），其中 `name` 為必需。
</Note>

**必需欄位：**

| 欄位       | 類型             | 描述                    |
| :------- | :------------- | :-------------------- |
| `name`   | string         | 插件識別符（kebab-case，無空格） |
| `source` | string\|object | 從哪裡獲取插件               |

#### 可選插件欄位

**標準元資料欄位：**

| 欄位            | 類型      | 描述                                         |
| :------------ | :------ | :----------------------------------------- |
| `description` | string  | 簡短插件描述                                     |
| `version`     | string  | 插件版本                                       |
| `author`      | object  | 插件作者資訊                                     |
| `homepage`    | string  | 插件首頁或文件 URL                                |
| `repository`  | string  | 原始碼儲存庫 URL                                 |
| `license`     | string  | SPDX 授權識別符（例如 MIT、Apache-2.0）              |
| `keywords`    | array   | 用於插件發現和分類的標籤                               |
| `category`    | string  | 用於組織的插件類別                                  |
| `tags`        | array   | 用於搜尋的標籤                                    |
| `strict`      | boolean | 要求插件資料夾中有 plugin.json（預設：true）<sup>1</sup> |

**元件配置欄位：**

| 欄位           | 類型             | 描述                  |
| :----------- | :------------- | :------------------ |
| `commands`   | string\|array  | 命令檔案或目錄的自訂路徑        |
| `agents`     | string\|array  | 代理檔案的自訂路徑           |
| `hooks`      | string\|object | 自訂鉤子配置或鉤子檔案路徑       |
| `mcpServers` | string\|object | MCP 伺服器配置或 MCP 配置路徑 |

*<sup>1 - 當 `strict: true`（預設）時，插件必須包含 `plugin.json` 清單檔案，市場欄位補充這些值。當 `strict: false` 時，plugin.json 是可選的。如果缺少，市場條目將作為完整的插件清單。</sup>*

### 插件來源

#### 相對路徑

對於同一儲存庫中的插件：

```json  theme={null}
{
  "name": "my-plugin",
  "source": "./plugins/my-plugin"
}
```

#### GitHub 儲存庫

```json  theme={null}
{
  "name": "github-plugin",
  "source": {
    "source": "github",
    "repo": "owner/plugin-repo"
  }
}
```

#### Git 儲存庫

```json  theme={null}
{
  "name": "git-plugin",
  "source": {
    "source": "url",
    "url": "https://gitlab.com/team/plugin.git"
  }
}
```

#### 進階插件條目

插件條目可以覆蓋預設元件位置並提供額外的元資料。請注意，`${CLAUDE_PLUGIN_ROOT}` 是一個環境變數，解析為插件的安裝目錄（詳情請參閱[環境變數](/zh-TW/docs/claude-code/plugins-reference#environment-variables)）：

```json  theme={null}
{
  "name": "enterprise-tools",
  "source": {
    "source": "github",
    "repo": "company/enterprise-plugin"
  },
  "description": "企業工作流程自動化工具",
  "version": "2.1.0",
  "author": {
    "name": "Enterprise Team",
    "email": "enterprise@company.com"
  },
  "homepage": "https://docs.company.com/plugins/enterprise-tools",
  "repository": "https://github.com/company/enterprise-plugin",
  "license": "MIT",
  "keywords": ["enterprise", "workflow", "automation"],
  "category": "productivity",
  "commands": [
    "./commands/core/",
    "./commands/enterprise/",
    "./commands/experimental/preview.md"
  ],
  "agents": [
    "./agents/security-reviewer.md",
    "./agents/compliance-checker.md"
  ],
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [{"type": "command", "command": "${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"}]
      }
    ]
  },
  "mcpServers": {
    "enterprise-db": {
      "command": "${CLAUDE_PLUGIN_ROOT}/servers/db-server",
      "args": ["--config", "${CLAUDE_PLUGIN_ROOT}/config.json"]
    }
  },
  "strict": false
}
```

<Note>
  **架構關係**：插件條目使用插件清單架構，所有欄位都設為可選，加上市場特定欄位（`source`、`strict`、`category`、`tags`）。這意味著在 `plugin.json` 檔案中有效的任何欄位也可以在市場條目中使用。當 `strict: false` 時，如果不存在 `plugin.json`，市場條目將作為完整的插件清單。當 `strict: true`（預設）時，市場欄位補充插件自己的清單檔案。
</Note>

***

## 託管和分發市場

為您的插件分發需求選擇最佳託管策略。

### 在 GitHub 上託管（推薦）

GitHub 提供最簡單的分發方法：

1. **建立儲存庫**：為您的市場設定新儲存庫
2. **新增市場檔案**：使用您的插件定義建立 `.claude-plugin/marketplace.json`
3. **與團隊共享**：團隊成員使用 `/plugin marketplace add owner/repo` 新增

**優點**：內建版本控制、問題追蹤和團隊協作功能。

### 在其他 git 服務上託管

任何 git 託管服務都可用於市場分發，使用任意 git 儲存庫的 URL。

例如，使用 GitLab：

```shell  theme={null}
/plugin marketplace add https://gitlab.com/company/plugins.git
```

### 使用本地市場進行開發

在分發前本地測試您的市場：

```shell 新增本地市場進行測試 theme={null}
/plugin marketplace add ./my-local-marketplace
```

```shell 測試插件安裝 theme={null}
/plugin install test-plugin@my-local-marketplace
```

## 管理市場操作

### 列出已知市場

```shell 列出所有配置的市場 theme={null}
/plugin marketplace list
```

顯示所有配置的市場及其來源和狀態。

### 更新市場元資料

```shell 重新整理市場元資料 theme={null}
/plugin marketplace update marketplace-name
```

從市場來源重新整理插件清單和元資料。

### 移除市場

```shell 移除市場 theme={null}
/plugin marketplace remove marketplace-name
```

從您的配置中移除市場。

<Warning>
  移除市場將解除安裝您從中安裝的任何插件。
</Warning>

***

## 市場疑難排解

### 常見市場問題

#### 市場無法載入

**症狀**：無法新增市場或看不到其中的插件

**解決方案**：

* 驗證市場 URL 是否可存取
* 檢查指定路徑是否存在 `.claude-plugin/marketplace.json`
* 使用 `claude plugin validate` 確保 JSON 語法有效
* 對於私人儲存庫，確認您有存取權限

#### 插件安裝失敗

**症狀**：市場出現但插件安裝失敗

**解決方案**：

* 驗證插件來源 URL 是否可存取
* 檢查插件目錄是否包含必需檔案
* 對於 GitHub 來源，確保儲存庫是公開的或您有存取權限
* 透過手動複製/下載測試插件來源

### 驗證和測試

在共享前測試您的市場：

```bash 驗證市場 JSON 語法 theme={null}
claude plugin validate .
```

```shell 新增市場進行測試 theme={null}
/plugin marketplace add ./path/to/marketplace
```

```shell 安裝測試插件 theme={null}
/plugin install test-plugin@marketplace-name
```

有關完整的插件測試工作流程，請參閱[在本地測試您的插件](/zh-TW/docs/claude-code/plugins#test-your-plugins-locally)。有關技術疑難排解，請參閱[插件參考](/zh-TW/docs/claude-code/plugins-reference)。

***

## 下一步

### 對於市場使用者

* **發現社群市場**：在 GitHub 上搜尋 Claude Code 插件集合
* **提供回饋**：向市場維護者報告問題並提出改進建議
* **分享有用的市場**：幫助您的團隊發現有價值的插件集合

### 對於市場建立者

* **建立插件集合**：圍繞特定使用案例建立主題市場
* **建立版本控制**：實施清晰的版本控制和更新政策
* **社群參與**：收集回饋並維護活躍的市場社群
* **文件**：提供清晰的 README 檔案解釋您的市場內容

### 對於組織

* **私人市場**：為專有工具設定內部市場
* **治理政策**：建立插件批准和安全審查指南
* **培訓資源**：幫助團隊有效發現和採用有用的插件

## 另請參閱

* [插件](/zh-TW/docs/claude-code/plugins) - 安裝和使用插件
* [插件參考](/zh-TW/docs/claude-code/plugins-reference) - 完整的技術規格和架構
* [插件開發](/zh-TW/docs/claude-code/plugins#develop-more-complex-plugins) - 建立您自己的插件
* [設定](/zh-TW/docs/claude-code/settings#plugin-configuration) - 插件配置選項

