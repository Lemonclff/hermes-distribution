# Hermes Profile Installation Guide
# ============= 配置分佈安裝指南 =============

## 快速開始

### 方法一：使用 hermes CLI（推薦）

```bash
# 克隆 Profile Distribution
hermes profile install /home/lemon/hermes-distribution

# 或者從 Git 倉庫克隆
hermes profile install https://github.com/lemon/hermes-distribution
```

### 方法二：手動安裝

```bash
# 1. 創建目標目錄
mkdir -p ~/.hermes

# 2. 複製配置文件
cp config.yaml ~/.hermes/config.yaml
cp channel_directory.json ~/.hermes/channel_directory.json
cp auth.json ~/.hermes/auth.json
cp context_length_cache.yaml ~/.hermes/context_length_cache.yaml
cp gateway_voice_mode.json ~/.hermes/gateway_voice_mode.json
cp gateway_state.json ~/.hermes/gateway_state.json

# 3. 保留 SOUL.md（人格設定）
# 建議在 ~/.hermes/ 下維護本地的 SOUL.md

# 4. 設置环境变量（如果有的話）
# 編輯 ~/.bashrc 或 ~/.zshrc：
# export HERMES_HOME=~/.hermes
```

## 驗證安裝

### 檢查配置是否正確應用

```bash
# 查看當前配置的模型設置
cat ~/.hermes/config.yaml | head -20

# 重新啟動 Agent 測試
hermes restart agent

# 查看日誌確認無錯誤
tail -f ~/.hermes/logs/*.log
```

### 常見問題排查

#### Problem: config.yaml 不生效

**Solution:**
```bash
# 確保配置路徑正確
ls -la ~/.hermes/config.yaml

# 檢查語法錯誤（Python YAML 解析）
python3 -c "import yaml; yaml.safe_load(open('~/.hermes/config.yaml'))"

# 重新加載配置
killall hermes-gateway 2>/dev/null || true
hermes restart agent
```

#### Problem: SOUL.md (人格) 未顯示

**Solution:**
```bash
# 確保有本地的人格文件
cat ~/.hermes/SOUL.md

# 如果沒有，可以創建一個新的：
echo "You are a helpful AI assistant." > ~/.hermes/SOUL.md
```

## Advanced: Skills 管理

### 分佈中包含的技能

目前分佈**不包含**技能目錄（skills/），因為：
1. 技能通常較大
2. 技能可能需要根據系統環境調整
3. 本地化設置更適合保留在本地

### 同步技能（可選）

```bash
# 如果你有版本控制的技能
hermes skill sync

# 或手動複製
cp -r /path/to/skills ~/.hermes/skills
```

## Post-Installation Checklist

安裝完成後，請確認：

- [ ] `config.yaml` 包含所有需要的配置
- [ ] `.env` 文件已根據需要設置（API 密鑰等）
- [ ] `SOUL.md` 人格設定已定義
- [ ] `auth.json` OAuth 認證正常
- [ ] Gateway 可以正常啟動
- [ ] Tools 可以正確執行

## Maintenance

### 定期更新

```bash
# Pull 最新的分佈更改（如果從 Git）
git pull origin main

# 應用更改（智能區分 Distribution 文件 vs 用戶文件）
hermes profile update

# 驗證變更無誤
hermes validate config
```

### 備份當前配置

```bash
# 完整備份
tar -czf ~/.hermes_backup_$(date +%Y%m%d).tar.gz \
  ~/.hermes/config.yaml \
  ~/.hermes/SOUL.md \
  ~/.hermes/.env

# 只備份需要版本控制的文件
tar -czf ~/.hermes_config_backup_$(date +%Y%m%d).tar.gz \
  ~/.hermes/config.yaml \
  ~/.hermes/channel_directory.json
```

## Troubleshooting

### Q: 安裝後 Agent 不認識我的配置？

**A:** 需要重新啟動 Agent：
```bash
killall hermes-gateway
hermes restart agent
```

### Q: 某些工具無法執行？

**A:** 檢查 disabled_toolsets 設定：
```bash
grep -A5 "disabled_toolsets" ~/.hermes/config.yaml
```

### Q: API 連接失敗？

**A:** 
1. 檢查 `.env` 中的 API 密鑰
2. 確認 `model.base_url` 正確
3. 測試連接：`curl $model.base_url/v1/models`

## Support

如果遇到问题，请检查：
1. Hermes Agent 版本：`hermes --version`
2. Python 版本：`python3 --version`
3. 查看日志：`tail -50 ~/.hermes/logs/*.log`

---
**Remember:** Always check the .gitignore file to ensure sensitive data is not committed!
