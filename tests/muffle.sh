#!/usr/bin/env bash

bgen:import ../lib/butl/muffle.sh

test_muffle_does_not_print_stderr_if_command_does_not_fail() {
    local command="echo errors >&2; echo hello; echo more errors >&2;"
    local stdout="hello"

    assert_exits_with --code=0 --stderr="" --stdout="$stdout" butl.muffle bash -c "$command"
}

test_muffle_prints_to_stderr_if_command_fails() {
    local command="echo this is cheese; echo this is an error >&2; exit 42"
    local stdout="this is cheese"
    local stderr="this is an error"

    assert_exits_with --code=42 --stderr="$stderr" --stdout="$stdout" butl.muffle bash -c "$command"
}

test_silence_does_not_print_anything_if_command_does_not_fail() {
    local command="echo errors >&2; echo hello; echo more errors >&2;"

    unset VERBOSE
    assert_exits_with --code=0 --stderr="" --stdout="" butl.silence bash -c "$command"
}

test_silence_only_prints_stderr_if_command_fails() {
    local command="echo this is cheese; echo this is an error >&2; exit 42"
    local stderr="this is an error"

    unset VERBOSE
    assert_exits_with --code=42 --stderr="$stderr" --stdout="" butl.silence bash -c "$command"
}

test_silence_prints_stdout_if_command_does_not_fail_and_verbose_is_set() {
    local command="echo errors >&2; echo hello; echo more errors >&2;"
    local stdout="hello"

    export VERBOSE=1
    assert_exits_with --code=0 --stderr="" --stdout="$stdout" butl.silence bash -c "$command"
}

test_silence_prints_stdout_and_stderr_if_command_fails_and_verbose_is_set() {
    local command="echo this is cheese; echo this is an error >&2; exit 42"
    local stdout="this is cheese"
    local stderr="this is an error"

    export VERBOSE=1
    assert_exits_with --code=42 --stderr="$stderr" --stdout="$stdout" butl.silence bash -c "$command"
}
