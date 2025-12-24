# index.html UI/UX 重構自動化分析報告

> **生成時間**: 2025-12-25T01:33:39+08:00  
> **專案版本**: v5.1.0  
> **Claude Code 版本**: v2.0.75  
> **技術棧**: Tailwind CSS v3.x (CDN)

---

## 1. 分析摘要

### 1.1 過去對話需求萃取

| 需求分類 | 關鍵需求 | 優先級 |
|----------|----------|--------|
| **架構重構** | SSOT 百科全書式架構 | ✅ 已完成 |
| **版本同步** | 統一版本資訊至 `config/metadata.json` | ✅ 已完成 |
| **PRD 文檔** | 建立 index.html 功能規格書 | ✅ 已完成 |
| **UI/UX 重構** | 進行全面的使用者介面重構 | 🔴 待執行 |
| **資料過時** | index.html 顯示舊版本資訊 | 🔴 待修正 |

### 1.2 專案現況掃描結果

**檔案狀態**:
- `index.html`: 4,801 行 / 208KB
- 最後內容更新: 2025-11-25 (過時)
- Git 狀態: 已修改

**版本不一致問題**:

| 項目 | index.html 顯示 | SSOT 實際值 | 狀態 |
|------|-----------------|-------------|------|
| 專案版本 | v5.0.0 | v5.1.0 | ❌ 不一致 |
| Claude Code 版本 | v2.0.27 | v2.0.75 | ❌ 不一致 |
| 專案數量 | 20 個 | 14 個活躍 | ❌ 不一致 |
| 最後更新 | 2025-11-25 | 2025-12-25 | ❌ 不一致 |

**架構問題**:
1. 硬編碼版本資訊，未從 `metadata.json` 讀取
2. 專案卡片數量與 SSOT 不符
3. 部分已歸檔專案仍在展示
4. 缺少動態版本注入機制

---

## 2. 最佳實踐優化方案

### 2.1 Tailwind CSS 最佳實踐 [context7:/websites/v3_tailwindcss]

| 實踐項目 | 當前狀態 | 建議調整 |
|----------|----------|----------|
| Mobile-first 設計 | ✅ 已採用 | 維持 |
| Viewport Meta | ✅ 已設定 | 維持 |
| 響應式斷點使用 | ✅ sm/md/lg/xl | 維持 |
| motion-reduce 支援 | ❌ 未實作 | **建議新增** |
| dark mode | ❌ 未實作 | 可選 |

### 2.2 動畫與互動最佳實踐 [context7:/tailwindlabs/tailwindcss.com]

```html
<!-- 建議採用的按鈕動畫模式 -->
<button class="transition delay-150 duration-300 ease-in-out 
               hover:-translate-y-1 hover:scale-110 
               motion-reduce:transition-none motion-reduce:hover:translate-y-0">
  Save Changes
</button>
```

**建議優化**:
1. 所有動畫元素添加 `motion-reduce:*` 變體
2. 載入動畫添加 `motion-reduce:hidden` 選項
3. Logo 字母動畫考慮 `motion-safe:*` 條件

### 2.3 SSOT 整合建議

**當前問題**: 版本資訊硬編碼於 HTML

**解決方案**: 建立建置時注入機制

```javascript
// scripts/inject-ssot-to-html.js
const metadata = require('../config/metadata.json');
// 替換 HTML 中的版本佔位符
```

---

## 3. 專案步驟清單（完成度標註）

### 3.1 已完成項目 ✅

| # | 項目 | 完成時間 |
|---|------|----------|
| 1 | SSOT 架構建立 | 2025-12-25 |
| 2 | metadata.json 創建 | 2025-12-25 |
| 3 | 14 個活躍專案確認 | 2025-12-25 |
| 4 | 5 個歸檔專案處理 | 2025-12-25 |
| 5 | PRD 規格書建立 | 2025-12-25 |
| 6 | read-metadata.js 工具 | 2025-12-25 |

### 3.2 待執行項目 ⏳

