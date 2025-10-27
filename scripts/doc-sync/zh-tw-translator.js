#!/usr/bin/env node

/**
 * Claude Code 強化繁體中文翻譯器
 * 
 * 功能:
 * - 智能識別技術術語並翻譯
 * - 保持程式碼和指令的原樣
 * - 針對 CHANGELOG 內容最佳化
 * - 支援批次翻譯和自訂規則
 */

class TraditionalChineseTranslator {
  constructor() {
    this.initializeTranslations();
    this.setupPatterns();
  }

  initializeTranslations() {
    // 核心技術術語（保持英文或音譯）
    this.coreTerms = new Map([
      ['Claude Code', 'Claude Code'],
      ['Claude', 'Claude'],
      ['API', 'API'],
      ['SDK', 'SDK'],
      ['CLI', 'CLI'],
      ['MCP', 'MCP'],
      ['OAuth', 'OAuth'],
      ['JSON', 'JSON'],
      ['Git', 'Git'],
      ['GitHub', 'GitHub'],
      ['Node.js', 'Node.js'],
      ['npm', 'npm'],
      ['VS Code', 'VS Code'],
      ['VSCode', 'VS Code'],
      ['IDE', 'IDE'],
      ['HTTP', 'HTTP'],
      ['HTTPS', 'HTTPS'],
      ['URL', 'URL'],
      ['UUID', 'UUID'],
      ['TCP', 'TCP'],
      ['SSH', 'SSH'],
      ['VPN', 'VPN'],
      ['DNS', 'DNS'],
      ['SSL', 'SSL'],
      ['TLS', 'TLS'],
      ['JWT', 'JWT'],
      ['UUID', 'UUID'],
      ['YAML', 'YAML'],
      ['XML', 'XML'],
      ['CSV', 'CSV'],
      ['PDF', 'PDF'],
      ['Bash', 'Bash'],
      ['Shell', 'Shell'],
      ['Terminal', '終端機'],
      ['Docker', 'Docker'],
      ['Kubernetes', 'Kubernetes'],
      ['AWS', 'AWS'],
      ['GCP', 'GCP'],
      ['Azure', 'Azure']
    ]);

    // 動作相關翻譯
    this.actionTerms = new Map([
      ['add', '新增'],
      ['added', '已新增'],
      ['fix', '修復'],
      ['fixed', '已修復'],
      ['improve', '改善'],
      ['improved', '已改善'],
      ['update', '更新'],
      ['updated', '已更新'],
      ['upgrade', '升級'],
      ['upgraded', '已升級'],
      ['remove', '移除'],
      ['removed', '已移除'],
      ['delete', '刪除'],
      ['deleted', '已刪除'],
      ['enhance', '增強'],
      ['enhanced', '已增強'],
      ['optimize', '最佳化'],
      ['optimized', '已最佳化'],
      ['refactor', '重構'],
      ['refactored', '已重構'],
      ['support', '支援'],
      ['enable', '啟用'],
      ['enabled', '已啟用'],
      ['disable', '停用'],
      ['disabled', '已停用'],
      ['create', '建立'],
      ['created', '已建立'],
      ['build', '建置'],
      ['built', '已建置'],
      ['install', '安裝'],
      ['installed', '已安裝'],
      ['configure', '設定'],
      ['configured', '已設定'],
      ['implement', '實作'],
      ['implemented', '已實作'],
      ['deploy', '部署'],
      ['deployed', '已部署'],
      ['release', '發布'],
      ['released', '已發布'],
      ['launch', '啟動'],
      ['launched', '已啟動']
    ]);

    // 技術功能翻譯
    this.featureTerms = new Map([
      ['feature', '功能'],
      ['features', '功能'],
      ['function', '函數'],
      ['functions', '函數'],
      ['method', '方法'],
      ['methods', '方法'],
      ['command', '指令'],
      ['commands', '指令'],
      ['tool', '工具'],
      ['tools', '工具'],
      ['option', '選項'],
      ['options', '選項'],
      ['setting', '設定'],
      ['settings', '設定'],
      ['configuration', '設定'],
      ['config', '設定'],
      ['parameter', '參數'],
      ['parameters', '參數'],
      ['argument', '引數'],
      ['arguments', '引數'],
      ['flag', '旗標'],
      ['flags', '旗標'],
      ['switch', '開關'],
      ['switches', '開關'],
      ['mode', '模式'],
      ['modes', '模式'],
      ['status', '狀態'],
      ['state', '狀態'],
      ['session', '會話'],
      ['sessions', '會話'],
      ['connection', '連線'],
      ['connections', '連線'],
      ['integration', '整合'],
      ['integrations', '整合'],
      ['extension', '擴充功能'],
      ['extensions', '擴充功能'],
      ['plugin', '外掛'],
      ['plugins', '外掛'],
      ['module', '模組'],
      ['modules', '模組'],
      ['library', '函式庫'],
      ['libraries', '函式庫'],
      ['framework', '框架'],
      ['frameworks', '框架'],
      ['package', '套件'],
      ['packages', '套件'],
      ['dependency', '依賴'],
      ['dependencies', '依賴'],
      ['version', '版本'],
      ['versions', '版本'],
      ['update', '更新'],
      ['updates', '更新'],
      ['upgrade', '升級'],
      ['upgrades', '升級'],
      ['patch', '修補'],
      ['patches', '修補'],
      ['hotfix', '緊急修復'],
      ['hotfixes', '緊急修復'],
      ['bugfix', '錯誤修復'],
      ['bugfixes', '錯誤修復'],
      ['bug', '錯誤'],
      ['bugs', '錯誤'],
      ['issue', '問題'],
      ['issues', '問題'],
      ['error', '錯誤'],
      ['errors', '錯誤'],
      ['warning', '警告'],
      ['warnings', '警告'],
      ['exception', '例外'],
      ['exceptions', '例外'],
      ['crash', '當機'],
      ['crashes', '當機'],
      ['failure', '失敗'],
      ['failures', '失敗'],
      ['timeout', '逾時'],
      ['timeouts', '逾時']
    ]);

    // UI/UX 相關翻譯
    this.uiTerms = new Map([
      ['interface', '介面'],
      ['user interface', '使用者介面'],
      ['UI', 'UI'],
      ['UX', 'UX'],
      ['experience', '體驗'],
      ['button', '按鈕'],
      ['buttons', '按鈕'],
      ['menu', '選單'],
      ['menus', '選單'],
      ['dialog', '對話框'],
      ['dialogs', '對話框'],
      ['window', '視窗'],
      ['windows', '視窗'],
      ['tab', '分頁'],
      ['tabs', '分頁'],
      ['panel', '面板'],
      ['panels', '面板'],
      ['sidebar', '側邊欄'],
      ['toolbar', '工具列'],
      ['statusbar', '狀態列'],
      ['notification', '通知'],
      ['notifications', '通知'],
      ['alert', '警示'],
      ['alerts', '警示'],
      ['popup', '彈出視窗'],
      ['popups', '彈出視窗'],
      ['tooltip', '工具提示'],
      ['tooltips', '工具提示'],
      ['dropdown', '下拉選單'],
      ['dropdowns', '下拉選單'],
      ['checkbox', '核取方塊'],
      ['checkboxes', '核取方塊'],
      ['radio button', '選項按鈕'],
      ['input', '輸入'],
      ['inputs', '輸入'],
      ['output', '輸出'],
      ['outputs', '輸出'],
      ['display', '顯示'],
      ['view', '檢視'],
      ['views', '檢視'],
      ['preview', '預覽'],
      ['preview mode', '預覽模式']
    ]);

    // 程式設計相關翻譯
    this.programmingTerms = new Map([
      ['code', '程式碼'],
      ['coding', '程式設計'],
      ['development', '開發'],
      ['developer', '開發者'],
      ['developers', '開發者'],
      ['programming', '程式設計'],
      ['programmer', '程式設計師'],
      ['programmers', '程式設計師'],
      ['software', '軟體'],
      ['application', '應用程式'],
      ['applications', '應用程式'],
      ['app', '應用程式'],
      ['apps', '應用程式'],
      ['script', '腳本'],
      ['scripts', '腳本'],
      ['file', '檔案'],
      ['files', '檔案'],
      ['folder', '資料夾'],
      ['folders', '資料夾'],
      ['directory', '目錄'],
      ['directories', '目錄'],
      ['path', '路徑'],
      ['paths', '路徑'],
      ['project', '專案'],
      ['projects', '專案'],
      ['workspace', '工作空間'],
      ['workspaces', '工作空間'],
      ['repository', '儲存庫'],
      ['repositories', '儲存庫'],
      ['repo', '儲存庫'],
      ['repos', '儲存庫'],
      ['branch', '分支'],
      ['branches', '分支'],
      ['commit', '提交'],
      ['commits', '提交'],
      ['merge', '合併'],
      ['merges', '合併'],
      ['pull request', '拉取請求'],
      ['pull requests', '拉取請求'],
      ['PR', 'PR'],
      ['PRs', 'PR'],
      ['issue', '問題'],
      ['issues', '問題'],
      ['milestone', '里程碑'],
      ['milestones', '里程碑'],
      ['release', '發布'],
      ['releases', '發布'],
      ['tag', '標籤'],
      ['tags', '標籤'],
      ['version control', '版本控制'],
      ['source control', '原始碼控制']
    ]);

    // 系統相關翻譯
    this.systemTerms = new Map([
      ['system', '系統'],
      ['operating system', '作業系統'],
      ['OS', '作業系統'],
      ['platform', '平台'],
      ['platforms', '平台'],
      ['environment', '環境'],
      ['environments', '環境'],
      ['server', '伺服器'],
      ['servers', '伺服器'],
      ['client', '客戶端'],
      ['clients', '客戶端'],
      ['database', '資料庫'],
      ['databases', '資料庫'],
      ['network', '網路'],
      ['networks', '網路'],
      ['security', '安全性'],
      ['authentication', '認證'],
      ['authorization', '授權'],
      ['permission', '權限'],
      ['permissions', '權限'],
      ['access', '存取'],
      ['login', '登入'],
      ['logout', '登出'],
      ['password', '密碼'],
      ['passwords', '密碼'],
      ['token', '權杖'],
      ['tokens', '權杖'],
      ['key', '金鑰'],
      ['keys', '金鑰'],
      ['certificate', '憑證'],
      ['certificates', '憑證'],
      ['encryption', '加密'],
      ['decryption', '解密'],
      ['backup', '備份'],
      ['backups', '備份'],
      ['restore', '還原'],
      ['recovery', '復原'],
      ['sync', '同步'],
      ['synchronization', '同步']
    ]);

    // 狀態和結果相關翻譯
    this.statusTerms = new Map([
      ['success', '成功'],
      ['successful', '成功'],
      ['successfully', '成功地'],
      ['fail', '失敗'],
      ['failed', '失敗'],
      ['failure', '失敗'],
      ['error', '錯誤'],
      ['errors', '錯誤'],
      ['warning', '警告'],
      ['warnings', '警告'],
      ['info', '資訊'],
      ['information', '資訊'],
      ['debug', '除錯'],
      ['debugging', '除錯'],
      ['log', '日誌'],
      ['logs', '日誌'],
      ['logging', '記錄'],
      ['trace', '追蹤'],
      ['tracking', '追蹤'],
      ['monitor', '監控'],
      ['monitoring', '監控'],
      ['performance', '效能'],
      ['speed', '速度'],
      ['optimization', '最佳化'],
      ['efficiency', '效率'],
      ['stability', '穩定性'],
      ['reliability', '可靠性'],
      ['availability', '可用性'],
      ['scalability', '可擴展性'],
      ['maintainability', '可維護性'],
      ['usability', '可用性'],
      ['accessibility', '無障礙性'],
      ['compatibility', '相容性'],
      ['interoperability', '互操作性']
    ]);

    // 合併所有翻譯表
    this.allTranslations = new Map([
      ...this.coreTerms,
      ...this.actionTerms,
      ...this.featureTerms,
      ...this.uiTerms,
      ...this.programmingTerms,
      ...this.systemTerms,
      ...this.statusTerms
    ]);
  }

