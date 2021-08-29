#!/bin/sh

if [ -z ${DOTFILES_DIRECTORY} ]; then
    cd "`dirname "$0"`/../"
    export DOTFILES_DIRECTORY=`pwd`
fi
if [ -z ${ARGUMENTS-} ]; then
    export ARGUMENTS="$@"
fi
. install/functions.sh

BASH=/usr/bin/bash
CURL=/usr/bin/curl
install_homebrew() {
    check_command "$BASH" &&
    check_command "$CURL" &&
    get_sudo_access &&
    run $BASH -c "`$CURL -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`";
}

log_info "Checking Homebrew installation..."

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
    
    if ! run $BREW update; then
        exit_error "Failed to update Homebrew."
    else
        log_info "Ready to brew!"
    fi
fi

log_info "Installing dependencies..."

brew_tap() {
    if ! run $BREW tap $@; then
        log_warn "Failed to tap $@. Run \"brew upgrade $@\" to find out what goes wrong."
    fi
}

brew_tap homebrew/cask-fonts
brew_tap homebrew/cask

install_or_upgrade() {
    if run $BREW ls --version $@ >/dev/null; then
        if ! run $BREW upgrade $@; then
            log_warn "Failed to upgrade $@. Run \"brew upgrade $@\" to find out what goes wrong."
        else
            log_info "Succesfully upgraded $@."
        fi
    else
        if ! run $BREW install $@; then
            log_warn "Failed to install $@. Run \"brew install $@\" to find out what goes wrong."
        else
            log_info "Succesfully installed $@."
        fi
    fi
}

install_or_upgrade --cask alfred
install_or_upgrade --cask font-hack-nerd-font
install_or_upgrade fzf
install_or_upgrade git
install_or_upgrade gnupg
install_or_upgrade htop
install_or_upgrade --cask iterm2
install_or_upgrade jq
install_or_upgrade neovim
install_or_upgrade node
install_or_upgrade python
install_or_upgrade --cask rectangle
install_or_upgrade tmux
install_or_upgrade zsh

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
