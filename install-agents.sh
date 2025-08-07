#!/bin/bash

# Claude Code Agents 一鍵安裝/更新腳本
# 版本: 1.0.0
# 作者: Claude Code 繁體中文文檔團隊
# 描述: 自動下載並安裝/更新所有 Contains Studio AI Agents

set -euo pipefail

# 顏色定義
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly NC='\033[0m' # No Color

# 配置變數
readonly GITHUB_REPO="https://github.com/contains-studio/agents.git"
readonly CLAUDE_AGENTS_DIR="$HOME/.claude/agents"
readonly TEMP_DIR="/tmp/claude-agents-install-$(date +%s)"
readonly LOG_FILE="/tmp/claude-agents-install.log"

# 函數: 輸出帶顏色的訊息
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}❌ $1${NC}" | tee -a "$LOG_FILE"
}

log_header() {
    echo -e "${PURPLE}${WHITE}🚀 $1${NC}" | tee -a "$LOG_FILE"
}

# 函數: 檢查系統需求
check_requirements() {
    log_info "檢查系統需求..."
    
    # 檢查 git
    if ! command -v git &> /dev/null; then
        log_error "Git 未安裝，請先安裝 Git"
        exit 1
    fi
    
    # 檢查 claude 命令
    if ! command -v claude &> /dev/null; then
        log_error "Claude Code 未安裝，請先安裝 Claude Code CLI"
        log_info "安裝指令: npm install -g @anthropic-ai/claude-code"
        exit 1
    fi
    
    log_success "系統需求檢查完成"
}

# 函數: 創建目錄結構
setup_directories() {
    log_info "設定目錄結構..."
    
    # 創建 Claude 配置目錄
    if [[ ! -d "$HOME/.claude" ]]; then
        mkdir -p "$HOME/.claude"
        log_success "已創建 ~/.claude 目錄"
    fi
    
    # 創建 agents 目錄
    if [[ ! -d "$CLAUDE_AGENTS_DIR" ]]; then
        mkdir -p "$CLAUDE_AGENTS_DIR"
        log_success "已創建 ~/.claude/agents 目錄"
    else
        log_info "agents 目錄已存在"
    fi
    
    # 創建臨時目錄
    mkdir -p "$TEMP_DIR"
    log_success "目錄結構設定完成"
}

# 函數: 下載最新的 agents
download_agents() {
    log_info "從 GitHub 下載最新的 agents..."
    
    cd "$TEMP_DIR"
    
    # 克隆倉庫
    if git clone "$GITHUB_REPO" agents-repo; then
        log_success "成功克隆 agents 倉庫"
    else
        log_error "無法從 GitHub 下載 agents，請檢查網路連接"
        cleanup_and_exit 1
    fi
    
    cd agents-repo
    log_info "當前版本: $(git log -1 --pretty=format:'%h - %s (%cr)')"
}

# 函數: 備份現有 agents
backup_existing_agents() {
    if [[ -d "$CLAUDE_AGENTS_DIR" ]] && [[ "$(ls -A "$CLAUDE_AGENTS_DIR" 2>/dev/null)" ]]; then
        local backup_dir="$HOME/.claude/agents-backup-$(date +%Y%m%d_%H%M%S)"
        log_info "備份現有 agents 到 $backup_dir"
        
        cp -r "$CLAUDE_AGENTS_DIR" "$backup_dir"
        log_success "已備份現有 agents"
    else
        log_info "無現有 agents 需要備份"
    fi
}

# 函數: 安裝/更新 agents
install_agents() {
    log_info "安裝/更新 agents..."
    
    cd "$TEMP_DIR/agents-repo"
    
    # 統計 agents 數量
    local total_agents=0
    local installed_agents=0
    
    # 遍歷所有部門目錄
    for dept_dir in */; do
        if [[ -d "$dept_dir" ]]; then
            dept_name=$(basename "$dept_dir")
            log_info "處理部門: $dept_name"
            
            # 創建部門目錄
            mkdir -p "$CLAUDE_AGENTS_DIR/$dept_name"
            
            # 複製該部門的所有 .md 檔案
            for agent_file in "$dept_dir"*.md; do
                if [[ -f "$agent_file" ]]; then
                    agent_name=$(basename "$agent_file" .md)
                    cp "$agent_file" "$CLAUDE_AGENTS_DIR/$dept_name/"
                    log_success "已安裝: $dept_name/$agent_name"
                    ((installed_agents++))
                    ((total_agents++))
                fi
            done
        fi
    done
    
    log_success "總共安裝/更新了 $installed_agents 個 agents"
}

