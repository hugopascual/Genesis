#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
# FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
# SCRIPT_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

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
