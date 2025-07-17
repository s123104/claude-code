# 貢獻規範（本專案 claude-code 2025 版）

> 本專案（s123104/claude-code）採用 MIT 授權，並整合 SuperClaude Framework。所有貢獻需同時遵循本專案與 SuperClaude 的規範，詳見下方說明。

---

# Contributing to SuperClaude Framework

Thanks for your interest in contributing! 🙏

SuperClaude is a community-driven project that enhances Claude Code through modular hooks and intelligent orchestration. Every contribution helps make the framework more useful for developers.

## 🚀 Quick Start

### Prerequisites

- Python 3.12+ (standard library only)
- Node.js 18+ (for MCP servers)
- Claude Code installed and authenticated

### Development Setup

```bash
# Clone the repository
git clone https://github.com/your-username/SuperClaude.git
cd SuperClaude

# Install SuperClaude
./install.sh --standard

# Run tests
python Tests/comprehensive_test.py
```

## 🎯 Ways to Contribute

### 🐛 Bug Reports

- Use GitHub Issues with the "bug" label
- Include system info (OS, Python/Node versions)
- Provide minimal reproduction steps
- Include relevant hook logs from `~/.claude/`

### 💡 Feature Requests

- Check existing issues and roadmap first
- Use GitHub Issues with the "enhancement" label
- Describe the use case and expected behavior
- Consider if it fits the framework's modular philosophy

### 📝 Documentation

- Fix typos or unclear explanations
- Add examples and use cases
- Improve installation guides
- Translate documentation (especially for Scribe persona)

### 🔧 Code Contributions

- Focus on hooks, commands, or core framework components
- Follow existing patterns and conventions
- Include tests for new functionality
- Update documentation as needed

## 🏗️ Architecture Overview

### Core Components

```
SuperClaude/
├── SuperClaude/
│   ├── Hooks/          # 15 Python hooks (main extension points)
│   ├── Commands/       # 14 slash commands
│   ├── Core/          # Framework documentation
│   └── Settings/      # Configuration files
├── Scripts/           # Installation and utility scripts
└── Tests/            # Test suite
```

### Hook System

Hooks are the primary extension mechanism:

- **PreToolUse**: Intercept before tool execution
- **PostToolUse**: Process after tool completion
- **SubagentStop**: Handle sub-agent lifecycle
- **Stop**: Session cleanup and synthesis
- **Notification**: Real-time event processing

## 🧪 Testing

### Running Tests

```bash
# Full test suite
python Tests/comprehensive_test.py

# Specific components
python Tests/task_management_test.py
python Tests/performance_test_suite.py

# Hook integration tests
python SuperClaude/Hooks/test_orchestration_integration.py
```

### Writing Tests

- Test hook behavior with mock data
- Include performance benchmarks
- Test error conditions and recovery
- Validate cross-component integration

## 📋 Code Standards

### Python Code (Hooks)

```python
#!/usr/bin/env python3
"""
Brief description of hook purpose.
Part of SuperClaude Framework v3.0
"""

import json
import sys
from typing import Dict, Any

def process_hook_data(data: Dict[str, Any]) -> Dict[str, Any]:
    """Process hook data with proper error handling."""
    try:
        # Implementation here
        return {"status": "success", "data": result}
    except Exception as e:
        return {"status": "error", "message": str(e)}

if __name__ == "__main__":
    # Standard hook entry point
    input_data = json.loads(sys.stdin.read())
    result = process_hook_data(input_data)
    print(json.dumps(result))
```

### Documentation (Markdown)

- Use clear headings and structure
- Include code examples where helpful
- Add emoji sparingly for clarity 🎯
- Keep language humble and developer-focused

### Commit Messages

本專案採用結構化的提交訊息規範，確保版本歷史清晰易讀。

#### 訊息格式規範

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Header（必要）**：

- `type`: 代表 commit 的類別，必要欄位
- `scope`: 代表 commit 影響的範圍，可選欄位
- `subject`: 此 commit 的簡短描述，不超過 50 字元，結尾不加句號，必要欄位

**Body（可選）**：

- 72 字元換行的詳細描述
- 說明程式碼變動的項目與原因
- 與先前行為的對比

**Footer（可選）**：

- 任務編號（例如：issue #1234）
- BREAKING CHANGE 記錄不兼容的變動

#### Type 類別說明

| Type       | 說明          | 適用情況                 |
| ---------- | ------------- | ------------------------ |
| `feat`     | 新增/修改功能 | 新功能開發               |
| `fix`      | 修補 bug      | 錯誤修正                 |
| `docs`     | 文件變更      | 文件更新、新增、修正     |
| `style`    | 格式調整      | 不影響程式碼運行的變動   |
| `refactor` | 重構          | 既非新增功能也非修補 bug |
| `perf`     | 效能改善      | 提升效能的程式碼變動     |
| `test`     | 測試          | 新增或修改測試           |
| `chore`    | 維護          | 建構程序或輔助工具變動   |
| `revert`   | 撤銷          | 回覆先前的 commit        |

