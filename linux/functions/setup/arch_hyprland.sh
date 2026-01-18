#!/bin/bash

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


# Startup and login configuration with greetd
pacman_install 'greetd'
pacman_install 'greetd-tuigreet'
sudo rsync -azP --delete --mkpath "$STATICS_PATH/$DISTRO_PLUS_TYPE/greetd/" '/etc/greetd'
sudo systemctl enable greetd.service


# User configuration
# Create development folders
mkdir -p "$HOME/devops/repos"
mkdir -p "$HOME/devops/docker_volumes"
rsync -azP --delete --mkpath "$STATICS_PATH/clone.sh" "$HOME/devops/repos/"

# Copy configuration folders
folders_to_copy=('kitty' 'yazi' 'hypr' 'wofi')
for folder in "${folders_to_copy[@]}";
do
    rsync -azP --delete --mkpath "$STATICS_PATH/$DISTRO_PLUS_TYPE/$folder/" "$HOME/.config/$folder"
done

# Add aliases to .bashrc
echo \
"
alias ll='ls -alF'
" >> "$HOME/.bashrc"

# Waybar
pacman_install 'waybar'
# https://github.com/sejjy/mechabar
git clone https://github.com/sejjy/mechabar.git "$HOME/.config/waybar"
# shellcheck disable=SC1090
"$HOME/.config/waybar/install.sh"

# Bluetooth powered off on startup
sudo sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

# Dark theme
pacman_install 'gtk3'
pacman_install 'gtk4'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

pacman_install 'qt5ct'
pacman_install 'qt6ct'
pacman_install 'kvantum'
