---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/settings.md"
fetched_at: "2025-10-28T19:18:50+08:00"
---

# Claude Code 設定

> 使用全域和專案層級設定以及環境變數來設定 Claude Code。

Claude Code 提供多種設定選項，可根據您的需求設定其行為。您可以在使用互動式 REPL 時執行 `/config` 命令來設定 Claude Code，這會開啟一個分頁式設定介面，您可以在其中查看狀態資訊並修改設定選項。

## 設定檔案

`settings.json` 檔案是我們用於透過階層式設定來設定 Claude Code 的官方機制：

* **使用者設定**定義在 `~/.claude/settings.json` 中，適用於所有專案。
* **專案設定**儲存在您的專案目錄中：
  * `.claude/settings.json` 用於簽入原始碼控制並與您的團隊共享的設定
  * `.claude/settings.local.json` 用於未簽入的設定，適用於個人偏好和實驗。Claude Code 在建立 `.claude/settings.local.json` 時會將其設定為 git 忽略。
* 對於 Claude Code 的企業部署，我們也支援**企業管理的原則設定**。這些設定優先於使用者和專案設定。系統管理員可以將原則部署到：
  * macOS：`/Library/Application Support/ClaudeCode/managed-settings.json`
  * Linux 和 WSL：`/etc/claude-code/managed-settings.json`
  * Windows：`C:\ProgramData\ClaudeCode\managed-settings.json`
