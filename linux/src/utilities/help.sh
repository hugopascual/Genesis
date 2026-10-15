#!/bin/bash

##
# @Description
# Help command or with error usage
# @Params
# $1 Exit code (optional). Defaults to 1 (error usage).
##
help() {
    local exit_code="${1:-1}"

    echo \
"
Usage:  ./linux/linux.sh $INSTALL_COMMAND { DISTRO } { PROFILE | PACKAGE_LIST_FILE }
        ./linux/linux.sh $UPDATE_COMMAND
        ./linux/linux.sh $SETUP_COMMAND { DISTRO } { SETUP_TYPE }
        ./linux/linux.sh $ADD_DISTRO_COMMAND { NEW_DISTRO } { BASE_COMMAND }
        ./linux/linux.sh $HELP_COMMAND

where   DISTRO := { ${AVAILABLE_DISTROS[*]} }
        PROFILE := { ${INSTALL_COMMAND_TYPES[*]} } (from profiles/linux/)
        PACKAGE_LIST_FILE := Path to custom package list (supports @include <profile>)
            - Example: my_packages.txt

        SETUP_TYPE := { ${SETUP_TYPES[*]} } (from linux/src/setups/types/)

        NEW_DISTRO := Distribution key to add in all Linux packages
            - Example: fedora

        BASE_COMMAND := Base install command for the new distro
            - Use {package} as placeholder (recommended)
            - If {package} is not present, package name is appended at the end
            - Example: \"sudo dnf install -y {package}\"

Environment:
        GENESIS_LOG_ENABLED := { true | false } Save the log in linux/logs/ (default: true)

Examples:
    ./linux/linux.sh install arch personal
    ./linux/linux.sh install ubuntu my_packages.txt
    ./linux/linux.sh update
    ./linux/linux.sh setup cachyos kde
    ./linux/linux.sh add-distro fedora \"sudo dnf install -y {package}\"
    GENESIS_LOG_ENABLED=false ./linux/linux.sh install debian server
"
    exit "$exit_code"
}
