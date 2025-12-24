# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Claude Code Chinese Documentation Hub** - a comprehensive collection of Chinese language documentation for Claude Code and Cursor AI integration. The repository (GitHub: s123104/claude-code) contains 14 active project documents covering different aspects of Claude Code usage, from basic installation to advanced features, with a focus on Traditional Chinese localization.

## SSOT Architecture

This repository follows the **Single Source of Truth (SSOT)** principle:
- **Version metadata**: `config/metadata.json` is the authoritative source for all version information
- **Project status**: Active (14) and archived (5) projects are clearly tracked
- **Clean Code**: Consistent naming, no redundancy, clear documentation structure

## Repository Structure

```
/
├── README.md                     # Main project overview and navigation (v5.1.0)
├── claude-code-zh-tw.md         # Main documentation with CLI reference (v2.0.75)
├── CLAUDE.md                     # This file - project memory for Claude Code
├── CONTRIBUTING.md               # Contribution guidelines and standards
├── LICENSE                       # MIT License terms
├── config/                      # **SSOT Configuration (NEW)**
│   └── metadata.json            # Single source of truth for all versions
├── docs/                        # All documentation files (14 active)
│   ├── README.md                # Document index and quick reference
│   ├── agents-zh-tw.md          # 99 professional sub-agents collection
│   ├── superclaude-zh-tw.md     # SuperClaude professional framework
│   ├── ccusage-zh-tw.md         # Usage monitoring (replaces old monitor)
│   ├── claudecodeui-zh-tw.md    # Web UI and visualization
│   ├── vibe-kanban-zh-tw.md     # Kanban project management
│   └── ...                      # 8 more active project documents
├── archives/                    # Archived content
│   ├── deprecated-docs/         # 5 deprecated project docs
│   ├── deprecated-scripts/      # Old automation scripts
│   └── reports/                 # Historical reports
├── scripts/                     # Active automation tools
├── img/                         # Assets directory
├── index.html                   # Modern interactive web interface
├── SuperClaude/                 # Advanced development framework submodule
└── .github/workflows/           # CI/CD automation
```

## Document Categories

### Core Documents

- **cursor-claude-master-guide-zh-tw.md**: Master control guide - comprehensive overview of all features with v2.0.0 intelligent agent system
- **claude-code-guide-zh-tw.md**: Basic API guide and fundamental commands with MCP integration
- **docs/README.md**: Document index with quick navigation and WSL setup guide

### Specialized Documents

- **awesome-claude-code-zh-tw.md**: Community best practices, workflows, hooks, and integrations
- **superclaude-zh-tw.md**: Advanced flag system, personas, and complex automation
- **ccusage-zh-tw.md**: Usage monitoring, status bar integration, 5-hour block reports
- **claudecodeui-zh-tw.md**: Web UI interface, PWA features, and remote management
- **bplustree3-zh-tw.md**: Performance optimization strategies and B+Tree caching

### Project Assets

- **img/logo.png**: Claude Code logo in pixelated style with 3D cube design
- **index.html**: Modern interactive web interface with responsive design, animations, and easter eggs

### Installation Scripts

- **setup.bat**: Windows batch file entry point with admin check and WSL validation
- **setup.ps1**: PowerShell main installer with multilingual support and automated WSL2 setup
- **start.bat**: Windows launcher with path conversion and error handling
- **start.sh**: Cross-platform installer (Linux/WSL/macOS) with zsh/bash version detection and upgrade (v3.5.0)

### Project Files

