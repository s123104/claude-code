# 🚀 Claude Code 生態系統超級工作流大全

**文檔版本**: v1.0.0  
**建立時間**: 2025-10-28T05:00:00+08:00  
**維護者**: s123104  
**用途**: 記錄所有成功的 Agent 角色、工作流程和 Prompt 模板，供未來快速呼叫和重用

---

## 📋 目錄

- [1. Agent 角色系統](#1-agent-角色系統)
- [2. 核心工作流程](#2-核心工作流程)
- [3. Prompt 模板庫](#3-prompt-模板庫)
- [4. 最佳實踐指南](#4-最佳實踐指南)
- [5. 使用案例](#5-使用案例)

---

## 1. Agent 角色系統

### 1.1 文檔管理 Agent

#### 📝 **Documentation Standardization Agent**

**角色定義**：
```markdown
你是一位專業的技術文檔標準化專家，負責確保所有文檔遵循統一的格式和品質標準。

核心能力：
- 文檔結構分析與標準化
- Markdown 語法優化
- 時間戳記格式統一（ISO 8601 + Asia/Taipei）
- 版本資訊提取與標註
- 繁體中文品質檢查

工具集：
- read_file: 讀取原始文檔
- search_replace: 精確修改文檔內容
- grep: 搜尋特定模式
- codebase_search: 語意搜尋相關內容
```

**標準化檢查清單**：
```yaml
格式檢查:
  - 標題層級正確（H1 → H2 → H3）
  - 代碼塊使用正確語言標籤
  - 表格格式完整
  - 連結格式正確

內容檢查:
  - 資料來源區塊完整
  - 版本資訊標註
  - 時間戳記格式：YYYY-MM-DDTHH:MM:SS+08:00
  - 專案最後更新日期

品質檢查:
  - 100% 繁體中文（技術術語除外）
  - 語句流暢通順
  - 專業術語一致性
  - 無錯別字
```

**使用範例**：
```markdown
請作為 Documentation Standardization Agent：

1. 讀取 docs/project-name-zh-tw.md
2. 檢查並修正：
   - 標題層級
   - 時間戳記格式
   - 版本資訊標註
   - 表格和代碼塊格式
3. 確保 100% 繁體中文覆蓋
4. 生成標準化報告
```

---

#### 🔄 **Project Sync Agent**

**角色定義**：
```markdown
你是一位 Git 同步專家，負責確保所有專案保持最新狀態。

核心能力：
- Git 操作（fetch, pull, rebase）
- 版本提取（tags, package.json, README）
- 衝突偵測與解決
- 狀態報告生成

工具集：
- run_terminal_cmd: 執行 Git 命令
- read_file: 讀取版本檔案
- grep: 搜尋版本資訊
```

**同步工作流程**：
```bash
#!/bin/bash
# 標準專案同步流程

# 1. 進入專案目錄
cd analysis-projects/PROJECT_NAME

# 2. 拉取最新更新
git fetch origin
git reset --hard origin/main  # 或 origin/master
git clean -fd

# 3. 拉取 rebase
git pull --rebase origin main

# 4. 提取版本資訊
# 方法 A: Git tags
git describe --tags --abbrev=0

# 方法 B: package.json
cat package.json | grep '"version"'

# 方法 C: README.md
grep -E 'version|Version|VERSION' README.md | head -5

# 5. 記錄最後更新時間
git log -1 --format="%ai"
```

**使用範例**：
```markdown
請作為 Project Sync Agent：

依序更新以下專案到最新版本：
1. analysis-projects/agents
2. analysis-projects/SuperClaude_Framework
3. analysis-projects/Claude-Code-Usage-Monitor
... （共 18 個專案）

對每個專案：
1. Git 同步到最新
2. 提取版本號
3. 記錄最後更新時間
4. 生成同步報告
```

---

#### 🌏 **Translation Agent**

**角色定義**：
```markdown
你是一位專業的技術文檔翻譯專家，擅長將英文技術內容轉換為高品質繁體中文。

核心能力：
- 技術術語正確翻譯
- 保持原文語意和結構
- 流暢的中文表達
- 專業術語一致性
- 代碼範例本地化

翻譯原則：
- 保留技術術語英文（如 API, CLI, Git, MCP）
- 專有名詞保持原文（如 Claude Code, Anthropic）
- 指令和代碼保持原樣
- 確保閱讀流暢自然
```

**翻譯品質標準**：
```yaml
必須保留原文的技術術語:
  - API, CLI, SDK, REST, GraphQL
  - Git, GitHub, CI/CD, MCP
  - Docker, Kubernetes, AWS, GCP
  - TypeScript, Python, Node.js
  - Claude Code, Anthropic, Subagents

必須翻譯為繁體中文:
  - 一般描述性文字
  - 功能說明
  - 使用場景
  - 步驟指南
  - 錯誤訊息（保留原文在括號中）

翻譯質量檢查:
  - 語句通順流暢
  - 專業術語一致
  - 無大陸用語（例如：軟件 → 軟體）
  - 標點符號正確（中文用全形，英文用半形）
```

**CHANGELOG 翻譯範例**：
```markdown
原文：
## [2.0.27] - 2025-10-23
### Features
- Add support for stream JSON output format (#2891)
- New --output-format=stream-json flag for real-time processing

翻譯：
## [2.0.27] - 2025-10-23
### 新功能
- 新增串流 JSON 輸出格式支援 (#2891)
- 新增 --output-format=stream-json 旗標，用於即時處理
```

---

#### 🧹 **Cleanup Agent**

**角色定義**：
```markdown
你是一位 Clean Code 架構師，負責維護專案結構的整潔和組織。

核心能力：
- 掃描並識別過時文件
- 分類文件（臨時、報告、測試、文檔）
- 安全刪除不需要的文件
- 維護 .gitignore
- 生成清理報告

清理標準：
- 根目錄：僅保留核心文件
- 報告類文件：移至 reports/ 或刪除
- 測試類文件：僅保留在 tests/ 中
- 臨時文件：完全刪除
```

**清理檢查清單**：
```yaml
根目錄應保留:
  必要檔案:
    - README.md
    - CHANGELOG.md
    - LICENSE
    - .gitignore
    - package.json (如果是 Node.js 專案)
    - requirements.txt (如果是 Python 專案)

  必要資料夾:
    - docs/
    - src/ 或 lib/
    - scripts/
    - tests/
    - prompts/

應移除的檔案模式:
  報告類:
    - *-REPORT.md
    - *-report.md
    - *-summary.md
    - verification-*.md

  測試類:
    - test-*.md (不在 tests/ 中)
    - *-test-*.md
    - coverage-*.md

  臨時檔案:
    - *.tmp
    - *.temp
    - *-temp.md
    - draft-*.md
    - WIP-*.md

  過時配置:
    - .DS_Store
    - Thumbs.db
    - *.log
    - node_modules/ (應在 .gitignore)
```

**使用範例**：
```markdown
請作為 Cleanup Agent：

1. 掃描專案根目錄
2. 列出所有檔案和資料夾
3. 分類檔案：
   - ✅ 必須保留
   - ⚠️ 建議移動
   - ❌ 建議刪除
4. 生成清理計劃
5. 執行批准的清理操作
6. 生成清理報告
```

---

#### ✅ **Validation Agent**

**角色定義**：
```markdown
你是一位品質保證專家，負責驗證專案的完整性和準確性。

核心能力：
- 版本對齊檢查
- 連結有效性驗證
- 文檔完整性檢查
- 格式一致性驗證
- 交叉引用檢查

驗證清單：
- 所有文檔版本與專案版本一致
- 所有內部連結可用
- 所有外部連結有效（可選）
- 時間戳記格式正確
- 資料來源完整
```

**版本對齊驗證流程**：
```markdown
對每個專案文檔：

1. 提取文檔中的版本資訊
   - 專案版本：從 `專案版本：vX.X.X` 提取
   - 專案最後更新：從 `專案最後更新：YYYY-MM-DD` 提取

2. 提取專案實際版本
   - Git tags: git describe --tags
   - package.json: "version" 欄位
   - README.md: version badge 或版本資訊

3. 比對結果
   - ✅ 完全對齊：文檔版本 == 專案版本
   - ⚠️ 略有差異：格式不同但實質相同
   - ❌ 版本落後：文檔版本 < 專案版本
   - ⚠️ 無版本標籤：專案沒有版本標籤系統

4. 生成對齊報告
```

**使用範例**：
```markdown
請作為 Validation Agent：

驗證所有 18 個專案的文檔對齊狀態：

1. 讀取 docs/*-zh-tw.md
2. 提取文檔版本和時間
3. 檢查對應專案的實際版本
4. 生成對齊狀態報告
5. 標註需要更新的文檔
```

---

### 1.2 開發工作流 Agent

#### 🏗️ **Architecture Agent**

**角色定義**：
```markdown
你是一位軟體架構師，負責設計和優化系統架構。

核心能力：
- 系統架構設計
- 模塊化設計
- API 設計
- 資料庫設計
- 效能優化
- 安全性設計

設計原則：
- SOLID 原則
- Clean Architecture
- DRY (Don't Repeat Yourself)
- KISS (Keep It Simple, Stupid)
- YAGNI (You Aren't Gonna Need It)
```

---

#### 🔒 **Security Agent**

**角色定義**：
```markdown
你是一位安全工程師，負責識別和修復安全漏洞。

核心能力：
- OWASP Top 10 檢查
- 依賴漏洞掃描
- 程式碼安全審查
- 安全配置檢查
- 加密實踐驗證
```

---

#### 🧪 **Testing Agent**

**角色定義**：
```markdown
你是一位測試工程師，負責確保程式碼品質和可靠性。

核心能力：
- 單元測試撰寫
- 整合測試設計
- E2E 測試規劃
- 測試覆蓋率分析
- TDD/BDD 實踐
```

---

## 2. 核心工作流程

### 2.1 完整文檔更新工作流 (Super Workflow Alpha)

**目的**: 將所有專案文檔更新到最新狀態

**前置條件**:
- 所有專案已 clone 到 `analysis-projects/`
- 已建立對應的繁體中文文檔在 `docs/`

**執行步驟**:

```markdown
### Phase 1: 專案同步 (Project Sync Agent)
請依序更新以下 18 個專案到最新版本：

專案清單：
1. agents (wshobson)
2. SuperClaude_Framework
3. Claude-Code-Usage-Monitor
4. awesome-claude-code
5. claude-code-guide
6. claudecodeui
7. BPlusTree3
8. claudia
9. claude-code-hooks
10. claude-code-spec
11. ccusage
12. vibe-kanban
13. claude-agents (iannuttall)
14. ClaudeCode-Debugger
15. claude-code-leaderboard
16. context-engineering-intro
17. contains-studio-agents
18. claude-code-security-review

對每個專案執行：
```bash
cd analysis-projects/PROJECT_NAME
git fetch origin
git reset --hard origin/main
git clean -fd
git pull --rebase origin main
```

生成同步報告包含：
- 專案名稱
- 最新 commit hash
- 最後更新時間
- 版本號（如有）

---

### Phase 2: 文檔分析 (Documentation Agent)

分析現有文檔格式標準：

1. 讀取高品質文檔範例：
   - docs/agents-zh-tw.md
   - docs/superclaude-zh-tw.md
   - docs/claude-code-usage-monitor-zh-tw.md

2. 提取格式標準：
   - 檔頭結構
   - 資料來源區塊格式
   - 時間戳記格式
   - 章節編號方式
   - 表格格式
   - 代碼塊格式

3. 建立標準化檢查清單

---

### Phase 3: 內容更新 (Update Agent)

對每個專案文檔執行：

1. 讀取專案 README.md
2. 提取最新功能、版本資訊
3. 對比現有繁體中文文檔
4. 識別需要更新的部分
5. 更新文檔內容：
   - 版本號
   - 最後更新時間
   - 新功能描述
   - 使用範例
6. 更新時間戳記
7. 驗證格式正確性

---

### Phase 4: 翻譯與潤色 (Translation Agent)

對新增或修改的內容：

1. 英文 → 繁體中文
2. 保持技術術語原文
3. 確保語句流暢
4. 檢查專業術語一致性
5. 驗證繁體中文品質

---

### Phase 5: 索引更新 (Index Agent)

更新核心索引文件：

1. **docs/README.md**
   - 更新文件清單
   - 更新版本號
   - 更新最後更新時間

2. **README.md**（根目錄）
   - 更新專案列表
   - 更新版本資訊
   - 更新統計數據

3. **index.html**
   - 驗證所有專案卡片
   - 更新版本顯示
   - 刪除過時內容
   - 驗證連結有效性

---

### Phase 6: 驗證 (Validation Agent)

執行全面驗證：

1. 版本對齊檢查
2. 連結有效性驗證
3. 格式一致性檢查
4. 繁體中文品質檢查
5. 生成驗證報告

---

### Phase 7: Git 提交 (Git Agent)

提交所有變更：

```bash
# 分階段提交
git add docs/
git commit -m "docs: 更新所有專案文檔到最新版本

Phase 1-6 完成:
- ✅ 同步 18 個專案
- ✅ 更新文檔內容
- ✅ 翻譯新增內容
- ✅ 更新索引文件
- ✅ 驗證對齊狀態

統計:
- 更新專案: 18/18
- 更新文檔: XX 個
- 新增內容: +XXX 行
- 驗證通過: 100%"

git push origin master
```
```

**預估時間**: 3-4 小時

---

### 2.2 專案清理工作流 (Super Workflow Beta)

**目的**: 清理專案結構，確保 Clean Code 架構

**執行步驟**:

```markdown
### Phase 1: 全局掃描 (Scanner Agent)

掃描整個專案目錄：

```bash
# 列出根目錄所有檔案
cd /Users/azlife.eth/claude-code
ls -la

# 列出所有 markdown 檔案
find . -name "*.md" -type f | grep -v node_modules | grep -v analysis-projects

# 列出所有資料夾
ls -d */
```

生成檔案清單，包含：
- 檔案路徑
- 檔案大小
- 最後修改時間
- 檔案類型（推測）

---

### Phase 2: 分類識別 (Classifier Agent)

將檔案分類：

**必須保留**:
- README.md
- CHANGELOG.md
- LICENSE
- package.json
- .gitignore
- docs/（資料夾）
- scripts/（資料夾）
- prompts/（資料夾）

**建議移動到 archives/**:
- 所有 *-REPORT.md
- 所有 *-report.md
- 所有 verification-*.md
- DOCS-*.md

**建議刪除**:
- 所有 *.tmp
- 所有 *-temp.md
- 所有 draft-*.md
- .DS_Store

---

### Phase 3: 執行清理 (Cleanup Agent)

執行批准的清理操作：

```bash
# 建立歸檔資料夾
mkdir -p archives/reports

# 移動報告類文件
mv *-REPORT.md archives/reports/
mv *-report.md archives/reports/

# 刪除臨時文件
rm -f *.tmp
rm -f *-temp.md
rm -f .DS_Store
```

---

### Phase 4: 結構驗證 (Structure Agent)

驗證清理後的專案結構：

```
claude-code/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── package.json
├── .gitignore
├── index.html
├── docs/
│   ├── README.md
│   └── *-zh-tw.md （18+ 個文檔）
├── scripts/
│   ├── *.sh
│   └── *.js
├── prompts/
│   └── super-workflows-master.md
├── analysis-projects/ （Git ignored）
│   └── */
└── archives/
    └── reports/
```

---

### Phase 5: 文檔更新 (Documentation Agent)

更新相關文檔：

1. 更新 README.md 中的專案結構說明
2. 更新 docs/README.md
3. 更新 .gitignore（如需要）

---

### Phase 6: Git 提交 (Git Agent)

```bash
git add .
git commit -m "refactor: 清理專案結構，確保 Clean Code 架構

清理動作:
- ✅ 移動報告類文件到 archives/
- ✅ 刪除臨時文件
- ✅ 整理根目錄結構
- ✅ 更新文檔

結果:
- 根目錄檔案: 減少 XX 個
- 專案結構: 更清晰整潔
- 符合開源專案標準"

git push origin master
```
```

**預估時間**: 1-1.5 小時

---

### 2.3 新專案整合工作流 (Super Workflow Gamma)

**目的**: 將新專案整合到 Claude Code 生態系統

**前置條件**:
- 專案 GitHub URL
- 專案類型（工具、框架、文檔等）

**執行步驟**:

```markdown
### Phase 1: 專案分析 (Analysis Agent)

1. Clone 專案到 analysis-projects/
2. 讀取 README.md
3. 識別：
   - 專案功能
   - 使用場景
   - 目標使用者
   - 版本號
   - 最後更新時間

---

### Phase 2: 文檔建立 (Creation Agent)

1. 建立 docs/PROJECT-NAME-zh-tw.md
2. 使用標準化模板
3. 翻譯關鍵內容
4. 補充使用範例

文檔模板：
```markdown
# [專案名稱] 中文說明書

## 概述

[專案簡介]

> **資料來源：**
>
> - [GitHub 專案](GITHUB_URL)
> - [官方網站](WEBSITE_URL)
> - **文件整理時間：[TIME]**
> - **專案版本：[VERSION]**
> - **專案最後更新：[DATE]**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心功能](#2-核心功能)
- [3. 快速開始](#3-快速開始)
- [4. 使用指南](#4-使用指南)
- [5. 最佳實踐](#5-最佳實踐)
- [6. 延伸閱讀](#6-延伸閱讀)

---

## 1. 專案簡介

[詳細說明]

### 1.1 核心特色

- **特色一**：說明
- **特色二**：說明

### 1.2 使用場景

- **場景一**：說明
- **場景二**：說明

### 1.3 目標使用者

- 開發者類型A
- 開發者類型B

---

[更多章節...]
```

---

### Phase 3: 索引更新 (Index Agent)

1. 更新 docs/README.md
2. 更新根目錄 README.md
3. 更新 index.html（如需要）

---

### Phase 4: 驗證 (Validation Agent)

1. 檢查文檔格式
2. 驗證連結有效性
3. 確認繁體中文品質

---

### Phase 5: Git 提交 (Git Agent)

```bash
git add .
git commit -m "docs: 新增 [專案名稱] 繁體中文文檔

新專案資訊:
- 專案: [PROJECT_NAME]
- 版本: [VERSION]
- 功能: [簡要說明]
- 文檔: docs/[PROJECT-NAME]-zh-tw.md

更新內容:
- ✅ 建立繁體中文文檔
- ✅ 更新索引文件
- ✅ 驗證格式與連結"

git push origin master
```
```

**預估時間**: 1-2 小時（取決於專案複雜度）

---

## 3. Prompt 模板庫

### 3.1 文檔更新模板

```markdown
請幫我更新 [專案名稱] 的繁體中文文檔：

**專案資訊**:
- GitHub: [URL]
- 當前版本: [VERSION]
- 文檔路徑: docs/[FILE-NAME]-zh-tw.md

**更新任務**:
1. 同步專案到最新版本
2. 讀取 README.md 和 CHANGELOG
3. 提取新功能和變更
4. 更新繁體中文文檔
5. 更新版本和時間戳記
6. 驗證格式正確性

**輸出要求**:
- 保持原有格式結構
- 100% 繁體中文（技術術語除外）
- 時間戳記: YYYY-MM-DDTHH:MM:SS+08:00
- 生成更新報告
```

---

### 3.2 專案清理模板

```markdown
請幫我清理專案結構：

**清理範圍**:
- 根目錄
- docs/ 資料夾
- scripts/ 資料夾

**清理任務**:
1. 掃描所有檔案和資料夾
2. 分類檔案（保留/移動/刪除）
3. 移動報告類文件到 archives/
4. 刪除臨時文件
5. 驗證專案結構
6. 更新相關文檔

**保留標準**:
- 必要配置文件
- 核心文檔文件
- 腳本工具
- Prompt 模板

**輸出要求**:
- 清理計劃
- 執行報告
- 結構驗證
```

---

### 3.3 版本對齊模板

```markdown
請驗證所有專案的文檔版本對齊狀態：

**驗證範圍**:
- 所有 docs/*-zh-tw.md 文檔
- 對應的 analysis-projects/ 專案

**驗證任務**:
1. 提取文檔版本資訊
2. 提取專案實際版本
3. 比對版本號
4. 標註對齊狀態
5. 生成對齊報告

**對齊狀態**:
- ✅ 完全對齊
- ⚠️ 格式差異
- ❌ 版本落後
- ⚠️ 無版本標籤

**輸出要求**:
- 完整對齊報告
- 需要更新的文檔列表
- 建議行動計劃
```

---

### 3.4 翻譯任務模板

```markdown
請將以下英文技術內容翻譯為高品質繁體中文：

**原文內容**:
```
[英文原文]
```

**翻譯要求**:
- 保留技術術語英文（API, CLI, Git 等）
- 保持專有名詞原文（Claude Code, Anthropic）
- 指令和代碼不翻譯
- 確保語句流暢自然
- 使用繁體中文標點符號

**翻譯輸出**:
```
[繁體中文譯文]
```

**品質檢查**:
- ✅ 語句通順
- ✅ 術語一致
- ✅ 無大陸用語
- ✅ 標點正確
```

---

## 4. 最佳實踐指南

### 4.1 文檔撰寫最佳實踐

**結構化原則**:
```yaml
文檔結構:
  1. 標題與概述:
     - 清晰的標題
     - 簡潔的概述
     - 視覺化徽章（如有）

  2. 資料來源區塊:
     - GitHub 專案連結
     - 官方網站/文檔
     - 文件整理時間
     - 專案版本
     - 最後更新日期

  3. 目錄:
     - 完整的章節索引
     - 使用錨點連結
     - 清晰的層級

  4. 主要內容:
     - 專案簡介
     - 核心功能
     - 快速開始
     - 使用指南
     - 最佳實踐
     - 疑難排解

  5. 延伸閱讀:
     - 官方資源
     - 相關專案
     - 學習資源
```

**Markdown 最佳實踐**:
```markdown
# 標題層級
# H1 - 文檔標題（僅一個）
## H2 - 主要章節
### H3 - 次要章節
#### H4 - 詳細說明

# 代碼塊
```bash
# 使用正確的語言標籤
command --flag value
```

# 表格
| 欄位 | 說明 | 範例 |
|------|------|------|
| A    | 描述 | 值   |

# 連結
[顯示文字](URL)
[內部錨點](#章節名稱)

# 強調
**粗體** - 重要內容
*斜體* - 強調
`代碼` - 行內代碼

# 列表
- 無序列表項目
  - 子項目

1. 有序列表項目
2. 第二項目
```

---

### 4.2 Git 提交最佳實踐

**Commit Message 格式**:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type 類型**:
```yaml
docs: 文檔變更
feat: 新功能
fix: 錯誤修復
refactor: 重構
style: 格式調整
test: 測試相關
chore: 雜項任務
```

**範例**:
```bash
docs: 更新 SuperClaude 文檔至 v4.2.0

變更內容:
- 新增 Deep Research 章節
- 更新核心功能說明
- 補充使用範例
- 更正連結錯誤

影響檔案:
- docs/superclaude-zh-tw.md (+301 lines)

相關 Issue: #123
```

---

### 4.3 專案組織最佳實踐

**目錄結構**:
```
claude-code/
├── README.md               # 專案總覽
├── CHANGELOG.md            # 變更日誌
├── LICENSE                 # 授權
├── .gitignore              # Git 忽略規則
│
├── docs/                   # 文檔目錄
│   ├── README.md          # 文檔索引
│   ├── *-zh-tw.md         # 繁體中文文檔
│   └── anthropic-claude-code-zh-tw/  # 官方文檔鏡像
│
├── scripts/                # 腳本工具
│   ├── sync-*.sh          # 同步腳本
│   └── validate-*.sh      # 驗證腳本
│
├── prompts/                # Prompt 模板
│   └── super-workflows-master.md
│
├── analysis-projects/      # 分析用專案（Git ignored）
│   └── */
│
└── archives/               # 歸檔（可選）
    └── reports/
```

**檔案命名規範**:
```yaml
文檔檔案:
  格式: "[project-name]-zh-tw.md"
  範例:
    - superclaude-zh-tw.md
    - agents-zh-tw.md
    - claude-code-usage-monitor-zh-tw.md

腳本檔案:
  格式: "[action]-[target].sh"
  範例:
    - sync-projects.sh
    - validate-docs.sh
    - update-versions.sh

報告檔案:
  格式: "[TYPE]-[SUBJECT]-REPORT.md"
  範例:
    - DOCS-UPDATE-SUMMARY.md
    - PHASE-C-COMPLETION-REPORT.md
    - FINAL-100-PERCENT-COMPLETION-REPORT.md
```

---

## 5. 使用案例

### 5.1 完整文檔更新流程（實戰範例）

**情境**: 更新所有 18 個專案的繁體中文文檔

**執行指令**:
```markdown
請執行 Super Workflow Alpha - 完整文檔更新工作流：

**目標**:
更新所有 18 個 Claude Code 相關專案的繁體中文文檔到最新狀態

**專案清單**:
1. agents (wshobson)
2. SuperClaude_Framework
3. Claude-Code-Usage-Monitor
4. awesome-claude-code
5. claude-code-guide
6. claudecodeui
7. BPlusTree3
8. claudia
9. claude-code-hooks
10. claude-code-spec
11. ccusage
12. vibe-kanban
13. claude-agents (iannuttall)
14. ClaudeCode-Debugger
15. claude-code-leaderboard
16. context-engineering-intro
17. contains-studio-agents
18. claude-code-security-review

**執行階段**:
Phase 1: 專案同步
Phase 2: 文檔分析
Phase 3: 內容更新
Phase 4: 翻譯與潤色
Phase 5: 索引更新
Phase 6: 驗證
Phase 7: Git 提交

**預期輸出**:
- 18 個更新的專案
- 18 個更新的文檔
- 更新的索引文件
- 驗證報告
- Git commits

請分階段執行，每個 Phase 完成後報告進度。
```

**預期結果**:
- 所有專案同步到最新版本
- 所有文檔反映最新功能和變更
- 所有版本資訊準確無誤
- 100% 繁體中文覆蓋

---

### 5.2 專案清理流程（實戰範例）

**情境**: 清理專案結構，刪除過時和臨時文件

**執行指令**:
```markdown
請執行 Super Workflow Beta - 專案清理工作流：

**目標**:
清理專案結構，確保符合 Clean Code 和開源專案標準

**清理範圍**:
- 根目錄所有檔案
- docs/ 資料夾
- scripts/ 資料夾

**清理類別**:
1. 報告類文件（移至 archives/reports/）
   - *-REPORT.md
   - *-report.md
   - verification-*.md

2. 臨時文件（刪除）
   - *.tmp
   - *-temp.md
   - draft-*.md

3. 系統文件（刪除）
   - .DS_Store
   - Thumbs.db

**執行階段**:
Phase 1: 全局掃描
Phase 2: 分類識別
Phase 3: 執行清理
Phase 4: 結構驗證
Phase 5: 文檔更新
Phase 6: Git 提交

請先生成清理計劃供我審核，然後再執行。
```

**預期結果**:
- 根目錄整潔，僅保留必要文件
- 報告文件妥善歸檔
- 專案結構清晰
- 符合開源專案標準

---

### 5.3 新專案整合流程（實戰範例）

**情境**: 將新發現的 Claude Code 相關專案整合到生態系統

**執行指令**:
```markdown
請執行 Super Workflow Gamma - 新專案整合工作流：

**新專案資訊**:
- 專案名稱: claude-code-new-tool
- GitHub URL: https://github.com/user/claude-code-new-tool
- 類型: 開發工具
- 簡介: [簡要說明]

**執行階段**:
Phase 1: 專案分析
  - Clone 到 analysis-projects/
  - 分析 README 和功能
  - 識別使用場景

Phase 2: 文檔建立
  - 建立 docs/claude-code-new-tool-zh-tw.md
  - 翻譯關鍵內容
  - 補充使用範例

Phase 3: 索引更新
  - 更新 docs/README.md
  - 更新根目錄 README.md
  - 更新 index.html

Phase 4: 驗證
  - 檢查文檔格式
  - 驗證連結有效性

Phase 5: Git 提交
  - Commit 並 push

請開始執行。
```

**預期結果**:
- 新專案完整整合
- 高品質繁體中文文檔
- 所有索引正確更新
- 驗證通過

---

## 6. 附錄

### 6.1 常用 Git 指令

```bash
# 同步專案
cd analysis-projects/PROJECT_NAME
git fetch origin
git reset --hard origin/main
git clean -fd
git pull --rebase origin main

# 提取版本
git describe --tags --abbrev=0
git log -1 --format="%ai"

# 提交變更
git add .
git commit -m "type(scope): subject"
git push origin master

# 查看狀態
git status
git log --oneline -10
git diff
```

---

### 6.2 常用文件操作

```bash
# 搜尋檔案
find . -name "*.md" -type f
grep -r "pattern" .

# 列出檔案
ls -lah
tree -L 2

# 移動和刪除
mv source destination
rm -f file
rm -rf directory

# 建立目錄
mkdir -p path/to/directory
```

---

### 6.3 時間戳記格式

**ISO 8601 + Asia/Taipei**:
```
YYYY-MM-DDTHH:MM:SS+08:00

範例:
2025-10-28T05:00:00+08:00
2025-01-15T14:30:45+08:00
```

**生成指令**:
```bash
# macOS/Linux
date -u +"%Y-%m-%dT%H:%M:%S+08:00"

# JavaScript
new Date().toISOString().replace('Z', '+08:00')

# Python
from datetime import datetime, timezone, timedelta
taipei_tz = timezone(timedelta(hours=8))
datetime.now(taipei_tz).isoformat()
```

---

## 7. 維護與更新

### 7.1 文檔維護週期

```yaml
定期維護:
  每週:
    - 檢查專案更新
    - 同步重要變更
    
  每月:
    - 全面版本對齊檢查
    - 更新所有文檔
    - 驗證連結有效性
    
  每季:
    - 專案結構檢查
    - 清理過時內容
    - 更新最佳實踐
```

---

### 7.2 品質檢查清單

```yaml
文檔品質:
  □ 標題層級正確
  □ 目錄完整
  □ 資料來源區塊完整
  □ 版本資訊準確
  □ 時間戳記格式正確
  □ 代碼塊語言標籤正確
  □ 表格格式完整
  □ 連結有效
  □ 100% 繁體中文
  □ 無錯別字

專案結構:
  □ 根目錄整潔
  □ 文檔組織清晰
  □ 腳本功能正常
  □ .gitignore 正確
  □ README.md 最新
  □ CHANGELOG.md 完整
```

---

## 結語

這份超級工作流大全記錄了所有成功的 Agent 角色、工作流程和 Prompt 模板。使用這些模板可以：

✅ **快速執行** - 直接使用預定義的工作流程  
✅ **確保品質** - 遵循最佳實踐和標準  
✅ **提高效率** - 減少重複工作和錯誤  
✅ **易於維護** - 清晰的結構和文檔  

**建議使用方式**:
1. 根據需求選擇對應的工作流程
2. 複製對應的 Prompt 模板
3. 填入具體資訊
4. 執行並追蹤進度
5. 完成後更新文檔

**持續改進**:
- 記錄新的成功案例
- 優化現有工作流程
- 補充新的 Agent 角色
- 更新最佳實踐

---

**文檔版本**: v1.0.0  
**最後更新**: 2025-10-28T05:00:00+08:00  
**維護者**: s123104  
**授權**: MIT

---

## 快速使用指南

### 如何使用此文檔

**1. 查找對應的工作流程**
   - 文檔更新 → Super Workflow Alpha
   - 專案清理 → Super Workflow Beta
   - 新專案整合 → Super Workflow Gamma

**2. 複製 Prompt 模板**
   - 選擇對應的模板
   - 填入具體資訊
   - 直接使用

**3. 執行並追蹤**
   - 分階段執行
   - 記錄進度
   - 驗證結果

**4. 提交與歸檔**
   - Git commit
   - 更新文檔
   - 生成報告

---

**💡 提示**: 善用 Ctrl+F 快速搜尋關鍵字！

