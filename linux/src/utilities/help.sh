#!/bin/bash

##
# @Description
# Help command or with error usage
##
help() {
    echo \
"
Usage:  ./linux/linux.sh $INSTALL_COMMAND { DISTRO } { INSTALLATION_TYPE | CONFIG_FILE }
        ./linux/linux.sh $UPDATE_COMMAND
        ./linux/linux.sh $SETUP_COMMAND { DISTRO } { SETUP_TYPE } 
        ./linux/linux.sh $ADD_DISTRO_COMMAND { NEW_DISTRO } { BASE_COMMAND } 

where   DISTRO := { ${AVAILABLE_DISTROS[*]} }
        INSTALLATION_TYPE := { ${INSTALL_COMMAND_TYPES[*]} }
            - desktop: Uses configs/default_desktop.txt
            - server: Uses configs/default_server.txt
        CONFIG_FILE := Path to custom package list
            - Example: configs/my_packages.txt

        SETUP_TYPE := { ${SETUP_TYPES[*]} }

        NEW_DISTRO := Distribution key to add in all packages
            - Example: arch

        BASE_COMMAND := Base install command for the new distro
            - Use \{package\} as placeholder (recommended)
            - If \{package\} is not present, package name is appended at the end
            - Example: \"sudo pacman -Syu --noconfirm \{package\}\"

Examples:
    ./linux/linux.sh install arch desktop
    ./linux/linux.sh install ubuntu configs/custom.txt
    ./linux/linux.sh update
    ./linux/linux.sh add-distro arch \"sudo pacman -Syu --noconfirm \{package\}\"
"
    exit 1
}
