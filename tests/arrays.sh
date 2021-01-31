#!/usr/bin/env bash

bgen:import ../lib/butl/arrays.sh

test_is_array_does_not_fail_when_var_is_array() {
    # shellcheck disable=SC2034
    local array=("item1" "item2" "item3")

    assert_exits_with --code 0 --stdout= --stderr= butl.is_array array
}

test_is_array_does_not_fail_when_var_is_empty_array() {
    # shellcheck disable=SC2034
    local array=()

    assert_exits_with --code 0 --stdout= --stderr= butl.is_array array
}

test_is_array_fails_when_var_is_not_declared() {
    unset not_a_variable

    assert_exits_with --code 1 --stdout= --stderr= butl.is_array not_a_variable
}

test_is_array_fails_when_var_is_not_an_array() {
    # shellcheck disable=SC2034
    local not_an_array="hello there!"

    assert_exits_with --code 1 --stdout= --stderr= butl.is_array not_an_array
}

test_set_array_sets_value_of_array() {
    local array=()
    assert_eq 0 "${#array[@]}"

    butl.set_array array "item1" "item2" "item3"
    assert_eq 3 "${#array[@]}"
    assert_eq "item1" "${array[0]}"
    assert_eq "item2" "${array[1]}"
    assert_eq "item3" "${array[2]}"
}

test_set_array_sets_empty_array_if_no_arguments_are_passed() {
    local array=("item1" "item2" "item3")
    assert_eq 3 "${#array[@]}"

    butl.set_array array
    assert_eq 0 "${#array[@]}"
}

test_set_array_sets_array_with_empty_value_if_empty_value_is_provided() {
    local array=()
    assert_eq 0 "${#array[@]}"

    butl.set_array array ""
    assert_eq 1 "${#array[@]}"
    assert_eq "" "${array[0]}"
}

test_copy_array_copies_array_values_correctly() {
    local source=("a" "bc d" "efg")

    local target=()
    assert_eq 0 "${#target[@]}"

    butl.copy_array source target
    assert_eq 3 "${#target[@]}"
    assert_eq "a" "${target[0]}"
    assert_eq "bc d" "${target[1]}"
    assert_eq "efg" "${target[2]}"
}

test_copy_array_sets_target_to_empty_array_if_source_is_empty() {
    local source=()

    local target=("a" "b" "c")
    assert_eq 3 "${#target[@]}"

    butl.copy_array source target
    assert_eq 0 "${#target[@]}"
}

test_copy_array_fails_if_source_is_not_an_array() {
    # shellcheck disable=SC2178,SC2034
    local source="not an array"
    local target

    assert_exits_with --code 1 --stdout= --stderr= butl.copy_array source target
}

test_copy_associative_array_copies_array_values_correctly() {
    # shellcheck disable=SC2034
    local source=([1]="item1" [42]="item2")

    local target=()
    assert_eq 0 "${#target[@]}"

    butl.copy_associative_array source target
    assert_eq 2 "${#target[@]}"
    assert_eq "item1" "${target[1]}"
    assert_eq "item2" "${target[42]}"
}

test_copy_associative_array_sets_target_to_empty_array_if_source_is_empty() {
    # shellcheck disable=SC2034
    local source=()

    local target=([1]="item1" [42]="item2")
    assert_eq 2 "${#target[@]}"

    butl.copy_associative_array source target
    assert_eq 0 "${#target[@]}"
}

test_copy_associative_array_fails_if_source_is_not_an_array() {
    # shellcheck disable=SC2178,SC2034
    local source="not an array"
    local target

    assert_exits_with --code 1 --stdout= --stderr= butl.copy_associative_array source target
}

test_index_of_succeeds_if_item_exists_in_array() {
    local array=("item1" "item2" "itemS" "item3")

    assert_exits_with --code 0 --stdout= --stderr= butl.index_of "itemS" "${array[@]}"
}

test_index_of_fails_if_item_does_not_exist_in_array() {
    local array=("item1" "item2" "item3")

    assert_exits_with --code 1 --stdout= --stderr= butl.index_of "itemS" "${array[@]}"
}

test_index_of_sets_array_index_if_variable_is_declared() {
    local array=("item1" "item2" "itemS" "item3")

    local array_index=
    assert_eq "" "$array_index"

    butl.index_of "itemS" "${array[@]}"
    assert_eq 2 "$array_index"
}

test_index_of_does_not_set_array_index_if_variable_is_not_declared() {
    local array=("item1" "Item2" "itemS" "item3")

    unset array_index
    assert_exits_with --code 1 declare -p array_index

    butl.index_of "itemS" "${array[@]}"
    assert_exits_with --code 1 declare -p array_index
}

test_join_by_joins_array_items_with_separator() {
    local array=("item1" "item2" "item3")

    assert_exits_with --code 0 --stdout="item1, item2, item3" --stderr= butl.join_by ", " "${array[@]}"
}

test_join_by_outputs_first_element_if_its_the_only_element() {
    local array=("sole_element")

    assert_exits_with --code 0 --stdout="sole_element" --stderr= butl.join_by ", " "${array[@]}"
}

test_join_by_outputs_nothing_of_array_is_empty() {
    assert_exits_with --code=0 --stdout= --stderr= butl.join_by ", "
}

test_split_lines_turns_lines_into_array_elements() {
    local array=()
    assert_eq 0 "${#array[@]}"

    local input=$'item1\nitem2\nitem3'

    butl.split_lines array "$input"
    assert_eq 3 "${#array[@]}"
    assert_eq "item1" "${array[0]}"
    assert_eq "item2" "${array[1]}"
    assert_eq "item3" "${array[2]}"
}

test_split_lines_tunes_stdin_lines_into_array_elements() {
    local array=()
    assert_eq 0 "${#array[@]}"

    local input=$'item1\nitem2\nitem3'

    butl.split_lines array <<<"$input"
    assert_eq 3 "${#array[@]}"
    assert_eq "item1" "${array[0]}"
    assert_eq "item2" "${array[1]}"
    assert_eq "item3" "${array[2]}"
}
