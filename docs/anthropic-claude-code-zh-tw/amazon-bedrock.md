---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/amazon-bedrock"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/amazon-bedrock)

## 先決條件

在使用 Bedrock 配置 Claude Code 之前，請確保您具備：

- 已啟用 Bedrock 存取權限的 AWS 帳戶
- 在 Bedrock 中存取所需的 Claude 模型（例如 Claude Sonnet 4）
- 已安裝並配置的 AWS CLI（可選 - 僅在您沒有其他取得憑證機制時需要）
- 適當的 IAM 權限

## 設定

### 1. 啟用模型存取權限

首先，確保您在 AWS 帳戶中擁有所需 Claude 模型的存取權限：

1. 導航至 Amazon Bedrock 控制台
2. 在左側導航中前往模型存取權限
3. 請求存取所需的 Claude 模型（例如 Claude Sonnet 4）
4. 等待核准

### 2. 配置 AWS 憑證

使用預設的 AWS SDK 憑證鏈，或透過環境變數/SSO 設定。

### 3. 配置 Claude Code

設定以下環境變數以啟用 Bedrock：

### 4. 模型配置

可覆蓋預設主/小型模型識別碼或使用推理設定檔。

## IAM 配置

為 Claude Code 建立具有所需權限的 IAM 政策；可加強為特定推理設定檔 ARN。

## 疑難排解與資源

請參見官方文件與定價、推理設定檔說明。
