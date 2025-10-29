---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/troubleshooting.md"
fetched_at: "2025-10-29T14:12:19+08:00"
---

# 疑難排解

> 探索 Claude Code 安裝和使用常見問題的解決方案。

## 常見安裝問題

### Windows 安裝問題：WSL 中的錯誤

您可能在 WSL 中遇到以下問題：

**作業系統/平台檢測問題**：如果您在安裝過程中收到錯誤，WSL 可能正在使用 Windows `npm`。請嘗試：

* 在安裝前執行 `npm config set os linux`
* 使用 `npm install -g @anthropic-ai/claude-code --force --no-os-check` 安裝（請勿使用 `sudo`）

**找不到 Node 錯誤**：如果您在執行 `claude` 時看到 `exec: node: not found`，您的 WSL 環境可能正在使用 Windows 安裝的 Node.js。您可以使用 `which npm` 和 `which node` 來確認，這些應該指向以 `/usr/` 開頭的 Linux 路徑，而不是 `/mnt/c/`。要修復此問題，請嘗試透過您的 Linux 發行版套件管理器或透過 [`nvm`](https://github.com/nvm-sh/nvm) 安裝 Node。

**nvm 版本衝突**：如果您在 WSL 和 Windows 中都安裝了 nvm，在 WSL 中切換 Node 版本時可能會遇到版本衝突。這是因為 WSL 預設匯入 Windows PATH，導致 Windows nvm/npm 優先於 WSL 安裝。

您可以透過以下方式識別此問題：

* 執行 `which npm` 和 `which node` - 如果它們指向 Windows 路徑（以 `/mnt/c/` 開頭），則正在使用 Windows 版本
* 在 WSL 中使用 nvm 切換 Node 版本後功能損壞

要解決此問題，請修復您的 Linux PATH 以確保 Linux node/npm 版本優先：

**主要解決方案：確保 nvm 在您的 shell 中正確載入**

最常見的原因是 nvm 沒有在非互動式 shell 中載入。將以下內容新增到您的 shell 設定檔（`~/.bashrc`、`~/.zshrc` 等）：

```bash  theme={null}
# Load nvm if it exists
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```

或在您目前的會話中直接執行：

```bash  theme={null}
source ~/.nvm/nvm.sh
```

**替代方案：調整 PATH 順序**

如果 nvm 已正確載入但 Windows 路徑仍然優先，您可以在 shell 設定中明確將 Linux 路徑前置到 PATH：

```bash  theme={null}
export PATH="$HOME/.nvm/versions/node/$(node -v)/bin:$PATH"
```

<Warning>
  避免停用 Windows PATH 匯入（`appendWindowsPath = false`），因為這會破壞從 WSL 輕鬆呼叫 Windows 可執行檔的能力。同樣，如果您將 Node.js 用於 Windows 開發，請避免從 Windows 解除安裝 Node.js。
</Warning>

### Linux 和 Mac 安裝問題：權限或找不到命令錯誤

使用 npm 安裝 Claude Code 時，`PATH` 問題可能會阻止存取 `claude`。
如果您的 npm 全域前綴不可由使用者寫入（例如 `/usr` 或 `/usr/local`），您也可能遇到權限錯誤。

#### 建議解決方案：原生 Claude Code 安裝

Claude Code 有一個不依賴 npm 或 Node.js 的原生安裝。

<Note>
  原生 Claude Code 安裝程式目前處於測試階段。
</Note>

使用以下命令執行原生安裝程式。

**macOS、Linux、WSL：**

```bash  theme={null}
# Install stable version (default)
curl -fsSL https://claude.ai/install.sh | bash

# Install latest version
curl -fsSL https://claude.ai/install.sh | bash -s latest

# Install specific version number
curl -fsSL https://claude.ai/install.sh | bash -s 1.0.58
```

**Windows PowerShell：**

```powershell  theme={null}
# Install stable version (default)
irm https://claude.ai/install.ps1 | iex

# Install latest version
& ([scriptblock]::Create((irm https://claude.ai/install.ps1))) latest

# Install specific version number
& ([scriptblock]::Create((irm https://claude.ai/install.ps1))) 1.0.58

```

此命令為您的作業系統和架構安裝適當的 Claude Code 建置，並在 `~/.local/bin/claude` 新增安裝的符號連結。

<Tip>
  確保您的系統 PATH 中包含安裝目錄。
</Tip>

#### 替代解決方案：遷移到本地安裝

或者，如果 Claude Code 可以執行，您可以遷移到本地安裝：

```bash  theme={null}
claude migrate-installer
```

這會將 Claude Code 移動到 `~/.claude/local/` 並在您的 shell 設定中設定別名。未來更新不需要 `sudo`。

遷移後，重新啟動您的 shell，然後驗證您的安裝：

在 macOS/Linux/WSL 上：

```bash  theme={null}
which claude  # Should show an alias to ~/.claude/local/claude
```

在 Windows 上：

```powershell  theme={null}
where claude  # Should show path to claude executable
```

驗證安裝：

```bash  theme={null}
claude doctor # Check installation health
```

## 權限和身份驗證

### 重複的權限提示

如果您發現自己重複批准相同的命令，您可以使用 `/permissions` 命令允許特定工具在不需要批准的情況下執行。請參閱[權限文件](/zh-TW/docs/claude-code/iam#configuring-permissions)。

### 身份驗證問題

如果您遇到身份驗證問題：

1. 執行 `/logout` 完全登出
2. 關閉 Claude Code
3. 使用 `claude` 重新啟動並再次完成身份驗證過程

如果問題持續存在，請嘗試：

```bash  theme={null}
rm -rf ~/.config/claude-code/auth.json
claude
```

這會移除您儲存的身份驗證資訊並強制進行乾淨登入。

## 效能和穩定性

### 高 CPU 或記憶體使用量

Claude Code 設計用於與大多數開發環境配合使用，但在處理大型程式碼庫時可能會消耗大量資源。如果您遇到效能問題：

1. 定期使用 `/compact` 來減少上下文大小
2. 在主要任務之間關閉並重新啟動 Claude Code
3. 考慮將大型建置目錄新增到您的 `.gitignore` 檔案

### 命令掛起或凍結

如果 Claude Code 似乎沒有回應：

1. 按 Ctrl+C 嘗試取消目前操作
2. 如果沒有回應，您可能需要關閉終端機並重新啟動

### 搜尋和發現問題

如果搜尋工具、`@file` 提及、自訂代理和自訂斜線命令無法運作，請安裝系統 `ripgrep`：

```bash  theme={null}
# macOS (Homebrew)  
brew install ripgrep

# Windows (winget)
winget install BurntSushi.ripgrep.MSVC

# Ubuntu/Debian
sudo apt install ripgrep

# Alpine Linux
apk add ripgrep

# Arch Linux
pacman -S ripgrep
```

然後在您的[環境](/zh-TW/docs/claude-code/settings#environment-variables)中設定 `USE_BUILTIN_RIPGREP=0`。

### WSL 上搜尋結果緩慢或不完整

在 WSL 上[跨檔案系統工作](https://learn.microsoft.com/en-us/windows/wsl/filesystems)時的磁碟讀取效能損失可能會導致在 WSL 上使用 Claude Code 時匹配結果少於預期（但不是完全缺乏搜尋功能）。

<Note>
  在這種情況下，`/doctor` 會顯示搜尋為正常。
</Note>

**解決方案：**

1. **提交更具體的搜尋**：透過指定目錄或檔案類型來減少搜尋的檔案數量："在 auth-service 套件中搜尋 JWT 驗證邏輯"或"在 JS 檔案中尋找 md5 雜湊的使用"。

2. **將專案移動到 Linux 檔案系統**：如果可能，確保您的專案位於 Linux 檔案系統（`/home/`）而不是 Windows 檔案系統（`/mnt/c/`）。

3. **使用原生 Windows**：考慮在 Windows 上原生執行 Claude Code 而不是透過 WSL，以獲得更好的檔案系統效能。

## IDE 整合問題

### WSL2 上未檢測到 JetBrains IDE

如果您在 WSL2 上使用 Claude Code 與 JetBrains IDE 並收到"未檢測到可用的 IDE"錯誤，這可能是由於 WSL2 的網路設定或 Windows 防火牆阻止連線。

#### WSL2 網路模式

WSL2 預設使用 NAT 網路，這可能會阻止 IDE 檢測。您有兩個選項：

**選項 1：設定 Windows 防火牆**（建議）

1. 尋找您的 WSL2 IP 位址：
   ```bash  theme={null}
   wsl hostname -I
   # Example output: 172.21.123.456
   ```

2. 以管理員身份開啟 PowerShell 並建立防火牆規則：
   ```powershell  theme={null}
   New-NetFirewallRule -DisplayName "Allow WSL2 Internal Traffic" -Direction Inbound -Protocol TCP -Action Allow -RemoteAddress 172.21.0.0/16 -LocalAddress 172.21.0.0/16
   ```
   （根據步驟 1 中的 WSL2 子網路調整 IP 範圍）

3. 重新啟動您的 IDE 和 Claude Code

**選項 2：切換到鏡像網路**

在您的 Windows 使用者目錄中將以下內容新增到 `.wslconfig`：

```ini  theme={null}
[wsl2]
networkingMode=mirrored
```

然後從 PowerShell 使用 `wsl --shutdown` 重新啟動 WSL。

<Note>
  這些網路問題只影響 WSL2。WSL1 直接使用主機的網路，不需要這些設定。
</Note>

有關其他 JetBrains 設定提示，請參閱我們的 [IDE 整合指南](/zh-TW/docs/claude-code/ide-integrations#jetbrains-plugin-settings)。

### 回報 Windows IDE 整合問題（原生和 WSL）

如果您在 Windows 上遇到 IDE 整合問題，請[建立問題](https://github.com/anthropics/claude-code/issues)並提供以下資訊：您是原生（git bash）還是 WSL1/WSL2、WSL 網路模式（NAT 或鏡像）、IDE 名稱/版本、Claude Code 擴充功能/外掛程式版本，以及 shell 類型（bash/zsh/等）

### JetBrains（IntelliJ、PyCharm 等）終端機中 ESC 鍵無法運作

如果您在 JetBrains 終端機中使用 Claude Code 且 ESC 鍵無法如預期中斷代理，這可能是由於與 JetBrains 預設快捷鍵的按鍵綁定衝突。

要修復此問題：

1. 前往設定 → 工具 → 終端機
2. 選擇：
   * 取消勾選"使用 Escape 將焦點移動到編輯器"，或
   * 點選"設定終端機按鍵綁定"並刪除"切換焦點到編輯器"快捷鍵
3. 套用變更

這允許 ESC 鍵正確中斷 Claude Code 操作。

## Markdown 格式問題

Claude Code 有時會產生在程式碼圍欄上缺少語言標籤的 markdown 檔案，這可能會影響 GitHub、編輯器和文件工具中的語法高亮和可讀性。

### 程式碼區塊中缺少語言標籤

如果您在產生的 markdown 中注意到這樣的程式碼區塊：

````markdown  theme={null}
```
function example() {
  return "hello";
}
```
````

而不是正確標記的區塊，如：

````markdown  theme={null}
```javascript
function example() {
  return "hello";
}
```
````

**解決方案：**

1. **要求 Claude 新增語言標籤**：簡單地請求"請為此 markdown 檔案中的所有程式碼區塊新增適當的語言標籤。"

2. **使用後處理掛鉤**：設定自動格式化掛鉤來檢測和新增缺少的語言標籤。請參閱 [markdown 格式化掛鉤範例](/zh-TW/docs/claude-code/hooks-guide#markdown-formatting-hook)以了解實作詳情。

3. **手動驗證**：產生 markdown 檔案後，檢查它們是否有正確的程式碼區塊格式，如有需要請求更正。

### 不一致的間距和格式

如果產生的 markdown 有過多的空白行或不一致的間距：

**解決方案：**

1. **請求格式更正**：要求 Claude"修復此 markdown 檔案中的間距和格式問題。"

2. **使用格式化工具**：設定掛鉤在產生的 markdown 檔案上執行 markdown 格式化程式，如 `prettier` 或自訂格式化腳本。

3. **指定格式偏好**：在您的提示或專案[記憶](/zh-TW/docs/claude-code/memory)檔案中包含格式要求。

### Markdown 產生的最佳實務

要最小化格式問題：

* **在請求中明確說明**：要求"具有語言標記程式碼區塊的正確格式化 markdown"
* **使用專案慣例**：在 [CLAUDE.md](/zh-TW/docs/claude-code/memory) 中記錄您偏好的 markdown 樣式
* **設定驗證掛鉤**：使用後處理掛鉤自動驗證和修復常見格式問題

## 獲得更多幫助

如果您遇到此處未涵蓋的問題：

1. 在 Claude Code 中使用 `/bug` 命令直接向 Anthropic 回報問題
2. 檢查 [GitHub 儲存庫](https://github.com/anthropics/claude-code)以了解已知問題
3. 執行 `/doctor` 檢查您的 Claude Code 安裝健康狀況
4. 直接詢問 Claude 其功能和特性 - Claude 內建存取其文件

