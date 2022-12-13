#!/bin/sh

# define logging functions

if [ -t 1 ]; then
  ansi_escape() { printf "\033[%sm" "$1"; }
else
  ansi_escape() { :; }
fi

ansi_bold=`ansi_escape 1`
ansi_red=`ansi_escape 31`
ansi_yellow=`ansi_escape 33`
ansi_blue=`ansi_escape 34`
ansi_cyan=`ansi_escape 36`
ansi_reset=`ansi_escape 0`
newline="\n"

print_time() {
    printf "${ansi_cyan}[%s]${ansi_reset}" "`date '+%Y-%m-%d %H:%M:%S'`"
}

log() {
    printf "%s %s[%s]${ansi_reset} %s${newline}" "`print_time`" "$1" "$2" "$3"
}

log_info() {
    log "${ansi_blue}" "INFO" "$*"
}

log_warn() {
    log "${ansi_yellow}" "WARN" "$*"
}

log_error() {
    log "${ansi_red}" "ERROR" "$*" 1>&2
}

# helper functions

get_sudo_access() {
  if [ -z "${HAVE_SUDO_ACCESS-}" ]; then
    SUDO=`command -v sudo`
    if [ -z ${SUDO-} ]; then
        exit_error "Cannot find sudo."
    fi
    ${SUDO} -v && ${SUDO} -l mkdir &>/dev/null
    HAVE_SUDO_ACCESS="$?"
  fi

  if [ "$HAVE_SUDO_ACCESS" -ne 0 ]; then
    exit_error "Need sudo access in order to continue. Run with sudo or run interactively as an administrator."
  else
    # keep sudo alive during the rest of this script
    if [ -z "${KEEP_SUDO_ALIVE-}" ]; then
        while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
        KEEP_SUDO_ALIVE=$!
    fi
  fi
}

invalidate_sudo() {
    if [ -x ${SUDO-} ]; then
        if ${SUDO} -n -v 2>/dev/null; then
            ${SUDO} -k
        fi
    fi
}

cleanup() {
    invalidate_sudo
}

exit_error() {
    cleanup
    log_error "$@"
    exit 1
}

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        exit_error "Unable to find $1 which is necessary to continue the installation."
    fi
}

# Only run commands via run function such that we can intercept if needed

run() {
    ${@};
}

# Start installing dotfiles

cd "`dirname "$0"`"

# Installing Homebrew

log_info "Checking Homebrew installation..."

BASH=/usr/bin/bash
CURL=/usr/bin/curl
install_homebrew() {
    check_command "$BASH" &&
    check_command "$CURL" &&
    get_sudo_access &&
    run $BASH -c "`$CURL -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`";
}

if ! BREW=`command -v brew`; then
    log_info "No Homebrew installation found. Installing Homebrew... This may require your password."
    if ! install_homebrew; then
        exit_error "Failed to install Homebrew."
    else
        if ! BREW=`command -v brew`; then
            exit_error "Something unexpected happened while installing Homebrew. Please check Homebrew installation."
        fi
        log_info "Ready to brew!"
    fi
else
    log_info "Updating Homebrew..."
    
    if ! run $BREW update --quiet; then
        exit_error "Failed to update Homebrew."
    else
        log_info "Ready to brew!"
    fi
fi

# Installing dependencies

log_info "Installing dependencies using brew bundle..."

export HOMEBREW_CASK_OPTS="--no-quarantine"
if ! run $BREW bundle --no-lock; then
    exit_error "Failed to install dependencies."
else
    log_info "Succesfully installed dependencies."
fi

# Install tmux terminfo

check_tic() {
    if ! TIC=`command -v /usr/bin/tic`; then
        log_warn "Unable to find tic. Skipping installation of tmux terminfo."
        false; return
    fi
}

check_gunzip() {
    if ! GUNZIP=`command -v /usr/bin/gunzip`; then
        log_warn "Unable to find gunzip. Skipping installation of tmux terminfo."
        false; return
    fi
}

check_curl_warn() {
    if ! CURL=`command -v /usr/bin/curl`; then
        log_warn "Unable to find curl. Skipping installation of tmux terminfo."
        false; return
    fi
}

check_infocmp() {
    INFOCMP=`command -v /usr/bin/infocmp`
}

compile_tmux_256color() {
    log_info "Checking terminfo description for tmux."
    if check_infocmp && $INFOCMP tmux-256color >/dev/null 2>&1; then
        return
    fi
    log_info "Compiling terminfo description for tmux."
    if check_tic && check_curl && check_gunzip; then
        run $CURL -LO -o ${PREFIX}/terminfo.src.gz https://invisible-island.net/datafiles/current/terminfo.src.gz &&
        run $GUNZIP terminfo.src.gz &&
        run $TIC -xe tmux-256color ${PREFIX}/terminfo.src
        run rm ${PREFIX}/terminfo.src
    fi
}

compile_tmux_256color

# Linking dotfiles

log_info "Linking dotfiles..."

DATE=`date '+%Y-%m-%d'`
PREFIX=`pwd`

link_dotfile() {
    FULL_PATH="${HOME}/${2}"
    if [ -e "$FULL_PATH" ]; then
        if [ ! -L "$FULL_PATH" ]; then
            if ! run mv "$FULL_PATH" "${FULL_PATH}.backup.${DATE}"; then
                log_warn "Path $FULL_PATH does already exist and cannot be moved."
                false; return
            fi
        fi
    fi
    if [ -L "$FULL_PATH" ]; then
        if ! unlink "$FULL_PATH"; then
            log_warn "Failed to unlink current symbolic link ${FULL_PATH}."
            false; return
        fi
    fi
    run mkdir -p `dirname "$FULL_PATH"` && run ln -s "${PREFIX}/${1}" "$FULL_PATH"
    if [ $? -ne 0 ]; then
        log_warn "Failed to link ${PREFIX}/${1} to ${FULL_PATH}.";
        false; return
    fi
}

link_dotfile "zsh/zshrc" ".zshrc"
link_dotfile "vim/vimrc" ".vimrc"
link_dotfile "nvim" ".config/nvim"
link_dotfile "tmux.conf" ".tmux.conf"

log_info "Installing iTerm2 preferences..."

install_iterm_preferences() {
    if ! [ -e "${HOME}/Library/Preferences/com.googlecode.iterm2.plist" ]; then
        cp "${PREFIX}/iterm2/com.googlecode.iterm2.plist" "${HOME}/Library/Preferences/"
    fi &&
    defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "${PREFIX}/iterm2" &&
    defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
}

if ! install_iterm_preferences; then
    log_warm "Failed to install iTerm2 preferences."
fi

log_info "Installation successful."
