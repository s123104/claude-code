# Claude Code 生態系統 - 最新文檔摘要

**生成時間**：2025-10-28T05:00:00+08:00  
**文檔覆蓋率**：18/18（100%）  
**語言覆蓋率**：100% 繁體中文

---

## 📊 專案版本總覽

| 專案名稱 | 版本 | 最後更新 | 文檔時間 | 狀態 |
|---------|------|---------|---------|------|
| **agents** | Plugin Marketplace | 2025-10-28 | 2025-10-28T01:30:00 | ✅ 最新 |
| **ccusage** | v17.1.3 | 2025-10-27 | 2025-10-27T23:40:00 | ✅ 最新 |
| **claudecodeui** | v1.8.12 | 2025-10-27 | 2025-10-28T00:15:00 | ✅ 最新 |
| **claude-code-usage-monitor** | v3.0.0 | 2025-10-27 | 2025-10-28T02:00:00 | ✅ 最新 |
| **SuperClaude** | v4.2.0 | 2025-10-28 | 2025-10-28T03:00:00 | ✅ 最新 |
| **awesome-claude-code** | 2025-10-16 | 2025-10-16 | 2025-10-28T03:30:00 | ✅ 最新 |
| **bplustree3** | v3.0 | 2025-08-18 | 2025-10-28T03:45:00 | ✅ 最新 |
| **claude-code-leaderboard** | v0.2.9 | 2025-08-06 | 2025-10-28T03:50:00 | ✅ 最新 |
| **claude-code-security-review** | v1.0 | 2025-08-12 | 2025-10-28T03:55:00 | ✅ 最新 |
| **contains-studio-agents** | v1.2 | 2025-08-16 | 2025-10-28T04:00:00 | ✅ 最新 |
| **context-engineering-intro** | v1.0 | 2025-08-06 | 2025-10-28T04:05:00 | ✅ 最新 |
| **vibe-kanban** | v0.0.111-20251023 | 2025-10-27 | 2025-10-28T04:10:00 | ✅ 最新 |
| **claude-agents** | v1.0 | 2025-07-25 | 2025-10-28T04:20:00 | ✅ 最新 |
| **cursor-claude-master-guide** | v3.0.0 | 2025-10-28 | 2025-10-28T04:25:00 | ✅ 最新 |
| **mcp-setup-guide** | v2.0.0 | 2025-10-28 | 2025-10-28T04:30:00 | ✅ 最新 |
| **opcode (原 claudia)** | v0.2.0 | 2025-10-13 | 2025-10-27T23:30:00 | ✅ 最新 |
| **claude-code-spec** | v1.1.5 | 2025-10-25 | 2025-10-27T23:45:00 | ✅ 最新 |
| **claudecode-debugger** | v1.5.0 | 2025-07-30 | 2025-10-27T23:50:00 | ✅ 最新 |

---

## 🔥 核心功能摘要（按專案）

### 1️⃣ **agents (wshobson)** - Plugin Marketplace 架構

**最新架構變更**：從直接代理安裝轉型為 **Plugin Marketplace**

**核心數據**：
- 85 個專業 AI 代理（15 個多代理工作流編排器）
- 47 個 Agent Skills（Claude Code v2.0.20+）
- 44 個開發工具
- 63 個聚焦插件

**關鍵功能**：
- **Plugin Marketplace**：統一插件安裝與管理（`claude plugin install <plugin-name>`）
- **Agent Skills 系統**：模型控制的專業任務配置
- **混合模型編排**：Haiku + Sonnet 智能組合
- **多代理工作流**：15 個預建工作流編排器
- **插件管理**：查看、啟用、停用已安裝插件

**應用場景**：
- 企業級開發流程自動化
- 多代理協同工作流設計
- 專業任務特定優化（測試、安全、文檔等）

**適用客群**：
- 中大型開發團隊
- DevOps 工程師
- 技術架構師

---

### 2️⃣ **ccusage (ryoppippi)** - 使用量監控生態系統

**版本**：v17.1.3（2025-10-27）

**最新變更**：ccusage Family 生態系統整合

