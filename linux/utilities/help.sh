#!/bin/bash

##
# @Description
# Help command or with error usage
##
help() {
    echo \
"
Usage:  ./linux.sh $INSTALL_COMMAND { DISTRO } { INSTALLATION_TYPE | CONFIG_FILE }
        ./linux.sh $UPDATE_COMMAND { DISTRO } 
        ./linux.sh $SETUP_COMMAND { DISTRO } { SETUP_TYPE } 

where   DISTRO := { ${AVAILABLE_DISTROS[*]} }
        INSTALLATION_TYPE := { ${INSTALL_COMMAND_TYPES[*]} }
            - desktop: Uses configs/default_desktop.txt
            - server: Uses configs/default_server.txt
        CONFIG_FILE := Path to custom package list
            - Example: configs/my_packages.txt

        SETUP_TYPE := { ${SETUP_TYPES[*]} }

Examples:
  ./linux.sh install arch desktop
  ./linux.sh install ubuntu configs/custom.txt
  ./linux.sh update debian
"
    exit 1
}
