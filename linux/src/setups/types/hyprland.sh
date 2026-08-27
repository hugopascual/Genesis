#!/bin/bash

hyprland_install_packages() {
	setup_install_bundle "hyprland"
}

hyprland_configure_greetd() {
	sudo rsync -azP --delete --mkpath "$selected_statics_path/greetd/" '/etc/greetd'
	sudo systemctl enable greetd.service
}

hyprland_install_waybar_theme() {
	git clone https://github.com/sejjy/mechabar.git "$HOME/.config/waybar"
	# shellcheck disable=SC1090
	"$HOME/.config/waybar/install.sh"
}

hyprland_apply_theme() {
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
}

hyprland_disable_bluetooth_autostart() {
	sudo sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf
}

###############################################################################

desktop_folder_structure_creation
copy_config_statics "$TYPES_STATICS_PATH/$OPTION_SELECTED"

hyprland_install_packages || return 1
hyprland_configure_greetd || return 1
hyprland_install_waybar_theme || return 1
hyprland_apply_theme
hyprland_disable_bluetooth_autostart

setup_finalize_type
