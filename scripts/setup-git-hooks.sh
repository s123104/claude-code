#!/bin/bash

# Git Hooks 設定腳本
# 建立 Conventional Commits 和文檔自動化 Git Hooks
# 作者：Claude Code 團隊
# 最後更新：2025-08-20T01:50:00+08:00

set -euo pipefail

# 顏色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'

log() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[$(date '+%H:%M:%S')] ⚠️ ${NC} $1"
}

error() {
    echo -e "${RED}[$(date '+%H:%M:%S')] ❌${NC} $1"
}

success() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')] ✅${NC} $1"
}

info() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')] ℹ️ ${NC} $1"
}

# 檢查 Git 倉庫
check_git_repo() {
    if [[ ! -d ".git" ]]; then
        error "當前目錄不是 Git 倉庫"
        exit 1
    fi
    log "確認 Git 倉庫存在"
}

# 創建 commitlint 配置
create_commitlint_config() {
    log "創建 commitlint 配置..."
    
    cat > "commitlint.config.js" << 'EOF'
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'build',
        'chore',
        'ci',
        'docs',
        'feat',
        'fix',
        'perf',
        'refactor',
        'revert',
        'style',
        'test'
      ]
    ],
    'subject-case': [2, 'never', ['pascal-case', 'upper-case']],
    'subject-max-length': [2, 'always', 100],
    'body-max-line-length': [2, 'always', 100],
    'footer-max-line-length': [2, 'always', 100]
  }
}
EOF
    
    success "commitlint 配置檔案已創建"
}

# 創建 package.json（如果不存在）
create_package_json() {
    if [[ ! -f "package.json" ]]; then
        log "創建 package.json..."
        
        cat > "package.json" << 'EOF'
{
  "name": "claude-code-ecosystem",
  "version": "1.0.0",
  "description": "Claude Code 完整生態系統中文文檔",
  "scripts": {
    "version": "conventional-changelog -p angular -i CHANGELOG.md -s && git add CHANGELOG.md",
    "lint:commit": "commitlint --edit",
    "validate:docs": "./scripts/validate-docs.sh",
    "sync:versions": "./scripts/sync-versions.sh",
    "prepare": "husky install || true"
  },
  "devDependencies": {
    "@commitlint/cli": "^17.0.0",
    "@commitlint/config-conventional": "^17.0.0",
    "conventional-changelog-cli": "^3.0.0",
    "husky": "^8.0.0"
  },
  "keywords": [
    "claude-code",
    "anthropic",
    "ai",
    "documentation",
    "chinese",
    "traditional-chinese"
  ],
  "author": "Claude Code 團隊",
  "license": "MIT"
}
EOF
        
        success "package.json 已創建"
    else
        info "package.json 已存在，跳過創建"
    fi
}

