#!/bin/bash

##
#
# MODULE LIBRARY LOGIC PROJECT Index File
#
#######

function MODULE-LIBRARY-LOGIC-PROJECT-INDEX {
    
    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/lib/logic/project"
    
    source $LOCAL_PWD/internal.sh
    # source $LOCAL_PWD/srp.sh
    # source $LOCAL_PWD/api.sh
    source $LOCAL_PWD/spa.sh
    
}

MODULE-LIBRARY-LOGIC-PROJECT-INDEX