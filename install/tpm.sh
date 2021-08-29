#!/bin/sh

if [ -z ${DOTFILES_DIRECTORY} ]; then
    cd "`dirname "$0"`/../"
    export DOTFILES_DIRECTORY=`pwd`
fi
if [ -z ${ARGUMENTS-} ]; then
    export ARGUMENTS="$@"
fi
. install/functions.sh

install_tmux_plugin_manager() {
    if ! GIT=`command -v git`; then
        log_warn "Unable to find git needed to install tmux plugin manager."
    else
        if ! [ -d ~/.tmux/plugins/tpm ] && ! run $GIT clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; then
            log_warn "Failed to install tmux plugin manager"
        fi
    fi
}

install_tmux_plugins() {
    if ! run $TMUX new -d ~/.tmux/plugins/tpm/bin/install_plugins; then
        log_warn "Failed to install tmux plugins."
    fi
}

update_tmux_plugins() {
    if ! run $TMUX new -d ~/.tmux/plugins/tpm/bin/install_plugins; then
        log_warn "Failed to update tmux plugins."
    fi
}

if TMUX=`command -v tmux`; then

    log_info "Installing tmux plugin manager..."

    install_tmux_plugin_manager

    log_info "Installing tmux plugins..."

    install_tmux_plugins

    log_info "Updating tmux plugins..."

    update_tmux_plugins

fi
