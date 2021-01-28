#!/usr/bin/env bash

# Colors o/
if ((${NO_COLOR:-})); then
    export BUTL_ANSI_RESET=

    export BUTL_ANSI_BOLD=
    export BUTL_ANSI_DIM=
    export BUTL_ANSI_UNDERLINE=

    export BUTL_ANSI_RESET_UNDERLINE=

    export BUTL_ANSI_BLACK=
    export BUTL_ANSI_RED=
    export BUTL_ANSI_GREEN=
    export BUTL_ANSI_YELLOW=
    export BUTL_ANSI_BLUE=
    export BUTL_ANSI_MAGENTA=
    export BUTL_ANSI_CYAN=
    export BUTL_ANSI_WHITE=

    export BUTL_ANSI_BRBLACK=
else
    export BUTL_ANSI_RESET="\e[0m"

    export BUTL_ANSI_BOLD="\e[1m"
    export BUTL_ANSI_DIM="\e[2m"
    export BUTL_ANSI_UNDERLINE="\e[4m"

    export BUTL_ANSI_RESET_UNDERLINE="\e[24m"

    export BUTL_ANSI_BLACK="\e[30m"
    export BUTL_ANSI_RED="\e[31m"
    export BUTL_ANSI_GREEN="\e[32m"
    export BUTL_ANSI_YELLOW="\e[33m"
    export BUTL_ANSI_BLUE="\e[34m"
    export BUTL_ANSI_MAGENTA="\e[35m"
    export BUTL_ANSI_CYAN="\e[36m"
    export BUTL_ANSI_WHITE="\e[37m"

    export BUTL_ANSI_BRBLACK="\e[90m"
fi
