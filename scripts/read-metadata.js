#!/usr/bin/env node
/**
 * SSOT Metadata Reader
 * 從 config/metadata.json 讀取版本資訊
 * 
 * 用法:
 *   node scripts/read-metadata.js                    # 顯示所有資訊
 *   node scripts/read-metadata.js --project-version  # 專案版本
 *   node scripts/read-metadata.js --claude-version   # Claude Code 版本
 *   node scripts/read-metadata.js --json             # 輸出 JSON
 */

const fs = require('fs');
const path = require('path');

const METADATA_PATH = path.join(__dirname, '..', 'config', 'metadata.json');

function readMetadata() {
    try {
        const content = fs.readFileSync(METADATA_PATH, 'utf8');
        return JSON.parse(content);
    } catch (error) {
        console.error(`Error reading metadata: ${error.message}`);
        process.exit(1);
    }
}

function main() {
    const args = process.argv.slice(2);
    const metadata = readMetadata();
    
    if (args.includes('--json')) {
        console.log(JSON.stringify(metadata, null, 2));
        return;
    }
    
    if (args.includes('--project-version')) {
        console.log(metadata.project.version);
        return;
    }
    
    if (args.includes('--claude-version')) {
        console.log(metadata.claudeCode.version);
        return;
    }
    
    if (args.includes('--last-updated')) {
        console.log(metadata.lastUpdated);
        return;
    }
    
    if (args.includes('--active-projects')) {
        console.log(metadata.documentation.totalProjects);
        return;
    }
    
    if (args.includes('--list-projects')) {
        metadata.projects.forEach(p => {
            console.log(`${p.id}: v${p.version} (${p.lastUpdate})`);
        });
        return;
    }
    
    // 預設：顯示摘要
    console.log('=== SSOT Metadata Summary ===');
    console.log(`Project: ${metadata.project.name} v${metadata.project.version}`);
    console.log(`Claude Code: v${metadata.claudeCode.version}`);
    console.log(`Last Updated: ${metadata.lastUpdated}`);
    console.log(`Active Projects: ${metadata.documentation.totalProjects}`);
    console.log(`Archived Projects: ${metadata.documentation.archivedProjects}`);
    console.log('\nUse --help for more options');
}

if (require.main === module) {
    main();
}

module.exports = { readMetadata };
