#!/usr/bin/env bash

bgen:import ../lib/butl/vars.sh

test_is_declared_fails_when_variable_is_declared_without_value() {
    # shellcheck disable=SC2034
    local var

    assert_exits_with --code 1 --stdout= --stderr= butl.is_declared var
}

test_is_declared_does_not_fail_when_variable_is_string() {
    # shellcheck disable=SC2034
    local var="test_var"

    assert_exits_with --code 0 --stdout= --stderr= butl.is_declared var
}

test_is_declared_does_not_fail_when_variable_is_empty_string() {
    # shellcheck disable=SC2034
    local var=

    assert_exits_with --code 0 --stdout= --stderr= butl.is_declared var
}

test_is_declared_does_not_fail_when_variable_is_array() {
    # shellcheck disable=SC2034
    local var=("item1" "item2")

    assert_exits_with --code 0 --stdout= --stderr= butl.is_declared var
}

test_is_declared_does_not_fail_when_variable_is_empty_array() {
    # shellcheck disable=SC2034
    local var=()

    assert_exits_with --code 0 --stdout= --stderr= butl.is_declared var
}

test_is_declared_fails_when_variable_is_not_declared() {
    unset var

    assert_exits_with --code 1 --stdout= --stderr= butl.is_declared var
}

test_set_var_sets_variable() {
    # shellcheck disable=SC2178
    local my_var=

    butl.set_var my_var "hello"
    assert_eq "hello" "$my_var"
}

test_set_var_sets_global_variable() {
    unset my_var

    butl.set_var my_var "hello"
    assert_eq "hello" "$my_var"
}

test_is_false_does_not_fail_when_value_is_falsy() {
    local value
    for value in 0 f false off False OFF no n; do
        assert_exits_with --code 0 --stdout= --stderr= butl.is_false "$value"
    done
}

test_is_false_fails_when_value_is_not_falsy() {
    local value
    for value in 1 42 t true on ON True Y yes any_other_value; do
        assert_exits_with --code 1 --stdout= --stderr= butl.is_false "$value"
    done
}

test_is_true_does_not_fail_when_value_is_truthy() {
    local value
    for value in 1 42 t true on ON True Y yes any_other_value; do
        assert_exits_with --code 0 --stdout= --stderr= butl.is_true "$value"
    done
}

test_is_true_fails_when_value_is_not_truthy() {
    local value
    for value in 0 f false off False OFF no n; do
        assert_exits_with --code 1 --stdout= --stderr= butl.is_true "$value"
    done
}