# 函數: 生成繁體中文版 README.md
generate_readme() {
    log_info "生成繁體中文版 README.md..."
    
    cat > "$CLAUDE_AGENTS_DIR/README.md" << 'EOF'
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
├── design/ (設計部門)
├── engineering/ (工程部門)  
├── marketing/ (行銷部門)
├── product/ (產品部門)
├── project-management/ (專案管理)
├── studio-operations/ (工作室營運)
├── testing/ (測試部門)
└── bonus/ (獎勵代理)
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

**核心能力：**
- 實用的 AI 實現，專注於快速部署
- LLM 整合，具備適當的提示工程
- 推薦引擎和個性化系統
- 計算機視覺和圖像處理

#### **backend-architect** - 後端架構師
**專長：** 設計可擴展的 API 和伺服器系統
**適用場景：**
- 設計新的 API 和資料庫架構
- 優化資料庫查詢和效能
- 實現 OAuth2 登入和安全驗證
- 構建可擴展的後端服務

**核心能力：**
- RESTful API 設計和 GraphQL 實現
- 資料庫設計和優化策略
- 微服務架構和容器化部署
- 安全性和身份驗證系統

#### **devops-automator** - DevOps 自動化專家
**專長：** 持續部署而不破壞系統
**適用場景：**
- 設置 CI/CD 管道和自動化部署
- 實現自動擴展和負載平衡
- 建立監控和警報系統
- 基礎設施即代碼實施

**核心能力：**
- 自動化部署和測試流程
- 雲基礎設施配置和管理
- 容器編排和服務網格
- 監控、日誌和可觀察性

#### **frontend-developer** - 前端開發工程師
**專長：** 構建超快速用戶界面
**適用場景：**
- 創建分析儀表板和互動圖表
- 修復響應式導航和移動端問題
- 優化應用程式載入效能
- 實現無障礙設計和用戶體驗

**核心能力：**
- React/Vue/Angular 組件開發
- 響應式設計和移動優先開發
- 效能優化和程式碼分割
- 無障礙性和用戶體驗設計

#### **mobile-app-builder** - 移動應用建構師
**專長：** 創建原生 iOS/Android 體驗
**適用場景：**
- 構建 TikTok 風格的視頻流應用
- 實現推送通知和生物識別認證
- 跨平台開發（React Native）
- 原生效能優化

**核心能力：**
- React Native 和原生開發
- 平台特定功能整合
- 效能優化和記憶體管理
- 應用商店發布和優化

#### **rapid-prototyper** - 快速原型師
**專長：** 在幾天內構建 MVP，而非幾週
**適用場景：**
- 創建新的應用程式原型和概念驗證
- 測試病毒式功能和趨勢概念
- 驗證商業想法的最小投資
- 為利益相關者演示創建demo

**核心能力：**
- 快速專案腳手架和設置
- 整合趨勢功能和現代設計
- 最小可行產品開發
- 原型到生產的快速迭代

#### **test-writer-fixer** - 測試編寫修復專家
**專長：** 編寫能捕獲真實錯誤的測試
**適用場景：**
- 程式碼變更後編寫新測試
- 運行和分析測試失敗
- 重構後修復測試套件
- 為關鍵模組建立測試覆蓋

**核心能力：**
- 全面的測試策略和實施
- 自動化測試和持續整合
- 測試維護和套件健康
- 程式碼覆蓋分析和改進

### 📊 產品部門 (Product Department)

#### **feedback-synthesizer** - 反饋綜合師
**專長：** 將抱怨轉化為功能
**適用場景：**
- 分析來自多個來源的用戶反饋
- 識別用戶投訴和請求中的模式
- 基於用戶輸入優先考慮功能開發
- 綜合評論和反饋洞察

**核心能力：**
- 多來源反饋分析和模式識別
- 用戶情感分析和洞察提取
- 功能需求優先級排序
- 可操作的產品改進建議

#### **sprint-prioritizer** - 衝刺優先級管理師
**專長：** 在 6 天內交付最大價值
**適用場景：**
- 規劃 6 天開發週期和功能優先級
- 在緊湊時間線內做出權衡決策
- 管理範圍變更和衝刺重組
- 基於 ROI 分析進行決策

**核心能力：**
- 敏捷衝刺規劃和管理
- 功能價值評估和優先級排序
- 資源分配和時間管理
- 風險評估和範圍管理

#### **trend-researcher** - 趨勢研究員
**專長：** 識別病毒式機會
**適用場景：**
- 基於當前趨勢尋找新應用創意
- 驗證產品概念的市場需求
- 競爭功能的市場影響分析
- 為現有應用找到病毒式機制

**核心能力：**
- 市場機會識別和趨勢分析
- 社交媒體和病毒內容研究
- 競爭分析和市場驗證
- 產品機會評估和建議

### 🎨 設計部門 (Design Department)

#### **brand-guardian** - 品牌守護者
**專長：** 在各處保持視覺識別一致性
**適用場景：**
- 為新應用建立品牌指南
- 確保視覺一致性和品牌合規
- 管理品牌資產和設計系統
- 品牌識別演進和維護

**核心能力：**
- 品牌策略和視覺識別系統
- 設計系統管理和維護
- 品牌合規和一致性保證
- 品牌資產管理和優化

#### **ui-designer** - UI 設計師
**專長：** 設計開發者能實際構建的界面
**適用場景：**
- 創建新的用戶界面和組件
- 構建設計系統和風格指南
- 改進視覺美學和用戶體驗
- 實現響應式和無障礙設計

**核心能力：**
- 用戶界面設計和原型製作
- 設計系統創建和維護
- 響應式設計和移動端優化
- 可用性和用戶體驗設計

#### **ux-researcher** - UX 研究員
**專長：** 將用戶洞察轉化為產品改進
**適用場景：**
- 了解新功能的用戶需求
- 進行可用性研究和用戶測試
- 創建用戶旅程地圖和人物誌
- 驗證設計決策和假設

**核心能力：**
- 用戶研究方法和數據分析
- 用戶旅程映射和體驗設計
- 可用性測試和行為分析
- 設計驗證和迭代改進

#### **visual-storyteller** - 視覺故事講述者
**專長：** 創建能轉換和分享的視覺內容
**適用場景：**
- 創建應用入門插圖和視覺指南
- 設計信息圖表和數據可視化
- 構建演示文稿和營銷材料
- 開發視覺敘事和品牌故事

**核心能力：**
- 視覺敘事和內容創作
- 信息圖表和數據可視化
- 品牌視覺和營銷材料設計
- 多媒體內容創作和優化

#### **whimsy-injector** - 趣味注入師
**專長：** 為每次互動添加樂趣
**適用場景：**
- UI/UX 變更後添加愉悦元素
- 轉換錯誤狀態為積極體驗
- 創建有趣的載入和等待狀態
- 為完成的功能添加驚喜元素

**核心能力：**
- 微互動設計和動畫效果
- 用戶體驗優化和情感設計
- 創意內容和驚喜元素
- 品牌個性和用戶參與

### 📈 行銷部門 (Marketing Department)

#### **app-store-optimizer** - 應用商店優化師
**專長：** 主導應用商店搜索結果
**適用場景：**
- 準備應用商店清單和關鍵詞研究
- 優化應用元數據和轉換率
- 分析應用商店效能和排名
- 最大化有機下載和可見性

**核心能力：**
- ASO策略和關鍵詞優化
- 應用商店清單優化和A/B測試
- 競爭分析和市場研究
- 轉換率優化和用戶獲取

#### **content-creator** - 內容創作者
**專長：** 跨所有平台生成內容
**適用場景：**
- 創建多平台營銷內容策略
- 生成社交媒體貼文和活動
- 開發品牌聲音和內容指南
- 創作吸引人的營銷材料

**核心能力：**
- 多平台內容策略和創作
- 品牌聲音發展和維護
- 社交媒體營銷和參與
- 內容日程安排和優化

#### **growth-hacker** - 增長駭客
**專長：** 找到並利用病毒式增長迴路
**適用場景：**
- 識別和實施增長策略
- 分析用戶獲取和留存漏斗
- 實驗增長戰術和優化
- 開發病毒式營銷活動

**核心能力：**
- 增長戰略和實驗設計
- 數據分析和轉換優化
- 用戶獲取和留存策略
- 病毒式營銷和推薦系統

#### **instagram-curator** - Instagram 策劃師
**專長：** 掌握視覺內容遊戲
**適用場景：**
- 開發Instagram內容策略和美學
- 創建視覺一致的品牌展現
- 分析Instagram趨勢和最佳實踐
- 優化參與度和粉絲增長

**核心能力：**
- Instagram策略和內容規劃
- 視覺品牌和美學發展
- 社群參與和影響者合作
- Instagram分析和優化

#### **reddit-community-builder** - Reddit 社群建設者
**專長：** 在不被禁止的情況下贏得 Reddit
**適用場景：**
- 建立和參與相關Reddit社群
- 創建有價值的內容和討論
- 管理社群關係和聲譽
- 利用Reddit進行產品推廣

**核心能力：**
- Reddit社群策略和參與
- 內容創作和討論管理
- 社群建設和關係維護
- Reddit營銷和品牌建設

#### **tiktok-strategist** - TikTok 策略師
**專長：** 創建可分享的營銷時刻
**適用場景：**
- 為新應用發布創建TikTok策略
- 開發病毒式內容創意和格式
- 識別創作者合作機會
- 優化應用功能以適合TikTok分享

**核心能力：**
- TikTok內容策略和趨勢分析
- 病毒式內容創作和優化
- 影響者合作和夥伴關係
- TikTok算法優化和增長

#### **twitter-engager** - Twitter 參與專家
**專長：** 乘趨勢達到病毒式參與
**適用場景：**
- 開發Twitter內容策略和聲音
- 識別和利用trending話題
- 管理品牌Twitter存在和參與
- 創建viral tweets和營銷活動

**核心能力：**
- Twitter策略和內容創作
- 趨勢分析和實時營銷
- 社群管理和客戶服務
- Twitter分析和優化

### 🎯 專案管理 (Project Management)

#### **experiment-tracker** - 實驗追蹤師
**專長：** 數據驅動的功能驗證
**適用場景：**
- 實施功能標誌和A/B測試
- 監控實驗效能和結果分析
- 追蹤實驗里程碑和決策點
- 基於數據做出產品決策

**核心能力：**
- 實驗設計和A/B測試
- 數據收集和分析
- 功能標誌管理
- 產品決策支持

#### **project-shipper** - 專案交付師
**專長：** 發布不會崩潰的產品
**適用場景：**
- 準備重大功能發布和里程碑
- 協調發布流程和上市策略
- 管理多個發布和時程安排
- 監控發布後的指標和回應

**核心能力：**
- 發布管理和協調
- 上市策略和執行
- 跨團隊協作和溝通
- 發布後監控和支援

#### **studio-producer** - 工作室製作人
**專長：** 保持團隊持續交付，而不是開會
**適用場景：**
- 協調多團隊協作和依賴關係
- 管理資源分配和衝突解決
- 優化工作流程和流程改進
- 規劃衝刺啟動和團隊協調

**核心能力：**
- 跨功能團隊協調
- 資源管理和優化
- 流程改進和效率提升
- 團隊領導和動機

### 🏢 工作室營運 (Studio Operations)

#### **analytics-reporter** - 分析報告師
**專長：** 將數據轉化為可操作的洞察
**適用場景：**
- 月度績效回顧和分析
- 創建KPI儀表板和報告
- 識別趨勢和改進機會
- 數據驅動的決策支持

**核心能力：**
- 數據分析和可視化
- KPI追蹤和報告
- 商業智能和洞察
- 預測分析和建議

#### **finance-tracker** - 財務追蹤師
**專長：** 保持工作室盈利
**適用場景：**
- 規劃下季度開發預算
- 管理成本優化和預測
- 分析財務績效和ROI
- 預算規劃和資源分配

**核心能力：**
- 財務規劃和預算管理
- 成本分析和優化
- 收入預測和建模
- 財務報告和分析

#### **infrastructure-maintainer** - 基礎設施維護師
**專長：** 在不破產的情況下擴展
**適用場景：**
- 監控系統健康和效能
- 管理擴展和容量規劃
- 確保基礎設施可靠性
- 優化成本和資源使用

**核心能力：**
- 基礎設施監控和維護
- 容量規劃和擴展
- 成本優化和資源管理
- 可靠性和災難恢復

#### **legal-compliance-checker** - 法律合規檢查師
**專長：** 在快速行動的同時保持合法
**適用場景：**
- 在歐洲市場發布應用
- 審查服務條款和隱私政策
- 確保監管合規和法律要求
- 處理法律風險和合規問題

**核心能力：**
- 法律合規和監管要求
- 隱私政策和數據保護
- 風險評估和緩解
- 合約審查和談判

#### **support-responder** - 支援回應師
**專長：** 將憤怒的用戶轉化為擁護者
**適用場景：**
- 為新應用發布設置支援
- 處理客戶支援查詢和問題
- 創建支援文檔和流程
- 分析支援模式和改進

**核心能力：**
- 客戶支援策略和流程
- 問題解決和用戶滿意度
- 支援文檔和知識庫
- 支援分析和改進

### 🧪 測試部門 (Testing)

#### **api-tester** - API 測試師
**專長：** 確保 API 在壓力下正常工作
**適用場景：**
- 負載測試API效能和可靠性
- 驗證API規範和合約
- 測試API安全性和認證
- 自動化API測試和監控

**核心能力：**
- API測試策略和自動化
- 效能測試和負載測試
- API文檔和規範驗證
- 安全測試和漏洞評估

#### **performance-benchmarker** - 效能基準測試師
**專長：** 讓一切變得更快
**適用場景：**
- 應用程式速度測試和優化
- 識別效能瓶頸和問題
- 建立效能基準和目標
- 監控和警報設置

**核心能力：**
- 效能測試和基準測試
- 瓶頸識別和優化建議
- 監控和警報系統
- 效能分析和報告

#### **test-results-analyzer** - 測試結果分析師
**專長：** 在測試失敗中找到模式
**適用場景：**
- 分析測試套件結果和趨勢
- 識別測試失敗模式和根本原因
- 生成品質指標報告
- 測試數據綜合和洞察

**核心能力：**
- 測試數據分析和報告
- 品質指標追蹤和趨勢分析
- 根本原因分析和改進建議
- 測試策略優化和建議

#### **tool-evaluator** - 工具評估師
**專長：** 選擇真正有幫助的工具
**適用場景：**
- 考慮新的框架或函式庫
- 評估開發工具和平台
- 進行工具比較和建議
- 工具整合和採用策略

**核心能力：**
- 工具評估和比較分析
- 技術決策支援和建議
- 工具整合和採用計劃
- ROI分析和風險評估

#### **workflow-optimizer** - 工作流程優化師
**專長：** 消除工作流程瓶頸
**適用場景：**
- 改善開發工作流程效率
- 優化人機協作和流程
- 分析工作流程瓶頸和問題
- 流程改進和自動化建議

**核心能力：**
- 工作流程分析和優化
- 流程改進和自動化
- 效率提升和瓶頸消除
- 團隊協作和溝通優化

## 🎁 獎勵代理 (Bonus Agents)

### **joker** - 幽默師
**專長：** 用技術幽默緩解氣氛
**適用場景：**
- 在壓力大的衝刺期間需要團隊士氣提升
- 創建有趣的錯誤訊息和404頁面
- 為應用添加幽默元素和個性
- 團隊建設和氣氛活躍

**核心能力：**
- 程式設計幽默和技術笑話
- 創意內容創作和娛樂
- 團隊士氣提升和氣氛活躍
- 品牌個性和用戶參與

### **studio-coach** - 工作室教練
**專長：** 激勵 AI 團隊達到卓越
**適用場景：**
- 開始複雜的多代理任務時提供指導
- 當代理遇到困難或overwhelmed時提供支援
- 重大衝刺或倡議啟動前的團隊準備
- 慶祝勝利或從失敗中學習

**核心能力：**
- 多代理協調和領導
- 績效優化和卓越追求
- 團隊動機和士氣管理
- 策略指導和決策支援

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
EOF

    log_success "已生成繁體中文版 README.md"
}