| # | 項目 | 狀態 | 預估時間 |
|---|------|------|----------|
| 1 | 同步 index.html 版本資訊 | ✅ 已完成 | 15 分鐘 |
| 2 | 更新專案卡片數量 (20→17) | ✅ 已完成 | 20 分鐘 |
| 3 | 確認專案卡片 (無需移除) | ✅ 已完成 | 10 分鐘 |
| 4 | 新增 motion-reduce 支援 | ✅ 已完成 | 15 分鐘 |
| 5 | 建立版本注入腳本 | 可選 (P3) | 30 分鐘 |

---

## 4. To-Do List（優先級排序）

### 🔴 P0 - 緊急（版本一致性）

| ID | 任務 | 負責人 | 預估時間 | 驗收標準 |
|----|------|--------|----------|----------|
| T01 | 更新 meta 標籤版本資訊 | @developer | 5 min | meta 顯示 v2.0.75 |
| T02 | 更新安裝區版本顯示 | @developer | 5 min | 顯示 v5.1.0 |
| T03 | 更新 Footer 版本與日期 | @developer | 5 min | 顯示 2025-12-25 |
| T04 | 更新文檔統計數字 | @developer | 5 min | 顯示 14 個專案 |

### 🟠 P1 - 高優先（內容對齊）

| ID | 任務 | 負責人 | 預估時間 | 驗收標準 |
|----|------|--------|----------|----------|
| T05 | 調整篩選標籤數量 | @developer | 10 min | 分類數量與實際對應 |
| T06 | 移除 6 個已歸檔專案卡片 | @developer | 15 min | 僅顯示 14 個活躍專案 |
| T07 | 更新核心文檔區塊 | @developer | 10 min | 連結與描述正確 |

### 🟡 P2 - 中優先（體驗優化）

| ID | 任務 | 負責人 | 預估時間 | 驗收標準 |
|----|------|--------|----------|----------|
| T08 | 新增 motion-reduce 支援 | @developer | 15 min | 動畫可被系統設定禁用 |
| T09 | 優化載入動畫 accessibility | @developer | 10 min | 通過 a11y 檢測 |
| T10 | 更新官方功能介紹專區 | @developer | 10 min | 版本與功能說明對齊 |

### 🟢 P3 - 低優先（技術債務）

| ID | 任務 | 負責人 | 預估時間 | 驗收標準 |
|----|------|--------|----------|----------|
| T11 | 建立 SSOT 注入腳本 | @developer | 30 min | 可從 metadata.json 自動更新 HTML |
| T12 | 清理未使用的 CSS 動畫 | @developer | 20 min | 移除冗餘定義 |
| T13 | 優化 JavaScript 函數 | @developer | 30 min | 模組化、減少全域變數 |

---

## 5. 子功能規格（P0/P1 任務）

### 5.1 T01-T04: 版本資訊同步

**目標**: 將 index.html 所有版本資訊與 SSOT 對齊

**變更位置與內容**:

| 行數範圍 | 舊值 | 新值 |
|----------|------|------|
| Line 8 | `2025-11-25` | `2025-12-25` |
| Line 8 | `20 個專案` | `14 個專案` |
| Line 8, 12, 1646, 2589 | `v2.0.27` | `v2.0.75` |
| Line 1338, 2703, 3405 | `v5.0.0` | `v5.1.0` |
| Line 1338, 3405 | `20 個專案文檔` | `14 個專案文檔` |

**驗收標準**:
- [ ] 所有 `v2.0.27` → `v2.0.75`
- [ ] 所有 `v5.0.0` → `v5.1.0`
- [ ] 所有 `2025-11-25` → `2025-12-25`
- [ ] 所有 `20 個專案` → `14 個專案`

### 5.2 T05: 篩選標籤調整

**當前狀態**:
```html
<button data-filter="all">全部項目 (20)</button>
<button data-filter="core">核心文檔 (3)</button>
<!-- ... -->
```