- **CONTRIBUTING.md**: Contribution guidelines and development standards
- **LICENSE**: MIT License terms and conditions
- **TESTING_REPORT.md**: Test results and quality assurance documentation
- **SuperClaude/**: Advanced development framework submodule integration

## Working with Documentation

### Reading Order by Role

- **Beginners**: guide → awesome → ui
- **Developers**: guide → superclaude → monitor
- **Team Leaders**: monitor → awesome → ui
- **Architects**: bplustree → guide → superclaude

### Common Tasks

- **Project Setup**: awesome + superclaude + guide
- **Code Fixing**: guide + awesome + monitor
- **Production Deployment**: monitor + ui + guide
- **Performance Optimization**: bplustree + monitor + guide

### Key Flag Categories

- **Project Creation**: `--create --template --mcp`
- **Error Fixing**: `--scan --fix --lint --test`
- **Deployment**: `--build --deploy --monitor`
- **Performance**: `--profile --optimize --cache`
- **Security**: `--security --audit --scan`

## New Features in v3.0.0

### Enhanced Installation System

- **Cross-platform Compatibility**: Windows (setup.bat, setup.ps1) and Linux/WSL (start.sh) support
- **Automated OS Detection**: Intelligent system environment detection and compatibility checks
- **Version Updates**: nvm v0.40.3, Node.js 18 LTS, latest @anthropic-ai/claude-code
- **Network Diagnostics**: Comprehensive connectivity and DNS resolution checks
- **Resource Monitoring**: Memory, CPU, and disk space validation
- **Windows 11 Support**: TPM 2.0 detection and advanced Windows 11 features

### Smart Environment Diagnostics

- **Multi-layer OS Detection**: WSL2, Linux distributions, system architecture identification
- **Virtualization Validation**: VT-x/AMD-V, SLAT, Hyper-V requirements verification
- **Path Pollution Cleanup**: Automatic npm configuration cleanup and repair
- **Error Recovery**: Comprehensive error handling and logging system
- **Performance Optimization**: Load balancing and resource usage monitoring

### Enhanced Web Interface (index.html)

- **Modern Responsive Design**: Mobile-first approach with Tailwind CSS
- **Interactive Features**: Animations, easter eggs, terminal demo
- **PWA Support**: Installable on desktop and mobile devices
- **Accessibility**: WCAG AA compliance with keyboard navigation

## Development Commands

### Local Development

```bash
# View documentation locally with web server
python3 -m http.server 8000
# or
npx serve .

# Open the interactive web interface
open index.html
# or
xdg-open index.html

# WSL installation script
./wsl_claude_code_setup.sh

# Check documentation encoding
for f in docs/*.md; do iconv -f UTF-8 -t UTF-8 "$f" > /dev/null && echo "$f: OK"; done
```

### MCP 伺服器管理

```bash
# 自動導入 Claude Desktop MCP 伺服器
./scripts/import-mcp-servers.sh

# 查看當前 MCP 伺服器
claude mcp list

# 手動添加 MCP 伺服器
claude mcp add-json <name> '<json-config>'

# 移除 MCP 伺服器
claude mcp remove <server-name>
```

### Git Operations for Documentation Updates

```bash
# Add all documentation changes
git add docs/ README.md claude-code-zh-tw.md CLAUDE.md

# Commit with structured message
git commit -m "Update documentation: [description]"

# Push to GitHub repository
git push origin master

# Create pull request (if needed)
gh pr create --title "Documentation Update" --body "Updated documentation files"
```

### Claude Code Integration Commands

```bash
# Basic Claude Code usage
claude --help
claude --version

# With project configuration
claude config set allowedTools '["Edit","View","Bash","Write","Read"]'
claude config list

# UI and monitoring
claude --ui --monitor
claude mcp list
claude mcp add postgres-server
```

## Content Guidelines

### Document Maintenance

- All documents are in Traditional Chinese (繁體中文)
- Cross-references between documents should be maintained
- Flag examples should be consistent across documents
- Update timestamps when making significant changes
- Version 2.0.0 introduces intelligent agent system features

### File Organization

- Main navigation starts from README.md
- Primary content is in cursor-claude-master-guide-zh-tw.md
- Specialized topics have dedicated files in docs/
- Web interface available through index.html
- WSL setup automation via wsl_claude_code_setup.sh
- No build process - static documentation files with interactive web components

### Technical Stack

- **Frontend**: HTML5, Tailwind CSS, JavaScript (ES6+)
- **Backend**: Node.js 18+ (for Claude Code)
- **Deployment**: Static hosting (GitHub Pages, Netlify, Vercel)
- **Containerization**: Docker support via start.sh automation
- **CI/CD**: GitHub Actions integration ready

## Usage Context

This repository serves as a comprehensive Chinese language resource for:

- Claude Code installation and setup (including WSL automation)
- AI-assisted development workflows with intelligent agent system
- MCP (Multi-Agent Protocol) integration and multi-modal analysis
- Advanced automation with flags, personas, and sequential thinking
- Production monitoring, security, and Docker deployment
- Performance optimization strategies using B+Tree caching
- Modern web interface with PWA capabilities

### Target Audience

- **AI 輔助開發初學者**: Beginners starting with Claude Code
- **專業開發者**: Professional developers integrating AI tools
- **架構師**: Architects needing performance optimization
- **團隊領導**: Team leaders managing Claude Code deployment
- **DevOps 工程師**: DevOps engineers handling monitoring and deployment

### Key Repository Information

- **GitHub Repository**: s123104/claude-code
- **Current Version**: v5.1.0
- **Claude Code Version**: v2.0.75
- **Last Update**: 2025-12-25T00:45:00+08:00
- **Language**: Traditional Chinese (繁體中文)
- **License**: MIT License
- **Branch**: master
- **SSOT Config**: `config/metadata.json`

### Project Configuration

- **Claude Code Settings**: `.claude/settings.local.json`
- **Permissions**: Configured for Bash, WebFetch, MCP operations
- **Allowed Tools**: Edit, View, Bash, Write, Read, Git operations
- **Logo**: Custom pixelated Claude Code logo with 3D cube design

This comprehensive documentation hub ensures Chinese-speaking developers can effectively integrate Claude Code into their development workflows with full feature coverage and practical examples.

## Installation and Setup Commands

### Automated Installation Scripts

```bash
# Linux/WSL/macOS - One-click installation (v3.5.0)
curl -fsSL https://raw.githubusercontent.com/s123104/claude-code/master/start.sh | bash

# Fast mode (skip interactive prompts)
curl -fsSL https://raw.githubusercontent.com/s123104/claude-code/master/start.sh | bash -s -- --fast

# Windows PowerShell installation
curl -O https://raw.githubusercontent.com/s123104/claude-code/master/setup.ps1
powershell -ExecutionPolicy Bypass -File setup.ps1
```

### Manual Installation

```bash
# Install Node.js 18+ and npm
# Then install Claude Code globally
npm install -g @anthropic-ai/claude-code

# Verify installation
claude --version
which claude
```

### Development and Testing Commands

```bash
# Serve documentation locally
python3 -m http.server 8000
# or
npx serve .

# Check documentation encoding
for f in docs/*.md; do iconv -f UTF-8 -t UTF-8 "$f" > /dev/null && echo "$f: OK"; done

# Validate shell scripts with ShellCheck
shellcheck start.sh
shellcheck setup.ps1

# Test installation script
bash -n start.sh  # Syntax check
./start.sh --fast  # Fast mode test
```

### Authentication Commands

```bash
# HTTP web authentication (recommended)
claude auth login
claude auth status

# API key authentication
export ANTHROPIC_API_KEY="sk-ant-apiXX-XXXXXXX"
echo 'export ANTHROPIC_API_KEY="sk-ant-apiXX-XXXXXXX"' >> ~/.zshrc

# Test connection
claude "Hello, Claude Code!"
claude doctor  # Health check
```

### Configuration Management

```bash
# Set allowed tools
claude config set allowedTools '["Edit","View","Bash","Write","Read"]'

# List current configuration
claude config list

# MCP operations
claude mcp list
claude mcp add postgres-server
claude mcp restart --all
```

## Architecture and Code Structure

### Core Components

**Installation System (v3.5.0)**:

- `start.sh` - Main cross-platform installation script (Linux/WSL/macOS)
- `setup.bat` / `setup.ps1` - Windows installation automation
- `SuperClaude/` - Advanced development framework submodule
- Supports macOS (Homebrew), Linux (apt/yum/pacman), and Windows (WSL2)

**Documentation Architecture**:

- **Primary Entry Point**: `cursor-claude-master-guide-zh-tw.md` - Master control guide
- **Specialized Modules**: 7 focused documents covering specific functionality
- **Interactive Web Interface**: `index.html` with modern responsive design
- **Cross-Reference System**: Documents are interconnected with consistent flag references

**Shell Script Architecture (start.sh)**:

- **Multi-OS Detection**: Automatic detection of macOS, Linux, WSL2 environments
- **Version Management**: Zsh (5.0+) and Bash (4.0+) version checking and upgrade
- **Package Management**: Homebrew (macOS), apt/yum/dnf/pacman (Linux) support
- **Error Handling**: Comprehensive logging to `/tmp/claude_setup_*.log`
- **Fast Mode**: `--fast` parameter bypasses interactive prompts

### Key Technical Decisions

**Shell Priority (macOS)**:

- Zsh is prioritized over Bash on macOS (steps 1→2→3)
- Automatic .zshrc configuration file creation
- Homebrew-installed shells take precedence over system versions

**Version Detection Logic**:

- Uses `npm view` to fetch latest package versions
- Regex-based version extraction with fallback handling
- Supports both semantic versioning and build identifiers

**Security Model**:

- Permissions defined in `.claude/settings.local.json`
- Granular tool access control (Bash, WebFetch, MCP operations)
- Audit trail for all operations

### Development Workflow

**Documentation Updates**:

1. Update individual documents in `docs/` directory
2. Update cross-references and timestamps
3. Test encoding with `iconv` validation
4. Commit with structured message format

**Script Development**:

1. Follow ShellCheck best practices (zero warnings required)
2. Use `set -euo pipefail` for strict error handling
3. Test with both interactive and fast modes
4. Validate across multiple OS environments

**Web Interface**:

- Built with vanilla JavaScript and Tailwind CSS
- Responsive design with mobile-first approach
- PWA capabilities for offline access
- Accessibility features (WCAG AA compliance)

### Integration Points

**MCP (Model Context Protocol)**:

- Supports multi-agent collaboration
- Context7 library integration for enhanced functionality
- Sequential thinking execution flow

**IDE Integration**:

- VSCode and Cursor editor support
- Hooks system for custom workflow automation
- Slash commands for rapid development

**Monitoring and Analytics**:

- Usage tracking via `ccusage-zh-tw.md`
- Performance optimization with B+Tree caching
- Security audit and compliance features

This architecture enables rapid development while maintaining high code quality and comprehensive documentation coverage across all supported platforms.
