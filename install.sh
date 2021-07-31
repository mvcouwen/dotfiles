#!/bin/sh

print_usage() {
    printf "\n"
    printf "usage: %s [-q] [-d directory] [-r remote]\n" "$0" 1>&2
    printf "\n"
    printf "%-12s: mute all intermediate steps\n" "q"
    printf "%-12s: set installation directory\n" "d directory"
    printf "%-12s: set remote repository\n" "r remote"
}

illegal_option() {
    printf "%s: illegal option -- %c\n" "$0" "$1" 1>&2
    print_usage
    exit 1
}

option_requires_argument() {
    printf "%s: option requires an argument -- %c\n" "$0" "$1" 1>&2
    print_usage
    exit 1
}

unset FORCE_UPDATE
unset QUIET
unset PREFIX
unset REMOTE

while getopts ":fqd:r:" opt; do
    case $opt in
        f) FORCE_UPDATE="--force";;
        q) QUIET=1;;
        d) PREFIX=$OPTARG;;
        r) REMOTE=$OPTARG;;
        \?) illegal_option "$OPTARG";;
        :) option_requires_argument "$OPTARG";;
    esac
done

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

unset HAVE_SUDO_ACCESS
unset KEEP_SUDO_ALIVE
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

if [ -z ${QUIET-} ]; then
    run() {
        ${@};
    }
else
    run() {
        ${@} >/dev/null 2>&1
    }
fi

check_bash() {
    if ! BASH=`command -v bash`; then
        exit_error 'Unable to find bash which is necessary to continue the installation.'
    fi
}

check_curl() {
    if ! CURL=`command -v curl`; then
        exit_error 'Unable to find curl which is necessary to continue the installation.'
    fi
}

install_homebrew() {
    check_bash &&
    check_curl &&
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
        fi
        log_info "Succesfully upgraded $@."
    else
        if ! run $BREW install $@; then
            log_warn "Failed to install $@. Run \"brew install $@\" to find out what goes wrong."
        fi
        log_info "Succesfully installed $@."
    fi
}

#install_or_upgrade --cask alfred
#install_or_upgrade --cask font-hack-nerd-font
#install_or_upgrade git
#install_or_upgrade gnupg
#install_or_upgrade htop
#install_or_upgrade --cask iterm2
#install_or_upgrade jq
#install_or_upgrade neovim
#install_or_upgrade node
#install_or_upgrade python
#install_or_upgrade --cask rectangle
#install_or_upgrade tmux
#install_or_upgrade zsh


log_info "Downloading dotfiles... This may require your GitHub password."

check_git() {
    if ! GIT=`command -v /usr/local/bin/git`; then
        if ! GIT=`command -v git`; then
            exit_error "Unable to find git which is necessary to continue the installation."
        fi
    fi
}

if [ -z ${PREFIX-} ]; then
    PREFIX="$HOME/.dotfiles"
fi

if [ -z ${REMOTE-} ]; then
    REMOTE="https://git@github.com/mvcouwen/dotfiles.git"
fi

update_dotfiles() {
    run $GIT "-C $PREFIX" init "-q"
    run $GIT "-C $PREFIX" config remote.origin.url "$REMOTE" &&
    run $GIT "-C $PREFIX" config remote.origin.fetch "refs/heads/*:refs/remotes/origin/*" &&
    run $GIT "-C $PREFIX" fetch $FORCE_UPDATE origin &&
    if ! [ -z $FORCE_UPDATE ]; then
        run $GIT "-C $PREFIX" reset "--hard" "--recurse-submodules" origin/master
    else
        if ! [ -z "`$GIT -C $PREFIX status --porcelain`" ]; then
            log_warn "Failed to update dotfiles. The working directory is not clean."
            return
        fi
        run $GIT "-C $PREFIX" checkout "-t" origin/master &&
        run $GIT "-C $PREFIX" pull "--ff-only" "--recurse-submodules"
    fi
}

install_dotfiles() {
    if ! [ -d $PREFIX ]; then
        if ! ( run mkdir -p $PREFIX && run $GIT clone --recurse-submodules ${REMOTE} ${PREFIX} ); then
            exit_error "Something went wrong while initializing dotfiles local repository. Check if $PREFIX is a valid installation directory."
        fi
    else
        if ! update_dotfiles; then
            log_warn "Failed to update dotfiles."
        fi
    fi
}

install_dotfiles

log_info "Linking dotfiles..."

DATE=`date '+%Y-%m-%d'`

link_dotfile() {
    FULL_PATH="${HOME}/${2}"
    if [ -e "$FULL_PATH" ]; then
        if [ ! -L "$FULL_PATH" ]; then
            if ! run mv "$FULL_PATH" "${FULL_PATH}.backup.${DATE}"; then
                log_warn "$FULL_PATH does already exist and cannot be moved."
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
link_dotfile "vim/init.vim" ".config/nvim/init.vim"
link_dotfile "vim/coc-settings.json" ".config/coc-settings.json"
link_dotfile "tmux.conf" ".tmux.conf"

log_info "Installing vim-plug..."

check_curl
if ! run $CURL -fLo '~/.vim/autoload/plug.vim' --create-dirs \
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >/dev/null 2>&1
then
    exit_error "Failed to install vim-plug."
fi

check_nvim() {
    if ! NVIM=`command -v /usr/local/bin/nvim`; then
        log_warn "Unable to find neovim installation. Skipping the installation of vim plugins."
        false
        return
    fi
}

log_info "Installing vim plugins..."

if check_nvim; then
    run $NVIM -c ":PlugInstall"
fi
#run nvim +'PlugInstall --sync' +qa
#run nvim +'CocInstall' +qa
#run nvim +'so http://www.drchip.org/astronaut/vim/vbafiles/amsmath.vba.gz'


#setup_github() {
#    read -p "GitHub username: " GIT_USER 
#    read -p "GitHub name: " GIT_NAME
#    read -p "GitHub e-mail: " GIT_EMAIL
#}
#
#read -p "Do you wish to set up GitHub credentials [yN]? " yn
#case $yn in
#    [yY]*) setup_github;;
#esac

##!/bin/zsh
#
#run() {
#    printf "%s..." $2
#    $1
#    printf "done%n"
#}
#
#####################
## Install Homebrew #
#####################
#
#echo "Installing Homebrew..."
#
##/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#brew bundle --file="$(pwd)/Brewfile"
#
#####################
## Install vim-plug #
#####################
#
#echo "Installing vim-plug..."
#
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#
#############
## Dotfiles #
#############
#
#echo "Linking dotfiles..."
#
#cd $(dirname $0)
#local date=$(date +%Y%m%d)
#
#declare -A dotfiles
#dotfiles=(
#    [~/.zshrc]="$(pwd)/zsh/zshrc"
#    [~/.vimrc]="$(pwd)/vim/vimrc"
#    [~/.config/nvim/init.vim]="$(pwd)/vim/init.vim"
#    [~/.config/nvim/coc-settings.json]="$(pwd)/vim/coc-settings.json"
#)
#
#for key val in ${(@kv)dotfiles}; do
#    [ -e $key ] && [ ! -L $key ] && mv $key ${key}.backup.${date}
#    [ -L $key ] && unlink $key
#    mkdir -p $(dirname $key)
#    ln -s $val $key
#done
#
########################
## Install vim plugins #
########################
#
#echo "Installing vim plugins..."
#nvim +'PlugInstall --sync' +qa
#nvim +'CocInstall' +qa
#nvim +'so http://www.drchip.org/astronaut/vim/vbafiles/amsmath.vba.gz'

