#!/bin/sh

##
# -------------------------------------
# Site Manager for Nginx / 2024       #
# Script made by Kunitskyi Vladyslav  #
# For WISENT AngaVel module           #
# -------------------------------------
#######

ARG_1="$1"
ARG_2="$2"
ARG_3="$3"

GLOBAL_SITES_AVAILABLE_PATH="/etc/nginx/sites-available"
GLOBAL_SITES_ENABLED_PATH="/etc/nginx/sites-enabled"
declare -A ACTION_PREFIX_FORMAT_CODE
ACTION_PREFIX_FORMAT_CODE=(
    ["ENABLE"]="\033[33m"
    ["RENEW"]="\033[34m"
    ["DISABLE"]="\033[35m"
)

function site-manager@center-text {
    local TEXT="$1"
    local PATTERN=${2:-" "}
    local STYLE=${3:-"0"}
    local WIDTH=$(tput cols)
    local PADDING_WIDTH=$((WIDTH - ${#TEXT}))
    local PADDING=""
    
    if [ ${#PATTERN} -le 0 ]
    then
        site-manager@throw-error 1002 "(center-text) Set wrong PATTERN!"
    fi
    
    for ((i = 0; i < PADDING_WIDTH / (${#PATTERN}*2) ; i++))
    do
        PADDING+="${PATTERN}"
    done
    
    echo -e "\033[${STYLE}m${PADDING}${TEXT}${PADDING}\033[0m"
}

function site-manager@header {
    clear
    site-manager@center-text " Site Manager for Nginx " "|" "1;32"
}

function site-manager@custom-read {
    echo -e "\033[3m(For \033[1mexit\033[0m\033[3m, just type so...)\033[0m"
    echo -en "\033[1m \033[0m\033[1;32m:\033[0m\033[1m \033[0m "
    read -r "$1"
    
    if [ "${!1}" = "exit" ] || [ "${!1}" = "q" ]
    then
        echo -e "\033[1;36mScript made by Kunitskyi Vladyslav\033[0m"
        echo -e "\033[1;36mExiting...\033[0m"
        exit 1
    elif [ "${!1}" = "menu" ] || [ "${!1}" = "main" ] || [ "${!1}" = "m" ]
    then
        site-manager:entrypoint
    fi
}

function site-manager@show-items-list {
    
    local ITEMS_ARRAY="$1"
    local -n ITEMS_ARRAY_REF="$ITEMS_ARRAY"
    
    local DESCRIPTION_ARRAY="$2"
    local -n DESCRIPTION_ARRAY_REF="$DESCRIPTION_ARRAY"
    
    local i=1
    
    for ITEM in "${ITEMS_ARRAY_REF[@]}"
    do
        echo -e "$((i++))) - ${DESCRIPTION_ARRAY_REF[$ITEM]}"
    done
}

function site-manager@throw-error {
    local CODE=$1
    local TEXT=$2
    echo -e "\033[1;31mError[$CODE]| $TEXT\033[0m"
    exit $CODE
}

function site-manager@stop {
    echo -en "To continue press \033[1;34mENTER\033[0m\033[3m (Or type - \033[1mstop\033[0m\033[3m, to return in Main Menu) \033[0m"
    read -r USER_INPUT
    
    if [ "$USER_INPUT" = "stop" ]
    then
        site-manager:selector:main
    elif [ "$USER_INPUT" != "" ]
    then
        @stop
    fi
}

function site-manager@main {
    
    site-manager:nginx:_reload
    
    site-manager@stop
    
    site-manager:selector:main
    
}

function site-manager@action-selector {
    
    local ACTIONS_ARRAY="$1"
    local DESCRIPTION_ARRAY="$2"
    local REPEAT="$3"
    
    local -n ACTIONS_ARRAY_REF="$ACTIONS_ARRAY"
    
    echo -e "\033[1mSelect action:\033[0m \033[1;2;3;32m(Enter action number)\033[0m"
    
    site-manager@show-items-list  ACTIONS_ARRAY_REF $DESCRIPTION_ARRAY
    
    site-manager@custom-read USER_INPUT
    
    if [ "$USER_INPUT" -ge 1 ] && [ "$USER_INPUT" -le "${#ACTIONS_ARRAY_REF[@]}" ]
    then
        "${ACTIONS_ARRAY_REF[$USER_INPUT-1]}"
    else
        "${REPEAT}"
    fi
    
}

function site-manager:_file-selector {
    
    # Initialization
    
    local DIRECTORY="$1"
    
    local ACTION_NAME="$2"
    if [ $ACTION_NAME != "ENABLE" ] && [ $ACTION_NAME != "DISABLE" ]
    then
        site-manager@throw-error 55 "site-manager@file-selector: Unknown action name!"
    fi
    
    local REPEAT="$3"
    
    local FILES_ARRAY=($(ls "${DIRECTORY}/"))
    declare -A DESCRIPTION
    for ITEM in "${FILES_ARRAY[@]}"
    do
        DESCRIPTION+=(
            ["${ITEM}"]="$ITEM"
        )
    done
    
    # Adding LAST point
    
    FILES_ARRAY+=("site-manager:selector:main")
    
    DESCRIPTION+=(
        ["site-manager:selector:main"]="\033[1;3;32mGo Back\033[0m"
    )
    
    echo -e "\033[1mSelect config to ${ACTION_PREFIX_FORMAT_CODE[$ACTION_NAME]}${ACTION_NAME}:\033[0m \033[1;2;3;32m(Enter file number)\033[0m"
    
    site-manager@show-items-list FILES_ARRAY DESCRIPTION
    
    site-manager@custom-read USER_INPUT
    
    if [ "$USER_INPUT" -ge 1 ] && [ "$USER_INPUT" -le "${#FILES_ARRAY[@]}" ]
    then
        if [ "${FILES_ARRAY[$USER_INPUT-1]}" = "site-manager:selector:main" ] # IF user select LAST point then execute it
        then
            "${FILES_ARRAY[$USER_INPUT-1]}"
        else
            if [ $ACTION_NAME = "ENABLE" ] # IF this enabling command
            then
                site-manager:site:_enable "${FILES_ARRAY[$USER_INPUT-1]}"
                
                site-manager@main
            elif [ $ACTION_NAME = "DISABLE" ] # IF this disabling command
            then
                site-manager:site:_disable "${FILES_ARRAY[$USER_INPUT-1]}"
                
                site-manager@main
            else
                "${REPEAT}"
            fi
        fi
    else
        "${REPEAT}"
    fi
}

function site-manager:nginx:_reload {
    
    systemctl reload nginx
    
}

function site-manager:site:_enable {
    local CONF_FILE_NAME=$1
    
    cp -fr \
    "${GLOBAL_SITES_AVAILABLE_PATH}/${CONF_FILE_NAME}" \
    "${GLOBAL_SITES_ENABLED_PATH}/${CONF_FILE_NAME}"
    
}

function site-manager:site:_enable-all-from {
    
    local ENABLED_FILES_ARRAY="$1"
    local -n ITEMS_ARRAY_REF="$ENABLED_FILES_ARRAY"
    
    for ONE_ENABLED_FILE in "${ITEMS_ARRAY_REF[@]}"
    do
        site-manager:site:_enable $ONE_ENABLED_FILE
    done
    
}

function site-manager:site:_enable-all {
    
    local AVAILABLE_FILES=($(ls $GLOBAL_SITES_AVAILABLE_PATH/))
    
    site-manager:site:_enable-all-from AVAILABLE_FILES
    
}

function site-manager:site:_renew {
    
    site-manager:site:_enable $1
    
}

function site-manager:site:_renew-all {
    
    local ENABLED_FILES=($(ls $GLOBAL_SITES_ENABLED_PATH/))
    
    site-manager:site:_enable-all-from ENABLED_FILES
    
}

function site-manager:site:_disable {
    
    local CONF_FILE_NAME=$1
    
    rm -fI $GLOBAL_SITES_ENABLED_PATH}/$CONF_FILE_NAME
    
}

function site-manager:site:_disable-all {
    
    echo -e "\033[1;31mDELETING ALL FILES FROM:\033[0m"
    echo -e "\033[1m${GLOBAL_SITES_ENABLED_PATH}/\033[0m"
    
    rm -fI $GLOBAL_SITES_ENABLED_PATH/*
    
}

function site-manager:selector:enable {
    
    site-manager@header
    
    site-manager:_file-selector $GLOBAL_SITES_AVAILABLE_PATH ENABLE site-manager:selector:enable
    
}

function site-manager:selector:renew {
    
    site-manager@header
    
    site-manager:_file-selector $GLOBAL_SITES_AVAILABLE_PATH ENABLE site-manager:selector:enable
    
}

function site-manager:selector:disable {
    
    site-manager@header
    
    site-manager:_file-selector $GLOBAL_SITES_ENABLED_PATH DISABLE site-manager:selector:disable
    
}

function site-manager:selector:enable-all {
    
    site-manager:site:_enable-all
    
    site-manager@main
    
}

function site-manager:selector:renew-all {
    
    site-manager:site:_disable-all
    
    site-manager:site:_renew-all
    
    site-manager@main
    
}

function site-manager:selector:disable-all {
    
    site-manager:site:_disable-all
    
    site-manager@main
    
}

function site-manager:selector:main {
    
    site-manager@header
    local ACTIONS=(
        "site-manager:selector:enable-all"
        "site-manager:selector:renew-all"
        "site-manager:selector:enable"
        "site-manager:selector:disable"
        "site-manager:selector:disable-all"
    )
    
    declare -A ACTION_DESCRIPTION
    ACTION_DESCRIPTION=(
        ["site-manager:selector:enable-all"]="\033[1;3m${ACTION_PREFIX_FORMAT_CODE["ENABLE"]}Enable\033[0m \033[1mALL SITES\033[0m"
        ["site-manager:selector:renew-all"]="\033[1;3m${ACTION_PREFIX_FORMAT_CODE["RENEW"]}Renew\033[0m \033[1mALL SITES\033[0m"
        ["site-manager:selector:enable"]="Select Site to \033[1;3m${ACTION_PREFIX_FORMAT_CODE["ENABLE"]}(Enable\033[37m \\ ${ACTION_PREFIX_FORMAT_CODE["RENEW"]}Renew)\033[0m"
        ["site-manager:selector:disable"]="Select Site to \033[1;3m${ACTION_PREFIX_FORMAT_CODE["DISABLE"]}Disable\033[0m"
        ["site-manager:selector:disable-all"]="\033[1;3m${ACTION_PREFIX_FORMAT_CODE["DISABLE"]}Disable\033[0m \033[1mALL SITES\033[0m"
    )
    
    site-manager@action-selector ACTIONS ACTION_DESCRIPTION site-manager:selector:main
    
}

function site-manager:entrypoint {
    site-manager:selector:main
}

if [ $ARG_1 = "ENABLE" ] 
then
    site-manager:site:_enable $ARG_2
    site-manager:nginx:_reload
elif [ $ARG_1 = "RENEW" ] 
then
    site-manager:site:_renew $ARG_2
    site-manager:nginx:_reload
elif [ $ARG_1 = "DISABLE" ] 
then
    site-manager:site:_disable $ARG_2
    site-manager:nginx:_reload
elif [ $ARG_1 = "ENABLE-ALL" ] 
then
    site-manager:site:_enable-all
    site-manager:nginx:_reload
elif [ $ARG_1 = "RENEW-ALL" ] 
then
    site-manager:site:_renew-all
    site-manager:nginx:_reload
elif [ $ARG_1 = "DISABLE-ALL" ] 
then
    site-manager:site:_disable-all
    site-manager:nginx:_reload
fi

site-manager:entrypoint
