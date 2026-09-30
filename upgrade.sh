#!/usr/bin/env bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
TARGET_BIN="$HOME/.local/bin/aoe"
PREBUILT_BIN="$SCRIPT_DIR/prebuilt/aoe"

echo "========================================="
echo "  Agent of Empires - Antigravity Upgrade "
echo "========================================="

# 1. Update from git if in a git repository
if [ -d "$SCRIPT_DIR/.git" ]; then
    echo "Checking for latest updates from Git..."
    git -C "$SCRIPT_DIR" pull --ff-only origin feature/antigravity 2>/dev/null || true
fi

# 2. Install prebuilt or build from source
mkdir -p "$HOME/.local/bin"

if [ "$1" == "--build" ] || [ ! -f "$PREBUILT_BIN" ]; then
    echo "Compiling from source with Cargo (this may take several minutes)..."
    cd "$SCRIPT_DIR"
    cargo build --release
    cp "$SCRIPT_DIR/target/release/aoe" "$TARGET_BIN.new"
    mv -f "$TARGET_BIN.new" "$TARGET_BIN"
else
    echo "Installing prebuilt binary..."
    cp "$PREBUILT_BIN" "$TARGET_BIN.new"
    mv -f "$TARGET_BIN.new" "$TARGET_BIN"
fi

chmod +x "$TARGET_BIN"

# 3. Verify installation and PATH
echo ""
echo "Verifying installation:"
ACTIVE_AOE="$(which aoe 2>/dev/null || true)"

if [ "$ACTIVE_AOE" != "$TARGET_BIN" ]; then
    echo "⚠️  Note: 'which aoe' resolved to: $ACTIVE_AOE"
    echo "   Ensure ~/.local/bin is at the beginning of your PATH."
    echo "   Add this to your ~/.bashrc or ~/.zshrc if needed:"
    echo '   export PATH="$HOME/.local/bin:$PATH"'
else
    echo "✓ Active binary: $ACTIVE_AOE"
fi

echo "✓ aoe version:   $($TARGET_BIN --version 2>/dev/null || echo 'Installed')"

# 4. Check Antigravity CLI (agy), auto-install if missing
if which agy >/dev/null 2>&1; then
    echo "✓ Antigravity CLI (agy): found at $(which agy)"
else
    echo "⚠️  Antigravity CLI (agy) not found in PATH."
    echo "Installing Antigravity CLI (agy)..."
    if curl -fsSL https://antigravity.google/cli/install.sh | bash; then
        echo "✓ Antigravity CLI installed successfully!"
    else
        echo "❌ Failed to install Antigravity CLI automatically."
        echo "   Please run: curl -fsSL https://antigravity.google/cli/install.sh | bash"
    fi
fi

echo ""
echo "========================================="
echo " Upgrade Complete!                       "
echo " You can now launch: aoe                 "
echo "========================================="
