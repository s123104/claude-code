#!/usr/bin/env node
/**
 * Claude Code 文檔自動同步至 index.html 工具
 * 
 * 功能：
 * - 自動讀取所有繁體中文文檔的元資料
 * - 提取：版本、更新時間、功能、場景、客群
 * - 自動同步更新到 index.html 的專案卡片
 * 
 * 使用：
 *   node scripts/sync-index-docs.js
 *   node scripts/sync-index-docs.js --dry-run  # 乾模式預覽
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.join(__dirname, '..');

// 顏色輸出
const colors = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
};

function log(level, message) {
  const timestamp = new Date().toLocaleTimeString('zh-TW', { hour12: false });
  const prefix = {
    INFO: `${colors.blue}ℹ️  [${timestamp}]${colors.reset}`,
    SUCCESS: `${colors.green}✅ [${timestamp}]${colors.reset}`,
    WARNING: `${colors.yellow}⚠️  [${timestamp}]${colors.reset}`,
    ERROR: `${colors.red}❌ [${timestamp}]${colors.reset}`,
  };
  console.log(`${prefix[level]} ${message}`);
}

// 專案配置映射表
const projectsConfig = [
  // 核心文檔類
  {
    id: 'claude-code-official',
    file: 'claude-code-zh-tw.md',
    category: 'core',
    tags: ['官方', '必讀', '基礎', 'Subagents', 'AgentSkills'],
    badge: '核心必讀',
    icon: 'book',
    title: 'Claude Code 官方手冊',
    color: 'red',
    independence: '⭐⭐⭐',
  },
  {
    id: 'cursor-claude-master',
    file: 'docs/cursor-claude-master-guide-zh-tw.md',
    category: 'core',
    tags: ['整合', '主控', '索引', 'AgentSkills'],
    badge: '綜合整合',
    icon: 'sitemap',
    title: '綜合代理主控手冊',
    color: 'primary',
    independence: '⭐⭐⭐',
  },
  {
    id: 'docs-index',
    file: 'docs/README.md',
    category: 'core',
    tags: ['文檔', '導覽', '索引'],
    badge: '文檔索引',
    icon: 'list',
    title: '完整文檔導覽索引',
    color: 'orange',
    independence: '⭐⭐⭐',
  },
  
  // 增強框架類
  {
    id: 'awesome-claude-code',
    file: 'docs/awesome-claude-code-zh-tw.md',
    category: 'framework',
    tags: ['社群', '最佳實踐', '範例', 'AgentSkills'],
    badge: '社群資源',
    icon: 'star',
    title: 'Awesome Claude Code 資源集',
    color: 'green',
    independence: '⭐⭐⭐',
  },
  {
    id: 'superclaude',
    file: 'docs/superclaude-zh-tw.md',
    category: 'framework',
    tags: ['高階', 'Persona', 'MCP', 'DeepResearch', 'AgentSkills'],
    badge: '專業框架',
    icon: 'magic',
    title: 'SuperClaude 專業框架',
    color: 'secondary',
    independence: '⭐⭐⭐',
  },
  
  // AI 代理類
  {
    id: 'agents',
    file: 'docs/agents-zh-tw.md',
    category: 'agents',
    tags: ['Plugins', '85代理', '47技能', '專業'],
    badge: 'Plugin Marketplace',
    icon: 'robot',
    title: 'Claude Code Plugins 插件市場',
    color: 'blue',
    independence: '⭐⭐⭐',
  },
  // claude-agents 已淘汰（2025-12-24），建議使用 agents (wshobson)
  {
    id: 'contains-studio-agents',
    file: 'docs/contains-studio-agents-zh-tw.md',
    category: 'agents',
    tags: ['Studio', '專業代理'],
    badge: '工作室代理',
    icon: 'building',
    title: 'Contains Studio 代理集合',
    color: 'teal',
    independence: '⭐⭐',
  },
  
  // 監控分析類
  // usage-monitor 已淘汰（2025-12-24），建議使用 ccusage
  {
    id: 'ccusage',
    file: 'docs/ccusage-zh-tw.md',
    category: 'monitoring',
    tags: ['極速分析', '狀態列', 'Family'],
    badge: 'ccusage Family',
    icon: 'tachometer-alt',
    title: 'ccusage Family 極速分析',
    color: 'orange',
    independence: '⭐⭐⭐',
  },
  
  // 介面工具類
  {
    id: 'claudecodeui',
    file: 'docs/claudecodeui-zh-tw.md',
    category: 'interface',
    tags: ['Web UI', 'TaskMaster', '行動'],
    badge: '全端 Web UI',
    icon: 'desktop',
    title: 'ClaudeCodeUI 全端介面',
    color: 'pink',
    independence: '⭐⭐',
  },
  {
    id: 'opcode',
    file: 'docs/opcode-zh-tw.md',
    category: 'interface',
    tags: ['桌面', 'Tauri', 'opcode'],
    badge: '桌面應用',
    icon: 'window-maximize',
    title: 'opcode 桌面應用',
    color: 'purple',
    independence: '⭐',
  },
  {
    id: 'vibe-kanban',
    file: 'docs/vibe-kanban-zh-tw.md',
    category: 'interface',
    tags: ['看板', '專案管理', '多代理'],
    badge: '專案管理',
    icon: 'tasks',
    title: 'Vibe Kanban 專案管理',
    color: 'cyan',
    independence: '⭐⭐',
  },
  
  // 效能優化類
  {
    id: 'bplustree3',
    file: 'docs/bplustree3-zh-tw.md',
    category: 'performance',
    tags: ['B+Tree', '快取', '效能', 'KentBeck'],
    badge: 'Kent Beck 實驗',
    icon: 'tachometer-alt',
    title: 'BPlusTree3 效能優化',
    color: 'emerald',
    independence: '⭐⭐',
  },
  
  // 安全審查類
  {
    id: 'security-review',
    file: 'docs/claude-code-security-review-zh-tw.md',
    category: 'security',
    tags: ['安全審查', '程式碼掃描', 'GitHub Actions'],
    badge: 'Anthropic 官方',
    icon: 'shield-alt',
    title: 'Claude Code 安全審查工具',
    color: 'red',
    independence: '⭐⭐',
  },
  
  // 指南教學類
  {
    id: 'claude-code-guide',
    file: 'docs/claude-code-guide-zh-tw.md',
    category: 'guides',
    tags: ['基礎API', '指南', 'Subagents'],
    badge: '基礎指南',
    icon: 'graduation-cap',
    title: 'Claude Code 基礎 API 指南',
    color: 'green',
    independence: '⭐⭐',
  },
  {
    id: 'context-engineering',
    file: 'docs/context-engineering-intro-zh-tw.md',
    category: 'guides',
    tags: ['Context工程', '方法論', 'PRP'],
    badge: '方法論',
    icon: 'brain',
    title: 'Context Engineering 方法論',
    color: 'amber',
    independence: '⭐⭐',
  },
  {
    id: 'mcp-setup',
    file: 'docs/mcp-setup-guide-zh-tw.md',
    category: 'guides',
    tags: ['MCP設定', '設定指南'],
    badge: '設定指南',
    icon: 'cogs',
    title: 'MCP 設定指南',
    color: 'violet',
    independence: '⭐⭐',
  },
  
  // 專業工具類
  {
    id: 'claude-code-spec',
    file: 'docs/claude-code-spec-zh-tw.md',
    category: 'tools',
    tags: ['SDD', 'AI-DLC', '規格驗證'],
    badge: 'AI-DLC & SDD',
    icon: 'tools',
    title: 'cc-sdd AI 規格驅動開發',
    color: 'slate',
    independence: '⭐⭐',
  },
  // leaderboard 已淘汰（2025-12-24），無維護
  // debugger 已淘汰（2025-12-24），無維護
];

/**
 * 從 Markdown 文件中提取元資料（標準化格式）
 * 
 * 優先從「專案資訊」和「核心定位」區塊提取，符合 unified-documentation-standard.md
 */
