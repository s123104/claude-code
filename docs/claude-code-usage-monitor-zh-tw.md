# Claude Code Usage Monitor 中文說明書

## 概述

此專案提供了完整的功能說明。


> **資料來源：**
>
> - [GitHub 專案](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)
> - [PyPI 套件頁面](https://pypi.org/project/claude-monitor/)
> - [Docker Hub](https://hub.docker.com/r/maciek/claude-usage-monitor)
> - **文件整理時間：2025-08-19T23:52:25+08:00**
> - **專案版本：v3.1.0（最新版本）**
> - **專案最後更新：2025-07-24T00:21:42+02:00**

---

## 目錄

- [1. 產品簡介](#1-產品簡介)
- [2. 安裝方式](#2-安裝方式)
- [3. 啟動與基本用法](#3-啟動與基本用法)
- [4. 進階設定與常用參數](#4-進階設定與常用參數)
- [5. 常見問題與除錯](#5-常見問題與除錯)
- [6. Docker/Web Dashboard](#6-dockerweb-dashboard)
- [7. 開發、測試與貢獻](#7-開發測試與貢獻)
- [8. ML/未來規劃](#8-ml未來規劃)

---

## 1. 產品簡介

Claude Code Usage Monitor 是一套即時監控 Claude Code 令牌（token）用量、預測與警示的開源工具，支援 CLI、Web Dashboard、Docker 部署，並具備多種自訂方案、時區、重置時刻與主題設定。

### 1.1 核心功能

- **即時用量追蹤**：監控 Claude Code API 呼叫次數和 token 消耗
- **多方案支援**：Pro、Max5、Max20、Custom 等訂閱方案自動偵測
- **智能預測**：基於使用模式預測每日/每月用量趨勢
- **彈性警示**：可設定用量閾值和通知機制
- **多重介面**：CLI、Web Dashboard、RESTful API
- **跨平台支援**：Linux、macOS、Windows（WSL）
- **機器學習預測**：LSTM、Prophet、Isolation Forest、XGBoost 等演算法

### 1.2 使用場景

- **個人開發者**：追蹤個人 Claude Code 使用量，避免超出限額
- **團隊管理**：監控團隊整體用量，進行成本控制
- **企業環境**：整合到 CI/CD 流程，實現自動化監控
- **研究機構**：分析 AI 工具使用模式，優化工作流程

---

## 2. 安裝方式

### 2.1 使用 uv（強烈推薦）

```bash
# 安裝 uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 安裝 Claude Monitor
uv tool install claude-monitor

# 執行
claude-monitor
```

**為什麼 uv 是最佳選擇：**

- ✅ 自動創建隔離環境（無系統衝突）
- ✅ 無 Python 版本問題
- ✅ 無 "externally-managed-environment" 錯誤
- ✅ 簡單的更新和卸載
- ✅ 支援所有平台

### 2.2 使用 pip

```bash
pip install claude-monitor

# 若找不到指令，加入 PATH：
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
claude-monitor
```

### 2.3 使用 pipx（隔離環境）

```bash
sudo apt install pipx  # Ubuntu/Debian
pipx install claude-monitor
claude-monitor
```

### 2.4 Conda/Mamba 環境

```bash
pip install claude-monitor
claude-monitor
```

### 2.5 從原始碼安裝

```bash
git clone https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor.git
cd Claude-Code-Usage-Monitor
python3 -m venv venv
source venv/bin/activate
pip install -e .
python claude_monitor.py
```

---

## 3. 啟動與基本用法

- **預設方案（Pro）**：
  ```bash
  claude-monitor
  ```
- **指定方案**：
  ```bash
  claude-monitor --plan max5
  claude-monitor --plan max20
  claude-monitor --plan custom_max
  ```
- **設定重置時刻與時區**：
  ```bash
  claude-monitor --reset-hour 9 --timezone Asia/Taipei
  ```
- **主題設定**：
  ```bash
  claude-monitor --theme light
  claude-monitor --theme dark
  claude-monitor --theme auto
  ```
- **Web Dashboard（Docker）**：
  ```bash
  docker run -p 8080:8080 maciek/claude-usage-monitor --web-mode
  ```

---

## 4. 進階設定與常用參數

- `--plan [pro|max5|max20|custom_max]`：選擇訂閱方案或自動偵測
- `--reset-hour [0-23]`：每日重置時刻（24 小時制）
- `--timezone [Asia/Taipei|UTC|Europe/London|... ]`：指定時區
- `--theme [auto|light|dark]`：主題
- `--web-mode`：啟用 Web Dashboard
- `--check-updates`：檢查更新
- `--version`：顯示版本

---

## 5. 常見問題與除錯

- **pip 安裝後找不到指令**：
  - 加入 `~/.local/bin` 至 PATH
- **externally-managed-environment 錯誤**：
  - 優先用 uv 或 pipx 安裝
  - 或建立虛擬環境再安裝
- **多 Python 版本衝突**：
  - 指定正確 python/pip 版本
- **No active session found**：
  - 需先啟動 Claude Code session
- **權限問題**：
  - `chmod +x claude_monitor.py` 或用 python 執行
- **Web Dashboard 無法啟動**：
  - 檢查 Docker 是否安裝、port 是否被佔用
- **記憶體/顏色/終端機問題**：
  - 使用現代終端機，調整寬度、強制顏色輸出
- **完整重裝**：
  ```bash
  pip uninstall claude-monitor
  pipx uninstall claude-monitor
  uv tool uninstall claude-monitor
  find ~/.cache -name "*claude*" -delete
  uv tool install claude-monitor
  ```

---

## 6. Docker/Web Dashboard

### 6.1 Web Dashboard 啟動

```bash
# 基本啟動
docker run -p 8080:8080 maciek/claude-usage-monitor --web-mode

# 自訂連接埠
docker run -p 3000:8080 maciek/claude-usage-monitor --web-mode

# 背景執行
docker run -d -p 8080:8080 --name claude-monitor maciek/claude-usage-monitor --web-mode
```

### 6.2 主要功能

#### 視覺化面板

- **即時用量儀表板**：顯示當前 token 使用量和剩餘額度
- **歷史趨勢圖表**：日、週、月用量變化曲線
- **Session 時間軸**：詳細的對話記錄和用量分布
- **方案比較圖**：不同訂閱方案的使用效率分析

#### 互動功能

- **REST API 端點**：`/api/usage`、`/api/stats`、`/api/alerts`
- **行動裝置支援**：響應式設計，支援手機和平板訪問
- **即時更新**：WebSocket 連接，無需手動刷新
- **匯出功能**：CSV、JSON 格式資料下載

### 6.3 Docker 進階配置

#### 環境變數設定

```bash
# 方案與時區設定
docker run -e PLAN=max5 -e RESET_HOUR=9 -e TIMEZONE=Asia/Taipei maciek/claude-usage-monitor

# 資料持久化
docker run -v ~/.claude_monitor:/data -p 8080:8080 maciek/claude-usage-monitor --web-mode

# 完整配置範例
docker run -d \
  --name claude-monitor \
  -p 8080:8080 \
  -e PLAN=pro \
  -e RESET_HOUR=0 \
  -e TIMEZONE=UTC \
  -e ALERT_THRESHOLD=80 \
  -v ~/.claude_monitor:/data \
  maciek/claude-usage-monitor --web-mode
```

#### Docker Compose 範例

```yaml
version: "3.8"
services:
  claude-monitor:
    image: maciek/claude-usage-monitor
    container_name: claude-monitor
    ports:
      - "8080:8080"
    environment:
      - PLAN=pro
      - RESET_HOUR=0
      - TIMEZONE=Asia/Taipei
      - ALERT_THRESHOLD=85
    volumes:
      - ./data:/data
    command: --web-mode
    restart: unless-stopped
```

### 6.4 API 端點說明

| 端點                 | 方法 | 功能         | 回應格式 |
| -------------------- | ---- | ------------ | -------- |
| `/api/usage`         | GET  | 當前用量資訊 | JSON     |
| `/api/usage/history` | GET  | 歷史用量記錄 | JSON     |
| `/api/stats`         | GET  | 統計資訊     | JSON     |
| `/api/alerts`        | GET  | 警示設定     | JSON     |
| `/api/alerts`        | POST | 更新警示     | JSON     |
| `/api/export`        | GET  | 匯出資料     | CSV/JSON |

#### API 使用範例

```bash
# 取得當前用量
curl http://localhost:8080/api/usage

# 取得統計資訊
curl http://localhost:8080/api/stats

# 設定警示閾值
curl -X POST http://localhost:8080/api/alerts \
  -H "Content-Type: application/json" \
  -d '{"threshold": 85, "email": "admin@example.com"}'
```

---

## 7. 開發、測試與貢獻

- Fork 並 clone 專案：
  ```bash
  git clone https://github.com/YOUR-USERNAME/Claude-Code-Usage-Monitor.git
  cd Claude-Code-Usage-Monitor
  ```
- 建立虛擬環境與安裝開發依賴：
  ```bash
  python3 -m venv venv
  source venv/bin/activate
  pip install -e .[dev]
  chmod +x claude_monitor.py
  ```
- 執行測試：
  ```bash
  pytest
  pytest --cov=claude_monitor
  tox
  ```
- 程式碼風格：PEP8、pytest 單元測試、Ruff 靜態檢查
- Git commit 格式：Add/Fix/Update/Docs/Test/Refactor/Style
- Issue/Bug/Feature Template：請依 CONTRIBUTING.md 填寫

---

## 8. ML/未來規劃

- **ML 預測**：LSTM、Prophet、Isolation Forest、XGBoost 等演算法預測 token 用量與異常
- **Web Dashboard**：即時圖表、歷史趨勢、行動裝置支援、REST API
- **多用戶/團隊支援**、**通知整合**（Slack/Discord/Webhook）、**外掛系統**
- **效能優化**：Alpine Linux、multi-stage build、最小資源佔用
- **資料收集**：匿名用量、地區/時區分析、任務型態關聯

---

> 如需更多細節、除錯指令、或參與開發，請參閱 [官方 GitHub](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) 及專案內 README、TROUBLESHOOTING、DEVELOPMENT、CONTRIBUTING、RELEASE.md 文件。
>
> **版本資訊**：Claude Code Usage Monitor v3.1.0 - 最新版本  
> **最後更新**：2025-08-19T23:52:25+08:00
