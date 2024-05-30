#!/bin/bash

##
#
# MODULE LIBRARY LOGIC Index File
#
#######

function MODULE-LIBRARY-LOGIC-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib/logic"

    source $LOCAL_PWD/general/.index.sh
    source $LOCAL_PWD/srp/.index.sh
    source $LOCAL_PWD/spa/.index.sh
    source $LOCAL_PWD/api/.index.sh

}

MODULE-LIBRARY-LOGIC-INDEX
