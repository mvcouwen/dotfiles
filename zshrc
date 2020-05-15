# Set locale variables
export LANG="en_US.UTF-8"
export LC_COLLATE="C" # Reset to default instead of LANG
export LC_NUMBERIC="C" # Reset to default instead of LANG
export LC_MONETARY="nl_BE.UTF-8"
export LC_PAPER="nl_BE.UTF-8"
export LC_TIME="en_US.UTF-8"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Aliases
alias l="ls -lah"

# Load local configuration
# Keep this at the bottom
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi
