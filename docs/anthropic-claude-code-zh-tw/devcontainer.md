---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/devcontainer.md"
fetched_at: "2025-10-28T19:16:28+08:00"
---

# 開發容器

> 了解 Claude Code 開發容器，適用於需要一致、安全環境的團隊。

參考的 [devcontainer 設定](https://github.com/anthropics/claude-code/tree/main/.devcontainer) 和相關的 [Dockerfile](https://github.com/anthropics/claude-code/blob/main/.devcontainer/Dockerfile) 提供了一個預配置的開發容器，您可以直接使用或根據需求進行自定義。此 devcontainer 與 Visual Studio Code [Dev Containers 擴充功能](https://code.visualstudio.com/docs/devcontainers/containers) 和類似工具相容。

容器的增強安全措施（隔離和防火牆規則）允許您執行 `claude --dangerously-skip-permissions` 來繞過權限提示，以進行無人值守操作。

<Warning>
  雖然 devcontainer 提供了實質性的保護，但沒有系統能完全免疫所有攻擊。
  當使用 `--dangerously-skip-permissions` 執行時，devcontainer 無法防止惡意專案竊取 devcontainer 中可存取的任何內容，包括 Claude Code 憑證。
  我們建議僅在開發受信任的儲存庫時使用 devcontainer。
  始終保持良好的安全實踐並監控 Claude 的活動。
</Warning>

## 主要功能

* **生產就緒的 Node.js**：基於 Node.js 20 構建，包含必要的開發依賴項
* **安全設計**：自定義防火牆，僅限制網路存取必要的服務
* **開發者友善工具**：包含 git、ZSH 與生產力增強功能、fzf 等
* **無縫 VS Code 整合**：預配置的擴充功能和優化設定
* **會話持久性**：在容器重啟之間保留命令歷史和配置
* **隨處可用**：與 macOS、Windows 和 Linux 開發環境相容

## 4 步驟快速開始

1. 安裝 VS Code 和 Remote - Containers 擴充功能
2. 複製 [Claude Code 參考實作](https://github.com/anthropics/claude-code/tree/main/.devcontainer) 儲存庫
3. 在 VS Code 中開啟儲存庫
4. 出現提示時，點擊「在容器中重新開啟」（或使用命令面板：Cmd+Shift+P → "Remote-Containers: Reopen in Container"）

## 配置詳解

devcontainer 設定由三個主要組件組成：

* [**devcontainer.json**](https://github.com/anthropics/claude-code/blob/main/.devcontainer/devcontainer.json)：控制容器設定、擴充功能和卷掛載
* [**Dockerfile**](https://github.com/anthropics/claude-code/blob/main/.devcontainer/Dockerfile)：定義容器映像和已安裝的工具
* [**init-firewall.sh**](https://github.com/anthropics/claude-code/blob/main/.devcontainer/init-firewall.sh)：建立網路安全規則

## 安全功能

容器透過其防火牆配置實作多層安全方法：

* **精確存取控制**：僅限制對白名單域名的出站連接（npm 註冊表、GitHub、Claude API 等）
* **允許的出站連接**：防火牆允許出站 DNS 和 SSH 連接
* **預設拒絕政策**：阻止所有其他外部網路存取
* **啟動驗證**：在容器初始化時驗證防火牆規則
* **隔離**：創建與您主系統分離的安全開發環境

## 自定義選項

devcontainer 配置設計為可適應您的需求：

* 根據您的工作流程添加或移除 VS Code 擴充功能
* 為不同硬體環境修改資源分配
* 調整網路存取權限
* 自定義 shell 配置和開發者工具

## 使用案例範例

### 安全客戶工作

使用 devcontainer 隔離不同的客戶專案，確保程式碼和憑證永遠不會在環境之間混合。

### 團隊入職

新團隊成員可以在幾分鐘內獲得完全配置的開發環境，並預安裝所有必要的工具和設定。

### 一致的 CI/CD 環境

在 CI/CD 管道中鏡像您的 devcontainer 配置，以確保開發和生產環境匹配。

## 相關資源

* [VS Code devcontainers 文件](https://code.visualstudio.com/docs/devcontainers/containers)
* [Claude Code 安全最佳實踐](/zh-TW/docs/claude-code/security)
* [企業網路配置](/zh-TW/docs/claude-code/network-config)

