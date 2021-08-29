#!/bin/sh

if [ -z ${DOTFILES_DIRECTORY} ]; then
    cd "`dirname "$0"`/../"
    export DOTFILES_DIRECTORY=`pwd`
fi
if [ -z ${ARGUMENTS-} ]; then
    export ARGUMENTS="$@"
fi
. install/functions.sh &&
. install/brew.sh &&
. install/link.sh &&
. install/tpm.sh

log_info "Installation successful."
