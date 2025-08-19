#!/bin/bash

# Claude Code 自動化版本同步機制
# 基於 semantic-release 最佳實踐建立的版本管理工具
# 作者：Claude Code 團隊
# 最後更新：2025-08-20T01:27:23+08:00

set -euo pipefail

# 顏色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# 配置
ANALYSIS_DIR="analysis-projects"
DOCS_DIR="docs"
VERSION_LOG="scripts/version-sync.log"
TIMESTAMP=$(date '+%Y-%m-%dT%H:%M:%S%z')

# 創建腳本目錄（如果不存在）
mkdir -p scripts

# 日誌函數
log() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $1" | tee -a "$VERSION_LOG"
}

warn() {
    echo -e "${YELLOW}[$(date '+%H:%M:%S')] ⚠️ ${NC} $1" | tee -a "$VERSION_LOG"
}

error() {
    echo -e "${RED}[$(date '+%H:%M:%S')] ❌${NC} $1" | tee -a "$VERSION_LOG"
}

success() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')] ✅${NC} $1" | tee -a "$VERSION_LOG"
}

info() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')] ℹ️ ${NC} $1" | tee -a "$VERSION_LOG"
}

# 檢查專案目錄是否存在
check_analysis_dir() {
    if [[ ! -d "$ANALYSIS_DIR" ]]; then
        error "Analysis 目錄不存在: $ANALYSIS_DIR"
        exit 1
    fi
    log "Analysis 目錄確認存在: $ANALYSIS_DIR"
}

# 獲取 Git 版本資訊
get_git_version() {
    local project_dir="$1"
    local project_name="$2"
    
    cd "$project_dir" 2>/dev/null || {
        warn "無法進入目錄: $project_dir"
        echo "unknown"
        return
    }
    
    # 優先順序：1. 最新 tag 2. package.json version 3. 最後 commit 日期
    local version=""
    
    # 1. 嘗試獲取最新 Git Tag
    if git tag --sort=-version:refname 2>/dev/null | head -1 | grep -q .; then
        version=$(git tag --sort=-version:refname | head -1)
        echo "$version"
        return
    fi
    
    # 2. 嘗試讀取 package.json 版本
    if [[ -f "package.json" ]] && command -v jq >/dev/null; then
        local pkg_version=$(jq -r '.version // empty' package.json 2>/dev/null)
        if [[ -n "$pkg_version" && "$pkg_version" != "null" ]]; then
            echo "v$pkg_version"
            return
        fi
    fi
    
    # 3. 嘗試讀取 Cargo.toml 版本（Rust 專案）
    if [[ -f "Cargo.toml" ]]; then
        local cargo_version=$(grep '^version = ' Cargo.toml | head -1 | sed 's/version = "\(.*\)"/v\1/')
        if [[ -n "$cargo_version" ]]; then
            echo "$cargo_version"
            return
        fi
    fi
    
    # 4. 回傳最後更新日期
    local last_commit_date=$(git log -1 --format=%cI 2>/dev/null || echo "unknown")
    echo "$last_commit_date"
}

# 獲取專案最後更新時間
get_last_update() {
    local project_dir="$1"
    
    cd "$project_dir" 2>/dev/null || {
        echo "unknown"
        return
    }
    
    git log -1 --format=%cI 2>/dev/null || echo "unknown"
}

