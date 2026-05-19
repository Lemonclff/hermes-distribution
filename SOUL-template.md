# Hermes Profile Distribution - Migration Guide
# ============= 從本地設置遷移指南 ============

## 🎯 目標

將你現有的 `~/.hermes` 配置分佈成可版本控制的 Git 倉庫，同時保護敏感數據。

## 📋 當前設置狀態

### ✅ 已完成：Profile Distribution 目錄創建

```
hermes-distribution/
├── README.md                 # 快速開始指南
├── INSTALL.md                # 詳細安裝說明  
├── REFERENCE.md              # 配置參數完整參考
├── .gitignore                # Git 忽略規則
└── config-example.yaml       # 當前配置的副本（已掩碼敏感數據）
```

### 📂 Distribution 包含的文件

這些文件已經在 Git 倉庫中準備好：

| 文件 | 說明 | 可共享？ |
|------|------|---------|
| `config.yaml` | 主配置文件（模型、工具集等） | ✅ 是 |
| `config-example.yaml` | 示例配置模板 | ✅ 是 |
| `channel_directory.json` | 頻道目錄定義 | ✅ 是 |
| `auth.json` | OAuth 認證狀態 | ⚠️ 需重新生成 Token |
| `context_length_cache.yaml` | 上下文長度緩存 | ✅ 是 |
| `gateway_voice_mode.json` | 語音模式配置 | ✅ 是 |
| `gateway_state.json` | Gateway 狀態 | ✅ 是 |

### 🚫 Distribution 不包含的文件（已排除）

這些文件**不會**被提交到 Git，應該本地管理：

| 文件/目錄 | 說明 | 原因 |
|----------|------|------|
| `.env` | API 密鑰、Token | 🔒 隱私保護 |
| `sessions/` | 會話歷史記錄 | 🔒 包含對話內容 |
| `memories/` | AI 記憶數據 | 🔒 用戶隱私數據 |
| `logs/` | 日誌文件 | 🔒 可能包含敏感操作 |
| `state.db*` | Redis 狀態數據庫 | 🔄 可重生成 |

## 🚀 設置步驟（完整流程）

### Step 1: 確保配置文件已準備就緒

檢查分佈目錄：

```bash
cd /home/lemon/hermes-distribution
ls -la
```

預期看到以下文件：
- ✅ README.md
- ✅ INSTALL.md
- ✅ REFERENCE.md
- ✅ .gitignore
- ✅ config-example.yaml

### Step 2: （可選）添加更多模板文件

#### 創建 SOUL-template.md（人格設定模板）

<tool_call>
<function=write_file>
<parameter=content>
# Hermes Agent Persona Template
# ============ 人格設定模板 ============

<!--
This file defines the agent's personality and tone.
Edit this to customize how Hermes communicates with you.
Examples:
  - "You are a warm, playful assistant who uses kaomoji occasionally."
  - "You are a concise technical expert. No fluff, just facts."
  - "You speak like a friendly coworker who happens to know everything."

This file is loaded fresh each message -- no restart needed.
Delete the contents (or this file) to use the default personality.
-->

# [你的個性設定]

<!-- 
提示：這是一個模板文件。在實際使用中，你需要根據自己的偏好編輯此文件。
以下是一個示例人格設定，你可以參考並自定義：
-->

You are a helpful AI assistant who:
1. Speaks clearly and professionally in Traditional Chinese (繁體中文)
2. Provides structured, detailed responses for complex topics
3. Offers proactive risk disclaimers for sensitive topics (finance, health, etc.)
4. Values methodological rigor - provides blueprints/frameworks over incomplete results
5. Prefers to be organized: uses tables, bullet points, and clear sections
6. Asks clarifying questions when topics are ambiguous or need more context
7. Demonstrates expertise in technical subjects (AI, quant finance, tools integration)

## Communication Style
- Tone: Professional yet approachable
- Language: Traditional Chinese (繁體中文) for user communication
- Format: Structured responses with clear headings and sections
- Length: Detailed when needed; concise when appropriate

## Key Principles
- **Accuracy over speed**: When in doubt about data, acknowledge the limitation and provide methodology/framework
- **Proactive**: Anticipate user needs and potential issues
- **Structured**: Organize complex information logically
- **Disclaimers**: Always provide risk warnings for sensitive domains

## Domain Expertise
- AI/ML Systems
- Quantitative Finance
- Tool Integration (MCP, APIs)
- System Architecture
- Development Workflows

---
Template created: $(date)
