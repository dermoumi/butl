#!/usr/bin/env bash

# BGEN__SHEBANG_REMOVED

# Checks if a variable is declared and is an array
# @param  array_name:  Array to check
butl.is_array() {
    [[ "$(declare -p "$1" 2>/dev/null)" =~ ^"declare -a " ]]
}

# Sets an a array by name
# @param  array_name:  Name of the array
# @param  args...:  Values of the array
butl.set_array() {
    local array_name=$1
    shift

    if (($#)); then
        eval "$array_name=($(printf '%q ' "$@"))"
    else
        eval "$array_name=()"
    fi
}

# Copies an array to another by name
# @param source:  Array to copy from
# @param target:  Array to copy to
# @returns 1 if source
butl.copy_array() {
    if ! butl.is_array "$1"; then
        return 1
    elif eval "((\${#${1}[@]} == 0))"; then
        butl.set_array "$2"
    else
        eval "$2=( \"\${""$1""[@]}\" )"
    fi
}

# Copies an associative array to another by name
# @param source:  Array to copy from
# @param target:  Array to copy to
butl.copy_associative_array() {
    local declare_statement
    declare_statement=$(declare -p "$1" 2>/dev/null)

    if ! [[ "$declare_statement" =~ ^"declare -a " ]]; then
        return 1
    elif eval "((\${#${1}[@]} == 0))"; then
        eval "$2=()"
    else
        if ((BASH_VERSINFO[0] < 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4))); then
            # workaround bash <4.4 quoting the content of the variables in declare's output
            local __butl_affect_target="'$2=" # will fail if $1 == "__butl_affect_target", but what are the odds

            # also these versions concat array elements instead of replacing them
            # so we unset existing values before setting new ones
            eval "$(eval "echo ${declare_statement/declare -a $1=\'/$__butl_affect_target}")"
        else
            eval "${declare_statement/declare -a $1=/$2=}"
        fi
    fi
}

# Finds the index of an element amongs others
# @param target:       Element to find
# @param args...:      Items to search through
# @sets  array_index:  Index of the item in the array
# @returns  0 if the item is found, 1 if not
butl.index_of() {
    local target=$1
    shift

    local i=0
    while (($#)); do
        if [[ "$1" == "$target" ]]; then
            if declare -p array_index >/dev/null 2>/dev/null; then
                array_index=$i
            fi

            return 0
        fi

        i=$((i + 1))
        shift
    done

    return 1
}

# Joins arguments by a custom delimiter
# @param delimiter:  Which delimiter to use
# @param args...:  Items to join
butl.join_by() {
    local delimiter=$1
    if (($# <= 1)); then
        return 0
    fi

    local first=$2
    shift 2

    printf %s "$first" "${@/#/$delimiter}"
}

# Splits a multiline string into an array
# @param array_name:  Array to copy to
# @param args...?: Items to parse. Falls back to stdin if no arguments are found
butl.split_lines() {
    local array_name=$1
    shift

    local lines=()

    if (($#)); then
        local original_IFS=$IFS
        IFS=$'\n'

        # shellcheck disable=SC2068
        for line in $@; do
            lines+=("$line")
        done

        IFS=$original_IFS
    else
        while read -r line; do
            lines+=("$line")
        done
    fi

    butl.copy_array lines "$array_name"
}
