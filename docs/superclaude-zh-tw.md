# SuperClaude 中文專業說明書

> 資料來源：
>
> - [GitHub 專案](https://github.com/NomenAK/SuperClaude)
> - [Context7 文檔](/nomenak/superclaude)
> - 文件整理時間：2025-07-14

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 安裝與啟動](#2-安裝與啟動)
- [3. 指令分類與旗標](#3-指令分類與旗標)
- [4. 代表性 Workflow 與範例](#4-代表性-workflow-與範例)
- [5. MCP、Persona、旗標與最佳實踐](#5-mcppersona旗標與最佳實踐)
- [6. 專案結構與自訂](#6-專案結構與自訂)
- [7. 社群貢獻與參與](#7-社群貢獻與參與)
- [8. 常見問題與延伸閱讀](#8-常見問題與延伸閱讀)

---

## 1. 專案簡介

SuperClaude 是一套強化 Claude Code 的配置框架，結合專業 slash-commands、AI Persona、MCP 多代理協議、旗標控制與現代開發方法論，支援全端、架構、測試、維運、文件、CI/CD、AI 驅動分析等全流程自動化。

---

## 2. 安裝與啟動

- **Git 下載與安裝**：
  ```bash
  git clone https://github.com/NomenAK/SuperClaude.git && cd SuperClaude && ./install.sh
  # 進階選項
  ./install.sh --dir /opt/claude   # 自訂安裝路徑
  ./install.sh --update            # 更新現有安裝
  ./install.sh --dry-run --verbose # 預覽變更
  ./install.sh --force             # 跳過確認
  ./install.sh --log install.log   # 日誌記錄
  ```
- **MCP 全域安裝腳本**：
  ```bash
  curl -sSL https://superclaude.dev/install-mcp | bash
  ```
- **安裝後結構**：
  ```
  ~/.claude/
    ├── CLAUDE.md, RULES.md, PERSONAS.md, MCP.md
    ├── commands/
    └── commands/shared/
  ```

---

## 3. 指令分類與旗標

- **Development**：/build、/dev-setup、/test
- **Analysis & Improvement**：/review、/analyze、/troubleshoot、/improve、/explain
- **Operations**：/deploy、/migrate、/scan、/estimate、/cleanup、/git
- **Design & Workflow**：/design、/spawn、/document、/load、/task
- **旗標（通用）**：
  - --validate、--security、--coverage、--strict、--introspect、--plan、--dry-run、--watch、--interactive、--force、--uc/--ultracompressed
  - MCP 控制：--c7、--seq、--magic、--pup、--all-mcp、--no-mcp、--no-c7、--no-seq、--no-magic、--no-pup
  - 思考深度：--think、--think-hard、--ultrathink

---

## 4. 代表性 Workflow 與範例

- **全端開發**：
  ```bash
  /build --fullstack --tdd --magic
  /test --coverage --e2e --pup
  /deploy --env staging --validate
  ```
- **架構設計/分析**：
  ```bash
  /design --api --ddd --persona-architect
  /analyze --architecture --persona-architect
  /estimate --detailed --complexity --risk
  ```
- **AI 驅動審查/優化**：
  ```bash
  /review --files src/ --quality --evidence
  /improve --performance --iterate --threshold 95%
  /scan --security --owasp --deps
  ```
- **任務/專案管理**：
  ```bash
  /task:create "Add user authentication"
  /task:status task-id
  /task:update task-id "進度說明"
  /task:complete task-id
  ```
- **文件/說明產生**：
  ```bash
  /explain --depth expert --visual --api
  /document --api --interactive --examples
  ```
- **維運/安全/資料庫**：
  ```bash
  /deploy --env prod --plan
  /migrate --database --backup --validate
  /cleanup --all --dry-run
  ```

---

## 5. MCP、Persona、旗標與最佳實踐

- **MCP 多代理**：Context7、Sequential、Magic、Puppeteer 等可組合啟用/停用
- **Persona 專家模式**：
  - --persona-architect（架構）、--persona-frontend、--persona-backend、--persona-analyzer、--persona-security、--persona-mentor、--persona-refactorer、--persona-performance、--persona-qa
- **旗標控制**：
  - --validate（安全檢查）、--coverage（覆蓋率）、--introspect（自省分析）、--plan（預覽）、--dry-run（模擬）、--uc（壓縮 token）、--think-hard（深度分析）
- **最佳實踐**：
  - 結合 MCP/Persona/旗標，針對不同階段與需求自訂最適化流程
  - 以 /build、/analyze、/test、/deploy、/scan、/improve 等指令串接全流程

---

## 6. 專案結構與自訂

- **核心設定**：CLAUDE.md、RULES.md、PERSONAS.md、MCP.md
- **指令定義**：.claude/commands/（YAML/Markdown）
- **自訂指令格式**：
  ```markdown
  # Command Name

  Description & purpose

  ## Flags

  - --flag1: 說明

  ## Examples

  /command --flag1
  ```
- **專案結構**：
  ```
  SuperClaude/
    ├── CLAUDE.md, RULES.md, PERSONAS.md, MCP.md
    ├── .claude/commands/
    ├── .claude/commands/shared/
    ├── install.sh
    └── README.md
  ```

---

## 7. 社群貢獻與參與

- **貢獻方式**：Fork/PR、slash-command 投稿、CLAUDE.md/Persona/MCP 設計
- **分支管理**：git checkout -b feature/your-feature-name
- **DCO 簽署**：git commit -s -m "Your commit message"
- **建議遵循**：CONTRIBUTING.md、RULES.md、PERSONAS.md

---

## 8. 常見問題與延伸閱讀

- **安裝驗證**：/load、/analyze --code --think
- **token 優化**：--uc/--ultracompressed
- **MCP 啟用/停用**：--all-mcp、--no-mcp、--c7、--no-c7
- **常見指令查詢**：README.md、COMMANDS.md
- **官方資源**：
  - [SuperClaude GitHub](https://github.com/NomenAK/SuperClaude)
  - [Context7 文檔](/nomenak/superclaude)

---

> 本文件僅為社群整理，詳細內容與最新資源請參閱官方 GitHub 與文檔。
