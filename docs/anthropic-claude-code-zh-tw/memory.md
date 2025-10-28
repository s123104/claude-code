---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/memory.md"
fetched_at: "2025-10-28T19:18:00+08:00"
---

# 管理 Claude 的記憶體

> 學習如何使用不同的記憶體位置和最佳實踐來管理 Claude Code 跨會話的記憶體。

Claude Code 可以記住您跨會話的偏好設定，例如樣式指南和工作流程中的常用命令。

## 確定記憶體類型

Claude Code 提供四個記憶體位置的階層結構，每個都有不同的用途：

| 記憶體類型         | 位置                                                                                                                                                      | 用途                    | 使用案例範例                       | 共享對象         |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- | ---------------------------- | ------------ |
| **企業政策**      | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`<br />Linux: `/etc/claude-code/CLAUDE.md`<br />Windows: `C:\ProgramData\ClaudeCode\CLAUDE.md` | 由 IT/DevOps 管理的組織範圍指令 | 公司編碼標準、安全政策、合規要求             | 組織中的所有使用者    |
| **專案記憶體**     | `./CLAUDE.md` 或 `./.claude/CLAUDE.md`                                                                                                                   | 專案的團隊共享指令             | 專案架構、編碼標準、常見工作流程             | 透過原始碼控制的團隊成員 |
| **使用者記憶體**    | `~/.claude/CLAUDE.md`                                                                                                                                   | 所有專案的個人偏好設定           | 程式碼樣式偏好、個人工具快捷方式             | 只有您（所有專案）    |
| **專案記憶體（本地）** | `./CLAUDE.local.md`                                                                                                                                     | 個人專案特定偏好設定            | *（已棄用，見下文）* 您的沙盒 URL、偏好的測試資料 | 只有您（當前專案）    |

所有記憶體檔案在啟動時會自動載入到 Claude Code 的上下文中。階層中較高的檔案優先載入，提供更具體記憶體建立的基礎。

## CLAUDE.md 匯入

CLAUDE.md 檔案可以使用 `@path/to/import` 語法匯入其他檔案。以下範例匯入 3 個檔案：

```
查看 @README 了解專案概述，查看 @package.json 了解此專案可用的 npm 命令。

# 其他指令
- git 工作流程 @docs/git-instructions.md
```

允許相對路徑和絕對路徑。特別是，匯入使用者主目錄中的檔案是讓團隊成員提供不會檢入儲存庫的個人指令的便利方式。以前 CLAUDE.local.md 有類似的用途，但現在已棄用，改用匯入，因為它們在多個 git 工作樹中運作得更好。

```
# 個人偏好設定
- @~/.claude/my-project-instructions.md
```

為避免潛在衝突，匯入不會在 markdown 程式碼範圍和程式碼區塊內評估。

```
此程式碼範圍不會被視為匯入：`@anthropic-ai/claude-code`
```

匯入的檔案可以遞迴匯入其他檔案，最大深度為 5 跳。您可以透過執行 `/memory` 命令查看載入了哪些記憶體檔案。

## Claude 如何查找記憶體

Claude Code 遞迴讀取記憶體：從 cwd 開始，Claude Code 遞迴向上到（但不包括）根目錄 */* 並讀取找到的任何 CLAUDE.md 或 CLAUDE.local.md 檔案。這在大型儲存庫中工作時特別方便，您在 *foo/bar/* 中執行 Claude Code，並在 *foo/CLAUDE.md* 和 *foo/bar/CLAUDE.md* 中都有記憶體。

Claude 也會發現嵌套在當前工作目錄下子樹中的 CLAUDE.md。它們不會在啟動時載入，只有當 Claude 讀取這些子樹中的檔案時才會包含。

## 使用 `#` 快捷方式快速新增記憶體

新增記憶體最快的方式是在輸入開頭使用 `#` 字元：

```
# 始終使用描述性變數名稱
```

系統會提示您選擇要將此記憶體儲存在哪個記憶體檔案中。

## 使用 `/memory` 直接編輯記憶體

在會話期間使用 `/memory` 斜線命令在系統編輯器中開啟任何記憶體檔案，以進行更廣泛的新增或組織。

## 設定專案記憶體

假設您想要設定一個 CLAUDE.md 檔案來儲存重要的專案資訊、慣例和常用命令。專案記憶體可以儲存在 `./CLAUDE.md` 或 `./.claude/CLAUDE.md` 中。

使用以下命令為您的程式碼庫引導一個 CLAUDE.md：

```
> /init 
```

<Tip>
  提示：

  * 包含常用命令（建置、測試、檢查）以避免重複搜尋
  * 記錄程式碼樣式偏好和命名慣例
  * 新增專案特定的重要架構模式
  * CLAUDE.md 記憶體可用於與團隊共享的指令和個人偏好設定。
</Tip>

## 組織層級記憶體管理

企業組織可以部署適用於所有使用者的集中管理 CLAUDE.md 檔案。

要設定組織層級記憶體管理：

1. 在適合您作業系統的位置建立企業記憶體檔案：

* macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`
* Linux/WSL: `/etc/claude-code/CLAUDE.md`
* Windows: `C:\ProgramData\ClaudeCode\CLAUDE.md`

2. 透過您的配置管理系統（MDM、群組原則、Ansible 等）部署，以確保在所有開發者機器上一致分發。

## 記憶體最佳實踐

* **具體明確**：「使用 2 空格縮排」比「正確格式化程式碼」更好。
* **使用結構組織**：將每個個別記憶體格式化為項目符號，並在描述性 markdown 標題下分組相關記憶體。
* **定期檢視**：隨著專案發展更新記憶體，確保 Claude 始終使用最新的資訊和上下文。

