# Add Homebrew's sbin to path
export PATH="/usr/local/sbin:$PATH"

# Set locale variables
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="nl_BE.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="nl_BE.UTF-8"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Aliases
alias l="ls -lah"
