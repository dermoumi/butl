#!/usr/bin/env bash

__butl.init_ansi_vars(){
if ((${NO_COLOR:-}));then
export BUTL_ANSI_RESET=
export BUTL_ANSI_BOLD=
export BUTL_ANSI_DIM=
export BUTL_ANSI_UNDERLINE=
export BUTL_ANSI_BLINK=
export BUTL_ANSI_INVERT=
export BUTL_ANSI_HIDDEN=
export BUTL_ANSI_RESET_BOLD=
export BUTL_ANSI_RESET_DIM=
export BUTL_ANSI_RESET_UNDERLINE=
export BUTL_ANSI_RESET_BLINK=
export BUTL_ANSI_RESET_INVERT=
export BUTL_ANSI_RESET_HIDDEN=
export BUTL_ANSI_DEFAULT=
export BUTL_ANSI_BLACK=
export BUTL_ANSI_RED=
export BUTL_ANSI_GREEN=
export BUTL_ANSI_YELLOW=
export BUTL_ANSI_BLUE=
export BUTL_ANSI_MAGENTA=
export BUTL_ANSI_CYAN=
export BUTL_ANSI_WHITE=
export BUTL_ANSI_BRBLACK=
export BUTL_ANSI_BRRED=
export BUTL_ANSI_BRGREEN=
export BUTL_ANSI_BRYELLOW=
export BUTL_ANSI_BRBLUE=
export BUTL_ANSI_BRMAGENTA=
export BUTL_ANSI_BRCYAN=
export BUTL_ANSI_BRWHITE=
export BUTL_ANSI_BG_DEFAULT=
export BUTL_ANSI_BG_BLACK=
export BUTL_ANSI_BG_RED=
export BUTL_ANSI_BG_GREEN=
export BUTL_ANSI_BG_YELLOW=
export BUTL_ANSI_BG_BLUE=
export BUTL_ANSI_BG_MAGENTA=
export BUTL_ANSI_BG_CYAN=
export BUTL_ANSI_BG_WHITE=
export BUTL_ANSI_BG_BRBLACK=
export BUTL_ANSI_BG_BRRED=
export BUTL_ANSI_BG_BRGREEN=
export BUTL_ANSI_BG_BRYELLOW=
export BUTL_ANSI_BG_BRBLUE=
export BUTL_ANSI_BG_BRMAGENTA=
export BUTL_ANSI_BG_BRCYAN=
export BUTL_ANSI_BG_BRWHITE=
else
export BUTL_ANSI_RESET="\e[0m"
export BUTL_ANSI_BOLD="\e[1m"
export BUTL_ANSI_DIM="\e[2m"
export BUTL_ANSI_UNDERLINE="\e[4m"
export BUTL_ANSI_BLINK="\e[5m"
export BUTL_ANSI_INVERT="\e[7m"
export BUTL_ANSI_HIDDEN="\e[8m"
export BUTL_ANSI_RESET_BOLD="\e[21m"
export BUTL_ANSI_RESET_DIM="\e[22m"
export BUTL_ANSI_RESET_UNDERLINE="\e[24m"
export BUTL_ANSI_RESET_BLINK="\e[25m"
export BUTL_ANSI_RESET_INVERT="\e[27m"
export BUTL_ANSI_RESET_HIDDEN="\e[28m"
export BUTL_ANSI_DEFAULT="\e[39m"
export BUTL_ANSI_BLACK="\e[30m"
export BUTL_ANSI_RED="\e[31m"
export BUTL_ANSI_GREEN="\e[32m"
export BUTL_ANSI_YELLOW="\e[33m"
export BUTL_ANSI_BLUE="\e[34m"
export BUTL_ANSI_MAGENTA="\e[35m"
export BUTL_ANSI_CYAN="\e[36m"
export BUTL_ANSI_WHITE="\e[37m"
export BUTL_ANSI_BRBLACK="\e[90m"
export BUTL_ANSI_BRRED="\e[91m"
export BUTL_ANSI_BRGREEN="\e[92m"
export BUTL_ANSI_BRYELLOW="\e[93m"
export BUTL_ANSI_BRBLUE="\e[94m"
export BUTL_ANSI_BRMAGENTA="\e[95m"
export BUTL_ANSI_BRCYAN="\e[96m"
export BUTL_ANSI_BRWHITE="\e[97m"
export BUTL_ANSI_BG_BLACK="\e[40m"
export BUTL_ANSI_BG_RED="\e[41m"
export BUTL_ANSI_BG_GREEN="\e[42m"
export BUTL_ANSI_BG_YELLOW="\e[43m"
export BUTL_ANSI_BG_BLUE="\e[44m"
export BUTL_ANSI_BG_MAGENTA="\e[45m"
export BUTL_ANSI_BG_CYAN="\e[46m"
export BUTL_ANSI_BG_WHITE="\e[47m"
export BUTL_ANSI_BG_BRBLACK="\e[100m"
export BUTL_ANSI_BG_BRRED="\e[101m"
export BUTL_ANSI_BG_BRGREEN="\e[102m"
export BUTL_ANSI_BG_BRYELLOW="\e[103m"
export BUTL_ANSI_BG_BRBLUE="\e[104m"
export BUTL_ANSI_BG_BRMAGENTA="\e[105m"
export BUTL_ANSI_BG_BRCYAN="\e[106m"
export BUTL_ANSI_BG_BRWHITE="\e[107m"
fi
}
__butl.init_ansi_vars
__butl.init_log_vars(){
: "${BUTL_STYLE_EMERGENCY:="$BUTL_ANSI_BOLD$BUTL_ANSI_BG_RED$BUTL_ANSI_BRWHITE"}"
: "${BUTL_STYLE_ALERT:="$BUTL_ANSI_BOLD$BUTL_ANSI_BG_RED$BUTL_ANSI_BLACK"}"
: "${BUTL_STYLE_CRITICAL:="$BUTL_ANSI_BOLD$BUTL_ANSI_RED"}"
: "${BUTL_STYLE_ERROR:="$BUTL_ANSI_RED"}"
: "${BUTL_STYLE_PRIMARY:="$BUTL_ANSI_BOLD$BUTL_ANSI_BRCYAN"}"
: "${BUTL_STYLE_WARNING:="$BUTL_ANSI_YELLOW"}"
: "${BUTL_STYLE_SECONDARY:="$BUTL_ANSI_BOLD$BUTL_ANSI_BRYELLOW"}"
: "${BUTL_STYLE_NOTICE:="$BUTL_ANSI_GREEN"}"
: "${BUTL_STYLE_INFO:="$BUTL_ANSI_DEFAULT"}"
: "${BUTL_STYLE_DEBUG:="$BUTL_ANSI_BRBLACK"}"
if [[ ! ${LOG_LEVEL:-} ]];then
if ((${VERBOSE:-}));then
export LOG_LEVEL=7
else
export LOG_LEVEL=6
fi
fi
}
__butl.init_log_vars
butl.echo_stylized(){
local style=$1
shift
printf '%b\n' "$style${*//\\e\[0m/$BUTL_ANSI_RESET$style}$BUTL_ANSI_RESET"
}
butl.log_emergency(){
butl.echo_stylized "$BUTL_STYLE_EMERGENCY" "$@" >&2
}
butl.log_alert(){
if ((LOG_LEVEL>=1));then
butl.echo_stylized "$BUTL_STYLE_ALERT" "$@" >&2
fi
}
butl.log_critical(){
if ((LOG_LEVEL>=2));then
butl.echo_stylized "$BUTL_STYLE_CRITICAL" "$@" >&2
fi
}
butl.log_error(){
if ((LOG_LEVEL>=3));then
butl.echo_stylized "$BUTL_STYLE_ERROR" "$@" >&2
fi
}
butl.log_primary(){
if ((LOG_LEVEL>=4));then
butl.echo_stylized "$BUTL_STYLE_PRIMARY" "$@" >&2
fi
}
butl.log_warning(){
if ((LOG_LEVEL>=4));then
butl.echo_stylized "$BUTL_STYLE_WARNING" "$@" >&2
fi
}
butl.log_secondary(){
if ((LOG_LEVEL>=5));then
butl.echo_stylized "$BUTL_STYLE_SECONDARY" "$@" >&2
fi
}
butl.log_notice(){
if ((LOG_LEVEL>=5));then
butl.echo_stylized "$BUTL_STYLE_NOTICE" "$@" >&2
fi
}
butl.log_info(){
if ((LOG_LEVEL>=6));then
butl.echo_stylized "$BUTL_STYLE_INFO" "$@" >&2
fi
}
butl.log_debug(){
if ((LOG_LEVEL>=7));then
butl.echo_stylized "$BUTL_STYLE_DEBUG" "$@" >&2
fi
}
butl.fail(){
butl.log_error "$1"
return "${2:-1}"
}
butl.die(){
butl.log_critical "$1"
exit "${2:-1}"
}
