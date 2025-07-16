# start.sh 腳本函數依賴關係分析報告

## 1. 主要函數調用鏈和流程

### 主入口點
```
main_installation (line 1617)
└── 調用其他函數的主要協調器
```

### 完整調用鏈
```
main_installation (1617)
├── check_fast_mode (1442)
├── print_header (1606)
├── detect_os (395)
│   ├── detect_shell_config (466) - 內部函數
│   └── validate_shell_config (568) - 內部函數
├── main_diagnostic_and_repair (1534)
│   ├── start_timer (1424)
│   ├── check_system_environment (1481) - 重複定義，使用後者
│   │   ├── show_progress (1403)
│   │   ├── interactive_prompt (1450) - 重複定義，使用後者
│   │   └── clean_system_environment (323)
│   ├── check_npm_permissions (89)
│   │   ├── interactive_prompt (1450)
│   │   └── fix_npm_permissions_safe (134)
│   ├── check_nvm_npm_conflicts (172)
│   │   ├── interactive_prompt (1450)
│   │   └── fix_nvm_npm_conflicts (210)
│   ├── check_claude_cli_status (236)
│   │   ├── interactive_prompt (1450)
│   │   └── install_claude_code_fresh (1282)
│   ├── apply_security_best_practices (349)
│   └── end_timer (1428)
├── check_dependencies (723) - 非快速模式
├── check_disk_space (809) - 非快速模式
├── check_network_connectivity (755) - 非快速模式
├── check_system_resources (780) - 非快速模式
├── install_system_dependencies (834)
├── fix_npm_config (871)
├── install_nvm (959)
│   └── install_nvm_fresh (990)
│       └── configure_nvm_profile (1017)
├── install_nodejs (1080)
│   ├── install_nodejs_fresh (1102)
│   │   └── switch_to_target_version (1116)
│   └── verify_nodejs_installation (1142)
├── verify_nodejs_environment (1156)
├── configure_npm_global (1185)
├── install_claude_code (1262)
│   └── install_claude_code_fresh (1282)
├── verify_claude_installation (1300)
└── final_system_check (1323)
```

## 2. 函數間的依賴關係

### 日誌函數群組
```
log_info (31) ← 被所有函數廣泛使用
log_success (35) ← 被所有函數廣泛使用
log_warn (39) ← 被所有函數廣泛使用
log_error (43) ← 被所有函數廣泛使用
error_exit (48) ← 依賴 log_error 和 log_info

兼容函數：
warn (54) → log_warn
success (58) → log_success
info (62) → log_info
```

### 檢測與修復函數群組
```
check_npm_permissions (89)
├── 依賴：interactive_prompt, fix_npm_permissions_safe
└── 被調用：main_diagnostic_and_repair

fix_npm_permissions_safe (134)
├── 依賴：log_info, log_success, log_warn
└── 被調用：check_npm_permissions

check_nvm_npm_conflicts (172)
├── 依賴：interactive_prompt, fix_nvm_npm_conflicts
└── 被調用：main_diagnostic_and_repair

fix_nvm_npm_conflicts (210)
├── 依賴：log_info, log_success, log_warn
└── 被調用：check_nvm_npm_conflicts
```

### 安裝函數群組
```
install_nvm (959)
├── 依賴：install_nvm_fresh
└── 被調用：main_installation

install_nvm_fresh (990)
├── 依賴：configure_nvm_profile
└── 被調用：install_nvm

install_nodejs (1080)
├── 依賴：install_nodejs_fresh, switch_to_target_version, verify_nodejs_installation
└── 被調用：main_installation

install_claude_code (1262)
├── 依賴：install_claude_code_fresh
└── 被調用：main_installation
```

### 實用工具函數群組
```
interactive_prompt (重複定義：69, 1450)
├── 依賴：無
└── 被調用：多個檢測函數

show_progress (1403)
├── 依賴：無
└── 被調用：check_system_environment

start_timer/end_timer (1424/1428)
├── 依賴：無
└── 被調用：main_diagnostic_and_repair
```

## 3. 可能的循環依賴

**無發現直接循環依賴**，但有以下需要注意的情況：

### 重複函數定義
1. **interactive_prompt** 重複定義在第 69 行和第 1450 行
   - 功能類似但實現不同
   - 後定義的版本支援快速模式
   - 可能導致混淆和不一致的行為

2. **check_system_environment** 重複定義在第 277 行和第 1481 行
   - 第二個版本有進度顯示功能
   - 第一個版本較簡單

