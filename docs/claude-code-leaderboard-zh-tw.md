# Claude Code Leaderboard CLI 中文說明書

## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/grp06/claude-code-leaderboard)
> - [排行榜網站](https://claudecount.com)
> - [NPM 套件](https://www.npmjs.com/package/claude-code-leaderboard)
> - **文件整理時間：2025-08-17T23:45:00+08:00**
> - **專案最後更新：v0.2.9**

---

## 目錄

- [1. 專案簡介](#1-專案簡介)
- [2. 核心功能](#2-核心功能)
- [3. 安裝與設定](#3-安裝與設定)
- [4. 使用指南](#4-使用指南)
- [5. Hooks 系統詳解](#5-hooks-系統詳解)
- [6. 隱私與安全](#6-隱私與安全)
- [7. 故障排除](#7-故障排除)
- [8. 延伸閱讀](#8-延伸閱讀)

---

## 1. 專案簡介

Claude Code Leaderboard CLI 是一個自動追蹤 Claude Code 使用量的工具，透過全球排行榜讓開發者能夠比較和分享自己的 AI 開發效率。這個工具利用 Claude Code 的 Hooks 系統，在每次會話結束後自動收集使用統計資料，並上傳到公開的排行榜。

### 1.1 核心特色

- **🔄 自動追蹤**：透過 Hooks 系統自動監控使用量，無需手動操作
- **🏆 全球排行榜**：在 [claudecount.com](https://claudecount.com) 上展示全球使用者排名
- **🛡️ 隱私保護**：只收集使用統計，不記錄實際對話內容
- **📊 詳細分析**：包含 token 使用、模型選擇、快取效率等指標
- **🚀 即插即用**：一行指令完成安裝和設定

### 1.2 使用場景

- **個人競爭**：追蹤和提升個人的 AI 開發效率
- **團隊比較**：團隊成員間的友善競爭
- **社群參與**：參與全球 Claude Code 開發者社群
- **使用分析**：了解自己的 AI 工具使用模式
- **效率優化**：透過數據分析優化 AI 使用策略

---

## 2. 核心功能

### 2.1 自動使用量追蹤

#### 追蹤指標

- **輸入 Tokens**：發送給 Claude 的文字量
- **輸出 Tokens**：Claude 產生的回應量
- **快取 Tokens**：快取建立和讀取的 token 數量
- **會話時間戳記**：每次使用的時間記錄
- **使用模型**：如 claude-sonnet-4、claude-opus-4 等

#### 數據收集範圍

✅ **會收集的資料**：

- Token 使用統計
- 模型選擇記錄
- 會話時間長度
- 快取效率指標

❌ **不會收集的資料**：

- 實際對話內容
- 程式碼內容
- 個人檔案內容
- 敏感資訊

### 2.2 排行榜功能

#### 排名系統

- **總 Token 使用量**：累計所有 token 使用
- **活躍度排名**：基於使用頻率的排名
- **效率指標**：平均每次會話的產出效率
- **快取利用率**：快取使用效率排名

#### 展示內容

```
🏆 全球排行榜 (claudecount.com)

排名 | 使用者     | 總 Tokens | 會話數 | 效率分數
-----|-----------|-----------|--------|----------
1    | developer1 | 1,234,567 | 156    | 95.2
2    | coder_ai   | 987,654   | 132    | 92.8
3    | ai_ninja   | 876,543   | 98     | 90.1
```

### 2.3 Twitter 整合

#### 自動發文功能

- **里程碑達成**：達到特定 token 數量時自動發文
- **排名變化**：排名提升時的自動慶祝
- **每日總結**：每日使用量統計分享
- **成就解鎖**：完成特定挑戰時的分享

#### 發文範例

```
🚀 剛剛達成 100萬 tokens 里程碑！

📊 我的 Claude Code 統計：
• 總 tokens: 1,000,000
• 會話數: 234
• 最愛模型: claude-sonnet-4
• 全球排名: #15

一起來挑戰 AI 開發效率！
#ClaudeCode #AI #Coding

查看排行榜：claudecount.com
```

---

## 3. 安裝與設定

### 3.1 快速開始

#### 一鍵安裝

```bash
# 使用 npx 直接執行（推薦）
npx claude-code-leaderboard

# 或全域安裝
npm install -g claude-code-leaderboard
claude-code-leaderboard
```

#### 設定流程

安裝時會引導您完成以下步驟：

1. **Twitter 認證**（可選）
2. **使用者名稱設定**
3. **隱私偏好設定**
4. **Hook 安裝確認**

### 3.2 詳細設定步驟

#### 步驟 1：啟動設定精靈

```bash
npx claude-code-leaderboard

# 輸出範例：
? 歡迎使用 Claude Code Leaderboard! 設定 Twitter 整合嗎？ (Y/n)
```

#### 步驟 2：Twitter 整合（可選）

```bash
? 設定 Twitter 整合嗎？ Yes
? 您的 Twitter 帳號： @your_handle
? 開啟自動發文功能嗎？ Yes

✅ Twitter 整合設定完成！
```

#### 步驟 3：使用者資料設定

```bash
? 您的顯示名稱： AI Developer
? 是否公開您的統計資料？ Yes
? 參與全球排行榜嗎？ Yes

✅ 使用者資料設定完成！
```

#### 步驟 4：Hook 安裝

```bash
正在安裝 Claude Code Hook...

✅ Hook 已成功安裝到：
   ~/.claude/hooks/stop/leaderboard-tracker.sh

🎉 設定完成！現在會自動追蹤您的 Claude Code 使用量。
```

### 3.3 手動 Hook 安裝

如果自動安裝失敗，可以手動安裝：

```bash
# 建立 hooks 目錄
mkdir -p ~/.claude/hooks/stop

# 建立追蹤腳本
cat > ~/.claude/hooks/stop/leaderboard-tracker.sh << 'EOF'
#!/bin/bash
# Claude Code Leaderboard Tracker
node ~/.npm-global/lib/node_modules/claude-code-leaderboard/hooks/track-usage.js "$@"
EOF

# 設定執行權限
chmod +x ~/.claude/hooks/stop/leaderboard-tracker.sh
```

---

## 4. 使用指南

### 4.1 基本使用

#### 日常使用

一旦設定完成，追蹤就會自動進行：

```bash
# 正常使用 Claude Code
claude "請幫我優化這個函數"

# 會話結束時，Hook 會自動執行
# 無需任何額外操作
```

#### 檢查狀態

```bash
# 檢查追蹤狀態
claude-code-leaderboard status

# 輸出範例：
✅ 追蹤功能：啟用
📊 今日統計：1,234 tokens (3 會話)
🏆 目前排名：#42 (總榜)
🔄 最後同步：2 分鐘前
```

#### 查看本地統計

```bash
# 查看詳細統計
claude-code-leaderboard stats

# 輸出範例：
📊 您的 Claude Code 統計

總計：
• 總 tokens: 123,456
• 輸入 tokens: 45,678
• 輸出 tokens: 67,890
• 快取命中: 9,888

今日：
• 會話數: 12
• 總時間: 2.5 小時
• 平均效率: 92.1%

本週：
• 活躍天數: 5/7
• 總 tokens: 23,456
• 週排名: #8
```

### 4.2 進階功能

#### 自訂追蹤設定

```bash
# 開啟設定模式
claude-code-leaderboard config

# 可設定項目：
? 追蹤頻率 (immediate/daily/weekly): immediate
? Twitter 自動發文 (on/off): on
? 里程碑通知 (on/off): on
? 排名變化通知 (on/off): on
```

#### 匯出資料

```bash
# 匯出個人統計資料
claude-code-leaderboard export --format csv
claude-code-leaderboard export --format json

# 匯出到特定檔案
claude-code-leaderboard export --output my-stats.json
```

#### 比較分析

```bash
# 與其他使用者比較
claude-code-leaderboard compare --user developer123

# 輸出範例：
📊 與 developer123 比較

項目           | 您      | developer123 | 差距
---------------|---------|--------------|--------
總 tokens      | 123,456 | 234,567     | -111,111
週平均會話     | 15      | 12          | +3
效率分數       | 92.1%   | 88.7%       | +3.4%
快取利用率     | 78%     | 65%         | +13%
```

---

## 5. Hooks 系統詳解

### 5.1 Claude Code Hooks 概念

#### 什麼是 Hooks？

Hooks 是 Claude Code 的擴展機制，允許在特定的執行時機自動執行用戶定義的 shell 命令。這提供了確定性的程式化控制，確保重要任務在正確的時間點自動執行。

#### Hook 類型

| Hook 類型    | 觸發時機               | 使用場景             |
| ------------ | ---------------------- | -------------------- |
| **Start**    | Claude Code 會話開始時 | 環境初始化、日誌開始 |
| **Stop**     | Claude Code 會話結束時 | 使用量統計、清理作業 |
| **PreTool**  | 工具執行前             | 權限檢查、預處理     |
| **PostTool** | 工具執行後             | 結果處理、通知       |

### 5.2 Leaderboard Hook 實作

#### Hook 檔案結構

```bash
~/.claude/hooks/stop/leaderboard-tracker.sh
```

#### Hook 腳本內容

```bash
#!/bin/bash
# Claude Code Leaderboard Tracker Hook

# 設定環境變數
export LEADERBOARD_CONFIG="$HOME/.claude-leaderboard/config.json"
export LOG_FILE="$HOME/.claude-leaderboard/tracker.log"

# 記錄執行時間
echo "$(date): Hook triggered" >> "$LOG_FILE"

# 執行追蹤腳本
node "$(npm root -g)/claude-code-leaderboard/hooks/track-usage.js" "$@" 2>> "$LOG_FILE"

# 檢查執行結果
if [ $? -eq 0 ]; then
    echo "$(date): Tracking successful" >> "$LOG_FILE"
else
    echo "$(date): Tracking failed" >> "$LOG_FILE"
fi
```

#### 追蹤腳本邏輯

```javascript
// hooks/track-usage.js 核心邏輯

const fs = require("fs");
const path = require("path");

async function trackUsage(sessionData) {
  try {
    // 1. 解析 Claude Code 會話資料
    const usage = parseSessionData(sessionData);

    // 2. 累計本地統計
    await updateLocalStats(usage);

    // 3. 上傳到排行榜伺服器
    await uploadToLeaderboard(usage);

    // 4. 檢查里程碑和成就
    await checkMilestones(usage);

    // 5. 發送 Twitter 更新（如果啟用）
    await postTwitterUpdate(usage);
  } catch (error) {
    console.error("Tracking failed:", error);
  }
}
```

### 5.3 Hook 安全性考量

#### 執行權限

- Hook 以使用者完整權限執行
- 需要謹慎檢查腳本內容
- 建議定期審查 Hook 檔案

#### 資料傳輸安全

```javascript
// 資料加密和匿名化
const anonymizedData = {
  sessionId: hash(sessionId + salt),
  tokens: usage.tokens,
  timestamp: usage.timestamp,
  model: usage.model,
  // 不包含任何可識別的內容
};
```

---

## 6. 隱私與安全

### 6.1 資料保護政策

#### 收集的資料

✅ **會收集**：

- Token 使用統計（數量）
- 模型選擇（claude-sonnet-4 等）
- 會話時間戳記
- 快取效率指標
- 匿名會話 ID

❌ **不會收集**：

- 對話內容
- 程式碼內容
- 檔案內容
- 個人身份資訊（除非您明確提供）
- IP 地址（後端不記錄）

#### 資料匿名化

```javascript
// 範例：資料匿名化過程
const rawSession = {
  content: "請幫我寫一個函數...", // ❌ 不會上傳
  tokens: 1234, // ✅ 會上傳（統計）
  model: "claude-sonnet-4", // ✅ 會上傳（統計）
  timestamp: "2025-08-17T23:45:00Z", // ✅ 會上傳（統計）
};
```

### 6.2 隱私控制選項

#### 完全退出

```bash
# 完全停用追蹤
claude-code-leaderboard disable

# 移除所有資料
claude-code-leaderboard purge --confirm
```

#### 部分隱私模式

```bash
# 只追蹤本地，不上傳排行榜
claude-code-leaderboard config --mode local-only

# 匿名參與排行榜（無使用者名稱）
claude-code-leaderboard config --mode anonymous
```

#### 資料控制

```bash
# 查看所有儲存的資料
claude-code-leaderboard data --show-all

# 刪除特定時間範圍的資料
claude-code-leaderboard data --delete --since "2025-08-01"

# 匯出並刪除所有資料
claude-code-leaderboard data --export-and-delete
```

### 6.3 開源透明度

#### 原始碼審查

本專案完全開源，您可以：

- 檢查所有資料收集邏輯
- 驗證隱私保護措施
- 提交改進建議
- Fork 並自建伺服器

#### 自建伺服器選項

```bash
# 設定自訂伺服器端點
claude-code-leaderboard config --server https://your-server.com

# 本地模式（完全不上傳）
claude-code-leaderboard config --mode offline
```

---

## 7. 故障排除

### 7.1 常見問題

#### Hook 未執行

**症狀**：統計資料不更新，無自動追蹤

**解決方案**：

```bash
# 檢查 Hook 檔案是否存在
ls -la ~/.claude/hooks/stop/

# 檢查執行權限
ls -la ~/.claude/hooks/stop/leaderboard-tracker.sh

# 手動執行 Hook 測試
bash ~/.claude/hooks/stop/leaderboard-tracker.sh
```

#### 網路連線問題

**症狀**：本地統計正常，但排行榜未更新

**解決方案**：

```bash
# 檢查網路連線
claude-code-leaderboard test-connection

# 查看錯誤日誌
cat ~/.claude-leaderboard/tracker.log

# 重試上傳
claude-code-leaderboard sync --force
```

#### Twitter 整合問題

**症狀**：統計正常但無法發文

**解決方案**：

```bash
# 重新授權 Twitter
claude-code-leaderboard twitter --reauth

# 檢查 Twitter API 配額
claude-code-leaderboard twitter --check-quota

# 測試發文功能
claude-code-leaderboard twitter --test-post
```

### 7.2 診斷工具

#### 系統診斷

```bash
# 完整系統檢查
claude-code-leaderboard doctor

# 輸出範例：
🔍 系統診斷報告

✅ Claude Code 安裝: 正常
✅ Hook 檔案存在: 正常
✅ 執行權限: 正常
✅ 網路連線: 正常
❌ Twitter 認證: 已過期

🛠️ 建議修復：
1. 重新授權 Twitter: claude-code-leaderboard twitter --reauth
```

#### 日誌分析

```bash
# 查看最近的日誌
claude-code-leaderboard logs --recent

# 查看錯誤日誌
claude-code-leaderboard logs --errors-only

# 即時監控
claude-code-leaderboard logs --follow
```

### 7.3 效能優化

#### 減少網路請求

```bash
# 批次上傳模式（每小時一次）
claude-code-leaderboard config --upload-mode batch

# 壓縮資料傳輸
claude-code-leaderboard config --compression on
```

#### Hook 執行優化

```bash
# 非同步執行 Hook（減少 Claude Code 等待時間）
claude-code-leaderboard config --async-hook on

# 減少 Hook 執行時間
claude-code-leaderboard config --minimal-tracking on
```

---

## 8. 延伸閱讀

### 8.1 官方資源

- [Claude Code Leaderboard GitHub](https://github.com/grp06/claude-code-leaderboard)
- [排行榜網站](https://claudecount.com)
- [NPM 套件頁面](https://www.npmjs.com/package/claude-code-leaderboard)

### 8.2 相關專案

- [Claude Code Usage Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)
- [ccusage](https://github.com/ryoppippi/ccusage)
- [Claude Code](https://github.com/anthropics/claude-code)

### 8.3 技術文檔

- [Claude Code Hooks 官方文檔](https://docs.anthropic.com/en/docs/claude-code/hooks)
- [Slash Commands 指南](https://docs.anthropic.com/en/docs/claude-code/slash-commands)
- [Claude Code CLI 參考](https://docs.anthropic.com/en/docs/claude-code/cli-reference)

### 8.4 社群資源

- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
- [Claude Code Discord](https://discord.com/channels/claude-code)
- [Twitter #ClaudeCode](https://twitter.com/hashtag/ClaudeCode)

---

> **注意**：本文件為社群整理版本，詳細內容與最新資源請參閱 [官方 GitHub](https://github.com/grp06/claude-code-leaderboard) 與相關文檔。
>
> **版本資訊**：Claude Code Leaderboard CLI - 全球使用量追蹤與排行榜  
> **最後更新**：2025-08-17T23:45:00+08:00
