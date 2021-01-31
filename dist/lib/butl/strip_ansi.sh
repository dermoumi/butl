#!/usr/bin/env bash

butl.strip_ansi_style(){
local keep_extglob=0
if shopt -qp extglob;then
keep_extglob=1
fi
if (($#));then
local input=$1
else
local input
read -d "" -r input||true
fi
shopt -s extglob
echo "${input//\\@(e|x1[bB])\[[0-9]?([0-9])*([;:]?([0-9]?([0-9])))[m]/}"
if ! ((keep_extglob));then
shopt -u extglob
fi
}
butl.strip_ansi(){
local keep_extglob=0
if shopt -qp extglob;then
keep_extglob=1
fi
if (($#));then
local input=$1
else
local input
read -d "" -r input||true
fi
shopt -s extglob
echo "${input//\\@(e|x1[bB])\[[0-9]?([0-9])*([;:]?([0-9]?([0-9])))[ABCDEFGHJKSTfmin]/}"
if ! ((keep_extglob));then
shopt -u extglob
fi
}