#### Scope 範圍建議

- `installation`: 安裝相關腳本
- `docs`: 文件系統
- `web`: 網頁介面
- `scripts`: 腳本工具
- `config`: 配置檔案
- `tests`: 測試相關

#### 提交訊息範例

**功能新增範例**：

```
feat(installation): 新增 zsh 版本檢測與升級功能

在 macOS 上優先檢測 zsh 版本並支援自動升級：
- 新增 get_zsh_version() 函數檢測當前 zsh 版本
- 新增 upgrade_zsh_macos() 支援 Homebrew 升級
- 修改主流程優先檢測 zsh (步驟 1/3)
- 自動建立 ~/.zshrc 配置檔案

issue #123
```

**錯誤修正範例**：

```
fix(installation): 修正版本檢測邏輯誤報更新需求

問題：
1. bash 版本檢測使用系統版本而非 Homebrew 版本
2. Claude Code 版本比較邏輯不準確導致誤報

原因：
1. 版本檢測函數未優先檢查 Homebrew 安裝的版本
2. 版本號提取正則表達式處理不當

調整項目：
1. 優化 get_bash_version() 支援 Homebrew 版本優先檢測
2. 修正版本號提取和比較邏輯
3. 新增變數初始化檢查避免 unbound variable 錯誤

issue #456
```

**文件更新範例**：

```
docs(readme): 更新 start.sh v3.5.0 功能說明

更新內容：
- 新增 zsh 版本檢測與升級功能說明
- 更新跨平台支援資訊 (Linux/WSL/macOS)
- 修正安裝指令和使用範例
- 更新技術棧和相依性資訊

issue #789
```

**重構範例**：

```
refactor(installation): 重構版本檢測邏輯統一處理

將 bash 和 zsh 版本檢測邏輯統一管理：
- 建立通用版本比較函數 version_compare()
- 統一 Homebrew 版本檢測邏輯
- 簡化錯誤處理和日誌輸出
- 提升程式碼可讀性和維護性

無功能性變更，保持向後相容性。
```

**效能改善範例**：

```
perf(installation): 優化腳本執行速度

調整內容：
- 減少不必要的網路請求
- 優化套件管理器檢測邏輯
- 並行執行可獨立的檢測步驟
- 改善日誌輸出效率

效能提升：腳本執行時間從 45 秒降至 12 秒
```

**維護範例**：

```
chore(ci): 新增 ShellCheck 自動化檢測

新增項目：
- GitHub Actions 工作流程
- ShellCheck 零警告要求
- 自動化測試腳本
- 程式碼品質檢查

確保所有 Shell 腳本符合最佳實踐標準。
```

**BREAKING CHANGE 範例**：

```
feat(installation): 更新最低 Node.js 版本需求

升級最低版本需求從 16.x 到 18.x LTS：
- 支援最新 ES2022 語法特性
- 改善效能和安全性
- 與 Claude Code 最新版本相容

BREAKING CHANGE: 不再支援 Node.js 16.x，請升級至 18.x LTS 或更新版本。
升級方法：
1. 使用 nvm: `nvm install 18 && nvm use 18`
2. 重新執行安裝腳本: `./start.sh`

issue #1001
```

遵循這些規範有助於：

- 提升 Code Review 效率
- 自動化版本發布流程
- 快速理解變更內容
- 維護清晰的專案歷史

## 🔄 Development Workflow

### 1. Fork & Branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Develop & Test

- Make focused, atomic changes
- Test locally with `--standard` installation
- Ensure hooks don't break existing functionality

### 3. Submit Pull Request

- Clear title and description
- Reference related issues
- Include test results
- Update documentation if needed

### 4. Code Review

- Address feedback promptly
- Keep discussions focused and respectful
- Be open to suggestions and improvements

## 📦 Release Process

### Version Management

- Follow [Semantic Versioning](https://semver.org/)
- Update `VERSION` file
- Document changes in `CHANGELOG.md`
- Tag releases: `git tag v3.0.1`

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped
- [ ] Installation tested on clean system

## 🤝 Community Guidelines

### Be Respectful

- Welcome newcomers and different experience levels
- Focus on the code and ideas, not personal attributes
- Help others learn and improve

### Stay Focused

- Keep discussions relevant to SuperClaude's goals
- Avoid scope creep in feature requests
- Consider if changes fit the modular philosophy

### Quality First

- Test your changes thoroughly
- Consider performance impact
- Think about maintainability

## 💬 Getting Help

### Channels

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and ideas
- **Documentation**: Check existing guides first

### Common Questions

**Q: How do I debug hook execution?**
A: Check logs in `~/.claude/` and use verbose logging for detailed output.

**Q: Can I add new MCP servers?**
A: Yes! Follow the pattern in `settings.json` and add integration hooks.

**Q: How do I test changes without affecting my global setup?**
A: Use a separate test environment or backup your `~/.claude` directory before testing.

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🙏 Acknowledgments

Thanks to all contributors who help make SuperClaude better for the development community!
