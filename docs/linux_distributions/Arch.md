# Arch

## Arch with Hyprland

### Documentación software instalado

- [Hyprland](https://wiki.hypr.land/)
- [Ecosistema hyprland](https://wiki.hypr.land/Hypr-Ecosystem/)
- [Yazi](https://knng.de/blog/hyprland_yazi/)
- [Yay](https://github.com/Jguer/yay)

### Network Manager

Una vez instalado el NetworkManager hay que asegurarse de tener el servicio activo

```sh
systemctl status NetworkManager
```

Si el servicio está activo debes buscar las redes WiFi disponibles

```sh
nmcli dev wifi
```

Descubierto el nombre de la red a la que nos queremos conectar nos podemos conectar con

```sh
nmcli dev wifi connect <SSID> --ask
```

Información más detallada en la[página oficial](https://wiki.archlinux.org/title/NetworkManager) o
[aquí](https://itsfoss.gitlab.io/post/enable-networkmanager-after-arch-installation/).

### Configuración de arranque

En este caso vamos a configurar `tuigreet` como pantalla de login en el arranque
y para el login posterior al bloquear la pantalla usaremos `hyprlock`.
Utilizaremos `greetd` como servicio en `systemd` para hacer el arranque
instantaneo con `systemctl enable greetd.service`.

La configuración se modifica en el fichero `/etc/greetd/config.toml`:

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

**Existe una alternativa** si desea configurar `hyprlock` como login inicial
cambiaremos la configuración por la siguiente. Fíjese que debe cambiar el
usuario por el suyo.

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
user = "tu-usuario"
```

### Waybar

Configuración custom usando la [mechabar](https://github.com/sejjy/mechabar).

```sh
git clone https://github.com/sejjy/mechabar.git ~/.config/waybar
~/.config/waybar/install.sh
```
