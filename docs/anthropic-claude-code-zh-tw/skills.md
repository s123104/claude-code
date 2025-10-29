---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/skills.md"
fetched_at: "2025-10-29T14:11:46+08:00"
---

# Agent Skills

> 在 Claude Code 中建立、管理和分享 Skills 以擴展 Claude 的功能。

本指南展示如何在 Claude Code 中建立、使用和管理 Agent Skills。Skills 是模組化功能，透過包含指示、指令碼和資源的有組織資料夾來擴展 Claude 的功能。

## 先決條件

* Claude Code 版本 1.0 或更新版本
* 對 [Claude Code](/zh-TW/docs/claude-code/quickstart) 的基本熟悉

## 什麼是 Agent Skills？

Agent Skills 將專業知識打包成可發現的功能。每個 Skill 包含一個 `SKILL.md` 檔案，其中包含 Claude 在相關時讀取的指示，以及可選的支援檔案，例如指令碼和範本。

**Skills 如何被呼叫**：Skills 是**模型呼叫的**—Claude 根據您的請求和 Skill 的描述自主決定何時使用它們。這與斜杠命令不同，斜杠命令是**使用者呼叫的**（您明確輸入 `/command` 來觸發它們）。

**優點**：

* 為您的特定工作流程擴展 Claude 的功能
* 透過 git 在您的團隊中分享專業知識
* 減少重複提示
* 為複雜任務組合多個 Skills

在 [Agent Skills 概述](/zh-TW/docs/agents-and-tools/agent-skills/overview) 中了解更多。

<Note>
  如需深入了解 Agent Skills 的架構和實際應用，請閱讀我們的工程部落格：[Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)。
</Note>

## 建立 Skill

Skills 儲存為包含 `SKILL.md` 檔案的目錄。

### 個人 Skills

個人 Skills 在您的所有專案中都可用。將它們儲存在 `~/.claude/skills/`：

```bash  theme={null}
mkdir -p ~/.claude/skills/my-skill-name
```

**使用個人 Skills 的用途**：

* 您的個人工作流程和偏好設定
* 您正在開發的實驗性 Skills
* 個人生產力工具

### 專案 Skills

專案 Skills 與您的團隊共享。將它們儲存在您的專案內的 `.claude/skills/`：

```bash  theme={null}
mkdir -p .claude/skills/my-skill-name
```

**使用專案 Skills 的用途**：

* 團隊工作流程和約定
* 專案特定的專業知識
* 共享的公用程式和指令碼

專案 Skills 被簽入 git 並自動提供給團隊成員。

### 外掛程式 Skills

Skills 也可以來自 [Claude Code 外掛程式](/zh-TW/docs/claude-code/plugins)。外掛程式可能會捆綁在安裝外掛程式時自動可用的 Skills。這些 Skills 的工作方式與個人和專案 Skills 相同。

## 撰寫 SKILL.md

建立一個 `SKILL.md` 檔案，其中包含 YAML 前置事項和 Markdown 內容：

```yaml  theme={null}
---
name: your-skill-name
description: Brief description of what this Skill does and when to use it
---

# Your Skill Name

## Instructions
Provide clear, step-by-step guidance for Claude.

## Examples
Show concrete examples of using this Skill.
```

**欄位要求**：

* `name`：必須僅使用小寫字母、數字和連字符（最多 64 個字元）
* `description`：簡短描述此 Skill 的功能以及何時使用它（最多 1024 個字元）

`description` 欄位對於 Claude 發現何時使用您的 Skill 至關重要。它應該包括 Skill 的功能以及 Claude 應該何時使用它。

請參閱 [最佳實踐指南](/zh-TW/docs/agents-and-tools/agent-skills/best-practices) 以獲得完整的撰寫指導，包括驗證規則。

## 新增支援檔案

在 SKILL.md 旁邊建立其他檔案：

```
my-skill/
├── SKILL.md (required)
├── reference.md (optional documentation)
├── examples.md (optional examples)
├── scripts/
│   └── helper.py (optional utility)
└── templates/
    └── template.txt (optional template)
```

