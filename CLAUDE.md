# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Claude Code Chinese Documentation Hub** - a comprehensive collection of Chinese language documentation for Claude Code and Cursor AI integration. The repository contains 8 specialized documents covering different aspects of Claude Code usage, from basic installation to advanced features.

## Repository Structure

```
/
├── README.md                     # Main project overview and navigation
├── claude-code-zh-tw.md         # Project summary (duplicate of README)
├── docs/                        # All documentation files
│   ├── README.md                # Document index and quick reference
│   ├── cursor-claude-master-guide-zh-tw.md    # **Primary guide - start here**
│   ├── claude-code-guide-zh-tw.md             # Basic API and commands
│   ├── awesome-claude-code-zh-tw.md           # Community best practices
│   ├── superclaude-zh-tw.md                   # Advanced flag system
│   ├── claude-code-usage-monitor-zh-tw.md     # Usage monitoring & security
│   ├── claudecodeui-zh-tw.md                  # Web UI and visualization
│   └── bplustree3-zh-tw.md                    # Performance optimization
├── index.html                   # Simple web viewer
└── wsl_claude_code_setup.sh    # WSL installation script
```

## Document Categories

### Core Documents
- **cursor-claude-master-guide-zh-tw.md**: Master control guide - comprehensive overview of all features
- **claude-code-guide-zh-tw.md**: Basic API guide and fundamental commands
- **docs/README.md**: Document index with quick navigation

### Specialized Documents
- **awesome-claude-code-zh-tw.md**: Community best practices, workflows, and integrations
- **superclaude-zh-tw.md**: Advanced flag system and complex automation
- **claude-code-usage-monitor-zh-tw.md**: Usage monitoring, security, and cost control
- **claudecodeui-zh-tw.md**: Web UI interface and PWA features
- **bplustree3-zh-tw.md**: Performance optimization strategies

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

## Development Commands

Since this is a documentation repository, there are no build/test commands. However, for working with the content:

```bash
# View documentation locally (if web server needed)
python3 -m http.server 8000
# or
npx serve .

# Check for broken links (if needed)
# No specific tooling configured - manual verification required

# Git operations for documentation updates
git add docs/
git commit -m "Update documentation"
git push origin master
```

## Content Guidelines

### Document Maintenance
- All documents are in Traditional Chinese (繁體中文)
- Cross-references between documents should be maintained
- Flag examples should be consistent across documents
- Update timestamps when making significant changes

### File Organization
- Main navigation starts from README.md
- Primary content is in cursor-claude-master-guide-zh-tw.md
- Specialized topics have dedicated files in docs/
- No build process - static documentation files

## Usage Context

This repository serves as a comprehensive Chinese language resource for:
- Claude Code installation and setup
- AI-assisted development workflows
- MCP (Multi-Agent Protocol) integration
- Advanced automation with flags and personas
- Production monitoring and security
- Performance optimization strategies

The target audience includes Chinese-speaking developers, architects, and teams looking to integrate Claude Code into their development workflows.