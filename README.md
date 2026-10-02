# 📱 Termux Personalization & X11 Desktop Rice 🚀

A modern, high-performance, aesthetic **Termux terminal customization** and automated **Termux:X11 GUI Desktop Setup** for Android power users, developers, and AI enthusiasts.

---

## ✨ Features

- ⚡ **Starship Prompt + Zsh**: Fast, minimal, aesthetic shell prompt with Git & Python environment status.
- 🧰 **Modern CLI Utilities**:
  - `ls` ➔ **`eza`** (with icons and group-first directories)
  - `cat` ➔ **`bat`** (syntax highlighting & line numbers)
  - `cd` ➔ **`zoxide`** (smart directory navigation)
  - `fzf` fuzzy finder integration for history & commands
  - `fastfetch` terminal system info overview
  - `lazygit` TUI git manager
- 🖥️ **Termux:X11 XFCE4 GUI Desktop**:
  - 1-click start command (`x11`) and stop command (`stop-x11`).
  - Native speed desktop interface on Android devices.
  - Automatic dark liquid wallpaper fitting via `xfconf-query`.
- 🎹 **Custom Extra-Keys Row**:
  - 2-row custom Termux key layout optimized for terminal navigation, vim commands (`:q`), macros, arrow keys, and Git commands (`git status`).
- 🐧 **Ubuntu Proot-Distro Integration**:
  - Pre-configured `ubuntu` alias for running Ollama AI models, PyTorch, Node.js, and heavy Linux software.
- 💾 **System Backup Utility**:
  - `backup` command to archive and save your Termux state.

---

## ⚡ 1-Line Quick Installation

Open Termux on your Android phone and paste the following command:

```bash
pkg install -y git && git clone https://github.com/apravint/termux-dotfiles.git ~/.termux-dotfiles && bash ~/.termux-dotfiles/install.sh
```

---

## ⌨️ Custom Shortcuts & Aliases

| Alias / Command | Action |
| :--- | :--- |
| `x11` | Launch Termux:X11 hardware-accelerated XFCE Desktop |
| `stop-x11` | Terminate active X11 desktop session |
| `ubuntu` | Login to Ubuntu Proot container (`proot-distro login ubuntu`) |
| `ls` / `ll` / `la` | Modern `eza` directory listing with icons |
| `cat` | Syntax-highlighted viewer with `bat` |
| `lg` | Launch `lazygit` TUI |
| `ff` | Run `fastfetch` system banner |
| `backup` | Create a compressed backup of your Termux setup |
| `reload` | Quick source `~/.zshrc` |

---

## 🖥️ Launching the XFCE GUI Desktop

1. Install the companion **[Termux:X11 Android App APK](https://github.com/termux/termux-x11/releases)** on your Android device.
2. Open Termux and run:
   ```bash
   x11
   ```
3. Open the **Termux:X11** app on your phone. You will instantly see your full desktop environment!
4. To stop the GUI session, run:
   ```bash
   stop-x11
   ```

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE).
