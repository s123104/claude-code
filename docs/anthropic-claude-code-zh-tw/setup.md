---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/setup.md"
fetched_at: "2025-10-28T19:18:52+08:00"
---

# 設定 Claude Code

> 在您的開發機器上安裝、驗證並開始使用 Claude Code。

## 系統需求

* **作業系統**: macOS 10.15+、Ubuntu 20.04+/Debian 10+，或 Windows 10+（搭配 WSL 1、WSL 2 或 Git for Windows）
* **硬體**: 4GB+ RAM
* **軟體**: [Node.js 18+](https://nodejs.org/en/download)
* **網路**: 需要網際網路連線進行驗證和 AI 處理
* **Shell**: 在 Bash、Zsh 或 Fish 中運作最佳
* **位置**: [Anthropic 支援的國家](https://www.anthropic.com/supported-countries)

### 額外相依性

* **ripgrep**: 通常包含在 Claude Code 中。如果搜尋功能失效，請參閱[搜尋疑難排解](/zh-TW/docs/claude-code/troubleshooting#search-and-discovery-issues)。

## 標準安裝

To install Claude Code, run the following command:

```sh  theme={null}
npm install -g @anthropic-ai/claude-code
```

<Warning>
  請勿使用 `sudo npm install -g`，因為這可能導致權限問題和安全風險。
  如果您遇到權限錯誤，請參閱[設定 Claude Code](/zh-TW/docs/claude-code/troubleshooting#linux-permission-issues) 以取得建議的解決方案。
</Warning>

<Note>
  某些使用者可能會自動遷移到改良的安裝方法。
  安裝後執行 `claude doctor` 來檢查您的安裝類型。
</Note>

安裝程序完成後，導航到您的專案並啟動 Claude Code：

```bash  theme={null}
cd your-awesome-project
claude
```

Claude Code 提供以下驗證選項：

1. **Claude Console**: 預設選項。透過 Claude Console 連線並完成 OAuth 程序。需要在 [console.anthropic.com](https://console.anthropic.com) 啟用計費。將自動建立「Claude Code」工作區用於使用追蹤和成本管理。請注意，您無法為 Claude Code 工作區建立 API 金鑰 - 它專門用於 Claude Code 使用。
2. **Claude App（搭配 Pro 或 Max 方案）**: 訂閱 Claude 的 [Pro 或 Max 方案](https://claude.com/pricing)，獲得包含 Claude Code 和網頁介面的統一訂閱。以相同價格獲得更多價值，同時在一個地方管理您的帳戶。使用您的 Claude.ai 帳戶登入。在啟動期間，選擇符合您訂閱類型的選項。
3. **企業平台**: 設定 Claude Code 使用 [Amazon Bedrock 或 Google Vertex AI](/zh-TW/docs/claude-code/third-party-integrations) 進行企業部署，搭配您現有的雲端基礎設施。

<Note>
  Claude Code 安全地儲存您的憑證。詳情請參閱[憑證管理](/zh-TW/docs/claude-code/iam#credential-management)。
</Note>

## Windows 設定

**選項 1: WSL 中的 Claude Code**

* 支援 WSL 1 和 WSL 2

**選項 2: 原生 Windows 上的 Claude Code 搭配 Git Bash**

* 需要 [Git for Windows](https://git-scm.com/downloads/win)
* 對於可攜式 Git 安裝，請指定您的 `bash.exe` 路徑：
  ```powershell  theme={null}
  $env:CLAUDE_CODE_GIT_BASH_PATH="C:\Program Files\Git\bin\bash.exe"
  ```

## 替代安裝方法

Claude Code 提供多種安裝方法以適應不同環境。

如果您在安裝過程中遇到任何問題，請參閱[疑難排解指南](/zh-TW/docs/claude-code/troubleshooting#linux-permission-issues)。

<Tip>
  安裝後執行 `claude doctor` 來檢查您的安裝類型和版本。
</Tip>

### 全域 npm 安裝

上述[安裝步驟](#standard-installation)中顯示的傳統方法

### 原生二進位安裝（Beta）

如果您已有 Claude Code 的現有安裝，請使用 `claude install` 開始原生二進位安裝。

對於全新安裝，執行以下命令之一：

**Homebrew（macOS、Linux）:**

```sh  theme={null}
brew install --cask claude-code
```

<Note>
  透過 Homebrew 安裝的 Claude Code 將在 brew 目錄外自動更新，除非使用 `DISABLE_AUTOUPDATER` 環境變數明確停用（請參閱[自動更新](#auto-updates)章節）。
</Note>

**macOS、Linux、WSL:**

```bash  theme={null}
# 安裝穩定版本（預設）
curl -fsSL https://claude.ai/install.sh | bash

# 安裝最新版本
curl -fsSL https://claude.ai/install.sh | bash -s latest

# 安裝特定版本號
curl -fsSL https://claude.ai/install.sh | bash -s 1.0.58
```

<Note>
  **Alpine Linux 和其他基於 musl/uClibc 的發行版**: 原生建置需要您安裝 `libgcc`、`libstdc++` 和 `ripgrep`。安裝（Alpine: `apk add libgcc libstdc++ ripgrep`）並設定 `USE_BUILTIN_RIPGREP=0`。
</Note>

**Windows PowerShell:**

```powershell  theme={null}
# 安裝穩定版本（預設）
irm https://claude.ai/install.ps1 | iex

# 安裝最新版本
& ([scriptblock]::Create((irm https://claude.ai/install.ps1))) latest

# 安裝特定版本號
& ([scriptblock]::Create((irm https://claude.ai/install.ps1))) 1.0.58
```

**Windows CMD:**

```batch  theme={null}
REM 安裝穩定版本（預設）
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd

REM 安裝最新版本
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd latest && del install.cmd

REM 安裝特定版本號
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd 1.0.58 && del install.cmd
```

原生 Claude Code 安裝程式支援 macOS、Linux 和 Windows。

<Tip>
  確保您移除任何過時的別名或符號連結。
  安裝完成後，執行 `claude doctor` 來驗證安裝。
</Tip>

### 本機安裝

* 透過 npm 全域安裝後，使用 `claude migrate-installer` 移至本機
* 避免自動更新程式 npm 權限問題
* 某些使用者可能會自動遷移到此方法

## 在 AWS 或 GCP 上執行

預設情況下，Claude Code 使用 Claude API。

有關在 AWS 或 GCP 上執行 Claude Code 的詳細資訊，請參閱[第三方整合](/zh-TW/docs/claude-code/third-party-integrations)。

## 更新 Claude Code

### 自動更新

Claude Code 自動保持最新狀態，確保您擁有最新功能和安全修復。

* **更新檢查**: 在啟動時和執行期間定期執行
* **更新程序**: 在背景自動下載和安裝
* **通知**: 安裝更新時您會看到通知
* **套用更新**: 更新在您下次啟動 Claude Code 時生效

**停用自動更新:**

在您的 shell 或 [settings.json 檔案](/zh-TW/docs/claude-code/settings)中設定 `DISABLE_AUTOUPDATER` 環境變數：

```bash  theme={null}
export DISABLE_AUTOUPDATER=1
```

### 手動更新

```bash  theme={null}
claude update
```

