#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$DIRECTORY/../utils/auxiliar.sh"

#------------------------------- Config
echo_info "Git config"
git config --global user.email "hugopascual998@gmail.com"
git config --global user.name "hugopascual"   
echo_success "Git config finished"