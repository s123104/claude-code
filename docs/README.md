# Claude Code 文件索引

> **目錄概覽**: 完整的 Claude Code 與 Cursor AI 整合說明書集合  
> **更新時間**: 2025-01-15T22:00:00+08:00  
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
```

---

## 🎯 常用旗標快查

| 動作     | 推薦旗標組合                   | 參考文件            |
| -------- | ------------------------------ | ------------------- |
| 建立專案 | `--create --template --mcp`    | superclaude + guide |
| 修復錯誤 | `--scan --fix --lint --test`   | awesome + monitor   |
| 部署上線 | `--build --deploy --monitor`   | guide + ui          |
| 效能調優 | `--profile --optimize --cache` | bplustree + monitor |
| 安全檢查 | `--security --audit --scan`    | monitor + awesome   |

---

## 📖 閱讀建議

### 按角色推薦

- **初學者**: guide → awesome → ui
- **開發者**: guide → superclaude → monitor
- **團隊領導**: monitor → awesome → ui
- **架構師**: bplustree → guide → superclaude

### 按任務推薦

- **新專案**: awesome → superclaude → guide
- **維護專案**: guide → monitor → bplustree
- **部署管理**: monitor → ui → guide
- **效能問題**: bplustree → monitor → guide

---

## 🔄 文件更新機制

- **主控文件**: cursor-claude-master-guide-zh-tw.md 會整合所有子文件的更新
- **版本同步**: 任一文件更新時會自動更新索引與交叉參考
- **旗標新增**: 新旗標會在主控文件中統一註冊與分類

---

**💡 提示**: 建議將 `cursor-claude-master-guide-zh-tw.md` 設為書籤，它包含所有其他文件的精華整合與快速查詢功能。
