---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/jetbrains.md"
fetched_at: "2025-10-29T14:11:04+08:00"
---

# JetBrains IDEs

> 在 JetBrains IDEs 中使用 Claude Code，包括 IntelliJ、PyCharm、WebStorm 等

Claude Code 透過專用外掛程式與 JetBrains IDEs 整合，提供互動式差異檢視、選取內容分享等功能。

## 支援的 IDEs

Claude Code 外掛程式適用於大多數 JetBrains IDEs，包括：

* IntelliJ IDEA
* PyCharm
* Android Studio
* WebStorm
* PhpStorm
* GoLand

## 功能

* **快速啟動**：使用 `Cmd+Esc` (Mac) 或 `Ctrl+Esc` (Windows/Linux) 直接從編輯器開啟 Claude Code，或點擊 UI 中的 Claude Code 按鈕
* **差異檢視**：程式碼變更可以直接在 IDE 差異檢視器中顯示，而不是在終端機中
* **選取內容**：IDE 中目前的選取範圍/分頁會自動與 Claude Code 分享
* **檔案參考快捷鍵**：使用 `Cmd+Option+K` (Mac) 或 `Alt+Ctrl+K` (Linux/Windows) 插入檔案參考（例如 @File#L1-99）
* **診斷分享**：IDE 中的診斷錯誤（lint、語法等）會在您工作時自動與 Claude 分享

## 安裝

### Marketplace 安裝

從 JetBrains marketplace 尋找並安裝 [Claude Code 外掛程式](https://plugins.jetbrains.com/plugin/27310-claude-code-beta-)，然後重新啟動您的 IDE。

### 自動安裝

當您在整合終端機中執行 `claude` 時，外掛程式也可能會自動安裝。必須完全重新啟動 IDE 才能生效。

<Note>
  安裝外掛程式後，您必須完全重新啟動 IDE 才能生效。您可能需要重新啟動多次。
</Note>

## 使用方式

### 從您的 IDE

從 IDE 的整合終端機執行 `claude`，所有整合功能都會啟用。

### 從外部終端機

在任何外部終端機中使用 `/ide` 命令將 Claude Code 連接到您的 JetBrains IDE 並啟用所有功能：

```bash  theme={null}
claude
> /ide
```

如果您希望 Claude 能夠存取與 IDE 相同的檔案，請從與 IDE 專案根目錄相同的目錄啟動 Claude Code。

## 設定

### Claude Code 設定

透過 Claude Code 的設定來配置 IDE 整合：

1. 執行 `claude`
2. 輸入 `/config` 命令
3. 將差異工具設定為 `auto` 以進行自動 IDE 偵測

### 外掛程式設定

透過前往 **Settings → Tools → Claude Code \[Beta]** 來配置 Claude Code 外掛程式：

#### 一般設定

* **Claude 命令**：指定執行 Claude 的自訂命令（例如 `claude`、`/usr/local/bin/claude` 或 `npx @anthropic/claude`）
* **抑制找不到 Claude 命令的通知**：跳過關於找不到 Claude 命令的通知
* **啟用使用 Option+Enter 進行多行提示**（僅限 macOS）：啟用時，Option+Enter 會在 Claude Code 提示中插入新行。如果遇到 Option 鍵意外被捕獲的問題，請停用此功能（需要重新啟動終端機）
* **啟用自動更新**：自動檢查並安裝外掛程式更新（在重新啟動時套用）

<Tip>
  對於 WSL 使用者：將 `wsl -d Ubuntu -- bash -lic "claude"` 設定為您的 Claude 命令（將 `Ubuntu` 替換為您的 WSL 發行版名稱）
</Tip>

#### ESC 鍵設定

如果 ESC 鍵無法在 JetBrains 終端機中中斷 Claude Code 操作：

1. 前往 **Settings → Tools → Terminal**
2. 執行以下任一操作：
   * 取消勾選「使用 Escape 將焦點移至編輯器」，或
   * 點擊「配置終端機按鍵綁定」並刪除「切換焦點至編輯器」快捷鍵
3. 套用變更

這樣可以讓 ESC 鍵正確中斷 Claude Code 操作。

## 特殊設定

### 遠端開發

<Warning>
  使用 JetBrains Remote Development 時，您必須透過 **Settings → Plugin (Host)** 在遠端主機中安裝外掛程式。
</Warning>

外掛程式必須安裝在遠端主機上，而不是在您的本機用戶端電腦上。

### WSL 設定

<Warning>
  WSL 使用者可能需要額外設定才能讓 IDE 偵測正常運作。請參閱我們的 [WSL 疑難排解指南](/zh-TW/docs/claude-code/troubleshooting#jetbrains-ide-not-detected-on-wsl2) 以取得詳細的設定說明。
</Warning>

WSL 設定可能需要：

* 適當的終端機設定
* 網路模式調整
* 防火牆設定更新

## 疑難排解

### 外掛程式無法運作

* 確保您從專案根目錄執行 Claude Code
* 檢查 JetBrains 外掛程式是否在 IDE 設定中啟用
* 完全重新啟動 IDE（您可能需要執行多次）
* 對於 Remote Development，確保外掛程式安裝在遠端主機中

### IDE 未偵測到

* 驗證外掛程式已安裝並啟用
* 完全重新啟動 IDE
* 檢查您是否從整合終端機執行 Claude Code
* 對於 WSL 使用者，請參閱 [WSL 疑難排解指南](/zh-TW/docs/claude-code/troubleshooting#jetbrains-ide-not-detected-on-wsl2)

### 找不到命令

如果點擊 Claude 圖示顯示「找不到命令」：

1. 驗證 Claude Code 已安裝：`npm list -g @anthropic-ai/claude-code`
2. 在外掛程式設定中配置 Claude 命令路徑
3. 對於 WSL 使用者，使用設定部分中提到的 WSL 命令格式

## 安全考量

當 Claude Code 在啟用自動編輯權限的 JetBrains IDE 中執行時，它可能能夠修改可由您的 IDE 自動執行的 IDE 設定檔。這可能會增加在自動編輯模式下執行 Claude Code 的風險，並允許繞過 Claude Code 對 bash 執行的權限提示。

在 JetBrains IDEs 中執行時，請考慮：

* 對編輯使用手動核准模式
* 格外小心確保 Claude 僅用於受信任的提示
* 了解 Claude Code 有權修改哪些檔案

如需其他協助，請參閱我們的[疑難排解指南](/zh-TW/docs/claude-code/troubleshooting)。

