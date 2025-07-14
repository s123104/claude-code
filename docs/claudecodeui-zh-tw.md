# Claude Code UI 中文全解（繁體中文版）

> 本文件彙整自 [siteboon/claudecodeui](https://github.com/siteboon/claudecodeui) 官方文件、README 及 Context7 技術文檔，涵蓋安裝、啟動、PWA 圖示、CLI 整合、開發流程、最佳實踐與疑難排解。資料來源皆標註於各節，取得時間：2025-07-14T11:51:25+08:00。

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

Claude Code UI 是 Claude Code CLI 的 Web 與行動裝置友善介面，讓你能遠端瀏覽所有 Claude Code session 與專案，並進行互動與管理。

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

### 6.1 Git 操作

- 建立新功能分支：
  ```bash
  git checkout -b feature/amazing-feature
  ```
- 推送分支：
  ```bash
  git push origin feature/amazing-feature
  ```

### 6.2 程式碼品質檢查

- 執行 Lint 與格式化：
  ```bash
  npm run lint && npm run format
  ```

### 6.3 依賴安裝

- 安裝所有依賴：
  ```bash
  npm install
  ```

### 6.4 Service Worker 註冊（前端 JS 範例）

```javascript
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .then((registration) => {
        console.log("SW registered: ", registration);
      })
      .catch((registrationError) => {
        console.log("SW registration failed: ", registrationError);
      });
  });
}
```

> 來源：[index.html](https://github.com/siteboon/claudecodeui/blob/main/index.html)

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