# 函數: 驗證安裝
verify_installation() {
    log_info "驗證安裝..."
    
    # 檢查 agents 目錄
    if [[ ! -d "$CLAUDE_AGENTS_DIR" ]]; then
        log_error "agents 目錄不存在"
        return 1
    fi
    
    # 統計安裝的 agents
    local total_agents=0
    for dept_dir in "$CLAUDE_AGENTS_DIR"/*/; do
        if [[ -d "$dept_dir" ]]; then
            local dept_count=$(find "$dept_dir" -name "*.md" | wc -l)
            total_agents=$((total_agents + dept_count))
        fi
    done
    
    if [[ $total_agents -eq 0 ]]; then
        log_error "沒有找到任何已安裝的 agents"
        return 1
    fi
    
    log_success "驗證完成：共發現 $total_agents 個已安裝的 agents"
    
    # 顯示部門結構
    log_info "部門結構："
    for dept_dir in "$CLAUDE_AGENTS_DIR"/*/; do
        if [[ -d "$dept_dir" ]]; then
            local dept_name=$(basename "$dept_dir")
            local dept_count=$(find "$dept_dir" -name "*.md" | wc -l)
            echo -e "  ${CYAN}$dept_name${NC}: $dept_count 個 agents" | tee -a "$LOG_FILE"
        fi
    done
}

