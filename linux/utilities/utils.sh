#!/bin/bash

####################
#--Echo functions--#
####################
# Colors and more
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
BHIGreen='\033[1;92m' # Bold High Intensity Green
BHIYellow='\033[1;93m' # Bold High Intensity Green
BHICyan='\033[1;96m' # Bold High Intensity Cyan
NoColor='\033[0m'

echo_info() {
    echo -e "${BHICyan}$1${NoColor}"
}

echo_success() {
    echo -e "${BHIGreen}$1${NoColor}"
}

echo_other() {
    echo -e "${BHIYellow}$1${NoColor}"
}

echo_installing() {
    echo -e "${BHICyan}Installing $1${NoColor}"
}

echo_installed() {
    echo -e "${BHIGreen}$1 installed${NoColor}"
}

echo_uninstalling() {
    echo -e "${BHICyan}Uninstalling $1${NoColor}"
}

echo_uninstalled() {
    echo -e "${BHIGreen}$1 uninstalled${NoColor}"
}

###########################
#--Other Usage Functions--#
###########################
##
# @Description
#
##
help_message() {
    echo \
"
Usage:  ./linux.sh install { INSTALLATION_TYPE } { DISTRO }
        ./linux.sh update { DISTRO }
        ./linux.sh customize { DESKTOP_ENVIRONMENT_TYPE }

where   INSTALLATION_TYPE := { desktop | server }
        DISTRO := { ubuntu | debian }
        DESKTOP_ENVIRONMENT_TYPE := { gnome }
"
    exit 1
}

##
# @Description
#
##
check_distribution() {
    distro_selected="$1"

    if [[ ! " ${AVAILABLE_DISTROS[*]} " =~ [[:space:]]${distro_selected}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$DISTRIBUTION_NOT_VALID_MESSAGE"
        help_message
    fi
}

##
# @Description
#
##
check_desktop_environment() {
    desktop_environment_type="$1"

    if [[ ! " ${CUSTOMIZATION_TYPES[*]} " =~ [[:space:]]${desktop_environment_type}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$DESKTOP_ENVIRONMENT_TYPE_NOT_VALID_MESSAGE"
        help_message
    fi
}
