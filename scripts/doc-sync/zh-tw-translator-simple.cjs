#!/usr/bin/env node

/**
 * Claude Code 簡化強化繁體中文翻譯器
 * 
 * 針對 CHANGELOG 內容特別優化
 * 避免複雜的保護機制，專注於正確的詞彙翻譯
 */

class SimpleTraditionalChineseTranslator {
  constructor() {
    this.initializeTranslations();
  }

  initializeTranslations() {
    // 完整的技術術語翻譯表
    this.translations = new Map([
      // 核心動作詞彙
      ['Fixed', '已修復'],
      ['fixed', '已修復'],
      ['Added', '已新增'],
      ['added', '已新增'],
      ['Improved', '已改善'],
      ['improved', '已改善'],
      ['Enhanced', '已增強'],
      ['enhanced', '已增強'],
      ['Upgraded', '已升級'],
      ['upgraded', '已升級'],
      ['Updated', '已更新'],
      ['updated', '已更新'],
      ['Enabled', '已啟用'],
      ['enabled', '已啟用'],
      ['Disabled', '已停用'],
      ['disabled', '已停用'],
      ['Support', '支援'],
      ['support', '支援'],
      ['New', '新的'],
      ['new', '新的'],
      ['Released', '已發布'],
      ['released', '已發布'],
      ['Removed', '已移除'],
      ['removed', '已移除'],
      ['Changed', '已變更'],
      ['changed', '已變更'],
      
      // 技術術語
      ['status line', '狀態列'],
      ['Status line', '狀態列'],
      ['input', '輸入'],
      ['output', '輸出'],
      ['includes', '包含'],
      ['session', '會話'],
      ['cost', '成本'],
      ['info', '資訊'],
      ['information', '資訊'],
      ['error', '錯誤'],
      ['errors', '錯誤'],
      ['issue', '問題'],
      ['issues', '問題'],
      ['crash', '當機'],
      ['when', '當'],
      ['network', '網路'],
      ['unstable', '不穩定'],
      ['sometimes', '有時候'],
      ['ignoring', '忽略'],
      ['real-time', '即時'],
      ['steering', '引導'],
      ['wrapping up', '完成'],
      ['task', '任務'],
      ['mention', '提及'],
      ['files', '檔案'],
      ['file', '檔案'],
      ['suggestions', '建議'],
      ['easier', '更容易'],
      ['agent', '代理'],
      ['agents', '代理'],
      ['style', '樣式'],
      ['styles', '樣式'],
      ['slash', '斜線'],
      ['command', '指令'],
      ['commands', '指令'],
      ['editing', '編輯'],
      ['built-in', '內建'],
      ['default', '預設'],
      ['opt out', '退出'],
      ['behavior', '行為'],
      ['spaces', '空格'],
      ['path', '路徑'],
      ['paths', '路徑'],
      ['spinner', '載入圖示'],
      ['request', '請求'],
      ['cancellation', '取消'],
      ['option', '選項'],
      ['options', '選項'],
      ['search', '搜尋'],
      ['custom', '自訂'],
      ['processing', '處理'],
      ['settings', '設定'],
      ['validation', '驗證'],
      ['prevents', '防止'],
      ['invalid', '無效'],
      ['fields', '欄位'],
      ['consistency', '一致性'],
      ['tries', '嘗試'],
      ['automatically', '自動'],
      ['read', '讀取'],
      ['large', '大型'],
      ['including', '包括'],
      ['educational', '教育'],
      ['docs', '文檔'],
      ['loading', '載入'],
      ['unparsable', '無法解析'],
      ['permissions', '權限'],
      ['confirmation', '確認'],
      ['specific', '特定'],
      ['tools', '工具'],
      ['tool', '工具'],
      ['background', '背景'],
      ['run', '執行'],
      ['any', '任何'],
      ['keep', '保持'],
      ['working', '工作'],
      ['great', '很好'],
      ['dev', '開發'],
      ['servers', '伺服器'],
      ['server', '伺服器'],
      ['tailing', '追蹤'],
      ['logs', '日誌'],
      ['log', '日誌'],
      ['customizable', '可自訂'],
      ['terminal', '終端機'],
      ['prompt', '提示'],
      ['performance', '效能'],
      ['optimized', '最佳化'],
      ['message', '訊息'],
      ['rendering', '渲染'],
      ['better', '更好'],
      ['large', '大型'],
      ['contexts', '上下文'],
      ['context', '上下文'],
      ['native', '原生'],
      ['functionality', '功能'],
      ['arguments', '引數'],
      ['upgrade', '升級'],
      ['version', '版本'],
      ['incorrect', '不正確'],
      ['names', '名稱'],
      ['being used', '被使用'],
      ['certain', '特定'],
      ['like', '如'],
      ['improve', '改善'],
      ['checks', '檢查'],
      ['allow', '允許'],
      ['deny', '拒絕'],
      ['project', '專案'],
      ['trust', '信任'],
      ['may', '可能'],
      ['create', '建立'],
      ['entry', '項目'],
      ['manually', '手動'],
      ['merge', '合併'],
      ['history', '歷史'],
      ['field', '欄位'],
      ['desired', '期望'],
      ['spawning', '生成'],
      ['eliminate', '消除'],
      ['such', '這樣'],
      ['directory', '目錄'],
      ['executing', '執行'],
      ['context', '上下文'],
      ['self-serve', '自助'],
      ['debugging', '除錯'],
      ['callback', '回調'],
      ['setting', '設定'],
      ['connection', '連線'],
      ['stability', '穩定性'],
      ['handling', '處理'],
      ['diagnostics', '診斷'],
      ['shell', '殼層'],
      ['environment', '環境'],
      ['users', '使用者'],
      ['without', '沒有'],
      ['model', '模型'],
      ['customization', '自訂'],
      ['specify', '指定'],
      ['which', '哪個'],
      ['should', '應該'],
      ['use', '使用'],
      ['unintended', '意外'],
      ['access', '存取'],
      ['recursive', '遞迴'],
      ['hooks', 'hooks'],
      ['displaying', '顯示'],
      ['warnings', '警告'],
      ['tracking', '追蹤'],
      ['across', '跨越'],
      ['multi-turn', '多輪'],
      ['conversations', '對話'],
      ['hidden', '隱藏'],
      ['typeahead', '預輸入'],
      ['invoke', '調用'],
      ['hook', 'hook'],
      ['initialization', '初始化'],
      ['supports', '支援'],
      ['directory', '目錄'],
      ['reliability', '可靠性'],
      ['transcript', '文字記錄'],
      ['mode', '模式'],
      ['exit', '退出'],
      ['rather', '而非'],
      ['than', '比'],
      ['interrupt', '中斷'],
      ['load', '載入'],
      ['resolution', '解析'],
      ['symlinks', '符號連結'],
      ['reporting', '報告'],
      ['wrong', '錯誤'],
      ['organization', '組織'],
      ['after', '之後'],
      ['authentication', '認證'],
      ['changes', '變更'],
      ['checking', '檢查'],
      ['allowed-tools', '允許工具'],
      ['pasting', '貼上'],
      ['images', '圖片'],
      ['using', '使用'],
      ['disabling', '停用'],
      ['auto-connection', '自動連線'],
      ['wrapping', '包裝'],
      ['user-provided', '使用者提供'],
      ['spawned', '生成'],
      ['process', '程序'],
      ['confirmation', '確認'],
      ['allow', '允許'],
      ['specifying', '指定'],
      ['env', '環境'],
      ['exposed', '暴露'],
      ['decision', '決定'],
      ['supports', '支援'],
      ['additional', '額外'],
      ['context', '上下文'],
      ['advanced', '進階'],
      ['max', '最大'],
      ['specified', '指定'],
      ['would', '會'],
      ['still', '仍然'],
      ['see', '看到'],
      ['fallback', '回退'],
      ['reading', '讀取'],
      ['pdfs', 'PDF'],
      ['health', '健康'],
      ['status', '狀態'],
      ['display', '顯示'],
      ['list', '列表'],
      ['var', '變數'],
      ['permission', '權限'],
      ['messages', '訊息'],
      ['help', '幫助'],
      ['understand', '理解'],
      ['allowed', '允許'],
      ['remove', '移除'],
      ['trailing', '尾隨'],
      ['newlines', '換行'],
      ['bash', 'Bash'],
      ['wrapping', '包裝'],
      ['shift+tab', 'shift+tab'],
      ['switching', '切換'],
      ['versions', '版本'],
      ['that', '那'],
      ['wsl', 'WSL'],
      ['detection', '檢測'],
      ['causing', '導致'],
      ['awsrefreshhelper', 'awsRefreshHelper'],
      ['picked', '拾取'],
      ['up', '起來'],
      ['clarified', '澄清'],
      ['knowledge', '知識'],
      ['cutoff', '截止'],
      ['models', '模型'],
      ['ctrl+z', 'Ctrl+Z'],
      ['ability', '能力'],
      ['capture', '捕獲'],
      ['logging', '記錄'],
      ['system-prompt-file', 'system-prompt-file'],
      ['override', '覆蓋'],
      ['system', '系統'],
      ['print', '列印'],
      ['current', '目前'],
      ['inputs', '輸入'],
      ['parameter-hint', 'parameter-hint'],
      ['frontmatter', '前言'],
      ['oauth', 'OAuth'],
      ['uses', '使用'],
      ['port', '連接埠'],
      ['properly', '正確'],
      ['constructs', '構建'],
      ['browser', '瀏覽器'],
      ['url', 'URL'],
      ['alt', 'alt'],
      ['plan', '計劃'],
      ['renders', '渲染'],
      ['switch', '切換'],
      ['in-memory', '記憶體內'],
      ['snapshot', '快照'],
      ['file-related', '檔案相關'],
      
      // 補充常見詞彙
      ['now', '現在'],
      ['with', '與'],
      ['the', ''],  // 通常不需要翻譯
      ['and', '和'],
      ['or', '或'],
      ['for', '為'],
      ['to', '到'],
      ['in', '在'],
      ['on', '於'],
      ['at', '在'],
      ['by', '透過'],
      ['from', '從'],
      ['this', '這個'],
      ['that', '那個'],
      ['when', '當'],
      ['where', '哪裡'],
      ['how', '如何'],
      ['what', '什麼'],
      ['which', '哪個'],
      ['who', '誰'],
      ['why', '為什麼'],
      ['is', '是'],
      ['are', '是'],
      ['was', '是'],
      ['were', '是'],
      ['be', '是'],
      ['been', '已'],
      ['being', '正在'],
      ['have', '有'],
      ['has', '有'],
      ['had', '有'],
      ['will', '將'],
      ['would', '會'],
      ['can', '可以'],
      ['could', '可以'],
      ['should', '應該'],
      ['must', '必須'],
      ['may', '可能'],
      ['might', '可能']
    ]);
  }

  /**
   * 翻譯文字為繁體中文
   */
  translateText(text) {
    if (!text || typeof text !== 'string') return text;

    let translated = text;

    // 按長度排序，長詞優先
    const sortedTranslations = Array.from(this.translations.entries())
      .sort((a, b) => b[0].length - a[0].length);

    for (const [english, chinese] of sortedTranslations) {
      // 使用全局替換，但要保持大小寫敏感性
      const regex = new RegExp(`\\b${english.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'g');
      translated = translated.replace(regex, chinese);
    }

    return translated.trim();
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
    this.translations.set(english, chinese);
  }
}

// 導出模組
module.exports = SimpleTraditionalChineseTranslator;

// 如果作為命令列工具使用
if (require.main === module) {
  const fs = require('fs');
  const translator = new SimpleTraditionalChineseTranslator();
  
  const args = process.argv.slice(2);
  
  if (args.length === 0) {
    console.log(`
使用方式:
  node zh-tw-translator-simple.cjs --translate "English text"
  node zh-tw-translator-simple.cjs <input-file> [output-file]

範例:
  node zh-tw-translator-simple.cjs --translate "Added support for new features"
  node zh-tw-translator-simple.cjs changelog.md changelog-zh-tw.md
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
  }
}
