# 🚀 SuperClaude Framework 中文專業說明書

## 概述

**Transform Claude Code into a Structured Development Platform**

SuperClaude 是一套 **meta-programming 配置框架**，透過行為指令注入和元件編排，將 Claude Code 轉變為結構化開發平台。提供系統化工作流程自動化，配備強大工具和智能代理。

> **專案資訊**
>
> - **專案名稱**：SuperClaude Framework
> - **專案版本**：v4.1.9
> - **專案最後更新**：2025-11-14
> - **文件整理時間**：2025-12-24T00:42:00+08:00
>
> **核心定位**
> - **功能**：Meta-programming 配置框架，提供系統化工作流程自動化、Deep Research 深度研究、Agent Skills 和 MCP 伺服器整合
> - **場景**：結構化開發、工作流程自動化、深度研究、多代理協作、專案腳手架
> - **客群**：專業開發者、AI 研究人員、企業團隊、工作流程優化者
>
> **資料來源**
> - [GitHub 專案](https://github.com/SuperClaude-Org/SuperClaude_Framework)
> - [SuperClaude 官方網站](https://superclaude.netlify.app/)
> - [PyPI 套件](https://pypi.org/project/superclaude/)
> - [npm 套件](https://www.npmjs.com/package/@bifrost_inc/superclaude)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 安裝與啟動](#2-安裝與啟動)
- [3. v4.1.9 核心功能：Deep Research 深度研究](#3-v419-核心功能deep-research-深度研究)
- [4. 指令分類與選項](#4-指令分類與選項)
- [5. 代表性 Workflow 與範例](#5-代表性-workflow-與範例)
- [6. MCP、Persona、選項與最佳實踐](#6-mcppersona選項與最佳實踐)
- [7. 專案結構與自訂](#7-專案結構與自訂)
- [8. 社群貢獻與參與](#8-社群貢獻與參與)
- [9. 常見問題與延伸閱讀](#9-常見問題與延伸閱讀)

---

## 1. 專案簡介

SuperClaude v4.1.9 是一套 **meta-programming 配置框架**，透過 30 個斜線指令（slash commands）和元件編排，將 Claude Code 轉變為結構化開發平台。提供系統化工作流程自動化，配備強大工具和智能代理系統。

## 📊 框架統計

| **Commands** | **Agents** | **Modes** | **MCP Servers** |
|:------------:|:----------:|:---------:|:---------------:|
| **30** | **16** | **7** | **8** |
| 斜線指令 | 專業 AI | 行為模式 | 整合服務 |

30 個斜線指令涵蓋從構思到部署的完整開發生命週期。

### v4.1.9 主要特色

<table>
<tr>
<td width="50%">

#### 🚀 **30 個斜線指令系統**
**v4.1.9 穩定架構**：
- 30 個斜線指令涵蓋完整開發生命週期
- `/sc:research` - Deep web research（增強 Tavily MCP）
- `/sc:brainstorm` - 結構化構思
- `/sc:implement` - 程式碼實作
- `/sc:test` - 測試工作流
- `/sc:pm` - 專案管理
- `/sc` - 顯示所有 30 個可用指令

**v5.0 計劃**：TypeScript plugins 系統（開發中，尚未可用）

</td>
<td width="50%">

#### 🤖 **16 個專業代理系統**
**領域專家代理**，具備深度知識：
- PM Agent 透過系統化文檔確保持續學習
- Deep Research agent 進行自主網路研究
- Security engineer 捕捉真實漏洞
- Frontend architect 理解 UI 模式
- 根據情境自動協調
- 按需提供領域專業知識

</td>
</tr>
<tr>
<td width="50%">

#### 🔧 **MCP 伺服器整合**
**8 個強大伺服器**協同工作：
- **Context7** → 最新文檔
- **Sequential** → 複雜分析（30-50% 減少 tokens）
- **Magic** → UI 元件生成
- **Playwright** → 瀏覽器測試
- **Morphllm** → 批量轉換
- **Serena** → 會話持久化（2-3x 更快）
- **Tavily** → 深度研究的網路搜尋
- **Chrome DevTools** → 效能分析

**效能提升**：使用 MCP 可達 2-3x 更快、30-50% 減少 tokens

</td>
<td width="50%">

#### 🎯 **行為模式**
**7 種適應性模式**用於不同情境：
- **Brainstorming** → 提出正確問題
- **Business Panel** → 多專家策略分析
- **Deep Research** → 自主網路研究
- **Orchestration** → 高效工具協調
- **Token-Efficiency** → 30-50% 情境節省
- **Task Management** → 系統化組織
- **Introspection** → 元認知分析

</td>
</tr>
<tr>
<td width="50%">

#### ⚡ **最佳化效能**
**更小的框架，更大的專案：**
- 減少框架足跡
- 為您的程式碼提供更多情境
- 可進行更長的對話
- 啟用複雜操作

</td>
<td width="50%">

#### 📚 **文檔全面改寫**
**為開發者完整重寫：**
- 真實範例和使用案例
- 記錄常見陷阱
- 包含實用工作流程
- 更好的導航結構

</td>
</tr>
</table>

### 🔬 **v4.1.9 核心功能：30 個斜線指令 + Deep Research**

SuperClaude v4.1.9 提供：
- **30 個斜線指令**：涵蓋完整開發生命週期，從構思到部署
- **Deep Research**：自主網路研究能力（透過 `/sc:research` 指令，增強 Tavily MCP）
- **效能提升**：配合 MCP 伺服器，執行速度提升 2-3 倍，token 使用減少 30-50%
- **16 個專業代理**：領域專家自動協調
- **7 種行為模式**：適應不同開發情境

**v5.0 計劃**：TypeScript plugins 系統正在開發中（詳見 issue [#419](https://github.com/SuperClaude-Org/SuperClaude_Framework/issues/419)），將簡化安裝流程

### v4.1.9 穩定功能

✅ **運作良好的功能：**

- 安裝套件（pipx 安裝，穩定運行）
- 核心框架與文檔檔案
- **30 個斜線指令**（涵蓋完整開發生命週期）
- **16 個專業代理**（領域專家自動協調）
- **7 種行為模式**（適應不同開發情境）
- **8 個 MCP 伺服器整合**（Context7、Sequential、Magic、Playwright、Tavily、Serena、Morphllm、Chrome DevTools）
- 統一 CLI 安裝器（`superclaude install`）
- MCP 伺服器管理（`superclaude mcp`）

🔄 **v5.0 計劃（開發中）：**

- TypeScript plugins 系統（簡化安裝流程）
- 專案本地自動偵測
- 熱重載功能

---

## 2. 安裝與啟動

SuperClaude v4.1.9 安裝流程：

### ⚠️ 重要說明

> **注意**：舊文檔中描述的 TypeScript plugin 系統尚未可用（計劃在 v5.0 推出）。  
> 當前穩定版本 v4.1.9 使用斜線指令（slash commands）系統。

### 方式 1：使用 pipx 安裝（推薦）

```bash
# 從 PyPI 安裝
pipx install superclaude

# 安裝所有 30 個斜線指令
superclaude install

# 安裝 MCP 伺服器（選用，可提升效能）
superclaude mcp --list         # 列出可用的 MCP 伺服器
superclaude mcp                # 互動式安裝
superclaude mcp --servers tavily --servers context7  # 安裝特定伺服器

# 驗證安裝
superclaude install --list
superclaude doctor
```

安裝完成後，**重新啟動 Claude Code** 即可使用 30 個指令，包括：
- `/sc:research` - Deep web research（增強 Tavily MCP）
- `/sc:brainstorm` - 結構化構思
- `/sc:implement` - 程式碼實作
- `/sc:test` - 測試工作流
- `/sc:pm` - 專案管理
- `/sc` - 顯示所有 30 個可用指令

### 方式 2：從 Git 直接安裝

```bash
# Clone 儲存庫
git clone https://github.com/SuperClaude-Org/SuperClaude_Framework.git
cd SuperClaude_Framework

# 執行安裝腳本
./install.sh
```

### 效能提升（選用 MCP 伺服器）

安裝 MCP 伺服器可獲得 **2-3x 更快執行速度**和 **30-50% 減少 tokens**：

- **Serena**：程式碼理解（2-3x 更快）
- **Sequential**：Token 效率推理（30-50% 減少 tokens）
- **Tavily**：Deep Research 的網路搜尋
- **Context7**：官方文檔查詢
- **Mindbase**：語義搜尋增強（選用）

**效能對比**：
- **不使用 MCP**：完全功能，標準效能 ✅
- **使用 MCP**：2-3x 更快，30-50% 減少 tokens ⚡

### v5.0 計劃（開發中）

TypeScript plugin 系統正在開發中，未來安裝將簡化為：

```bash
# 此功能尚未可用
/plugin marketplace add SuperClaude-Org/superclaude-plugin-marketplace
/plugin install superclaude
```

**狀態**：開發中，尚未設定發布時間。

---

## 2.1 升級指引

### 從舊版本升級到 v4.1.9

如果您正在使用舊版本的 SuperClaude：

```bash
# 使用 pipx 升級（推薦）
pipx upgrade superclaude

# 或使用 pip 升級
pip install --upgrade superclaude

# 重新安裝指令（確保所有 30 個指令都是最新版本）
superclaude install

# 驗證安裝
superclaude doctor
```

### 清理舊配置（可選）

如果遇到問題，可以清理舊配置後重新安裝：

```bash
# 備份重要資料（如果有自訂配置）
cp -r ~/.claude/ ~/.claude.backup/

# 清理舊配置（謹慎操作）
# rm -rf ~/.claude/commands/
# rm -rf ~/.claude/shared/

# 重新安裝
superclaude install
```

---

## 3. v4.1.9 核心功能：Deep Research 深度研究

### 🔬 **自主網路研究能力**

SuperClaude v4.1.9 提供全面的 Deep Research 能力，實現自主、適應性和智能的網路研究。

<table>
<tr>
<td width="50%">

#### 🎯 **適應性規劃**
**三種智能策略：**
- **Planning-Only**：針對明確查詢的直接執行
- **Intent-Planning**：針對模糊請求的澄清
- **Unified**：協作計劃優化（預設）

</td>
<td width="50%">

#### 🔄 **Multi-Hop 推理**
**最多 5 次迭代搜尋：**
- 實體擴展（論文 → 作者 → 作品）
- 概念深化（主題 → 細節 → 範例）
- 時間進展（當前 → 歷史）
- 因果鏈（效果 → 原因 → 預防）

</td>
</tr>
<tr>
<td width="50%">

#### 📊 **品質評分**
**基於信心度的驗證：**
- 來源可信度評估（0.0-1.0）
- 覆蓋完整性追蹤
- 綜合一致性評估
- 最低門檻：0.6，目標：0.8

</td>
<td width="50%">

#### 🧠 **案例學習**
**跨會話智能：**
- 模式識別和重用
- 策略隨時間優化
- 儲存成功的查詢公式
- 效能改進追蹤

</td>
</tr>
</table>

### 📝 **研究指令使用方式**

#### 基本研究

```bash
# 自動深度的基本研究
/sc:research "latest AI developments 2024"

# 控制研究深度
/sc:research "quantum computing breakthroughs" --depth exhaustive

# 特定策略選擇
/sc:research "market analysis" --strategy planning-only

# 領域過濾研究
/sc:research "React patterns" --domains "reactjs.org,github.com"
```

### 📊 **研究深度層級**

| 深度 | 來源數 | Hops | 時間 | 最適合 |
|:----:|:------:|:----:|:----:|----------|
| **Quick** | 5-10 | 1 | ~2分鐘 | 快速事實、簡單查詢 |
| **Standard** | 10-20 | 3 | ~5分鐘 | 一般研究（預設）|
| **Deep** | 20-40 | 4 | ~8分鐘 | 全面分析 |
| **Exhaustive** | 40+ | 5 | ~10分鐘 | 學術級研究 |

### 🛠️ **整合工具編排**

Deep Research 系統智能協調多個工具：

- **Tavily MCP**：主要網路搜尋和發現
- **Playwright MCP**：複雜內容提取
- **Sequential MCP**：多步驟推理和綜合
- **Serena MCP**：記憶和學習持久化
- **Context7 MCP**：技術文檔查找

### 📈 **使用範例**

#### 快速研究

```bash
# 快速事實查找
/sc:research "Python 3.12 new features" --depth quick

# 結果：
# - 5-10 個來源
# - 1 次搜尋迭代
# - ~2 分鐘完成
# - 適合快速參考
```

#### 標準研究

```bash
# 一般研究（預設）
/sc:research "best practices for React hooks"

# 結果：
# - 10-20 個來源
# - 3 次搜尋迭代
# - ~5 分鐘完成
# - 全面概述
```

#### 深度研究

```bash
# 深入分析
/sc:research "microservices architecture patterns" --depth deep

# 結果：
# - 20-40 個來源
# - 4 次搜尋迭代
# - ~8 分鐘完成
# - 詳細分析和比較
```

#### 徹底研究

```bash
# 學術級研究
/sc:research "quantum machine learning applications" --depth exhaustive

# 結果：
# - 40+ 個來源
# - 5 次搜尋迭代
# - ~10 分鐘完成
# - 研究論文級別的綜合報告
```

### 🎓 **最佳實踐**

#### 選擇正確的深度

```bash
# 快速參考
/sc:research "What is JWT?" --depth quick

# 學習新技術
/sc:research "How to use Docker Compose?" --depth standard

# 架構決策
/sc:research "GraphQL vs REST for mobile apps" --depth deep

# 研究報告
/sc:research "State of AI in healthcare 2024" --depth exhaustive
```

#### 指定可信來源

```bash
# 限制為官方文檔
/sc:research "Next.js 14 features" --domains "nextjs.org"

# 學術研究
/sc:research "climate change models" --domains "scholar.google.com,arxiv.org"

# 技術社群
/sc:research "Rust async patterns" --domains "rust-lang.org,github.com"
```

#### 策略選擇

```bash
# 明確問題，直接執行
/sc:research "How to fix CORS errors?" --strategy planning-only

# 需要澄清的模糊查詢
/sc:research "improve my app performance" --strategy intent-planning

# 複雜研究，協作規劃（預設）
/sc:research "AI agent architecture patterns"  # 使用 unified 策略
```

### 💡 **進階功能**

#### 跨會話學習

Deep Research 系統會記住：
- 您常用的研究模式
- 成功的查詢公式
- 偏好的來源和領域
- 研究策略偏好

這意味著它會隨時間變得更聰明，為您的特定需求提供更好的結果。

#### 品質保證

每個研究結果包含：
- **信心分數**：0.0-1.0（目標 ≥ 0.8）
- **來源評估**：可信度和相關性
- **覆蓋分析**：主題覆蓋的完整性
- **綜合品質**：報告的一致性和準確性

---

## 4. 指令分類與選項

### 重要指令變更對照表

| v2 指令         | v4.1.9 指令        | 說明                   |
| --------------- | ------------------ | ---------------------- |
| `/build`        | `/sc:implement`    | **重要變更**：功能實作 |
| `/analyze`      | `/sc:analyze`      | 程式碼分析             |
| `/test`         | `/sc:test`         | 測試相關               |
| `/review`       | `/sc:analyze`      | 程式碼審查             |
| `/improve`      | `/sc:improve`      | 程式碼改善             |
| `/document`     | `/sc:document`     | 文檔生成               |
| `/troubleshoot` | `/sc:troubleshoot` | 問題排除               |
| `/explain`      | `/sc:explain`      | 程式碼解釋             |
| `/cleanup`      | `/sc:cleanup`      | 清理操作               |

### 配置遷移

v4.1.9 的配置檔案位於 `~/.claude/settings.json`，大部分設定會自動初始化，無需手動遷移。

### 常見升級問題

**Q：為什麼 `/build` 指令不能用了？**  
A：v4.1.9 中 `/build` 改為 `/sc:implement`。新的 `/sc:build` 僅用於編譯/打包。

**Q：MCP 伺服器無法連接？**  
A：v4.1.9 的 MCP 整合已優化，請使用 `superclaude mcp` 重新安裝。

**Q：如何查看所有可用指令？**  
A：在 Claude Code 中輸入 `/sc` 即可查看所有 30 個可用指令。

---

## 4. 指令分類與選項

### 4.1 完整 30 個指令列表

SuperClaude v4.1.9 提供 **30 個斜線指令**，涵蓋完整開發生命週期：

#### 🧠 規劃與設計（4 個）

- `/sc:brainstorm` - 結構化構思
- `/sc:design` - 系統架構設計
- `/sc:estimate` - 時間/工作量估算
- `/sc:spec-panel` - 規格分析

#### 💻 開發（5 個）

- `/sc:implement` - 程式碼實作
- `/sc:build` - 建置工作流程
- `/sc:improve` - 程式碼改善
- `/sc:cleanup` - 重構與清理
- `/sc:explain` - 程式碼解釋

#### 🧪 測試與品質（4 個）

- `/sc:test` - 測試生成
- `/sc:analyze` - 程式碼分析
- `/sc:troubleshoot` - 除錯與問題排除
- `/sc:reflect` - 回顧與反思

#### 📚 文檔（2 個）

- `/sc:document` - 文檔生成
- `/sc:help` - 指令說明

#### 🔧 版本控制（1 個）

- `/sc:git` - Git 操作

#### 📊 專案管理（3 個）

- `/sc:pm` - 專案管理
- `/sc:task` - 任務追蹤
- `/sc:workflow` - 工作流程自動化

#### 🔍 研究與分析（2 個）

- `/sc:research` - Deep web research（深度網路研究）
- `/sc:business-panel` - 商業分析

#### 🎯 工具類（9 個）

- `/sc:agent` - AI 代理
- `/sc:index-repo` - 儲存庫索引
- `/sc:index` - 索引別名
- `/sc:recommend` - 指令推薦
- `/sc:select-tool` - 工具選擇
- `/sc:spawn` - 並行任務
- `/sc:load` - 載入會話
- `/sc:save` - 儲存會話
- `/sc` - 顯示所有指令

### 4.2 通用選項

### 通用選項

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

## 5. 代表性 Workflow 與範例

### 5.1 全端開發完整流程

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

### 5.2 AI 驅動程式碼審查與優化

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

### 5.3 企業級部署與維運

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

### 5.4 進階專案管理整合

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

### 5.5 文檔與知識管理

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

## 6. MCP、Persona、選項與最佳實踐

### MCP 多代理系統

**可用的 MCP 伺服器**：

- **Context7** - 官方函式庫文檔與模式
- **Sequential** - 複雜多步驟思考
- **Magic** - 現代 UI 元件生成
- **Playwright** - 瀏覽器自動化與測試

**MCP 控制選項**：

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

## 7. 專案結構與自訂

### v4.1.9 專案結構

```
SuperClaude/
├── setup.py               # PyPI 安裝檔案
├── SuperClaude/           # 框架檔案
│   ├── Core/              # 行為文檔 (COMMANDS.md, OPTIONS.md, etc.)
│   ├── Commands/          # 30 個 slash 指令定義
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
├── OPTIONS.md            # 選項定義
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

## 8. 社群貢獻與參與

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

## 9. 常見問題與延伸閱讀

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

- [SuperClaude GitHub](https://github.com/SuperClaude-Org/SuperClaude_Framework)
- [SuperClaude 官方網站](https://superclaude.netlify.app/)
- [PyPI 套件](https://pypi.org/project/superclaude/)
- [npm 套件](https://www.npmjs.com/package/@bifrost_inc/superclaude)
- [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)

### v5.0 計劃（開發中）

**計劃中的功能**：

- **TypeScript Plugins 系統** - 專案本地、熱重載、零安裝（詳見 issue [#419](https://github.com/SuperClaude-Org/SuperClaude_Framework/issues/419)）
- **簡化安裝流程** - `/plugin marketplace add` 和 `/plugin install` 方式
- **更多 MCP 整合** - 擴展外部工具整合
- **效能持續改善** - 更快速、更少 tokens

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/SuperClaude-Org/SuperClaude_Framework) 與相關文檔。
>
> **版本資訊**：SuperClaude v4.1.9 - Meta-programming 配置框架（30 個斜線指令、16 個專業代理、7 種行為模式、8 個 MCP 伺服器）  
> **最後更新**：2025-11-25T02:49:00+08:00  
> **主要變更**：更新安裝流程（pipx）、修正架構說明（v4.1.9 使用 slash commands，TypeScript plugins 計劃在 v5.0）、更新統計數字、確認 Deep Research 功能已包含在 v4.1.9、驗證所有 30 個指令和 16 個代理
