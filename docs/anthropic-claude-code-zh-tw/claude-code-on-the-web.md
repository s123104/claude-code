---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/claude-code-on-the-web.md"
fetched_at: "2025-10-28T19:14:40+08:00"
---

# Claude Code on the web

> 在安全的雲端基礎設施上非同步執行 Claude Code 任務

<Note>
  Claude Code on the web 目前處於研究預覽階段。
</Note>

## Claude Code on the web 是什麼？

Claude Code on the web 讓開發人員可以從 Claude 應用程式啟動 Claude Code。這非常適合：

* **回答問題**：詢問程式碼架構以及功能如何實現
* **修復錯誤和例行任務**：定義明確的任務，不需要頻繁調整
* **並行工作**：同時處理多個錯誤修復
* **不在本機上的儲存庫**：處理您未在本機簽出的程式碼
* **後端變更**：Claude Code 可以編寫測試，然後編寫程式碼來通過這些測試

Claude Code 也可在 Claude iOS 應用程式上使用。這非常適合：

* **隨時隨地**：在通勤或遠離筆記型電腦時啟動任務
* **監控**：觀察軌跡並引導代理的工作

開發人員也可以將 Claude Code 工作階段從 Claude 應用程式移至其終端機，以在本機繼續執行任務。

## 誰可以使用 Claude Code on the web？

Claude Code on the web 在研究預覽中可供以下人員使用：

* **Pro 使用者**
* **Max 使用者**

即將推出給 Team 和 Enterprise 高級座位使用者。

## 開始使用

