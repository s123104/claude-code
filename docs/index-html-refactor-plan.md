# index.html UI/UX 重構分析與執行計畫

> **產出時間**：2025-12-25T01:17:32+08:00
> **基於**：`docs/index-html-feature-spec.md` 功能規格書
> **SSOT 版本**：v5.1.0 | Claude Code v2.0.75

---

## 1. 分析摘要

### 1.1 需求萃取
根據對話分析，使用者的核心需求為：
- **UI/UX 大重構**：重新設計頁面視覺與互動體驗
- **功能規格書產出**：✅ 已完成（`docs/index-html-feature-spec.md`）
- **百科全書式架構**：確保文檔結構清晰、易於導覽

### 1.2 現況盤點

| 項目 | 現況 | 備註 |
|------|------|------|
| 頁面總行數 | 4800+ 行 | 單一 HTML 檔案，維護困難 |
| 第三方依賴 | Tailwind CDN、Font Awesome、Google Fonts | 無版本鎖定 |
| 區塊數量 | 11 個主要區塊 | 結構完整但冗餘 |
| 專案卡片 | 20 個 | 與 SSOT 不一致（應為 14 個活躍專案） |
| 彩蛋系統 | 14+ 種 | JavaScript 嵌入式，難以維護 |
| 版本資訊 | 硬編碼 | 未與 `config/metadata.json` SSOT 同步 |

### 1.3 關鍵問題
1. **SSOT 不一致**：頁面顯示 20 個專案，但 SSOT 只有 14 個活躍專案
2. **版本過時**：顯示 v2.0.27，但最新為 v2.0.75
3. **程式碼冗餘**：4800+ 行單檔，CSS 與 JS 混合
4. **維護困難**：內容更新需手動修改 HTML

---

## 2. 最佳實踐優化方案

### 2.1 架構優化（依 Tailwind CSS 4.x 最佳實踐）

| 項目 | 現況 | 建議優化 |
|------|------|----------|
| CSS 框架 | Tailwind CDN | 維持 CDN（文檔類網站適用） |
| 響應式設計 | 使用 `md:`、`lg:` | ✅ 符合最佳實踐 |
| 組件化 | 無 | 可考慮使用 Alpine.js 輕量化 |
| SSOT 整合 | 無 | 應從 `config/metadata.json` 動態讀取 |

### 2.2 SSOT 整合方案
```javascript
// 建議新增 scripts/inject-metadata.js
// 從 config/metadata.json 注入版本資訊到 index.html
```

### 2.3 內容同步建議
| 來源 | 目標 | 同步方式 |
|------|------|----------|
| `config/metadata.json` | 頁面版本資訊 | 建置時注入 |
| `config/metadata.json` | 專案卡片列表 | 建置時生成 |
| `docs/*.md` | 專案描述 | 手動維護或腳本同步 |

---

## 3. 專案步驟清單

### 3.1 已完成項目
| 步驟 | 狀態 | 說明 |
|------|------|------|
| 功能規格書 | ✅ 完成 | `docs/index-html-feature-spec.md` |
| SSOT 架構建立 | ✅ 完成 | `config/metadata.json` |
| 讀取腳本 | ✅ 完成 | `scripts/read-metadata.js` |

### 3.2 待執行項目
| 步驟 | 狀態 | 說明 |
|------|------|------|
| 版本資訊同步 | ⏳ 待執行 | index.html 版本需更新 |
| 專案卡片同步 | ⏳ 待執行 | 移除已歸檔專案 |
| UI/UX 重構 | ⏳ 待執行 | 視覺風格重新設計 |
| 程式碼模組化 | ⏳ 待執行 | CSS/JS 抽離 |

---

## 4. To-Do List（含優先級與負責人）

### P0：立即執行（阻礙性問題）
| ID | 任務 | 優先級 | 負責人 | 預估時程 |
|----|------|--------|--------|----------|
| T-001 | 更新 index.html 版本號（v2.0.27 → v2.0.75） | P0 | AI | 5 分鐘 |
| T-002 | 更新專案版本號（v5.0.0 → v5.1.0） | P0 | AI | 5 分鐘 |
| T-003 | 同步專案數量（20 → 14 個活躍專案） | P0 | AI | 30 分鐘 |

### P1：短期執行（功能修正）
| ID | 任務 | 優先級 | 負責人 | 預估時程 |
|----|------|--------|--------|----------|
| T-004 | 移除已歸檔專案卡片（5 個） | P1 | AI | 20 分鐘 |
| T-005 | 更新最後更新時間戳記 | P1 | AI | 5 分鐘 |
| T-006 | 修正 Filter Tabs 計數 | P1 | AI | 10 分鐘 |

### P2：中期執行（架構優化）
| ID | 任務 | 優先級 | 負責人 | 預估時程 |
|----|------|--------|--------|----------|
| T-007 | 建立 SSOT 注入腳本 | P2 | 開發者 | 2 小時 |
| T-008 | 抽離 CSS 至獨立檔案 | P2 | 開發者 | 1 小時 |
| T-009 | 抽離 JS 至獨立檔案 | P2 | 開發者 | 1 小時 |

