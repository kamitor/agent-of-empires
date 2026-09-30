#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREBUILT_BIN="$SCRIPT_DIR/prebuilt/aoe"
TARGET_DIR="$HOME/.local/bin"

if [ ! -f "$PREBUILT_BIN" ]; then
    echo "Error: Prebuilt binary not found at $PREBUILT_BIN"
    exit 1
fi

mkdir -p "$TARGET_DIR"
cp "$PREBUILT_BIN" "$TARGET_DIR/aoe"
chmod +x "$TARGET_DIR/aoe"

echo "Successfully installed aoe to $TARGET_DIR/aoe"
echo "Version: $($TARGET_DIR/aoe --version)"
