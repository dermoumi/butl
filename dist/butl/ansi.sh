#!/usr/bin/env bash

# BGEN__SHEBANG_REMOVED

__butl.init_ansi_vars() {
    # Colors o/
    if ((${NO_COLOR:-})); then
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