**目標狀態** (基於 metadata.json 分類):
```html
<button data-filter="all">全部項目 (14)</button>
<button data-filter="core">核心文檔 (2)</button>
<button data-filter="framework">增強框架 (2)</button>
<button data-filter="agents">AI 代理 (2)</button>
<button data-filter="monitoring">監控分析 (1)</button>
<button data-filter="interface">介面工具 (3)</button>
<button data-filter="performance">效能優化 (1)</button>
<button data-filter="security">安全審查 (1)</button>
<button data-filter="guides">指南教學 (2)</button>
<button data-filter="tools">專業工具 (2)</button>
```

### 5.3 T06: 移除歸檔專案卡片

**需移除的專案** (基於 metadata.json archivedProjects):
1. `claude-agents` - 已被 agents-zh-tw.md 取代
2. `claude-code-hooks` - 已有官方文檔
3. `claude-code-usage-monitor` - 已被 ccusage 取代
4. `claudecode-debugger` - 已無維護
5. `claude-code-leaderboard` - 已無維護
6. 其他過時專案

**額外需檢查**:
- cursor-claude-master-guide 是否仍適用（這是整合手冊，應保留）

### 5.4 T08: motion-reduce 支援

**需修改的動畫元素**:

```html
<!-- 載入動畫 -->
<div class="loading-spinner motion-reduce:hidden">

<!-- Logo 動畫 -->
<span class="animate-ping motion-reduce:hidden">

<!-- Hover 效果 -->
<button class="transition motion-reduce:transition-none 
               hover:scale-105 motion-reduce:hover:scale-100">
```

---

## 6. 當前進度實作（立即執行）

### 6.1 版本資訊同步腳本

以下為立即可執行的變更：

**變更摘要**:
- 更新 8 處版本資訊
- 更新 4 處日期資訊
- 更新 4 處專案數量

### 6.2 執行指令

```bash
# 使用 sed 批次替換（macOS 相容）
cd /Users/azlife.eth/claude-code

# 1. 替換 Claude Code 版本
sed -i '' 's/v2\.0\.27/v2.0.75/g' index.html

# 2. 替換專案版本
sed -i '' 's/v5\.0\.0/v5.1.0/g' index.html

# 3. 替換日期
sed -i '' 's/2025-11-25/2025-12-25/g' index.html

# 4. 替換專案數量
sed -i '' 's/20 個專案/14 個專案/g' index.html
sed -i '' 's/20個專案/14個專案/g' index.html

# 驗證變更
grep -n "v2.0.75\|v5.1.0\|2025-12-25\|14 個專案" index.html
```

---

## 7. 驗證檢查清單

### 7.1 版本一致性驗證

```bash
# 驗證 SSOT 與 index.html 版本一致
node scripts/read-metadata.js --project-version  # 應輸出 5.1.0
node scripts/read-metadata.js --claude-version   # 應輸出 2.0.75
node scripts/read-metadata.js --active-projects  # 應輸出 14
```

### 7.2 功能完整性驗證

- [ ] 載入動畫正常顯示與隱藏
- [ ] 導覽列連結正確跳轉
- [ ] 行動版選單正常展開/收合
- [ ] 篩選功能正確篩選專案
- [ ] 搜尋功能正常運作
- [ ] 複製功能正常執行
- [ ] 彩蛋功能正常觸發

### 7.3 可存取性驗證

- [ ] Lighthouse Accessibility 分數 ≥ 90
- [ ] motion-reduce 設定生效
- [ ] 鍵盤導覽可用

---

## 附錄：相關文檔連結

| 文檔 | 路徑 | 用途 |
|------|------|------|
| PRD 規格書 | `docs/index-html-prd.md` | 功能需求基準 |
| SSOT 配置 | `config/metadata.json` | 版本單一來源 |
| Metadata 工具 | `scripts/read-metadata.js` | 版本讀取 |
| 本分析報告 | `docs/index-html-refactor-analysis.md` | 重構規劃 |

---

**報告結束** | 下一步：執行 P0 任務（版本資訊同步）
