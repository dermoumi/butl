#!/usr/bin/env bash

bgen:import log

# Waits for a shell function N seconds, and sends SIGTERM to it if it hasn't finished yet
# @param timeout:  Duration to wait for
# @param command:  Command to execute
# @param args...?:  Arguments to pass to the command
butl.timeout() {
    # shellcheck disable=SC2034
    local timeout=$1
    shift

    (
        "$@" &
        local child=$!

        trap : TERM INT

        # Workaround shfmt minifier omitting the '&' at the end of the subshell
        local timeout_pid
        eval '(
            trap "exit 0" TERM INT
            sleep "$timeout" &
            wait
            butl.fail "Command timed out: $*" || true
            kill "$child" 2>/dev/null
        ) &
        timeout_pid=$!'

        wait "$child"
        local err=$?
        kill "$timeout_pid" 2>/dev/null || true
        exit "$err"
    )
}
