#!/usr/bin/env bash

butl.is_declared(){
[[ "$(declare -p "$1" 2>/dev/null)" =~ ^"declare -a " ]]||eval "[[ \${$*+x} ]]"
}
butl.set_var(){
printf -v "$1" "$2"
}
butl.is_false(){
if ((BASH_VERSINFO[0]<4));then
local value
value=$(tr '[:upper:]' '[:lower:]' <<<"$1")
else
local value=${1,,}
fi
[[ $value =~ ^(0|f|n|false|off|no)?$ ]]
}
butl.is_true(){
! butl.is_false "$@"
}
