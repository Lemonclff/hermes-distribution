#!/bin/bash
# Hermes Profile Distribution Setup Script
# =========================================
# 此腳本幫助你從 ~/.hermes 設置創建 Profile Distribution

set -e

DIST_DIR="/home/lemon/hermes-distribution"
SOURCE_DIR="/home/lemon/.hermes"

echo "=============================================="
echo "Hermes Profile Distribution Setup Script"
echo "=============================================="
echo ""

# Step 1: 檢查是否已存在分佈目錄
if [ -d "$DIST_DIR/.git" ]; then
    echo "✅ Distribution directory already exists at: $DIST_DIR"
else
    echo "ℹ️  Distribution directory does not exist. Creating..."
    mkdir -p "$DIST_DIR"
fi

# Step 2: 列出需要在分佈中包含的文件
echo ""
echo "📦 Files to include in distribution:"
echo "=================================="
cat <<'EOF'
✅ config.yaml - Main configuration (model, tools, agent settings)
✅ channel_directory.json - Channel definitions
✅ auth.json - OAuth authentication status  
✅ context_length_cache.yaml - Context length cache
✅ gateway_voice_mode.json - Voice mode settings
✅ gateway_state.json - Gateway state

🚫 Files NOT included (handled by .gitignore):
❌ .env - API keys and tokens (environment variables)
❌ sessions/ - Session history (privacy sensitive)
❌ memories/ - AI memory data (user privacy)
❌ logs/ - Log files (temporary data)
EOF

# Step 3: 檢查需要添加的文檔文件
echo ""
echo "📝 Checking documentation files..."
doc_files=(
    "README.md"
    "INSTALL.md"
    "REFERENCE.md"
    ".gitignore"
    "SOUL-template.md"
)

for doc in "${doc_files[@]}"; do
    if [ -f "$DIST_DIR/$doc" ]; then
        echo "  ✅ $doc exists"
    else
        echo "  ⚠️  $doc is missing!"
    fi
done

# Step 4: 準備配置文件（掩碼敏感數據）
echo ""
echo "🔧 Creating config-example.yaml (masked sensitive data)..."
python3 << 'PYTHON_EOF'
import os
import re
from pathlib import Path

source_path = Path("/home/lemon/.hermes/config.yaml")
if source_path.exists():
    with open(source_path, 'r') as f:
        content = f.read()
    
    # Mask values for sensitive keys
    masked_content = re.sub(
        r'([a-zA-Z0-9_]+):["\']([^"\']+)[\n]',
        r'\1: "<masked>[\2]</masked>"\n',
        content
    )
    
    example_path = Path("/home/lemon/hermes-distribution/config-example.yaml")
    with open(example_path, 'w') as f:
        f.write(masked_content.strip())
    
    print(f"✅ Created config-example.yaml at: /home/lemon/hermes-distribution/config-example.yaml")
else:
    print(f"⚠️  Source config not found at {source_path}")
PYTHON_EOF

# Step 5: 添加文件到 Git
echo ""
echo "📂 Adding files to Git repository..."

cd "$DIST_DIR"

# Track added files
added_files=()

for file in README.md INSTALL.md REFERENCE.md ".gitignore" config-example.yaml "SOUL-template.md"; do
    if [ -f "$file" ]; then
        git add "$file"
        added_files+=("$file")
    fi
done

# Add channel_directory.json, auth.json, etc. if they exist and are not in .env
if [ -f "channel_directory.json" ] && [[ ! -f ".env"* ]]; then
    git add channel_directory.json
    added_files+=("channel_directory.json")
fi

if [ -f "auth.json" ] && [[ ! -f ".env"* ]]; then
    git add auth.json
    added_files+=("auth.json")
fi

echo ""
echo "✅ Added to Git:"
for file in "${added_files[@]}"; do
    echo "  ✅ $file"
done

# Step 6: 檢查狀態
echo ""
echo "📊 Git status:"
git status --short

echo ""
echo "=============================================="
echo "✅ Profile Distribution Setup Complete!"
echo "=============================================="
echo ""
echo "🎯 Next Steps:"
echo "   1. Review the files added to Git"
echo "   2. (Optional) Create a .github/workflows for CI/CD"
echo "   3. Push to remote repository when ready"
echo "   4. Others can use: hermes profile install <repo-url>"
echo ""
echo "📝 Documentation:"
echo "   - README.md: Quick start and installation guide"
echo "   - INSTALL.md: Detailed installation steps"
echo "   - REFERENCE.md: Complete configuration reference"
echo "   - SOUL-template.md: Personality setting template"
echo ""
