# Claude Code 文件索引

> **目錄概覽**: 完整的 Claude Code 與 Cursor AI 整合說明書集合  
> **更新時間**: 2025-08-15T00:43:00+08:00  
> **文件語言**: 繁體中文

---

## 📚 文件清單

### 🎯 主要文件

| 文件名稱                                                                       | 核心功能         | 適用對象 | 快速連結 |
| ------------------------------------------------------------------------------ | ---------------- | -------- | -------- |
| **[cursor-claude-master-guide-zh-tw.md](cursor-claude-master-guide-zh-tw.md)** | 綜合代理主控手冊 | 所有用戶 | **必讀** |

### 🔧 功能專門文件

| 文件名稱                                                                 | 主要內容        | 關鍵旗標                           | 使用場景             |
| ------------------------------------------------------------------------ | --------------- | ---------------------------------- | -------------------- |
| [awesome-claude-code-zh-tw.md](awesome-claude-code-zh-tw.md)             | 社群最佳實踐    | `--hooks` `--workflow`             | 專案初始化、團隊協作 |
| [superclaude-zh-tw.md](superclaude-zh-tw.md)                             | 高階旗標系統    | `--persona` `--advanced`           | 複雜任務自動化       |
| [claude-code-guide-zh-tw.md](claude-code-guide-zh-tw.md)                 | 基礎 API 指南   | `--api` `--mcp` `--session`        | 日常開發、基礎操作   |
| [claude-code-usage-monitor-zh-tw.md](claude-code-usage-monitor-zh-tw.md) | 用量監控與安全  | `--monitor` `--limit` `--audit`    | 生產環境、成本控制   |
| [claudecodeui-zh-tw.md](claudecodeui-zh-tw.md)                           | Web UI 與視覺化 | `--ui` `--pwa` `--dashboard`       | 圖形介面、遠端管理   |
| [bplustree3-zh-tw.md](bplustree3-zh-tw.md)                               | 效能優化策略    | `--cache` `--optimize` `--profile` | 大型專案、效能調優   |
| [claude-code-security-review-zh-tw.md](claude-code-security-review-zh-tw.md) | 安全審查自動化  | `--security` `--audit` `--scan`    | 安全合規、漏洞檢測   |

---

## 🚀 快速開始

### 初次使用者

1. 閱讀 **[cursor-claude-master-guide-zh-tw.md](cursor-claude-master-guide-zh-tw.md)** - 了解整體架構
2. 參考 **[claude-code-guide-zh-tw.md](claude-code-guide-zh-tw.md)** - 學習基礎操作
3. 根據需求查閱其他專門文件

### 依使用場景快速導航

```yaml
專案建立: awesome-claude-code-zh-tw.md + superclaude-zh-tw.md
程式碼修復: claude-code-guide-zh-tw.md + awesome-claude-code-zh-tw.md
生產部署: claude-code-usage-monitor-zh-tw.md + claudecodeui-zh-tw.md
效能優化: bplustree3-zh-tw.md + claude-code-usage-monitor-zh-tw.md
團隊協作: awesome-claude-code-zh-tw.md + claudecodeui-zh-tw.md
安全審查: claude-code-security-review-zh-tw.md + claude-code-guide-zh-tw.md
```

---

## 🎯 常用旗標快查

| 動作     | 推薦旗標組合                   | 參考文件            |
| -------- | ------------------------------ | ------------------- |
| 建立專案 | `--create --template --mcp`    | superclaude + guide |
| 修復錯誤 | `--scan --fix --lint --test`   | awesome + monitor   |
| 部署上線 | `--build --deploy --monitor`   | guide + ui          |
| 效能調優 | `--profile --optimize --cache` | bplustree + monitor |
| 安全檢查 | `--security --audit --scan`    | security-review + awesome |

---

## 📖 閱讀建議

### 按角色推薦

- **初學者**: guide → awesome → ui
- **開發者**: guide → superclaude → monitor
- **團隊領導**: monitor → awesome → ui
- **架構師**: bplustree → guide → superclaude
- **安全工程師**: security-review → guide → monitor

### 按任務推薦

- **新專案**: awesome → superclaude → guide
- **維護專案**: guide → monitor → bplustree
- **部署管理**: monitor → ui → guide
- **效能問題**: bplustree → monitor → guide
- **安全審查**: security-review → guide → monitor

---

## 🐧 WSL 環境自動化安裝

本專案提供完整的 WSL 環境自動化安裝腳本 `wsl_claude_code_setup.sh`，支援：

### 功能特色

- **智能環境偵測**: 自動識別 Windows 與 WSL 環境
- **虛擬化檢查**: 檢查 Hyper-V、WSL 2、虛擬化狀態
- **依賴管理**: 自動安裝 Node.js、npm、必要工具
- **路徑修復**: 自動修復 .npmrc 污染和 Windows 路徑汙染
- **全域配置**: 設定 npm 全域安裝目錄和環境變數

### 使用方式

```bash
# 下載並執行安裝腳本
wget https://raw.githubusercontent.com/s123104/claude-code/master/start.sh
chmod +x start.sh
./start.sh
```

### 自動化檢查項目

- WSL 環境偵測與系統資訊
- 虛擬化功能啟用狀態
- Node.js 與 npm 版本檢查
- 路徑污染自動修復
- Claude Code CLI 全域安裝
- 常見問題自動診斷

---

## 🔄 文件更新機制

- **主控文件**: cursor-claude-master-guide-zh-tw.md 會整合所有子文件的更新
- **版本同步**: 任一文件更新時會自動更新索引與交叉參考
- **旗標新增**: 新旗標會在主控文件中統一註冊與分類

---

## 📊 文件統計資訊

| 項目         | 數量 | 說明                         |
| ------------ | ---- | ---------------------------- |
| 核心文件     | 8    | 專業功能文件                 |
| 支援旗標     | 50+  | 涵蓋所有常用操作             |
| 使用場景     | 20+  | 從入門到企業級應用           |
| 範例程式碼   | 100+ | 實用的指令與腳本範例         |
| 最佳實踐     | 30+  | 社群驗證的經驗分享           |
| 疑難排解     | 25+  | 常見問題與解決方案           |

---

## 🌟 特色功能

### 智能代理系統 (v2.0.0)

- **多模態分析**: 支援圖像、文檔、程式碼視覺化
- **深度學習意圖識別**: 自動解析模糊需求
- **實時協作優化**: 多用戶同步與衝突解決

### 企業級功能

- **用量監控**: 完整的 API 使用量追蹤
- **安全控制**: 權限管理與安全掃描
- **效能優化**: B+Tree 資料結構與快取策略
- **CI/CD 整合**: GitHub Actions 與自動化部署
- **安全審查**: AI 驅動的自動化安全漏洞檢測

### 開發者體驗

- **Web UI**: 直觀的網頁管理介面
- **PWA 支援**: 可安裝至桌面和行動裝置
- **Hooks 系統**: 靈活的生命週期事件處理
- **MCP 協作**: 多代理協作與擴展

---

**💡 提示**: 建議將 `cursor-claude-master-guide-zh-tw.md` 設為書籤，它包含所有其他文件的精華整合與快速查詢功能。

---

*最後更新：2025-08-15T00:43:00+08:00 | 維護者：s123104*