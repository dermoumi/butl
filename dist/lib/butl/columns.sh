#!/usr/bin/env bash

butl.columns(){
local out_separator=${1:-"  "}
local in_separator=${2:-$'\t'}
if column -o "$out_separator" -s "$in_separator" -t -L 2>/dev/null;then
return
fi
local column_widths=()
local lines=()
local cell
while IFS= read -r line;do
if [[ "$line" ]];then
local i=0
while IFS= read -r cell;do
local cell_width
cell_width="${#cell}"
if ((cell_width>column_widths[i]));then
column_widths[$i]="$cell_width"
fi
i=$((i+1))
done <<<"${line//$in_separator/$'\n'}"
fi
lines+=("$line")
done
local printf_query
printf_query=$(printf -- "%%-%ss$out_separator" "${column_widths[@]::$((${#column_widths[@]}-1))}")
printf_query+="%s"
for line in "${lines[@]-}";do
local cells=()
if [[ ! $line ]];then
for cell in "${column_widths[@]}";do
cells+=("")
done
else
while IFS= read -r cell;do
cells+=("$cell")
done <<<"${line//$in_separator/$'\n'}"
fi
printf "$printf_query\n" "${cells[@]}"
done
}
