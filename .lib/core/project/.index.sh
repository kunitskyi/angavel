#!/bin/bash

##
#
# MODULE LIBRARY LOGIC PROJECT Index File
#
#######

function MODULE-LIBRARY-CORE-PROJECT-INDEX {

    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/.lib/core/project"

    source $LOCAL_PWD/initialization.sh
    source $LOCAL_PWD/start.sh
    source $LOCAL_PWD/stop.sh

}

MODULE-LIBRARY-CORE-PROJECT-INDEX
