#!/bin/bash

# Locales
# TODO: Modify /etc/locale.gen to include the line es_ES.UTF-8
sudo locale-gen
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


# Bash
sed -iE 's/\\w/\\W/' ~/.bashrc


# Configuration for every user
for home_user_path in $( find /home -maxdepth 1 -mindepth 1 -type d  | sort ); 
do
    # Create development folders
    mkdir -p "$home_user_path/devops/repos"
    mkdir -p "$home_user_path/devops/docker_volumes"
    rsync -azP --delete --mkpath "$STATICS_PATH/clone.sh" "$home_user_path/devops/repos/"
    
    # Copy configuration folders
    folders_to_copy=('kitty' 'yazi' 'hypr' 'wofi')
    for folder in "${folders_to_copy[@]}";
    do
        rsync -azP --delete --mkpath "$STATICS_PATH/$DISTRO_PLUS_TYPE/$folder" "$home_user_path/.config/$folder"
    done

    # Add aliases to .bashrc
    echo \
    "
    alias ll='ls -alF'
    " >> "$home_user_path/.bashrc"
done


# GNOME
echo_info "Starting GNOME setup"
#------------------------------- Installation
# TODO: Install GNOME if not installed

#------------------------------- Appearance and general settings
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

# Multitasking 
gsettings set org.gnome.mutter workspaces-only-on-primary false
gsettings set org.gnome.shell.app-switcher current-workspace-only true


# Mouse and Touchpad
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# Notifications
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

#------------------------------- END
echo_success "Setup finished"
