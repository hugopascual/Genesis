#!/bin/bash

# shellcheck disable=SC1091
source "./select_distro.sh"

#------------------------------- Start with the setup
echo_info "Starting setup"

#------------------------------- Update and Upgrade
# shellcheck disable=SC1091
source "$LINUX_SCRIPTS_PATH/update_system.sh"

#------------------------------- Customization
# shellcheck disable=SC1091
source "$LINUX_SCRIPTS_PATH/locales_config.sh"

#------------------------------- Software installations
# Basic
linux_install_net_basic
linux_install_common_utilities
linux_install_fastfetch
linux_install_nvtop

# Development
linux_install_docker
linux_install_github_cli

# DIT Installs and config
linux_install_openvpnc

# Services

# Games

# Extra

#------------------------------- Software configuration
source "$LINUX_SCRIPTS_PATH/enable_ssh_service.sh"

#------------------------------- Update and Clean
# shellcheck disable=SC1091
source "$LINUX_SCRIPTS_PATH/update_system.sh"

#------------------------------- Finish
echo_success "Restart the computer now"