# 函數: 清理並退出
cleanup_and_exit() {
    local exit_code=${1:-0}
    
    log_info "清理臨時檔案..."
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
        log_success "已清理臨時目錄"
    fi
    
    if [[ $exit_code -eq 0 ]]; then
        log_success "所有 agents 安裝/更新完成！"
        log_info "重啟 Claude Code 以使用新的 agents"
        log_info "日誌檔案: $LOG_FILE"
    else
        log_error "安裝過程中出現錯誤，請檢查日誌: $LOG_FILE"
    fi
    
    exit $exit_code
}

# 函數: 顯示使用說明
show_usage() {
    echo -e "${WHITE}Claude Code Agents 一鍵安裝/更新腳本${NC}"
    echo
    echo -e "${YELLOW}用法:${NC}"
    echo "  $0 [選項]"
    echo
    echo -e "${YELLOW}選項:${NC}"
    echo "  -h, --help     顯示此幫助訊息"
    echo "  -v, --verbose  詳細輸出模式"
    echo "  -f, --force    強制重新安裝（覆蓋現有 agents）"
    echo "  --no-backup    不備份現有 agents"
    echo
    echo -e "${YELLOW}範例:${NC}"
    echo "  $0              # 標準安裝/更新"
    echo "  $0 -v           # 詳細模式"
    echo "  $0 -f           # 強制重新安裝"
}

# 主函數
main() {
    local verbose=false
    local force=false
    local no_backup=false
    
    # 解析命令行參數
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -f|--force)
                force=true
                shift
                ;;
            --no-backup)
                no_backup=true
                shift
                ;;
            *)
                log_error "未知選項: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # 啟動安裝流程
    log_header "Claude Code Agents 一鍵安裝/更新腳本"
    echo "開始時間: $(date)" | tee "$LOG_FILE"
    
    # 設置錯誤處理
    trap 'cleanup_and_exit 1' ERR INT TERM
    
    # 執行安裝步驟
    check_requirements
    setup_directories
    
    if [[ "$no_backup" != true ]]; then
        backup_existing_agents
    fi
    
    download_agents
    install_agents
    generate_readme
    verify_installation
    
    # 成功完成
    cleanup_and_exit 0
}

# 如果直接執行此腳本，則運行主函數
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi