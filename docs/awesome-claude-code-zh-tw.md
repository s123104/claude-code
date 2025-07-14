# Awesome Claude Code 中文精選資源總覽

> 資料來源：
>
> - [GitHub 專案](https://github.com/hesreallyhim/awesome-claude-code)
> - [Anthropic 官方文檔](https://docs.anthropic.com/en/docs/claude-code/overview)
> - 文件整理時間：2025-07-14

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 目錄分類與重點資源](#2-目錄分類與重點資源)
- [3. Workflow & Knowledge Guides](#3-workflow--knowledge-guides)
- [4. Tooling & IDE 整合](#4-tooling--ide-整合)
- [5. Hooks 實例](#5-hooks-實例)
- [6. Slash-Commands 精選](#6-slash-commands-精選)
- [7. CLAUDE.md 實戰範例](#7-claudemd-實戰範例)
- [8. MCP/整合與自動化](#8-mcp整合與自動化)
- [9. 社群貢獻與參與](#9-社群貢獻與參與)
- [10. 官方文檔與延伸閱讀](#10-官方文檔與延伸閱讀)

---

## 1. 專案簡介

Awesome Claude Code 是一份由社群協作維護的精選清單，收錄 Claude Code 相關的指令、CLAUDE.md、workflow、hooks、MCP 整合、IDE 工具、最佳實踐與各類自動化資源，協助開發者提升生產力、優化 AI 代理開發流程。

---

## 2. 目錄分類與重點資源

- **Workflows & Knowledge Guides**：專案啟動、管理、知識導入、Context Priming、SDLC 全流程
- **Tooling**：用量監控、Code Flow、IDE/編輯器整合、Webhooks、Swarm/多代理協作
- **Hooks**：各類 hooks 實作、TypeScript/PHP/Go 等語言範例
- **Slash-Commands**：Git/CI/PR/測試/優化/自動化/專案管理/文件/安全/AI 輔助
- **CLAUDE.md**：語言/領域/專案腳手架/記憶體協議（MCP）等範本
- **MCP/整合**：MCP server/client、API、外部資源引用、工具鏈串接
- **官方文檔**：安裝、API、MCP、工具定義、最佳實踐

---

## 3. Workflow & Knowledge Guides

- **Blogging Platform**：一鍵管理部落格文章、分類、媒體
- **ClaudeLog**：進階 CLAUDE.md 實戰、plan mode、配置技巧
- **Context Priming**：專案情境導入、目標/結構/協作參數
- **n8n_agent**：AI 驅動的 QA/設計/專案管理/優化全流程
- **Project Bootstrapping/Task Management**：專案啟動、slash-commands 自訂
- **Project Workflow System**：任務、審查、部署一條龍
- **Shipping Real Code**：真實產品交付流程
- **Simone**：文件/規範/流程一體化管理
- **Slash-commands megalist**：超過 80 條社群精選指令

---

## 4. Tooling & IDE 整合

- **CC Usage**：用量監控 CLI，token/cost 儀表板
- **Claude Code Flow**：遞迴式自動化 agent 編輯/測試/優化
- **Claude Hub**：Webhook 連 GitHub，AI 協作 PR/issue
- **Claude Squad/Swarm**：多代理協作、分工
- **IDE 插件**：Emacs（claude-code.el）、Neovim（claude-code.nvim）、桌面應用（crystal）

---

## 5. Hooks 實例

- **claude-code-hooks-sdk**（PHP）、**claude-hooks**（TypeScript）
- **Linting/Testing/Notification**（Go）
- **官方 hooks API**：可於 agent lifecycle 任意階段觸發自訂腳本
- **最佳實踐**：結構化 JSON 輸出、型別安全、錯誤處理

---

## 6. Slash-Commands 精選

- **Git/PR/Issue**：/commit、/create-pr、/fix-issue、/pr-review、/update-branch-name
- **測試/分析/優化**：/check、/clean、/code_analysis、/optimize、/tdd
- **Context/Priming**：/context-prime、/prime、/rsi
- **文件/Changelog**：/add-to-changelog、/create-docs、/update-docs
- **CI/部署**：/release、/run-ci
- **專案管理**：/create-command、/todo、/create-jtbd、/create-prd
- **Misc**：/act（React a11y）、/five（五問法）、/mermaid（ER 圖）、/use-stepper

---

## 7. CLAUDE.md 實戰範例

- **語言/框架**：AI IntelliJ Plugin、AWS MCP Server、DroidconKotlin、EDSL、Giselle、HASH、Inkline、JSBeeb、Lamoom Python、LangGraphJS、Metabase、SG Cars Trends Backend、SPy、TPL
- **領域/專案**：AVS Vibe、Comm、Course Builder、Cursor Tools、Guitar、Note Companion、Pareto Mac、SteadyStart
- **MCP/腳手架**：Basic Memory、claude-code-mcp-enhanced、Perplexity MCP
- **官方建議**：/init 指令自動產生 CLAUDE.md，支援 @import、@path 引用

---

## 8. MCP 整合與自動化

- **MCP server/client**：`claude mcp add`、`claude mcp serve`、`claude mcp list`、`claude mcp get`、`claude mcp remove`
- **Slash-commands 與 MCP**：`/mcp__github__list_prs`、`/mcp__jira__create_issue "Bug" high`
- **API 工具鏈**：多工具串接、tool_use/stop_reason 處理、JSON 結構化回傳
- **外部資源引用**：@github:issue://123、@docs:file://api/authentication
- **權限規則**：Bash/Edit/Read/WebFetch/mcp\_\_\* 精細控管
- **自動化範例**：Python/CLI/Docker/HTTP/SSE 多協議

---

## 9. 社群貢獻與參與

- **貢獻方式**：Pull Request、/project:add-new-resource 指令、CLAUDE.md/HOOKS/指令投稿
- **內容收錄原則**：最佳實踐、創新/實驗性 workflow、工具/外掛、非傳統 AI 助理應用
- **License 注意**：未附 LICENSE 預設為全著作權，建議選擇開源授權
- **行為準則**：請遵守 code-of-conduct.md

---

## 10. 官方文檔與延伸閱讀

- [Anthropic Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code/overview)
- [MCP/工具整合 API](https://docs.anthropic.com/en/docs/claude-code/docs/claude-code/mcp)
- [工具定義/最佳實踐](https://docs.anthropic.com/en/docs/claude-code/docs/agents-and-tools/tool-use/overview)
- [CLAUDE.md 記憶體協議](https://docs.anthropic.com/en/docs/claude-code/docs/claude-code/memory)
- [社群精選資源](https://github.com/hesreallyhim/awesome-claude-code)

---

> 本文件僅為社群整理，詳細內容與最新資源請參閱官方 GitHub 與文檔。
