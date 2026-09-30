# Antigravity CLI (`agy`) Integration Guide

## Overview

Agent of Empires natively supports the **Google Antigravity CLI (`agy`)**. It replaces the legacy Gemini CLI implementation while maintaining full backward compatibility with existing profiles and sessions.

---

## Key Features & Behaviors

### 1. Agent Name & Binary Discovery
- **Primary Agent Name**: `agy`
- **Binary**: `agy` (resolved dynamically via `which agy`, default: `~/.local/bin/agy`)
- **Aliases**: `antigravity`, `gemini`
  - Any session or command referencing `antigravity` or `gemini` automatically resolves to the `agy` agent definition.

### 2. Auto-Approve / YOLO Mode
When YOLO mode is enabled for an `agy` session, `aoe` launches the process with:
```bash
agy --dangerously-skip-permissions
```
Unlike the older Gemini CLI which expected `--approval-mode yolo`, `agy` uses `--dangerously-skip-permissions` to bypass manual tool call approvals.

### 3. Tmux Status Detection
`aoe` continuously monitors the tmux pane running `agy` to determine the agent's current lifecycle state:
- **`Running`**: Active tool execution, spinner animation, or model generation.
- **`Waiting for Permission`**: Interactive tool confirmation prompt (when YOLO mode is off).
- **`Waiting for Input`**: Model prompt input / question.
- **`Idle`**: Standard interactive input prompt waiting for user command.

### 4. Container & Sandbox Mounts
When running in containerized or sandbox modes, `aoe` maps the host configuration folder:
- Host: `~/.gemini` (which houses `~/.gemini/antigravity-cli` skills, brain, cache, and auth credentials)
- Mount target: `/root/.gemini` or `/home/<user>/.gemini`

---

## Configuring a Session

In `~/.config/agent-of-empires/profiles/<profile>/sessions.json`, define an Antigravity session as follows:

```json
{
  "id": "88c4262359f547c1",
  "title": "My Antigravity Session",
  "tool": "agy",
  "path": "/home/chris/my-project",
  "yolo_mode": true,
  "status": "idle"
}
```

> **Note**: Legacy sessions with `"tool": "gemini"` will automatically resolve to `agy` without requiring modifications.

---

## Multi-Machine Synchronization

The `agent-of-empires` source code, prebuilt binaries, and Git history are synchronized across machines via:
- **NextCloud Folder**: `~/Documents/NextCloud/Github/agent-of-empires`
- **GitHub Fork**: `https://github.com/kamitor/agent-of-empires` (branch: `feature/antigravity`)

On a secondary machine:
1. Navigate to `~/Documents/NextCloud/Github/agent-of-empires`.
2. Run `./install-prebuilt.sh` to install the pre-compiled binary directly to `~/.local/bin/aoe`.
3. Or run `./build-from-source.sh` to compile with Cargo.
