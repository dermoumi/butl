#!/usr/bin/env bash

bgen:import ../lib/butl/columns.sh

test_columns_uses_column_bin_if_available() {
    local columns_called=0
    column() {
        columns_called=1
    }

    assert_eq 0 "$columns_called"

    butl.columns <<<"lorem ipsum dolor sit amet"
    assert_eq 1 "$columns_called"
}

test_columns_build_columns_output_correctly() {
    unset column
    unset -f column

    local input=$'money\tobsession\n'
    input+=$'unhealthy\tneglect\tof\tlife\n'
    input+=$'better\tto\tlive\tnow'

    local expected_output=$'money      obsession        \n'
    expected_output+=$'unhealthy  neglect    of    life\n'
    expected_output+=$'better     to         live  now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns <<<"$input"
}

test_columns_preserves_empty_lines() {
    unset column
    unset -f column

    local input=$'money\tobsession\n\n' # double \n here
    input+=$'unhealthy\tneglect\tof\tlife\n'
    input+=$'better\tto\tlive\tnow'

    local expected_output=$'money      obsession        \n'
    expected_output+=$'                            \n'
    expected_output+=$'unhealthy  neglect    of    life\n'
    expected_output+=$'better     to         live  now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns <<<"$input"
}

test_columns_can_choose_input_separator() {
    unset column
    unset -f column

    local input=$'money;obsession\n'
    input+=$'unhealthy;neglect;of;life\n'
    input+=$'better;to;live;now'

    local expected_output=$'money      obsession        \n'
    expected_output+=$'unhealthy  neglect    of    life\n'
    expected_output+=$'better     to         live  now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns '  ' ";" <<<"$input"
}

test_columns_can_choose_output_separator() {
    unset column
    unset -f column

    local input=$'money\tobsession\n'
    input+=$'unhealthy\tneglect\tof\tlife\n'
    input+=$'better\tto\tlive\tnow'

    local expected_output=$'money    -obsession-    -\n'
    expected_output+=$'unhealthy-neglect  -of  -life\n'
    expected_output+=$'better   -to       -live-now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns '-' <<<"$input"
}

test_columns_falls_back_to_bash_implementation_if_columns_fails() {
    column() {
        return 127
    }
    assert_exits_with --code 127 column

    local input=$'money\tobsession\n'
    input+=$'unhealthy\tneglect\tof\tlife\n'
    input+=$'better\tto\tlive\tnow'

    local expected_output=$'money      obsession        \n'
    expected_output+=$'unhealthy  neglect    of    life\n'
    expected_output+=$'better     to         live  now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns <<<"$input"
}

test_columns_fallback_preserves_empty_lines() {
    column() {
        return 127
    }
    assert_exits_with --code 127 column

    local input=$'money\tobsession\n\n' # double \n here
    input+=$'unhealthy\tneglect\tof\tlife\n'
    input+=$'better\tto\tlive\tnow'

    local expected_output=$'money      obsession        \n'
    expected_output+=$'                            \n'
    expected_output+=$'unhealthy  neglect    of    life\n'
    expected_output+=$'better     to         live  now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns <<<"$input"
}

test_columns_fallback_can_choose_input_separator() {
    column() {
        return 127
    }
    assert_exits_with --code 127 column

    local input=$'money;obsession\n'
    input+=$'unhealthy;neglect;of;life\n'
    input+=$'better;to;live;now'

    local expected_output=$'money      obsession        \n'
    expected_output+=$'unhealthy  neglect    of    life\n'
    expected_output+=$'better     to         live  now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns '  ' ";" <<<"$input"
}

test_columns_fallback_can_choose_output_separator() {
    column() {
        return 127
    }
    assert_exits_with --code 127 column

    local input=$'money\tobsession\n'
    input+=$'unhealthy\tneglect\tof\tlife\n'
    input+=$'better\tto\tlive\tnow'

    local expected_output=$'money    -obsession-    -\n'
    expected_output+=$'unhealthy-neglect  -of  -life\n'
    expected_output+=$'better   -to       -live-now'

    assert_exits_with --code 0 --stdout="$expected_output" --stderr="" butl.columns '-' <<<"$input"
}
