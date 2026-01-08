#!/bin/bash

##
# @Description
#
##
help() {
    echo \
"
Usage:  ./linux.sh $INSTALL_COMMAND { DISTRO } { INSTALLATION_TYPE } 
        ./linux.sh $UPDATE_COMMAND { DISTRO } 
        ./linux.sh $SETUP_COMMAND { DISTRO } { SETUP_TYPE } 

where   INSTALLATION_TYPE := { ${INSTALL_COMMAND_TYPES[*]} }
        DISTRO := { ${AVAILABLE_DISTROS[*]} }
        SETUP_TYPE := { ${SETUP_TYPES[*]} }
"
    exit 1
}
