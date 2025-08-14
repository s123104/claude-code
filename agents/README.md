# Contains Studio AI Agents 繁體中文指南

全面的專業化 AI 代理集合，專為加速和增強快速開發的各個方面而設計。每個代理都是其領域的專家，隨時準備在需要其專業知識時被調用。

## 📥 安裝

### 自動安裝（推薦）
```bash
# 從您的 claude-code 專案目錄執行
./install-agents.sh
```

### 手動安裝
1. **下載此倉庫：**
   ```bash
   git clone https://github.com/contains-studio/agents.git
   ```

2. **複製到您的 Claude Code agents 目錄：**
   ```bash
   cp -r agents/* ~/.claude/agents/
   ```

3. **重啟 Claude Code** 以載入新的 agents。

## 🚀 快速開始

Agents 會自動在 Claude Code 中可用。只需描述您的任務，適當的代理就會被觸發。您也可以透過提及其名稱來明確要求某個代理。

📚 **了解更多：** [Claude Code Sub-Agents 文檔](https://docs.anthropic.com/en/docs/claude-code/sub-agents)

### 使用範例
- 「創建一個用於追蹤冥想習慣的新應用程式」 → `rapid-prototyper` (快速原型師)
- 「TikTok 上有什麼趨勢是我們可以開發的？」 → `trend-researcher` (趋势研究员)
- 「我們的應用程式評價在下降，出了什麼問題？」 → `feedback-synthesizer` (反馈综合师)
- 「讓這個載入畫面更有趣」 → `whimsy-injector` (趣味注入师)

## 📁 目錄結構

Agents 按部門組織，便於發現：

```
contains-studio-agents/
├── design/
│   ├── brand-guardian.md
│   ├── ui-designer.md
│   ├── ux-researcher.md
│   ├── visual-storyteller.md
│   └── whimsy-injector.md
├── engineering/
│   ├── ai-engineer.md
│   ├── backend-architect.md
│   ├── devops-automator.md
│   ├── frontend-developer.md
│   ├── mobile-app-builder.md
│   ├── rapid-prototyper.md
│   └── test-writer-fixer.md
├── marketing/
│   ├── app-store-optimizer.md
│   ├── content-creator.md
│   ├── growth-hacker.md
│   ├── instagram-curator.md
│   ├── reddit-community-builder.md
│   ├── tiktok-strategist.md
│   └── twitter-engager.md
├── product/
│   ├── feedback-synthesizer.md
│   ├── sprint-prioritizer.md
│   └── trend-researcher.md
├── project-management/
│   ├── experiment-tracker.md
│   ├── project-shipper.md
│   └── studio-producer.md
├── studio-operations/
│   ├── analytics-reporter.md
│   ├── finance-tracker.md
│   ├── infrastructure-maintainer.md
│   ├── legal-compliance-checker.md
│   └── support-responder.md
├── testing/
│   ├── api-tester.md
│   ├── performance-benchmarker.md
│   ├── test-results-analyzer.md
│   ├── tool-evaluator.md
│   └── workflow-optimizer.md
└── bonus/
    ├── joker.md
    └── studio-coach.md
```

## 📋 完整代理清單

### 🔧 工程部門 (Engineering Department)

#### **ai-engineer** - AI 工程師
**專長：** 整合真正能交付的 AI/ML 功能
**適用場景：**
- 在應用程式中添加 AI 功能（聊天機器人、推薦系統）
- 整合語言模型和機器學習管道
- 實現計算機視覺功能（圖像識別、搜索）
- 構建智能自動化工具

#### **backend-architect** - 後端架構師
**專長：** 設計可擴展的 API 和伺服器系統
**適用場景：**
- 設計新的 API 和資料庫架構
- 優化資料庫查詢和效能
- 實現 OAuth2 登入和安全驗證
- 構建可擴展的後端服務

#### **devops-automator** - DevOps 自動化專家
**專長：** 持續部署而不破壞系統
**適用場景：**
- 設置 CI/CD 管道和自動化部署
- 實現自動擴展和負載平衡
- 建立監控和警報系統
- 基礎設施即代碼實施

#### **frontend-developer** - 前端開發工程師
**專長：** 構建超快速用戶界面
**適用場景：**
- 創建分析儀表板和互動圖表
- 修復響應式導航和移動端問題
- 優化應用程式載入效能
- 實現無障礙設計和用戶體驗

#### **mobile-app-builder** - 移動應用建構師
**專長：** 創建原生 iOS/Android 體驗
**適用場景：**
- 構建 TikTok 風格的視頻流應用
- 實現推送通知和生物識別認證
- 跨平台開發（React Native）
- 原生效能優化

#### **rapid-prototyper** - 快速原型師
**專長：** 在幾天內構建 MVP，而非幾週
**適用場景：**
- 創建新的應用程式原型和概念驗證
- 測試病毒式功能和趨勢概念
- 驗證商業想法的最小投資
- 為利益相關者演示創建demo

#### **test-writer-fixer** - 測試編寫修復專家
**專長：** 編寫能捕獲真實錯誤的測試
**適用場景：**
- 程式碼變更後編寫新測試
- 運行和分析測試失敗
- 重構後修復測試套件
- 為關鍵模組建立測試覆蓋

### 📊 產品部門 (Product Department)

#### **feedback-synthesizer** - 反饋綜合師
**專長：** 將抱怨轉化為功能
**適用場景：**
- 分析來自多個來源的用戶反饋
- 識別用戶投訴和請求中的模式
- 基於用戶輸入優先考慮功能開發
- 綜合評論和反饋洞察

#### **sprint-prioritizer** - 衝刺優先級管理師
**專長：** 在 6 天內交付最大價值
**適用場景：**
- 規劃 6 天開發週期和功能優先級
- 在緊湊時間線內做出權衡決策
- 管理範圍變更和衝刺重組
- 基於 ROI 分析進行決策

#### **trend-researcher** - 趨勢研究員
**專長：** 識別病毒式機會
**適用場景：**
- 基於當前趨勢尋找新應用創意
- 驗證產品概念的市場需求
- 競爭功能的市場影響分析
- 為現有應用找到病毒式機制

### 📈 行銷部門 (Marketing Department)

#### **app-store-optimizer** - 應用商店優化師
**專長：** 主導應用商店搜索結果
**適用場景：**
- 準備應用商店清單和關鍵詞研究
- 優化應用元數據和轉換率
- 分析應用商店效能和排名
- 最大化有機下載和可見性

#### **content-creator** - 內容創作者
**專長：** 跨所有平台生成內容
**適用場景：**
- 創建多平台營銷內容策略
- 生成社交媒體貼文和活動
- 開發品牌聲音和內容指南
- 創作吸引人的營銷材料

#### **growth-hacker** - 增長駭客
**專長：** 找到並利用病毒式增長迴路
**適用場景：**
- 識別和實施增長策略
- 分析用戶獲取和留存漏斗
- 實驗增長戰術和優化
- 開發病毒式營銷活動

#### **instagram-curator** - Instagram 策劃師
**專長：** 掌握視覺內容遊戲
**適用場景：**
- 開發Instagram內容策略和美學
- 創建視覺一致的品牌展現
- 分析Instagram趨勢和最佳實踐
- 優化參與度和粉絲增長

#### **reddit-community-builder** - Reddit 社群建設者
**專長：** 在不被禁止的情況下贏得 Reddit
**適用場景：**
- 建立和參與相關Reddit社群
- 創建有價值的內容和討論
- 管理社群關係和聲譽
- 利用Reddit進行產品推廣

#### **tiktok-strategist** - TikTok 策略師
**專長：** 創建可分享的營銷時刻
**適用場景：**
- 為新應用發布創建TikTok策略
- 開發病毒式內容創意和格式
- 識別創作者合作機會
- 優化應用功能以適合TikTok分享

#### **twitter-engager** - Twitter 參與專家
**專長：** 乘趨勢達到病毒式參與
**適用場景：**
- 開發Twitter內容策略和聲音
- 識別和利用trending話題
- 管理品牌Twitter存在和參與
- 創建viral tweets和營銷活動

### 🎨 設計部門 (Design Department)

#### **brand-guardian** - 品牌守護者
**專長：** 在各處保持視覺識別一致性
**適用場景：**
- 為新應用建立品牌指南
- 確保視覺一致性和品牌合規
- 管理品牌資產和設計系統
- 品牌識別演進和維護

#### **ui-designer** - UI 設計師
**專長：** 設計開發者能實際構建的界面
**適用場景：**
- 創建新的用戶界面和組件
- 構建設計系統和風格指南
- 改進視覺美學和用戶體驗
- 實現響應式和無障礙設計

#### **ux-researcher** - UX 研究員
**專長：** 將用戶洞察轉化為產品改進
**適用場景：**
- 了解新功能的用戶需求
- 進行可用性研究和用戶測試
- 創建用戶旅程地圖和人物誌
- 驗證設計決策和假設

#### **visual-storyteller** - 視覺故事講述者
**專長：** 創建能轉換和分享的視覺內容
**適用場景：**
- 創建應用入門插圖和視覺指南
- 設計信息圖表和數據可視化
- 構建演示文稿和營銷材料
- 開發視覺敘事和品牌故事

#### **whimsy-injector** - 趣味注入師
**專長：** 為每次互動添加樂趣
**適用場景：**
- UI/UX 變更後添加愉悦元素
- 轉換錯誤狀態為積極體驗
- 創建有趣的載入和等待狀態
- 為完成的功能添加驚喜元素

### 🎯 專案管理 (Project Management)

#### **experiment-tracker** - 實驗追蹤師
**專長：** 數據驅動的功能驗證
**適用場景：**
- 實施功能標誌和A/B測試
- 監控實驗效能和結果分析
- 追蹤實驗里程碑和決策點
- 基於數據做出產品決策

#### **project-shipper** - 專案交付師
**專長：** 發布不會崩潰的產品
**適用場景：**
- 準備重大功能發布和里程碑
- 協調發布流程和上市策略
- 管理多個發布和時程安排
- 監控發布後的指標和回應

#### **studio-producer** - 工作室製作人
**專長：** 保持團隊持續交付，而不是開會
**適用場景：**
- 協調多團隊協作和依賴關係
- 管理資源分配和衝突解決
- 優化工作流程和流程改進
- 規劃衝刺啟動和團隊協調

### 🏢 工作室營運 (Studio Operations)

#### **analytics-reporter** - 分析報告師
**專長：** 將數據轉化為可操作的洞察
**適用場景：**
- 月度績效回顧和分析
- 創建KPI儀表板和報告
- 識別趨勢和改進機會
- 數據驅動的決策支持

#### **finance-tracker** - 財務追蹤師
**專長：** 保持工作室盈利
**適用場景：**
- 規劃下季度開發預算
- 管理成本優化和預測
- 分析財務績效和ROI
- 預算規劃和資源分配

#### **infrastructure-maintainer** - 基礎設施維護師
**專長：** 在不破產的情況下擴展
**適用場景：**
- 監控系統健康和效能
- 管理擴展和容量規劃
- 確保基礎設施可靠性
- 優化成本和資源使用

#### **legal-compliance-checker** - 法律合規檢查師
**專長：** 在快速行動的同時保持合法
**適用場景：**
- 在歐洲市場發布應用
- 審查服務條款和隱私政策
- 確保監管合規和法律要求
- 處理法律風險和合規問題

#### **support-responder** - 支援回應師
**專長：** 將憤怒的用戶轉化為擁護者
**適用場景：**
- 為新應用發布設置支援
- 處理客戶支援查詢和問題
- 創建支援文檔和流程
- 分析支援模式和改進

### 🧪 測試部門 (Testing)

#### **api-tester** - API 測試師
**專長：** 確保 API 在壓力下正常工作
**適用場景：**
- 負載測試API效能和可靠性
- 驗證API規範和合約
- 測試API安全性和認證
- 自動化API測試和監控

#### **performance-benchmarker** - 效能基準測試師
**專長：** 讓一切變得更快
**適用場景：**
- 應用程式速度測試和優化
- 識別效能瓶頸和問題
- 建立效能基準和目標
- 監控和警報設置

#### **test-results-analyzer** - 測試結果分析師
**專長：** 在測試失敗中找到模式
**適用場景：**
- 分析測試套件結果和趨勢
- 識別測試失敗模式和根本原因
- 生成品質指標報告
- 測試數據綜合和洞察

#### **tool-evaluator** - 工具評估師
**專長：** 選擇真正有幫助的工具
**適用場景：**
- 考慮新的框架或函式庫
- 評估開發工具和平台
- 進行工具比較和建議
- 工具整合和採用策略

#### **workflow-optimizer** - 工作流程優化師
**專長：** 消除工作流程瓶頸
**適用場景：**
- 改善開發工作流程效率
- 優化人機協作和流程
- 分析工作流程瓶頸和問題
- 流程改進和自動化建議

## 🎁 獎勵代理 (Bonus Agents)

### **joker** - 幽默師
**專長：** 用技術幽默緩解氣氛
**適用場景：**
- 在壓力大的衝刺期間需要團隊士氣提升
- 創建有趣的錯誤訊息和404頁面
- 為應用添加幽默元素和個性
- 團隊建設和氣氛活躍

### **studio-coach** - 工作室教練
**專長：** 激勵 AI 團隊達到卓越
**適用場景：**
- 開始複雜的多代理任務時提供指導
- 當代理遇到困難或overwhelmed時提供支援
- 重大衝刺或倡議啟動前的團隊準備
- 慶祝勝利或從失敗中學習

## 🎯 主動式代理

某些代理會在特定情境下自動觸發：
- **studio-coach** - 當複雜的多代理任務開始或代理需要指導時
- **test-writer-fixer** - 在實施功能、修復錯誤或修改程式碼後
- **whimsy-injector** - 在 UI/UX 變更後
- **experiment-tracker** - 當添加功能標誌時

## 💡 最佳實踐

1. **讓代理協同工作** - 許多任務受益於多個代理的協作
2. **具體明確** - 清晰的任務描述有助於代理更好地執行
3. **信任專業知識** - 代理專為其特定領域而設計
4. **快速迭代** - 代理支持 6 天衝刺哲學

## 🔧 技術細節

### 代理結構
每個代理包含：
- **name**: 唯一識別符
- **description**: 何時使用代理的說明和範例
- **color**: 視覺識別
- **tools**: 代理可存取的特定工具
- **System prompt**: 詳細的專業知識和指令

### 添加新代理
1. 在適當的部門資料夾中建立新的 `.md` 檔案
2. 遵循現有格式與 YAML frontmatter
3. 包含 3-4 個詳細使用範例
4. 編寫全面的系統提示（500+ 字）
5. 使用真實任務測試代理

## 📊 代理效能

透過以下方式追蹤代理效能：
- 任務完成時間
- 用戶滿意度
- 錯誤率
- 功能採用率
- 開發速度

## 🚦 狀態

- ✅ **活躍**: 功能完整且經過測試
- 🚧 **即將推出**: 開發中
- 🧪 **測試版**: 功能有限的測試階段

## 🛠️ 為您的工作室自訂代理

### 代理自訂待辦清單

在為您的特定需求建立或修改代理時，請使用此檢查清單：

#### 📋 必需組件
- [ ] **YAML Frontmatter**
  - [ ] `name`: 唯一代理識別符（kebab-case）
  - [ ] `description`: 使用時機 + 3-4 個詳細範例（含情境/註釋）
  - [ ] `color`: 視覺識別（如：blue、green、purple、indigo）
  - [ ] `tools`: 代理可存取的特定工具（Write、Read、MultiEdit、Bash 等）

#### 📝 系統提示要求（500+ 字）
- [ ] **代理身份**: 清晰的角色定義和專業領域
- [ ] **核心職責**: 5-8 個特定的主要職責
- [ ] **領域專業知識**: 技術技能和知識領域
- [ ] **工作室整合**: 代理如何融入 6 天衝刺工作流程
- [ ] **最佳實踐**: 特定方法和方法論
- [ ] **限制**: 代理應該/不應該做什麼
- [ ] **成功指標**: 如何衡量代理效能

#### 🎯 按代理類型所需範例

**工程代理** 需要以下範例：
- [ ] 功能實施請求
- [ ] 錯誤修復場景
- [ ] 程式碼重構任務
- [ ] 架構決策

**設計代理** 需要以下範例：
- [ ] 新 UI 組件創建
- [ ] 設計系統工作
- [ ] 用戶體驗問題
- [ ] 視覺識別任務

**行銷代理** 需要以下範例：
- [ ] 活動創建請求
- [ ] 平台特定內容需求
- [ ] 增長機會識別
- [ ] 品牌定位任務

**產品代理** 需要以下範例：
- [ ] 功能優先級決策
- [ ] 用戶反饋分析
- [ ] 市場研究請求
- [ ] 戰略規劃需求

**營運代理** 需要以下範例：
- [ ] 流程優化
- [ ] 工具評估
- [ ] 資源管理
- [ ] 績效分析

#### ✅ 測試與驗證檢查清單
- [ ] **觸發測試**: 代理在預期用例中正確啟動
- [ ] **工具存取**: 代理能正確使用所有指定工具
- [ ] **輸出品質**: 回應有用且可操作
- [ ] **邊緣案例**: 代理能處理意外或複雜場景
- [ ] **整合**: 在多代理工作流程中與其他代理良好協作
- [ ] **效能**: 在合理時間內完成任務
- [ ] **文檔**: 範例準確反映真實使用模式

#### 🔧 代理檔案結構範本

```markdown
---
name: your-agent-name
description: Use this agent when [scenario]. This agent specializes in [expertise]. Examples:\n\n<example>\nContext: [situation]\nuser: "[user request]"\nassistant: "[response approach]"\n<commentary>\n[why this example matters]\n</commentary>\n</example>\n\n[3 more examples...]
color: agent-color
tools: Tool1, Tool2, Tool3
---

You are a [role] who [primary function]. Your expertise spans [domains]. You understand that in 6-day sprints, [sprint constraint], so you [approach].

Your primary responsibilities:
1. [Responsibility 1]
2. [Responsibility 2]
...

[Detailed system prompt content...]

Your goal is to [ultimate objective]. You [key behavior traits]. Remember: [key philosophy for 6-day sprints].
```

#### 📂 部門特定指南

**工程** (`engineering/`): 專注於實施速度、程式碼品質、測試
**設計** (`design/`): 強調用戶體驗、視覺一致性、快速迭代
**行銷** (`marketing/`): 針對病毒式潛力、平台專業知識、增長指標
**產品** (`product/`): 優先考慮用戶價值、數據驅動決策、市場適配
**營運** (`studio-operations/`): 優化流程、減少摩擦、擴展系統
**測試** (`testing/`): 確保品質、找出瓶頸、驗證效能
**專案管理** (`project-management/`): 協調團隊、按時交付、管理範圍

#### 🎨 自訂選項

根據您的需求修改這些元素：
- [ ] 調整範例以反映您的產品類型
- [ ] 添加代理可存取的特定工具
- [ ] 修改成功指標以符合您的 KPI
- [ ] 如需要，更新部門結構
- [ ] 為您的品牌自訂代理顏色

## 🤝 貢獻

要改進現有代理或建議新代理：
1. 使用上述自訂檢查清單
2. 用真實專案徹底測試
3. 記錄效能改進
4. 與社群分享成功模式

---

**版本：** 1.0.0  
**最後更新：** $(date '+%Y-%m-%d %H:%M:%S %Z')  
**安裝位置：** ~/.claude/agents/  
**總代理數：** 38 個專業代理

> 💡 **提示：** 使用 `./install-agents.sh` 腳本定期更新所有代理到最新版本。
