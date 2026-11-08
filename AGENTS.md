# AGENTS.md - Developer & AI Agent Operations Manual for `termux-dotfiles` 🤖

This document is the definitive operational guide for autonomous AI coding agents (Antigravity, Claude, Cursor, OpenAI Codex, OpenHands) operating within this repository.

---

## 🎯 1. System Overview & Core Philosophy

**📱 Termux Personalization & X11 Desktop Rice 🚀**
> A modern, high-performance, aesthetic Termux terminal customization and automated Termux:X11 GUI Desktop Setup for Android power users, developers, and AI enthusiasts. - ⚡ Starship Prompt + Zsh: Fast, minimal, aesthetic shell prompt with Git & Python environment status. - 🧰 Modern CLI Utilities:

### Key Architectural Capabilities
- `ls` ➔ **`eza`** (with icons and group-first directories)
- `cat` ➔ **`bat`** (syntax highlighting & line numbers)
- `cd` ➔ **`zoxide`** (smart directory navigation)
- `fzf` fuzzy finder integration for history & commands
- `fastfetch` terminal system info overview
- `lazygit` TUI git manager

---

## 🏗️ 2. Repository Structure & Directory Map

| Path | Role & Architectural Responsibility |
| :--- | :--- |
| `.github/` | Subsystem directory (.github) |
| `bin/` | Executable CLI scripts and dispatchers |
| `install.sh` | System installation and setup automation script |
| `iram-x11/` | Subsystem directory (iram-x11) |
| `start-x11.sh` | Shell automation script |
| `stop-x11.sh` | Shell automation script |

---

## ⚙️ 3. Executable Verification Pipeline

Before marking any task complete, an AI agent **must** run the following verification steps sequentially:

### Tier 1: POSIX Shell Syntax Validation
```bash
bash -n $(find . -maxdepth 3 -name '*.sh' -not -path '*/.*')
```

### Tier 2: ShellCheck Linting
```bash
shellcheck $(find . -maxdepth 3 -name '*.sh' -not -path '*/.*')
```

### Tier 3: Non-Destructive Simulation / Dry-Run
```bash
./install.sh --dry-run || ./install.sh --help
```

---

## 🛡️ 4. Architectural Invariants & Non-Negotiable Rules

### Strict Invariants ("Never Do" List):
1. **Strict Shell Safety:** Every shell script must declare `set -euo pipefail`. Never use `|| true` on critical installation or backup steps.
2. **Preserve Subshell Exit Codes:** Separate `local` variable declarations from command substitutions (ShellCheck SC2155).
3. **Safe Path Expansion:** Always quote variable expansions (e.g. `"$TARGET_DIR"`) to guard against whitespace and path traversal.

### Security & Environment Variables:
- All API keys and secrets must be loaded strictly from environment variables.
- Never commit `.env`, `.pem`, token files, or private credentials.

---

## 🤖 5. Autonomous Agent Operational Protocol

When dispatched to resolve an issue, implement a feature, or refactor code in this repo:

1. **Phase 1 — Explore & Plan:**
   - Read this `AGENTS.md` and relevant source files.
   - Check existing tests to establish the baseline.
2. **Phase 2 — Act (Surgical Implementation):**
   - Implement changes with minimal blast radius.
   - Adhere to the established code style and existing conventions.
3. **Phase 3 — Verify:**
   - Run the Tier 1, 2, and 3 verification commands listed above.
   - Ensure all existing and new tests pass cleanly.
4. **Phase 4 — Reflect:**
   - Review `git diff` to confirm zero unintended whitespace or collateral changes.
   - Confirm no untracked scratch files remain.

---
*Maintained by Ayyappa Pravin • Engineered for Antigravity, Claude, Cursor & Modern Autonomous AI Agents.*
