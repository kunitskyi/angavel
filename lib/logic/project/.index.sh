#!/bin/bash

##
#
# MODULE LIBRARY LOGIC PROJECT Index File
#
#######

function MODULE-LIBRARY-LOGIC-PROJECT-INDEX {
    
    local LOCAL_PWD="${GLOBAL_MODULE_PWD}/lib/logic/project"
    
    source $LOCAL_PWD/internal.sh
    source $LOCAL_PWD/init.sh
    source $LOCAL_PWD/project.sh
    source $LOCAL_PWD/start.sh
    source $LOCAL_PWD/stop.sh
    
}

MODULE-LIBRARY-LOGIC-PROJECT-INDEX