**核心套件**：
1. **ccusage**：主要 CLI 工具
2. **@ccusage/codex**：使用記錄查詢引擎
3. **@ccusage/mcp**：MCP 伺服器整合

**關鍵功能**：
- **即時令牌監控**：追蹤當前會話的令牌使用量
- **快取效率分析**：Prompt 快取命中率監控
- **成本估算**：基於令牌的成本計算
- **歷史記錄查詢**：@ccusage/codex 查詢歷史使用記錄
- **MCP 整合**：透過 @ccusage/mcp 與其他工具整合

**安裝方式**：
```bash
npx ccusage@latest        # 基本監控
npx @ccusage/codex@latest # 歷史查詢
bunx ccusage@latest       # Bun 用戶（需設定 BUN_CONFIG_MAX_HTTP_REQUESTS）
```

**應用場景**：
- 個人開發成本控制
- 團隊使用量追蹤
- 令牌效率優化

**適用客群**：
- 所有 Claude Code 用戶
- 成本敏感型團隊
- 個人開發者

---

### 3️⃣ **claudecodeui (siteboon)** - 雙 CLI 桌面 + 行動介面

**版本**：v1.8.12（2025-10-27）

**核心變更**：支援 **Claude Code CLI** 和 **Cursor CLI** 動態切換

**支援模型**：
- Claude Sonnet 4
- Claude Opus 4.1
- GPT-5

**主要特色**：
- **雙 CLI 支援**：Claude Code + Cursor 自由切換
- **完整行動體驗**：手機/平板完全可用
- **整合終端**：直接在 UI 內執行 CLI 命令
- **檔案管理**：完整檔案瀏覽器與編輯器
- **Git 整合**：Git Explorer 視覺化 Git 操作
- **安全優先**：所有 Claude Code 工具預設停用，手動啟用
- **TaskMaster AI 整合**：AI 任務管理（需手動啟用）

**安裝**：
```bash
# 一鍵運行
npx claudecodeui

# 本地開發
git clone https://github.com/siteboon/claudecodeui
cd claudecodeui
npm install
npm run dev       # Frontend
npm run server    # Backend
```

**技術架構**：
- **後端**：Node.js + Express + WebSocket
- **前端**：React + Vite + Tailwind CSS
- **CLI 整合**：動態偵測並切換 Claude Code / Cursor

**應用場景**：
- 行動辦公開發
- 遠端專案管理
- 視覺化 Claude Code 會話管理

**適用客群**：
- 行動優先開發者
- 非命令列偏好用戶
- 遠端工作者

---

### 4️⃣ **claude-code-usage-monitor (Maciek-roboblog)** - v3.0.0 架構重寫

**版本**：v3.0.0（2025-10-27）

**重大更新**：完全架構重寫

**v3.0.0 核心特性**：
- **🔮 ML 基礎預測**：P90 百分位計算和智能會話限制檢測
- **🔄 即時監控**：可配置刷新率（0.1-20 Hz）
- **📊 進階 Rich UI**：美化的彩色進度條、符合 WCAG 對比標準
- **🤖 智能自動檢測**：自動計畫切換與自定義限制發現
- **📋 增強的計畫支援**：Pro (19k)、Max5 (88k)、Max20 (220k)、Custom (P90 基礎)
- **⚠️ 進階警告系統**：多級警報與成本及時間預測
- **🏗️ 專業架構**：Pydantic 驗證、完整測試覆蓋、錯誤報告
- **🎨 智能主題**：自動偵測淺色/深色終端機
- **⏰ 進階排程**：可設定監控頻率（--rate）
- **💰 成本分析**：詳細的花費追蹤和預測

**安裝**：
```bash
pip install claude-monitor  # 或 pipx install claude-monitor
claude-monitor              # 啟動監控
```

**使用範例**：
```bash
claude-monitor --rate 2                    # 2 Hz 監控
claude-monitor --plan max5                 # 指定計畫
claude-monitor --custom-limit 100000       # 自定義限制
claude-monitor --debug                     # 除錯模式
```

