---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/plugins.md"
fetched_at: "2025-10-29T14:11:25+08:00"
---

# 外掛程式

> 透過外掛程式系統使用自訂命令、代理、鉤子、技能和 MCP 伺服器擴展 Claude Code。

<Tip>
  如需完整的技術規格和結構描述，請參閱[外掛程式參考](/zh-TW/docs/claude-code/plugins-reference)。如需市場管理，請參閱[外掛程式市場](/zh-TW/docs/claude-code/plugin-marketplaces)。
</Tip>

外掛程式可讓您使用可在專案和團隊中共享的自訂功能擴展 Claude Code。從[市場](/zh-TW/docs/claude-code/plugin-marketplaces)安裝外掛程式以新增預先建置的命令、代理、鉤子、技能和 MCP 伺服器，或建立您自己的外掛程式以自動化您的工作流程。

## 快速入門

讓我們建立一個簡單的問候外掛程式，讓您熟悉外掛程式系統。我們將建置一個可運作的外掛程式，新增自訂命令，在本地測試它，並理解核心概念。

### 先決條件

* 在您的機器上安裝了 Claude Code
* 對命令列工具有基本的熟悉度

### 建立您的第一個外掛程式

<Steps>
  <Step title="建立市場結構">
    ```bash  theme={null}
    mkdir test-marketplace
    cd test-marketplace
    ```
  </Step>

  <Step title="建立外掛程式目錄">
    ```bash  theme={null}
    mkdir my-first-plugin
    cd my-first-plugin
    ```
  </Step>

  <Step title="建立外掛程式清單">
    ```bash Create .claude-plugin/plugin.json theme={null}
    mkdir .claude-plugin
    cat > .claude-plugin/plugin.json << 'EOF'
    {
    "name": "my-first-plugin",
    "description": "A simple greeting plugin to learn the basics",
    "version": "1.0.0",
    "author": {
    "name": "Your Name"
    }
    }
    EOF
    ```
  </Step>

  <Step title="新增自訂命令">
    ```bash Create commands/hello.md theme={null}
    mkdir commands
    cat > commands/hello.md << 'EOF'
    ---
    description: Greet the user with a personalized message
    ---

    # Hello Command

    Greet the user warmly and ask how you can help them today. Make the greeting personal and encouraging.
    EOF
    ```
  </Step>

  <Step title="建立市場清單">
    ```bash Create marketplace.json theme={null}
    cd ..
    mkdir .claude-plugin
    cat > .claude-plugin/marketplace.json << 'EOF'
    {
    "name": "test-marketplace",
    "owner": {
    "name": "Test User"
    },
    "plugins": [
    {
      "name": "my-first-plugin",
      "source": "./my-first-plugin",
      "description": "My first test plugin"
    }
    ]
    }
    EOF
    ```
  </Step>

  <Step title="安裝並測試您的外掛程式">
    ```bash Start Claude Code from parent directory theme={null}
    cd ..
    claude
    ```

    ```shell Add the test marketplace theme={null}
    /plugin marketplace add ./test-marketplace
    ```

    ```shell Install your plugin theme={null}
    /plugin install my-first-plugin@test-marketplace
    ```

    選擇「立即安裝」。然後您需要重新啟動 Claude Code 才能使用新外掛程式。

    ```shell Try your new command theme={null}
    /hello
    ```

    您將看到 Claude 使用您的問候命令！檢查 `/help` 以查看您的新命令列表。
  </Step>
</Steps>

您已成功建立並測試了具有以下關鍵元件的外掛程式：

* **外掛程式清單** (`.claude-plugin/plugin.json`) - 描述您的外掛程式的中繼資料
* **命令目錄** (`commands/`) - 包含您的自訂斜線命令
* **測試市場** - 允許您在本地測試您的外掛程式

### 外掛程式結構概述

您的外掛程式遵循此基本結構：

```
my-first-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── commands/                 # Custom slash commands (optional)
│   └── hello.md
├── agents/                   # Custom agents (optional)
│   └── helper.md
├── skills/                   # Agent Skills (optional)
│   └── my-skill/
│       └── SKILL.md
└── hooks/                    # Event handlers (optional)
    └── hooks.json
```

**您可以新增的其他元件：**

* **命令**：在 `commands/` 目錄中建立 markdown 檔案
* **代理**：在 `agents/` 目錄中建立代理定義
* **技能**：在 `skills/` 目錄中建立 `SKILL.md` 檔案
* **鉤子**：為事件處理建立 `hooks/hooks.json`
* **MCP 伺服器**：為外部工具整合建立 `.mcp.json`

