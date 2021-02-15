#!/usr/bin/env bash

# BGEN__SHEBANG_REMOVED

# Formats tab separated stdin entries as columns
# @param out_separator:  String to separate the output with (default: '  ')
# @param in_separator:  Single character to separate the input with (defualt '<tab>')
butl.columns() {
    local out_separator=${1:-"  "}
    local in_separator=${2:-$'\t'}

    if column -o "$out_separator" -s "$in_separator" -t -L 2>/dev/null; then
        return
    fi

    # parse manually
    local column_widths=()
    local lines=()
    local cell

    # for each column find the longest cell
    while IFS= read -r line; do
        if [[ "$line" ]]; then
            local i=0
            while IFS= read -r cell; do
                local cell_width
                cell_width="${#cell}"
                if ((cell_width > column_widths[i])); then
                    column_widths[$i]="$cell_width"
                fi
                i=$((i + 1))
            done <<<"${line//$in_separator/$'\n'}"
        fi

        lines+=("$line")
    done

    # generate a printf string such as it can print each cells at a given width
    local printf_query
    printf_query=$(printf -- "%%-%ss$out_separator" "${column_widths[@]::$((${#column_widths[@]} - 1))}")
    printf_query+="%s"

    for line in "${lines[@]-}"; do
        local cells=()

        if [[ ! "$line" ]]; then
            # Replicating column behaviour
            for cell in "${column_widths[@]}"; do
                cells+=("")
            done
        else
            while IFS= read -r cell; do
                cells+=("$cell")
            done <<<"${line//$in_separator/$'\n'}"
        fi

        # shellcheck disable=SC2059
        printf "$printf_query\n" "${cells[@]}"
    done
}
