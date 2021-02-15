#!/usr/bin/env bash

# BGEN__SHEBANG_REMOVED

# Check if the passed variable(s) is declared
# @param variable_name:  Name of variable to check
butl.is_declared() {
    [[ "$(declare -p "$1" 2>/dev/null)" =~ ^"declare -a " ]] || eval "[[ \${$*+x} ]]"
}

# Sets an array by name
# @param variable_name:  Name of the variable
# @param value:  Value of the variable
butl.set_var() {
    printf -v "$1" -- '%s' "$2"
}

# Check if value is false
butl.is_false() {
    if ((BASH_VERSINFO[0] < 4)); then
        local value
        value=$(tr '[:upper:]' '[:lower:]' <<<"$1")
    else
        local value=${1,,}
    fi

    [[ "$value" =~ ^(0|f|n|false|off|no)?$ ]]
}

# Check if value is true
butl.is_true() {
    ! butl.is_false "$@"
}
