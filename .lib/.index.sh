#!/bin/bash

##
#
# MODULE LIBRARY Index File
#
#######

function MODULE-LIBRARY-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib"

    source $LOCAL_PWD/config/.selector/.index.sh
    source $LOCAL_PWD/logic/.index.sh
    source $LOCAL_PWD/core/.index.sh

}

MODULE-LIBRARY-INDEX
