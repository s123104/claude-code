---
source: "https://docs.anthropic.com/en/docs/claude-code/sub-agents"
fetched_at: "2025-08-20T01:40:00+08:00"
updated_features: "2025-08-20 - 新增顯式子代理調用、代理鏈接、實戰範例"
---

[原始文件連結](https://docs.anthropic.com/zh-TW/docs/claude-code/sub-agents)

Claude Code 中的自定義子代理是專門的 AI 助手，可以被調用來處理特定類型的任務。它們通過提供具有自定義系統提示、工具和獨立上下文窗口的特定任務配置，實現更高效的問題解決。

## 什麼是子代理？

子代理是 Claude Code 可以委派任務的預配置 AI 個性。每個子代理：

- 具有特定的目的和專業領域
- 使用與主對話分離的自己的上下文窗口
- 可以配置允許使用的特定工具
- 包含指導其行為的自定義系統提示

當 Claude Code 遇到與子代理專業知識匹配的任務時，它可以將該任務委派給專門的子代理，該子代理獨立工作並返回結果。

## 主要優勢

- **專業領域聚焦**：每個子代理針對特定任務類型進行優化
- **獨立上下文**：避免主對話窗口過載，提升效能
- **工具權限控制**：精確控制子代理可使用的工具
- **可重複使用**：一次定義，多次調用
- **團隊共享**：項目級子代理可與團隊成員共享

## 快速開始

### 查看現有子代理

使用 `/agents` 指令查看所有可用的子代理：

```bash
> /agents
```

### 創建您的第一個項目子代理

```bash
mkdir -p .claude/agents
echo '---
name: test-runner
description: Use proactively to run tests and fix failures
---

You are a test automation expert. When you see code changes, proactively run the appropriate tests. If tests fail, analyze the failures and fix them while preserving the original test intent.' > .claude/agents/test-runner.md
```

### 顯式調用子代理

您可以明確要求特定子代理執行任務：

```bash
> Use the test-runner subagent to fix failing tests
> Have the code-reviewer subagent look at my recent changes
> Ask the debugger subagent to investigate this error
```

## 子代理配置

### 文件位置

子代理作為帶有 YAML 前置內容的 Markdown 文件存儲在兩個可能的位置：

| 類型           | 位置                | 範圍             | 優先級 |
| -------------- | ------------------- | ---------------- | ------ |
| **項目子代理** | `.claude/agents/`   | 在當前項目中可用 | 最高   |
| **用戶子代理** | `~/.claude/agents/` | 在所有項目中可用 | 較低   |

當子代理名稱衝突時，項目級子代理優先於用戶級子代理。

### 文件格式

每個子代理在 Markdown 文件中定義，具有以下結構：

#### 配置字段

| 字段          | 必需 | 描述                                                   |
| ------------- | ---- | ------------------------------------------------------ |
| `name`        | 是   | 使用小寫字母和連字符的唯一標識符                       |
| `description` | 是   | 子代理目的的自然語言描述                               |
| `tools`       | 否   | 特定工具的逗號分隔列表。如果省略，從主線程繼承所有工具 |

### 可用工具

子代理可以被授予訪問 Claude Code 的任何內部工具。請參閱[工具文檔](about:/zh-TW/docs/claude-code/settings#tools-available-to-claude)以獲取可用工具的完整列表。

您有兩個配置工具的選項：

- **省略 `tools` 字段**以從主線程繼承所有工具（默認），包括 MCP 工具
- **指定個別工具**作為逗號分隔列表以進行更精細的控制（可以手動編輯或通過 `/agents` 編輯）

**MCP 工具**：子代理可以訪問來自配置的 MCP 服務器的 MCP 工具。當省略 `tools` 字段時，子代理繼承主線程可用的所有 MCP 工具。

## 管理子代理

### 使用 /agents 命令（推薦）

`/agents` 命令為子代理管理提供了全面的界面：

這會打開一個交互式菜單，您可以：

- 查看所有可用的子代理（內置、用戶和項目）
- 使用引導設置創建新的子代理
- 編輯現有的自定義子代理，包括其工具訪問權限
- 刪除自定義子代理
- 查看當存在重複時哪些子代理處於活動狀態
- **輕鬆管理工具權限**，提供可用工具的完整列表

### 直接文件管理

您也可以通過直接處理子代理文件來管理它們：

## 實戰範例

### 程式碼審查子代理 (code-reviewer)

```markdown
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
tools: Read, Grep, Glob, Bash
---

You are a senior code reviewer ensuring high standards of code quality and security.

When invoked:
1. Run git diff to see recent changes
2. Focus on modified files
3. Begin review immediately

Review checklist:
- Code is simple and readable
- Functions and variables are well-named
- No duplicated code
- Proper error handling
- No exposed secrets or API keys
- Input validation implemented
- Good test coverage
- Performance considerations addressed

Provide feedback organized by priority:
- Critical issues (must fix)
- Warnings (should fix)
- Suggestions (consider improving)

Include specific examples of how to fix issues.
```

### 除錯專家子代理 (debugger)

```markdown
---
name: debugger
description: Debugging specialist for errors, test failures, and unexpected behavior. Use proactively when encountering any issues.
tools: Read, Edit, Bash, Grep, Glob
---

You are an expert debugger specializing in root cause analysis.

When invoked:
1. Capture error message and stack trace
2. Identify reproduction steps
3. Isolate the failure location
4. Implement minimal fix
5. Verify solution works

Debugging process:
- Analyze error messages and logs
- Check recent code changes
- Form and test hypotheses
- Add strategic debug logging
- Inspect variable states

For each issue, provide:
- Root cause explanation
- Evidence supporting the diagnosis
- Specific code fix
- Testing approach
- Prevention recommendations

Focus on fixing the underlying issue, not just symptoms.
```

### 資料科學子代理 (data-scientist)

```markdown
---
name: data-scientist
description: Data analysis expert for SQL queries, BigQuery operations, and data insights. Use proactively for data analysis tasks and queries.
tools: Bash, Read, Write
---

You are a data scientist specializing in SQL and BigQuery analysis.

When invoked:
1. Understand the data analysis requirement
2. Write efficient SQL queries
3. Use BigQuery command line tools (bq) when appropriate
4. Analyze and summarize results
5. Present findings clearly

Key practices:
- Write optimized SQL queries with proper filters
- Use appropriate aggregations and joins
- Include comments explaining complex logic
- Format results for readability
- Provide data-driven recommendations

For each analysis:
- Explain the query approach
- Document any assumptions
- Highlight key findings
- Suggest next steps based on data

Always ensure queries are efficient and cost-effective.
```

## 子代理鏈接與協作

### 多子代理協作範例

```bash
# 複雜工作流程：分析 → 優化
> First use the code-analyzer subagent to find performance issues, then use the optimizer subagent to fix them

# 安全審查流程
> Use the security-auditor subagent to check for vulnerabilities, then have the code-reviewer subagent verify the fixes

# 全面測試流程
> Have the test-runner subagent run all tests, then use the debugger subagent to investigate any failures
```

## 有效使用子代理

### 自動委派

Claude Code 基於以下因素主動委派任務：

- 您請求中的任務描述
- 子代理配置中的 `description` 字段
- 當前上下文和可用工具

### 明確調用

通過在命令中提及特定子代理來請求它：

## 示例子代理

### 代碼審查員

### 調試器

### 數據科學家

## 最佳實踐

- **從 Claude 生成的代理開始**：我們強烈建議使用 Claude 生成您的初始子代理，然後對其進行迭代以使其個人化。這種方法為您提供最佳結果 - 一個您可以根據特定需求自定義的堅實基礎。
- **設計專注的子代理**：創建具有單一、明確責任的子代理，而不是試圖讓一個子代理做所有事情。這提高了性能並使子代理更可預測。
- **編寫詳細的提示**：在您的系統提示中包含具體指令、示例和約束。您提供的指導越多，子代理的表現就越好。
- **限制工具訪問**：只授予子代理目的所必需的工具。這提高了安全性並幫助子代理專注於相關操作。
- **版本控制**：將項目子代理檢入版本控制，以便您的團隊可以從中受益並協作改進它們。

## 高級用法

### 鏈接子代理

對於複雜的工作流程，您可以鏈接多個子代理：

### 動態子代理選擇

Claude Code 基於上下文智能選擇子代理。使您的 `description` 字段具體且面向行動，以獲得最佳結果。

## 性能考慮

- **上下文效率**：代理幫助保護主上下文，實現更長的整體會話
- **延遲**：子代理每次被調用時都從乾淨的狀態開始，可能會增加延遲，因為它們需要收集有效完成工作所需的上下文。

## 相關文檔

- [斜線命令](/zh-TW/docs/claude-code/slash-commands) - 了解其他內置命令
- [設置](/zh-TW/docs/claude-code/settings) - 配置 Claude Code 行為
- [鉤子](/zh-TW/docs/claude-code/hooks) - 使用事件處理程序自動化工作流程
