#!/bin/bash

# Claude Code 文檔驗證腳本
# 自動檢查所有文檔連結有效性和內容一致性
# 作者：Claude Code 團隊
# 最後更新：2025-08-20T01:40:00+08:00

set -euo pipefail

# 顏色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# 配置
DOCS_DIR="docs"
VALIDATION_LOG="scripts/validation.log"
ERROR_COUNT=0
WARNING_COUNT=0
TIMESTAMP=$(date '+%Y-%m-%dT%H:%M:%S%z')

# 創建腳本目錄（如果不存在）
mkdir -p scripts

# 日誌函數
log() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $1" | tee -a "$VALIDATION_LOG"
}

warn() {
    echo -e "${YELLOW}[$(date '+%H:%M:%S')] ⚠️ ${NC} $1" | tee -a "$VALIDATION_LOG"
    ((WARNING_COUNT++))
}

error() {
    echo -e "${RED}[$(date '+%H:%M:%S')] ❌${NC} $1" | tee -a "$VALIDATION_LOG"
    ((ERROR_COUNT++))
}

success() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')] ✅${NC} $1" | tee -a "$VALIDATION_LOG"
}

info() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')] ℹ️ ${NC} $1" | tee -a "$VALIDATION_LOG"
}

# 檢查檔案是否存在
check_file_exists() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        error "檔案不存在: $file"
        return 1
    fi
    return 0
}

