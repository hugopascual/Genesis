#!/bin/bash

################################################################################
# Configure system locales

# TODO

################################################################################
# Create basics folders structure 
desktop_folder_structure_creation

################################################################################
# Configure environment
selected_statics_path="$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED"
copy_config_statics

# Install hyprland desktop and the around software used
## First of all the around software used for som functionalities 
pacman_install 'qt5-wayland'
pacman_install 'qt6-wayland'
pacman_install 'wofi'
pacman_install 'brightnessctl'
pacman_install 'swaync'
## Now we go with the proper hyprland software
pacman_install 'hyprland'
pacman_install 'hyprpaper'
pacman_install 'hypridle'
pacman_install 'hyprlock'
# TODO probably not neccesary
pacman_install 'xdg-desktop-portal-hyprland'
pacman_install 'hyprshot'
# TODO is not available any more
pacman_install 'hyprctl'

# Startup and login configuration with greetd
pacman_install 'greetd'
pacman_install 'greetd-tuigreet'
sudo rsync -azP --delete --mkpath "$selected_statics_path/greetd/" '/etc/greetd'
sudo systemctl enable greetd.service


# Waybar
pacman_install 'waybar'
# Fix for 0.14.0 Waybar
git clone https://github.com/sejjy/mechabar.git "$HOME/.config/waybar"
# shellcheck disable=SC1090
"$HOME/.config/waybar/install.sh"


# Dark theme
pacman_install 'gtk3'
pacman_install 'gtk4'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'


pacman_install 'qt5ct'
pacman_install 'qt6ct'
pacman_install 'kvantum'

################################################################
# Add second keyboard distribution

# Already done with the configuration files of the desktop environment

################################################################
# Startup applications

# Already done with the configuration files of the desktop environment

################################################################################
# Other setup configurations

# Deactivate bluethooth on startup
sudo sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

custom_shell_setup

################################################################################
# Graphics drivers

# TODO: check if NVIDIA
nvidia_config(){
    pacman_install 'nvidia-open'
    pacman_install 'nvidia-utils'
    pacman_install 'nvidia-settings'
}
