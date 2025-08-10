---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/troubleshooting"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/troubleshooting)

## 常見安裝問題

### Windows 安裝問題：WSL 中的錯誤

您可能在 WSL 中遇到以下問題：

**作業系統/平台檢測問題**：如果您在安裝期間收到錯誤，WSL 可能正在使用 Windows 的 `npm`。請嘗試：

- 在安裝前執行 `npm config set os linux`
- 使用 `npm install -g @anthropic-ai/claude-code --force --no-os-check` 安裝（請勿使用 `sudo`）

**找不到 Node 錯誤**：如果您在執行 `claude` 時看到 `exec: node: not found`，您的 WSL 環境可能正在使用 Windows 安裝的 Node.js。您可以使用 `which npm` 和 `which node` 來確認，這些應該指向以 `/usr/` 開頭的 Linux 路徑，而不是 `/mnt/c/`。要修復此問題，請嘗試透過您的 Linux 發行版套件管理器或透過 [`nvm`](https://github.com/nvm-sh/nvm) 安裝 Node。

### Linux 和 Mac 安裝問題：權限或找不到命令錯誤

使用 npm 安裝 Claude Code 時，`PATH` 問題可能會阻止存取 `claude`。
如果您的 npm 全域前綴不可由使用者寫入（例如 `/usr` 或 `/usr/local`），您也可能遇到權限錯誤。

#### 建議解決方案：原生 Claude Code 安裝

Claude Code 有一個不依賴 npm 或 Node.js 的原生安裝。

使用以下命令執行原生安裝程式。

**macOS、Linux、WSL：**

**Windows PowerShell：**

此命令會為您的作業系統和架構安裝適當的 Claude Code 建置，並在 `~/.local/bin/claude` 新增安裝的符號連結。

#### 替代解決方案：遷移到本地安裝

或者，如果 Claude Code 可以執行，您可以遷移到本地安裝：

這會將 Claude Code 移動到 `~/.claude/local/` 並在您的 shell 配置中設定別名。未來更新不需要 `sudo`。

遷移後，重新啟動您的 shell，然後驗證您的安裝：

在 macOS/Linux/WSL 上：

在 Windows 上：

驗證安裝：

## 權限和身份驗證

### 重複的權限提示

如果您發現自己重複批准相同的命令，您可以使用 `/permissions` 命令允許特定工具在不需要批准的情況下執行。請參閱[權限文件](about:/zh-TW/docs/claude-code/iam#configuring-permissions)。

### 身份驗證問題

如果您遇到身份驗證問題：

1. 執行 `/logout` 完全登出
2. 關閉 Claude Code
3. 使用 `claude` 重新啟動並再次完成身份驗證過程

如果問題持續存在，請嘗試：

這會移除您儲存的身份驗證資訊並強制進行乾淨登入。

## 效能和穩定性

### 高 CPU 或記憶體使用量

Claude Code 設計用於與大多數開發環境配合使用，但在處理大型程式碼庫時可能會消耗大量資源。如果您遇到效能問題：

1. 定期使用 `/compact` 來減少上下文大小
2. 在主要任務之間關閉並重新啟動 Claude Code
3. 考慮將大型建置目錄新增到您的 `.gitignore` 檔案中

### 命令掛起或凍結

如果 Claude Code 似乎沒有回應：

1. 按 Ctrl+C 嘗試取消目前操作
2. 如果沒有回應，您可能需要關閉終端機並重新啟動

### ESC 鍵在 JetBrains（IntelliJ、PyCharm 等）終端機中無法運作

如果您在 JetBrains 終端機中使用 Claude Code，而 ESC 鍵無法如預期中斷代理程式，這可能是由於與 JetBrains 預設快捷鍵的按鍵綁定衝突。

要修復此問題：

1. 前往設定 → 工具 → 終端機
2. 點選「覆蓋 IDE 快捷鍵」旁邊的「配置終端機按鍵綁定」超連結
3. 在終端機按鍵綁定中，向下捲動到「切換焦點到編輯器」並刪除該快捷鍵

這將允許 ESC 鍵正確地用於取消 Claude Code 操作，而不是被 PyCharm 的「切換焦點到編輯器」動作捕獲。

## 獲得更多幫助

如果您遇到此處未涵蓋的問題：

1. 在 Claude Code 中使用 `/bug` 命令直接向 Anthropic 回報問題
2. 查看 [GitHub 儲存庫](https://github.com/anthropics/claude-code) 了解已知問題
3. 執行 `/doctor` 檢查您的 Claude Code 安裝健康狀況
4. 直接詢問 Claude 其功能和特性 - Claude 內建存取其文件的功能
