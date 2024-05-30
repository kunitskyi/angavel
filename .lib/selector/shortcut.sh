#!/bin/bash

##
#
# SHORTCUT
#
#######

declare -gA GLOBAL_SHORTCUTS

GLOBAL_SHORTCUTS=(
    ["m"]="angavel:selector:main"
    ["main"]="angavel:selector:main"
    ["menu"]="angavel:selector:main"

    ["pc"]="angavel:selector:project-control"
    ["project-control"]="angavel:selector:project-control"

    ["d"]="angavel:selector:docker"
    ["docker"]="angavel:selector:docker"

    ["c"]="angavel:selector:docker-composition"
    ["composition"]="angavel:selector:docker-composition"

    ["bu"]="angavel:selector:backups"
    ["backups"]="angavel:selector:backups"

    ["git"]="angavel:selector:git"
)
