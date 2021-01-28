#!/usr/bin/env bash

butl.strip_ansi_style() {
    if shopt -qs extglob; then
        local keep_extglob=1
    fi

    shopt -s extglob
    echo "${1//\\@(e|x1[bB])\[[0-9]?([0-9])*([;:]?([0-9]?([0-9])))[m]/}"

    if ! ((keep_extglob)); then
        shopt -u extglob
    fi
}

butl.strip_ansi() {
    if shopt -qs extglob; then
        local keep_extglob=1
    fi

    shopt -s extglob
    echo "${1//\\@(e|x1[bB])\[[0-9]?([0-9])*([;:]?([0-9]?([0-9])))[ABCDEFGHJKSTfmin]/}"

    if ! ((keep_extglob)); then
        shopt -u extglob
    fi
}