# 檢查 Markdown 檔案語法
check_markdown_syntax() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "檢查 Markdown 語法: $filename"
    
    # 檢查基本 YAML front matter
    if head -1 "$file" | grep -q "^---$"; then
        local yaml_end_line=$(grep -n "^---$" "$file" | sed -n '2p' | cut -d: -f1)
        if [[ -z "$yaml_end_line" ]]; then
            error "$filename: YAML front matter 未正確關閉"
        else
            success "$filename: YAML front matter 格式正確"
        fi
    else
        warn "$filename: 缺少 YAML front matter"
    fi
    
    # 檢查標題層級
    local prev_level=0
    while IFS= read -r line; do
        if [[ $line =~ ^(#+)([[:space:]]+)(.+) ]]; then
            local level=${#BASH_REMATCH[1]}
            local title="${BASH_REMATCH[3]}"
            
            if ((level > prev_level + 1)); then
                warn "$filename: 標題層級跳躍過大 (H$prev_level → H$level): $title"
            fi
            prev_level=$level
        fi
    done < "$file"
    
    # 檢查程式碼區塊配對
    local code_block_count=$(grep -c "^```" "$file" 2>/dev/null || echo "0")
    if ((code_block_count % 2 != 0)); then
        error "$filename: 程式碼區塊未正確關閉（發現 $code_block_count 個 \`\`\`）"
    fi
    
    # 檢查連結格式
    local malformed_links=$(grep -n "\[.*\]([^)]*[[:space:]][^)]*)" "$file" || true)
    if [[ -n "$malformed_links" ]]; then
        warn "$filename: 發現可能格式錯誤的連結:"
        echo "$malformed_links" | while read -r line; do
            warn "  $line"
        done
    fi
}

# 檢查內部連結
check_internal_links() {
    local file="$1"
    local filename=$(basename "$file")
    local base_dir=$(dirname "$file")
    
    log "檢查內部連結: $filename"
    
    # 提取所有內部連結 (相對路徑)
    local internal_links=$(grep -oE '\[([^\]]+)\]\(([^)]+)\)' "$file" | grep -E '\]\([^http]' || true)
    
    if [[ -n "$internal_links" ]]; then
        echo "$internal_links" | while IFS= read -r link; do
            # 提取連結路徑
            local link_path=$(echo "$link" | sed -E 's/.*\]\(([^)#]+).*/\1/')
            local full_path="$base_dir/$link_path"
            
            # 標準化路徑
            full_path=$(realpath -m "$full_path" 2>/dev/null || echo "$full_path")
            
            if [[ ! -f "$full_path" && ! -d "$full_path" ]]; then
                error "$filename: 內部連結失效: $link_path"
            fi
        done
    fi
}

# 檢查圖片連結
check_image_links() {
    local file="$1"
    local filename=$(basename "$file")
    local base_dir=$(dirname "$file")
    
    log "檢查圖片連結: $filename"
    
    # 提取圖片連結
    local image_links=$(grep -oE '!\[([^\]]*)\]\(([^)]+)\)' "$file" || true)
    
    if [[ -n "$image_links" ]]; then
        echo "$image_links" | while IFS= read -r img; do
            local img_path=$(echo "$img" | sed -E 's/.*\]\(([^)]+)\).*/\1/')
            
            # 跳過 HTTP 連結
            if [[ $img_path =~ ^https?:// ]]; then
                continue
            fi
            
            local full_img_path="$base_dir/$img_path"
            full_img_path=$(realpath -m "$full_img_path" 2>/dev/null || echo "$full_img_path")
            
            if [[ ! -f "$full_img_path" ]]; then
                error "$filename: 圖片檔案不存在: $img_path"
            else
                # 檢查圖片檔案大小
                local img_size=$(stat -f%z "$full_img_path" 2>/dev/null || stat -c%s "$full_img_path" 2>/dev/null || echo "0")
                if ((img_size > 5000000)); then  # 5MB
                    warn "$filename: 圖片檔案過大 ($(((img_size / 1024 / 1024)))MB): $img_path"
                fi
            fi
        done
    fi
}

# 檢查外部連結（基本可達性）
check_external_links() {
    local file="$1"
    local filename=$(basename "$file")
    
    # 跳過外部連結檢查（如果設定）
    if [[ "${SKIP_EXTERNAL:-}" == "true" ]]; then
        return 0
    fi
    
    log "檢查外部連結可達性: $filename"
    
    # 提取 HTTP/HTTPS 連結
    local external_links=$(grep -oE 'https?://[^)\s]+' "$file" | sort -u || true)
    
    if [[ -n "$external_links" ]]; then
        echo "$external_links" | while IFS= read -r url; do
            # 清理 URL（移除尾隨符號）
            url=$(echo "$url" | sed 's/[.,;)]$//')
            
            # 基本可達性檢查（HEAD 請求）
            if command -v curl >/dev/null; then
                local status_code=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 -L "$url" 2>/dev/null || echo "000")
                if [[ $status_code =~ ^[45] ]]; then
                    warn "$filename: 外部連結可能失效 (HTTP $status_code): $url"
                elif [[ $status_code == "000" ]]; then
                    warn "$filename: 外部連結無法訪問: $url"
                fi
            fi
        done
    fi
}

# 檢查文檔結構一致性
check_document_structure() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "檢查文檔結構: $filename"
    
    # 檢查是否有主標題
    if ! grep -q "^# " "$file"; then
        warn "$filename: 缺少主標題 (H1)"
    fi
    
    # 檢查中文標點符號使用
    local wrong_punctuation=$(grep -n "[,.]" "$file" | grep -v "```" | head -5 || true)
    if [[ -n "$wrong_punctuation" ]]; then
        warn "$filename: 發現可能的中英文標點混用:"
        echo "$wrong_punctuation" | while IFS= read -r line; do
            warn "  行 $line"
        done
    fi
    
    # 檢查表格格式
    local table_lines=$(grep -n "|" "$file" | head -1 || true)
    if [[ -n "$table_lines" ]]; then
        # 檢查表格標頭分隔線
        local table_start_line=$(echo "$table_lines" | cut -d: -f1)
        local next_line=$((table_start_line + 1))
        local separator_line=$(sed -n "${next_line}p" "$file")
        
        if [[ ! $separator_line =~ ^[|:[:space:]-]+$ ]]; then
            warn "$filename: 表格可能缺少標頭分隔線（行 $next_line）"
        fi
    fi
}

# 檢查版本資訊一致性
check_version_consistency() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "檢查版本資訊: $filename"
    
    # 檢查是否有版本或日期資訊
    local has_version=$(grep -E "(版本|version|v[0-9])" "$file" >/dev/null && echo "yes" || echo "no")
    local has_date=$(grep -E "20[0-9]{2}-[0-9]{2}-[0-9]{2}" "$file" >/dev/null && echo "yes" || echo "no")
    
    if [[ $has_version == "no" && $has_date == "no" ]]; then
        warn "$filename: 缺少版本或日期資訊"
    fi
    
    # 檢查日期格式一致性
    local date_formats=$(grep -oE "20[0-9]{2}-[0-9]{2}-[0-9]{2}[T ][0-9]{2}:[0-9]{2}:[0-9]{2}[+\-][0-9]{2}:[0-9]{2}" "$file" | sort -u || true)
    local date_count=$(echo "$date_formats" | wc -l | tr -d ' ')
    
    if [[ -n "$date_formats" && $date_count -gt 3 ]]; then
        warn "$filename: 日期格式不一致，發現 $date_count 種不同格式"
    fi
}

# 檢查文檔完整性
check_content_quality() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "檢查內容品質: $filename"
    
    # 檢查檔案大小
    local file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")
    if ((file_size < 500)); then
        warn "$filename: 檔案內容過少 (${file_size} bytes)"
    elif ((file_size > 500000)); then  # 500KB
        warn "$filename: 檔案過大 ($(((file_size / 1024)))KB)"
    fi
    
    # 檢查是否有 TODO 或 FIXME
    local todos=$(grep -in "TODO\|FIXME\|XXX" "$file" || true)
    if [[ -n "$todos" ]]; then
        warn "$filename: 發現未完成項目:"
        echo "$todos" | while IFS= read -r todo; do
            warn "  $todo"
        done
    fi
    
    # 檢查重複標題
    local headers=$(grep "^#" "$file" | sort | uniq -d || true)
    if [[ -n "$headers" ]]; then
        warn "$filename: 發現重複標題:"
        echo "$headers" | while IFS= read -r header; do
            warn "  $header"
        done
    fi
}

# 驗證特定檔案類型
validate_specific_files() {
    log "驗證特定檔案類型..."
    
    # 檢查 README.md
    if [[ -f "README.md" ]]; then
        log "驗證主 README.md"
        if ! grep -q "Claude Code" "README.md"; then
            warn "README.md: 缺少 Claude Code 關鍵字"
        fi
        
        if ! grep -q "安裝\|Installation" "README.md"; then
            warn "README.md: 缺少安裝說明"
        fi
    fi
    
    # 檢查 docs/README.md
    if [[ -f "docs/README.md" ]]; then
        log "驗證 docs/README.md"
        local doc_count=$(ls docs/*-zh-tw.md 2>/dev/null | wc -l | tr -d ' ')
        if ! grep -q "$doc_count" "docs/README.md"; then
            warn "docs/README.md: 文檔數量可能未同步（實際: ${doc_count}）"
        fi
    fi
    
    # 檢查 index.html
    if [[ -f "index.html" ]]; then
        log "驗證 index.html"
        if ! grep -q "Claude Code" "index.html"; then
            warn "index.html: 缺少 Claude Code 關鍵字"
        fi
        
        # 檢查 HTML 基本語法
        local unclosed_tags=$(grep -o "<[^/>][^>]*>" "index.html" | grep -v "meta\|link\|img\|br\|hr\|input" | sort | uniq -c | awk '$1 % 2 != 0 {print $2}' || true)
        if [[ -n "$unclosed_tags" ]]; then
            warn "index.html: 可能有未閉合的 HTML 標籤: $unclosed_tags"
        fi
    fi
}

# 生成驗證報告
generate_validation_report() {
    log "生成驗證報告..."
    
    local report_file="scripts/validation-report.md"
    local total_files=$(find "$DOCS_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    
    cat > "$report_file" << EOF
# Claude Code 文檔驗證報告

**驗證時間**: $TIMESTAMP  
**檢查檔案數**: $total_files  
**錯誤數**: $ERROR_COUNT  
**警告數**: $WARNING_COUNT  

## 驗證摘要

EOF

    if ((ERROR_COUNT == 0 && WARNING_COUNT == 0)); then
        echo "✅ **所有檢查通過** - 文檔品質良好" >> "$report_file"
    elif ((ERROR_COUNT == 0)); then
        echo "⚠️ **檢查完成** - $WARNING_COUNT 個警告項目需要注意" >> "$report_file"
    else
        echo "❌ **發現問題** - $ERROR_COUNT 個錯誤和 $WARNING_COUNT 個警告需要修復" >> "$report_file"
    fi
    
    cat >> "$report_file" << EOF

## 檢查項目

- ✅ Markdown 語法檢查
- ✅ 內部連結驗證
- ✅ 圖片連結檢查
- ✅ 外部連結可達性
- ✅ 文檔結構分析
- ✅ 版本資訊一致性
- ✅ 內容品質評估
- ✅ 特定檔案驗證

## 詳細日誌

詳細驗證日誌請查看: \`$VALIDATION_LOG\`

## 建議修復

EOF

    if ((ERROR_COUNT > 0)); then
        echo "**高優先級**（錯誤）:" >> "$report_file"
        echo "- 修復失效的內部連結" >> "$report_file"
        echo "- 修正 Markdown 語法錯誤" >> "$report_file"
        echo "- 補充缺失的檔案" >> "$report_file"
        echo "" >> "$report_file"
    fi
    
    if ((WARNING_COUNT > 0)); then
        echo "**中優先級**（警告）:" >> "$report_file"
        echo "- 統一日期時間格式" >> "$report_file"
        echo "- 補充版本資訊" >> "$report_file"
        echo "- 優化圖片大小" >> "$report_file"
        echo "- 修正標點符號使用" >> "$report_file"
    fi
    
    cat >> "$report_file" << EOF

---
*此報告由 Claude Code 文檔驗證腳本自動生成*
EOF

    success "驗證報告已生成: $report_file"
}

# 主要驗證流程
validate_documents() {
    log "開始文檔驗證流程..."
    
    # 檢查 docs 目錄是否存在
    if [[ ! -d "$DOCS_DIR" ]]; then
        error "文檔目錄不存在: $DOCS_DIR"
        return 1
    fi
    
    # 計算總檔案數
    local total_files=$(find "$DOCS_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    log "找到 $total_files 個 Markdown 檔案"
    
    # 驗證每個 Markdown 檔案
    while IFS= read -r file; do
        if check_file_exists "$file"; then
            check_markdown_syntax "$file"
            check_internal_links "$file"
            check_image_links "$file"
            check_external_links "$file"
            check_document_structure "$file"
            check_version_consistency "$file"
            check_content_quality "$file"
        fi
    done < <(find "$DOCS_DIR" -name "*.md")
    
    # 驗證根目錄特定檔案
    if [[ -f "README.md" ]]; then
        check_file_exists "README.md"
        check_markdown_syntax "README.md"
        check_internal_links "README.md"
    fi
    
    # 驗證特定檔案類型
    validate_specific_files
}

# 快速修復功能
quick_fix() {
    log "執行快速修復..."
    
    # 修復常見的 Markdown 格式問題
    find "$DOCS_DIR" -name "*.md" -exec sed -i '' 's/，\([a-zA-Z]\)/， \1/g' {} \; 2>/dev/null || true
    find "$DOCS_DIR" -name "*.md" -exec sed -i '' 's/\([a-zA-Z]\)，/\1，/g' {} \; 2>/dev/null || true
    
    success "快速修復完成"
}

# 主程式
main() {
    echo -e "${BOLD}${BLUE}Claude Code 文檔驗證系統${NC}"
    echo -e "${BLUE}自動檢查連結、語法、結構與內容品質${NC}"
    echo -e "${BLUE}================================================${NC}"
    
    # 初始化日誌
    echo "=== 文檔驗證開始: $TIMESTAMP ===" > "$VALIDATION_LOG"
    
    # 執行驗證
    validate_documents
    
    # 生成報告
    generate_validation_report
    
    # 顯示結果摘要
    echo -e "${BOLD}${BLUE}📊 驗證結果摘要${NC}"
    echo -e "${BOLD}${RED}❌ 錯誤: $ERROR_COUNT${NC}"
    echo -e "${BOLD}${YELLOW}⚠️  警告: $WARNING_COUNT${NC}"
    
    if ((ERROR_COUNT == 0 && WARNING_COUNT == 0)); then
        echo -e "${BOLD}${GREEN}🎉 所有檢查通過！${NC}"
        exit 0
    elif ((ERROR_COUNT == 0)); then
        echo -e "${BOLD}${YELLOW}⚠️  有 $WARNING_COUNT 個警告需要注意${NC}"
        exit 0
    else
        echo -e "${BOLD}${RED}❌ 發現 $ERROR_COUNT 個錯誤需要修復${NC}"
        exit 1
    fi
}

# 參數處理
case "${1:-}" in
    "--help"|"-h")
        echo "Claude Code 文檔驗證腳本"
        echo ""
        echo "用法: $0 [選項]"
        echo ""
        echo "選項:"
        echo "  --help, -h        顯示此幫助訊息"
        echo "  --quick-fix       執行快速修復"
        echo "  --external-only   僅檢查外部連結"
        echo "  --no-external     跳過外部連結檢查"
        echo ""
        exit 0
        ;;
    "--quick-fix")
        quick_fix
        exit 0
        ;;
    "--external-only")
        log "僅檢查外部連結"
        find "$DOCS_DIR" -name "*.md" | while IFS= read -r file; do
            check_external_links "$file"
        done
        generate_validation_report
        exit 0
        ;;
    "--no-external")
        # 設定標誌跳過外部連結檢查
        SKIP_EXTERNAL="true"
        main
        ;;
    "")
        # 正常執行
        main
        ;;
    *)
        error "未知參數: $1"
        echo "使用 --help 查看可用選項"
        exit 1
        ;;
esac
