---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/iam.md"
fetched_at: "2025-10-28T19:17:19+08:00"
---

# 身份與存取管理

> 了解如何為您的組織配置 Claude Code 的使用者驗證、授權和存取控制。

## 驗證方法

設定 Claude Code 需要存取 Anthropic 模型。對於團隊，您可以透過以下三種方式之一設定 Claude Code 存取：

* 透過 Claude Console 使用 Claude API
* Amazon Bedrock
* Google Vertex AI

### Claude API 驗證

**透過 Claude API 為您的團隊設定 Claude Code 存取：**

1. 使用您現有的 Claude Console 帳戶或建立新的 Claude Console 帳戶
2. 您可以透過以下任一方法新增使用者：
   * 從 Console 內批量邀請使用者（Console -> Settings -> Members -> Invite）
   * [設定 SSO](https://support.claude.com/en/articles/10280258-setting-up-single-sign-on-on-the-api-console)
3. 邀請使用者時，他們需要以下角色之一：
   * "Claude Code" 角色表示使用者只能建立 Claude Code API 金鑰
   * "Developer" 角色表示使用者可以建立任何類型的 API 金鑰
4. 每個受邀使用者需要完成以下步驟：
   * 接受 Console 邀請
   * [檢查系統需求](/zh-TW/docs/claude-code/setup#system-requirements)
   * [安裝 Claude Code](/zh-TW/docs/claude-code/setup#installation)
   * 使用 Console 帳戶憑證登入

### 雲端提供商驗證

**透過 Bedrock 或 Vertex 為您的團隊設定 Claude Code 存取：**

1. 遵循 [Bedrock 文件](/zh-TW/docs/claude-code/amazon-bedrock) 或 [Vertex 文件](/zh-TW/docs/claude-code/google-vertex-ai)
2. 將環境變數和產生雲端憑證的指示分發給您的使用者。閱讀更多關於如何[在此管理配置](/zh-TW/docs/claude-code/settings)。
3. 使用者可以[安裝 Claude Code](/zh-TW/docs/claude-code/setup#installation)

## 存取控制和權限

我們支援細粒度權限，讓您能夠精確指定代理被允許執行的操作（例如執行測試、執行 linter）以及不被允許執行的操作（例如更新雲端基礎設施）。這些權限設定可以檢入版本控制並分發給組織中的所有開發者，也可以由個別開發者自訂。

### 權限系統

Claude Code 使用分層權限系統來平衡功能和安全性：

| 工具類型    | 範例           | 需要批准 | "是，不要再問" 行為 |
| :------ | :----------- | :--- | :---------- |
| 唯讀      | 檔案讀取、LS、Grep | 否    | 不適用         |
| Bash 指令 | Shell 執行     | 是    | 永久針對專案目錄和指令 |
| 檔案修改    | 編輯/寫入檔案      | 是    | 直到會話結束      |

### 配置權限

您可以使用 `/permissions` 檢視和管理 Claude Code 的工具權限。此 UI 列出所有權限規則和它們來源的 settings.json 檔案。

* **Allow** 規則將允許 Claude Code 使用指定的工具而無需進一步的手動批准。
* **Ask** 規則將在 Claude Code 嘗試使用指定工具時要求使用者確認。Ask 規則優先於 allow 規則。
* **Deny** 規則將阻止 Claude Code 使用指定的工具。Deny 規則優先於 allow 和 ask 規則。
* **Additional directories** 將 Claude 的檔案存取擴展到初始工作目錄之外的目錄。
* **Default mode** 控制 Claude 在遇到新請求時的權限行為。

權限規則使用格式：`Tool` 或 `Tool(optional-specifier)`

僅為工具名稱的規則匹配該工具的任何使用。例如，將 `Bash` 新增到 allow 規則清單中將允許 Claude Code 使用 Bash 工具而無需使用者批准。

#### 權限模式

Claude Code 支援幾種權限模式，可以在[設定檔案](/zh-TW/docs/claude-code/settings#settings-files)中設定為 `defaultMode`：

| 模式                  | 描述                             |
| :------------------ | :----------------------------- |
| `default`           | 標準行為 - 在首次使用每個工具時提示權限          |
| `acceptEdits`       | 自動接受會話的檔案編輯權限                  |
| `plan`              | 計劃模式 - Claude 可以分析但不能修改檔案或執行指令 |
| `bypassPermissions` | 跳過所有權限提示（需要安全環境 - 請參閱下方警告）     |

#### 工作目錄

預設情況下，Claude 可以存取啟動目錄中的檔案。您可以擴展此存取：

* **啟動期間**：使用 `--add-dir <path>` CLI 參數
* **會話期間**：使用 `/add-dir` 斜線指令
* **持久配置**：新增到[設定檔案](/zh-TW/docs/claude-code/settings#settings-files)中的 `additionalDirectories`

附加目錄中的檔案遵循與原始工作目錄相同的權限規則 - 它們變為可讀而無需提示，檔案編輯權限遵循當前權限模式。

#### 工具特定權限規則

某些工具支援更細粒度的權限控制：

**Bash**

* `Bash(npm run build)` 匹配確切的 Bash 指令 `npm run build`
* `Bash(npm run test:*)` 匹配以 `npm run test` 開頭的 Bash 指令
* `Bash(curl http://site.com/:*)` 匹配以確切的 `curl http://site.com/` 開頭的 curl 指令

<Tip>
  Claude Code 了解 shell 運算子（如 `&&`），因此像 `Bash(safe-cmd:*)` 這樣的前綴匹配規則不會給它執行指令 `safe-cmd && other-cmd` 的權限
</Tip>

<Warning>
  Bash 權限模式的重要限制：

  1. 此工具使用**前綴匹配**，而非正規表達式或 glob 模式
  2. 萬用字元 `:*` 只能在模式末尾使用以匹配任何延續
  3. 像 `Bash(curl http://github.com/:*)` 這樣的模式可以透過許多方式繞過：
     * URL 前的選項：`curl -X GET http://github.com/...` 不會匹配
     * 不同協定：`curl https://github.com/...` 不會匹配
     * 重新導向：`curl -L http://bit.ly/xyz`（重新導向到 github）
     * 變數：`URL=http://github.com && curl $URL` 不會匹配
     * 額外空格：`curl  http://github.com` 不會匹配

  為了更可靠的 URL 過濾，請考慮：

  * 使用 WebFetch 工具與 `WebFetch(domain:github.com)` 權限
  * 透過 CLAUDE.md 指示 Claude Code 您允許的 curl 模式
  * 使用 hooks 進行自訂權限驗證
</Warning>

**Read & Edit**

`Edit` 規則適用於所有編輯檔案的內建工具。Claude 將盡力嘗試將 `Read` 規則應用於所有讀取檔案的內建工具，如 Grep、Glob 和 LS。

Read & Edit 規則都遵循 [gitignore](https://git-scm.com/docs/gitignore) 規範，具有四種不同的模式類型：

| 模式                | 意義                | 範例                               | 匹配                                 |
| ----------------- | ----------------- | -------------------------------- | ---------------------------------- |
| `//path`          | 從檔案系統根目錄的**絕對**路徑 | `Read(//Users/alice/secrets/**)` | `/Users/alice/secrets/**`          |
| `~/path`          | 從**家目錄**的路徑       | `Read(~/Documents/*.pdf)`        | `/Users/alice/Documents/*.pdf`     |
| `/path`           | **相對於設定檔案**的路徑    | `Edit(/src/**/*.ts)`             | `<settings file path>/src/**/*.ts` |
| `path` 或 `./path` | **相對於當前目錄**的路徑    | `Read(*.env)`                    | `<cwd>/*.env`                      |

<Warning>
  像 `/Users/alice/file` 這樣的模式不是絕對路徑 - 它是相對於您的設定檔案的！使用 `//Users/alice/file` 表示絕對路徑。
</Warning>

* `Edit(/docs/**)` - 在 `<project>/docs/` 中編輯（不是 `/docs/`！）
* `Read(~/.zshrc)` - 讀取您家目錄的 `.zshrc`
* `Edit(//tmp/scratch.txt)` - 編輯絕對路徑 `/tmp/scratch.txt`
* `Read(src/**)` - 從 `<current-directory>/src/` 讀取

**WebFetch**

* `WebFetch(domain:example.com)` 匹配對 example.com 的取得請求

**MCP**

* `mcp__puppeteer` 匹配由 `puppeteer` 伺服器提供的任何工具（在 Claude Code 中配置的名稱）
* `mcp__puppeteer__puppeteer_navigate` 匹配由 `puppeteer` 伺服器提供的 `puppeteer_navigate` 工具

<Warning>
  與其他權限類型不同，MCP 權限不支援萬用字元（`*`）。

  要批准來自 MCP 伺服器的所有工具：

  * ✅ 使用：`mcp__github`（批准所有 GitHub 工具）
  * ❌ 不要使用：`mcp__github__*`（不支援萬用字元）

  要僅批准特定工具，請列出每一個：

  * ✅ 使用：`mcp__github__get_issue`
  * ✅ 使用：`mcp__github__list_issues`
</Warning>

### 使用 hooks 進行額外權限控制

[Claude Code hooks](/zh-TW/docs/claude-code/hooks-guide) 提供了一種註冊自訂 shell 指令以在執行時進行權限評估的方法。當 Claude Code 進行工具呼叫時，PreToolUse hooks 在權限系統執行之前執行，hook 輸出可以決定是否批准或拒絕工具呼叫以取代權限系統。

### 企業管理政策設定

對於 Claude Code 的企業部署，我們支援企業管理政策設定，這些設定優先於使用者和專案設定。這允許系統管理員強制執行使用者無法覆蓋的安全政策。

系統管理員可以將政策部署到：

* macOS：`/Library/Application Support/ClaudeCode/managed-settings.json`
* Linux 和 WSL：`/etc/claude-code/managed-settings.json`
* Windows：`C:\ProgramData\ClaudeCode\managed-settings.json`

這些政策檔案遵循與常規[設定檔案](/zh-TW/docs/claude-code/settings#settings-files)相同的格式，但不能被使用者或專案設定覆蓋。這確保了整個組織的一致安全政策。

### 設定優先順序

當存在多個設定來源時，它們按以下順序應用（從最高到最低優先順序）：

1. 企業政策
2. 命令列參數
3. 本地專案設定（`.claude/settings.local.json`）
4. 共享專案設定（`.claude/settings.json`）
5. 使用者設定（`~/.claude/settings.json`）

此層次結構確保組織政策始終得到執行，同時在適當的情況下仍允許在專案和使用者層級的靈活性。

## 憑證管理

Claude Code 安全地管理您的驗證憑證：

* **儲存位置**：在 macOS 上，API 金鑰、OAuth 權杖和其他憑證儲存在加密的 macOS Keychain 中。
* **支援的驗證類型**：Claude.ai 憑證、Claude API 憑證、Bedrock Auth 和 Vertex Auth。
* **自訂憑證腳本**：[`apiKeyHelper`](/zh-TW/docs/claude-code/settings#available-settings) 設定可以配置為執行返回 API 金鑰的 shell 腳本。
* **重新整理間隔**：預設情況下，`apiKeyHelper` 在 5 分鐘後或在 HTTP 401 回應時被呼叫。設定 `CLAUDE_CODE_API_KEY_HELPER_TTL_MS` 環境變數以自訂重新整理間隔。

