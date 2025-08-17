#!/usr/bin/env node

/**
 * Claude Code 自動文檔更新器
 * 基於 Context7 最新最佳實踐
 * 
 * 功能:
 * - 自動檢查 repositories 版本更新
 * - 使用 Claude Code stream-json 輸出處理文檔
 * - 整合 MCP 協作功能
 * - 維護繁體中文文檔一致性
 */

const fs = require('fs').promises;
const path = require('path');
const { execSync } = require('child_process');

class AutoDocUpdater {
  constructor() {
    this.repos = [
      'SuperClaude_Framework',
      'agents', 
      'awesome-claude-code',
      'claude-code-guide',
      'claudecodeui',
      'BPlusTree3',
      'claudia',
      'claude-code-hooks',
      'claude-code-spec',
      'ccusage',
      'vibe-kanban',
      'claude-agents',
      'ClaudeCode-Debugger',
      'claude-code-leaderboard',
      'context-engineering-intro',
      'contains-studio-agents',
      'claude-code-security-review'
    ];
    
    this.basePath = '/Users/azlife.eth/claude-code';
    this.analysisPath = path.join(this.basePath, 'analysis-projects');
    this.docsPath = path.join(this.basePath, 'docs');
  }

  /**
   * 主要更新流程
   */
  async run() {
    console.log('🚀 Claude Code 自動文檔更新器啟動');
    console.log('📊 使用 Claude Code stream-json 輸出格式');
    
    try {
      // 1. 檢查版本更新
      const updates = await this.checkVersionUpdates();
      
      // 2. 更新有變更的文檔
      if (updates.length > 0) {
        await this.updateDocuments(updates);
        
        // 3. 使用 Claude Code MCP 協作功能
        await this.runClaudeCodeMCP();
        
        // 4. 品質檢查
        await this.qualityCheck();
        
        // 5. 生成報告
        await this.generateReport(updates);
      } else {
        console.log('✅ 所有文檔均為最新版本');
      }
      
    } catch (error) {
      console.error('❌ 更新過程發生錯誤:', error.message);
      process.exit(1);
    }
  }

  /**
   * 檢查版本更新
   */
  async checkVersionUpdates() {
    console.log('🔍 檢查 repositories 版本更新...');
    const updates = [];
    
    for (const repo of this.repos) {
      try {
        const repoPath = path.join(this.analysisPath, repo);
        
        // 使用 git 檢查是否有新的 commits
        const currentCommit = execSync('git rev-parse HEAD', { 
          cwd: repoPath, 
          encoding: 'utf8' 
        }).trim();
        
        // 拉取最新變更
        execSync('git fetch origin', { cwd: repoPath });
        
        const latestCommit = execSync('git rev-parse origin/main || git rev-parse origin/master', { 
          cwd: repoPath, 
          encoding: 'utf8' 
        }).trim();
        
        if (currentCommit !== latestCommit) {
          updates.push({
            repo,
            currentCommit: currentCommit.substring(0, 7),
            latestCommit: latestCommit.substring(0, 7),
            path: repoPath
          });
          console.log(`📋 ${repo}: 發現更新 ${currentCommit.substring(0, 7)} → ${latestCommit.substring(0, 7)}`);
        }
        
      } catch (error) {
        console.warn(`⚠️  無法檢查 ${repo}:`, error.message);
      }
    }
    
    return updates;
  }

  /**
   * 更新文檔
   */
  async updateDocuments(updates) {
    console.log('📝 更新文檔...');
    
    for (const update of updates) {
      try {
        // 拉取最新變更
        execSync('git pull origin main || git pull origin master', { 
          cwd: update.path 
        });
        
        // 使用 Claude Code 生成更新的繁體中文文檔
        await this.generateChineseDoc(update.repo, update.path);
        
        console.log(`✅ ${update.repo} 文檔已更新`);
        
      } catch (error) {
        console.error(`❌ 更新 ${update.repo} 失敗:`, error.message);
      }
    }
  }

