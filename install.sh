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
  gnupg \
  openssh \
  proot-distro \
  xfce4 \
  i3 \
  polybar \
  rofi \
  picom \
  feh \
  termux-x11-nightly 2>/dev/null || pkg install -y xfce4

# Set up Zsh plugins
echo "🔌 Installing Zsh plugins..."
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" 2>/dev/null || true

# Link dotfiles so the repo and the live config cannot drift apart
echo "⚙️ Linking configuration dotfiles..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "${HOME}/.termux" "${HOME}/bin"

for f in .zshrc .tmux.conf.local start-x11.sh stop-x11.sh .termux/termux.properties \
         bin/termux-backup bin/clean-system bin/stock-news; do
  ln -sfn "${SCRIPT_DIR}/${f}" "${HOME}/${f}"
done
[ -e "${HOME}/.tmux.conf" ] || ln -s "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
cp "${SCRIPT_DIR}/.termux/font.ttf" "${HOME}/.termux/font.ttf"
chmod +x "${SCRIPT_DIR}"/bin/* "${SCRIPT_DIR}"/start-x11.sh "${SCRIPT_DIR}"/stop-x11.sh

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
