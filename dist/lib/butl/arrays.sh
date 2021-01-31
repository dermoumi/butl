#!/usr/bin/env bash

butl.is_array(){
[[ "$(declare -p "$1" 2>/dev/null)" =~ ^"declare -a " ]]
}
butl.set_array(){
local array_name=$1
shift
if (($#));then
eval "$array_name=($(printf '%q ' "$@"))"
else
eval "$array_name=()"
fi
}
butl.copy_array(){
if ! butl.is_array "$1";then
return 1
elif eval "((\${#$1[@]} == 0))";then
butl.set_array "$2"
else
eval "$2=( \"\${""$1""[@]}\" )"
fi
}
butl.copy_associative_array(){
local declare_statement
declare_statement=$(declare -p "$1" 2>/dev/null)
if ! [[ $declare_statement =~ ^"declare -a " ]];then
return 1
elif eval "((\${#$1[@]} == 0))";then
eval "$2=()"
else
if ((BASH_VERSINFO[0]<4||(BASH_VERSINFO[0]==4&&BASH_VERSINFO[1]<4)));then
local __butl_affect_target="'$2="
eval "$(eval "echo ${declare_statement/declare -a $1=\'/$__butl_affect_target}")"
else
eval "${declare_statement/declare -a $1=/$2=}"
fi
fi
}
butl.index_of(){
local target=$1
shift
local i=0
while (($#));do
if [[ $1 == "$target" ]];then
if declare -p array_index >/dev/null 2>/dev/null;then
array_index=$i
fi
return 0
fi
i=$((i+1))
shift
done
return 1
}
butl.join_by(){
local delimiter=$1
if (($#<=1));then
return 0
fi
local first=$2
shift 2
printf %s "$first" "${@/#/$delimiter}"
}
butl.split_lines(){
local array_name=$1
shift
local lines=()
if (($#));then
local original_IFS=$IFS
IFS=$'\n'
for line in $@;do
lines+=("$line")
done
IFS=$original_IFS
else
while read -r line;do
lines+=("$line")
done
fi
butl.copy_array lines "$array_name"
}
