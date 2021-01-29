#!/usr/bin/env bash

test_colors_are_set_when_nocolor_is_off() {
    unset NO_COLOR
    bgen:include ../lib/butl/ansi.sh

    assert_eq "$BUTL_ANSI_RED" "\e[31m"
}

test_colors_are_set_but_empty_when_nocolor_is_on() {
    export NO_COLOR=1
    bgen:include ../lib/butl/ansi.sh

    assert_eq "$BUTL_ANSI_RED" ""
}
