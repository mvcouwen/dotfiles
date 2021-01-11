# Set locale variables
export LANG="en_US.UTF-8"
export LC_COLLATE="C" # Reset to default instead of LANG
export LC_NUMBERIC="C" # Reset to default instead of LANG
export LC_MONETARY="nl_BE.UTF-8"
export LC_PAPER="nl_BE.UTF-8"
export LC_TIME="en_US.UTF-8"

# pure
fpath+=~/.dotfiles/modules/pure
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:dirty color 242

# zsh-syntax-highlighting (must be sourced after everything else)
source ~/.dotfiles/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load local configuration
# Keep this at the bottom
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi
