#!/bin/sh

if [ -z ${DOTFILES_DIRECTORY} ]; then
    cd "`dirname "$0"`/../"
    export DOTFILES_DIRECTORY=`pwd`
fi
if [ -z ${ARGUMENTS-} ]; then
    export ARGUMENTS="$@"
fi
. install/functions.sh

log_info "Linking dotfiles..."

DATE=`date '+%Y-%m-%d'`
PREFIX=`pwd`

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
link_dotfile "vim/coc-settings.json" ".config/nvim/coc-settings.json"
link_dotfile "tmux.conf" ".tmux.conf"
