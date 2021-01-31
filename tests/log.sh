#!/usr/bin/env bash

bgen:import ../lib/butl/log.sh
bgen:import ../lib/butl/ansi.sh

test_log_module_does_not_override_config_files_when_imported() {
    export BUTL_STYLE_INFO="$BUTL_ANSI_BRBLACK"
    export BUTL_STYLE_EMERGENCY="not_even_ansi"

    __butl.init_log_vars

    assert_eq "$BUTL_ANSI_BRBLACK" "$BUTL_STYLE_INFO"
    assert_eq "not_even_ansi" "$BUTL_STYLE_EMERGENCY"
}

test_log_module_sets_log_level_to_6_if_verbose_is_not_set_when_imported() {
    unset LOG_LEVEL
    unset VERBOSE

    __butl.init_log_vars

    assert_eq 6 "$LOG_LEVEL"
}

test_log_module_sets_log_level_to_7_if_verbose_is_set_when_imported() {
    unset LOG_LEVEL
    export VERBOSE=1

    __butl.init_log_vars

    assert_eq 7 "$LOG_LEVEL"
}

test_echo_stylized_resets_to_the_given_style() {
    local expected_message
    expected_message=$(printf '%b%s%b%s%b%s%b' \
        "$BUTL_ANSI_BRBLACK" "text" "$BUTL_ANSI_GREEN" "green_text" \
        "$BUTL_ANSI_RESET$BUTL_ANSI_BRBLACK" "more_text" "$BUTL_ANSI_RESET")

    assert_exits_with --code 0 --stdout="$expected_message" --stderr="" \
        butl.echo_stylized "$BUTL_ANSI_BRBLACK" "text${BUTL_ANSI_GREEN}green_text${BUTL_ANSI_RESET}more_text"
}

test_log_emergency_is_visible_not_matter_the_log_level() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_RED" "emergency" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_EMERGENCY=$BUTL_ANSI_RED

    for level in {0..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_emergency "emergency"
    done
}

test_log_alert_is_only_visible_on_log_level_1_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_UNDERLINE" "alert" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_ALERT=$BUTL_ANSI_UNDERLINE

    for level in {0..0}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_alert "alert"
    done

    for level in {1..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_alert "alert"
    done
}

test_log_critical_is_only_visible_on_log_level_2_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BOLD" "critical" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_CRITICAL=$BUTL_ANSI_BOLD

    for level in {0..1}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_critical "critical"
    done

    for level in {2..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_critical "critical"
    done
}

test_log_error_is_only_visible_on_log_level_3_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BLUE" "error" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_ERROR=$BUTL_ANSI_BLUE

    for level in {0..2}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_error "error"
    done

    for level in {3..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_error "error"
    done
}

test_log_primary_is_only_visible_on_log_level_4_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_GREEN" "primary" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_PRIMARY=$BUTL_ANSI_GREEN

    for level in {0..3}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_primary "primary"
    done

    for level in {4..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_primary "primary"
    done
}

test_log_warning_is_only_visible_on_log_level_4_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_YELLOW" "warning" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_WARNING=$BUTL_ANSI_YELLOW

    for level in {0..3}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_warning "warning"
    done

    for level in {4..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_warning "warning"
    done
}

test_log_secondary_is_only_visible_on_log_level_5_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_RED" "secondary" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_SECONDARY=$BUTL_ANSI_BG_RED

    for level in {0..4}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_secondary "secondary"
    done

    for level in {5..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_secondary "secondary"
    done
}

test_log_notice_is_only_visible_on_log_level_5_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_GREEN" "notice" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_NOTICE=$BUTL_ANSI_BG_GREEN

    for level in {0..4}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_notice "notice"
    done

    for level in {5..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_notice "notice"
    done
}

test_log_info_is_only_visible_on_log_level_6_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_BLACK" "info" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_INFO=$BUTL_ANSI_BG_BLACK

    for level in {0..5}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_info "info"
    done

    for level in {6..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_info "info"
    done
}

test_log_debug_is_only_visible_on_log_level_7_and_above() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_BLUE" "debug" "$BUTL_ANSI_RESET")

    export BUTL_STYLE_DEBUG=$BUTL_ANSI_BG_BLUE

    for level in {0..6}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="" butl.log_debug "debug"
    done

    for level in {7..7}; do
        export LOG_LEVEL=$level
        assert_exits_with --code 0 --stdout="" --stderr="$expected_message" butl.log_debug "debug"
    done
}

test_fail_prints_error_message_and_fails_with_given_exit_code() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_YELLOW" "ouch" "$BUTL_ANSI_RESET")

    export LOG_LEVEL=7
    export BUTL_STYLE_ERROR=$BUTL_ANSI_BG_YELLOW

    assert_exits_with --code 42 --stdout="" --stderr="$expected_message" butl.fail ouch 42
}

test_fail_prints_error_message_and_fails_with_1_if_no_code_was_given() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_BLACK" "ouch" "$BUTL_ANSI_RESET")

    export LOG_LEVEL=7
    export BUTL_STYLE_ERROR=$BUTL_ANSI_BG_BLACK

    assert_exits_with --code 1 --stdout="" --stderr="$expected_message" butl.fail ouch
}

test_die_prints_critical_message_and_fails_with_given_exit_code() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_CYAN" "ouch" "$BUTL_ANSI_RESET")

    export LOG_LEVEL=7
    export BUTL_STYLE_CRITICAL=$BUTL_ANSI_BG_CYAN

    assert_exits_with --code 42 --stdout="" --stderr="$expected_message" butl.die ouch 42
}

test_die_prints_critical_message_and_fails_with_1_if_no_code_was_given() {
    local expected_message
    expected_message=$(printf '%b%s%b' "$BUTL_ANSI_BG_MAGENTA" "ouch" "$BUTL_ANSI_RESET")

    export LOG_LEVEL=7
    export BUTL_STYLE_CRITICAL=$BUTL_ANSI_BG_MAGENTA

    assert_exits_with --code 1 --stdout="" --stderr="$expected_message" butl.die ouch
}