### 潛在的相互依賴
```
fix_npm_config (871) 和 configure_npm_global (1185)
├── 都處理 npm 配置
├── 可能產生配置衝突
└── 執行順序很重要
```

## 4. 未使用的函數

### Windows 相關函數（條件性使用）
```
check_windows_version (625) - 僅在 Windows 環境使用
check_virtualization (639) - 僅在 Windows 環境使用
enable_windows_features (658) - 僅在 Windows 環境使用
fix_wsl_issues (682) - 僅在 Windows 環境使用
install_wsl_distro (698) - 僅在 Windows 環境使用
```

這些函數在條件塊 (line 1378-1395) 中使用，但由於邏輯判斷錯誤，實際上**永遠不會被執行**：

```bash
# 第 1378 行的邏輯錯誤
if [[ "$SYSTEM_TYPE" == "wsl" ]] && ! grep -qi microsoft /proc/version 2>/dev/null; then
```

這個條件永遠不會為真，因為：
- 如果 `SYSTEM_TYPE == "wsl"`，那麼 `/proc/version` 必然包含 "microsoft"
- 條件要求 `SYSTEM_TYPE == "wsl"` 且同時 **不包含** "microsoft"，這是矛盾的

### 其他未使用函數
```
check_command (618) - 定義但從未被調用
pause_if_needed (1573) - 定義但從未被調用
handle_error (1581) - 用於錯誤處理，但可能不會被觸發
```

## 5. 缺失的函數定義

**無發現缺失的函數定義**。所有被調用的函數都有相應的定義。

## 6. 函數分類總結

### 核心流程函數 (4個)
- main_installation (主入口)
- main_diagnostic_and_repair (診斷修復)
- detect_os (系統檢測)
- final_system_check (最終檢查)

### 安裝相關函數 (8個)
- install_system_dependencies
- install_nvm / install_nvm_fresh
- install_nodejs / install_nodejs_fresh
- install_claude_code / install_claude_code_fresh
- configure_nvm_profile

### 檢測與修復函數 (12個)
- check_npm_permissions / fix_npm_permissions_safe
- check_nvm_npm_conflicts / fix_nvm_npm_conflicts
- check_claude_cli_status
- check_system_environment (兩個版本)
- clean_system_environment
- check_dependencies
- check_network_connectivity
- check_system_resources
- check_disk_space

### 驗證函數 (4個)
- verify_nodejs_installation
- verify_nodejs_environment
- verify_claude_installation
- switch_to_target_version

### 配置函數 (3個)
- fix_npm_config
- configure_npm_global
- apply_security_best_practices

### 實用工具函數 (11個)
- 日誌函數組：log_info, log_success, log_warn, log_error, error_exit
- 兼容函數：warn, success, info
- 互動函數：interactive_prompt (兩個版本)
- 進度函數：show_progress
- 計時函數：start_timer, end_timer
- 快速模式：check_fast_mode
- 顯示函數：print_header

### Windows 專用函數 (5個) - 未被使用
- check_windows_version
- check_virtualization
- enable_windows_features
- fix_wsl_issues
- install_wsl_distro

### 內部輔助函數 (4個)
- detect_shell_config (內部於 detect_os)
- validate_shell_config (內部於 detect_os)
- pause_if_needed (未使用)
- handle_error (錯誤處理)

### 未使用函數 (2個)
- check_command
- pause_if_needed

## 7. 建議改進

1. **修正重複定義**：統一 interactive_prompt 和 check_system_environment 函數
2. **修正邏輯錯誤**：修正第 1378 行的 Windows 檢測邏輯
3. **移除未使用函數**：清理 check_command 和 pause_if_needed
4. **函數順序優化**：將相關函數組織在一起
5. **依賴關係文檔化**：為複雜的依賴關係添加註釋

## 8. 執行流程圖

```
開始
│
├── 檢測作業系統 (detect_os)
├── 智能診斷修復 (main_diagnostic_and_repair)
├── 系統檢查 (conditional)
├── 安裝系統依賴 (install_system_dependencies)
├── 修復 npm 配置 (fix_npm_config)
├── 安裝 nvm (install_nvm)
├── 安裝 Node.js (install_nodejs)
├── 配置 npm (configure_npm_global)
├── 安裝 Claude Code (install_claude_code)
├── 驗證安裝 (verify_claude_installation)
└── 最終檢查 (final_system_check)
│
結束
```

腳本總體結構良好，函數職責分明，但存在一些重複定義和未使用函數需要清理。