**應用場景**：
- 精確成本控制
- 即時使用量監控
- ML 基礎預測和限制檢測

**適用客群**：
- 重度 Claude Code 用戶
- 企業用戶
- 成本敏感型開發者

---

### 5️⃣ **SuperClaude (SuperClaude-Org)** - v4.2.0 Deep Research 更新

**版本**：v4.2.0（2025-10-28）

**最新功能**：**Deep Research** 深度研究系統

**v4.2 Deep Research 核心特性**：
- **🎯 適應性規劃**：根據查詢複雜度動態調整研究策略
- **🔄 多跳推理**：迭代式搜尋策略（Multi-Hop Reasoning）
- **📊 品質評分**：自動評估來源可靠性和相關性
- **📚 案例學習**：從成功研究案例中學習

**研究深度層級**：
1. **Quick**：快速概覽（5-10 來源，< 5 分鐘）
2. **Standard**：標準研究（10-20 來源，5-15 分鐘）
3. **Deep**：深度分析（20-40 來源，15-30 分鐘）
4. **Exhaustive**：完全詳盡（40+ 來源，30-60 分鐘）

**整合工具編排**：
- **Tavily MCP**：網路搜尋和新聞聚合
- **Playwright MCP**：動態網頁瀏覽
- **Sequential Thinking MCP**：複雜推理鏈
- **Serena MCP**：學術研究和技術文檔
- **Context7 MCP**：程式碼相關研究

**v4.2 其他特色**：
- **Agent Skills**：新一代模型控制技能系統
- **改善命名**：CC-Agent → Agent，CC-Tools → Agent Tools
- **17 個 MCP 伺服器**：涵蓋搜尋、瀏覽、資料庫、開發工具
- **6 種行為模式**：Creative、Balanced、Precise、Conservative、Experimental、Safe
- **優化效能**：減少延遲、改善記憶管理

**安裝**：
```bash
git clone https://github.com/SuperClaude-Org/SuperClaude_Framework
cd SuperClaude_Framework
./scripts/install.sh      # 或 Windows 用 install.bat
```

**使用範例**：
```bash
# Deep Research 使用
"請進行深度研究：AI 在醫療診斷的最新應用"

# 指定研究深度
"請用 Exhaustive 模式研究量子計算的商業應用"
```

**應用場景**：
- 深度技術調研
- 學術文獻綜述
- 市場趨勢分析
- 複雜問題解決

**適用客群**：
- 研究人員
- 產品經理
- 技術架構師
- 數據分析師

---

### 6️⃣ **awesome-claude-code (hesreallyhim)** - 2025-10-16 重大更新

**最新版本**：2025-10-16

**📢 重要公告**：**AGENT SKILLS 重大更新**（Claude Code v2.0.20）

**🆕 本週新增**：
1. **Codex Skill**：全局歷史會話管理和搜尋
2. **claude-mem**：外部記憶存儲系統
3. **cc-sessions**：命令列會話管理工具
4. **fcakyon Collection**：5 個專業 MCP 伺服器（Jira、Linear、Google Maps、YouTube、Serper）
5. **/linux-desktop-slash-commands**：Linux 桌面自動化斜槓命令

**核心內容**：
- **Agent Skills 說明**：完整的 Agent Skills 系統介紹和使用指南
- **工具與資源分類**：
  - CLI 工具與 GUI 工具
  - MCP 伺服器（官方 + 社群）
  - 開發工具（測試、除錯、監控）
  - 整合工具（IDE、Git、CI/CD）
  - 學習資源（教學、文檔、社群）

**應用場景**：
- 發現最新 Claude Code 工具
- 快速找到特定需求的解決方案
- 學習 Claude Code 最佳實踐

**適用客群**：
- 所有 Claude Code 用戶
- 工具探索者
- 學習者

---

### 7️⃣ **bplustree3 (KentBeck)** - Kent Beck AI 實驗

**版本**：v3.0（2025-08-18）

**🎯 Kent Beck 實驗動機**：
1. **AI 輔助編程實驗**：探索如何利用 Claude Code 進行複雜系統級程式設計
2. **效能優化研究**：Rust 和 Python 雙語言實作對比
3. **教學示範**：高品質 B+ Tree 參考實作
4. **開源貢獻**：生產級品質的資料結構實作

