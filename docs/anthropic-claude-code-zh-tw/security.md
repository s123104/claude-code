---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/security.md"
fetched_at: "2025-10-29T14:11:43+08:00"
---

# 安全性

> 了解 Claude Code 的安全防護措施和安全使用的最佳實踐。

## 我們如何處理安全性

### 安全基礎

您的程式碼安全至關重要。Claude Code 以安全為核心進行構建，根據 Anthropic 的全面安全計畫開發。在 [Anthropic 信任中心](https://trust.anthropic.com)了解更多資訊並存取資源（SOC 2 Type 2 報告、ISO 27001 證書等）。

### 基於權限的架構

Claude Code 預設使用嚴格的唯讀權限。當需要額外操作時（編輯檔案、執行測試、執行命令），Claude Code 會請求明確的權限。使用者可以控制是否批准一次性操作或自動允許操作。

我們設計 Claude Code 以實現透明和安全。例如，我們要求在執行 bash 命令之前獲得批准，讓您擁有直接控制權。這種方法使使用者和組織能夠直接配置權限。

如需詳細的權限配置，請參閱[身份和存取管理](/zh-TW/docs/claude-code/iam)。

### 內建保護

為了降低代理系統中的風險：

* **沙箱化 bash 工具**：[沙箱](/zh-TW/docs/claude-code/sandboxing)bash 命令具有檔案系統和網路隔離，減少權限提示同時保持安全性。使用 `/sandbox` 啟用以定義 Claude Code 可以自主工作的邊界
* **寫入存取限制**：Claude Code 只能寫入啟動它的資料夾及其子資料夾—它無法在沒有明確權限的情況下修改父目錄中的檔案。雖然 Claude Code 可以讀取工作目錄外的檔案（對於存取系統庫和依賴項很有用），但寫入操作嚴格限制在專案範圍內，建立了明確的安全邊界
* **提示疲勞緩解**：支援按使用者、按程式碼庫或按組織允許列表常用的安全命令
* **接受編輯模式**：批量接受多個編輯，同時為具有副作用的命令保持權限提示

### 使用者責任

Claude Code 只具有您授予它的權限。您負責在批准前審查提議的程式碼和命令的安全性。

## 防止提示注入

提示注入是一種技術，攻擊者試圖通過插入惡意文本來覆蓋或操縱 AI 助手的指令。Claude Code 包括針對這些攻擊的多項防護措施：

### 核心保護

* **權限系統**：敏感操作需要明確批准
* **上下文感知分析**：通過分析完整請求來檢測潛在有害的指令
* **輸入清理**：通過處理使用者輸入來防止命令注入
* **命令黑名單**：預設阻止從網路獲取任意內容的危險命令，如 `curl` 和 `wget`。明確允許時，請注意[權限模式限制](/zh-TW/docs/claude-code/iam#tool-specific-permission-rules)

### 隱私保護措施

我們已實施多項保護措施來保護您的資料，包括：

* 敏感資訊的有限保留期（請參閱[隱私中心](https://privacy.anthropic.com/en/articles/10023548-how-long-do-you-store-my-data)了解更多）
* 對使用者會話資料的受限存取
* 使用者對資料訓練偏好的控制。消費者使用者可以隨時更改其[隱私設定](https://claude.ai/settings/privacy)。

如需完整詳情，請查閱我們的[商業服務條款](https://www.anthropic.com/legal/commercial-terms)（適用於 Team、Enterprise 和 API 使用者）或[消費者條款](https://www.anthropic.com/legal/consumer-terms)（適用於 Free、Pro 和 Max 使用者）以及[隱私政策](https://www.anthropic.com/legal/privacy)。

### 其他保護措施

* **網路請求批准**：進行網路請求的工具預設需要使用者批准
* **隔離的上下文視窗**：Web 擷取使用單獨的上下文視窗以避免注入潛在的惡意提示
* **信任驗證**：首次程式碼庫執行和新的 MCP 伺服器需要信任驗證
  * 注意：使用 `-p` 旗標以非互動方式執行時，信任驗證被禁用
* **命令注入檢測**：即使之前已允許列表，可疑的 bash 命令也需要手動批准
* **故障關閉匹配**：不匹配的命令預設需要手動批准
* **自然語言描述**：複雜的 bash 命令包括使用者理解的說明
* **安全認證儲存**：API 金鑰和令牌已加密。請參閱[認證管理](/zh-TW/docs/claude-code/iam#credential-management)

<Warning>
  **Windows WebDAV 安全風險**：我們建議在 Windows 上執行 Claude Code 時不要啟用 WebDAV。[WebDAV 已被 Microsoft 棄用](https://learn.microsoft.com/en-us/windows/whats-new/deprecated-features#:~:text=The%20Webclient%20\(WebDAV\)%20service%20is%20deprecated)，原因是安全風險。啟用 WebDAV 可能允許 Claude Code 觸發對遠端主機的網路請求，繞過權限系統。
</Warning>

**使用不受信任內容的最佳實踐**：

1. 在批准前審查建議的命令
2. 避免直接將不受信任的內容管道傳輸到 Claude
3. 驗證對關鍵檔案的提議更改
4. 使用虛擬機器 (VM) 執行指令碼和進行工具呼叫，特別是在與外部網路服務互動時
5. 使用 `/bug` 報告可疑行為

<Warning>
  雖然這些保護措施大大降低了風險，但沒有任何系統完全免疫所有攻擊。在使用任何 AI 工具時，始終保持良好的安全實踐。
</Warning>

## MCP 安全性

Claude Code 允許使用者配置模型上下文協議 (MCP) 伺服器。允許的 MCP 伺服器清單在您的原始程式碼中配置，作為 Claude Code 設定的一部分，工程師將其簽入原始碼控制。

我們鼓勵編寫您自己的 MCP 伺服器或使用來自您信任的提供者的 MCP 伺服器。您能夠為 MCP 伺服器配置 Claude Code 權限。Anthropic 不管理或審計任何 MCP 伺服器。

## IDE 安全性

請參閱[此處](/zh-TW/docs/claude-code/ide-integrations#security)以了解有關在 IDE 中執行 Claude Code 的安全性的更多資訊。

## 雲端執行安全性

使用[網路上的 Claude Code](/zh-TW/docs/claude-code/claude-code-on-the-web) 時，會實施額外的安全控制：

* **隔離的虛擬機器**：每個雲端會話在隔離的、由 Anthropic 管理的 VM 中執行
* **網路存取控制**：網路存取預設受限，可配置為禁用或僅允許特定網域
* **認證保護**：身份驗證通過安全代理進行處理，該代理在沙箱內使用作用域認證，然後將其轉換為您的實際 GitHub 身份驗證令牌
* **分支限制**：Git 推送操作限制在目前工作分支
* **審計日誌**：雲端環境中的所有操作都被記錄以用於合規性和審計目的
* **自動清理**：雲端環境在會話完成後自動終止

如需有關雲端執行的更多詳情，請參閱[網路上的 Claude Code](/zh-TW/docs/claude-code/claude-code-on-the-web)。

## 安全最佳實踐

### 使用敏感程式碼

* 在批准前審查所有建議的更改
* 為敏感存放庫使用專案特定的權限設定
* 考慮使用[開發容器](/zh-TW/docs/claude-code/devcontainer)以獲得額外隔離
* 使用 `/permissions` 定期審計您的權限設定

### 團隊安全性

* 使用[企業管理的原則](/zh-TW/docs/claude-code/iam#enterprise-managed-policy-settings)來強制執行組織標準
* 通過版本控制共享已批准的權限配置
* 培訓團隊成員了解安全最佳實踐
* 通過 [OpenTelemetry 指標](/zh-TW/docs/claude-code/monitoring-usage)監控 Claude Code 使用情況

### 報告安全問題

如果您在 Claude Code 中發現安全漏洞：

1. 不要公開披露
2. 通過我們的 [HackerOne 計畫](https://hackerone.com/anthropic-vdp/reports/new?type=team\&report_type=vulnerability)報告
3. 包括詳細的重現步驟
4. 在公開披露前給我們時間來解決問題

## 相關資源

* [沙箱](/zh-TW/docs/claude-code/sandboxing) - bash 命令的檔案系統和網路隔離
* [身份和存取管理](/zh-TW/docs/claude-code/iam) - 配置權限和存取控制
* [監控使用情況](/zh-TW/docs/claude-code/monitoring-usage) - 追蹤和審計 Claude Code 活動
* [開發容器](/zh-TW/docs/claude-code/devcontainer) - 安全、隔離的環境
* [Anthropic 信任中心](https://trust.anthropic.com) - 安全認證和合規性