### P3：長期規劃（UI/UX 重構）
| ID | 任務 | 優先級 | 負責人 | 預估時程 |
|----|------|--------|--------|----------|
| T-010 | UI 風格重新設計 | P3 | 設計師 | 依設計稿 |
| T-011 | 響應式佈局優化 | P3 | 開發者 | 依設計稿 |
| T-012 | 動畫與互動優化 | P3 | 開發者 | 依設計稿 |
| T-013 | 效能優化（圖片、載入） | P3 | 開發者 | 4 小時 |

---

## 5. 子功能規格

### 5.1 T-003 專案卡片同步規格

**目標**：將專案卡片數量從 20 個同步至 14 個活躍專案

**需移除的專案卡片**（依 SSOT 已歸檔）：
| 專案 ID | 專案名稱 | 替代方案 |
|---------|----------|----------|
| claude-agents | Claude Agents | docs/agents-zh-tw.md |
| claude-code-hooks | Claude Code Hooks | docs/anthropic-claude-code-zh-tw/hooks.md |
| claude-code-usage-monitor | Usage Monitor | docs/ccusage-zh-tw.md |
| claudecode-debugger | Debugger | docs/claudecodeui-zh-tw.md |
| claude-code-leaderboard | Leaderboard | 無替代（已棄用） |

**驗收標準**：
- [ ] 專案卡片總數為 14 個
- [ ] Filter Tabs「全部項目」顯示 (14)
- [ ] 各分類計數正確
- [ ] 無死連結

### 5.2 T-007 SSOT 注入腳本規格

**功能**：從 `config/metadata.json` 讀取版本資訊並注入 index.html

**介面定義**：
```javascript
// scripts/inject-metadata-to-html.js
async function injectMetadata() {
  // 1. 讀取 config/metadata.json
  // 2. 解析 index.html
  // 3. 替換版本資訊佔位符
  // 4. 輸出更新後的 HTML
}
```

**佔位符格式**：
```html
<!-- VERSION_PLACEHOLDER: project.version -->
<!-- VERSION_PLACEHOLDER: claudeCode.version -->
<!-- VERSION_PLACEHOLDER: lastUpdated -->
```

**驗收標準**：
- [ ] 執行腳本後版本資訊正確
- [ ] 支援 dry-run 模式
- [ ] 錯誤處理完善

---

## 6. 當前進度實作

### 6.1 立即可執行的修正（T-001、T-002、T-005）

以下為需要在 `index.html` 中進行的版本同步修正：

#### 6.1.1 更新 Claude Code 版本
```diff
- <meta name="description" content="...Claude Code v2.0.27...">
+ <meta name="description" content="...Claude Code v2.0.75...">

- Claude Code v2.0.27
+ Claude Code v2.0.75
```

#### 6.1.2 更新專案版本
```diff
- 版本：v5.0.0
+ 版本：v5.1.0

- 文檔標準化 v5.0.0
+ SSOT 架構 v5.1.0
```

#### 6.1.3 更新時間戳記
```diff
- 最後更新：2025-11-25T03:02:00+08:00
+ 最後更新：2025-12-25T01:17:32+08:00
```

#### 6.1.4 更新專案數量
```diff
- 涵蓋 20 個專案完整文檔
+ 涵蓋 14 個活躍專案文檔

- 20 個專案 100% 文檔覆蓋
+ 14 個活躍專案 100% 文檔覆蓋

- 全部項目 (20)
+ 全部項目 (14)
```

### 6.2 需移除的專案卡片 HTML

以下專案卡片應從 `index.html` 中移除：

1. **claude-agents**（如有）
2. **claude-code-hooks**（如有）
3. **claude-code-usage-monitor**（如有）
4. **claudecode-debugger**（如有）
5. **claude-code-leaderboard**（如有）
6. **claudia**（已更名為 opcode）

### 6.3 Filter Tabs 計數更新

```diff
- <button class="filter-btn active..." data-filter="all">全部項目 (20)</button>
+ <button class="filter-btn active..." data-filter="all">全部項目 (14)</button>

- 核心文檔 (3)
+ 核心文檔 (2)  // 移除獨立 README 索引

各分類需依實際內容重新計算
```

---

## 7. 下一步行動

### 立即執行（由 AI 完成）
1. ✅ 功能規格書已完成
2. ⏳ 執行 T-001 ~ T-006 的版本與專案同步
3. ⏳ 驗證修正結果

### 等待使用者確認
1. UI 風格方向（現代極簡 / 科技感 / 其他）
2. 是否需要 P2 架構優化（CSS/JS 模組化）
3. 是否需要 SSOT 自動注入腳本

---

**文件結束**

---

*此報告依據 DevSecOps Ultimate Agent 2025 規範產出*
*技術棧參考：Tailwind CSS v4.x [context7:/websites/tailwindcss:2025-12-25T01:17:32+08:00]*