1. 造訪 [claude.ai/code](https://claude.ai/code)
2. 連接您的 GitHub 帳戶
3. 在您的儲存庫中安裝 Claude GitHub 應用程式
4. 選擇您的預設環境
5. 提交您的編碼任務
6. 檢查變更並在 GitHub 中建立拉取請求

## 運作方式

當您在 Claude Code on the web 上啟動任務時：

1. **儲存庫複製**：您的儲存庫被複製到 Anthropic 管理的虛擬機器
2. **環境設定**：Claude 準備一個安全的雲端環境，其中包含您的程式碼
3. **網路配置**：根據您的設定配置網際網路存取
4. **任務執行**：Claude 分析程式碼、進行變更、執行測試並檢查其工作
5. **完成**：完成後您會收到通知，並可以使用變更建立 PR
6. **結果**：變更被推送到分支，準備好建立拉取請求

## 在網頁和終端機之間移動任務

### 從網頁到終端機

在網頁上啟動任務後：

1. 點擊「在 CLI 中開啟」按鈕
2. 在儲存庫簽出的終端機中貼上並執行命令
3. 任何現有的本機變更都將被隱藏，遠端工作階段將被載入
4. 繼續在本機工作

## 雲端環境

### 預設映像

我們構建並維護一個通用映像，其中預先安裝了常見的工具鏈和語言生態系統。此映像包括：

* 流行的程式設計語言和執行時
* 常見的構建工具和套件管理器
* 測試框架和 linter

#### 檢查可用工具

要查看環境中預先安裝的內容，請要求 Claude Code 執行：

```bash  theme={null}
check-tools
```

此命令顯示：

* 程式設計語言及其版本
* 可用的套件管理器
* 已安裝的開發工具

#### 特定語言的設定

通用映像包括以下預先配置的環境：

* **Python**：Python 3.x，包含 pip、poetry 和常見的科學庫
* **Node.js**：最新 LTS 版本，包含 npm、yarn 和 pnpm
* **Java**：OpenJDK，包含 Maven 和 Gradle
* **Go**：最新穩定版本，包含模組支援
* **Rust**：Rust 工具鏈，包含 cargo
* **C++**：GCC 和 Clang 編譯器

### 環境配置

當您在 Claude Code on the web 中啟動工作階段時，以下是幕後發生的情況：

1. **環境準備**：我們複製您的儲存庫並執行任何為初始化配置的 Claude 掛鉤。儲存庫將使用 GitHub 儲存庫上的預設分支進行複製。如果您想簽出特定分支，可以在提示中指定。

2. **網路配置**：我們為代理配置網際網路存取。預設情況下網際網路存取受限，但您可以根據需要將環境配置為無網際網路或完全網際網路存取。

3. **Claude Code 執行**：Claude Code 執行以完成您的任務，編寫程式碼、執行測試並檢查其工作。您可以透過網頁介面在整個工作階段中引導和調整 Claude。Claude 尊重您在 `CLAUDE.md` 中定義的上下文。

4. **結果**：當 Claude 完成其工作時，它將推送分支到遠端。您將能夠為分支建立 PR。

<Note>
  Claude 完全透過環境中可用的終端機和 CLI 工具進行操作。它使用通用映像中預先安裝的工具以及您透過掛鉤或依賴管理安裝的任何其他工具。
</Note>

**新增環境**：選擇目前環境以開啟環境選擇器，然後選擇「新增環境」。這將開啟一個對話框，您可以在其中指定環境名稱、網路存取級別和任何要設定的環境變數。

**更新現有環境**：選擇目前環境，在環境名稱右側，然後選擇設定按鈕。這將開啟一個對話框，您可以在其中更新環境名稱、網路存取和環境變數。

<Note>
  環境變數必須指定為 [`.env` 格式](https://www.dotenv.org/)中的鍵值對。例如：

  ```
  API_KEY=your_api_key
  DEBUG=true
  ```
</Note>

### 依賴管理

使用 [SessionStart 掛鉤](/zh-TW/docs/claude-code/hooks#sessionstart)配置自動依賴安裝。這可以在您的儲存庫的 `.claude/settings.json` 檔案中配置：

```json  theme={null}
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/scripts/install_pkgs.sh"
          }
        ]
      }
    ]
  }
}
```

在 `scripts/install_pkgs.sh` 建立對應的指令碼：

```bash  theme={null}
#!/bin/bash
npm install
pip install -r requirements.txt
exit 0
```

使其可執行：`chmod +x scripts/install_pkgs.sh`

#### 本機與遠端執行

預設情況下，所有掛鉤在本機和遠端（網頁）環境中都執行。要僅在一個環境中執行掛鉤，請在掛鉤指令碼中檢查 `CLAUDE_CODE_REMOTE` 環境變數。

```bash  theme={null}
#!/bin/bash

# 範例：僅在遠端環境中執行
if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

npm install
pip install -r requirements.txt
```

#### 保留環境變數

SessionStart 掛鉤可以透過寫入 `CLAUDE_ENV_FILE` 環境變數中指定的檔案來為後續 bash 命令保留環境變數。有關詳細資訊，請參閱掛鉤參考中的 [SessionStart 掛鉤](/zh-TW/docs/claude-code/hooks#sessionstart)。

## 網路存取和安全性

### 網路政策

#### GitHub 代理

為了安全起見，所有 GitHub 操作都透過專用代理服務進行，該服務透明地處理所有 git 互動。在沙箱內，git 用戶端使用自訂構建的範圍認證進行身份驗證。此代理：

* 安全地管理 GitHub 身份驗證 - git 用戶端在沙箱內使用範圍認證，代理驗證並將其轉換為您的實際 GitHub 身份驗證令牌
* 限制 git push 操作到目前工作分支以確保安全
* 啟用無縫複製、提取和 PR 操作，同時維持安全邊界

#### 安全代理

環境在 HTTP/HTTPS 網路代理後面執行，以用於安全和濫用防止目的。所有出站網際網路流量都通過此代理，該代理提供：

* 防止惡意請求
* 速率限制和濫用防止
* 內容過濾以增強安全性

### 存取級別

預設情況下，網路存取限制為[允許清單域](#default-allowed-domains)。

您可以配置自訂網路存取，包括禁用網路存取。

### 預設允許的域

使用「有限」網路存取時，預設允許以下域：

#### Anthropic 服務

* api.anthropic.com
* statsig.anthropic.com
* claude.ai

#### 版本控制

* github.com
* [www.github.com](http://www.github.com)
* api.github.com
* raw\.githubusercontent.com
* objects.githubusercontent.com
* codeload.github.com
* avatars.githubusercontent.com
* camo.githubusercontent.com
* gist.github.com
* gitlab.com
* [www.gitlab.com](http://www.gitlab.com)
* registry.gitlab.com
* bitbucket.org
* [www.bitbucket.org](http://www.bitbucket.org)
* api.bitbucket.org

#### 容器登錄

* registry-1.docker.io
* auth.docker.io
* index.docker.io
* hub.docker.com
* [www.docker.com](http://www.docker.com)
* production.cloudflare.docker.com
* download.docker.com
* \*.gcr.io
* ghcr.io
* mcr.microsoft.com
* \*.data.mcr.microsoft.com

#### 雲端平台

* cloud.google.com
* accounts.google.com
* gcloud.google.com
* \*.googleapis.com
* storage.googleapis.com
* compute.googleapis.com
* container.googleapis.com
* azure.com
* portal.azure.com
* microsoft.com
* [www.microsoft.com](http://www.microsoft.com)
* \*.microsoftonline.com
* packages.microsoft.com
* dotnet.microsoft.com
* dot.net
* visualstudio.com
* dev.azure.com
* oracle.com
* [www.oracle.com](http://www.oracle.com)
* java.com
* [www.java.com](http://www.java.com)
* java.net
* [www.java.net](http://www.java.net)
* download.oracle.com
* yum.oracle.com

#### 套件管理器 - JavaScript/Node

* registry.npmjs.org
* [www.npmjs.com](http://www.npmjs.com)
* [www.npmjs.org](http://www.npmjs.org)
* npmjs.com
* npmjs.org
* yarnpkg.com
* registry.yarnpkg.com

#### 套件管理器 - Python

* pypi.org
* [www.pypi.org](http://www.pypi.org)
* files.pythonhosted.org
* pythonhosted.org
* test.pypi.org
* pypi.python.org
* pypa.io
* [www.pypa.io](http://www.pypa.io)

#### 套件管理器 - Ruby

* rubygems.org
* [www.rubygems.org](http://www.rubygems.org)
* api.rubygems.org
* index.rubygems.org
* ruby-lang.org
* [www.ruby-lang.org](http://www.ruby-lang.org)
* rubyforge.org
* [www.rubyforge.org](http://www.rubyforge.org)
* rubyonrails.org
* [www.rubyonrails.org](http://www.rubyonrails.org)
* rvm.io
* get.rvm.io

#### 套件管理器 - Rust

* crates.io
* [www.crates.io](http://www.crates.io)
* static.crates.io
* rustup.rs
* static.rust-lang.org
* [www.rust-lang.org](http://www.rust-lang.org)

#### 套件管理器 - Go

* proxy.golang.org
* sum.golang.org
* index.golang.org
* golang.org
* [www.golang.org](http://www.golang.org)
* goproxy.io
* pkg.go.dev

#### 套件管理器 - JVM

* maven.org
* repo.maven.org
* central.maven.org
* repo1.maven.org
* jcenter.bintray.com
* gradle.org
* [www.gradle.org](http://www.gradle.org)
* services.gradle.org
* spring.io
* repo.spring.io

#### 套件管理器 - 其他語言

* packagist.org (PHP Composer)
* [www.packagist.org](http://www.packagist.org)
* repo.packagist.org
* nuget.org (.NET NuGet)
* [www.nuget.org](http://www.nuget.org)
* api.nuget.org
* pub.dev (Dart/Flutter)
* api.pub.dev
* hex.pm (Elixir/Erlang)
* [www.hex.pm](http://www.hex.pm)
* cpan.org (Perl CPAN)
* [www.cpan.org](http://www.cpan.org)
* metacpan.org
* [www.metacpan.org](http://www.metacpan.org)
* api.metacpan.org
* cocoapods.org (iOS/macOS)
* [www.cocoapods.org](http://www.cocoapods.org)
* cdn.cocoapods.org
* haskell.org
* [www.haskell.org](http://www.haskell.org)
* hackage.haskell.org
* swift.org
* [www.swift.org](http://www.swift.org)

#### Linux 發行版

* archive.ubuntu.com
* security.ubuntu.com
* ubuntu.com
* [www.ubuntu.com](http://www.ubuntu.com)
* \*.ubuntu.com
* ppa.launchpad.net
* launchpad.net
* [www.launchpad.net](http://www.launchpad.net)

#### 開發工具和平台

* dl.k8s.io (Kubernetes)
* pkgs.k8s.io
* k8s.io
* [www.k8s.io](http://www.k8s.io)
* releases.hashicorp.com (HashiCorp)
* apt.releases.hashicorp.com
* rpm.releases.hashicorp.com
* archive.releases.hashicorp.com
* hashicorp.com
* [www.hashicorp.com](http://www.hashicorp.com)
* repo.anaconda.com (Anaconda/Conda)
* conda.anaconda.org
* anaconda.org
* [www.anaconda.com](http://www.anaconda.com)
* anaconda.com
* continuum.io
* apache.org (Apache)
* [www.apache.org](http://www.apache.org)
* archive.apache.org
* downloads.apache.org
* eclipse.org (Eclipse)
* [www.eclipse.org](http://www.eclipse.org)
* download.eclipse.org
* nodejs.org (Node.js)
* [www.nodejs.org](http://www.nodejs.org)

#### 雲端服務和監控

* statsig.com
* [www.statsig.com](http://www.statsig.com)
* api.statsig.com
* \*.sentry.io

#### 內容傳遞和鏡像

* \*.sourceforge.net
* packagecloud.io
* \*.packagecloud.io

#### 架構和配置

* json-schema.org
* [www.json-schema.org](http://www.json-schema.org)
* json.schemastore.org
* [www.schemastore.org](http://www.schemastore.org)

<Note>
  標記為 `*` 的域表示萬用字元子域匹配。例如，`*.gcr.io` 允許存取 `gcr.io` 的任何子域。
</Note>

### 自訂網路存取的安全最佳實踐

1. **最小權限原則**：僅啟用所需的最小網路存取
2. **定期審計**：定期檢查允許的域
3. **使用 HTTPS**：始終優先使用 HTTPS 端點而不是 HTTP

## 安全性和隔離

Claude Code on the web 提供強大的安全保證：

* **隔離的虛擬機器**：每個工作階段在隔離的 Anthropic 管理的 VM 中執行
* **網路存取控制**：預設情況下網路存取受限，可以禁用

<Note>
  在禁用網路存取的情況下執行時，Claude Code 被允許與 Anthropic API 通訊，這可能仍然允許資料離開隔離的 Claude Code VM。
</Note>

* **認證保護**：敏感認證（例如 git 認證或簽署金鑰）永遠不會在沙箱內與 Claude Code 一起。身份驗證透過使用範圍認證的安全代理進行處理
* **安全分析**：程式碼在隔離的 VM 內進行分析和修改，然後才建立 PR

## 定價和速率限制

Claude Code on the web 與您帳戶內所有其他 Claude 和 Claude Code 使用共享速率限制。並行執行多個任務將按比例消耗更多速率限制。

## 限制

* **儲存庫身份驗證**：只有在您已驗證到同一帳戶時，才能將工作階段從網頁移至本機
* **平台限制**：Claude Code on the web 僅適用於託管在 GitHub 中的程式碼。GitLab 和其他非 GitHub 儲存庫無法與雲端工作階段一起使用

## 最佳實踐

1. **使用 Claude Code 掛鉤**：配置 [sessionStart 掛鉤](/zh-TW/docs/claude-code/hooks#sessionstart)以自動化環境設定和依賴安裝。
2. **記錄需求**：在 `CLAUDE.md` 檔案中清楚指定依賴和命令。如果您有 `AGENTS.md` 檔案，可以使用 `@AGENTS.md` 在 `CLAUDE.md` 中來源它以維持單一真實來源。

## 相關資源

* [掛鉤配置](/zh-TW/docs/claude-code/hooks)
* [設定參考](/zh-TW/docs/claude-code/settings)
* [安全性](/zh-TW/docs/claude-code/security)
* [資料使用](/zh-TW/docs/claude-code/data-usage)

