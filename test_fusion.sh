#!/bin/bash
# Claude Code 融合安裝系統測試腳本
set -euo pipefail

# 基本設置
BINARY_SCORE=0
NPM_SCORE=0
SYSTEM_TYPE="macos"

# 測試智能評分系統
echo "=== 測試智能評分系統 ==="

# macOS 環境加分
BINARY_SCORE=$((BINARY_SCORE + 35))
NPM_SCORE=$((NPM_SCORE + 30))
echo "macOS 環境評分: 二進制=$BINARY_SCORE, NPM=$NPM_SCORE"

# Node.js 環境檢查模擬
if command -v node &>/dev/null; then
    NPM_SCORE=$((NPM_SCORE + 30))
    echo "Node.js 可用: NPM +30分"
else
    BINARY_SCORE=$((BINARY_SCORE + 25))
    echo "Node.js 不可用: 二進制 +25分"
fi

# 決策邏輯測試
echo "=== 決策結果 ==="
echo "二進制安裝評分: $BINARY_SCORE"
echo "NPM 安裝評分: $NPM_SCORE"

if [[ $BINARY_SCORE -gt $NPM_SCORE ]]; then
    INSTALL_METHOD="binary"
    echo "推薦: 官方二進制安裝"
else
    INSTALL_METHOD="npm"
    echo "推薦: NPM 安裝"
fi

echo "選擇的安裝方法: $INSTALL_METHOD"
echo "測試完成！"