#!/bin/bash

gnome_look_pesonalization() {
	# Theme
	local gnome_theme="Adwaita-dark"

	if [[ "$DISTRO_SELECTED" == "$UBUNTU" ]]; then
		gnome_theme="Yaru-blue-dark"
	fi

	gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

	# Background and screensaver
	gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_DESTINATION_PATH"
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_DESTINATION_PATH"
	gsettings set org.gnome.desktop.screensaver picture-uri "file://$SCREENSAVER_DESTINATION_PATH"
}

gnome_desktop_preferences() {
	gsettings set org.gnome.mutter workspaces-only-on-primary true
	gsettings set org.gnome.shell.app-switcher current-workspace-only true

	gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

	gsettings set org.gnome.desktop.notifications show-in-lock-screen false
	gsettings set org.gnome.desktop.interface show-battery-percentage true

	# Dock preferences
	if gsettings writable org.gnome.shell.extensions.dash-to-dock click-action >/dev/null 2>&1; then
		gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize
		gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
		gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
		gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
		gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
	fi
}

gnome_keyboard_configuration() {
	# Keyboard layouts
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'es')]"

	# Shortcuts
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"

	local terminal_shortcut_id="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
	local terminal_command="terminator"
	local file_manager_id="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
	local file_manager_command="nautilus"

	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$terminal_shortcut_id', '$file_manager_id']"

	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ name "Terminal"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ command "$terminal_command"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/ binding "<Ctrl><Alt>T"

	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ name "Files"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ command "$file_manager_command"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/ binding "<Super>e"
}

gnome_configure_startup_apps () {
	setup_copy_autostart_entry_if_exists "/usr/share/applications/obsidian.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/org.mozilla.Thunderbird.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/firefox.desktop"
}

gnome_additional_configurations(){
	sudo systemctl enable gdm.service
}

shell_to_bash() {
	sudo chsh --shell /bin/bash "$USER"
	sudo chsh --shell /bin/bash root
}


gnome_enable_display_manager() {
	
}

###############################################################################

log_info "Starting GNOME setup"

# TODO: test in other distros 
if [[ "$DISTRO_SELECTED" == "$UBUNTU" || "$DISTRO_SELECTED" == "$DEBIAN" ]]; then
	setup_configure_locales
fi

desktop_folder_structure_creation
copy_config_statics "$TYPES_STATICS_PATH/$OPTION_SELECTED"
setup_install_bundle "gnome"

gnome_look_pesonalization
gnome_desktop_preferences
gnome_keyboard_configuration
gnome_configure_startup_apps
gnome_additional_configurations
shell_to_bash

setup_finalize_type
