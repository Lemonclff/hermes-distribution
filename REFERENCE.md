# Hermes Agent Configuration Reference
# ============ 配置參數完整說明 =============

## 📋 核心配置塊

### model (模型設定)

```yaml
model:
  default: <模型名稱，如 qwen/qwen3.5-9b-Q4>
  provider: <提供者，如 custom/openai/anthropic>
  base_url: <API 基礎 URL>
  api_key: "<從 .env 讀取>"
```

**常見設置：**
- `default` - 預設模型（無 token 時使用）
- `fallback_providers` - 主模型失敗時的備用提供商列表
- `credential_pool_strategies` - 認證池策略

### agent (代理行為)

```yaml
agent:
  max_turns: <最大對話輪次>
  gateway_timeout: <門禁超時時間（秒）>
  restart_drain_timeout: <重啟排空超時>
  api_max_retries: <API 請求最大重試次數>
  service_tier: ""<服務等級>
  tool_use_enforcement: auto|never|always
  gateway_timeout_warning: <超時警告提前時間（秒）>
  clarify_timeout: <clarify 工具超時>
  image_input_mode: auto|disabled|enabled
```

**重要參數：**
- `max_turns`: 控制對話深度，避免無限循環
- `tool_use_enforcement`: 
  - `auto`: 自動決定是否需要調用工具（推薦）
  - `never`: 禁止使用工具
  - `always`: 強制每個回應都使用工具

### terminal (終端機設定)

```yaml
terminal:
  backend: local|docker
  modal_mode: auto|direct
  cwd: "."<工作目錄>
  timeout: <超時時間（秒）>
  env_passthrough: []<要傳遞的環境變量>
  shell_init_files: []<自定義 shell 初始化腳本>
  docker_image: <Docker 鏡像>
```

### web (網頁工具)

```yaml
web:
  backend: ""<後端服務器類型>
  search_backend: ""<搜索引擎後端>
  extract_backend: ""<數據提取後端>
```

## 🔧 MCP 配置

MCP (Model Context Protocol) 設置在 `mcp.servers` 塊中：

```yaml
mcp:
  servers:
    github-http-protocol:
      type: http
      url: http://localhost:8080/mcp
      headers:
        Authorization: Bearer $GITHUB_TOKEN
      timeout: 300  # 僅適用於支持 --max-time 的 curl (Windows)
```

**重要：** WSL 環境（curl 7.68.0）不支援 `timeout` 參數，請使用 `--connect-timeout` 替代。

## 🛠️ Toolsets (工具集)

```yaml
toolsets:
- hermes-cli
- terminal
- browser
- file
- web
# ... etc

disabled_toolsets: []  # 禁用的工具集
```

**可用工具集：**
- `hermes-cli` - Hermes 內部命令
- `terminal` - 終端機命令執行
- `browser` - 瀏覽器操作
- `file` - 文件系統操作
- `web` - 網頁搜尋和提取
- `image_gen` - 圖像生成
- `vision` - 視覺分析
- `audio` - 音頻處理
- `video` - 視頻處理
- `discord` - Discord 消息
- `slack` - Slack 消息
- `email` - 電子郵件
- `calendar` - 日曆操作

## 📦 Agent 高級設置

```yaml
agent:
  max_turns: 90
  gateway_timeout: 1800  # 30 分鐘
  restart_drain_timeout: 180
  api_max_retries: 3
  service_tier: ""<可留空或使用 premium/basic>
  tool_use_enforcement: auto
  gateway_timeout_warning: 900
  clarify_timeout: 600
  gateway_notify_interval: 180
  gateway_auto_continue_freshness: 3600
  image_input_mode: auto
  disabled_toolsets: []
```

### 關鍵參數說明

| 參數 | 默認值 | 說明 |
|------|--------|------|
| `max_turns` | - | 最大對話輪次，-1 表示無限制 |
| `gateway_timeout` | 1800 | 門禁連接超時時間（秒）|
| `restart_drain_timeout` | 180 | 重啟前的排空等待時間 |
| `api_max_retries` | - | API 請求失敗後的最大重試次數 |
| `clarify_timeout` | - | clarify 工具的超時時間 |

## 🎯 Credential Pool Strategies

```yaml
credential_pool_strategies:
  <策略名稱>:
    max_concurrent_calls: 100
    pool_size: 20
```

用於管理多個 API 請求的認證分發。

## 🌐 Gateway 配置

在 `.hermes/gateway_state.json` 和 `gateway_voice_mode.json` 中：

```json
{
  "state": "idle|running|paused",
  "voice_mode": "auto|always|disabled"
}
```

**狀態說明：**
- `idle` - 等待請求
- `running` - 正在處理任務
- `paused` - 暫停狀態

## 📊 Context Length Cache

```yaml
# ~/.hermes/context_length_cache.yaml
default: 128000
<模型名稱>: <上下文長度>
```

用于緩存不同模型的上下文長度限制。

## 🔐 环境变量 (.env)

```bash
# API 密鑰示例
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-...
GITHUB_TOKEN=ghp_...

# Hermes 內部配置
HERMES_LOG_LEVEL=info|debug|warn
HERMES_WORK_DIR=/path/to/workdir
```

**重要：** `.env` 文件不應提交到 Git！

## 📝 SOUL.md (人格設定)

這是一個 Markdown 文件，定義 Agent 的人格和行為風格：

```markdown
# Hermes Agent Persona

<!--
This file defines the agent's personality and tone.
Edit this to customize how Hermes communicates with you.
--!>

You are a warm, professional AI assistant who:
- Speaks in Traditional Chinese
- Provides structured, detailed responses
- Offers proactive risk disclaimers for sensitive topics
- Values methodological rigor in analysis
- Prefers blueprint/framework over incomplete results
```

## 🔄 配置熱加載

修改配置文件後：

1. **輕量級變更**（如模型設置、工具集）：無需重啟
2. **關鍵性變更**（如 gateway_state.json）：需要重新啟動
   ```bash
   hermes restart agent
   ```

## 📈 最佳實踐

### 1. 分佈式配置

- **Version Control (Git)**: `config.yaml`, `channel_directory.json`
- **Local Overrides**: `.env`, `SOUL.md`, `sessions/`, `memories/`

### 2. 環境隔離

使用不同的配置文件針對不同環境：
```yaml
# config.yaml (production)
model:
  default: qwen/qwen3.5-9b-Q4
  provider: custom

# config-staging.yaml (staging)
model:
  default: llama3.1:8b
  provider: local
```

### 3. Skills 管理

Skills 可以通過以下方式管理：
- **手動**: 直接編輯 `~/.hermes/skills/`
- **Git sync**: `hermes skill sync`
- **Distribution**: 只包含 SKILL.md 定義，不在 Git 中存儲完整內容

## 🔍 配置驗證

```bash
# 檢查 YAML 語法
python3 -c "import yaml; yaml.safe_load(open('config.yaml'))"

# 重新加載配置
hermes restart agent

# 查看當前活動配置
hermes config show

# 驗證工具集
hermes tools list
```

---
**Last Updated:** $(date)
