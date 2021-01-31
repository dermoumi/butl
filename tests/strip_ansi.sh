#!/usr/bin/env bash

bgen:import ../lib/butl/strip_ansi.sh

test_strip_ansi_style_strips_ansi_style_only() {
    local input="\e[32mhello\e[91;m\e[13;1mhello\e[1A"
    local expected_output="hellohello\e[1A"

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.strip_ansi_style "$input"
}

test_strip_ansi_style_restores_extglob_state() {
    shopt -u extglob

    butl.strip_ansi_style ""

    assert_exits_with --code 1 shopt -qp extglob
}

test_strip_ansi_style_keeps_extglob_state() {
    shopt -s extglob

    butl.strip_ansi_style ""

    assert_exits_with --code 0 shopt -qp extglob
}

test_strip_ansi_strips_all_ansi() {
    local input="\e[32mhello\e[91;m\e[13;1mhello\e[1A"
    local expected_output="hellohello"

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.strip_ansi "$input"
}

test_strip_ansi_restores_extglob_state() {
    shopt -u extglob

    butl.strip_ansi ""

    assert_exits_with --code 1 shopt -qp extglob
}

test_strip_ansi_keeps_extglob_state() {
    shopt -s extglob

    butl.strip_ansi ""

    assert_exits_with --code 0 shopt -qp extglob
}

test_strip_ansi_style_accepts_stdin_if_no_args_are_given() {
    local input="\e[32mhello\e[91;m\e[13;1mhello\e[1A"
    local expected_output="hellohello\e[1A"

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.strip_ansi_style <<<"$input"
}

test_strip_ansi_accepts_stdin_if_no_args_are_given() {
    local input="\e[32mhello\e[91;m\e[13;1mhello\e[1A"
    local expected_output="hellohello"

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.strip_ansi <<<"$input"
}
