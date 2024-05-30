#!/bin/bash

##
#
# LIBRARY CONFIG SELECTOR File
#
#######

function LIBRARY-CONFIG-SELECTOR-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib/config/.selector"

    source $LOCAL_PWD/descriptions.sh
    source $LOCAL_PWD/list.sh
    source $LOCAL_PWD/shortcut.sh
    source $LOCAL_PWD/tags.sh

}

LIBRARY-CONFIG-SELECTOR-INDEX