* 企業部署也可以設定**受管 MCP 伺服器**，這會覆蓋使用者設定的伺服器。請參閱[企業 MCP 設定](/zh-TW/docs/claude-code/mcp#enterprise-mcp-configuration)：
  * macOS：`/Library/Application Support/ClaudeCode/managed-mcp.json`
  * Linux 和 WSL：`/etc/claude-code/managed-mcp.json`
  * Windows：`C:\ProgramData\ClaudeCode\managed-mcp.json`

```JSON Example settings.json theme={null}
{
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test:*)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl:*)",
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)"
    ]
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_METRICS_EXPORTER": "otlp"
  }
}
```

### 可用的設定

`settings.json` 支援多個選項：

| 鍵                            | 說明                                                                                                                                                            | 範例                                                          |
| :--------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------- |
| `apiKeyHelper`               | 自訂指令碼，在 `/bin/sh` 中執行，用於產生驗證值。此值將作為 `X-Api-Key` 和 `Authorization: Bearer` 標頭傳送以進行模型請求                                                                         | `/bin/generate_temp_api_key.sh`                             |
| `cleanupPeriodDays`          | 根據上次活動日期在本機保留聊天記錄的時間長度（預設值：30 天）                                                                                                                              | `20`                                                        |
| `env`                        | 將應用於每個工作階段的環境變數                                                                                                                                               | `{"FOO": "bar"}`                                            |
| `includeCoAuthoredBy`        | 是否在 git 提交和拉取請求中包含 `co-authored-by Claude` 署名（預設值：`true`）                                                                                                     | `false`                                                     |
| `permissions`                | 請參閱下表以了解權限的結構。                                                                                                                                                |                                                             |
| `hooks`                      | 設定自訂命令以在工具執行前後執行。請參閱 [hooks 文件](hooks)                                                                                                                        | `{"PreToolUse": {"Bash": "echo 'Running command..'"}}`      |
| `disableAllHooks`            | 停用所有 [hooks](hooks)                                                                                                                                           | `true`                                                      |
| `model`                      | 覆蓋 Claude Code 使用的預設模型                                                                                                                                        | `"claude-sonnet-4-5-20250929"`                              |
| `statusLine`                 | 設定自訂狀態行以顯示上下文。請參閱 [statusLine 文件](statusline)                                                                                                                 | `{"type": "command", "command": "~/.claude/statusline.sh"}` |
| `outputStyle`                | 設定輸出樣式以調整系統提示。請參閱[輸出樣式文件](output-styles)                                                                                                                      | `"Explanatory"`                                             |
| `forceLoginMethod`           | 使用 `claudeai` 限制登入到 Claude.ai 帳戶，使用 `console` 限制登入到 Claude Console（API 使用計費）帳戶                                                                                | `claudeai`                                                  |
| `forceLoginOrgUUID`          | 指定組織的 UUID 以在登入期間自動選擇它，略過組織選擇步驟。需要設定 `forceLoginMethod`                                                                                                       | `"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"`                    |
| `enableAllProjectMcpServers` | 自動核准在專案 `.mcp.json` 檔案中定義的所有 MCP 伺服器                                                                                                                          | `true`                                                      |
| `enabledMcpjsonServers`      | 要核准的 `.mcp.json` 檔案中特定 MCP 伺服器的清單                                                                                                                             | `["memory", "github"]`                                      |
| `disabledMcpjsonServers`     | 要拒絕的 `.mcp.json` 檔案中特定 MCP 伺服器的清單                                                                                                                             | `["filesystem"]`                                            |
| `useEnterpriseMcpConfigOnly` | 在 managed-settings.json 中設定時，將 MCP 伺服器限制為僅在 managed-mcp.json 中定義的伺服器。請參閱[企業 MCP 設定](/zh-TW/docs/claude-code/mcp#enterprise-mcp-configuration)                 | `true`                                                      |
| `allowedMcpServers`          | 在 managed-settings.json 中設定時，使用者可以設定的 MCP 伺服器的允許清單。未定義 = 無限制，空陣列 = 鎖定。適用於所有範圍。拒絕清單優先。請參閱[企業 MCP 設定](/zh-TW/docs/claude-code/mcp#enterprise-mcp-configuration) | `[{ "serverName": "github" }]`                              |
| `deniedMcpServers`           | 在 managed-settings.json 中設定時，明確封鎖的 MCP 伺服器的拒絕清單。適用於所有範圍，包括企業伺服器。拒絕清單優先於允許清單。請參閱[企業 MCP 設定](/zh-TW/docs/claude-code/mcp#enterprise-mcp-configuration)          | `[{ "serverName": "filesystem" }]`                          |
| `awsAuthRefresh`             | 修改 `.aws` 目錄的自訂指令碼（請參閱[進階認證設定](/zh-TW/docs/claude-code/amazon-bedrock#advanced-credential-configuration)）                                                     | `aws sso login --profile myprofile`                         |
| `awsCredentialExport`        | 輸出包含 AWS 認證的 JSON 的自訂指令碼（請參閱[進階認證設定](/zh-TW/docs/claude-code/amazon-bedrock#advanced-credential-configuration)）                                               | `/bin/generate_aws_grant.sh`                                |

### 權限設定

| 鍵                              | 說明                                                                                                                                                                                                        | 範例                                                                     |
| :----------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------- |
| `allow`                        | [權限規則](/zh-TW/docs/claude-code/iam#configuring-permissions)的陣列，允許工具使用。**注意：** Bash 規則使用前綴匹配，而不是正規表達式                                                                                                      | `[ "Bash(git diff:*)" ]`                                               |
| `ask`                          | [權限規則](/zh-TW/docs/claude-code/iam#configuring-permissions)的陣列，在工具使用時要求確認。                                                                                                                                | `[ "Bash(git push:*)" ]`                                               |
| `deny`                         | [權限規則](/zh-TW/docs/claude-code/iam#configuring-permissions)的陣列，拒絕工具使用。也可用於排除敏感檔案不被 Claude Code 存取。**注意：** Bash 模式是前綴匹配，可能被繞過（請參閱 [Bash 權限限制](/zh-TW/docs/claude-code/iam#tool-specific-permission-rules)） | `[ "WebFetch", "Bash(curl:*)", "Read(./.env)", "Read(./secrets/**)" ]` |
| `additionalDirectories`        | Claude 可以存取的其他[工作目錄](iam#working-directories)                                                                                                                                                             | `[ "../docs/" ]`                                                       |
| `defaultMode`                  | 開啟 Claude Code 時的預設[權限模式](iam#permission-modes)                                                                                                                                                           | `"acceptEdits"`                                                        |
| `disableBypassPermissionsMode` | 設定為 `"disable"` 以防止 `bypassPermissions` 模式被啟動。這會停用 `--dangerously-skip-permissions` 命令列旗標。請參閱[受管原則設定](iam#enterprise-managed-policy-settings)                                                             | `"disable"`                                                            |

### 沙箱設定

設定進階沙箱行為。沙箱將 bash 命令與您的檔案系統和網路隔離。詳細資訊請參閱[沙箱](/zh-TW/docs/claude-code/sandboxing)。

**檔案系統和網路限制**透過 Read、Edit 和 WebFetch 權限規則設定，而不是透過這些沙箱設定。

| 鍵                           | 說明                                                   | 範例                        |
| :-------------------------- | :--------------------------------------------------- | :------------------------ |
| `enabled`                   | 啟用 bash 沙箱（僅限 macOS/Linux）。預設值：false                 | `true`                    |
| `autoAllowBashIfSandboxed`  | 沙箱化時自動核准 bash 命令。預設值：true                            | `true`                    |
| `excludedCommands`          | 應在沙箱外執行的命令                                           | `["git", "docker"]`       |
| `network.allowUnixSockets`  | 沙箱中可存取的 Unix 套接字路徑（用於 SSH 代理等）                       | `["~/.ssh/agent-socket"]` |
| `network.allowLocalBinding` | 允許繫結到 localhost 連接埠（僅限 MacOS）。預設值：false              | `true`                    |
| `network.httpProxyPort`     | 如果您想使用自己的代理，則使用的 HTTP 代理連接埠。如果未指定，Claude 將執行自己的代理。   | `8080`                    |
| `network.socksProxyPort`    | 如果您想使用自己的代理，則使用的 SOCKS5 代理連接埠。如果未指定，Claude 將執行自己的代理。 | `8081`                    |
| `enableWeakerNestedSandbox` | 為無特權 Docker 環境啟用較弱的沙箱（僅限 Linux）。**降低安全性。** 預設值：false | `true`                    |

**設定範例：**

```json  theme={null}
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "excludedCommands": ["docker"],
    "network": {
      "allowUnixSockets": [
        "/var/run/docker.sock"
      ],
      "allowLocalBinding": true
    }
  },
  "permissions": {
    "deny": [
      "Read(.envrc)",
      "Read(~/.aws/**)"
    ]
  }
}
```

**檔案系統存取**透過 Read/Edit 權限控制：

* Read 拒絕規則在沙箱中封鎖檔案讀取
* Edit 允許規則允許檔案寫入（除了預設值，例如目前工作目錄）
* Edit 拒絕規則在允許的路徑內封鎖寫入

**網路存取**透過 WebFetch 權限控制：

* WebFetch 允許規則允許網路網域
* WebFetch 拒絕規則封鎖網路網域

### 設定優先順序

設定按優先順序（從高到低）應用：

1. **企業管理的原則** (`managed-settings.json`)
   * 由 IT/DevOps 部署
   * 無法被覆蓋

2. **命令列引數**
   * 特定工作階段的臨時覆蓋

3. **本機專案設定** (`.claude/settings.local.json`)
   * 個人專案特定設定

4. **共享專案設定** (`.claude/settings.json`)
   * 原始碼控制中的團隊共享專案設定

5. **使用者設定** (`~/.claude/settings.json`)
   * 個人全域設定

此階層結構確保企業安全原則始終被強制執行，同時仍允許團隊和個人自訂其體驗。

### 設定系統的重點

* **記憶體檔案 (CLAUDE.md)**：包含 Claude 在啟動時載入的指示和上下文
* **設定檔案 (JSON)**：設定權限、環境變數和工具行為
* **斜線命令**：可在工作階段期間使用 `/command-name` 叫用的自訂命令
* **MCP 伺服器**：使用其他工具和整合擴展 Claude Code
* **優先順序**：更高層級的設定（企業）覆蓋更低層級的設定（使用者/專案）
* **繼承**：設定被合併，更具體的設定新增到或覆蓋更廣泛的設定

### 系統提示可用性

<Note>
  與 claude.ai 不同，我們不在本網站上發佈 Claude Code 的內部系統提示。使用 CLAUDE.md 檔案或 `--append-system-prompt` 將自訂指示新增到 Claude Code 的行為。
</Note>

### 排除敏感檔案

為了防止 Claude Code 存取包含敏感資訊的檔案（例如 API 金鑰、機密、環境檔案），請在 `.claude/settings.json` 檔案中使用 `permissions.deny` 設定：

```json  theme={null}
{
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Read(./config/credentials.json)",
      "Read(./build)"
    ]
  }
}
```

這取代了已棄用的 `ignorePatterns` 設定。符合這些模式的檔案將對 Claude Code 完全不可見，防止任何敏感資料的意外洩露。

## 子代理設定

Claude Code 支援可在使用者和專案層級設定的自訂 AI 子代理。這些子代理儲存為具有 YAML frontmatter 的 Markdown 檔案：

* **使用者子代理**：`~/.claude/agents/` - 在所有專案中可用
* **專案子代理**：`.claude/agents/` - 特定於您的專案，可與您的團隊共享

子代理檔案定義具有自訂提示和工具權限的專門 AI 助手。在[子代理文件](/zh-TW/docs/claude-code/sub-agents)中了解更多關於建立和使用子代理的資訊。

## 外掛程式設定

Claude Code 支援外掛程式系統，可讓您使用自訂命令、代理、hooks 和 MCP 伺服器擴展功能。外掛程式透過市場分發，可在使用者和儲存庫層級設定。

### 外掛程式設定

`settings.json` 中的外掛程式相關設定：

```json  theme={null}
{
  "enabledPlugins": {
    "formatter@company-tools": true,
    "deployer@company-tools": true,
    "analyzer@security-plugins": false
  },
  "extraKnownMarketplaces": {
    "company-tools": {
      "source": "github",
      "repo": "company/claude-plugins"
    }
  }
}
```

#### `enabledPlugins`

控制啟用哪些外掛程式。格式：`"plugin-name@marketplace-name": true/false`

**範圍**：

* **使用者設定** (`~/.claude/settings.json`)：個人外掛程式偏好
* **專案設定** (`.claude/settings.json`)：與團隊共享的專案特定外掛程式
* **本機設定** (`.claude/settings.local.json`)：每台機器的覆蓋（未提交）

**範例**：

```json  theme={null}
{
  "enabledPlugins": {
    "code-formatter@team-tools": true,
    "deployment-tools@team-tools": true,
    "experimental-features@personal": false
  }
}
```

#### `extraKnownMarketplaces`

定義應為儲存庫提供的其他市場。通常在儲存庫層級設定中使用，以確保團隊成員可以存取所需的外掛程式來源。

**當儲存庫包含 `extraKnownMarketplaces` 時**：

1. 當團隊成員信任該資料夾時，系統會提示他們安裝市場
2. 然後系統會提示團隊成員從該市場安裝外掛程式
3. 使用者可以跳過不需要的市場或外掛程式（儲存在使用者設定中）
4. 安裝遵守信任邊界並需要明確同意

**範例**：

```json  theme={null}
{
  "extraKnownMarketplaces": {
    "company-tools": {
      "source": {
        "source": "github",
        "repo": "company-org/claude-plugins"
      }
    },
    "security-plugins": {
      "source": {
        "source": "git",
        "url": "https://git.company.com/security/plugins.git"
      }
    }
  }
}
```

**市場來源類型**：

* `github`：GitHub 儲存庫（使用 `repo`）
* `git`：任何 git URL（使用 `url`）
* `directory`：本機檔案系統路徑（使用 `path`，僅用於開發）

### 管理外掛程式

使用 `/plugin` 命令以互動方式管理外掛程式：

* 瀏覽市場中的可用外掛程式
* 安裝/解除安裝外掛程式
* 啟用/停用外掛程式
* 檢視外掛程式詳細資訊（提供的命令、代理、hooks）
* 新增/移除市場

在[外掛程式文件](/zh-TW/docs/claude-code/plugins)中了解更多關於外掛程式系統的資訊。

## 環境變數

Claude Code 支援以下環境變數來控制其行為：

<Note>
  所有環境變數也可以在 [`settings.json`](#available-settings) 中設定。這是自動為每個工作階段設定環境變數或為整個團隊或組織推出一組環境變數的有用方式。
</Note>

| 變數                                         | 目的                                                                                                                                                                                    |
| :----------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `ANTHROPIC_API_KEY`                        | 作為 `X-Api-Key` 標頭傳送的 API 金鑰，通常用於 Claude SDK（用於互動使用，執行 `/login`）                                                                                                                       |
| `ANTHROPIC_AUTH_TOKEN`                     | `Authorization` 標頭的自訂值（您在此設定的值將以 `Bearer ` 為前綴）                                                                                                                                       |
| `ANTHROPIC_CUSTOM_HEADERS`                 | 您想新增到請求的自訂標頭（採用 `Name: Value` 格式）                                                                                                                                                     |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL`            | 請參閱[模型設定](/zh-TW/docs/claude-code/model-config#environment-variables)                                                                                                                 |
| `ANTHROPIC_DEFAULT_OPUS_MODEL`             | 請參閱[模型設定](/zh-TW/docs/claude-code/model-config#environment-variables)                                                                                                                 |
| `ANTHROPIC_DEFAULT_SONNET_MODEL`           | 請參閱[模型設定](/zh-TW/docs/claude-code/model-config#environment-variables)                                                                                                                 |
| `ANTHROPIC_MODEL`                          | 要使用的模型設定名稱（請參閱[模型設定](/zh-TW/docs/claude-code/model-config#environment-variables)）                                                                                                     |
| `ANTHROPIC_SMALL_FAST_MODEL`               | \[已棄用] [用於背景工作的 Haiku 級模型](/zh-TW/docs/claude-code/costs)的名稱                                                                                                                          |
| `ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION`    | 使用 Bedrock 時覆蓋 Haiku 級模型的 AWS 區域                                                                                                                                                      |
| `AWS_BEARER_TOKEN_BEDROCK`                 | Bedrock API 金鑰用於驗證（請參閱 [Bedrock API 金鑰](https://aws.amazon.com/blogs/machine-learning/accelerate-ai-development-with-amazon-bedrock-api-keys/)）                                       |
| `BASH_DEFAULT_TIMEOUT_MS`                  | 長時間執行 bash 命令的預設逾時                                                                                                                                                                    |
| `BASH_MAX_OUTPUT_LENGTH`                   | bash 輸出中的最大字元數，超過此數量後將進行中間截斷                                                                                                                                                          |
| `BASH_MAX_TIMEOUT_MS`                      | 模型可以為長時間執行的 bash 命令設定的最大逾時                                                                                                                                                            |
| `CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR` | 在每個 Bash 命令後返回原始工作目錄                                                                                                                                                                  |
| `CLAUDE_CODE_API_KEY_HELPER_TTL_MS`        | 應刷新認證的間隔（以毫秒為單位）（使用 `apiKeyHelper` 時）                                                                                                                                                 |
| `CLAUDE_CODE_CLIENT_CERT`                  | 用於 mTLS 驗證的用戶端憑證檔案路徑                                                                                                                                                                  |
| `CLAUDE_CODE_CLIENT_KEY_PASSPHRASE`        | 加密 CLAUDE\_CODE\_CLIENT\_KEY 的密碼（可選）                                                                                                                                                  |
| `CLAUDE_CODE_CLIENT_KEY`                   | 用於 mTLS 驗證的用戶端私密金鑰檔案路徑                                                                                                                                                                |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | 等同於設定 `DISABLE_AUTOUPDATER`、`DISABLE_BUG_COMMAND`、`DISABLE_ERROR_REPORTING` 和 `DISABLE_TELEMETRY`                                                                                     |
| `CLAUDE_CODE_DISABLE_TERMINAL_TITLE`       | 設定為 `1` 以停用根據對話上下文自動更新終端機標題                                                                                                                                                           |
| `CLAUDE_CODE_IDE_SKIP_AUTO_INSTALL`        | 跳過 IDE 擴充功能的自動安裝                                                                                                                                                                      |
| `CLAUDE_CODE_MAX_OUTPUT_TOKENS`            | 設定大多數請求的最大輸出權杖數                                                                                                                                                                       |
| `CLAUDE_CODE_SKIP_BEDROCK_AUTH`            | 跳過 Bedrock 的 AWS 驗證（例如使用 LLM 閘道時）                                                                                                                                                     |
| `CLAUDE_CODE_SKIP_VERTEX_AUTH`             | 跳過 Vertex 的 Google 驗證（例如使用 LLM 閘道時）                                                                                                                                                   |
| `CLAUDE_CODE_SUBAGENT_MODEL`               | 請參閱[模型設定](/zh-TW/docs/claude-code/model-config)                                                                                                                                       |
| `CLAUDE_CODE_USE_BEDROCK`                  | 使用 [Bedrock](/zh-TW/docs/claude-code/amazon-bedrock)                                                                                                                                  |
| `CLAUDE_CODE_USE_VERTEX`                   | 使用 [Vertex](/zh-TW/docs/claude-code/google-vertex-ai)                                                                                                                                 |
| `DISABLE_AUTOUPDATER`                      | 設定為 `1` 以停用自動更新。這優先於 `autoUpdates` 設定設定。                                                                                                                                              |
| `DISABLE_BUG_COMMAND`                      | 設定為 `1` 以停用 `/bug` 命令                                                                                                                                                                 |
| `DISABLE_COST_WARNINGS`                    | 設定為 `1` 以停用成本警告訊息                                                                                                                                                                     |
| `DISABLE_ERROR_REPORTING`                  | 設定為 `1` 以選擇退出 Sentry 錯誤報告                                                                                                                                                             |
| `DISABLE_NON_ESSENTIAL_MODEL_CALLS`        | 設定為 `1` 以停用非關鍵路徑（如風味文字）的模型呼叫                                                                                                                                                          |
| `DISABLE_PROMPT_CACHING`                   | 設定為 `1` 以停用所有模型的提示快取（優先於每個模型設定）                                                                                                                                                       |
| `DISABLE_PROMPT_CACHING_HAIKU`             | 設定為 `1` 以停用 Haiku 模型的提示快取                                                                                                                                                             |
| `DISABLE_PROMPT_CACHING_OPUS`              | 設定為 `1` 以停用 Opus 模型的提示快取                                                                                                                                                              |
| `DISABLE_PROMPT_CACHING_SONNET`            | 設定為 `1` 以停用 Sonnet 模型的提示快取                                                                                                                                                            |
| `DISABLE_TELEMETRY`                        | 設定為 `1` 以選擇退出 Statsig 遙測（請注意，Statsig 事件不包含使用者資料，如程式碼、檔案路徑或 bash 命令）                                                                                                                   |
| `HTTP_PROXY`                               | 為網路連線指定 HTTP 代理伺服器                                                                                                                                                                    |
| `HTTPS_PROXY`                              | 為網路連線指定 HTTPS 代理伺服器                                                                                                                                                                   |
| `MAX_MCP_OUTPUT_TOKENS`                    | MCP 工具回應中允許的最大權杖數。當輸出超過 10,000 個權杖時，Claude Code 會顯示警告（預設值：25000）                                                                                                                      |
| `MAX_THINKING_TOKENS`                      | 啟用[延伸思考](/zh-TW/docs/build-with-claude/extended-thinking)並設定思考過程的權杖預算。延伸思考改進複雜推理和編碼工作的效能，但影響[提示快取效率](/zh-TW/docs/build-with-claude/prompt-caching#caching-with-thinking-blocks)。預設停用。 |
| `MCP_TIMEOUT`                              | MCP 伺服器啟動的逾時（以毫秒為單位）                                                                                                                                                                  |
| `MCP_TOOL_TIMEOUT`                         | MCP 工具執行的逾時（以毫秒為單位）                                                                                                                                                                   |
| `NO_PROXY`                                 | 將直接發出請求的網域和 IP 清單，略過代理                                                                                                                                                                |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET`           | 顯示給 [SlashCommand 工具](/zh-TW/docs/claude-code/slash-commands#slashcommand-tool)的斜線命令中繼資料的最大字元數（預設值：15000）                                                                             |
| `USE_BUILTIN_RIPGREP`                      | 設定為 `0` 以使用系統安裝的 `rg` 而不是 Claude Code 隨附的 `rg`                                                                                                                                        |
| `VERTEX_REGION_CLAUDE_3_5_HAIKU`           | 使用 Vertex AI 時覆蓋 Claude 3.5 Haiku 的區域                                                                                                                                                 |
| `VERTEX_REGION_CLAUDE_3_5_SONNET`          | 使用 Vertex AI 時覆蓋 Claude 3.5 Sonnet 的區域                                                                                                                                                |
| `VERTEX_REGION_CLAUDE_3_7_SONNET`          | 使用 Vertex AI 時覆蓋 Claude 3.7 Sonnet 的區域                                                                                                                                                |
| `VERTEX_REGION_CLAUDE_4_0_OPUS`            | 使用 Vertex AI 時覆蓋 Claude 4.0 Opus 的區域                                                                                                                                                  |
| `VERTEX_REGION_CLAUDE_4_0_SONNET`          | 使用 Vertex AI 時覆蓋 Claude 4.0 Sonnet 的區域                                                                                                                                                |
| `VERTEX_REGION_CLAUDE_4_1_OPUS`            | 使用 Vertex AI 時覆蓋 Claude 4.1 Opus 的區域                                                                                                                                                  |

## Claude 可用的工具

Claude Code 可以存取一組強大的工具，幫助它理解和修改您的程式碼庫：

| 工具               | 說明                                                                   | 需要權限 |
| :--------------- | :------------------------------------------------------------------- | :--- |
| **Bash**         | 在您的環境中執行 shell 命令                                                    | 是    |
| **Edit**         | 對特定檔案進行有針對性的編輯                                                       | 是    |
| **Glob**         | 根據模式匹配尋找檔案                                                           | 否    |
| **Grep**         | 在檔案內容中搜尋模式                                                           | 否    |
| **NotebookEdit** | 修改 Jupyter 筆記本儲存格                                                    | 是    |
| **NotebookRead** | 讀取並顯示 Jupyter 筆記本內容                                                  | 否    |
| **Read**         | 讀取檔案的內容                                                              | 否    |
| **SlashCommand** | 執行[自訂斜線命令](/zh-TW/docs/claude-code/slash-commands#slashcommand-tool) | 是    |
| **Task**         | 執行子代理以處理複雜的多步驟工作                                                     | 否    |
| **TodoWrite**    | 建立和管理結構化工作清單                                                         | 否    |
| **WebFetch**     | 從指定的 URL 擷取內容                                                        | 是    |
| **WebSearch**    | 執行具有網域篩選的網路搜尋                                                        | 是    |
| **Write**        | 建立或覆蓋檔案                                                              | 是    |

權限規則可以使用 `/allowed-tools` 或在[權限設定](/zh-TW/docs/claude-code/settings#available-settings)中設定。另請參閱[工具特定權限規則](/zh-TW/docs/claude-code/iam#tool-specific-permission-rules)。

### 使用 hooks 擴展工具

您可以使用[Claude Code hooks](/zh-TW/docs/claude-code/hooks-guide)在任何工具執行前後執行自訂命令。

例如，您可以在 Claude 修改 Python 檔案後自動執行 Python 格式化程式，或透過封鎖對特定路徑的 Write 操作來防止修改生產設定檔案。

## 另請參閱

* [身份和存取管理](/zh-TW/docs/claude-code/iam#configuring-permissions) - 了解 Claude Code 的權限系統
* [IAM 和存取控制](/zh-TW/docs/claude-code/iam#enterprise-managed-policy-settings) - 企業原則管理
* [疑難排解](/zh-TW/docs/claude-code/troubleshooting#auto-updater-issues) - 常見設定問題的解決方案