  /**
   * 生成繁體中文文檔
   */
  async generateChineseDoc(repoName, repoPath) {
    const docFile = path.join(this.docsPath, `${repoName.toLowerCase()}-zh-tw.md`);
    
    // 讀取專案資訊
    const readmePath = path.join(repoPath, 'README.md');
    let readmeContent = '';
    
    try {
      readmeContent = await fs.readFile(readmePath, 'utf8');
    } catch (error) {
      console.warn(`⚠️  無法讀取 ${repoName} 的 README.md`);
    }
    
    // 獲取最新 commit 資訊
    const lastCommit = execSync('git log -1 --format="%H|%ad|%s" --date=iso', { 
      cwd: repoPath, 
      encoding: 'utf8' 
    }).trim();
    
    const [commitHash, commitDate, commitMessage] = lastCommit.split('|');
    
    // 使用 Claude Code stream-json 格式處理
    const prompt = `請根據以下專案資訊生成完整的繁體中文文檔：

專案名稱: ${repoName}
最後更新: ${commitDate}
最新提交: ${commitHash.substring(0, 7)} - ${commitMessage}

README 內容:
${readmeContent}

請輸出格式化的繁體中文文檔，包含：
1. 專案概述
2. 安裝指南
3. 使用方法
4. 主要功能
5. 版本資訊`;

    try {
      // 使用 Claude Code CLI 與 stream-json 輸出
      const claudeOutput = execSync(`claude -p --output-format=stream-json "${prompt}"`, {
        encoding: 'utf8',
        maxBuffer: 1024 * 1024 * 10 // 10MB buffer
      });
      
      // 解析 stream-json 輸出
      const lines = claudeOutput.split('\n').filter(line => line.trim());
      let docContent = '';
      
      for (const line of lines) {
        try {
          const data = JSON.parse(line);
          if (data.content) {
            docContent += data.content;
          }
        } catch (e) {
          // 跳過無效的 JSON 行
        }
      }
      
      if (docContent) {
        await fs.writeFile(docFile, docContent, 'utf8');
        console.log(`📄 已生成 ${repoName} 繁體中文文檔`);
      }
      
    } catch (error) {
      console.error(`❌ Claude Code 處理失敗:`, error.message);
    }
  }

  /**
   * 運行 Claude Code MCP 協作
   */
  async runClaudeCodeMCP() {
    console.log('🤖 啟動 Claude Code MCP 協作功能...');
    
    try {
      // 檢查 MCP 狀態
      execSync('claude mcp list', { encoding: 'utf8' });
      
      // 執行 MCP 協作任務
      const mcpPrompt = `請協助檢查並優化以下文檔的品質：
1. 檢查所有繁體中文文檔的格式一致性
2. 驗證連結的有效性
3. 確保版本資訊的準確性
4. 標準化文檔結構`;
      
      execSync(`claude --mcp-debug "${mcpPrompt}"`, {
        stdio: 'inherit'
      });
      
      console.log('✅ MCP 協作任務完成');
      
    } catch (error) {
      console.warn('⚠️  MCP 功能暫時無法使用:', error.message);
    }
  }

  /**
   * 品質檢查
   */
  async qualityCheck() {
    console.log('🔍 執行品質檢查...');
    
    const docFiles = await fs.readdir(this.docsPath);
    const zhTwFiles = docFiles.filter(file => file.endsWith('-zh-tw.md'));
    
    const issues = [];
    
    for (const file of zhTwFiles) {
      const filePath = path.join(this.docsPath, file);
      const content = await fs.readFile(filePath, 'utf8');
      
      // 檢查必要元素
      if (!content.includes('文件整理時間')) {
        issues.push(`${file}: 缺少文件整理時間`);
      }
      
      if (!content.includes('版本')) {
        issues.push(`${file}: 缺少版本資訊`);
      }
      
      if (content.length < 500) {
        issues.push(`${file}: 內容過短 (${content.length} 字元)`);
      }
    }
    
    if (issues.length > 0) {
      console.log('⚠️  發現品質問題:');
      issues.forEach(issue => console.log(`  - ${issue}`));
    } else {
      console.log('✅ 品質檢查通過');
    }
    
    return issues;
  }

  /**
   * 生成更新報告
   */
  async generateReport(updates) {
    const timestamp = new Date().toISOString();
    const report = {
      timestamp,
      totalUpdates: updates.length,
      updates: updates.map(u => ({
        repo: u.repo,
        changes: `${u.currentCommit} → ${u.latestCommit}`
      })),
      nextCheck: new Date(Date.now() + 6 * 60 * 60 * 1000).toISOString() // 6小時後
    };
    
    const reportPath = path.join(this.basePath, '.update-report.json');
    await fs.writeFile(reportPath, JSON.stringify(report, null, 2), 'utf8');
    
    console.log('📊 更新報告已生成:', reportPath);
    console.log(`✅ 總計更新 ${updates.length} 個專案`);
  }
}

// 執行更新器
if (require.main === module) {
  const updater = new AutoDocUpdater();
  updater.run().catch(console.error);
}

module.exports = AutoDocUpdater;
