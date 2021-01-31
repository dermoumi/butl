#!/usr/bin/env bash

butl.muffle(){
local err=0
local stderr
if ((BASH_VERSINFO[0]==4&&BASH_VERSINFO[1]>=2&&BASH_VERSINFO[1]<=3));then
local stderr_file
stderr_file=$(mktemp)
local stdout_file
stdout_file=$(mktemp)
err=$("$@" 1>"$stdout_file" 2>"$stderr_file"||echo $?)||err=$?
if [[ ! $err ]];then
err=0
fi
cat "$stdout_file"
rm "$stdout_file"
stderr=$(<"$stderr_file")
rm "$stderr_file"
else
exec 3>&1
stderr=$("$@" 2>&1 1>&3)||err=$?
exec 3>&-
fi
if ((err));then
echo "$stderr" >&2
fi
return "$err"
}
butl.silence(){
: "${LOG_LEVEL:=6}"
: "${VERBOSE:=0}"
if ((LOG_LEVEL>=7||VERBOSE));then
butl.muffle "$@"
else
butl.muffle "$@" >/dev/null
fi
}
