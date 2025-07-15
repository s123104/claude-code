# SuperClaude 中文專業說明書

> **資料來源：**
>
> - [GitHub 專案](https://github.com/NomenAK/SuperClaude)
> - [SuperClaude 官方文檔](https://superclaude.dev/)
> - [Claude Code 高階配置指南](https://docs.anthropic.com/en/docs/claude-code)
> - [MCP 多代理協作協議](https://docs.anthropic.com/en/docs/claude-code/mcp)
> - **文件整理時間：2025-07-15T14:16:31+08:00**

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

### 4.1 全端開發完整流程

#### 專案初始化與架構設計
```bash
# 初始化全端專案
/build --fullstack --framework nextjs --database postgresql --auth supabase

# 設計資料庫架構
/design --api --ddd --persona-architect
/generate --schema --migrations --seeds

# 建立開發環境
/setup --docker --dev-containers --hot-reload
```

#### 測試驅動開發循環
```bash
# TDD 開發流程
/test --tdd --watch --coverage-threshold 90%

# 端到端測試
/test --e2e --pup --visual-regression

# 效能測試
/test --performance --lighthouse --load-testing
```

### 4.2 AI 驅動程式碼審查與優化

#### 多層次程式碼審查
```bash
# 基礎程式碼品質審查
/review --files src/ --quality --evidence --severity high

# 安全性深度掃描
/scan --security --owasp --deps --vulnerability-db

# 效能分析與優化
/analyze --performance --bottlenecks --memory-leaks
/improve --performance --iterate --threshold 95% --auto-fix
```

#### 智能重構建議
```bash
# 程式碼重構分析
/refactor --analyze --patterns --suggestions

# 自動化重構執行
/refactor --execute --backup --test-after

# 依賴優化
/optimize --dependencies --tree-shaking --bundle-analysis
```

### 4.3 企業級部署與維運

#### 多環境部署策略
```bash
# 開發環境部署
/deploy --env development --auto-deploy --notifications

# 預發布環境驗證
/deploy --env staging --validate --smoke-tests --rollback-ready

# 生產環境藍綠部署
/deploy --env production --strategy blue-green --health-checks --monitoring
```

#### 監控與維護自動化
```bash
# 系統監控設定
/monitor --setup --alerts --dashboards --log-aggregation

# 自動化維護任務
/maintain --cleanup --backups --security-updates --performance-tuning

# 災難恢復準備
/backup --full --incremental --disaster-recovery --test-restore
```

### 4.4 進階專案管理整合

#### 敏捷開發工作流程
```bash
# 建立用戶故事
/story:create "As a user, I want to login with social media"

# 任務分解與估算
/task:create "Implement OAuth2 integration" --story-id 123 --estimate 8h
/task:assign --developer john.doe --reviewer jane.smith

# 進度追蹤
/sprint:status --burndown --velocity --blockers
/task:update task-id "完成 Google OAuth 整合，待測試" --progress 80%
```

#### 自動化 CI/CD 整合
```bash
# CI/CD 流程設定
/cicd:setup --github-actions --docker --kubernetes

# 自動化部署流程
/pipeline:create --trigger pr-merge --target staging --notify slack

# 品質門檻設定
/quality:gate --coverage 85% --security-scan --performance-budget
```

### 4.5 文檔與知識管理

#### 智能文檔生成
```bash
# API 文檔自動生成
/document --api --openapi --examples --postman-collection

# 架構文檔
/document --architecture --c4-model --decision-records --diagrams

# 使用者指南
/document --user-guide --screenshots --interactive --multilingual
```

#### 知識庫建立
```bash
# 專案知識庫
/knowledge:create --wiki --searchable --version-controlled

# 最佳實踐文檔
/knowledge:best-practices --coding-standards --patterns --anti-patterns

# 故障排除指南
/knowledge:troubleshooting --common-issues --solutions --escalation
```

### 4.6 高階自動化工作流程

#### 智能程式碼生成
```bash
# 基於需求的程式碼生成
/generate --from-requirements --pattern mvc --tests-included

# 資料庫模型自動生成
/generate --models --from-schema --relationships --validations

# 前端元件庫生成
/generate --components --design-system --storybook --a11y
```

#### 多專案管理
```bash
# Monorepo 管理
/monorepo:setup --workspaces --shared-configs --build-cache

# 依賴管理
/deps:update --security --compatibility --changelog

# 版本發布
/release:create --semantic-versioning --changelog --notifications
```

### 4.7 AI 輔助學習與培訓

#### 程式碼學習助手
```bash
# 程式碼解釋
/explain --code src/complex-algorithm.js --depth expert --visual

# 學習路徑生成
/learn:path --topic "microservices" --level intermediate --hands-on

# 程式碼審查學習
/learn:review --examples --patterns --common-mistakes
```

#### 團隊培訓工具
```bash
# 培訓計畫建立
/training:plan --team frontend --skills react,typescript --duration 4weeks

# 進度追蹤
/training:progress --individual --team --certifications

# 知識測試
/training:quiz --topic security --difficulty intermediate --feedback detailed
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
