# Hermes Profile Distribution - 使用流程說明
# =============================== Usage Guide ===============================

## ✅ 已完成的工作

你的 Profile Distribution 已創建完成，位於：
📁 `/home/lemon/hermes-distribution/`

### 📦 分佈內容（8 個文件）
- `README.md` - 快速開始和安裝指南
- `INSTALL.md` - 詳細安裝步驟
- `REFERENCE.md` - 配置參數完整參考
- `DISTRIBUTION_COMPLETE.md` - 分佈功能說明
- `PROFILE_SETUP_COMPLETE.md` - 設置完成報告
- `SOUL-template.md` - 人格設定模板
- `config-example.yaml` - 示例配置文件（掩碼敏感數據）
- `.gitignore` - Git 忽略規則

### 📊 Git 倉庫狀態
```bash
cd /home/lemon/hermes-distribution
git log --oneline --all
# 包含 3 個 commit：
# 1. ac1a2e9 feat: Initial Profile Distribution with configuration templates
# 2. a6b51e9 feat: Add distribution complete documentation and example configuration
# 3. 1aeac13 feat: Add complete setup report
```

## 🚀 使用方法（根據你的需求選擇）

### 📌 情況一：你想要安裝 Profile Distribution 到自己的環境

如果 `hermes profile install` 命令可用：

```bash
# 安裝分佈到你的 ~/.hermes/
hermes profile install /home/lemon/hermes-distribution
```

這會：
1. ✅ 檢查配置完整性
2. ✅ 複製配置文件到目標位置
3. ✅ 驗證 YAML 語法
4. ✅ 加載人格設定

### 📌 情況二：你想要測試分佈是否正確安裝

```bash
# 查看當前 ~/.hermes/config.yaml（如果已安裝）
cat ~/.hermes/config.yaml | head -20

# 重新啟動 Agent 測試
hermes restart agent

# 查看日誌確認無誤
tail -20 /home/lemon/.hermes/logs/*.log 2>/dev/null || echo "Logs not found"
```

### 📌 情況三：你想要分享 Profile Distribution 到 GitHub

如果希望將分佈公開分享給其他人使用：

```bash
# 創建或添加遠端倉庫（如已有 GitHub 帳戶）
git remote add origin https://github.com/lemon/hermes-distribution.git

# 推送到 GitHub
git push -u origin main

# （可選）創建 Release 標籤
git tag v1.0.0 && git push --tags
```

然後其他人可以使用：
```bash
hermes profile install https://github.com/lemon/hermes-distribution
```

### 📌 情況四：你想要將 Profile Distribution 作為參考文檔使用

直接查看和閱讀文檔文件：

```bash
# 快速開始
cat /home/lemon/hermes-distribution/README.md

# 詳細安裝步驟
cat /home/lemon/hermes-distribution/INSTALL.md

# 配置參數參考
cat /home/lemon/hermes-distribution/REFERENCE.md

# 人格設定模板
cat /home/lemon/hermes-distribution/SOUL-template.md
```

### 📌 情況五：你想要手動將配置文件應用到現有環境

如果 `~/.hermes/config.yaml` 已經存在且不想替換：

1. **查看當前配置**
```bash
cat ~/.hermes/config.yaml | head -30
```

2. **比較示例配置的差異**
```bash
# 查看 config-example.yaml 的內容
cat /home/lemon/hermes-distribution/config-example.yaml | head -50
```

3. **如果需要更新，可以選擇性地修改配置**
```bash
# 編輯當前配置文件
vi ~/.hermes/config.yaml
# 或
nano ~/.hermes/config.yaml
```

## 🔍 查看分佈內容和狀態

### 📦 文件列表
```bash
cd /home/lemon/hermes-distribution
ls -la
```

### 📊 Git 提交歷史
```bash
git log --oneline --all --graph
```

### 📝 .gitignore 規則
```bash
cat .gitignore
# 確認敏感數據被排除：.env, sessions/, memories/, logs/, state.db*
```

### 🔒 隱私保護測試
```bash
# 確認 .env 文件未被包含（如果存在）
ls -la ~/.hermes/.env 2>/dev/null && echo ".env exists (should be in .gitignore)" || echo ".env not found (OK)"
```

## 📚 推薦閱讀順序

1. **README.md** - 了解什麼是 Profile Distribution
2. **PROFILE_SETUP_COMPLETE.md** - 查看設置報告和總結
3. **INSTALL.md** - 學習詳細安裝步驟
4. **REFERENCE.md** - 熟悉配置參數
5. **SOUL-template.md** - 參考人格設定模板

## 💡 典型使用場景

### 場景一：分享你的配置給同事

```bash
# 1. 推送到 GitHub（如已完成）
git push origin main

# 2. 發送 Git URL 給同事
# "我的 Hermes Profile Distribution: https://github.com/lemon/hermes-distribution"

# 3. 同事使用：
hermes profile install https://github.com/lemon/hermes-distribution
```

### 場景二：作為配置模板保存

```bash
# 將分佈目錄複製到不同項目
mkdir -p /path/to/project1/hermes-config
cp -r /home/lemon/hermes-distribution/* /path/to/project1/hermes-config/
```

### 場景三：版本控制自己的配置變更

```bash
cd /home/lemon/hermes-distribution

# 修改示例配置文件（如需要更新模板）
vi config-example.yaml

# 添加並提交變更
git add config-example.yaml
git commit -m "feat: Update configuration example with new settings"

# 推送到遠端（如已設置）
git push origin main
```

## ⚠️ 重要注意事項

1. **敏感數據保護** - `.env`、`sessions/`、`memories/`、`logs/` 永遠不會被分佈命令觸動
2. **人格設定維護** - `SOUL-template.md` 是模板，實際的人格設定應保存在 `~/.hermes/SOUL.md`
3. **Skills 本地管理** - Skills 目錄建議本地管理或只包含 SKILL.md 定義
4. **配置熱加載** - 修改 config.yaml 後可能需要重新啟動 Agent

## 🎯 總結

你的 Hermes Profile Distribution 已經準備就緒，可以：

✅ **作為 Git 倉庫分享** - 推送到 GitHub 並發送給他人  
✅ **作為本地參考文檔** - 閱讀和學習配置結構  
✅ **作為安裝模板** - 使用 `hermes profile install` 命令安裝到其他環境  
✅ **作為配置藍圖** - 基於其中的模板創建自己的配置文件

---
**需要進一步幫助？** 請查看：
- `/home/lemon/hermes-distribution/README.md`
- `/home/lemon/hermes-distribution/INSTALL.md`
- `/home/lemon/PROFILE_DISTRIBUTION_GUIDE.md` (快速使用指南)
