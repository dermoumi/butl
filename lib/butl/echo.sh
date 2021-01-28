#!/bin/bash

bgen:import ansi

# Prints stylized text
# @param message... text to echo
butl.echo_title() {
    printf '%b%b=> %b%b\n' "$BUTL_ANSI_BOLD" "$BUTL_ANSI_CYAN" "$*" "$BUTL_ANSI_RESET"
}

# Prints stylized text
# @param message... text to echo
butl.echo_success() {
    printf '%b=> %b%b\n' "$BUTL_ANSI_GREEN" "$*" "$BUTL_ANSI_RESET"
}

# Prints stylized text
# @param message... text to echo
butl.echo_warning() {
    printf '%b%b%b\n' "$BUTL_ANSI_YELLOW" "$*" "$BUTL_ANSI_RESET"
}

# Prints stylized text
# @param message... text to echo
butl.echo_err() {
    printf '%b%b%b\n' "$BUTL_ANSI_RED" "$*" "$BUTL_ANSI_RESET" >&2
}

# Prints an error and returns with an exit code
# @param message    text to echo
# @param exit_code? code to return, defaults to 1
butl.fail() {
    butl.echo_err "$1"
    return "${2:-1}"
}

# Prints an error and exits program with an exist code
# @param message    text to echo
# @param exit_code? code to return, defaults to 1
butl.die() {
    butl.echo_err "$1"
    exit "${2:-1}"
}