  setupPatterns() {
    // 保護程式碼塊的模式
    this.codeBlockPatterns = [
      /```[\s\S]*?```/g,           // 程式碼區塊
      /`[^`\n]+`/g,                // 行內程式碼
      /\$\w+/g,                    // 環境變數
      /-{1,2}[\w-]+/g,             // 指令選項
      /\/[\w\/.]+/g,               // 檔案路徑
      /https?:\/\/[\w\/.?=&-]+/g,  // URL
      /[\w.]+@[\w.]+/g,            // Email
      /\w+\(\)/g,                  // 函數呼叫
      /\w+\.\w+/g,                 // 物件屬性（謹慎使用）
      /[A-Z][A-Z_]+/g,             // 常數（全大寫）
      /v?\d+\.\d+\.\d+/g           // 版本號
    ];

    // 句型模式翻譯
    this.sentencePatterns = new Map([
      [/Add support for (.+)/gi, '新增 $1 支援'],
      [/Added support for (.+)/gi, '已新增 $1 支援'],
      [/Fix (.+) issue/gi, '修復 $1 問題'],
      [/Fixed (.+) issue/gi, '已修復 $1 問題'],
      [/Improve (.+) performance/gi, '改善 $1 效能'],
      [/Improved (.+) performance/gi, '已改善 $1 效能'],
      [/Update (.+) to (.+)/gi, '將 $1 更新為 $2'],
      [/Updated (.+) to (.+)/gi, '已將 $1 更新為 $2'],
      [/Enable (.+) by default/gi, '預設啟用 $1'],
      [/Enabled (.+) by default/gi, '已預設啟用 $1'],
      [/Remove (.+) from (.+)/gi, '從 $2 移除 $1'],
      [/Removed (.+) from (.+)/gi, '已從 $2 移除 $1'],
      [/New (.+) feature/gi, '新的 $1 功能'],
      [/Release (.+)/gi, '發布 $1'],
      [/Released (.+)/gi, '已發布 $1']
    ]);
  }

  /**
   * 保護程式碼和技術內容不被翻譯
   */
  protectCode(text) {
    const protectedContent = [];
    let protectedText = text;

    // 保護程式碼區塊
    this.codeBlockPatterns.forEach(pattern => {
      protectedText = protectedText.replace(pattern, (match) => {
        const index = protectedContent.length;
        protectedContent.push(match);
        return `__PROTECTED_${index}__`;
      });
    });

    return { protectedText, protectedContent };
  }

  /**
   * 還原保護的內容
   */
  restoreProtectedContent(text, protectedContent) {
    let restoredText = text;
    protectedContent.forEach((content, index) => {
      restoredText = restoredText.replace(`__PROTECTED_${index}__`, content);
    });
    return restoredText;
  }

  /**
   * 智能翻譯文字為繁體中文
   */
  translateText(text) {
    if (!text || typeof text !== 'string') return text;

    // 1. 保護程式碼和技術內容
    const { protectedText, protectedContent } = this.protectCode(text);
    
    let translated = protectedText;

    // 2. 應用句型模式翻譯
    for (const [pattern, replacement] of this.sentencePatterns) {
      translated = translated.replace(pattern, replacement);
    }

    // 3. 應用詞彙翻譯（按長度排序，長詞優先）
    const sortedTranslations = Array.from(this.allTranslations.entries())
      .sort((a, b) => b[0].length - a[0].length);

    for (const [english, chinese] of sortedTranslations) {
      // 使用單字邊界確保精確匹配
      const regex = new RegExp(`\\b${english.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'gi');
      translated = translated.replace(regex, chinese);
    }