從 SKILL.md 參考這些檔案：

````markdown  theme={null}
For advanced usage, see [reference.md](reference.md).

Run the helper script:
```bash
python scripts/helper.py input.txt
```
````

Claude 只在需要時讀取這些檔案，使用漸進式揭露來有效管理上下文。

## 使用 allowed-tools 限制工具存取

使用 `allowed-tools` 前置事項欄位來限制當 Skill 處於活動狀態時 Claude 可以使用哪些工具：

```yaml  theme={null}
---
name: safe-file-reader
description: Read files without making changes. Use when you need read-only file access.
allowed-tools: Read, Grep, Glob
---

# Safe File Reader

This Skill provides read-only file access.

## Instructions
1. Use Read to view file contents
2. Use Grep to search within files
3. Use Glob to find files by pattern
```

當此 Skill 處於活動狀態時，Claude 只能使用指定的工具（Read、Grep、Glob），無需請求許可。這對以下情況很有用：

* 不應修改檔案的唯讀 Skills
* 範圍有限的 Skills（例如，僅資料分析，無檔案寫入）
* 安全敏感的工作流程，您想要限制功能

如果未指定 `allowed-tools`，Claude 將按照標準許可模型要求許可以使用工具。

<Note>
  `allowed-tools` 僅在 Claude Code 中的 Skills 支援。
</Note>

## 檢視可用的 Skills

Skills 由 Claude 從三個來源自動發現：

* 個人 Skills：`~/.claude/skills/`
* 專案 Skills：`.claude/skills/`
* 外掛程式 Skills：與已安裝的外掛程式捆綁

**若要檢視所有可用的 Skills**，直接詢問 Claude：

```
What Skills are available?
```

或

```
List all available Skills
```

這將顯示來自所有來源的所有 Skills，包括外掛程式 Skills。

**若要檢查特定 Skill**，您也可以檢查檔案系統：

```bash  theme={null}
# List personal Skills
ls ~/.claude/skills/

# List project Skills (if in a project directory)
ls .claude/skills/

# View a specific Skill's content
cat ~/.claude/skills/my-skill/SKILL.md
```

## 測試 Skill

建立 Skill 後，透過提出與您的描述相符的問題來測試它。

**範例**：如果您的描述提到「PDF 檔案」：

```
Can you help me extract text from this PDF?
```

Claude 自主決定是否使用您的 Skill（如果它與請求相符）—您無需明確呼叫它。根據您問題的上下文，Skill 會自動啟動。

## 偵錯 Skill

如果 Claude 不使用您的 Skill，請檢查這些常見問題：

### 使描述更具體

**太模糊**：

```yaml  theme={null}
description: Helps with documents
```

**具體**：

```yaml  theme={null}
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

在描述中包括 Skill 的功能以及何時使用它。

### 驗證檔案路徑

**個人 Skills**：`~/.claude/skills/skill-name/SKILL.md`
**專案 Skills**：`.claude/skills/skill-name/SKILL.md`

檢查檔案是否存在：

```bash  theme={null}
# Personal
ls ~/.claude/skills/my-skill/SKILL.md

