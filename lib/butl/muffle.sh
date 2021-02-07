#!/usr/bin/env bash

# Only outputs stderr if command fails
# @param command:  command to run
# @param args...:  arguments to pass to the command
butl.muffle() {
    local err=0
    local stderr

    if ((BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] >= 2 && BASH_VERSINFO[1] <= 3)); then
        # Working around bash 4.2 and 4.3 not returning the correct exit code of subprocesses
        local stderr_file
        stderr_file=$(mktemp)

        local stdout_file
        stdout_file=$(mktemp)

        err=$("${@}" 1>"$stdout_file" 2>"$stderr_file" || echo $?) || err=$?
        if [[ ! "$err" ]]; then
            err=0
        fi

        cat "$stdout_file"
        rm "$stdout_file"

        stderr=$(<"$stderr_file")
        rm "$stderr_file"
    else
        exec 3>&1
        stderr=$("$@" 2>&1 1>&3) || err=$?
        exec 3>&-
    fi

    if ((err)); then
        echo "$stderr" >&2
    fi

    return "$err"
}

# Only outputs if command fails
# @param command:  command to run
# @param args...:  arguments to pass to the command
butl.muffle_all() {
    local err=0
    local stderr

    local stdout_file
    stdout_file=$(mktemp)

    if ((BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] >= 2 && BASH_VERSINFO[1] <= 3)); then
        # Working around bash 4.2 and 4.3 not returning the correct exit code of subprocesses
        local stderr_file
        stderr_file=$(mktemp)

        err=$("${@}" 1>"$stdout_file" 2>"$stderr_file" || echo $?) || err=$?
        if [[ ! "$err" ]]; then
            err=0
        fi

        stderr=$(<"$stderr_file")
        rm "$stderr_file"
    else
        stderr=$("$@" 2>&1 1>"$stdout_file") || err=$?
    fi

    local stdout
    stdout=$(<"$stdout_file")
    rm "$stdout_file"

    if ((err)); then
        if [[ "$stdout" =~ [^[:cntrl:]] ]]; then
            echo "$stdout"
        fi

        if [[ "$stderr" =~ [^[:cntrl:]] ]]; then
            echo "$stderr" >&2
        fi
    fi

    return "$err"
}

# Only output to stdout if LOG_LEVEL >= 1
# Only output to stderr if command fails
# @param command:  command to run
# @param args...:  argumets to pass to the command
butl.silence() {
    : "${LOG_LEVEL:=${LOGLEVEL:-6}}"
    : "${VERBOSE:=0}"

    if ((LOG_LEVEL >= 7 || VERBOSE)); then
        butl.muffle "$@"
    else
        butl.muffle "$@" >/dev/null
    fi
}
