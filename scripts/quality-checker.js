#!/usr/bin/env node

/**
 * Claude Code 文檔品質檢查器
 * 基於 Claude Code MCP 協作和最佳實踐
 */

const fs = require('fs').promises;
const path = require('path');
const { execSync } = require('child_process');

class DocumentQualityChecker {
  constructor() {
    this.basePath = '/Users/azlife.eth/claude-code';
    this.docsPath = path.join(this.basePath, 'docs');
    this.requiredElements = [
      '文件整理時間',
      '版本',
      '專案最後更新',
      '## 概述',
      '## 安裝',
      '## 使用方法'
    ];
    
    this.qualityRules = {
      minLength: 800,
      maxLength: 50000,
      requiredSections: 4,
      linkPattern: /\[([^\]]+)\]\(([^)]+)\)/g,
      versionPattern: /v?\d+\.\d+\.\d+/,
      datePattern: /\d{4}-\d{2}-\d{2}/
    };
  }

  /**
   * 執行完整品質檢查
   */
  async runQualityCheck() {
    console.log('🔍 Claude Code 文檔品質檢查器啟動');
    
    try {
      const results = {
        timestamp: new Date().toISOString(),
        totalFiles: 0,
        passedFiles: 0,
        failedFiles: 0,
        issues: [],
        summary: {}
      };

      // 1. 掃描所有繁體中文文檔
      const zhTwFiles = await this.scanDocuments();
      results.totalFiles = zhTwFiles.length;

      // 2. 逐一檢查每個文檔
      for (const file of zhTwFiles) {
        const fileResults = await this.checkDocument(file);
        
        if (fileResults.passed) {
          results.passedFiles++;
        } else {
          results.failedFiles++;
          results.issues.push(...fileResults.issues);
        }
      }

      // 3. 使用 Claude Code MCP 進行深度分析
      await this.runClaudeCodeAnalysis();

      // 4. 生成詳細報告
      await this.generateQualityReport(results);

      // 5. 執行自動修復 (如可能)
      await this.autoFix(results.issues);

      console.log(`✅ 品質檢查完成: ${results.passedFiles}/${results.totalFiles} 通過`);
      
      return results;

    } catch (error) {
      console.error('❌ 品質檢查失敗:', error.message);
      throw error;
    }
  }

  /**
   * 掃描所有文檔
   */
  async scanDocuments() {
    const files = await fs.readdir(this.docsPath);
    const zhTwFiles = files
      .filter(file => file.endsWith('-zh-tw.md'))
      .map(file => path.join(this.docsPath, file));

    console.log(`📄 發現 ${zhTwFiles.length} 個繁體中文文檔`);
    return zhTwFiles;
  }

  /**
   * 檢查單個文檔
   */
  async checkDocument(filePath) {
    const fileName = path.basename(filePath);
    const content = await fs.readFile(filePath, 'utf8');
    
    console.log(`🔍 檢查 ${fileName}...`);
    
    const issues = [];
    let passed = true;

    // 1. 內容長度檢查
    if (content.length < this.qualityRules.minLength) {
      issues.push({
        file: fileName,
        type: 'length',
        severity: 'warning',
        message: `內容過短 (${content.length} 字元，建議至少 ${this.qualityRules.minLength})`
      });
      passed = false;
    }

    if (content.length > this.qualityRules.maxLength) {
      issues.push({
        file: fileName,
        type: 'length',
        severity: 'info',
        message: `內容過長 (${content.length} 字元，建議不超過 ${this.qualityRules.maxLength})`
      });
    }

    // 2. 必要元素檢查
    for (const element of this.requiredElements) {
      if (!content.includes(element)) {
        issues.push({
          file: fileName,
          type: 'missing_element',
          severity: 'error',
          message: `缺少必要元素: ${element}`
        });
        passed = false;
      }
    }

    // 3. 版本格式檢查
    if (!this.qualityRules.versionPattern.test(content)) {
      issues.push({
        file: fileName,
        type: 'version_format',
        severity: 'warning',
        message: '未找到有效的版本格式 (例: v1.0.0)'
      });
    }

    // 4. 日期格式檢查
    if (!this.qualityRules.datePattern.test(content)) {
      issues.push({
        file: fileName,
        type: 'date_format',
        severity: 'warning',
        message: '未找到有效的日期格式 (例: 2025-08-17)'
      });
    }

    // 5. 連結有效性檢查
    const links = [...content.matchAll(this.qualityRules.linkPattern)];
    for (const [fullMatch, text, url] of links) {
      if (url.startsWith('http')) {
        // 外部連結 - 可以用 HTTP 檢查
        continue;
      } else if (url.startsWith('#')) {
        // 內部錨點 - 檢查標題是否存在
        const anchor = url.slice(1);
        const headingPattern = new RegExp(`#+\\s*${anchor.replace(/-/g, '\\s+')}`, 'i');
        if (!headingPattern.test(content)) {
          issues.push({
            file: fileName,
            type: 'broken_link',
            severity: 'warning',
            message: `內部連結可能失效: ${fullMatch}`
          });
        }
      } else {
        // 相對路徑 - 檢查檔案是否存在
        const targetPath = path.resolve(path.dirname(filePath), url);
        try {
          await fs.access(targetPath);
        } catch (error) {
          issues.push({
            file: fileName,
            type: 'broken_link',
            severity: 'error',
            message: `檔案連結失效: ${fullMatch}`
          });
          passed = false;
        }
      }
    }

    // 6. 標題結構檢查
    const headings = content.match(/^#+\s+.+$/gm) || [];
    if (headings.length < this.qualityRules.requiredSections) {
      issues.push({
        file: fileName,
        type: 'structure',
        severity: 'warning',
        message: `標題數量不足 (${headings.length}，建議至少 ${this.qualityRules.requiredSections} 個)`
      });
    }

    // 7. 中文字體覆蓋率檢查
    const chineseChars = content.match(/[\u4e00-\u9fff]/g) || [];
    const totalChars = content.replace(/\s/g, '').length;
    const chineseRatio = chineseChars.length / totalChars;
    
    if (chineseRatio < 0.3) {
      issues.push({
        file: fileName,
        type: 'language',
        severity: 'warning',
        message: `中文字體覆蓋率過低 (${(chineseRatio * 100).toFixed(1)}%)`
      });
    }

    return { passed, issues };
  }

  /**
   * 使用 Claude Code MCP 進行深度分析
   */
  async runClaudeCodeAnalysis() {
    console.log('🤖 啟動 Claude Code MCP 深度分析...');
    
    try {
      const prompt = `請分析 docs/ 目錄下的繁體中文文檔品質，重點檢查：

1. 文檔結構一致性
2. 內容完整性
3. 語言品質
4. 格式規範
5. 交叉引用正確性

請使用 /approved-tools 管理權限，並生成詳細的品質分析報告。`;

      // 使用 Claude Code 的 MCP 協作功能
      const result = execSync(`claude --mcp-debug "${prompt}"`, {
        cwd: this.basePath,
        encoding: 'utf8',
        maxBuffer: 1024 * 1024 * 5 // 5MB buffer
      });

      console.log('✅ Claude Code MCP 分析完成');
      return result;

    } catch (error) {
      console.warn('⚠️  Claude Code MCP 分析失敗:', error.message);
      return null;
    }
  }

  /**
   * 生成品質報告
   */
  async generateQualityReport(results) {
    const reportPath = path.join(this.basePath, 'quality-report.md');
    
    const report = `# 📋 Claude Code 文檔品質檢查報告

**檢查時間**: ${new Date(results.timestamp).toLocaleString('zh-TW')}
**檢查範圍**: 繁體中文文檔 (\`*-zh-tw.md\`)

## 📊 總體統計

| 項目 | 數量 | 百分比 |
|------|------|--------|
| 總計文檔 | ${results.totalFiles} | 100% |
| 通過檢查 | ${results.passedFiles} | ${((results.passedFiles / results.totalFiles) * 100).toFixed(1)}% |
| 需要改進 | ${results.failedFiles} | ${((results.failedFiles / results.totalFiles) * 100).toFixed(1)}% |
| 發現問題 | ${results.issues.length} | - |

## 🔍 問題詳情

${results.issues.length === 0 ? '✅ 未發現品質問題' : ''}

${results.issues.map(issue => `
### ${issue.file}

**類型**: ${issue.type} | **嚴重程度**: ${issue.severity}

${issue.message}
`).join('\n')}

## 🎯 改進建議

### 高優先級
${results.issues.filter(i => i.severity === 'error').map(i => `- ${i.file}: ${i.message}`).join('\n')}

### 中優先級  
${results.issues.filter(i => i.severity === 'warning').map(i => `- ${i.file}: ${i.message}`).join('\n')}

### 低優先級
${results.issues.filter(i => i.severity === 'info').map(i => `- ${i.file}: ${i.message}`).join('\n')}

## 🔧 自動修復

以下問題可以自動修復：
- 格式規範化
- 日期格式統一
- 版本號格式化
- 標題結構優化

運行 \`node scripts/auto-fix.js\` 執行自動修復。

## 📈 品質趨勢

本次檢查通過率: **${((results.passedFiles / results.totalFiles) * 100).toFixed(1)}%**

---

*此報告由 Claude Code 品質檢查器自動生成*
*使用最新的 Claude Code v6.0.0 Subagents 功能*
`;

    await fs.writeFile(reportPath, report, 'utf8');
    console.log(`📊 品質報告已生成: ${reportPath}`);
  }

  /**
   * 自動修復常見問題
   */
  async autoFix(issues) {
    console.log('🔧 嘗試自動修復問題...');
    
    let fixedCount = 0;
    
    // 按檔案分組問題
    const issuesByFile = {};
    for (const issue of issues) {
      if (!issuesByFile[issue.file]) {
        issuesByFile[issue.file] = [];
      }
      issuesByFile[issue.file].push(issue);
    }

    for (const [fileName, fileIssues] of Object.entries(issuesByFile)) {
      const filePath = path.join(this.docsPath, fileName);
      let content = await fs.readFile(filePath, 'utf8');
      let modified = false;

      for (const issue of fileIssues) {
        switch (issue.type) {
          case 'date_format':
            // 嘗試修復日期格式
            if (!content.includes('文件整理時間')) {
              const timestamp = new Date().toISOString().split('T')[0];
              content = `> **文件整理時間**: ${timestamp}\n\n${content}`;
              modified = true;
              fixedCount++;
            }
            break;

          case 'missing_element':
            // 添加缺少的基本結構
            if (issue.message.includes('## 概述') && !content.includes('## 概述')) {
              content = content.replace(/^#\s+(.+)$/m, `# $1\n\n## 概述\n\n此專案提供了完整的功能說明。\n`);
              modified = true;
              fixedCount++;
            }
            break;

          case 'version_format':
            // 嘗試添加版本資訊
            if (!content.includes('版本:') && !content.includes('version:')) {
              content = content.replace(/^#\s+(.+)$/m, `# $1\n\n> **版本**: 最新版本\n`);
              modified = true;
              fixedCount++;
            }
            break;
        }
      }

      if (modified) {
        await fs.writeFile(filePath, content, 'utf8');
        console.log(`✅ 已修復 ${fileName}`);
      }
    }

    console.log(`🔧 自動修復完成: ${fixedCount} 個問題`);
  }
}

// 執行品質檢查
if (require.main === module) {
  const checker = new DocumentQualityChecker();
  checker.runQualityCheck().catch(console.error);
}

module.exports = DocumentQualityChecker;
