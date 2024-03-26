#!/bin/bash

#------------------------------- Imports
# Get the path to the main SCRIPTS_dir.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$SCRIPTS_DIR/../utils/auxiliar.sh"

#------------------------------- Config
echo_info "Git config"
git config --global user.email "hugo.pascual.adan@gmail.com"
git config --global user.name "hugopascual"   
echo_success "Git config finished" 
