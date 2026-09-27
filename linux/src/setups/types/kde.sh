#!/bin/bash

kde_look_pesonalization() {
	# Theme configuration
	lookandfeeltool -a org.kde.breezedark.desktop

	# Background wallpaper
	plasma-apply-wallpaperimage "$BACKGROUND_DESTINATION_PATH"
	# Screen Locking wallpaper
	kwriteconfig6 --file kscreenlockerrc \
		--group Greeter --group Wallpaper --group org.kde.image --group General \
		--key Image "$SCREENSAVER_DESTINATION_PATH"
	
	# Search bar in the midle of the screen
	kwriteconfig6 --file krunnerrc \
		--group General \
		--key FreeFloating true
}

kde_desktop_preferences() {
	# Disable natural scrolling
	kwriteconfig6 --file kcminputrc --group Touchpad --key NaturalScroll false
	# Taskbar on top
	qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'panels()[0].location = "top"'
	# No restore of apps from previouse session
	kwriteconfig6 --file ksmserverrc --group General --key loginMode emptySession
	# Switch desktops independently for each screen
	kwriteconfig6 --file kwinrc --group Windows --key PerOutputVirtualDesktops true

	# Workspaces configuration
	local temp_dir
	temp_dir="$(mktemp -d)" || return 1

	git clone https://github.com/maurges/dynamic_workspaces.git "$temp_dir/dynamic_workspaces"
	pushd "$temp_dir/dynamic_workspaces" >/dev/null || return 1
	kpackagetool6 --type KWin/Script --install .
	popd >/dev/null || return 1

	kwriteconfig6 --file kwinrc --group Plugins --key dynamic_workspacesEnabled true
	qdbus6 org.kde.KWin /KWin reconfigure

	rm -rf "$temp_dir"
}

kde_keyboard_configuration() {
	# Keyboard layouts
	kwriteconfig6 --file kxkbrc \
		--group Layout --key Use true

	kwriteconfig6 --file kxkbrc \
		--group Layout --key LayoutList "us,es"

	# KDE keyboard shortcut
	kwriteconfig6 --file kglobalshortcutsrc \
		--group "KDE Keyboard Layout Switcher" \
		--key "Switch to Next Keyboard Layout" \
	    "Meta+Space,Meta+Space,Switch to Next Keyboard Layout"
	
	# KDE shortcuts
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Left" "Ctrl+Alt+Left,none,Switch One Desktop to the Left"
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Right" "Ctrl+Alt+Right,none,Switch One Desktop to the Right"
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Overview" "Meta,none,Toggle Overview"
	kwriteconfig6 --file kglobalshortcutsrc --group plasmashell --key "activate application launcher" "Alt+F1,none,Activate Application Launcher"
	kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window Maximize" "Meta+F,none,Maximise Window"
}

kde_configure_startup_apps() {
	setup_copy_autostart_entry_if_exists "/usr/share/applications/obsidian.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/org.mozilla.Thunderbird.desktop"
	setup_copy_autostart_entry_if_exists "/usr/share/applications/firefox.desktop"
}

kde_additional_configurations(){}

shell_to_bash() {
	sudo chsh --shell /bin/bash "$USER"
	sudo chsh --shell /bin/bash root
}

###############################################################################

desktop_folder_structure_creation
copy_config_statics "$TYPES_STATICS_PATH/$OPTION_SELECTED"
setup_install_bundle "kde"

kde_look_pesonalization
kde_desktop_preferences
kde_keyboard_configuration
kde_configure_startup_apps
kde_additional_configurations
shell_to_bash

setup_finalize_type