<Note>
  **後續步驟**：準備好新增更多功能了嗎？跳至[開發更複雜的外掛程式](#develop-more-complex-plugins)以新增代理、鉤子和 MCP 伺服器。如需所有外掛程式元件的完整技術規格，請參閱[外掛程式參考](/zh-TW/docs/claude-code/plugins-reference)。
</Note>

***

## 安裝和管理外掛程式

了解如何發現、安裝和管理外掛程式以擴展您的 Claude Code 功能。

### 先決條件

* Claude Code 已安裝並執行
* 對命令列介面有基本的熟悉度

### 新增市場

市場是可用外掛程式的目錄。新增它們以發現和安裝外掛程式：

```shell Add a marketplace theme={null}
/plugin marketplace add your-org/claude-plugins
```

```shell Browse available plugins theme={null}
/plugin
```

如需詳細的市場管理，包括 Git 儲存庫、本地開發和團隊分發，請參閱[外掛程式市場](/zh-TW/docs/claude-code/plugin-marketplaces)。

### 安裝外掛程式

#### 透過互動式選單（建議用於發現）

```shell Open the plugin management interface theme={null}
/plugin
```

選擇「瀏覽外掛程式」以查看具有描述、功能和安裝選項的可用選項。

#### 透過直接命令（用於快速安裝）

```shell Install a specific plugin theme={null}
/plugin install formatter@your-org
```

```shell Enable a disabled plugin theme={null}
/plugin enable plugin-name@marketplace-name
```

```shell Disable without uninstalling theme={null}
/plugin disable plugin-name@marketplace-name
```

```shell Completely remove a plugin theme={null}
/plugin uninstall plugin-name@marketplace-name
```

### 驗證安裝

安裝外掛程式後：

1. **檢查可用命令**：執行 `/help` 以查看新命令
2. **測試外掛程式功能**：嘗試外掛程式的命令和功能
3. **檢查外掛程式詳細資訊**：使用 `/plugin` → 「管理外掛程式」以查看外掛程式提供的內容

## 設定團隊外掛程式工作流程

在儲存庫層級設定外掛程式，以確保整個團隊的工具一致。當團隊成員信任您的儲存庫資料夾時，Claude Code 會自動安裝指定的市場和外掛程式。

**設定團隊外掛程式的方法：**

1. 將市場和外掛程式設定新增到您的儲存庫的 `.claude/settings.json`
2. 團隊成員信任儲存庫資料夾
3. 外掛程式自動為所有團隊成員安裝

如需完整的說明，包括設定範例、市場設定和推出最佳實踐，請參閱[設定團隊市場](/zh-TW/docs/claude-code/plugin-marketplaces#how-to-configure-team-marketplaces)。

***

## 開發更複雜的外掛程式

一旦您對基本外掛程式感到滿意，您可以建立更複雜的擴展。

### 將技能新增到您的外掛程式

外掛程式可以包含[代理技能](/zh-TW/docs/claude-code/skills)以擴展 Claude 的功能。技能是由模型呼叫的 - Claude 根據任務上下文自主使用它們。

要將技能新增到您的外掛程式，請在您的外掛程式根目錄建立 `skills/` 目錄，並新增包含 `SKILL.md` 檔案的技能資料夾。外掛程式技能在安裝外掛程式時自動可用。

如需完整的技能編寫指南，請參閱[代理技能](/zh-TW/docs/claude-code/skills)。

### 組織複雜的外掛程式

對於具有許多元件的外掛程式，請按功能組織您的目錄結構。如需完整的目錄配置和組織模式，請參閱[外掛程式目錄結構](/zh-TW/docs/claude-code/plugins-reference#plugin-directory-structure)。

### 在本地測試您的外掛程式

開發外掛程式時，使用本地市場來迭代測試變更。此工作流程基於快速入門模式，適用於任何複雜度的外掛程式。

<Steps>
  <Step title="設定您的開發結構">
    組織您的外掛程式和市場以進行測試：

    ```bash Create directory structure theme={null}
    mkdir dev-marketplace
    cd dev-marketplace
    mkdir my-plugin
    ```

    這會建立：

    ```
    dev-marketplace/
    ├── .claude-plugin/marketplace.json  (you'll create this)
    └── my-plugin/                        (your plugin under development)
        ├── .claude-plugin/plugin.json
        ├── commands/
        ├── agents/
        └── hooks/
    ```
  </Step>

  <Step title="建立市場清單">
    ```bash Create marketplace.json theme={null}
    mkdir .claude-plugin
    cat > .claude-plugin/marketplace.json << 'EOF'
    {
    "name": "dev-marketplace",
    "owner": {
    "name": "Developer"
    },
    "plugins": [
    {
      "name": "my-plugin",
      "source": "./my-plugin",
      "description": "Plugin under development"
    }
    ]
    }
    EOF
    ```
  </Step>

  <Step title="安裝並測試">
    ```bash Start Claude Code from parent directory theme={null}
    cd ..
    claude
    ```

    ```shell Add your development marketplace theme={null}
    /plugin marketplace add ./dev-marketplace
    ```

    ```shell Install your plugin theme={null}
    /plugin install my-plugin@dev-marketplace
    ```

    測試您的外掛程式元件：

    * 使用 `/command-name` 嘗試您的命令
    * 檢查代理是否出現在 `/agents` 中
    * 驗證鉤子是否按預期工作
  </Step>

  <Step title="迭代您的外掛程式">
    對您的外掛程式程式碼進行變更後：

    ```shell Uninstall the current version theme={null}
    /plugin uninstall my-plugin@dev-marketplace
    ```

    ```shell Reinstall to test changes theme={null}
    /plugin install my-plugin@dev-marketplace
    ```

    在開發和改進外掛程式時重複此週期。
  </Step>
</Steps>

<Note>
  **對於多個外掛程式**：在子目錄中組織外掛程式，例如 `./plugins/plugin-name`，並相應地更新您的 marketplace.json。請參閱[外掛程式來源](/zh-TW/docs/claude-code/plugin-marketplaces#plugin-sources)以了解組織模式。
</Note>

### 偵錯外掛程式問題

如果您的外掛程式無法按預期工作：

1. **檢查結構**：確保您的目錄位於外掛程式根目錄，而不是在 `.claude-plugin/` 內
2. **個別測試元件**：分別檢查每個命令、代理和鉤子
3. **使用驗證和偵錯工具**：請參閱[偵錯和開發工具](/zh-TW/docs/claude-code/plugins-reference#debugging-and-development-tools)以了解 CLI 命令和故障排除技術

### 共享您的外掛程式

當您的外掛程式準備好共享時：

1. **新增文件**：包含 README.md，其中包含安裝和使用說明
2. **版本化您的外掛程式**：在您的 `plugin.json` 中使用語義版本控制
3. **建立或使用市場**：透過外掛程式市場分發以便於安裝
4. **與他人測試**：在更廣泛的分發前讓團隊成員測試外掛程式

<Note>
  如需完整的技術規格、偵錯技術和分發策略，請參閱[外掛程式參考](/zh-TW/docs/claude-code/plugins-reference)。
</Note>

***

## 後續步驟

現在您已了解 Claude Code 的外掛程式系統，以下是針對不同目標的建議路徑：

### 對於外掛程式使用者

* **發現外掛程式**：瀏覽社群市場以尋找有用的工具
* **團隊採用**：為您的專案設定儲存庫層級的外掛程式
* **市場管理**：了解如何管理多個外掛程式來源
* **進階用法**：探索外掛程式組合和工作流程

### 對於外掛程式開發人員

* **建立您的第一個市場**：[外掛程式市場指南](/zh-TW/docs/claude-code/plugin-marketplaces)
* **進階元件**：深入探討特定的外掛程式元件：
  * [斜線命令](/zh-TW/docs/claude-code/slash-commands) - 命令開發詳細資訊
  * [子代理](/zh-TW/docs/claude-code/sub-agents) - 代理設定和功能
  * [代理技能](/zh-TW/docs/claude-code/skills) - 擴展 Claude 的功能
  * [鉤子](/zh-TW/docs/claude-code/hooks) - 事件處理和自動化
  * [MCP](/zh-TW/docs/claude-code/mcp) - 外部工具整合
* **分發策略**：有效地打包和共享您的外掛程式
* **社群貢獻**：考慮為社群外掛程式集合做出貢獻

### 對於團隊主管和管理員

* **儲存庫設定**：為團隊專案設定自動外掛程式安裝
* **外掛程式治理**：建立外掛程式批准和安全審查的指南
* **市場維護**：建立和維護組織特定的外掛程式目錄
* **培訓和文件**：幫助團隊成員有效地採用外掛程式工作流程

## 另請參閱

* [外掛程式市場](/zh-TW/docs/claude-code/plugin-marketplaces) - 建立和管理外掛程式目錄
* [斜線命令](/zh-TW/docs/claude-code/slash-commands) - 了解自訂命令
* [子代理](/zh-TW/docs/claude-code/sub-agents) - 建立和使用專門代理
* [代理技能](/zh-TW/docs/claude-code/skills) - 擴展 Claude 的功能
* [鉤子](/zh-TW/docs/claude-code/hooks) - 使用事件處理程式自動化工作流程
* [MCP](/zh-TW/docs/claude-code/mcp) - 連接到外部工具和服務
* [設定](/zh-TW/docs/claude-code/settings) - 外掛程式的設定選項

