#!/usr/bin/env bash

# BGEN__SHEBANG_REMOVED

# BGEN__BEGIN /home/sdrm/projects/butl/lib/butl/log.sh
# BGEN__SHEBANG_REMOVED

# BGEN__ALREADY_IMPORTED /home/sdrm/projects/butl/lib/butl/ansi.sh

__butl.init_log_vars() {
    : "${BUTL_STYLE_EMERGENCY:="${BUTL_ANSI_BOLD}${BUTL_ANSI_INVERT}${BUTL_ANSI_BG_BRWHITE}${BUTL_ANSI_RED}"}"
    : "${BUTL_STYLE_ALERT:="${BUTL_ANSI_BOLD}${BUTL_ANSI_INVERT}${BUTL_ANSI_RED}"}"
    : "${BUTL_STYLE_CRITICAL:="${BUTL_ANSI_BOLD}${BUTL_ANSI_RED}"}"
    : "${BUTL_STYLE_ERROR:="${BUTL_ANSI_RED}"}"
    : "${BUTL_STYLE_PRIMARY:="${BUTL_ANSI_BOLD}${BUTL_ANSI_BRCYAN}"}"
    : "${BUTL_STYLE_WARNING:="${BUTL_ANSI_YELLOW}"}"
    : "${BUTL_STYLE_SECONDARY:="${BUTL_ANSI_BOLD}${BUTL_ANSI_BRYELLOW}"}"
    : "${BUTL_STYLE_NOTICE:="${BUTL_ANSI_GREEN}"}"
    : "${BUTL_STYLE_INFO:="${BUTL_ANSI_DEFAULT}"}"
    : "${BUTL_STYLE_DEBUG:="${BUTL_ANSI_BRBLACK}"}"

    if [[ ! "${LOG_LEVEL:-}" ]]; then
        if [[ "${LOGLEVEL:-}" ]]; then
            export LOG_LEVEL=$LOGLEVEL
        elif ((${VERBOSE:-})); then
            export LOG_LEVEL=7
        else
            export LOG_LEVEL=6
        fi
    fi
}
__butl.init_log_vars

# Prints stylized text
# @param style:  Style to use
# @param message...:  Text to echo
butl.echo_stylized() {
    local style=$1
    shift
    printf -- '%b\n' "${style}${*//\\e\[0m/$BUTL_ANSI_RESET$style}${BUTL_ANSI_RESET}"
}

# Prints emergency message
# @param message....: Message to print
butl.log_emergency() {
    butl.echo_stylized "$BUTL_STYLE_EMERGENCY" "$@" >&2
}

# Prints alert message when LOG_LEVEL >= 1
# @param message....: Message to print
butl.log_alert() {
    if ((LOG_LEVEL >= 1)); then
        butl.echo_stylized "$BUTL_STYLE_ALERT" "$@" >&2
    fi
}

# Prints critical message when LOG_LEVEL >= 2
# @param message....: Message to print
butl.log_critical() {
    if ((LOG_LEVEL >= 2)); then
        butl.echo_stylized "$BUTL_STYLE_CRITICAL" "$@" >&2
    fi
}

# Prints error message when LOG_LEVEL >= 3
# @param message....: Message to print
butl.log_error() {
    if ((LOG_LEVEL >= 3)); then
        butl.echo_stylized "$BUTL_STYLE_ERROR" "$@" >&2
    fi
}

# Prints primary message when LOG_LEVEL >= 4
# @param message....: Message to print
butl.log_primary() {
    if ((LOG_LEVEL >= 4)); then
        butl.echo_stylized "$BUTL_STYLE_PRIMARY" "$@" >&2
    fi
}

# Prints warning message when LOG_LEVEL >= 4
# @param message....: Message to print
butl.log_warning() {
    if ((LOG_LEVEL >= 4)); then
        butl.echo_stylized "$BUTL_STYLE_WARNING" "$@" >&2
    fi
}

# Prints secondary message when LOG_LEVEL >= 5
# @param message....: Message to print
butl.log_secondary() {
    if ((LOG_LEVEL >= 5)); then
        butl.echo_stylized "$BUTL_STYLE_SECONDARY" "$@" >&2
    fi
}

# Prints notice message when LOG_LEVEL >= 5
# @param message....: Message to print
butl.log_notice() {
    if ((LOG_LEVEL >= 5)); then
        butl.echo_stylized "$BUTL_STYLE_NOTICE" "$@" >&2
    fi
}

# Prints info message when LOG_LEVEL >= j6
# @param message....: Message to print
butl.log_info() {
    if ((LOG_LEVEL >= 6)); then
        butl.echo_stylized "$BUTL_STYLE_INFO" "$@" >&2
    fi
}

# Prints debug message when LOG_LEVEL >= 7 (or if VERBOSE is set)
# @param message....: Message to print
butl.log_debug() {
    if ((LOG_LEVEL >= 7)); then
        butl.echo_stylized "$BUTL_STYLE_DEBUG" "$@" >&2
    fi
}

# Prints an error and returns and exit code
# @param message:  Message text
# @param exit_code?:  Code to return, defaults to 1
butl.fail() {
    butl.log_error "$1"
    return "${2:-1}"
}

# Prints a critical message and exits program with an exist code
# @param message:  Message text
# @param exit_code?:  Code to return, defaults to 1
butl.die() {
    butl.log_critical "$1"
    exit "${2:-1}"
}
# BGEN__END /home/sdrm/projects/butl/lib/butl/log.sh

# Waits for a shell function N seconds, and sends SIGTERM to it if it hasn't finished yet
# @param timeout:  Duration to wait for
# @param command:  Command to execute
# @param args...?:  Arguments to pass to the command
butl.timeout() {
    # shellcheck disable=SC2034
    local timeout=$1
    shift

    (
        "$@" &
        local child=$!

        trap : TERM INT

        # Workaround shfmt minifier omitting the '&' at the end of the subshell
        local timeout_pid
        eval '(
            trap "exit 0" TERM INT
            sleep "$timeout" &
            wait
            butl.fail "Command timed out: $*" || true
            kill "$child" 2>/dev/null
        ) &
        timeout_pid=$!'

        wait "$child"
        local err=$?
        kill "$timeout_pid" 2>/dev/null || true
        exit "$err"
    )
}
