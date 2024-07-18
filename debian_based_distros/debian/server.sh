#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
FUNCTIONS_DIR="$BASE_DIR/functions/"
SCRIPTS_DIR="$BASE_DIR/scripts/"

# Import utils
# shellcheck disable=SC1090
for f in $( find "$FUNCTIONS_DIR" -type f -print | sort ); do source "$f"; done

#------------------------------- Starts
echo_info "Starting installation"

#------------------------------- Update and Upgrade
# TODO search for a better execution of scripts
"$SCRIPTS_DIR"update_system.sh

#------------------------------- Basic
apt_get_install "Mix of basic Sfotware" "wget curl net-tools htop tree"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"
install_nvtop
install_fastfetch

#------------------------------- Development
install_docker
install_github_cli

#------------------------------- Games

#------------------------------- Services

#------------------------------- Extra

#------------------------------- DIT Installs and config
install_openvpnc
ssh_server_activate

#------------------------------- Configuration

#------------------------------- Updates and Cleaning 
"$SCRIPTS_DIR"update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