# 創建 commit-msg hook
create_commit_msg_hook() {
    local hook_file=".git/hooks/commit-msg"
    
    log "創建 commit-msg hook..."
    
    cat > "$hook_file" << 'EOF'
#!/bin/sh
# Claude Code Commit Message Hook
# 驗證提交訊息是否符合 Conventional Commits 規範

# 顏色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 檢查是否有 commitlint
if command -v npx >/dev/null && [ -f "commitlint.config.js" ]; then
    echo "🔍 驗證提交訊息格式..."
    if ! npx commitlint --edit "$1"; then
        echo -e "${RED}❌ 提交訊息不符合 Conventional Commits 規範${NC}"
        echo -e "${YELLOW}📖 請參考格式：${NC}"
        echo "   feat: 新增功能"
        echo "   fix: 修復錯誤"
        echo "   docs: 文檔更新"
        echo "   style: 程式碼格式"
        echo "   refactor: 重構"
        echo "   test: 測試相關"
        echo "   chore: 建置或輔助工具"
        echo ""
        echo -e "${YELLOW}💡 範例：${NC}"
        echo "   feat(mcp): 新增企業級 MCP 伺服器整合"
        echo "   fix(docs): 修復文檔連結失效問題"
        echo "   docs: 更新 README.md 統計數據"
        exit 1
    fi
    echo -e "${GREEN}✅ 提交訊息格式正確${NC}"
else
    echo -e "${YELLOW}⚠️  commitlint 未安裝，跳過格式驗證${NC}"
fi

# 檢查提交訊息長度
commit_msg=$(cat "$1")
subject=$(echo "$commit_msg" | head -1)

if [ ${#subject} -gt 100 ]; then
    echo -e "${RED}❌ 提交標題過長（${#subject}/100 字符）${NC}"
    echo -e "${YELLOW}💡 請縮短提交標題長度${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 提交訊息驗證通過${NC}"
EOF
    
    chmod +x "$hook_file"
    success "commit-msg hook 已創建並設定權限"
}

# 創建 pre-commit hook
create_pre_commit_hook() {
    local hook_file=".git/hooks/pre-commit"
    
    log "創建 pre-commit hook..."
    
    cat > "$hook_file" << 'EOF'
#!/bin/sh
# Claude Code Pre-commit Hook
# 在提交前執行文檔驗證和格式檢查

# 顏色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 執行提交前檢查...${NC}"

# 檢查是否有待提交的文檔變更
if git diff --cached --name-only | grep -E "\.(md|html)$" > /dev/null; then
    echo -e "${YELLOW}📝 檢測到文檔變更，執行驗證...${NC}"
    
    # 如果文檔驗證腳本存在，執行快速驗證
    if [ -x "./scripts/validate-docs.sh" ]; then
        if ! ./scripts/validate-docs.sh --no-external > /dev/null 2>&1; then
            echo -e "${RED}❌ 文檔驗證失敗${NC}"
            echo -e "${YELLOW}💡 請執行以下指令檢查問題：${NC}"
            echo "   ./scripts/validate-docs.sh"
            exit 1
        fi
        echo -e "${GREEN}✅ 文檔驗證通過${NC}"
    else
        echo -e "${YELLOW}⚠️  文檔驗證腳本未找到，跳過驗證${NC}"
    fi
fi

# 檢查是否有版本相關變更
if git diff --cached --name-only | grep -E "(package\.json|.*version.*)" > /dev/null; then
    echo -e "${YELLOW}📦 檢測到版本相關變更...${NC}"
    
    # 如果版本同步腳本存在，執行檢查
    if [ -x "./scripts/sync-versions.sh" ]; then
        echo -e "${BLUE}🔄 建議執行版本同步：${NC}"
        echo "   ./scripts/sync-versions.sh"
    fi
fi

# 檢查大檔案
large_files=$(git diff --cached --name-only | xargs -I {} sh -c 'if [ -f "{}" ] && [ $(stat -f%z "{}" 2>/dev/null || stat -c%s "{}" 2>/dev/null || echo 0) -gt 5000000 ]; then echo "{}"; fi' 2>/dev/null)

if [ -n "$large_files" ]; then
    echo -e "${RED}❌ 檢測到大檔案（>5MB）：${NC}"
    echo "$large_files"
    echo -e "${YELLOW}💡 請考慮：${NC}"
    echo "   1. 使用 Git LFS 管理大檔案"
    echo "   2. 壓縮圖片或影片檔案"
    echo "   3. 將大檔案移至外部儲存"
    exit 1
fi

echo -e "${GREEN}🎉 所有預提交檢查通過${NC}"
EOF
    
    chmod +x "$hook_file"
    success "pre-commit hook 已創建並設定權限"
}

# 創建 post-commit hook
create_post_commit_hook() {
    local hook_file=".git/hooks/post-commit"
    
    log "創建 post-commit hook..."
    
    cat > "$hook_file" << 'EOF'
#!/bin/sh
# Claude Code Post-commit Hook
# 提交後自動執行相關維護任務

# 顏色配置
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}📝 提交完成，執行後續任務...${NC}"

# 獲取最新提交訊息
commit_msg=$(git log -1 --pretty=%s)

# 如果是版本提交，提醒生成 CHANGELOG
if echo "$commit_msg" | grep -E "(version|release|v[0-9])" > /dev/null; then
    echo -e "${GREEN}🔖 檢測到版本相關提交${NC}"
    echo -e "${BLUE}💡 建議更新 CHANGELOG：${NC}"
    echo "   conventional-changelog -p angular -i CHANGELOG.md -s"
fi

# 如果是文檔提交，提醒驗證
if echo "$commit_msg" | grep -E "(docs|documentation)" > /dev/null; then
    echo -e "${GREEN}📚 檢測到文檔相關提交${NC}"
    echo -e "${BLUE}💡 建議執行文檔驗證：${NC}"
    echo "   ./scripts/validate-docs.sh"
fi

echo -e "${GREEN}✨ 後續任務提醒完成${NC}"
EOF
    
    chmod +x "$hook_file"
    success "post-commit hook 已創建並設定權限"
}

# 安裝 Node.js 依賴
install_dependencies() {
    log "檢查 Node.js 依賴..."
    
    if command -v npm >/dev/null; then
        if [[ -f "package.json" ]]; then
            echo "📦 安裝 commitlint 和相關依賴..."
            npm install --save-dev @commitlint/cli @commitlint/config-conventional conventional-changelog-cli
            success "依賴安裝完成"
        fi
    else
        warn "npm 未安裝，請手動安裝以下依賴："
        echo "  npm install -g @commitlint/cli conventional-changelog-cli"
    fi
}

# 創建使用指南
create_usage_guide() {
    log "創建 Git Hooks 使用指南..."
    
    cat > "docs/git-hooks-guide.md" << 'EOF'
# Git Hooks 使用指南

本專案使用 Git Hooks 自動化代碼品質檢查和文檔維護流程。

## 已配置的 Hooks

### 1. commit-msg Hook
**功能**：驗證提交訊息格式
**觸發時機**：每次 `git commit` 時
**檢查項目**：
- Conventional Commits 格式驗證
- 提交標題長度檢查（≤100字符）

**範例格式**：
```
feat(scope): 描述新功能
fix(scope): 修復錯誤描述
docs: 更新文檔
style: 程式碼格式調整
refactor: 重構代碼
test: 新增或修改測試
chore: 建置或輔助工具變更
```

### 2. pre-commit Hook
**功能**：提交前品質檢查
**觸發時機**：每次 `git commit` 前
**檢查項目**：
- 文檔變更時執行文檔驗證
- 版本變更時提醒同步
- 大檔案檢查（>5MB 警告）

### 3. post-commit Hook
**功能**：提交後任務提醒
**觸發時機**：每次 `git commit` 後
**功能**：
- 版本提交時提醒更新 CHANGELOG
- 文檔提交時提醒執行驗證

## 使用方法

### 1. 正常提交流程
```bash
# 添加變更
git add .

# 提交（會自動觸發 hooks）
git commit -m "feat(mcp): 新增企業級 MCP 伺服器整合"
```

### 2. 跳過 Hooks（緊急情況）
```bash
# 跳過所有 hooks
git commit --no-verify -m "紧急修复"

# 只跳過 pre-commit
git commit --no-verify -m "fix: 緊急修復"
```

### 3. 手動執行檢查
```bash
# 手動驗證提交訊息
npx commitlint --edit .git/COMMIT_EDITMSG

# 手動執行文檔驗證
./scripts/validate-docs.sh

# 手動執行版本同步
./scripts/sync-versions.sh
```

## 故障排除

### 1. commitlint 錯誤
```bash
# 安裝依賴
npm install -g @commitlint/cli

# 檢查配置
cat commitlint.config.js
```

### 2. Hook 權限問題
```bash
# 重新設定權限
chmod +x .git/hooks/*
```

### 3. 禁用特定 Hook
```bash
# 重命名 hook 檔案
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled
```

## 最佳實踐

### 1. 提交訊息規範
- 使用英文動詞開頭（feat, fix, docs 等）
- 描述使用繁體中文
- 保持標題簡潔（≤50字符為佳）
- 詳細說明放在 body 中

### 2. 文檔維護
- 修改文檔後執行驗證腳本
- 定期同步版本資訊
- 保持連結有效性

### 3. 版本管理
- 遵循語義化版本控制
- 使用 conventional-changelog 生成 CHANGELOG
- 版本標籤格式：v1.2.3

---

*最後更新：2025-08-20T01:50:00+08:00*
EOF
    
    success "Git Hooks 使用指南已創建"
}

# 主程式
main() {
    echo -e "${BOLD}${BLUE}Claude Code Git Hooks 設定${NC}"
    echo -e "${BLUE}自動化提交品質檢查與文檔維護${NC}"
    echo -e "${BLUE}=====================================${NC}"
    
    check_git_repo
    create_package_json
    create_commitlint_config
    create_commit_msg_hook
    create_pre_commit_hook
    create_post_commit_hook
    install_dependencies
    create_usage_guide
    
    echo ""
    echo -e "${BOLD}${GREEN}🎉 Git Hooks 設定完成！${NC}"
    echo ""
    echo -e "${YELLOW}📋 已創建的檔案：${NC}"
    echo "  - .git/hooks/commit-msg"
    echo "  - .git/hooks/pre-commit" 
    echo "  - .git/hooks/post-commit"
    echo "  - commitlint.config.js"
    echo "  - package.json (如果不存在)"
    echo "  - docs/git-hooks-guide.md"
    echo ""
    echo -e "${YELLOW}📖 使用指南：${NC}"
    echo "  查看 docs/git-hooks-guide.md 了解詳細用法"
    echo ""
    echo -e "${YELLOW}🚀 下一步：${NC}"
    echo "  1. npm install  # 安裝依賴"
    echo "  2. git commit   # 測試 hooks"
    echo "  3. 查看使用指南了解更多功能"
}

# 參數處理
case "${1:-}" in
    "--help"|"-h")
        echo "Claude Code Git Hooks 設定腳本"
        echo ""
        echo "用法: $0 [選項]"
        echo ""
        echo "選項:"
        echo "  --help, -h     顯示此幫助訊息"
        echo "  --uninstall    移除所有 hooks"
        echo ""
        exit 0
        ;;
    "--uninstall")
        log "移除 Git Hooks..."
        rm -f .git/hooks/commit-msg .git/hooks/pre-commit .git/hooks/post-commit
        rm -f commitlint.config.js
        success "Git Hooks 已移除"
        exit 0
        ;;
    "")
        main
        ;;
    *)
        error "未知參數: $1"
        echo "使用 --help 查看可用選項"
        exit 1
        ;;
esac
