# Arch Linux Notes

## Graphics Drivers

### NVIDIA

```shell
sudo pacman -Syu --noconfirm nvidia-utils nvidia-settings
```

Depending on the GPU you may need a different driver instead of `nvidia-open`.
Check the [Arch Wiki](https://wiki.archlinux.org/title/NVIDIA) for more information.

```shell
sudo pacman -Syu --noconfirm nvidia-open
```

## Arch with Hyprland

`./linux/linux.sh setup arch hyprland` installs the Hyprland bundle and automates the `greetd` and Waybar configuration described below.

### Installed software documentation

- [Hyprland](https://wiki.hypr.land/)
- [Hyprland ecosystem](https://wiki.hypr.land/Hypr-Ecosystem/)
- [Yazi](https://knng.de/blog/hyprland_yazi/)
- [Yay](https://github.com/Jguer/yay)

### Network Manager

Once NetworkManager is installed, make sure its service is running:

```sh
systemctl status NetworkManager
```

If the service is running, list the available WiFi networks:

```sh
nmcli dev wifi
```

Then connect to the network:

```sh
nmcli dev wifi connect <SSID> --ask
```

More information in the [Arch Wiki](https://wiki.archlinux.org/title/NetworkManager) or in
[Enable NetworkManager after Arch installation](https://itsfoss.gitlab.io/post/enable-networkmanager-after-arch-installation/).

### Boot and login

`tuigreet` is used as the login screen at boot, and `hyprlock` to unlock the screen afterwards.
`greetd` runs as a `systemd` service to start it at boot (`systemctl enable greetd.service`).

The configuration is in `/etc/greetd/config.toml` (the setup copies it from `linux/statics/types/hyprland/greetd`):

```toml
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 1

# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
command = "tuigreet --cmd hyprland"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the `video` group.
user = "greeter"
```

---

**Alternative**: to use `hyprlock` as the initial login, use the following configuration instead, replacing the user with yours.

```toml
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 1

# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
command = "hyprland"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the `video` group.
user = "your-user"
```

### Waybar

Custom configuration using [mechabar](https://github.com/sejjy/mechabar) (installed by the setup):

```sh
git clone https://github.com/sejjy/mechabar.git ~/.config/waybar
~/.config/waybar/install.sh
```

### Useful links

- [hyprlock configs](https://github.com/MrVivekRajan/Hyprlock-Styles/)
