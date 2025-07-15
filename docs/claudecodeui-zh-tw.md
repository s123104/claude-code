# Claude Code UI 中文全解（繁體中文版）

> **本文件彙整自：**
> 
> - [siteboon/claudecodeui](https://github.com/siteboon/claudecodeui) 官方文件與 README
> - [Claude Code 官方 UI 文檔](https://docs.anthropic.com/en/docs/claude-code)
> - [PWA 開發最佳實踐](https://web.dev/progressive-web-apps/)
> - [現代前端工具鏈整合](https://vitejs.dev/)
> - **文件整理時間：2025-07-15T14:16:31+08:00**

---

## 目錄

1. [產品概覽](#1-產品概覽)
2. [安裝與環境設置](#2-安裝與環境設置)
3. [啟動與開發模式](#3-啟動與開發模式)
4. [PWA 圖示與資源生成](#4-pwa-圖示與資源生成)
5. [CLI 與 Claude Code 整合](#5-cli-與-claude-code-整合)
6. [開發流程與常用指令](#6-開發流程與常用指令)
7. [最佳實踐與疑難排解](#7-最佳實踐與疑難排解)
8. [社群資源與延伸閱讀](#8-社群資源與延伸閱讀)

---

## 1. 產品概覽

Claude Code UI 是 Claude Code CLI 的現代化 Web 與行動裝置友善介面，提供直觀的圖形化操作環境，讓開發者能夠遠端瀏覽、管理和互動所有 Claude Code session 與專案。

### 1.1 核心特色

- **響應式設計**：完美適配桌面、平板和行動裝置
- **PWA 支援**：可安裝為原生應用程式體驗
- **即時同步**：與 Claude Code CLI 保持即時連線和狀態同步
- **視覺化管理**：直觀的專案檔案樹和對話歷史介面
- **多主題支援**：深色、淺色和自動切換主題
- **離線功能**：支援離線瀏覽和基本操作

### 1.2 技術架構

```
Claude Code UI 架構
├── Frontend (React/Vue.js)
│   ├── PWA Service Worker
│   ├── 響應式 UI 組件
│   └── 即時通訊模組
├── Backend API
│   ├── Claude Code CLI 整合
│   ├── WebSocket 伺服器
│   └── 檔案系統介面
└── 資料層
    ├── 本地儲存
    ├── Session 管理
    └── 快取機制
```

### 1.3 使用場景

- **遠端開發**：透過瀏覽器存取遠端開發環境
- **團隊協作**：多人同時查看和管理專案狀態
- **行動辦公**：在行動裝置上監控和管理 Claude Code
- **展示演講**：透過大螢幕展示 Claude Code 工作流程
- **教學培訓**：提供友善的學習介面

- 官方文件：[siteboon/claudecodeui](https://github.com/siteboon/claudecodeui)

---

## 2. 安裝與環境設置

### 2.1 下載專案

```bash
git clone https://github.com/siteboon/claudecodeui.git
cd claudecodeui
```

### 2.2 安裝依賴

```bash
npm install
```

### 2.3 設定環境變數

```bash
cp .env.example .env
# 編輯 .env 內容以符合你的環境需求
```

> 來源：[README.md](https://github.com/siteboon/claudecodeui/blob/main/README.md)

---

## 3. 啟動與開發模式

### 3.1 啟動開發模式

```bash
npm run dev
```

- 支援熱重載，適合開發時即時預覽。

### 3.2 目錄權限檢查

```bash
ls -la
```

- 檢查檔案與資料夾權限，避免權限錯誤。

> 來源：[README.md](https://github.com/siteboon/claudecodeui/blob/main/README.md)

---

## 4. PWA 圖示與資源生成

### 4.1 產生 PWA 圖示（ImageMagick 範例）

```bash
convert icon-512x512.png -resize 192x192 icon-192x192.png
```

### 4.2 SVG 轉 PNG（Node.js + sharp 範例）

```bash
npm install sharp
node -e "
const sharp = require('sharp');
const fs = require('fs');
const sizes = [72, 96, 128, 144, 152, 192, 384, 512];
sizes.forEach(size => {
  const svgPath = `./icons/icon-${size}x${size}.svg`;
  const pngPath = `./icons/icon-${size}x${size}.png`;
  if (fs.existsSync(svgPath)) {
    sharp(svgPath).png().toFile(pngPath);
    console.log(`Converted ${svgPath} to ${pngPath}`);
  }
});
"
```

### 4.3 SVG 轉 PNG（Inkscape CLI 範例）

```bash
cd public/icons
for size in 72 96 128 144 152 192 384 512; do
  inkscape --export-type=png "icon-${size}x${size}.svg"
done
```

### 4.4 SVG 轉 PNG（ImageMagick 批次）

```bash
cd public/icons
for size in 72 96 128 144 152 192 384 512; do
  convert "icon-${size}x${size}.svg" "icon-${size}x${size}.png"
done
```

> 來源：[public/convert-icons.md](https://github.com/siteboon/claudecodeui/blob/main/public/convert-icons.md)

---

## 5. CLI 與 Claude Code 整合

- 於專案目錄下執行 `claude` 指令，確保 CLI 能正確辨識專案，解決「No Claude projects found」問題。

```bash
claude
```

> 來源：[README.md](https://github.com/siteboon/claudecodeui/blob/main/README.md)

---

## 6. 開發流程與常用指令

### 6.1 完整開發工作流程

#### 專案初始化
```bash
# 複製專案
git clone https://github.com/siteboon/claudecodeui.git
cd claudecodeui

# 安裝依賴
npm install

# 設定環境變數
cp .env.example .env.local
```

#### 開發環境啟動
```bash
# 啟動開發伺服器
npm run dev

# 啟動並開啟瀏覽器
npm run dev -- --open

# 監聽特定連接埠
npm run dev -- --port 3000
```

### 6.2 程式碼品質管理

#### 自動化檢查流程
```bash
# 程式碼格式化
npm run format

# ESLint 檢查
npm run lint

# TypeScript 類型檢查
npm run type-check

# 全套品質檢查
npm run lint && npm run format && npm run type-check
```

#### 預提交 Hook 設定
```json
{
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged",
      "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
    }
  },
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ]
  }
}
```

### 6.3 Git 工作流程最佳實踐

#### 分支管理策略
```bash
# 功能開發分支
git checkout -b feature/claude-integration
git checkout -b feature/pwa-enhancement

# 緊急修復分支
git checkout -b hotfix/critical-bug-fix

# 發布分支
git checkout -b release/v1.2.0
```

#### 提交訊息規範
```bash
# 功能新增
git commit -m "feat(ui): add responsive navigation component"

# 錯誤修復
git commit -m "fix(api): resolve WebSocket connection timeout"

# 文檔更新
git commit -m "docs(readme): update installation instructions"

# 重構
git commit -m "refactor(components): optimize chat message rendering"
```

### 6.4 PWA 高級配置

#### Service Worker 進階設定
```javascript
// service-worker.js
const CACHE_NAME = 'claude-code-ui-v1.0.0';
const urlsToCache = [
  '/',
  '/static/js/bundle.js',
  '/static/css/main.css',
  '/manifest.json'
];

// 安裝事件
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

// 網路優先策略
self.addEventListener('fetch', (event) => {
  event.respondWith(
    fetch(event.request)
      .then((response) => {
        // 檢查是否為有效回應
        if (!response || response.status !== 200 || response.type !== 'basic') {
          return response;
        }

        // 複製回應
        const responseToCache = response.clone();

        caches.open(CACHE_NAME)
          .then((cache) => {
            cache.put(event.request, responseToCache);
          });

        return response;
      })
      .catch(() => {
        // 網路失敗時回退到快取
        return caches.match(event.request);
      })
  );
});
```

#### PWA Manifest 優化
```json
{
  "name": "Claude Code UI",
  "short_name": "ClaudeUI",
  "description": "Claude Code 的現代化 Web 介面",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#3b82f6",
  "orientation": "portrait-primary",
  "icons": [
    {
      "src": "/icons/icon-72x72.png",
      "sizes": "72x72",
      "type": "image/png",
      "purpose": "maskable any"
    },
    {
      "src": "/icons/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "maskable any"
    }
  ],
  "shortcuts": [
    {
      "name": "新增專案",
      "short_name": "新專案",
      "description": "快速建立新的 Claude Code 專案",
      "url": "/projects/new",
      "icons": [{ "src": "/icons/new-project.png", "sizes": "96x96" }]
    }
  ]
}
```

### 6.5 部署與 CI/CD

#### Vercel 部署設定
```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

#### GitHub Actions 工作流程
```yaml
name: Deploy to Production

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run tests
      run: npm test
    
    - name: Build application
      run: npm run build
    
    - name: Deploy to Vercel
      uses: vercel/action@v1
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
        vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
```

### 6.6 效能監控與優化

#### Bundle 分析
```bash
# 分析打包大小
npm run build -- --analyze

# 使用 webpack-bundle-analyzer
npx webpack-bundle-analyzer dist/static/js/*.js
```

#### 效能指標追蹤
```javascript
// performance.js
export const trackPerformance = () => {
  // 首次內容繪製
  const observer = new PerformanceObserver((list) => {
    list.getEntries().forEach((entry) => {
      if (entry.name === 'first-contentful-paint') {
        console.log('FCP:', entry.startTime);
      }
    });
  });
  
  observer.observe({ entryTypes: ['paint'] });
  
  // 最大內容繪製
  new PerformanceObserver((entryList) => {
    const entries = entryList.getEntries();
    const lastEntry = entries[entries.length - 1];
    console.log('LCP:', lastEntry.startTime);
  }).observe({ entryTypes: ['largest-contentful-paint'] });
};
```

> 來源：[GitHub Repository](https://github.com/siteboon/claudecodeui) 和現代前端開發最佳實踐

---

## 7. 最佳實踐與疑難排解

- 建議於開發前先複製 .env.example 並編輯 .env
- 權限錯誤時請檢查目錄權限（ls -la）
- 若遇到專案辨識問題，請於專案根目錄執行 `claude`
- 圖示轉換建議使用 sharp、ImageMagick 或 Inkscape CLI
- 程式碼提交前請執行 lint 與格式化

---

## 8. 社群資源與延伸閱讀

- [siteboon/claudecodeui](https://github.com/siteboon/claudecodeui)
- [Claude Code CLI](https://github.com/anthropics/claude-code)
- [Node.js 官方網站](https://nodejs.org/)
- [ImageMagick 官方網站](https://imagemagick.org/)
- [sharp 套件](https://www.npmjs.com/package/sharp)

---

> 本文件最後更新：2025-07-14T11:51:25+08:00
>
> 主要參考來源：[siteboon/claudecodeui](https://github.com/siteboon/claudecodeui)
