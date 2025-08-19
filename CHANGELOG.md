# Claude Code 生態系統變更記錄

基於 [Conventional Commits](https://conventionalcommits.org/) 規範自動生成

## [未發布]

### 新增功能
- 建立自動化版本同步機制 (sync-versions.sh)
- 建立文檔驗證腳本 (validate-docs.sh)
- 建立 CHANGELOG.md 維護流程
- 更新 anthropic-claude-code-zh-tw 官方鏡像文檔
- 新增 6 個專案文檔完整覆蓋

### 改進
- 更新 README.md 統計數據從 8 增至 20+ 個文檔
- 更新 index.html 統計數據從 52 增至 62 個文檔
- 移除所有虛假旗標功能描述，確保內容真實性
- 補充專業工具類適用客群與應用場景說明
- 專案獨立性分級標示（⭐⭐⭐、⭐⭐、⭐）

### 文檔更新
- **sub-agents.md**: 新增 Subagents 專業代理系統實戰範例
- **mcp.md**: 新增企業級 MCP 伺服器整合與 OAuth 認證
- **claude-code-zh-tw.md**: 更新至 v6.0.0，新增 75+ 子代理系統
- 所有文檔版本資訊與實際專案狀態同步驗證

### 重構
- 移除 README.md 和 docs/README.md 中的旗標欄位
- 改為功能/場景/客群三欄結構描述
- 確保所有內容對應現有文檔的真實功能

---

## 版本歷史格式說明

本 CHANGELOG 遵循 [Keep a Changelog](https://keepachangelog.com/zh-TW/1.0.0/) 格式，
並且本專案遵守 [語義化版本控制](https://semver.org/lang/zh-TW/)。

### 版本類型
- **新增功能 (Added)** - 新功能
- **改進 (Changed)** - 既有功能的變更
- **棄用 (Deprecated)** - 即將移除的功能
- **移除 (Removed)** - 已移除的功能
- **修復 (Fixed)** - 任何 bug 的修復
- **安全性 (Security)** - 修復安全性問題

### 提交格式
遵循 Conventional Commits 規範：
```
<類型>[可選的作用域]: <描述>

[可選的正文]

[可選的頁腳]
```

**類型**：
- `feat`: 新功能
- `fix`: 錯誤修復
- `docs`: 文檔變更
- `style`: 程式碼格式（不影響程式碼運行的變動）
- `refactor`: 重構（既不新增功能，也不修復錯誤的程式碼變動）
- `perf`: 效能改善
- `test`: 增加測試
- `chore`: 建構過程或輔助工具的變動
- `ci`: CI 配置檔案和腳本的變動

### 破壞性變更
當有破壞性變更時，在提交訊息的正文或頁腳加上 `BREAKING CHANGE:`

---

## 自動化工具

本專案使用以下自動化工具維護 CHANGELOG：

### 1. 版本同步腳本
```bash
./scripts/sync-versions.sh
```
- 自動檢查所有專案版本
- 更新文檔中的版本資訊
- 生成版本同步報告

### 2. 文檔驗證腳本
```bash
./scripts/validate-docs.sh
```
- 檢查 Markdown 語法
- 驗證內部和外部連結
- 檢查文檔結構一致性
- 生成驗證報告

### 3. CHANGELOG 生成
基於 Conventional Commits 自動生成：
```bash
# 安裝依賴
npm install -g conventional-changelog-cli

# 生成 CHANGELOG
conventional-changelog -p angular -i CHANGELOG.md -s

# 首次生成
conventional-changelog -p angular -i CHANGELOG.md -s --first-release
```

### 4. Git Hooks 整合
建議在 `.git/hooks/commit-msg` 中新增：
```bash
#!/bin/sh
# 驗證提交訊息格式
npx commitlint --edit $1
```

---

*最後更新：2025-08-20T01:50:00+08:00*