function extractMetadata(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf-8');
    const lines = content.split('\n');
    
    const metadata = {
      projectName: null,
      version: null,
      lastUpdate: null,
      docUpdateTime: null,
      features: null,
      scenarios: null,
      audience: null,
    };
    
    // 狀態追蹤
    let inProjectInfo = false;
    let inCorePosition = false;
    
    // 逐行解析標準化元資料區塊
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();
      
      // 檢測「專案資訊」區塊開始
      if (line === '> **專案資訊**') {
        inProjectInfo = true;
        inCorePosition = false;
        continue;
      }
      
      // 檢測「核心定位」區塊開始
      if (line === '> **核心定位**') {
        inProjectInfo = false;
        inCorePosition = true;
        continue;
      }
      
      // 檢測區塊結束（遇到非引用行）
      if (!line.startsWith('>') && (inProjectInfo || inCorePosition)) {
        inProjectInfo = false;
        inCorePosition = false;
      }
      
      // === 從「專案資訊」區塊提取 ===
      if (inProjectInfo) {
        // 提取專案名稱
        if (line.includes('**專案名稱**')) {
          const match = line.match(/專案名稱[**：:]+\s*(.+)$/);
          if (match) metadata.projectName = match[1].trim();
        }
        
        // 提取專案版本
        if (line.includes('**專案版本**')) {
          const match = line.match(/專案版本[**：:]+\s*(v?[\d.]+[\w.-]*)/);
          if (match) metadata.version = match[1];
        }
        
        // 提取專案最後更新
        if (line.includes('**專案最後更新**')) {
          const match = line.match(/專案最後更新[**：:]+\s*(\d{4}-\d{2}-\d{2})/);
          if (match) metadata.lastUpdate = match[1];
        }
        
        // 提取文件整理時間
        if (line.includes('**文件整理時間**')) {
          const match = line.match(/文件整理時間[**：:]+\s*(\d{4}-\d{2}-\d{2})/);
          if (match) metadata.docUpdateTime = match[1];
        }
      }
      
      // === 從「核心定位」區塊提取 ===
      if (inCorePosition) {
        // 提取功能描述
        if (line.includes('**功能**')) {
          const match = line.match(/功能[**：:]+\s*(.+)$/);
          if (match) {
            metadata.features = match[1].trim();
          }
        }
        
        // 提取場景描述
        if (line.includes('**場景**')) {
          const match = line.match(/場景[**：:]+\s*(.+)$/);
          if (match) {
            metadata.scenarios = match[1].trim();
          }
        }
        
        // 提取客群描述
        if (line.includes('**客群**')) {
          const match = line.match(/客群[**：:]+\s*(.+)$/);
          if (match) {
            metadata.audience = match[1].trim();
          }
        }
      }
    }
    
    // 如果標準化區塊未找到，使用舊方法作為備用
    if (!metadata.version || !metadata.lastUpdate) {
      const fallback = extractMetadataFallback(content);
      metadata.version = metadata.version || fallback.version;
      metadata.lastUpdate = metadata.lastUpdate || fallback.lastUpdate;
    }
    
    // 如果核心定位未找到，使用智能提取作為備用
    if (!metadata.features) {
      metadata.features = extractFeaturesFallback(content);
    }
    if (!metadata.scenarios) {
      metadata.scenarios = extractScenariosFallback(content);
    }
    if (!metadata.audience) {
      metadata.audience = extractAudienceFallback(content);
    }
    
    return metadata;
  } catch (error) {
    log('ERROR', `讀取文件失敗: ${filePath} - ${error.message}`);
    return null;
  }
}

