# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Claude Code Chinese Documentation Hub** - a comprehensive collection of Chinese language documentation for Claude Code and Cursor AI integration. The repository (GitHub: s123104/claude-code-zh-tw) contains 8 specialized documents covering different aspects of Claude Code usage, from basic installation to advanced features, with a focus on Traditional Chinese localization.

## Repository Structure

```
/
├── README.md                     # Main project overview and navigation (v2.0.0)
├── claude-code-zh-tw.md         # Project summary with complete CLI reference
├── CLAUDE.md                     # This file - project memory for Claude Code
├── docs/                        # All documentation files
│   ├── README.md                # Document index and quick reference
│   ├── cursor-claude-master-guide-zh-tw.md    # **Primary guide - start here**
│   ├── claude-code-guide-zh-tw.md             # Basic API and commands
│   ├── awesome-claude-code-zh-tw.md           # Community best practices
│   ├── superclaude-zh-tw.md                   # Advanced flag system
│   ├── claude-code-usage-monitor-zh-tw.md     # Usage monitoring & security
│   ├── claudecodeui-zh-tw.md                  # Web UI and visualization
│   └── bplustree3-zh-tw.md                    # Performance optimization
├── img/                         # Assets directory
│   └── logo.png                 # Claude Code logo (pixelated style)
├── index.html                   # Modern interactive web interface
├── wsl_claude_code_setup.sh    # WSL automated installation script
└── .claude/                     # Claude Code project configuration
    └── settings.local.json      # Local permissions and settings
```

## Document Categories

### Core Documents
- **cursor-claude-master-guide-zh-tw.md**: Master control guide - comprehensive overview of all features with v2.0.0 intelligent agent system
- **claude-code-guide-zh-tw.md**: Basic API guide and fundamental commands with MCP integration
- **docs/README.md**: Document index with quick navigation and WSL setup guide

### Specialized Documents
- **awesome-claude-code-zh-tw.md**: Community best practices, workflows, hooks, and integrations
- **superclaude-zh-tw.md**: Advanced flag system, personas, and complex automation
- **claude-code-usage-monitor-zh-tw.md**: Usage monitoring, security, cost control, and Docker deployment
- **claudecodeui-zh-tw.md**: Web UI interface, PWA features, and remote management
- **bplustree3-zh-tw.md**: Performance optimization strategies and B+Tree caching

### Project Assets
- **img/logo.png**: Claude Code logo in pixelated style with 3D cube design
- **index.html**: Modern interactive web interface with responsive design, animations, and easter eggs
- **wsl_claude_code_setup.sh**: Comprehensive WSL environment setup script with error handling

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

## New Features in v2.0.0

### Intelligent Agent System
- **Multi-modal Analysis**: Support for images, documents, code visualization
- **Deep Learning Intent Recognition**: Automatic parsing of ambiguous requirements
- **Real-time Collaboration**: Multi-user synchronization and conflict resolution
- **Sequential-Thinking Execution**: 4-stage execution process (analysis → planning → execution → integration)

### Enhanced Web Interface (index.html)
- **Modern Responsive Design**: Mobile-first approach with Tailwind CSS
- **Interactive Features**: Animations, easter eggs, terminal demo
- **PWA Support**: Installable on desktop and mobile devices
- **Accessibility**: WCAG AA compliance with keyboard navigation

### WSL Automation (wsl_claude_code_setup.sh)
- **Windows Environment Detection**: Automatic system compatibility checks
- **Virtualization Verification**: VT-x/AMD-V, SLAT, Hyper-V requirements
- **Path Pollution Cleanup**: Automatic npm configuration cleanup
- **Error Recovery**: Comprehensive error handling and logging system
- **One-click Installation**: Complete WSL to Claude Code deployment

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
- **Containerization**: Docker support via wsl_claude_code_setup.sh
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
- **GitHub Repository**: s123104/claude-code-zh-tw
- **Current Version**: v2.0.0
- **Last Update**: 2025-07-15T14:16:31+08:00
- **Language**: Traditional Chinese (繁體中文)
- **License**: MIT License
- **Branch**: master (ahead of origin/master by 2 commits)

### Project Configuration
- **Claude Code Settings**: `.claude/settings.local.json`
- **Permissions**: Configured for Bash, WebFetch, MCP operations
- **Allowed Tools**: Edit, View, Bash, Write, Read, Git operations
- **Logo**: Custom pixelated Claude Code logo with 3D cube design

This comprehensive documentation hub ensures Chinese-speaking developers can effectively integrate Claude Code into their development workflows with full feature coverage and practical examples.