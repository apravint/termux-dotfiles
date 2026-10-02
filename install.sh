#!/usr/bin/env bash
# ==============================================================================
#  Termux Personalization & X11 Desktop Installer
# ==============================================================================

set -e

echo "🚀 Starting Termux Personalization & X11 Setup..."

# Update & Install Required Packages
echo "📦 Installing modern CLI tools and dependencies..."
pkg update -y
pkg install -y \
  zsh \
  starship \
  eza \
  bat \
  fzf \
  zoxide \
  lazygit \
  fastfetch \
  tmux \
  neovim \
  curl \
  git \
  proot-distro \
  xfce4 \
  termux-x11-nightly 2>/dev/null || pkg install -y xfce4

# Set up Zsh plugins
echo "🔌 Installing Zsh plugins..."
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" 2>/dev/null || true

# Copy Dotfiles
echo "⚙️ Copying configuration dotfiles..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "${SCRIPT_DIR}/.zshrc" "${HOME}/.zshrc"
mkdir -p "${HOME}/.termux" "${HOME}/bin"
cp "${SCRIPT_DIR}/.termux/termux.properties" "${HOME}/.termux/termux.properties"

if [ -f "${SCRIPT_DIR}/.tmux.conf" ]; then
  cp "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
fi
if [ -f "${SCRIPT_DIR}/.tmux.conf.local" ]; then
  cp "${SCRIPT_DIR}/.tmux.conf.local" "${HOME}/.tmux.conf.local"
fi

cp "${SCRIPT_DIR}/start-x11.sh" "${HOME}/start-x11.sh"
cp "${SCRIPT_DIR}/stop-x11.sh" "${HOME}/stop-x11.sh"
cp "${SCRIPT_DIR}/bin/termux-backup" "${HOME}/bin/termux-backup"

chmod +x "${HOME}/start-x11.sh" "${HOME}/stop-x11.sh" "${HOME}/bin/termux-backup"

# Apply Termux Settings
termux-reload-settings 2>/dev/null || true

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s zsh
fi

echo ""
echo "=================================================================="
echo "  🎉 Termux Personalization Setup Completed Successfully!"
echo "=================================================================="
echo "  ► Restart Termux or run: source ~/.zshrc"
echo "  ► Launch XFCE Desktop: x11"
echo "  ► Stop XFCE Desktop: stop-x11"
echo "=================================================================="