    // 4. 後處理：調整常見的語法問題
    translated = this.postProcess(translated);

    // 5. 還原保護的內容
    return this.restoreProtectedContent(translated, protectedContent);
  }

  /**
   * 後處理翻譯結果
   */
  postProcess(text) {
    return text
      // 修正重複的動詞
      .replace(/已新增新增/g, '已新增')
      .replace(/已修復修復/g, '已修復')
      .replace(/已改善改善/g, '已改善')
      .replace(/已更新更新/g, '已更新')
      // 修正時態一致性
      .replace(/新增支援/g, '新增支援')
      .replace(/修復問題/g, '修復問題')
      // 修正標點符號前後的空格
      .replace(/\s+：/g, '：')
      .replace(/：\s+/g, '：')
      .replace(/\s+，/g, '，')
      .replace(/，\s+/g, '，')
      // 修正英文與中文之間的空格
      .replace(/([a-zA-Z0-9])\s*([一-龯])/g, '$1 $2')
      .replace(/([一-龯])\s*([a-zA-Z0-9])/g, '$1 $2');
  }

  /**
   * 翻譯 CHANGELOG 項目
   */
  translateChangelogItem(item) {
    if (!item || typeof item !== 'string') return item;

    // 移除前面的破折號和空格
    const cleanItem = item.replace(/^[-\s*]+/, '').trim();
    
    // 翻譯內容
    const translated = this.translateText(cleanItem);
    
    // 返回格式化的項目
    return `- ${translated}`;
  }

  /**
   * 批次翻譯 CHANGELOG 內容
   */
  translateChangelog(changelogText) {
    if (!changelogText) return changelogText;

    const lines = changelogText.split('\n');
    const translatedLines = lines.map(line => {
      // 檢查是否為版本標題
      if (line.match(/^#{1,6}\s*\d+\.\d+\.\d+/)) {
        return line; // 保持版本標題不變
      }
      
      // 檢查是否為清單項目
      if (line.match(/^[-*]\s+/)) {
        return this.translateChangelogItem(line);
      }
      
      // 檢查是否為其他內容
      if (line.trim()) {
        return this.translateText(line);
      }
      
      return line; // 保持空行不變
    });

    return translatedLines.join('\n');
  }

  /**
   * 新增自訂翻譯規則
   */
  addCustomTranslation(english, chinese) {
    this.allTranslations.set(english, chinese);
  }

  /**
   * 批次新增自訂翻譯規則
   */
  addCustomTranslations(translationMap) {
    for (const [english, chinese] of Object.entries(translationMap)) {
      this.addCustomTranslation(english, chinese);
    }
  }

  /**
   * 取得所有翻譯規則（用於除錯）
   */
  getAllTranslations() {
    return Object.fromEntries(this.allTranslations);
  }

  /**
   * 統計翻譯覆蓋率
   */
  getTranslationCoverage(text) {
    const { protectedText } = this.protectCode(text);
    const words = protectedText.match(/\b[a-zA-Z]+\b/g) || [];
    const uniqueWords = [...new Set(words.map(w => w.toLowerCase()))];
    
    const translatedWords = uniqueWords.filter(word => 
      this.allTranslations.has(word) || this.allTranslations.has(word.toLowerCase())
    );

    return {
      totalWords: uniqueWords.length,
      translatedWords: translatedWords.length,
      coverage: uniqueWords.length > 0 ? (translatedWords.length / uniqueWords.length * 100).toFixed(2) : 0,
      untranslatedWords: uniqueWords.filter(word => 
        !this.allTranslations.has(word) && !this.allTranslations.has(word.toLowerCase())
      )
    };
  }
}

