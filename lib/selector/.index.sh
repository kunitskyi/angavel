#!/bin/bash

##
#
# LIBRARY SELECTOR File
#
#######

function LIBRARY-SELECTOR-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/lib/selector"

    source $LOCAL_PWD/descriptions.sh
    source $LOCAL_PWD/list.sh
    source $LOCAL_PWD/shortcut.sh
    source $LOCAL_PWD/tags.sh

}

LIBRARY-SELECTOR-INDEX
