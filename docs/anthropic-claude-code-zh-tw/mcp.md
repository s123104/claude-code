---
source: "https://docs.anthropic.com/zh-TW/docs/claude-code/mcp.md"
fetched_at: "2025-10-28T19:17:52+08:00"
---

# 透過 MCP 將 Claude Code 連接到工具

> 了解如何使用 Model Context Protocol 將 Claude Code 連接到您的工具。

export const MCPServersTable = ({platform = "all"}) => {
  const generateClaudeCodeCommand = server => {
    if (server.customCommands && server.customCommands.claudeCode) {
      return server.customCommands.claudeCode;
    }
    if (server.urls.http) {
      return `claude mcp add --transport http ${server.name.toLowerCase().replace(/[^a-z0-9]/g, '-')} ${server.urls.http}`;
    }
    if (server.urls.sse) {
      return `claude mcp add --transport sse ${server.name.toLowerCase().replace(/[^a-z0-9]/g, '-')} ${server.urls.sse}`;
    }
    if (server.urls.stdio) {
      const envFlags = server.authentication && server.authentication.envVars ? server.authentication.envVars.map(v => `--env ${v}=YOUR_${v.split('_').pop()}`).join(' ') : '';
      const baseCommand = `claude mcp add --transport stdio ${server.name.toLowerCase().replace(/[^a-z0-9]/g, '-')}`;
      return envFlags ? `${baseCommand} ${envFlags} -- ${server.urls.stdio}` : `${baseCommand} -- ${server.urls.stdio}`;
    }
    return null;
  };
  const servers = [{
    name: "Airtable",
    category: "Databases & Data Management",
    description: "Read/write records, manage bases and tables",
    documentation: "https://github.com/domdomegg/airtable-mcp-server",
    urls: {
      stdio: "npx -y airtable-mcp-server"
    },
    authentication: {
      type: "api_key",
      envVars: ["AIRTABLE_API_KEY"]
    },
    availability: {
      claudeCode: true,
      mcpConnector: false,
      claudeDesktop: true
    }
  }, {
    name: "Figma",
    category: "Design & Media",
    description: "Generate better code by bringing in full Figma context",
    documentation: "https://developers.figma.com",
    urls: {
      http: "https://mcp.figma.com/mcp"
    },
    customCommands: {
      claudeCode: "claude mcp add --transport http figma-remote-mcp https://mcp.figma.com/mcp"
    },
    availability: {
      claudeCode: true,
      mcpConnector: false,
      claudeDesktop: false
    },
    notes: "Visit developers.figma.com for local server setup."
  }, {
    name: "Asana",
    category: "Project Management & Documentation",
    description: "Interact with your Asana workspace to keep projects on track",
    documentation: "https://developers.asana.com/docs/using-asanas-model-control-protocol-mcp-server",
    urls: {
      sse: "https://mcp.asana.com/sse"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Atlassian",
    category: "Project Management & Documentation",
    description: "Manage your Jira tickets and Confluence docs",
    documentation: "https://www.atlassian.com/platform/remote-mcp-server",
    urls: {
      sse: "https://mcp.atlassian.com/v1/sse"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "ClickUp",
    category: "Project Management & Documentation",
    description: "Task management, project tracking",
    documentation: "https://github.com/hauptsacheNet/clickup-mcp",
    urls: {
      stdio: "npx -y @hauptsache.net/clickup-mcp"
    },
    authentication: {
      type: "api_key",
      envVars: ["CLICKUP_API_KEY", "CLICKUP_TEAM_ID"]
    },
    availability: {
      claudeCode: true,
      mcpConnector: false,
      claudeDesktop: true
    }
  }, {
    name: "Cloudflare",
    category: "Infrastructure & DevOps",
    description: "Build applications, analyze traffic, monitor performance, and manage security settings through Cloudflare",
    documentation: "https://developers.cloudflare.com/agents/model-context-protocol/mcp-servers-for-cloudflare/",
    urls: {},
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    },
    notes: "Multiple services available. See documentation for specific server URLs. Claude Code can use the Cloudflare CLI if installed."
  }, {
    name: "Cloudinary",
    category: "Design & Media",
    description: "Upload, manage, transform, and analyze your media assets",
    documentation: "https://cloudinary.com/documentation/cloudinary_llm_mcp#mcp_servers",
    urls: {},
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    },
    notes: "Multiple services available. See documentation for specific server URLs."
  }, {
    name: "Intercom",
    category: "Project Management & Documentation",
    description: "Access real-time customer conversations, tickets, and user data",
    documentation: "https://developers.intercom.com/docs/guides/mcp",
    urls: {
      http: "https://mcp.intercom.com/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "invideo",
    category: "Design & Media",
    description: "Build video creation capabilities into your applications",
    documentation: "https://invideo.io/ai/mcp",
    urls: {
      sse: "https://mcp.invideo.io/sse"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Linear",
    category: "Project Management & Documentation",
    description: "Integrate with Linear's issue tracking and project management",
    documentation: "https://linear.app/docs/mcp",
    urls: {
      http: "https://mcp.linear.app/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Notion",
    category: "Project Management & Documentation",
    description: "Read docs, update pages, manage tasks",
    documentation: "https://developers.notion.com/docs/mcp",
    urls: {
      http: "https://mcp.notion.com/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: false,
      claudeDesktop: false
    }
  }, {
    name: "PayPal",
    category: "Payments & Commerce",
    description: "Integrate PayPal commerce capabilities, payment processing, transaction management",
    documentation: "https://www.paypal.ai/",
    urls: {
      http: "https://mcp.paypal.com/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Plaid",
    category: "Payments & Commerce",
    description: "Analyze, troubleshoot, and optimize Plaid integrations. Banking data, financial account linking",
    documentation: "https://plaid.com/blog/plaid-mcp-ai-assistant-claude/",
    urls: {
      sse: "https://api.dashboard.plaid.com/mcp/sse"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Sentry",
    category: "Development & Testing Tools",
    description: "Monitor errors, debug production issues",
    documentation: "https://docs.sentry.io/product/sentry-mcp/",
    urls: {
      http: "https://mcp.sentry.dev/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: false,
      claudeDesktop: false
    }
  }, {
    name: "Square",
    category: "Payments & Commerce",
    description: "Use an agent to build on Square APIs. Payments, inventory, orders, and more",
    documentation: "https://developer.squareup.com/docs/mcp",
    urls: {
      sse: "https://mcp.squareup.com/sse"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Socket",
    category: "Development & Testing Tools",
    description: "Security analysis for dependencies",
    documentation: "https://github.com/SocketDev/socket-mcp",
    urls: {
      http: "https://mcp.socket.dev/"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: false,
      claudeDesktop: false
    }
  }, {
    name: "Stripe",
    category: "Payments & Commerce",
    description: "Payment processing, subscription management, and financial transactions",
    documentation: "https://docs.stripe.com/mcp",
    urls: {
      http: "https://mcp.stripe.com"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Workato",
    category: "Automation & Integration",
    description: "Access any application, workflows or data via Workato, made accessible for AI",
    documentation: "https://docs.workato.com/mcp.html",
    urls: {},
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    },
    notes: "MCP servers are programmatically generated"
  }, {
    name: "Zapier",
    category: "Automation & Integration",
    description: "Connect to nearly 8,000 apps through Zapier's automation platform",
    documentation: "https://help.zapier.com/hc/en-us/articles/36265392843917",
    urls: {},
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    },
    notes: "Generate a user-specific URL at mcp.zapier.com"
  }, {
    name: "Box",
    category: "Project Management & Documentation",
    description: "Ask questions about your enterprise content, get insights from unstructured data, automate content workflows",
    documentation: "https://box.dev/guides/box-mcp/remote/",
    urls: {
      http: "https://mcp.box.com/"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Canva",
    category: "Design & Media",
    description: "Browse, summarize, autofill, and even generate new Canva designs directly from Claude",
    documentation: "https://www.canva.dev/docs/connect/canva-mcp-server-setup/",
    urls: {
      http: "https://mcp.canva.com/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Daloopa",
    category: "Databases & Data Management",
    description: "Supplies high quality fundamental financial data sourced from SEC Filings, investor presentations",
    documentation: "https://docs.daloopa.com/docs/daloopa-mcp",
    urls: {
      http: "https://mcp.daloopa.com/server/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Fireflies",
    category: "Project Management & Documentation",
    description: "Extract valuable insights from meeting transcripts and summaries",
    documentation: "https://guide.fireflies.ai/articles/8272956938-learn-about-the-fireflies-mcp-server-model-context-protocol",
    urls: {
      http: "https://api.fireflies.ai/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "HubSpot",
    category: "Databases & Data Management",
    description: "Access and manage HubSpot CRM data by fetching contacts, companies, and deals, and creating and updating records",
    documentation: "https://developers.hubspot.com/mcp",
    urls: {
      http: "https://mcp.hubspot.com/anthropic"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Hugging Face",
    category: "Development & Testing Tools",
    description: "Provides access to Hugging Face Hub information and Gradio AI Applications",
    documentation: "https://huggingface.co/settings/mcp",
    urls: {
      http: "https://huggingface.co/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Jam",
    category: "Development & Testing Tools",
    description: "Debug faster with AI agents that can access Jam recordings like video, console logs, network requests, and errors",
    documentation: "https://jam.dev/docs/debug-a-jam/mcp",
    urls: {
      http: "https://mcp.jam.dev/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Monday",
    category: "Project Management & Documentation",
    description: "Manage monday.com boards by creating items, updating columns, assigning owners, setting timelines, adding CRM activities, and writing summaries",
    documentation: "https://developer.monday.com/apps/docs/mondaycom-mcp-integration",
    urls: {
      http: "https://mcp.monday.com/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Netlify",
    category: "Infrastructure & DevOps",
    description: "Create, deploy, and manage websites on Netlify. Control all aspects of your site from creating secrets to enforcing access controls to aggregating form submissions",
    documentation: "https://docs.netlify.com/build/build-with-ai/netlify-mcp-server/",
    urls: {
      http: "https://netlify-mcp.netlify.app/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Stytch",
    category: "Infrastructure & DevOps",
    description: "Configure and manage Stytch authentication services, redirect URLs, email templates, and workspace settings",
    documentation: "https://stytch.com/docs/workspace-management/stytch-mcp",
    urls: {
      http: "http://mcp.stytch.dev/mcp"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }, {
    name: "Vercel",
    category: "Infrastructure & DevOps",
    description: "Vercel's official MCP server, allowing you to search and navigate documentation, manage projects and deployments, and analyze deployment logs—all in one place",
    documentation: "https://vercel.com/docs/mcp/vercel-mcp",
    urls: {
      http: "https://mcp.vercel.com/"
    },
    authentication: {
      type: "oauth"
    },
    availability: {
      claudeCode: true,
      mcpConnector: true,
      claudeDesktop: false
    }
  }];
  const filteredServers = servers.filter(server => {
    if (platform === "claudeCode") {
      return server.availability.claudeCode;
    } else if (platform === "mcpConnector") {
      return server.availability.mcpConnector;
    } else if (platform === "claudeDesktop") {
      return server.availability.claudeDesktop;
    } else if (platform === "all") {
      return true;
    } else {
      throw new Error(`Unknown platform: ${platform}`);
    }
  });
  const serversByCategory = filteredServers.reduce((acc, server) => {
    if (!acc[server.category]) {
      acc[server.category] = [];
    }
    acc[server.category].push(server);
    return acc;
  }, {});
  const categoryOrder = ["Development & Testing Tools", "Project Management & Documentation", "Databases & Data Management", "Payments & Commerce", "Design & Media", "Infrastructure & DevOps", "Automation & Integration"];
  return <>
      <style jsx>{`
        .cards-container {
          display: grid;
          gap: 1rem;
          margin-bottom: 2rem;
        }
        .server-card {
          border: 1px solid var(--border-color, #e5e7eb);
          border-radius: 6px;
          padding: 1rem;
        }
        .command-row {
          display: flex;
          align-items: center;
          gap: 0.25rem;
        }
        .command-row code {
          font-size: 0.75rem;
          overflow-x: auto;
        }
      `}</style>
      
      {categoryOrder.map(category => {
    if (!serversByCategory[category]) return null;
    return <div key={category}>
            <h3>{category}</h3>
            <div className="cards-container">
              {serversByCategory[category].map(server => {
      const claudeCodeCommand = generateClaudeCodeCommand(server);
      const mcpUrl = server.urls.http || server.urls.sse;
      const commandToShow = platform === "claudeCode" ? claudeCodeCommand : mcpUrl;
      return <div key={server.name} className="server-card">
                    <div>
                      {server.documentation ? <a href={server.documentation}>
                          <strong>{server.name}</strong>
                        </a> : <strong>{server.name}</strong>}
                    </div>
                    
                    <p style={{
        margin: '0.5rem 0',
        fontSize: '0.9rem'
      }}>
                      {server.description}
                      {server.notes && <span style={{
        display: 'block',
        marginTop: '0.25rem',
        fontSize: '0.8rem',
        fontStyle: 'italic',
        opacity: 0.7
      }}>
                          {server.notes}
                        </span>}
                    </p>
                    
                    {commandToShow && <>
                      <p style={{
        display: 'block',
        fontSize: '0.75rem',
        fontWeight: 500,
        minWidth: 'fit-content',
        marginTop: '0.5rem',
        marginBottom: 0
      }}>
                        {platform === "claudeCode" ? "Command" : "URL"}
                      </p>
                      <div className="command-row">
                        <code>
                          {commandToShow}
                        </code>
                      </div>
                    </>}
                  </div>;
    })}
            </div>
          </div>;
  })}
    </>;
};

Claude Code 可以透過 [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) 連接到數百個外部工具和資料來源，MCP 是一個開源標準，用於 AI 工具整合。MCP 伺服器讓 Claude Code 能夠存取您的工具、資料庫和 API。

## 您可以使用 MCP 做什麼

連接 MCP 伺服器後，您可以要求 Claude Code：

* **從問題追蹤器實現功能**："新增 JIRA 問題 ENG-4521 中描述的功能，並在 GitHub 上建立 PR。"
* **分析監控資料**："檢查 Sentry 和 Statsig 以檢查 ENG-4521 中描述的功能使用情況。"
* **查詢資料庫**："根據我們的 Postgres 資料庫，找到 10 個使用功能 ENG-4521 的隨機使用者的電子郵件。"
* **整合設計**："根據在 Slack 中發佈的新 Figma 設計更新我們的標準電子郵件範本"
* **自動化工作流程**："建立 Gmail 草稿，邀請這 10 個使用者參加關於新功能的回饋會議。"

## 熱門 MCP 伺服器

以下是一些您可以連接到 Claude Code 的常用 MCP 伺服器：

<Warning>
  使用第三方 MCP 伺服器需自行承擔風險 - Anthropic 尚未驗證
  所有這些伺服器的正確性或安全性。
  請確保您信任要安裝的 MCP 伺服器。
  使用可能會取得不受信任內容的 MCP 伺服器時要特別小心，
  因為這些可能會讓您面臨提示注入風險。
</Warning>

<MCPServersTable platform="claudeCode" />

<Note>
  **需要特定的整合？** [在 GitHub 上找到數百個更多 MCP 伺服器](https://github.com/modelcontextprotocol/servers)，或使用 [MCP SDK](https://modelcontextprotocol.io/quickstart/server) 建立您自己的伺服器。
</Note>

## 安裝 MCP 伺服器

MCP 伺服器可以根據您的需求以三種不同的方式進行配置：

### 選項 1：新增遠端 HTTP 伺服器

HTTP 伺服器是連接到遠端 MCP 伺服器的建議選項。這是雲端服務最廣泛支援的傳輸方式。

```bash  theme={null}
# 基本語法
claude mcp add --transport http <name> <url>

# 實際範例：連接到 Notion
claude mcp add --transport http notion https://mcp.notion.com/mcp

# 使用 Bearer 令牌的範例
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

### 選項 2：新增遠端 SSE 伺服器

<Warning>
  SSE (Server-Sent Events) 傳輸已被棄用。請改用 HTTP 伺服器（如果可用）。
</Warning>

```bash  theme={null}
# 基本語法
claude mcp add --transport sse <name> <url>

# 實際範例：連接到 Asana
claude mcp add --transport sse asana https://mcp.asana.com/sse

# 使用驗證標頭的範例
claude mcp add --transport sse private-api https://api.company.com/sse \
  --header "X-API-Key: your-key-here"
```

### 選項 3：新增本機 stdio 伺服器

Stdio 伺服器在您的機器上作為本機程序執行。它們非常適合需要直接系統存取或自訂指令碼的工具。

```bash  theme={null}
# 基本語法
claude mcp add --transport stdio <name> <command> [args...]

# 實際範例：新增 Airtable 伺服器
claude mcp add --transport stdio airtable --env AIRTABLE_API_KEY=YOUR_KEY \
  -- npx -y airtable-mcp-server
```

<Note>
  **了解 "--" 參數：**
  `--`（雙破折號）將 Claude 自己的 CLI 旗標與傳遞給 MCP 伺服器的命令和引數分開。`--` 之前的所有內容都是 Claude 的選項（如 `--env`、`--scope`），`--` 之後的所有內容都是執行 MCP 伺服器的實際命令。

  例如：

  * `claude mcp add --transport stdio myserver -- npx server` → 執行 `npx server`
  * `claude mcp add --transport stdio myserver --env KEY=value -- python server.py --port 8080` → 執行 `python server.py --port 8080`，環境中設定 `KEY=value`

  這可以防止 Claude 的旗標與伺服器旗標之間的衝突。
</Note>

### 管理您的伺服器

配置後，您可以使用這些命令管理您的 MCP 伺服器：

```bash  theme={null}
# 列出所有已配置的伺服器
claude mcp list

# 取得特定伺服器的詳細資訊
claude mcp get github

# 移除伺服器
claude mcp remove github

# （在 Claude Code 中）檢查伺服器狀態
/mcp
```

<Tip>
  提示：

  * 使用 `--scope` 旗標指定配置的儲存位置：
    * `local`（預設）：僅在目前專案中對您可用（在較舊版本中稱為 `project`）
    * `project`：透過 `.mcp.json` 檔案與專案中的所有人共享
    * `user`：在所有專案中對您可用（在較舊版本中稱為 `global`）
  * 使用 `--env` 旗標設定環境變數（例如 `--env KEY=value`）
  * 使用 MCP\_TIMEOUT 環境變數配置 MCP 伺服器啟動逾時（例如 `MCP_TIMEOUT=10000 claude` 設定 10 秒逾時）
  * 當 MCP 工具輸出超過 10,000 個令牌時，Claude Code 將顯示警告。若要增加此限制，請設定 `MAX_MCP_OUTPUT_TOKENS` 環境變數（例如 `MAX_MCP_OUTPUT_TOKENS=50000`）
  * 使用 `/mcp` 向需要 OAuth 2.0 驗證的遠端伺服器進行驗證
</Tip>

<Warning>
  **Windows 使用者**：在原生 Windows（不是 WSL）上，使用 `npx` 的本機 MCP 伺服器需要 `cmd /c` 包裝器以確保正確執行。

  ```bash  theme={null}
  # 這會建立 Windows 可以執行的 command="cmd"
  claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
  ```

  沒有 `cmd /c` 包裝器，您會遇到「連接已關閉」錯誤，因為 Windows 無法直接執行 `npx`。（請參閱上面的注意以了解 `--` 參數的說明。）
</Warning>

### 外掛程式提供的 MCP 伺服器

[外掛程式](/zh-TW/docs/claude-code/plugins) 可以捆綁 MCP 伺服器，在啟用外掛程式時自動提供工具和整合。外掛程式 MCP 伺服器的工作方式與使用者配置的伺服器相同。

**外掛程式 MCP 伺服器的工作方式**：

* 外掛程式在外掛程式根目錄的 `.mcp.json` 中或 `plugin.json` 中內聯定義 MCP 伺服器
* 啟用外掛程式時，其 MCP 伺服器會自動啟動
* 外掛程式 MCP 工具與手動配置的 MCP 工具一起出現
* 外掛程式伺服器透過外掛程式安裝進行管理（不是 `/mcp` 命令）

**外掛程式 MCP 配置範例**：

在外掛程式根目錄的 `.mcp.json` 中：

```json  theme={null}
{
  "database-tools": {
    "command": "${CLAUDE_PLUGIN_ROOT}/servers/db-server",
    "args": ["--config", "${CLAUDE_PLUGIN_ROOT}/config.json"],
    "env": {
      "DB_URL": "${DB_URL}"
    }
  }
}
```

或在 `plugin.json` 中內聯：

```json  theme={null}
{
  "name": "my-plugin",
  "mcpServers": {
    "plugin-api": {
      "command": "${CLAUDE_PLUGIN_ROOT}/servers/api-server",
      "args": ["--port", "8080"]
    }
  }
}
```

**外掛程式 MCP 功能**：

* **自動生命週期**：伺服器在外掛程式啟用時啟動，但您必須重新啟動 Claude Code 以套用 MCP 伺服器變更（啟用或停用）
* **環境變數**：使用 `${CLAUDE_PLUGIN_ROOT}` 表示外掛程式相對路徑
* **使用者環境存取**：存取與手動配置伺服器相同的環境變數
* **多種傳輸類型**：支援 stdio、SSE 和 HTTP 傳輸（傳輸支援可能因伺服器而異）

**檢視外掛程式 MCP 伺服器**：

```bash  theme={null}
# 在 Claude Code 中，查看所有 MCP 伺服器，包括外掛程式伺服器
/mcp
```

外掛程式伺服器在列表中出現，並帶有指示器顯示它們來自外掛程式。

**外掛程式 MCP 伺服器的優點**：

* **捆綁分發**：工具和伺服器一起打包
* **自動設定**：無需手動 MCP 配置
* **團隊一致性**：安裝外掛程式時，每個人都會獲得相同的工具

請參閱[外掛程式元件參考](/zh-TW/docs/claude-code/plugins-reference#mcp-servers)以了解有關使用外掛程式捆綁 MCP 伺服器的詳細資訊。

## MCP 安裝範圍

MCP 伺服器可以在三個不同的範圍級別進行配置，每個級別都服務於管理伺服器可存取性和共享的不同目的。了解這些範圍可以幫助您確定為特定需求配置伺服器的最佳方式。

### 本機範圍

本機範圍伺服器代表預設配置級別，儲存在您的專案特定使用者設定中。這些伺服器對您保持私密，只有在目前專案目錄中工作時才可存取。此範圍非常適合個人開發伺服器、實驗配置或包含不應共享的敏感認證的伺服器。

```bash  theme={null}
# 新增本機範圍伺服器（預設）
claude mcp add --transport http stripe https://mcp.stripe.com

# 明確指定本機範圍
claude mcp add --transport http stripe --scope local https://mcp.stripe.com
```

### 專案範圍

專案範圍伺服器透過將配置儲存在專案根目錄的 `.mcp.json` 檔案中來啟用團隊協作。此檔案設計為簽入版本控制，確保所有團隊成員都能存取相同的 MCP 工具和服務。新增專案範圍伺服器時，Claude Code 會自動建立或更新此檔案，使用適當的配置結構。

```bash  theme={null}
# 新增專案範圍伺服器
claude mcp add --transport http paypal --scope project https://mcp.paypal.com/mcp
```

產生的 `.mcp.json` 檔案遵循標準化格式：

```json  theme={null}
{
  "mcpServers": {
    "shared-server": {
      "command": "/path/to/server",
      "args": [],
      "env": {}
    }
  }
}
```

出於安全原因，Claude Code 在使用來自 `.mcp.json` 檔案的專案範圍伺服器之前會提示批准。如果您需要重設這些批准選擇，請使用 `claude mcp reset-project-choices` 命令。

### 使用者範圍

使用者範圍伺服器提供跨專案可存取性，使其在您的機器上的所有專案中可用，同時對您的使用者帳戶保持私密。此範圍非常適合個人實用程式伺服器、開發工具或您在不同專案中經常使用的服務。

```bash  theme={null}
# 新增使用者伺服器
claude mcp add --transport http hubspot --scope user https://mcp.hubspot.com/anthropic
```

### 選擇正確的範圍

根據以下條件選擇您的範圍：

* **本機範圍**：個人伺服器、實驗配置或特定於一個專案的敏感認證
* **專案範圍**：團隊共享伺服器、專案特定工具或協作所需的服務
* **使用者範圍**：跨多個專案所需的個人實用程式、開發工具或經常使用的服務

### 範圍階層和優先順序

MCP 伺服器配置遵循清晰的優先順序階層。當具有相同名稱的伺服器存在於多個範圍時，系統透過優先考慮本機範圍伺服器、其次是專案範圍伺服器，最後是使用者範圍伺服器來解決衝突。此設計確保個人配置可以在需要時覆蓋共享配置。

### `.mcp.json` 中的環境變數擴展

Claude Code 支援 `.mcp.json` 檔案中的環境變數擴展，允許團隊共享配置，同時保持機器特定路徑和 API 金鑰等敏感值的靈活性。

**支援的語法：**

* `${VAR}` - 擴展為環境變數 `VAR` 的值
* `${VAR:-default}` - 如果設定，擴展為 `VAR`，否則使用 `default`

**擴展位置：**
環境變數可以在以下位置擴展：

* `command` - 伺服器可執行檔路徑
* `args` - 命令列引數
* `env` - 傳遞給伺服器的環境變數
* `url` - 對於 HTTP 伺服器類型
* `headers` - 對於 HTTP 伺服器驗證

**使用變數擴展的範例：**

```json  theme={null}
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

如果未設定必需的環境變數且沒有預設值，Claude Code 將無法解析配置。

## 實際範例

{/* ### 範例：使用 Playwright 自動化瀏覽器測試

  ```bash
  # 1. 新增 Playwright MCP 伺服器
  claude mcp add --transport stdio playwright -- npx -y @playwright/mcp@latest

  # 2. 編寫並執行瀏覽器測試
  > "Test if the login flow works with test@example.com"
  > "Take a screenshot of the checkout page on mobile"
  > "Verify that the search feature returns results"
  ``` */}

### 範例：使用 Sentry 監控錯誤

```bash  theme={null}
# 1. 新增 Sentry MCP 伺服器
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

# 2. 使用 /mcp 向您的 Sentry 帳戶進行驗證
> /mcp

# 3. 除錯生產問題
> "過去 24 小時內最常見的錯誤是什麼？"
> "顯示錯誤 ID abc123 的堆疊追蹤"
> "哪個部署引入了這些新錯誤？"
```

### 範例：連接到 GitHub 進行程式碼審查

```bash  theme={null}
# 1. 新增 GitHub MCP 伺服器
claude mcp add --transport http github https://api.githubcopilot.com/mcp/

# 2. 在 Claude Code 中，如果需要進行驗證
> /mcp
# 為 GitHub 選擇「驗證」

# 3. 現在您可以要求 Claude 使用 GitHub
> "審查 PR #456 並建議改進"
> "為我們剛發現的錯誤建立新問題"
> "顯示所有分配給我的開放 PR"
```

### 範例：查詢您的 PostgreSQL 資料庫

```bash  theme={null}
# 1. 使用您的連接字串新增資料庫伺服器
claude mcp add --transport stdio db -- npx -y @bytebase/dbhub \
  --dsn "postgresql://readonly:pass@prod.db.com:5432/analytics"

# 2. 自然地查詢您的資料庫
> "本月我們的總收入是多少？"
> "顯示訂單表的架構"
> "找到 90 天內未進行購買的客戶"
```

## 向遠端 MCP 伺服器進行驗證

許多雲端 MCP 伺服器需要驗證。Claude Code 支援 OAuth 2.0 以進行安全連接。

<Steps>
  <Step title="新增需要驗證的伺服器">
    例如：

    ```bash  theme={null}
    claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
    ```
  </Step>

  <Step title="在 Claude Code 中使用 /mcp 命令">
    在 Claude Code 中，使用命令：

    ```
    > /mcp
    ```

    然後按照瀏覽器中的步驟登入。
  </Step>
</Steps>

<Tip>
  提示：

  * 驗證令牌安全儲存並自動重新整理
  * 在 `/mcp` 功能表中使用「清除驗證」撤銷存取
  * 如果您的瀏覽器未自動開啟，請複製提供的 URL
  * OAuth 驗證適用於 HTTP 伺服器
</Tip>

## 從 JSON 配置新增 MCP 伺服器

如果您有 MCP 伺服器的 JSON 配置，您可以直接新增它：

<Steps>
  <Step title="從 JSON 新增 MCP 伺服器">
    ```bash  theme={null}
    # 基本語法
    claude mcp add-json <name> '<json>'

    # 範例：使用 JSON 配置新增 HTTP 伺服器
    claude mcp add-json weather-api '{"type":"http","url":"https://api.weather.com/mcp","headers":{"Authorization":"Bearer token"}}'

    # 範例：使用 JSON 配置新增 stdio 伺服器
    claude mcp add-json local-weather '{"type":"stdio","command":"/path/to/weather-cli","args":["--api-key","abc123"],"env":{"CACHE_DIR":"/tmp"}}'
    ```
  </Step>

  <Step title="驗證伺服器已新增">
    ```bash  theme={null}
    claude mcp get weather-api
    ```
  </Step>
</Steps>

<Tip>
  提示：

  * 確保 JSON 在您的 shell 中正確轉義
  * JSON 必須符合 MCP 伺服器配置架構
  * 您可以使用 `--scope user` 將伺服器新增到您的使用者配置，而不是專案特定配置
</Tip>

## 從 Claude Desktop 匯入 MCP 伺服器

如果您已在 Claude Desktop 中配置了 MCP 伺服器，您可以匯入它們：

<Steps>
  <Step title="從 Claude Desktop 匯入伺服器">
    ```bash  theme={null}
    # 基本語法 
    claude mcp add-from-claude-desktop 
    ```
  </Step>

  <Step title="選擇要匯入的伺服器">
    執行命令後，您將看到一個互動式對話框，允許您選擇要匯入的伺服器。
  </Step>

  <Step title="驗證伺服器已匯入">
    ```bash  theme={null}
    claude mcp list 
    ```
  </Step>
</Steps>

<Tip>
  提示：

  * 此功能僅適用於 macOS 和 Windows Subsystem for Linux (WSL)
  * 它從這些平台上的標準位置讀取 Claude Desktop 配置檔案
  * 使用 `--scope user` 旗標將伺服器新增到您的使用者配置
  * 匯入的伺服器將具有與 Claude Desktop 中相同的名稱
  * 如果已存在具有相同名稱的伺服器，它們將獲得數字尾碼（例如 `server_1`）
</Tip>

## 使用 Claude Code 作為 MCP 伺服器

您可以使用 Claude Code 本身作為其他應用程式可以連接到的 MCP 伺服器：

```bash  theme={null}
# 啟動 Claude 作為 stdio MCP 伺服器
claude mcp serve
```

您可以透過將此配置新增到 claude\_desktop\_config.json 在 Claude Desktop 中使用它：

```json  theme={null}
{
  "mcpServers": {
    "claude-code": {
      "type": "stdio",
      "command": "claude",
      "args": ["mcp", "serve"],
      "env": {}
    }
  }
}
```

<Tip>
  提示：

  * 伺服器提供對 Claude 工具（如 View、Edit、LS 等）的存取
  * 在 Claude Desktop 中，嘗試要求 Claude 讀取目錄中的檔案、進行編輯等。
  * 請注意，此 MCP 伺服器只是將 Claude Code 的工具公開給您的 MCP 用戶端，因此您自己的用戶端負責為個別工具呼叫實現使用者確認。
</Tip>

## MCP 輸出限制和警告

當 MCP 工具產生大型輸出時，Claude Code 可幫助管理令牌使用，以防止淹沒您的對話內容：

* **輸出警告閾值**：當任何 MCP 工具輸出超過 10,000 個令牌時，Claude Code 會顯示警告
* **可配置限制**：您可以使用 `MAX_MCP_OUTPUT_TOKENS` 環境變數調整最大允許 MCP 輸出令牌
* **預設限制**：預設最大值為 25,000 個令牌

若要增加產生大型輸出的工具的限制：

```bash  theme={null}
# 為 MCP 工具輸出設定更高的限制
export MAX_MCP_OUTPUT_TOKENS=50000
claude
```

這在使用以下 MCP 伺服器時特別有用：

* 查詢大型資料集或資料庫
* 產生詳細報告或文件
* 處理廣泛的日誌檔案或除錯資訊

<Warning>
  如果您經常遇到特定 MCP 伺服器的輸出警告，請考慮增加限制或配置伺服器以分頁或篩選其回應。
</Warning>

## 使用 MCP 資源

MCP 伺服器可以公開資源，您可以使用 @ 提及來參考，類似於您參考檔案的方式。

### 參考 MCP 資源

<Steps>
  <Step title="列出可用資源">
    在您的提示中輸入 `@` 以查看來自所有連接 MCP 伺服器的可用資源。資源與檔案一起出現在自動完成功能表中。
  </Step>

  <Step title="參考特定資源">
    使用格式 `@server:protocol://resource/path` 來參考資源：

    ```
    > 您能分析 @github:issue://123 並建議修復嗎？
    ```

    ```
    > 請審查 @docs:file://api/authentication 上的 API 文件
    ```
  </Step>

  <Step title="多個資源參考">
    您可以在單個提示中參考多個資源：

    ```
    > 比較 @postgres:schema://users 與 @docs:file://database/user-model
    ```
  </Step>
</Steps>

<Tip>
  提示：

  * 參考時會自動擷取資源並作為附件包含
  * 資源路徑在 @ 提及自動完成中可進行模糊搜尋
  * Claude Code 在伺服器支援時自動提供列出和讀取 MCP 資源的工具
  * 資源可以包含 MCP 伺服器提供的任何類型的內容（文字、JSON、結構化資料等）
</Tip>

## 使用 MCP 提示作為斜線命令

MCP 伺服器可以公開提示，這些提示在 Claude Code 中作為斜線命令可用。

### 執行 MCP 提示

<Steps>
  <Step title="發現可用提示">
    輸入 `/` 以查看所有可用命令，包括來自 MCP 伺服器的命令。MCP 提示以 `/mcp__servername__promptname` 格式出現。
  </Step>

  <Step title="執行不帶引數的提示">
    ```
    > /mcp__github__list_prs
    ```
  </Step>

  <Step title="執行帶引數的提示">
    許多提示接受引數。在命令後以空格分隔的方式傳遞它們：

    ```
    > /mcp__github__pr_review 456
    ```

    ```
    > /mcp__jira__create_issue "登入流程中的錯誤" high
    ```
  </Step>
</Steps>

<Tip>
  提示：

  * MCP 提示從連接的伺服器動態發現
  * 引數根據提示的定義參數進行解析
  * 提示結果直接注入到對話中
  * 伺服器和提示名稱已標準化（空格變為底線）
</Tip>

## 企業 MCP 配置

對於需要集中控制 MCP 伺服器的組織，Claude Code 支援企業管理的 MCP 配置。這允許 IT 管理員：

* **控制員工可以存取哪些 MCP 伺服器**：在整個組織中部署一組標準化的已批准 MCP 伺服器
* **防止未授權的 MCP 伺服器**：可選地限制使用者新增自己的 MCP 伺服器
* **完全停用 MCP**：如果需要，完全移除 MCP 功能

### 設定企業 MCP 配置

系統管理員可以在管理設定檔案旁邊部署企業 MCP 配置檔案：

* **macOS**：`/Library/Application Support/ClaudeCode/managed-mcp.json`
* **Windows**：`C:\ProgramData\ClaudeCode\managed-mcp.json`
* **Linux**：`/etc/claude-code/managed-mcp.json`

`managed-mcp.json` 檔案使用與標準 `.mcp.json` 檔案相同的格式：

```json  theme={null}
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/"
    },
    "sentry": {
      "type": "http",
      "url": "https://mcp.sentry.dev/mcp"
    },
    "company-internal": {
      "type": "stdio",
      "command": "/usr/local/bin/company-mcp-server",
      "args": ["--config", "/etc/company/mcp-config.json"],
      "env": {
        "COMPANY_API_URL": "https://internal.company.com"
      }
    }
  }
}
```

### 使用允許清單和拒絕清單限制 MCP 伺服器

除了提供企業管理的伺服器外，管理員還可以使用 `managed-settings.json` 檔案中的 `allowedMcpServers` 和 `deniedMcpServers` 控制使用者允許配置哪些 MCP 伺服器：

* **macOS**：`/Library/Application Support/ClaudeCode/managed-settings.json`
* **Windows**：`C:\ProgramData\ClaudeCode\managed-settings.json`
* **Linux**：`/etc/claude-code/managed-settings.json`

```json  theme={null}
{
  "allowedMcpServers": [
    { "serverName": "github" },
    { "serverName": "sentry" },
    { "serverName": "company-internal" }
  ],
  "deniedMcpServers": [
    { "serverName": "filesystem" }
  ]
}
```

**允許清單行為 (`allowedMcpServers`)**：

* `undefined`（預設）：無限制 - 使用者可以配置任何 MCP 伺服器
* 空陣列 `[]`：完全鎖定 - 使用者無法配置任何 MCP 伺服器
* 伺服器名稱清單：使用者只能配置指定的伺服器

**拒絕清單行為 (`deniedMcpServers`)**：

* `undefined`（預設）：沒有伺服器被阻止
* 空陣列 `[]`：沒有伺服器被阻止
* 伺服器名稱清單：指定的伺服器在所有範圍內被明確阻止

**重要注意事項**：

* 這些限制適用於所有範圍：使用者、專案、本機，甚至來自 `managed-mcp.json` 的企業伺服器
* **拒絕清單具有絕對優先順序**：如果伺服器同時出現在兩個清單中，它將被阻止

<Note>
  **企業配置優先順序**：企業 MCP 配置具有最高優先順序，當啟用 `useEnterpriseMcpConfigOnly` 時無法被使用者、本機或專案配置覆蓋。
</Note>

