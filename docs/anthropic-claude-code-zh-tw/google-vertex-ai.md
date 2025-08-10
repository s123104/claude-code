---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/google-vertex-ai"
fetched_at: "2025-08-09T22:31:55+08:00"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/google-vertex-ai)

## 先決條件

- 啟用計費的 GCP 帳戶與 Vertex AI API
- 目標模型存取
- gcloud 已安裝

## 設定與模型配置

啟用 API、請求模型存取，配置 ADC 或服務帳戶，並設定 `CLAUDE_CODE_USE_VERTEX` 等環境變數。

可覆蓋預設主/小型模型（如 `claude-sonnet-4@20250514`）。

## IAM 與疑難排解

賦予 `roles/aiplatform.user` 或自訂最小權限；針對配額/404/429 依指南修正。
