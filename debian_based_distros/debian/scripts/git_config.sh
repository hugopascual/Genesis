#!/bin/bash

#------------------------------- Imports
# Get the path to the main SCRIPTS_dir.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
AUXILIAR_FUNCTIONS="$SCRIPTS_DIR/../functions/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FUNCTIONS"

#------------------------------- Config
echo_info "Git config"
git config --global user.email "hugo.pascual.adan@gmail.com"
git config --global user.name "hugopascual"   
echo_success "Git config finished" 
