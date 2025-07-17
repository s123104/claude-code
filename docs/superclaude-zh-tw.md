# SuperClaude v3.0 中文專業說明書

> **資料來源：**
>
> - [GitHub 專案](https://github.com/NomenAK/SuperClaude)
> - [SuperClaude 官方文檔](https://superclaude.dev/)
> - [Claude Code 高階配置指南](https://docs.anthropic.com/en/docs/claude-code)
> - [MCP 多代理協作協議](https://docs.anthropic.com/en/docs/claude-code/mcp)
> - **文件整理時間：2025-07-16T15:30:00+08:00**
> - **版本：v3.0.0（初始發布版本）**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 安裝與啟動](#2-安裝與啟動)
- [2.1 v2 升級 v3 遷移指引](#21-v2-升級-v3-遷移指引)
- [3. 指令分類與旗標](#3-指令分類與旗標)
- [4. 代表性 Workflow 與範例](#4-代表性-workflow-與範例)
- [5. MCP、Persona、旗標與最佳實踐](#5-mcppersona旗標與最佳實踐)
- [6. 專案結構與自訂](#6-專案結構與自訂)
- [7. 社群貢獻與參與](#7-社群貢獻與參與)
- [8. 常見問題與延伸閱讀](#8-常見問題與延伸閱讀)

---

## 1. 專案簡介

SuperClaude v3.0 是一套強化 Claude Code 的配置框架，結合專業 slash-commands、AI Persona、MCP 多代理協議、旗標控制與現代開發方法論，支援全端、架構、測試、維運、文件、CI/CD、AI 驅動分析等全流程自動化。

### v3.0 主要特色

- 🛠️ **16 個專門指令**：針對常見開發任務優化
- 🎭 **智能 Persona 系統**：自動選擇適合的專家模式
- 🔧 **MCP 伺服器整合**：Context7、Sequential、Magic、Playwright 等
- 📋 **任務管理**：進度追蹤與工作流程管理
- ⚡ **Token 優化**：支援長時間對話與複雜任務

### 目前狀態

✅ **運作良好的功能：**

- 安裝套件（完全重寫）
- 核心框架與 9 個文檔檔案
- 16 個 slash 指令
- MCP 伺服器整合
- 統一 CLI 安裝器

⚠️ **已知問題：**

- 初始發布版本，可能存在錯誤
- 某些功能可能尚未完美
- 文檔持續改進中
- Hooks 系統已移除（v4 將回歸）

---

## 2. 安裝與啟動

SuperClaude v3.0 採用**兩步驟安裝流程**：

### 步驟 1：安裝 Python 套件

**方式 A：從 PyPI 安裝（推薦）**

```bash
pip install SuperClaude
```

**方式 B：從原始碼安裝**

```bash
git clone https://github.com/NomenAK/SuperClaude.git
cd SuperClaude
pip install .
```

**缺少 Python？** 請先安裝 Python 3.7+：

```bash
# Linux (Ubuntu/Debian)
sudo apt update && sudo apt install python3 python3-pip

# macOS
brew install python3

# Windows
# 從 https://python.org/downloads/ 下載安裝
```

### 步驟 2：執行安裝器

安裝套件後，執行 SuperClaude 安裝器來配置 Claude Code：

```bash
# 快速安裝（推薦）
python3 SuperClaude install

# 互動式選擇（選擇組件）
python3 SuperClaude install --interactive

# 最小安裝（僅核心框架）
python3 SuperClaude install --minimal

# 開發者安裝（包含所有功能）
python3 SuperClaude install --profile developer

# 查看所有選項
python3 SuperClaude install --help
```

### 安裝後結構

```
~/.claude/
├── *.md                    # 框架行為文檔
├── settings.json           # 主要配置
└── Commands/               # 指令定義
```

---

## 2.1 v2 升級 v3 遷移指引

### ⚠️ 重要：升級前必讀

如果您正在使用 SuperClaude v2，**必須先完全移除 v2 安裝**，因為 v3 採用完全不同的架構。

### 步驟 1：備份重要資料

```bash
# 備份自訂配置（如果有）
cp -r ~/.claude/custom_configs ~/superclaude_v2_backup/
```

### 步驟 2：卸載 v2

```bash
# 如果有 v2 卸載器
./uninstall.sh  # 如果存在

# 手動清理（必要時）
rm -rf SuperClaude/
rm -rf ~/.claude/shared/
rm -rf ~/.claude/commands/
rm -f ~/.claude/CLAUDE.md
```

### 步驟 3：安裝 v3

按照上述「2. 安裝與啟動」步驟進行全新安裝。

### 重要指令變更對照表

| v2 指令         | v3 指令            | 說明                   |
| --------------- | ------------------ | ---------------------- |
| `/build`        | `/sc:implement`    | **重要變更**：功能實作 |
| `/analyze`      | `/sc:analyze`      | 程式碼分析             |
| `/test`         | `/sc:test`         | 測試相關               |
| `/deploy`       | `/sc:deploy`       | 部署操作               |
| `/review`       | `/sc:analyze`      | 程式碼審查             |
| `/improve`      | `/sc:improve`      | 程式碼改善             |
| `/document`     | `/sc:document`     | 文檔生成               |
| `/troubleshoot` | `/sc:troubleshoot` | 問題排除               |
| `/explain`      | `/sc:explain`      | 程式碼解釋             |
| `/cleanup`      | `/sc:cleanup`      | 清理操作               |

### 配置遷移

v3 的配置檔案位於 `~/.claude/settings.json`，大部分設定會自動初始化，無需手動遷移。

### 常見升級問題

**Q：為什麼 `/build` 指令不能用了？**  
A：v3 中 `/build` 改為 `/sc:implement`。新的 `/sc:build` 僅用於編譯/打包。

**Q：MCP 伺服器無法連接？**  
A：v3 的 MCP 整合完全重寫，請重新執行安裝器。

**Q：自訂指令消失了？**  
A：v3 移除了 hooks 系統，將在 v4 回歸。

---

## 3. 指令分類與旗標

### 核心指令（16 個）

**開發類指令**：

- `/sc:implement` - 功能實作與開發
- `/sc:build` - 編譯與打包
- `/sc:design` - 系統設計與架構

**分析類指令**：

- `/sc:analyze` - 程式碼分析與審查
- `/sc:troubleshoot` - 問題排除與除錯
- `/sc:explain` - 程式碼解釋與說明

**品質類指令**：

- `/sc:improve` - 程式碼改善與優化
- `/sc:test` - 測試相關操作
- `/sc:cleanup` - 清理與重構

**其他指令**：

- `/sc:document` - 文檔生成
- `/sc:git` - Git 操作
- `/sc:estimate` - 工作量估算
- `/sc:task` - 任務管理
- `/sc:index` - 索引建立
- `/sc:load` - 載入與配置
- `/sc:spawn` - 專案生成

### 通用旗標

**基本控制**：

- `--validate` - 安全檢查
- `--security` - 安全性掃描
- `--coverage` - 覆蓋率檢查
- `--strict` - 嚴格模式
- `--plan` - 預覽計劃
- `--dry-run` - 模擬執行
- `--interactive` - 互動模式
- `--force` - 強制執行

**MCP 控制**：

- `--c7` / `--no-c7` - Context7 控制
- `--seq` / `--no-seq` - Sequential 控制
- `--magic` / `--no-magic` - Magic 控制
- `--pup` / `--no-pup` - Playwright 控制
- `--all-mcp` / `--no-mcp` - 全部 MCP 控制

**思考深度**：

- `--think` - 基礎思考
- `--think-hard` - 深度思考
- `--ultrathink` - 超深度思考

**效能優化**：

- `--uc` / `--ultracompressed` - Token 壓縮

---

## 4. 代表性 Workflow 與範例

### 4.1 全端開發完整流程

#### 專案初始化與架構設計

```bash
# 初始化全端專案
/sc:implement --fullstack --framework nextjs --database postgresql --auth supabase

# 設計資料庫架構
/sc:design --api --ddd --persona-architect
/sc:implement --schema --migrations --seeds

# 建立開發環境
/sc:build --docker --dev-containers --hot-reload
```

#### 測試驅動開發循環

```bash
# TDD 開發流程
/sc:test --tdd --watch --coverage-threshold 90%

# 端到端測試
/sc:test --e2e --pup --visual-regression

# 效能測試
/sc:test --performance --lighthouse --load-testing
```

### 4.2 AI 驅動程式碼審查與優化

#### 多層次程式碼審查

```bash
# 基礎程式碼品質審查
/sc:analyze --files src/ --quality --evidence --severity high

# 安全性深度掃描
/sc:analyze --security --owasp --deps --vulnerability-db

# 效能分析與優化
/sc:analyze --performance --bottlenecks --memory-leaks
/sc:improve --performance --iterate --threshold 95% --auto-fix
```

#### 智能重構建議

```bash
# 程式碼重構分析
/sc:improve --analyze --patterns --suggestions

# 自動化重構執行
/sc:improve --execute --backup --test-after

# 依賴優化
/sc:improve --dependencies --tree-shaking --bundle-analysis
```

### 4.3 企業級部署與維運

#### 多環境部署策略

```bash
# 開發環境部署
/sc:build --env development --auto-deploy --notifications

# 預發布環境驗證
/sc:build --env staging --validate --smoke-tests --rollback-ready

# 生產環境藍綠部署
/sc:build --env production --strategy blue-green --health-checks --monitoring
```

#### 監控與維護自動化

```bash
# 系統監控設定
/sc:implement --monitor --alerts --dashboards --log-aggregation

# 自動化維護任務
/sc:cleanup --maintenance --backups --security-updates --performance-tuning

# 災難恢復準備
/sc:implement --backup --full --incremental --disaster-recovery --test-restore
```

### 4.4 進階專案管理整合

#### 敏捷開發工作流程

```bash
# 建立用戶故事
/sc:task --create "As a user, I want to login with social media"

# 任務分解與估算
/sc:estimate --task "Implement OAuth2 integration" --story-id 123 --hours 8
/sc:task --assign --developer john.doe --reviewer jane.smith

# 進度追蹤
/sc:task --status --burndown --velocity --blockers
/sc:task --update task-id "完成 Google OAuth 整合，待測試" --progress 80%
```

#### 自動化 CI/CD 整合

```bash
# CI/CD 流程設定
/sc:implement --cicd --github-actions --docker --kubernetes

# 自動化部署流程
/sc:build --pipeline --trigger pr-merge --target staging --notify slack

# 品質門檻設定
/sc:test --quality-gate --coverage 85% --security-scan --performance-budget
```

### 4.5 文檔與知識管理

#### 智能文檔生成

```bash
# API 文檔自動生成
/sc:document --api --openapi --examples --postman-collection

# 架構文檔
/sc:document --architecture --c4-model --decision-records --diagrams

# 使用者指南
/sc:document --user-guide --screenshots --interactive --multilingual
```

#### 知識庫建立

```bash
# 專案知識庫
/sc:document --wiki --searchable --version-controlled

# 最佳實踐文檔
/sc:document --best-practices --coding-standards --patterns --anti-patterns

# 故障排除指南
/sc:document --troubleshooting --common-issues --solutions --escalation
```

---

## 5. MCP、Persona、旗標與最佳實踐

### MCP 多代理系統

**可用的 MCP 伺服器**：

- **Context7** - 官方函式庫文檔與模式
- **Sequential** - 複雜多步驟思考
- **Magic** - 現代 UI 元件生成
- **Playwright** - 瀏覽器自動化與測試

**MCP 控制旗標**：

```bash
# 啟用特定 MCP
/sc:analyze --c7 --seq

# 停用特定 MCP
/sc:implement --no-magic --no-pup

# 全部啟用/停用
/sc:build --all-mcp
/sc:test --no-mcp
```

### Persona 專家模式

**可用的 Persona**：

- 🏗️ **architect** - 系統設計與架構
- 🎨 **frontend** - UI/UX 與無障礙性
- ⚙️ **backend** - API 與基礎設施
- 🔍 **analyzer** - 除錯與分析
- 🛡️ **security** - 安全性與漏洞
- ✍️ **scribe** - 文檔與寫作
- 🧪 **tester** - 測試與品質保證
- ⚡ **optimizer** - 效能優化
- 🔧 **devops** - 部署與維運
- 🎓 **mentor** - 學習與指導
- 🔄 **refactorer** - 重構與改善

**Persona 自動觸發**：

```bash
# 系統會根據指令內容自動選擇合適的 Persona
/sc:design --api          # 自動觸發 architect
/sc:analyze --security    # 自動觸發 security
/sc:test --coverage       # 自動觸發 tester
```

### 最佳實踐

**指令組合策略**：

```bash
# 完整開發流程
/sc:design --think-hard --persona-architect
/sc:implement --validate --coverage --c7
/sc:test --comprehensive --pup --think
/sc:analyze --security --strict --seq
/sc:improve --performance --auto-fix
```

**Token 優化**：

```bash
# 長時間對話使用壓縮
/sc:analyze --uc --think-hard

# 複雜任務分解
/sc:task --break-down --estimate
```

---

## 6. 專案結構與自訂

### v3.0 專案結構

```
SuperClaude/
├── setup.py               # PyPI 安裝檔案
├── SuperClaude/           # 框架檔案
│   ├── Core/              # 行為文檔 (COMMANDS.md, FLAGS.md, etc.)
│   ├── Commands/          # 16 個 slash 指令定義
│   └── Settings/          # 配置檔案
├── setup/                 # 安裝系統
└── profiles/              # 安裝設定檔 (quick, minimal, developer)
```

### 安裝後結構

```
~/.claude/
├── settings.json          # 主要配置
├── CLAUDE.md             # 核心行為
├── RULES.md              # 規則定義
├── PERSONAS.md           # Persona 系統
├── MCP.md                # MCP 配置
├── COMMANDS.md           # 指令說明
├── FLAGS.md              # 旗標定義
├── MODES.md              # 模式控制
├── ORCHESTRATOR.md       # 編排邏輯
└── PRINCIPLES.md         # 核心原則
```

### 自訂配置

編輯 `~/.claude/settings.json` 來自訂 SuperClaude：

```json
{
  "version": "3.0.0",
  "mcp_servers": {
    "context7": true,
    "sequential": true,
    "magic": false,
    "playwright": true
  },
  "default_personas": ["architect", "security"],
  "token_optimization": true,
  "verbose_logging": false
}
```

---

## 7. 社群貢獻與參與

### 貢獻方式

**歡迎的貢獻類型**：

- 🐛 **錯誤回報** - 告訴我們什麼地方有問題
- 📝 **文檔改善** - 幫助我們解釋得更清楚
- 🧪 **測試** - 不同環境的測試覆蓋
- 💡 **想法** - 新功能或改善建議

### 開發流程

```bash
# Fork 專案
git clone https://github.com/your-username/SuperClaude.git
cd SuperClaude

# 建立功能分支
git checkout -b feature/your-feature-name

# 開發與測試
pip install -e .
python3 SuperClaude install --profile developer

# 提交變更
git commit -s -m "feat: 您的提交訊息"
git push origin feature/your-feature-name
```

### DCO 簽署

所有提交必須包含 Developer Certificate of Origin (DCO) 簽署：

```bash
git commit -s -m "您的提交訊息"
```

---

## 8. 常見問題與延伸閱讀

### 常見問題

**Q：為什麼 hooks 系統被移除了？**  
A：v2 的 hooks 系統過於複雜且容易出錯。我們正在為 v4 重新設計。

**Q：這個版本穩定嗎？**  
A：基本功能運作良好，但作為初始發布版本，預期會有一些粗糙的地方。

**Q：支援其他 AI 助手嗎？**  
A：目前僅支援 Claude Code，但 v4 將有更廣泛的相容性。

### 安裝驗證

```bash
# 驗證安裝
/sc:load --verify

# 系統分析
/sc:analyze --system --think

# 測試所有功能
/sc:test --comprehensive --all-mcp
```

### Token 優化技巧

```bash
# 使用壓縮模式
/sc:analyze --uc --think-hard

# 分解複雜任務
/sc:task --break-down --estimate

# 使用特定 Persona
/sc:implement --persona-backend --focused
```

### 官方資源

- [SuperClaude GitHub](https://github.com/NomenAK/SuperClaude)
- [使用者指南](Docs/superclaude-user-guide.md)
- [指令指南](Docs/commands-guide.md)
- [旗標指南](Docs/flags-guide.md)
- [Persona 指南](Docs/personas-guide.md)
- [安裝指南](Docs/installation-guide.md)

### v4 預覽

**計劃中的功能**：

- **Hooks 系統** - 事件驅動功能（重新設計）
- **MCP 套件** - 更多外部工具整合
- **效能改善** - 更快速、更少錯誤
- **更多 Persona** - 額外的領域專家
- **跨 CLI 支援** - 支援其他 AI 程式設計助手

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/NomenAK/SuperClaude) 與相關文檔。
>
> **版本資訊**：SuperClaude v3.0.0 - 初始發布版本  
> **最後更新**：2025-07-16T20:03:06+08:00
