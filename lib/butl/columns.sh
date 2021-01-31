#!/usr/bin/env bash

# Formats tab separated stdin entries as columns
butl.columns() {
    local out_separator=${1:-  }
    local input_separator=${2:-$'\t'}

    if column -o "$out_separator" -s "$input_separator" -t -L 2>/dev/null; then
        return
    fi

    # parse manually
    local column_widths=()
    local lines=()
    local cell
    local cell_width

    # for each column find the longest cell
    while IFS= read -r line; do
        if [[ "$line" ]]; then
            local i=0
            while IFS= read -r cell; do
                cell_width="${#cell}"
                if ((cell_width > column_widths[i])); then
                    column_widths[$i]="$cell_width"
                fi
                i=$((i + 1))
            done <<<"${line//$'\t'/$'\n'}"
        fi

        lines+=("$line")
    done

    # generate a printf string such as it can print each cells at a given width
    local printf_query
    printf_query=$(printf -- "$out_separator%%-%ss" "${column_widths[@]::$((${#column_widths[@]} - 1))}")
    printf_query+="$out_separator%s"

    for line in "${lines[@]-}"; do
        if [[ ! "$line" ]]; then
            echo
            continue
        fi

        cells=()
        while IFS= read -r cell; do
            cells+=("$cell")
        done <<<"${line//$input_separator/$'\n'}"

        local out
        # shellcheck disable=SC2059
        printf "${printf_query#$out_separator}\n" "${cells[@]}"
    done
}
