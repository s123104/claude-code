#!/bin/bash

# Claude Desktop MCP 伺服器導入腳本
# 自動從 Claude Desktop 配置導入 MCP 伺服器到 Claude Code

set -e

echo "🔧 Claude Desktop MCP 伺服器導入工具"
echo "======================================"

# 檢查 Claude Desktop 配置檔案
DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

if [ ! -f "$DESKTOP_CONFIG" ]; then
    echo "❌ 找不到 Claude Desktop 配置檔案: $DESKTOP_CONFIG"
    echo "請確認已安裝 Claude Desktop 並有配置 MCP 伺服器"
    exit 1
fi

echo "✅ 找到 Claude Desktop 配置檔案"

# 檢查 Claude Code 是否已安裝
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code 未安裝或不在 PATH 中"
    echo "請先安裝 Claude Code: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

echo "✅ Claude Code 已安裝"

# 備份當前 MCP 配置
echo "📋 備份當前 MCP 配置..."
claude mcp list > /tmp/claude_mcp_backup_$(date +%Y%m%d_%H%M%S).txt 2>/dev/null || true

# 解析 JSON 並提取 MCP 伺服器配置
echo "🔄 解析 Claude Desktop MCP 配置..."

# 使用 jq 解析 JSON（如果可用）
if command -v jq &> /dev/null; then
    # 提取所有 MCP 伺服器名稱
    servers=$(jq -r '.mcpServers | keys[]' "$DESKTOP_CONFIG" 2>/dev/null)
    
    if [ -z "$servers" ]; then
        echo "❌ 在 Claude Desktop 配置中找不到 MCP 伺服器"
        exit 1
    fi
    
    echo "📋 找到以下 MCP 伺服器:"
    echo "$servers" | while read -r server; do
        echo "  - $server"
    done
    
    # 導入每個伺服器
    echo ""
    echo "🚀 開始導入 MCP 伺服器..."
    
    echo "$servers" | while read -r server; do
        echo "正在導入: $server"
        
        # 提取伺服器配置
        command=$(jq -r ".mcpServers.$server.command" "$DESKTOP_CONFIG")
        args=$(jq -r ".mcpServers.$server.args | join(\" \")" "$DESKTOP_CONFIG")
        
        # 構建 JSON 配置
        json_config="{\"type\":\"stdio\",\"command\":\"$command\",\"args\":[\"$(echo $args | sed 's/ /","/g')\"],\"env\":{}}"
        
        # 添加到 Claude Code
        if claude mcp add-json "$server" "$json_config" > /dev/null 2>&1; then
            echo "  ✅ $server 導入成功"
        else
            echo "  ❌ $server 導入失敗"
        fi
    done
    
else
    echo "⚠️  jq 未安裝，使用手動配置..."
    echo "請手動執行以下命令來導入 MCP 伺服器:"
    echo ""
    echo "# 導入 puppeteer"
    echo "claude mcp add-json puppeteer '{\"type\":\"stdio\",\"command\":\"npx\",\"args\":[\"-y\",\"@modelcontextprotocol/server-puppeteer\",\"--no-sandbox\"],\"env\":{}}'"
    echo ""
    echo "# 導入 context7"
    echo "claude mcp add-json context7 '{\"type\":\"stdio\",\"command\":\"npx\",\"args\":[\"-y\",\"@upstash/context7-mcp@latest\"],\"env\":{}}'"
    echo ""
    echo "# 導入 time"
    echo "claude mcp add-json time '{\"type\":\"stdio\",\"command\":\"uvx\",\"args\":[\"mcp-server-time\",\"--local-timezone=Asia/Taipei\"],\"env\":{}}'"
    echo ""
    echo "# 導入 fetch"
    echo "claude mcp add-json fetch '{\"type\":\"stdio\",\"command\":\"uvx\",\"args\":[\"mcp-server-fetch\"],\"env\":{}}'"
    echo ""
    echo "# 導入 sequential-thinking"
    echo "claude mcp add-json sequential-thinking '{\"type\":\"stdio\",\"command\":\"npx\",\"args\":[\"-y\",\"@modelcontextprotocol/server-sequential-thinking\"],\"env\":{}}'"
fi

echo ""
echo "✅ MCP 伺服器導入完成！"
echo ""
echo "📋 當前配置的 MCP 伺服器:"
claude mcp list

echo ""
echo "🔧 使用說明:"
echo "- 使用 /mcp 命令在 Claude Code 中管理 MCP 伺服器"
echo "- 使用 /mcp__servername__function 來執行 MCP 功能"
echo "- 例如: /mcp__time__get_current_time"
echo ""
echo "📚 更多資訊請參考: docs/mcp-setup-guide-zh-tw.md" 