/**
 * 備用：舊格式元資料提取
 */
function extractMetadataFallback(content) {
  const lines = content.split('\n');
  const metadata = { version: null, lastUpdate: null };
  
  for (const line of lines) {
    if ((line.includes('專案版本') || line.includes('版本')) && !metadata.version) {
      const match = line.match(/v?([\d.]+[\w.-]*)/);
      if (match) metadata.version = match[1];
    }
    
    if ((line.includes('文件整理時間') || line.includes('最後更新')) && !metadata.lastUpdate) {
      const match = line.match(/(\d{4}-\d{2}-\d{2})/);
      if (match) metadata.lastUpdate = match[1];
    }
  }
  
  return metadata;
}

/**
 * 備用：智能提取功能描述（從文檔內容）
 */
function extractFeaturesFallback(content) {
  const lines = content.split('\n');
  const features = [];
  
  // 尋找核心功能、主要特色等區塊
  let inFeatureSection = false;
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    
    if (line.match(/##\s*(核心功能|主要特色|核心特色|專案特色)/)) {
      inFeatureSection = true;
      continue;
    }
    
    if (inFeatureSection && line.match(/^##\s/)) {
      break; // 離開功能區塊
    }
    
    if (inFeatureSection && line.match(/^-\s*\*?\*?(.+?)\*?\*?:/)) {
      const match = line.match(/^-\s*\*?\*?(.+?)\*?\*?:/);
      if (match) features.push(match[1].trim());
      if (features.length >= 3) break; // 最多取 3 個
    }
  }
  
  return features.length > 0 ? features.join('、') : '詳見文檔';
}

/**
 * 備用：智能提取應用場景
 */
function extractScenariosFallback(content) {
  const lines = content.split('\n');
  const scenarios = [];
  
  let inScenarioSection = false;
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    
    if (line.match(/##\s*(使用場景|應用場景|適用情境)/)) {
      inScenarioSection = true;
      continue;
    }
    
    if (inScenarioSection && line.match(/^##\s/)) {
      break;
    }
    
    if (inScenarioSection && line.match(/^-\s*\*?\*?(.+?)\*?\*?:/)) {
      const match = line.match(/^-\s*\*?\*?(.+?)\*?\*?:/);
      if (match) scenarios.push(match[1].trim());
      if (scenarios.length >= 3) break;
    }
  }
  
  return scenarios.length > 0 ? scenarios.join('、') : '多種應用場景';
}

/**
 * 備用：智能提取目標客群
 */
function extractAudienceFallback(content) {
  // 基於文檔內容智能推斷
  const audienceMap = {
    'ML': ['ML 分析師', 'SRE 工程師'],
    '監控': ['產品主管', '技術主管', 'FinOps'],
    'Plugin': ['產品/工程團隊', '專案負責人', 'Tech Lead'],
    'Agent Skills': ['進階開發者', '技術主管'],
    'Deep Research': ['研究人員', '架構師'],
    '除錯': ['開發者', '技術支援'],
    '安全': ['安全工程師', 'DevSecOps'],
    'GUI': ['GUI 偏好者', '視覺化用戶'],
    'CLI': ['命令列用戶', '開發者'],
    'Hooks': ['進階用戶', '自動化工程師'],
    '初學': ['初學者', '新手用戶'],
    '企業': ['企業團隊', '技術主管'],
  };
  
  const audiences = new Set();
  for (const [keyword, groups] of Object.entries(audienceMap)) {
    if (content.includes(keyword)) {
      groups.forEach(g => audiences.add(g));
    }
  }
  
  const audienceList = Array.from(audiences).slice(0, 3);
  return audienceList.length > 0 ? audienceList.join('、') : '所有用戶';
}

/**
 * 生成專案卡片 HTML（使用標準化元資料）
 */
function generateProjectCard(config, metadata) {
  if (!metadata) {
    log('WARNING', `跳過 ${config.title}（無元資料）`);
    return null;
  }
  
  const { category, tags, badge, icon, title, color, independence } = config;
  const { version, lastUpdate, docUpdateTime, features, scenarios, audience } = metadata;
  
  // 優先使用標準化格式的字符串，否則使用備用
  const featureText = features || '詳見文檔';
  const scenarioText = scenarios || '多種應用場景';
  const audienceText = audience || '所有用戶';
  
  // 版本和時間資訊（優先使用文件整理時間）
  const versionDisplay = version ? (version.startsWith('v') ? version : `v${version}`) : '最新版';
  const dateDisplay = docUpdateTime || lastUpdate || '2025-10-28';
  
  return `
          <div class="project-card glass-effect rounded-xl p-4 md:p-6 block hover:scale-105 transition observe-fade in-view" data-category="${category}" data-tags="${tags.join(',')}">
            <a href="${config.file}" target="_blank" rel="noopener noreferrer" class="block">
              <div class="flex items-center mb-3">
                <div class="w-3 h-3 bg-${color}-500 rounded-full mr-2"></div>
                <span class="text-xs bg-${color}-500/20 text-${color}-300 px-2 py-1 rounded-full">${badge}</span>
              </div>
              <h3 class="text-lg font-bold text-${color}-400 mb-2">
                <i class="fas fa-${icon} mr-2"></i>${title}
              </h3>
              <p class="text-neutral-200 text-xs mb-3">
                <strong>功能</strong>: ${featureText}<br/>
                <strong>場景</strong>: ${scenarioText}<br/>
                <strong>客群</strong>: ${audienceText}
              </p>
              <div class="flex justify-between items-center text-xs text-neutral-400">
                <span>${versionDisplay} | ${dateDisplay}</span>
                <span class="text-${color}-400">${independence}</span>
              </div>
            </a>
          </div>`;
}

/**
 * 主函數
 */
async function main() {
  const isDryRun = process.argv.includes('--dry-run');
  
  console.log(`${colors.blue}╔══════════════════════════════════════════════════════════════╗${colors.reset}`);
  console.log(`${colors.blue}║     Claude Code 文檔自動同步至 index.html 工具              ║${colors.reset}`);
  console.log(`${colors.blue}╚══════════════════════════════════════════════════════════════╝${colors.reset}\n`);
  
  if (isDryRun) {
    log('WARNING', '乾模式運行 - 不會修改 index.html');
  }
  
  // 讀取所有文檔的元資料
  log('INFO', '開始掃描文檔...');
  const projectsData = [];
  
  for (const config of projectsConfig) {
    const filePath = path.join(rootDir, config.file);
    log('INFO', `讀取: ${config.file}`);
    
    const metadata = extractMetadata(filePath);
    if (metadata) {
      projectsData.push({ config, metadata });
      log('SUCCESS', `✓ ${config.title} - v${metadata.version || '?'} (${metadata.lastUpdate || '?'})`);
    }
  }
  
  log('INFO', `\n已掃描 ${projectsData.length} 個專案文檔`);
  
  // 生成所有專案卡片
  log('INFO', '\n生成專案卡片 HTML...');
  const cards = [];
  
  // 按類別分組
  const categories = {
    core: '📚 核心文檔類',
    framework: '🎨 增強框架類',
    agents: '🤖 AI 代理類',
    monitoring: '📊 監控分析類',
    interface: '🖥️ 介面工具類',
    performance: '⚡ 效能優化類',
    security: '🔒 安全審查類',
    guides: '📖 指南教學類',
    tools: '🔧 專業工具類',
  };
  
  for (const [catKey, catName] of Object.entries(categories)) {
    const categoryProjects = projectsData.filter(p => p.config.category === catKey);
    if (categoryProjects.length > 0) {
      cards.push(`\n          <!-- ${catName} -->`);
      categoryProjects.forEach(({ config, metadata }) => {
        const card = generateProjectCard(config, metadata);
        if (card) cards.push(card);
      });
    }
  }
  
  const allCardsHTML = cards.join('\n');
  
  if (isDryRun) {
    log('INFO', '\n=== 乾模式預覽（前 500 字元）===');
    console.log(allCardsHTML.substring(0, 500) + '...\n');
    log('SUCCESS', '乾模式完成！');
    return;
  }
  
  // 讀取 index.html
  log('INFO', '\n讀取 index.html...');
  const indexPath = path.join(rootDir, 'index.html');
  let indexContent = fs.readFileSync(indexPath, 'utf-8');
  
  // 找到專案網格區塊並替換
  const gridStartMarker = '<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 md:gap-6" id="projects-grid">';
  const gridEndMarker = '</div>\n\n        <!-- GitHub Repository Information -->';
  
  const startIndex = indexContent.indexOf(gridStartMarker);
  const endIndex = indexContent.indexOf(gridEndMarker);
  
  if (startIndex === -1 || endIndex === -1) {
    log('ERROR', '找不到專案網格區塊標記！');
    return;
  }
  
  const newGridContent = `${gridStartMarker}\n          ${allCardsHTML}\n        `;
  
  indexContent = 
    indexContent.substring(0, startIndex) +
    newGridContent +
    indexContent.substring(endIndex);
  
  // 寫回 index.html
  log('INFO', '寫入 index.html...');
  fs.writeFileSync(indexPath, indexContent, 'utf-8');
  
  log('SUCCESS', '\n✅ index.html 專案卡片已成功更新！');
  log('INFO', `更新了 ${projectsData.length} 個專案卡片`);
  
  // 生成摘要報告
  console.log(`\n${colors.bright}═══ 更新摘要 ═══${colors.reset}`);
  console.log(`總專案數: ${projectsData.length}`);
  console.log(`核心文檔: ${projectsData.filter(p => p.config.category === 'core').length}`);
  console.log(`增強框架: ${projectsData.filter(p => p.config.category === 'framework').length}`);
  console.log(`AI 代理: ${projectsData.filter(p => p.config.category === 'agents').length}`);
  console.log(`監控分析: ${projectsData.filter(p => p.config.category === 'monitoring').length}`);
  console.log(`介面工具: ${projectsData.filter(p => p.config.category === 'interface').length}`);
  console.log(`專業工具: ${projectsData.filter(p => p.config.category === 'tools').length}`);
  console.log(`其他類別: ${projectsData.filter(p => !['core', 'framework', 'agents', 'monitoring', 'interface', 'tools'].includes(p.config.category)).length}`);
  console.log(`${colors.bright}═════════════${colors.reset}\n`);
}

// 執行
main().catch(error => {
  log('ERROR', `執行失敗: ${error.message}`);
  console.error(error);
  process.exit(1);
});

