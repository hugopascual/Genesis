#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$SCRIPTS_DIR/../utils/auxiliar.sh"

#------------------------------- Initialization
echo_info "Starting configuration"

#------------------------------- Appearance
# Style
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'

# Desktop icons
gsettings set org.gnome.shell.extensions.ding show-home false

# Dock
gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

#------------------------------- Multitasking 
gsettings set org.gnome.mutter workspaces-only-on-primary false
gsettings set org.gnome.shell.app-switcher current-workspace-only true


#------------------------------- Mouse and Touchpad
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

#------------------------------- Notifications
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# ------------------------------- Terminal
# Modify file .bashrc changing \w with \W
sed -iE 's/\\w/\\W/' ~/.bashrc

#------------------------------- END
echo_success "Configuration Finished"

