#!/bin/sh

# check script arguments

print_usage() {
    printf >&2 "\n"
    printf >&2 "usage: %s [-v]\n" "$0" 1>&2
    printf >&2 "\n"
    printf >&2 "%-5s: log all intermediate steps\n" "v"
}

illegal_option() {
    printf >&2 "%s: illegal option -- %c\n" "$0" "$1" 1>&2
    print_usage
    exit 1
}

option_requires_argument() {
    printf "%s: option requires an argument -- %c\n" "$0" "$1" 1>&2
    print_usage
    exit 1
}

check_arguments() {
    unset VERBOSE

    while getopts ":v" opt ${ARGUMENTS}; do
        case $opt in
            v) VERBOSE=1;;
            \?) illegal_option "$OPTARG";;
            :) option_requires_argument "$OPTARG";;
        esac
    done
}

check_arguments

# logging

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

# sudo

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

# exit error

cleanup() {
    invalidate_sudo
}

exit_error() {
    cleanup
    log_error "$@"
    exit 1
}

# run

if [ -z ${VERBOSE-} ]; then
    run() {
        ${@} >/dev/null 2>&1
    }
else
    run() {
        ${@};
    }
fi

# check command

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        exit_error "Unable to find $1 which is necessary to continue the installation."
    fi
}
