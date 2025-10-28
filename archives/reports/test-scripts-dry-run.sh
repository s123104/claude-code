#!/bin/bash
# 腳本乾模式測試
# 測試所有保留的腳本功能

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🧪 開始乾模式測試保留的腳本..."
echo ""

# 測試 1: batch-sync-projects.sh
echo -e "${YELLOW}測試 1: batch-sync-projects.sh${NC}"
if bash -n batch-sync-projects.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

# 測試 2: sync-versions.sh
echo -e "${YELLOW}測試 2: sync-versions.sh${NC}"
if bash -n sync-versions.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

# 測試 3: validate-docs.sh
echo -e "${YELLOW}測試 3: validate-docs.sh${NC}"
if bash -n validate-docs.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

# 測試 4: update-all-docs.sh  
echo -e "${YELLOW}測試 4: update-all-docs.sh${NC}"
if bash -n update-all-docs.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

# 測試 5: setup-git-hooks.sh
echo -e "${YELLOW}測試 5: setup-git-hooks.sh${NC}"
if bash -n setup-git-hooks.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

# 測試 6: import-mcp-servers.sh
echo -e "${YELLOW}測試 6: import-mcp-servers.sh${NC}"
if bash -n import-mcp-servers.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

# 測試 7: quality-checker.js (Node.js 語法檢查)
echo -e "${YELLOW}測試 7: quality-checker.js${NC}"
if node --check quality-checker.js 2>&1 | grep -q "Syntax"; then
    echo -e "${RED}✗ 語法錯誤${NC}"
else
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
fi
echo ""

# 測試 8: doc-sync/enhanced-doc-sync.js
echo -e "${YELLOW}測試 8: doc-sync/enhanced-doc-sync.js${NC}"
if node --check doc-sync/enhanced-doc-sync.js 2>&1 | grep -q "Syntax"; then
    echo -e "${RED}✗ 語法錯誤${NC}"
else
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
fi
echo ""

# 測試 9: doc-sync/sync-docs.sh
echo -e "${YELLOW}測試 9: doc-sync/sync-docs.sh${NC}"
if bash -n doc-sync/sync-docs.sh; then
    echo -e "${GREEN}✓ 語法檢查通過${NC}"
else
    echo -e "${RED}✗ 語法錯誤${NC}"
fi
echo ""

echo -e "${GREEN}✅ 所有腳本乾模式測試完成！${NC}"