// 如果作為模組使用
if (typeof module !== 'undefined' && module.exports) {
  module.exports = TraditionalChineseTranslator;
}

// 如果作為命令列工具使用
if (require.main === module) {
  const fs = require('fs');
  const path = require('path');

  const translator = new TraditionalChineseTranslator();
  
  // 簡單的命令列介面
  const args = process.argv.slice(2);
  
  if (args.length === 0) {
    console.log(`
使用方式:
  node zh-tw-translator.js <input-file> [output-file]
  node zh-tw-translator.js --translate "English text"
  node zh-tw-translator.js --coverage <input-file>

範例:
  node zh-tw-translator.js changelog.md changelog-zh-tw.md
  node zh-tw-translator.js --translate "Add support for new features"
  node zh-tw-translator.js --coverage input.txt
    `);
    process.exit(1);
  }

  if (args[0] === '--translate') {
    const text = args[1];
    if (!text) {
      console.error('請提供要翻譯的文字');
      process.exit(1);
    }
    console.log(translator.translateText(text));
  } else if (args[0] === '--coverage') {
    const inputFile = args[1];
    if (!inputFile || !fs.existsSync(inputFile)) {
      console.error('請提供有效的輸入檔案');
      process.exit(1);
    }
    const content = fs.readFileSync(inputFile, 'utf8');
    const coverage = translator.getTranslationCoverage(content);
    console.log('翻譯覆蓋率分析:');
    console.log(`總單字數: ${coverage.totalWords}`);
    console.log(`已翻譯單字: ${coverage.translatedWords}`);
    console.log(`覆蓋率: ${coverage.coverage}%`);
    if (coverage.untranslatedWords.length > 0) {
      console.log('未翻譯的單字:', coverage.untranslatedWords.slice(0, 20).join(', '));
    }
  } else {
    const inputFile = args[0];
    const outputFile = args[1] || inputFile.replace(/\.[^.]+$/, '-zh-tw$&');
    
    if (!fs.existsSync(inputFile)) {
      console.error(`檔案不存在: ${inputFile}`);
      process.exit(1);
    }
    
    const content = fs.readFileSync(inputFile, 'utf8');
    const translated = translator.translateChangelog(content);
    
    fs.writeFileSync(outputFile, translated, 'utf8');
    console.log(`翻譯完成: ${inputFile} -> ${outputFile}`);
    
    // 顯示翻譯統計
    const coverage = translator.getTranslationCoverage(content);
    console.log(`翻譯覆蓋率: ${coverage.coverage}%`);
  }
}
