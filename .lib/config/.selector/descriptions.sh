#!/bin/bash

##
#
# DESCRIPTION
#
#######

declare -gA GLOBAL_MODULE_MAIN_DESCRIPTION
GLOBAL_MODULE_MAIN_DESCRIPTION=(
    # -- Selectors & Actions --
    ["angavel:selector:project-control"]="Project Control"
    ["angavel:selector:docker"]="Docker Menu"
    ["angavel:selector:docker-composition"]="Select Composition"
    ["angavel:selector:backups"]="BackUps Manager"
    ["angavel:selector:git"]="Git Manager"
    ["ws:change-environment"]="\033[0;32mChange Environment\033[0m"
    ["ws:change-module"]="\033[0;32mChange Module \033[1m&\033[0;32m Environment\033[0m"

    ["angavel:ssl:cert-get"]="Add/Update SSL certificates"
    ["ws:flash-data"]="Flash Data"
    ["ws:configure-env"]="Environment Files Configuration"
)

declare -gA GLOBAL_MODULE_PROJECT_CONTROL_DESCRIPTION
GLOBAL_MODULE_PROJECT_CONTROL_DESCRIPTION=(
    # -- Project Control --
    ["angavel:project:start"]="Simple Start"
    ["angavel:project:stop"]="Stop Project"
    ["angavel:selector:project-start"]="Start"

    ["angavel:selector:main"]="Main Menu"
)

declare -gA GLOBAL_MODULE_PROJECT_START_DESCRIPTION
GLOBAL_MODULE_PROJECT_START_DESCRIPTION=(
    # -- Start Menu --
    ["angavel:project:start-fresh"]="Fresh Start"
    ["angavel:project:start-refresh"]="Refresh Start"
    ["angavel:project:start"]="Simple Start"

    ["angavel:selector:project-control"]="Go Back"
    ["angavel:selector:main"]="Main Menu"
)

declare -gA GLOBAL_MODULE_DOCKER_DESCRIPTION
GLOBAL_MODULE_DOCKER_DESCRIPTION=(
    # -- Docker Menu --
    ["docker:ps"]="Show Running Containers" # rename docker_action_ps
    ["docker:use-terminal"]="Run Command in Container"
    ["set_network_docker_action"]="Set Docker Network" # [NEW!] add higher level func for docker:set_network
    ["docker:prune"]="Docker Prune"
    ["bundle:install-docker"]="Install Docker"
)

declare -gA GLOBAL_MODULE_BACKUPS_DESCRIPTION
GLOBAL_MODULE_DOCKER_DESCRIPTION=(
    # -- BackUPs --
    ["angavel@bu:make"]="Make Rude BackUp"
    ["angavel@bu:restore"]="Restore BackUP"
)
