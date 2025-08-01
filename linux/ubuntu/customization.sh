#!/bin/bash

##
# @Description
# 
##
execute_customization() {
    config_locale
    config_bash
    desktop_customization
    development_config
}

##
# @Description
# 
##
config_locale() {
    sudo locale-gen es_ES.UTF-8
    localectl set-locale LANG=en_US.UTF-8
    localectl set-locale LANGUAGE=en_US.UTF-8
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
}

##
# @Description
# 
##
config_bash(){
    # Modify file .bashrc changing \w with \W
    sed -iE 's/\\w/\\W/' ~/.bashrc
}

##
# @Description
# 
##
desktop_customization() {
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

    #------------------------------- END
    echo_success "Configuration Finished"
}

##
# @Description
# Config the folder and copy clone_repos.sh
##
development_config() {
    mkdir -p "$HOME/repositories"
    script_folder="$(dirname "$0")"
    cp "$script_folder/../statics/scripts/clone.sh" "$HOME/repositories"
}
