#!/usr/bin/env bash

# Only outputs stderr if command fails
# @param command: command to run
# @param args...: arguments to pass to the command
butl.muffle() {
    local err=0
    exec 3>&1
    stderr=$("$@" 2>&1 1>&3) || err=$?
    exec 3>&-

    if ((err)); then
        echo "$stderr" >&2
    fi

    return "$err"
}

# Only output to stdout if VERBOSE is set
# Only output to stderr if command fails
# @param command: command to run
# @param args...: argumets to pass to the command
butl.silence() {
    # TODO: Add log level to check
    if ((${VERBOSE:-})); then
        butl.muffle "$@"
    else
        butl.muffle "$@" >/dev/null
    fi
}
