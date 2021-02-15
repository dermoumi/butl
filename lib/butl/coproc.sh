#!/usr/bin/env bash

bgen:import arrays.sh

butl.co_run() {
    # shellcheck disable=SC2034
    local __butl_output_var=$1
    shift

    local __butl_cmd
    local __butl_pid
    local __butl_pids=()
    local __butl_stdout
    local __butl_stderr
    local __butl_stdouts=()
    local __butl_stderrs=()

    for __butl_cmd in "$@"; do
        __butl_stdout=$(mktemp)
        __butl_stderr=$(mktemp)
        __butl_stdouts+=("$__butl_stdout")
        __butl_stderrs+=("$__butl_stderr")

        (eval "$__butl_cmd" >"$__butl_stdout" 2>"$__butl_stderr") &
        __butl_pids+=("$!")
    done

    local __butl_err=0
    local __butl_i=0

    local __butl_output=()
    for __butl_pid in "${__butl_pids[@]}"; do
        wait "$__butl_pid" || __butl_err=$?

        __butl_stdout=${__butl_stdouts[$__butl_i]}
        __butl_stderr=${__butl_stderrs[$__butl_i]}

        __butl_output+=("$(<"$__butl_stdout")")

        if ((__butl_err)); then
            cat "$__butl_stderr" >&2
        fi

        rm -f "$__butl_stdout" "$__butl_stderr"

        ((__butl_i = __butl_i + 1))
    done

    butl.copy_array __butl_output "$__butl_output_var"
    return "$__butl_err"
}
