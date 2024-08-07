#!/bin/bash

##
#
# TAGS
#
#######

TAGS_ARRAY=("UNSAFE" "WIP")

declare -gA TAGS_SYNTAX
TAGS_SYNTAX=(
    ["WIP"]="\033[1;33m*WIP*\033[0m"
    ["UNSAFE"]="\033[1;41m[Unsafe!]\033[0m\033[1;32m"
)

declare -gA TAGS_TO_SELECTORS
TAGS_TO_SELECTORS=(
    ["WIP"]="angavel:selector:docker,angavel:selector:docker-composition,angavel:selector:backups,angavel:selector:git"
    ["UNSAFE"]="angavel:selector:docker-composition"
)
