# Agent of Empires (with Antigravity CLI / agy integration)

This repository contains the customized build of **Agent of Empires (`aoe`)** that integrates the **Google Antigravity CLI (`agy`)** in place of Gemini, supporting no-permissions mode via `--dangerously-skip-permissions`.

---

## Quick Setup on Another Machine

### Option 1: Use Prebuilt Binary (Instant, Linux x86_64)
If your other machine is running Linux (x86_64), a prebuilt binary is included in this folder:

```bash
cd ~/Documents/NextCloud/Github/agent-of-empires
./install-prebuilt.sh
```

This installs `aoe` to `~/.local/bin/aoe`. Ensure `~/.local/bin` is in your `PATH` (e.g. in `~/.bashrc` or `~/.zshrc`):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

---

### Option 2: Build from Source
If your other machine uses a different architecture or you prefer compiling from source:

```bash
cd ~/Documents/NextCloud/Github/agent-of-empires
./build-from-source.sh
```

*(Requires Rust & Cargo: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`)*

---

### Option 3: Git Repository on Another Machine
- **GitHub Remote Fork**:
  The branch `feature/antigravity` is pushed to GitHub under:
  ```bash
  git clone https://github.com/kamitor/agent-of-empires.git -b feature/antigravity
  ```

- **From NextCloud Git Bundle (Offline / Direct)**:
  Because Nextcloud sync excludes `.git` folders by default (`sync-exclude.lst`), an uncompressed bundle `agent-of-empires.bundle` is included here. You can clone directly from it:
  ```bash
  git clone agent-of-empires.bundle my-aoe-repo
  ```

---

## Antigravity CLI (`agy`) Configuration

1. Make sure `agy` is installed and in your `PATH`:
   ```bash
   which agy
   ```
2. When creating or configuring sessions in `aoe`:
   - Set the agent / tool to `agy`.
   - Enable YOLO / no-permissions mode (`yolo_mode: true`).
   - `aoe` will automatically launch:
     ```bash
     agy --dangerously-skip-permissions
     ```
