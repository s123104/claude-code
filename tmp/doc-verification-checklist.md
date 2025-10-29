# Claude Code 文檔驗證核對表

**驗證時間**: 2025-10-29  
**目標文檔**: claude-code-zh-tw.md  
**官方文檔來源**: docs/anthropic-claude-code-zh-tw/

---

## 驗證策略

### 第一階段：核心概念驗證（優先級 1）

- [ ] 版本資訊更新（目前 v6.0.0 → 檢查最新）
- [ ] Subagents 系統描述（對照 sub-agents.md）
- [ ] Plugin 系統描述（對照 plugins.md）
- [ ] Agent Skills 描述（對照 skills.md）
- [ ] CHANGELOG 更新（2.0.27 → 2.0.28）

### 第二階段：CLI 功能驗證（優先級 1）

- [ ] CLI 命令列表（對照 cli-reference.md）
- [ ] 斜線命令列表（對照 slash-commands.md）
- [ ] 參數完整性（對照 cli-reference.md）
- [ ] 新增功能標記（2.0.28 新增項目）

### 第三階段：進階功能驗證（優先級 2）

- [ ] Hooks 系統（對照 hooks.md, hooks-guide.md）
- [ ] MCP 整合（對照 mcp.md）
- [ ] 權限管理（對照 iam.md）
- [ ] 設定檔案（對照 settings.md）
- [ ] 模型配置（對照 model-config.md）

### 第四階段：企業功能驗證（優先級 2）

- [ ] AWS Bedrock（對照 amazon-bedrock.md）
- [ ] Google Vertex AI（對照 google-vertex-ai.md）
- [ ] GitHub Actions（對照 github-actions.md）
- [ ] GitLab CI/CD（對照 gitlab-ci-cd.md）
- [ ] 監控系統（對照 monitoring-usage.md）
- [ ] 安全性（對照 security.md, sandboxing.md）

### 第五階段：工作流程驗證（優先級 3）

- [ ] 常見工作流程（對照 common-workflows.md）
- [ ] 快速入門（對照 quickstart.md）
- [ ] 設定指南（對照 setup.md）
- [ ] 互動模式（對照 interactive-mode.md）
- [ ] 疑難排解（對照 troubleshooting.md）

### 第六階段：IDE 整合驗證（優先級 3）

- [ ] VS Code 整合（對照 vs-code.md）
- [ ] JetBrains 整合（對照 jetbrains.md）
- [ ] 終端配置（對照 terminal-config.md）

### 第七階段：特殊功能驗證（優先級 3）

- [ ] Web 版本（對照 claude-code-on-the-web.md）
- [ ] 無頭模式（對照 headless.md）
- [ ] DevContainer（對照 devcontainer.md）
- [ ] 檢查點（對照 checkpointing.md）
- [ ] 輸出樣式（對照 output-styles.md）
- [ ] 狀態列（對照 statusline.md）

### 第八階段：其他驗證（優先級 4）

- [ ] 成本管理（對照 costs.md）
- [ ] 資料使用（對照 data-usage.md）
- [ ] 分析功能（對照 analytics.md）
- [ ] 法律合規（對照 legal-and-compliance.md）
- [ ] 網路配置（對照 network-config.md）
- [ ] LLM Gateway（對照 llm-gateway.md）

---

## 發現的新內容

### 2.0.28 新增功能

1. ✅ Plan 子代理（全新）
2. ✅ 子代理恢復功能
3. ✅ 子代理動態模型選擇
4. ✅ SDK --max-budget-usd 參數
5. ✅ Git 外掛程式分支/標籤支援

### 需要補充的重要概念

1. ⏳ Agent Skills 系統（完整描述）
2. ⏳ Plugin 市場架構
3. ⏳ 沙箱隔離系統
4. ⏳ 檢查點系統
5. ⏳ Web 版 Claude Code

### 需要更新的區塊

1. ⏳ 版本號（v6.0.0 → 檢查）
2. ⏳ CHANGELOG 區塊（2.0.27 → 2.0.28）
3. ⏳ 新功能說明
4. ⏳ CLI 參數列表
5. ⏳ 斜線命令列表

---

## 驗證進度

- 總項目：43 個
- 已完成：2 個
- 進行中：0 個
- 待處理：41 個
- 完成率：4.7%

**下一步**：開始第一階段核心概念驗證
