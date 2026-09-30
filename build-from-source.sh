#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

cd "$SCRIPT_DIR"

echo "Building agent-of-empires with Antigravity CLI support..."
cargo build --release

mkdir -p "$TARGET_DIR"
cp "$SCRIPT_DIR/target/release/aoe" "$TARGET_DIR/aoe"
chmod +x "$TARGET_DIR/aoe"

echo "Successfully built and installed aoe to $TARGET_DIR/aoe"
echo "Version: $($TARGET_DIR/aoe --version)"
