---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/analytics.md"
fetched_at: "2025-10-29T14:09:23+08:00"
---

# 分析

> 查看您組織的 Claude Code 部署的詳細使用洞察和生產力指標。

Claude Code 提供分析儀表板，幫助組織了解開發者使用模式、追蹤生產力指標，並優化其 Claude Code 採用情況。

<Note>
  分析功能目前僅適用於透過 Claude Console 使用 Claude API 的 Claude Code 組織。
</Note>

## 存取分析

導航至分析儀表板：[console.anthropic.com/claude-code](https://console.anthropic.com/claude-code)。

### 必要角色

* **主要擁有者**
* **擁有者**
* **帳務**
* **管理員**
* **開發者**

<Note>
  具有**使用者**、**Claude Code 使用者**或**成員管理員**角色的使用者無法存取分析功能。
</Note>

## 可用指標

### 已接受的程式碼行數

使用者在其會話中接受的由 Claude Code 撰寫的程式碼總行數。

* 排除被拒絕的程式碼建議
* 不追蹤後續的刪除操作

### 建議接受率

使用者接受程式碼編輯工具使用的百分比，包括：

* Edit
* Write
* NotebookEdit

### 活動

**使用者**：指定日期的活躍使用者數量（左側 Y 軸數字）

**會話**：指定日期的活躍會話數量（右側 Y 軸數字）

### 支出

**使用者**：指定日期的活躍使用者數量（左側 Y 軸數字）

**支出**：指定日期的總支出金額（右側 Y 軸數字）

### 團隊洞察

**成員**：所有已驗證 Claude Code 的使用者

* API 金鑰使用者以 **API 金鑰識別符**顯示
* OAuth 使用者以**電子郵件地址**顯示

\*\*本月支出：\*\*每位使用者本月的總支出。

\*\*本月行數：\*\*每位使用者本月接受的程式碼行數總計。

## 有效使用分析

### 監控採用情況

追蹤團隊成員狀態以識別：

* 可以分享最佳實務的活躍使用者
* 整個組織的整體採用趨勢

### 衡量生產力

工具接受率和程式碼指標幫助您：

* 了解開發者對 Claude Code 建議的滿意度
* 追蹤程式碼生成效果
* 識別培訓或流程改進的機會

## 相關資源

* [使用 OpenTelemetry 監控使用情況](/zh-TW/docs/claude-code/monitoring-usage) 用於自訂指標和警報
* [身分識別和存取管理](/zh-TW/docs/claude-code/iam) 用於角色配置

