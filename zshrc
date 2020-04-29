# Add Homebrew's sbin to path
export PATH="/usr/local/sbin:$PATH"

# Set locale variables
export LANG="en_US.UTF-8"
export LC_COLLATE="C.UTF-8" # Reset to default instead of LANG
export LC_NUMBERIC="C.UTF-8" # Reset to default instead of LANG
export LC_MONETARY="nl_BE.UTF-8"
export LC_PAPER="nl_BE.UTF-8"
export LC_TIME="nl_BE.UTF-8"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Aliases
alias l="ls -lah"