# 掃描所有專案並收集版本資訊
scan_projects() {
    log "開始掃描專案版本資訊..."
    
    local projects_data="{"
    local count=0
    
    for project_path in "$ANALYSIS_DIR"/*; do
        if [[ -d "$project_path" ]]; then
            local project_name=$(basename "$project_path")
            local current_dir=$(pwd)
            
            log "掃描專案: $project_name"
            
            # 獲取版本和更新時間
            local version=$(get_git_version "$project_path" "$project_name")
            local last_update=$(get_last_update "$project_path")
            
            cd "$current_dir"
            
            # 建立 JSON 格式的專案資料
            if [[ $count -gt 0 ]]; then
                projects_data="${projects_data},"
            fi
            projects_data="${projects_data}\"$project_name\":{\"version\":\"$version\",\"last_update\":\"$last_update\"}"
            
            info "  版本: $version"
            info "  更新: $last_update"
            
            ((count++))
        fi
    done
    
    projects_data="${projects_data}}"
    echo "$projects_data"
}

# 更新文檔中的版本資訊
update_doc_version() {
    local doc_file="$1"
    local project_name="$2"
    local version="$3"
    local last_update="$4"
    
    if [[ ! -f "$doc_file" ]]; then
        warn "文檔檔案不存在: $doc_file"
        return
    fi
    
    log "更新文檔: $doc_file"
    
    # 建立備份
    cp "$doc_file" "$doc_file.backup"
    
    # 更新版本資訊（使用更彈性的 sed 命令）
    if [[ "$version" =~ ^v[0-9] ]]; then
        # 如果是版本號格式
        sed -i '' "s/版本：[^|]*/版本：$version/g" "$doc_file" 2>/dev/null || true
        sed -i '' "s/版本: [^|]*/版本: $version/g" "$doc_file" 2>/dev/null || true
    fi
    
    # 更新最後更新時間
    sed -i '' "s/專案最後更新：[^|]*/專案最後更新：$last_update/g" "$doc_file" 2>/dev/null || true
    sed -i '' "s/專案最後更新: [^|]*/專案最後更新: $last_update/g" "$doc_file" 2>/dev/null || true
    
    # 更新文檔修改時間
    sed -i '' "s/最後更新：[0-9T:+-]*/最後更新：$TIMESTAMP/g" "$doc_file" 2>/dev/null || true
    sed -i '' "s/最後更新: [0-9T:+-]*/最後更新: $TIMESTAMP/g" "$doc_file" 2>/dev/null || true
    
    success "  已更新 $doc_file"
}

# 文檔映射函數（專案名稱轉換為文檔檔名）
get_doc_filename() {
    local project_name="$1"
    
    case "$project_name" in
        "Claude-Code-Usage-Monitor") echo "claude-code-usage-monitor-zh-tw.md" ;;
        "agents") echo "agents-zh-tw.md" ;;
        "awesome-claude-code") echo "awesome-claude-code-zh-tw.md" ;;
        "SuperClaude_Framework") echo "superclaude-zh-tw.md" ;;
        "claude-code-guide") echo "claude-code-guide-zh-tw.md" ;;
        "claudecodeui") echo "claudecodeui-zh-tw.md" ;;
        "BPlusTree3") echo "bplustree3-zh-tw.md" ;;
        "claudia") echo "claudia-zh-tw.md" ;;
        "claude-code-hooks") echo "claude-code-hooks-zh-tw.md" ;;
        "claude-code-spec") echo "claude-code-spec-zh-tw.md" ;;
        "ccusage") echo "ccusage-zh-tw.md" ;;
        "vibe-kanban") echo "vibe-kanban-zh-tw.md" ;;
        "claude-agents") echo "claude-agents-zh-tw.md" ;;
        "ClaudeCode-Debugger") echo "claudecode-debugger-zh-tw.md" ;;
        "claude-code-leaderboard") echo "claude-code-leaderboard-zh-tw.md" ;;
        "context-engineering-intro") echo "context-engineering-intro-zh-tw.md" ;;
        "contains-studio-agents") echo "contains-studio-agents-zh-tw.md" ;;
        "claude-code-security-review") echo "claude-code-security-review-zh-tw.md" ;;
        *) echo "" ;;
    esac
}

# 執行版本同步
sync_versions() {
    log "開始執行版本同步..."
    
    # 掃描專案
    local projects_json=$(scan_projects)
    
    # 儲存專案資訊到暫存檔案
    echo "$projects_json" > "scripts/projects-versions.json"
    
    # 更新對應的文檔
    for project_path in "$ANALYSIS_DIR"/*; do
        if [[ -d "$project_path" ]]; then
            local project_name=$(basename "$project_path")
            local doc_filename=$(get_doc_filename "$project_name")
            
            if [[ -n "$doc_filename" ]]; then
                local doc_file="$DOCS_DIR/$doc_filename"
                
                # 從 JSON 中提取專案資訊
                if command -v jq >/dev/null; then
                    local version=$(echo "$projects_json" | jq -r ".[\"$project_name\"].version // \"unknown\"")
                    local last_update=$(echo "$projects_json" | jq -r ".[\"$project_name\"].last_update // \"unknown\"")
                else
                    # 備用方案：簡單字串解析
                    local version="unknown"
                    local last_update="unknown"
                fi
                
                if [[ "$version" != "unknown" && "$last_update" != "unknown" ]]; then
                    update_doc_version "$doc_file" "$project_name" "$version" "$last_update"
                else
                    warn "跳過專案 $project_name (版本資訊不完整)"
                fi
            else
                info "專案 $project_name 無對應文檔"
            fi
        fi
    done
    
    success "版本同步完成！"
}

# 生成同步報告
generate_report() {
    log "生成同步報告..."
    
    local report_file="scripts/version-sync-report.md"
    
    cat > "$report_file" << EOF
# Claude Code 版本同步報告

**同步時間**: $TIMESTAMP  
**掃描專案數**: $(find "$ANALYSIS_DIR" -maxdepth 1 -type d | wc -l | tr -d ' ')  
**更新文檔數**: $(ls "$DOCS_DIR"/*-zh-tw.md 2>/dev/null | wc -l | tr -d ' ')  

## 專案版本資訊

| 專案名稱 | 版本 | 最後更新 | 文檔狀態 |
|----------|------|----------|----------|
EOF

    # 讀取專案版本資訊並生成表格
    if [[ -f "scripts/projects-versions.json" ]] && command -v jq >/dev/null; then
        while IFS= read -r project; do
            local project_name=$(echo "$project" | jq -r '.key')
            local version=$(echo "$project" | jq -r '.value.version')
            local last_update=$(echo "$project" | jq -r '.value.last_update')
            local doc_status="❌"
            local doc_filename=$(get_doc_filename "$project_name")
            
            if [[ -n "$doc_filename" ]] && [[ -f "$DOCS_DIR/$doc_filename" ]]; then
                doc_status="✅"
            fi
            
            echo "| $project_name | $version | $last_update | $doc_status |" >> "$report_file"
        done < <(jq -r 'to_entries[] | @json' "scripts/projects-versions.json")
    fi
    
    cat >> "$report_file" << EOF

## 同步規則

- ✅ 已同步：專案有對應文檔且版本已更新
- ❌ 未同步：專案無對應文檔或版本資訊不完整

## 同步日誌

詳細同步日誌請查看: \`$VERSION_LOG\`

---
*此報告由 Claude Code 自動化版本同步機制生成*
EOF

    success "同步報告已生成: $report_file"
}

# 清理功能
cleanup() {
    log "清理暫存檔案..."
    rm -f scripts/projects-versions.json
    
    # 清理備份檔案（保留最近 3 個）
    find "$DOCS_DIR" -name "*.backup" -type f -exec ls -t {} + | tail -n +4 | xargs rm -f 2>/dev/null || true
    
    success "清理完成"
}

# 主程式
main() {
    echo -e "${BOLD}${BLUE}Claude Code 自動化版本同步機制${NC}"
    echo -e "${BLUE}基於 semantic-release 最佳實踐${NC}"
    echo -e "${BLUE}========================================${NC}"
    
    # 初始化日誌
    echo "=== 版本同步開始: $TIMESTAMP ===" > "$VERSION_LOG"
    
    # 檢查依賴
    check_analysis_dir
    
    # 執行同步
    sync_versions
    
    # 生成報告
    generate_report
    
    # 清理
    cleanup
    
    echo -e "${BOLD}${GREEN}🎉 版本同步機制執行完成！${NC}"
    echo -e "${GREEN}📊 報告檔案: scripts/version-sync-report.md${NC}"
    echo -e "${GREEN}📋 日誌檔案: $VERSION_LOG${NC}"
}

# 參數處理
case "${1:-}" in
    "--help"|"-h")
        echo "Claude Code 自動化版本同步機制"
        echo ""
        echo "用法: $0 [選項]"
        echo ""
        echo "選項:"
        echo "  --help, -h     顯示此幫助訊息"
        echo "  --dry-run      僅掃描不更新"
        echo "  --report       只生成報告"
        echo ""
        exit 0
        ;;
    "--dry-run")
        log "執行模擬掃描（不會更新檔案）"
        check_analysis_dir
        scan_projects
        exit 0
        ;;
    "--report")
        log "僅生成報告"
        generate_report
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
