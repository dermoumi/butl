#!/usr/bin/env bash

# Formats tab separated stdin entries as columns
butl.columns() {
    local separator=${1:-  }

    if column -o "$separator" -s $'\t' -t -L 2>/dev/null; then
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
    printf_query=$(printf -- "$separator%%-%ss" "${column_widths[@]}")
    for line in "${lines[@]-}"; do
        if [[ ! "$line" ]]; then
            echo
            continue
        fi

        cells=()
        while IFS= read -r cell; do
            cells+=("$cell")
        done <<<"${line//$'\t'/$'\n'}"
        # shellcheck disable=SC2059
        printf "${printf_query/$separator/}\n" "${cells[@]}"
    done
}