# Project
ls .claude/skills/my-skill/SKILL.md
```

### 檢查 YAML 語法

無效的 YAML 會阻止 Skill 載入。驗證前置事項：

```bash  theme={null}
cat SKILL.md | head -n 10
```

確保：

* 第 1 行上的開始 `---`
* Markdown 內容前的結束 `---`
* 有效的 YAML 語法（無制表符，正確的縮排）

### 檢視錯誤

以偵錯模式執行 Claude Code 以查看 Skill 載入錯誤：

```bash  theme={null}
claude --debug
```

## 與您的團隊分享 Skills

**建議的方法**：透過 [外掛程式](/zh-TW/docs/claude-code/plugins) 分發 Skills。

透過外掛程式分享 Skills：

1. 在 `skills/` 目錄中建立包含 Skills 的外掛程式
2. 將外掛程式新增到市集
3. 團隊成員安裝外掛程式

如需完整指示，請參閱 [將 Skills 新增到您的外掛程式](/zh-TW/docs/claude-code/plugins#add-skills-to-your-plugin)。

您也可以直接透過專案存放庫分享 Skills：

### 步驟 1：將 Skill 新增到您的專案

建立專案 Skill：

```bash  theme={null}
mkdir -p .claude/skills/team-skill
# Create SKILL.md
```

### 步驟 2：提交到 git

```bash  theme={null}
git add .claude/skills/
git commit -m "Add team Skill for PDF processing"
git push
```

### 步驟 3：團隊成員自動取得 Skills

當團隊成員拉取最新變更時，Skills 立即可用：

```bash  theme={null}
git pull
claude  # Skills are now available
```

## 更新 Skill

直接編輯 SKILL.md：

```bash  theme={null}
# Personal Skill
code ~/.claude/skills/my-skill/SKILL.md

# Project Skill
code .claude/skills/my-skill/SKILL.md
```

變更在您下次啟動 Claude Code 時生效。如果 Claude Code 已在執行，請重新啟動它以載入更新。

## 移除 Skill

刪除 Skill 目錄：

```bash  theme={null}
# Personal
rm -rf ~/.claude/skills/my-skill

# Project
rm -rf .claude/skills/my-skill
git commit -m "Remove unused Skill"
```

## 最佳實踐

### 保持 Skills 專注

一個 Skill 應該解決一個功能：

**專注**：

* 「PDF 表單填寫」
* 「Excel 資料分析」
* 「Git 提交訊息」

**太寬泛**：

* 「文件處理」（分成單獨的 Skills）
* 「資料工具」（按資料類型或操作分割）

### 撰寫清晰的描述

透過在您的描述中包括特定觸發器來幫助 Claude 發現何時使用 Skills：

**清晰**：

```yaml  theme={null}
description: Analyze Excel spreadsheets, create pivot tables, and generate charts. Use when working with Excel files, spreadsheets, or analyzing tabular data in .xlsx format.
```

**模糊**：

```yaml  theme={null}
description: For files
```

### 與您的團隊測試

讓隊友使用 Skills 並提供回饋：

* Skill 是否在預期時啟動？
* 指示是否清晰？
* 是否有遺漏的範例或邊界情況？

### 記錄 Skill 版本

您可以在 SKILL.md 內容中記錄 Skill 版本以追蹤一段時間內的變更。新增版本歷史記錄部分：

```markdown  theme={null}
# My Skill

## Version History
- v2.0.0 (2025-10-01): Breaking changes to API
- v1.1.0 (2025-09-15): Added new features
- v1.0.0 (2025-09-01): Initial release
```

這有助於團隊成員了解版本之間的變更。

## 疑難排解

### Claude 不使用我的 Skill

**症狀**：您提出相關問題，但 Claude 不使用您的 Skill。

**檢查**：描述是否足夠具體？

模糊的描述使發現變得困難。包括 Skill 的功能以及何時使用它，以及使用者會提及的關鍵術語。

**太通用**：

```yaml  theme={null}
description: Helps with data
```

**具體**：

```yaml  theme={null}
description: Analyze Excel spreadsheets, generate pivot tables, create charts. Use when working with Excel files, spreadsheets, or .xlsx files.
```

**檢查**：YAML 是否有效？

執行驗證以檢查語法錯誤：

```bash  theme={null}
# View frontmatter
cat .claude/skills/my-skill/SKILL.md | head -n 15

