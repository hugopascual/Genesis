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
source "$LINUX_SCRIPTS_PATH/desktop_customization.sh"
# shellcheck disable=SC1091
source "$LINUX_SCRIPTS_PATH/locales_config.sh"

#------------------------------- Software installations
# Basic
linux_install_net_basic
linux_install_common_funcionalities
linux_install_displaylink_driver
linux_install_flatpak
linux_install_terminator
linux_install_fastfetch
linux_install_nvtop
linux_install_firefox
linux_install_thunderbird
linux_install_keepassxc
linux_install_autofirma
linux_install_config_fnmt

# Development
linux_install_docker
linux_install_vscode
linux_install_jetbrains_toolbox
linux_install_github_cli

# DIT Installs and config
linux_install_openvpnc

# Services
linux_install_spotify
linux_install_telegram
linux_install_discord

# Games
linux_install_lutris
linux_install_steam
linux_install_minecraft

# Extra
linux_install_obsidian
linux_install_vlc
linux_install_gimp
linux_install_google_chrome
linux_install_rpi_imager

#------------------------------- Software configuration

#------------------------------- Update and Clean
# shellcheck disable=SC1091
source "$LINUX_SCRIPTS_PATH/update_system.sh"

#------------------------------- Finish
echo_success "Restart the computer now"