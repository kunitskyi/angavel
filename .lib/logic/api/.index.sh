#!/bin/bash

##
#
# MODULE LIBRARY LOGIC API Index File
#
#######

function MODULE-LIBRARY-LOGIC-API-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib/logic/api"

    source $LOCAL_PWD/project/.index.sh
    source $LOCAL_PWD/start.sh
    source $LOCAL_PWD/stop.sh

}

MODULE-LIBRARY-LOGIC-API-INDEX
