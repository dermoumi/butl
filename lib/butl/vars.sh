#!/usr/bin/env bash

# Utility function to check if any of the passed variables is not declared
# @param    variable_name...    names of variables to check
butl.is_declared() {
    declare -p "$@" >/dev/null 2>/dev/null
}

# Utility function to check if the passed variable is an array
butl.is_array() {
    [[ "$(declare -p "$1" 2>/dev/null)" =~ ^"declare -a " ]]
}

# Utility function to check is a variable is false
butl.is_false() {
    [[ "${1,,}" =~ ^(0|f|false|off)?$ ]]
}

# Utility function to check if a variable is true
butl.is_true() {
    ! butl_is_false "$@"
}

# Declares a global variable, compatible with bash 3.2
butl.global_var() {
    # shellcheck disable=SC2059
    printf -v "$1" "$2"
}

# Declares a global array, compatible with bash 3.2
butl.global_array() {
    local var_name=$1
    shift

    if (($#)); then
        eval "$var_name=($(printf '%q ' "$@"))"
    else
        eval "$var_name=()"
    fi
}

# Copies an array to another by name
# @param source the array to copy from
# @param target the array to copy to
butl.copy_array() {
    local source=$1
    local target=$2

    if ! butl.is_array "$source" || eval "((\${#${source}[@]} == 0))"; then
        butl.global_array "$target"
    else
        eval "$target=( \"\${""$source""[@]}\" )"
    fi
}

# Copies an associative array to another by name
# @param source the array to copy from
# @param target the array to copy to
butl.copy_assiciative_array() {
    local source=$1
    local target=$2

    local declare_statement
    declare_statement=$(declare -p "$source" 2>/dev/null)

    if ! [[ "$declare_statement" =~ ^"declare -a " ]] || eval "((\${#${source}[@]} == 0))"; then
        eval "$target=()"
    else
        if ((BASH_VERSINFO[0] < 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4))); then
            # workaround bash <4.4 quoting the content of the variables in declare's output
            local affect_target="'$target="

            # also these versions concat array elements instead of replacing them
            # so we unset existing values before setting new ones
            eval "$(eval "echo ${declare_statement/declare -a $source=\'/$affect_target}")"
        else
            eval "${declare_statement/declare -a $source=/$target=}"
        fi
    fi
}

# Returns the index of the first item among the rest of the items
# returns -1 if the item is not found
butl.array_index_of() {
    local target=$1
    shift

    local i=0
    while (($#)); do
        if [[ "$1" == "$target" ]]; then
            echo $i
            return
        fi

        i=$((i + 1))
        shift
    done

    echo -1
}

# checks if itm is in an array
butl.is_in_array() {
    local target=$1
    shift

    while (($#)); do
        if [[ "$target" == "$1" ]]; then
            return
        fi

        shift
    done

    return 1
}

# Joins argument by a custom delimiter
butl.join_by() {
    if (($# <= 1)); then
        return 0
    fi

    local delimiter=$1
    local first=$2
    shift 2

    printf %s "$first" "${@/#/$delimiter}"
}
