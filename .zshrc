# Export PATH for local scripts
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Disabled OMZ theme to allow Starship to manage prompt without overhead
ZSH_THEME=""

# Plugins to load
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source $ZSH/oh-my-zsh.sh
fi

# User configuration
export EDITOR='nvim'

# Run Ubuntu in proot
alias ubuntu="proot-distro login ubuntu"

# Modern CLI Aliases
alias ls="eza --icons --group-directories-first"
alias ll="eza -lh --icons --group-directories-first"
alias la="eza -lah --icons --group-directories-first"
alias cat="bat --style=header,grid,snip"
alias lg="lazygit"
alias ff="fastfetch"
alias claw="openclaw"
alias reload="source ~/.zshrc"
alias backup="~/bin/termux-backup"
alias clean="~/bin/clean-system"

# Launch Termux:X11
alias x11="~/start-x11.sh"
alias stop-x11="~/stop-x11.sh"

# Initialize zoxide
eval "$(zoxide init zsh 2>/dev/null)" || true

# Initialize fzf keybindings & completion
eval "$(fzf --zsh 2>/dev/null)" || true

# Share one SSH agent across all shells
if [ -z "$SSH_AUTH_SOCK" ] && [ -f ~/.ssh/id_ed25519 ]; then
   export SSH_AUTH_SOCK="$HOME/.ssh/agent/shared.sock"
   ssh-add -l >/dev/null 2>&1
   if [ $? -eq 2 ]; then
      mkdir -p ~/.ssh/agent
      rm -f "$SSH_AUTH_SOCK"
      eval "$(ssh-agent -a "$SSH_AUTH_SOCK" -s)" > /dev/null
   fi
   if [ -t 0 ] && ! ssh-add -l >/dev/null 2>&1; then
      ssh-add ~/.ssh/id_ed25519 2>/dev/null
   fi
fi

# Initialize Starship Prompt
eval "$(starship init zsh 2>/dev/null)" || true
