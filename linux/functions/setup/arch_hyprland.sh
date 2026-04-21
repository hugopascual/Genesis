#!/bin/bash

################################################################################
# Configure system locales

# TODO

################################################################################
# Configure desktop environment

# Install hyprland desktop and the around software used
## First of all the around software used for som functionalities 
pacman_install 'qt5-wayland'
pacman_install 'qt6-wayland'
pacman_install 'wofi'
pacman_install 'brightnessctl'
pacman_install 'swaync'
pacman_install 'yazi'
## Now we go with the proper hyprland software
pacman_install 'hyprland'
pacman_install 'hyprpaper'
pacman_install 'hypridle'
pacman_install 'hyprlock'
pacman_install 'xdg-desktop-portal-hyprland'
pacman_install 'hyprshot'
pacman_install 'hyprctl'


# Copy configuration folders
folders_to_copy=('kitty' 'yazi' 'hypr' 'wofi')
for folder in "${folders_to_copy[@]}";
do
    rsync -azP --delete --mkpath "$STATICS_PATH/$DISTRO_PLUS_TYPE/$folder/" "$HOME/.config/$folder"
done


# Startup and login configuration with greetd
pacman_install 'greetd'
pacman_install 'greetd-tuigreet'
sudo rsync -azP --delete --mkpath "$STATICS_PATH/$DISTRO_PLUS_TYPE/greetd/" '/etc/greetd'
sudo systemctl enable greetd.service


# Waybar
pacman_install 'waybar'
# Fix for 0.14.0 Waybar
git clone -b fix/v0.14.0 https://github.com/sejjy/mechabar.git "$HOME/.config/waybar"
# shellcheck disable=SC1090
"$HOME/.config/waybar/install.sh"


# Dark theme
pacman_install 'gtk3'
pacman_install 'gtk4'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'

pacman_install 'qt5ct'
pacman_install 'qt6ct'
pacman_install 'kvantum'

################################################################################
# Create basics folders structure 

mkdir -p "$WINDOWS_APPS_PATH"
mkdir -p "$REPOSITORIES_PATH"
mkdir -p "$DOCKER_DEPLOYMENTS_PATH"
mkdir -p "$DOCKER_VOLUMES_PATH"
mkdir -p "$NFS_SHARE_PATH"
rsync -azP --delete --mkpath "$REPOSITORIES_CLONE_SCRIPT_PATH" "$REPOSITORIES_PATH/"

################################################################
# Add second keyboard distribution

# Already done with the configuration files of the desktop environment

################################################################
# Startup applications

# Already done with the configuration files of the desktop environment

################################################################################
# Other setup configurations

# .bashrc configuration and customization
sudo sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

# Add aliases to .bashrc
echo \
"
alias ll='ls -alF'
" >> "$HOME/.bashrc"

################################################################################
# Graphics drivers

################################################################################
