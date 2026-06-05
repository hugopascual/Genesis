#!/bin/bash

################################################################################
# Configure system locales

# Enable en_US.UTF-8 UTF-8 locale
sudo sed -i -E 's/^# (en_US\.UTF-8 UTF-8)/\1/' /etc/locale.gen
# Enable en_GB.UTF-8 UTF-8 locale
sudo sed -i -E 's/^# (en_GB\.UTF-8 UTF-8)/\1/' /etc/locale.gen
# Enable es_ES.UTF-8 UTF-8 locale
sudo sed -i -E 's/^# (es_ES\.UTF-8 UTF-8)/\1/' /etc/locale.gen

sudo locale-gen
localectl set-locale LANG=en_GB.UTF-8
localectl set-locale LANGUAGE=en_GB.UTF-8
localectl set-locale LC_CTYPE=es_ES.UTF-8
localectl set-locale LC_NUMERIC=es_ES.UTF-8
localectl set-locale LC_TIME=es_ES.UTF-8
localectl set-locale LC_COLLATE=es_ES.UTF-8
localectl set-locale LC_MONETARY=es_ES.UTF-8
localectl set-locale LC_MESSAGES=es_ES.UTF-8
localectl set-locale LC_PAPER=es_ES.UTF-8
localectl set-locale LC_NAME=es_ES.UTF-8
localectl set-locale LC_ADDRESS=es_ES.UTF-8
localectl set-locale LC_TELEPHONE=es_ES.UTF-8
localectl set-locale LC_MEASUREMENT=es_ES.UTF-8
localectl set-locale LC_IDENTIFICATION=es_ES.UTF-8

################################################################
# Create basics folders structure
base_folder_structure_creation

################################################################################
# Configure desktop environment
selected_statics_path="$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED"
copy_config_statics

# GNOME
log_info "Starting GNOME setup"
#------------------------------- Installation
log_info 'Checking if GNOME is installed...'
if is_command_installed; then
    log_info "GNOME is installed"
else
    log_info "GNOME not installed"
    exit 1
fi

# GNOME network manager integration with openvpn
apt_install 'network-manager-openvpn-gnome'
apt_install 'openvpn-systemd-resolved'

#------------------------------- Appearance and general settings
# Style
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'

# Background and screensaver
gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.config/theme/background.jpg"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/.config/theme/background.jpg"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$HOME/.config/theme/screensaver.jpg"

# Desktop icons
gsettings set org.gnome.shell.extensions.ding show-home false

# Dock
gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

# Multitasking 
gsettings set org.gnome.mutter workspaces-only-on-primary true
gsettings set org.gnome.shell.app-switcher current-workspace-only true


# Mouse and Touchpad
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# Notifications
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# TODO: Add the baterry percentage show

#------------------------------- END
log_info "Setup finished"

################################################################
# Add second keyboard distribution

# Define the 2 keyboard distributions
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'es')]"

################################################################
# Startup applications

# TODO: Add startup applications

################################################################################
# Other setup configurations

# .bashrc configuration and customization
sed -iE 's/\\w/\\W/' "$HOME/.bashrc"

## Add aliases to .bashrc
aliases_setup

################################################################################
# Graphics drivers