# Check for common issues
# - Missing opening or closing ---
# - Tabs instead of spaces
# - Unquoted strings with special characters
```

**檢查**：Skill 是否在正確的位置？

```bash  theme={null}
# Personal Skills
ls ~/.claude/skills/*/SKILL.md

# Project Skills
ls .claude/skills/*/SKILL.md
```

### Skill 有錯誤

**症狀**：Skill 載入但無法正常工作。

**檢查**：依賴項是否可用？

Claude 將在需要時自動安裝所需的依賴項（或要求許可以安裝它們）。

**檢查**：指令碼是否具有執行許可？

```bash  theme={null}
chmod +x .claude/skills/my-skill/scripts/*.py
```

**檢查**：檔案路徑是否正確？

在所有路徑中使用正斜杠（Unix 風格）：

**正確**：`scripts/helper.py`
**錯誤**：`scripts\helper.py`（Windows 風格）

### 多個 Skills 衝突

**症狀**：Claude 使用錯誤的 Skill 或似乎在類似 Skills 之間感到困惑。

**在描述中具體說明**：透過在您的描述中使用不同的觸發術語來幫助 Claude 選擇正確的 Skill。

而不是：

```yaml  theme={null}
# Skill 1
description: For data analysis

# Skill 2
description: For analyzing data
```

使用：

```yaml  theme={null}
# Skill 1
description: Analyze sales data in Excel files and CRM exports. Use for sales reports, pipeline analysis, and revenue tracking.

# Skill 2
description: Analyze log files and system metrics data. Use for performance monitoring, debugging, and system diagnostics.
```

## 範例

### 簡單 Skill（單一檔案）

```
commit-helper/
└── SKILL.md
```

```yaml  theme={null}
---
name: generating-commit-messages
description: Generates clear commit messages from git diffs. Use when writing commit messages or reviewing staged changes.
---

# Generating Commit Messages

## Instructions

1. Run `git diff --staged` to see changes
2. I'll suggest a commit message with:
   - Summary under 50 characters
   - Detailed description
   - Affected components

## Best practices

- Use present tense
- Explain what and why, not how
```

### 具有工具許可的 Skill

```
code-reviewer/
└── SKILL.md
```

```yaml  theme={null}
---
name: code-reviewer
description: Review code for best practices and potential issues. Use when reviewing code, checking PRs, or analyzing code quality.
allowed-tools: Read, Grep, Glob
---

# Code Reviewer

## Review checklist

1. Code organization and structure
2. Error handling
3. Performance considerations
4. Security concerns
5. Test coverage

## Instructions

1. Read the target files using Read tool
2. Search for patterns using Grep
3. Find related files using Glob
4. Provide detailed feedback on code quality
```

### 多檔案 Skill

```
pdf-processing/
├── SKILL.md
├── FORMS.md
├── REFERENCE.md
└── scripts/
    ├── fill_form.py
    └── validate.py
```

**SKILL.md**：

````yaml  theme={null}
---
name: pdf-processing
description: Extract text, fill forms, merge PDFs. Use when working with PDF files, forms, or document extraction. Requires pypdf and pdfplumber packages.
---

# PDF Processing

## Quick start

Extract text:
```python
import pdfplumber
with pdfplumber.open("doc.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

For form filling, see [FORMS.md](FORMS.md).
For detailed API reference, see [REFERENCE.md](REFERENCE.md).

## Requirements

Packages must be installed in your environment:
```bash
pip install pypdf pdfplumber
```
````

<Note>
  在描述中列出所需的套件。套件必須在您的環境中安裝，Claude 才能使用它們。
</Note>

Claude 只在需要時載入其他檔案。

## 後續步驟

<CardGroup cols={2}>
  <Card title="撰寫最佳實踐" icon="lightbulb" href="/zh-TW/docs/agents-and-tools/agent-skills/best-practices">
    撰寫 Claude 可以有效使用的 Skills
  </Card>

  <Card title="Agent Skills 概述" icon="book" href="/zh-TW/docs/agents-and-tools/agent-skills/overview">
    了解 Skills 如何在 Claude 產品中工作
  </Card>

  <Card title="在 Agent SDK 中使用 Skills" icon="cube" href="/zh-TW/api/agent-sdk/skills">
    使用 TypeScript 和 Python 以程式設計方式使用 Skills
  </Card>

  <Card title="開始使用 Agent Skills" icon="rocket" href="/zh-TW/docs/agents-and-tools/agent-skills/quickstart">
    建立您的第一個 Skill
  </Card>
</CardGroup>

