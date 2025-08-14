# Claude Code UI 中文說明書

> **資料來源：**
>
> - [GitHub 專案](https://github.com/siteboon/claudecodeui)
> - [Claude Code 官方文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [Cursor CLI 文檔](https://docs.cursor.com/en/cli/overview)
> - **文件整理時間：2025-08-15T00:38:00+08:00**
> - **專案版本：v1.7.0（最新版本）**
> - **專案最後更新：2025-08-12T15:23:27+03:00**

---

## 目錄

- [1. 產品簡介](#1-產品簡介)
- [2. 核心功能](#2-核心功能)
- [3. 安裝與部署](#3-安裝與部署)
- [4. 使用指南](#4-使用指南)
- [5. 技術架構](#5-技術架構)
- [6. 開發與貢獻](#6-開發與貢獻)
- [7. 常見問題](#7-常見問題)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 產品簡介

Claude Code UI 是一個專為 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 和 [Cursor CLI](https://docs.cursor.com/en/cli/overview) 設計的桌面和行動裝置使用者介面。您可以在本地或遠端使用它來查看 Claude Code 或 Cursor 中的活躍專案和會話，並從任何地方（手機或桌面）對它們進行更改。這為您提供了一個可以在任何地方正常工作的適當介面。

### 1.1 支援的模型

- **Claude Sonnet 4** - 最新的 Claude 模型
- **Claude Opus 4.1** - 高階 Claude 模型
- **GPT-5** - OpenAI 最新模型
- 其他 Claude Code 相容模型

### 1.2 主要特色

- 🖥️ **跨平台支援**：桌面和行動裝置
- 📱 **響應式設計**：觸控導航的行動體驗
- 🌐 **遠端存取**：本地或遠端使用
- 🔄 **即時同步**：專案和會話狀態即時更新
- 🎨 **現代化介面**：美觀且易用的使用者體驗

---

## 2. 核心功能

### 2.1 專案管理

- **專案概覽**：查看所有活躍專案
- **會話管理**：管理 Claude Code 會話
- **檔案瀏覽**：瀏覽專案檔案結構
- **狀態監控**：監控專案和會話狀態

### 2.2 聊天介面

- **多模型支援**：支援 Claude Sonnet 4、Opus 4.1、GPT-5
- **會話歷史**：保存和檢索聊天記錄
- **上下文管理**：維護對話上下文
- **回應優化**：優化 AI 回應品質

### 2.3 行動體驗

- **觸控優化**：專為觸控裝置設計
- **響應式佈局**：適配不同螢幕尺寸
- **手勢支援**：支援觸控手勢操作
- **離線功能**：部分功能支援離線使用

---

## 3. 安裝與部署

### 3.1 本地安裝

```bash
# 克隆專案
git clone https://github.com/siteboon/claudecodeui.git
cd claudecodeui

# 安裝依賴
npm install

# 啟動開發伺服器
npm run dev

# 建置生產版本
npm run build
```

### 3.2 Docker 部署

```bash
# 使用 Docker Compose
docker-compose up -d

# 或直接使用 Docker
docker run -p 3000:3000 siteboon/claudecodeui
```

### 3.3 雲端部署

```bash
# Vercel 部署
vercel --prod

# Netlify 部署
netlify deploy --prod

# Railway 部署
railway up
```

---

## 4. 使用指南

### 4.1 首次設定

1. **啟動應用程式**
   - 開啟瀏覽器訪問 `http://localhost:3000`
   - 或使用桌面應用程式

2. **連接 Claude Code**
   - 輸入您的 Anthropic API 金鑰
   - 或使用環境變數設定

3. **選擇專案**
   - 瀏覽本地專案目錄
   - 或連接遠端專案

### 4.2 基本操作

#### 專案瀏覽
- 點擊專案名稱進入專案
- 使用檔案樹瀏覽專案結構
- 搜尋特定檔案或資料夾

#### 聊天互動
- 選擇 AI 模型
- 輸入問題或指令
- 查看 AI 回應
- 管理對話歷史

#### 行動裝置使用
- 使用觸控手勢導航
- 橫向和縱向模式支援
- 優化的行動介面

---

## 5. 技術架構

### 5.1 前端技術

- **框架**：React 18 + TypeScript
- **樣式**：Tailwind CSS + CSS Modules
- **狀態管理**：Zustand
- **路由**：React Router v6
- **UI 元件**：自訂元件庫

### 5.2 後端整合

- **API 整合**：Claude Code API
- **認證**：API 金鑰管理
- **快取**：本地儲存和快取
- **同步**：即時狀態同步

### 5.3 部署架構

- **靜態建置**：Vite 建置工具
- **容器化**：Docker 支援
- **CDN**：靜態資源分發
- **PWA**：漸進式網頁應用

---

## 6. 開發與貢獻

### 6.1 開發環境設定

```bash
# 安裝依賴
npm install

# 啟動開發伺服器
npm run dev

# 執行測試
npm test

# 程式碼檢查
npm run lint

# 型別檢查
npm run type-check
```

### 6.2 貢獻指南

1. **Fork 專案**
2. **建立功能分支**
3. **實作功能**
4. **撰寫測試**
5. **提交 Pull Request**

### 6.3 開發規範

- **程式碼風格**：ESLint + Prettier
- **提交訊息**：Conventional Commits
- **測試覆蓋**：Jest + Testing Library
- **型別安全**：TypeScript 嚴格模式

---

## 7. 常見問題

### 7.1 安裝問題

**Q：無法啟動開發伺服器？**
A：檢查 Node.js 版本（需要 18+）和依賴安裝狀態

**Q：API 金鑰無效？**
A：確認 Anthropic API 金鑰正確且有效

**Q：專案無法載入？**
A：檢查專案路徑和權限設定

### 7.2 使用問題

**Q：聊天回應慢？**
A：檢查網路連線和 API 限制

**Q：行動裝置體驗不佳？**
A：使用最新版本的瀏覽器或安裝 PWA

**Q：會話歷史遺失？**
A：檢查本地儲存設定和瀏覽器權限

---

## 8. 延伸閱讀

### 8.1 官方資源

- [Claude Code 文檔](https://docs.anthropic.com/en/docs/claude-code)
- [Cursor CLI 文檔](https://docs.cursor.com/en/cli/overview)
- [Anthropic API 參考](https://docs.anthropic.com/en/api)

### 8.2 社群資源

- [GitHub Issues](https://github.com/siteboon/claudecodeui/issues)
- [Discussions](https://github.com/siteboon/claudecodeui/discussions)
- [Wiki](https://github.com/siteboon/claudecodeui/wiki)

### 8.3 相關專案

- [Claude Code](https://github.com/anthropics/claude-code)
- [Cursor](https://github.com/getcursor/cursor)
- [Claude Desktop](https://github.com/anthropics/anthropic-cookbook)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/siteboon/claudecodeui) 與相關文檔。
>
> **版本資訊**：Claude Code UI v1.7.0 - 最新版本  
> **最後更新**：2025-08-15T00:38:00+08:00