**🔬 實驗結果**：
- ✅ 雙語言高效能實作（Rust + Python）
- ✅ 顯著效能提升（刪除快 41%、混合工作負載提升 19-30%）
- ✅ 生產級程式碼品質（完整測試、優秀文檔）
- ✅ 持續改進（主動效能優化、架構簡化）

**核心特色**：
- **雙語言實作**：Rust（速度）+ Python（易用性）
- **高效能**：針對資料庫索引和檔案系統優化
- **完整測試**：包含單元測試和效能基準測試
- **學習資源**：詳細的實作說明和最佳實踐

**應用場景**：
- 高效能資料庫索引
- 檔案系統實作
- 學習 B+ Tree 資料結構
- AI 輔助系統級編程案例研究

**適用客群**：
- 系統工程師
- 資料庫開發者
- 學生和教育工作者
- AI 輔助編程研究者

---

### 8️⃣ **claude-code-leaderboard (grp06)** - 全球排行榜

**版本**：v0.2.9（2025-08-06）

**核心功能**：
- **🔄 自動追蹤**：透過 Hooks 系統自動監控使用量
- **🏆 全球排行榜**：在 [claudecount.com](https://claudecount.com) 展示排名
- **🛡️ 隱私保護**：只收集使用統計，不記錄實際對話內容
- **📊 詳細分析**：token 使用、模型選擇、快取效率等指標
- **🚀 即插即用**：一行指令完成安裝

**安裝**：
```bash
npx claude-code-leaderboard setup
```

**Hooks 系統**：
- **session_finished**：會話結束時觸發
- **自動上傳**：統計資料自動上傳到排行榜
- **背景執行**：不影響正常開發流程

**應用場景**：
- 個人競爭與效率追蹤
- 團隊友善競賽
- 社群參與
- 使用模式分析

**適用客群**：
- 競爭導向開發者
- 團隊領導者
- 社群活躍者

---

### 9️⃣ **claude-code-security-review (anthropics)** - Anthropic 官方安全審查

**版本**：v1.0（2025-08-12）

**專案特色**：
- **AI 驅動分析**：Claude 的先進推理能力檢測安全漏洞
- **差異感知掃描**：針對 PR，僅分析變更的檔案
- **PR 評論**：自動在 PR 上留下安全發現的評論
- **上下文理解**：超越模式匹配，理解程式碼語義
- **語言無關**：支援任何程式語言
- **誤報過濾**：進階過濾減少噪音

**核心功能**：
1. **GitHub Action 整合**：自動在 PR 上執行安全審查
2. **深度語義分析**：理解程式碼上下文和意圖
3. **詳細報告**：提供漏洞位置、嚴重性、修復建議
4. **可配置性**：自訂嚴重性閾值、掃描規則

**安裝**：
```yaml
# .github/workflows/security-review.yml
name: Security Review
on: [pull_request]
jobs:
  security-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: anthropics/claude-code-security-review@v1
        with:
          anthropic-api-key: ${{ secrets.ANTHROPIC_API_KEY }}
```

**應用場景**：
- 自動化安全審查
- 持續安全監控（CI/CD）
- 提升團隊安全意識
- 開源專案安全檢測

**適用客群**：
- 安全工程師
- DevOps 團隊
- 開源專案維護者
- 企業開發團隊

---

### 🔟 **contains-studio-agents (contains-studio)** - 專業代理集合

**版本**：v1.2（2025-08-16）

**核心特色**：
- **🎯 專業化分工**：每個代理專精於特定領域
- **⚡ 自動觸發**：根據任務描述自動選擇合適的代理
- **🔄 明確調用**：可以明確指定使用特定代理
- **📦 即插即用**：簡單複製即可使用
- **🔧 可客製化**：可根據需求修改代理行為

**代理覆蓋領域**：
- **開發專業**：前後端、全端、行動應用開發
- **資料與 AI**：資料科學、機器學習、AI 工程
- **基礎設施**：DevOps、雲端架構、安全工程
- **設計與內容**：UI/UX 設計、內容創作、技術寫作

**使用方式**：
```bash
# 自動觸發
"我需要設計一個 React 元件"  # 自動觸發前端代理

# 明確調用
"使用 DevOps 代理設定 CI/CD 流程"
```

**應用場景**：
- 專業任務自動化
- 團隊協作分工
- 專家級技術諮詢

**適用客群**：
- 全端開發者
- 專業化團隊
- 新手開發者（學習專業領域）

---

### 1️⃣1️⃣ **context-engineering-intro (coleam00)** - Context Engineering 方法論

**版本**：v1.0（2025-08-06）

**核心理念**：
> **Context Engineering 比 prompt engineering 好 10 倍，比 vibe coding 好 100 倍。**

**核心概念**：
- **結構化脈絡**：系統性地組織和提供 AI 所需的背景資訊
- **端到端交付**：確保 AI 能夠完整地完成複雜任務
- **可重複流程**：建立標準化的開發流程和範本
- **品質保證**：透過脈絡工程提升 AI 輸出的品質和一致性

**PRP 工作流程**（Plan-Review-Produce）：
1. **Plan（規劃）**：定義專案目標、範圍、技術棧
2. **Review（審查）**：AI 審查計畫並提供建議
3. **Produce（產出）**：執行開發並持續迭代

**範本系統**：
- **專案初始化範本**：快速啟動新專案
- **任務描述範本**：結構化任務說明
- **審查範本**：標準化程式碼審查流程

**應用場景**：
- 新專案啟動
- 複雜任務規劃
- 團隊標準化流程
- AI 輔助開發最佳實踐

**適用客群**：
- 專案經理
- 技術架構師
- 團隊領導者
- 所有希望提升 AI 協作效率的開發者

---

### 1️⃣2️⃣ **vibe-kanban (BloopAI)** - AI 代理視覺化編排

**版本**：v0.0.111-20251023173202（2025-10-27）

**核心理念**：
> **讓 AI 程式設計代理發揮 10 倍效能**

**主要優勢**：
- **🔄 代理切換**：輕鬆在不同程式設計代理間切換
- **⚡ 並行執行**：編排多個程式設計代理並行或串列執行
- **👀 快速審查**：快速審查工作成果並啟動開發伺服器
- **📊 狀態追蹤**：追蹤程式設計代理正在處理的任務狀態
- **🎯 視覺化管理**：看板式介面管理 AI 開發工作流程
- **🔌 Git 整合**：無縫整合 Git 倉庫和分支管理

**支援的 AI 代理**：
- Claude Code
- Gemini CLI
- Codex
- Amp
- 其他程式設計代理

**核心功能**：
1. **看板管理**：視覺化任務看板（待辦、進行中、已完成）
2. **代理編排**：多代理協同工作流程
3. **Git 整合**：自動 commit、分支管理、PR 建立
4. **審查工具**：快速審查 AI 生成的程式碼
5. **開發伺服器**：內建開發伺服器快速測試

**安裝**：
```bash
npm install -g vibe-kanban
vibe-kanban init      # 初始化專案
vibe-kanban start     # 啟動看板
```

**應用場景**：
- 多代理協同開發
- 視覺化專案管理
- Git 工作流程自動化
- AI 開發任務編排

**適用客群**：
- 使用多個 AI 代理的開發者
- 視覺化偏好的開發者
- 專案管理者

---

### 1️⃣3️⃣ **claude-agents (iannuttall)** - 自訂代理集合

**版本**：v1.0（2025-07-25）

**核心特色**：
- **專業化代理**：7 個專門設計的代理，涵蓋不同開發領域
- **即插即用**：簡單的安裝和配置流程
- **靈活部署**：支援專案特定和全域使用
- **持續更新**：定期更新和改進代理功能
- **社群驅動**：基於社群需求開發和優化

**可用代理**：
1. **Code Refactor Agent**：程式碼重構專家
2. **Frontend Design Agent**：前端設計和 UI/UX
3. **API Development Agent**：API 設計和開發
4. **Security Audit Agent**：安全審查
5. **Testing Agent**：測試策略和實作
6. **Documentation Agent**：技術文檔撰寫
7. **Project Planning Agent**：專案規劃和架構設計

**安裝**：
```bash
# 專案特定安裝
claude install agents/code-refactor

# 全域安裝
claude install -s user agents/code-refactor
```

**應用場景**：
- 程式碼重構
- 前端設計
- 安全審查
- 專案規劃

**適用客群**：
- 全端開發者
- 安全工程師
- 專案經理

---

### 1️⃣4️⃣ **cursor-claude-master-guide** - 統一作業手冊

**版本**：v3.0.0（2025-10-28）

**核心功能**：
- **模糊需求解析引擎**：理解用戶模糊語句並轉換為精確指令
- **統一功能索引系統**：整合 18 個專業說明書的功能索引
- **Sequential-Thinking 執行流程**：結構化思考和執行
- **安全控制與監控機制**：用量監控 + 風險評估
- **自動化指令映射表**：自動將需求映射到對應工具

**整合文件**：18 個專業說明書的完整功能索引與智能執行引擎

**新增功能**：
- Agent Skills 整合
- Subagents 多代理協作
- Deep Research 深度研究

**應用場景**：
- Cursor AI 自動執行 Claude Code 指令
- 模糊需求到精確執行的轉換
- 多工具協同使用

**適用客群**：
- Cursor 用戶
- 需要統一作業流程的團隊
- 希望簡化工具使用的開發者

---

### 1️⃣5️⃣ **mcp-setup-guide** - MCP 伺服器設置指南

**版本**：v2.0.0（2025-10-28）

**核心內容**：
- **自動導入 Claude Desktop MCP**：快速配置方法
- **手動配置 MCP 伺服器**：詳細步驟說明
- **常用 MCP 伺服器列表**：精選推薦
- **故障排除**：常見問題解決方案
- **最佳實踐**：MCP 使用建議

**支援的傳輸類型**：
- **stdio**：標準輸入輸出（本地工具）
- **HTTP**：HTTP 協議（REST API）
- **SSE**：Server-Sent Events（即時數據流）

**作用域類型**：
- **local**：僅當前專案
- **user**：所有專案
- **project**：團隊共享

**應用場景**：
- MCP 伺服器快速設置
- 外部工具整合
- 擴展 Claude Code 能力

**適用客群**：
- 所有 Claude Code 用戶
- 希望擴展 Claude Code 功能的開發者

---

### 1️⃣6️⃣ **opcode (原 claudia)** - 桌面 GUI 工具套件

**版本**：v0.2.0（2025-10-13）

**🔔 重要變更**：**專案更名**：Claudia 已正式更名為 **opcode**

**核心特色**：
- **🖥️ 現代化 GUI**：基於 Tauri 2 的原生桌面應用程式
- **🤖 智能代理管理**：創建和管理自訂 CC Agents
- **📊 使用量分析**：詳細的使用統計和分析儀表板
- **🗂️ 專案管理**：集中管理多個 Claude Code 專案
- **🔌 MCP 整合**：完整的 Model Context Protocol 伺服器管理

**主要功能**：
1. **CC Agents 系統**：創建、管理、分享自訂代理
2. **專案管理**：視覺化專案管理和會話追蹤
3. **使用量監控**：詳細的 token 和成本分析
4. **MCP 伺服器管理**：圖形化 MCP 設定介面
5. **會話管理**：管理和恢復歷史會話

**安裝**：
```bash
# macOS
brew install opcode

# Windows
winget install opcode

# 或從 GitHub Releases 下載
```

**應用場景**：
- 視覺化 Claude Code 管理
- 自訂代理開發
- 使用量追蹤和分析
- 非命令列偏好用戶

**適用客群**：
- GUI 偏好用戶
- 代理開發者
- 專案管理者

---

### 1️⃣7️⃣ **claude-code-spec (gotalab)** - AI-DLC 和 SDD 工具

**版本**：v1.1.5（2025-10-25）

**核心價值主張**：
```
傳統開發流程           vs           AI-DLC 流程
─────────────                    ─────────────
2-4 週 Sprint                    小時至天的快速週期
多次會議和文檔                    規格作為唯一信息源
人類執行                          AI 執行，人類關卡驗證
低上下文保持                      持久專案記憶
```

**核心功能**：
- **🚀 快速衝刺**：從週到小時的交付週期
- **📋 規格作為唯一信息源**：驅動整個開發生命週期
- **🧠 持久專案記憶**：AI 在所有會話間維持完整上下文
- **🔄 AI 原生 + 人類關卡**：AI 執行，人類在關鍵點驗證
- **🌍 多語言多平台**：支援 12 種語言、8 個 AI 平台

**支援平台**：
- Claude Code、Cursor IDE、Gemini CLI、Codex CLI、GitHub Copilot、Qwen Code、Windsurf、自訂平台

**支援語言**：
- TypeScript、Python、Java、Go、Rust、C#、PHP、Ruby、Swift、Kotlin、JavaScript、C++

**指令系統（11 個 /kiro:* 斜槓命令）**：
```bash
/kiro:new-spec              # 建立新規格
/kiro:show-spec             # 顯示當前規格
/kiro:implement             # 實作規格
/kiro:test                  # 測試實作
/kiro:review                # 審查變更
/kiro:merge                 # 合併變更
/kiro:checkpoint            # 建立檢查點
/kiro:restore-checkpoint    # 恢復檢查點
/kiro:show-checkpoints      # 列出檢查點
/kiro:update-spec           # 更新規格
/kiro:ai-dlc-status         # 顯示狀態
```

**AI-DLC 工作流程**：
1. **規格階段**：創建或更新規格文檔
2. **實作階段**：AI 執行實作
3. **人類關卡**：關鍵點驗證
4. **測試階段**：自動化測試
5. **審查階段**：程式碼審查
6. **合併階段**：合併到主分支
7. **部署階段**：生產部署

**安裝**：
```bash
npm install -g cc-sdd
cc-sdd init      # 初始化專案
```

**應用場景**：
- 規格驅動開發
- AI-DLC 工作流程
- 多平台 AI 協同開發
- 持久專案記憶管理

**適用客群**：
- 產品團隊
- 技術架構師
- 專案經理
- 希望採用 SDD 方法論的開發者

---

### 1️⃣8️⃣ **claudecode-debugger** - AI 驅動除錯助手

**版本**：v1.5.0（2025-07-30）

**核心特色**：
- **AI 驅動除錯**：使用先進的 AI 分析技術理解錯誤
- **多語言支援**：支援 10+ 種程式語言
- **原生整合**：與 Claude Code 無縫整合
- **智能分析**：三種智能分析器（堆疊追蹤、模式、程式碼上下文）
- **美觀介面**：豐富多彩的終端機 UI 和進度指示器

**核心功能**：
1. **錯誤分析**：將錯誤訊息轉換為可執行的解決方案
2. **智能建議**：基於 AI 的修復建議
3. **上下文理解**：理解程式碼上下文和錯誤原因
4. **多語言支援**：Python、JavaScript、TypeScript、Java、C++、Go 等

**安裝**：
```bash
pip install claudecode-debugger
claudecode-debugger analyze "error message"
```

**使用方式**：
```bash
# 分析錯誤
claudecode-debugger analyze "AttributeError: 'NoneType' object has no attribute 'value'"

# 分析檔案
claudecode-debugger analyze-file error.log

# 互動模式
claudecode-debugger interactive
```

**應用場景**：
- 快速除錯
- 多語言開發錯誤分析
- 團隊協作（與 Claude Code 整合）
- 學習輔助（理解錯誤原因）

**適用客群**：
- 所有開發者
- 新手開發者（學習除錯）
- 多語言開發者

---

## 📈 關鍵統計

### 版本分布
- **最新更新（2025-10-27+）**：12 個專案
- **近期更新（2025-08+）**：5 個專案
- **穩定版本（2025-07）**：1 個專案

### 功能覆蓋
- **CLI 工具**：12 個
- **GUI 工具**：3 個（claudecodeui、opcode、vibe-kanban）
- **代理系統**：4 個（agents、contains-studio-agents、claude-agents、opcode）
- **監控工具**：3 個（ccusage、claude-code-usage-monitor、claude-code-leaderboard）
- **開發工具**：5 個（claude-code-spec、claudecode-debugger、claude-code-security-review、bplustree3、claude-code-hooks）
- **整合指南**：3 個（mcp-setup-guide、context-engineering-intro、cursor-claude-master-guide）
- **資源集合**：1 個（awesome-claude-code）

### 技術棧分布
- **Node.js / npm**：11 個
- **Python**：3 個
- **Rust**：1 個
- **多語言**：3 個

---

## 🎯 使用場景矩陣

| 場景 | 推薦工具 |
|------|---------|
| **個人開發成本控制** | ccusage, claude-code-usage-monitor |
| **團隊協作開發** | agents (Plugin Marketplace), vibe-kanban, SuperClaude |
| **視覺化管理** | claudecodeui, opcode, vibe-kanban |
| **行動辦公** | claudecodeui |
| **安全審查** | claude-code-security-review, claude-agents (Security Audit) |
| **深度研究** | SuperClaude (Deep Research) |
| **規格驅動開發** | claude-code-spec |
| **除錯輔助** | claudecode-debugger |
| **代理開發** | agents, opcode, contains-studio-agents, claude-agents |
| **使用量追蹤** | ccusage, claude-code-usage-monitor, claude-code-leaderboard |
| **MCP 設置** | mcp-setup-guide |
| **Context Engineering** | context-engineering-intro |
| **工具探索** | awesome-claude-code |
| **統一作業流程** | cursor-claude-master-guide |
| **高效能資料結構** | bplustree3 |

---

## 🌟 關鍵創新

### 1. **Agent Skills 革命**（Claude Code v2.0.20+）
- agents 專案：Plugin Marketplace 架構
- awesome-claude-code：Codex Skill、claude-mem
- SuperClaude：Agent Skills 整合

### 2. **Deep Research 系統**（SuperClaude v4.2）
- 適應性規劃
- 多跳推理
- 品質評分
- 4 層研究深度

### 3. **ML 基礎監控**（claude-code-usage-monitor v3.0）
- P90 百分位計算
- 智能限制檢測
- 進階 Rich UI

### 4. **AI-DLC 工作流程**（claude-code-spec v1.1.5）
- 規格驅動開發
- 持久專案記憶
- 8 平台、12 語言支援

### 5. **雙 CLI 整合**（claudecodeui v1.8.12）
- Claude Code + Cursor 動態切換
- 完整行動體驗

### 6. **Kent Beck AI 實驗**（bplustree3 v3.0）
- AI 輔助系統級編程
- 雙語言高效能實作

---

## ✅ 文檔品質指標

- **100% 繁體中文覆蓋**：所有 18 個專案
- **結構化格式**：統一的文檔結構（概述、目錄、功能、安裝、使用、應用場景）
- **版本標註**：所有專案都標註版本號和最後更新日期
- **資料來源標註**：所有專案都標註 GitHub、官方網站、文檔來源
- **功能詳盡性**：每個專案都詳細說明核心功能、使用方法、應用場景、適用客群

---

## 📝 後續維護建議

### 高優先級（每週檢查）
1. **agents**：Plugin Marketplace 快速演進，需持續追蹤新插件
2. **SuperClaude**：Deep Research 系統持續優化
3. **awesome-claude-code**：新工具和 Agent Skills 快速增加

### 中優先級（每月檢查）
1. **ccusage**：ccusage Family 生態系統擴展
2. **claudecodeui**：CLI 整合和功能擴展
3. **claude-code-usage-monitor**：v3.0 新功能穩定性

### 低優先級（每季檢查）
1. **穩定專案**：bplustree3、claude-code-leaderboard、claude-code-security-review
2. **成熟工具**：opcode、claude-code-spec、claudecode-debugger

---

**報告結束** - 2025-10-28T05:00:00+08:00

