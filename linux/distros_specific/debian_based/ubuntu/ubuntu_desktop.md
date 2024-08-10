# Ubuntu Desktop specialized notes

## Games with Lutris
Once Lutris is installed on [this site](https://lutris.net/games) games can be 
searched and installed in a semi-automatic way.

## Things that are not automatized in desktops
- **Activate Wayland (Only on laptops)**
To activate Wayland, on the password screen click on the gear icon and activate
it.

- **See hidden files in folders**
If you want to see the hidden files and folder you can use Crtl-H on any 
folder.

- **Second Keyboard distribution**. 
Settings -> Keyboard -> Add Input Source

## Nvidia drivers
With the following command you can see the different drivers available for your 
hardware, including NVIDIA graphics card if present.
```
ubuntu-drivers devices
```

Select the one you want and install it with the following command.
```
sudo apt-get install <driver-name>
```

## Synchronize accounts
To finish the setup just synchronize your accounts in the web browser and apps.

- Ubuntu Online Accounts: Google ones
- Firefox:
  - Web browser synchronization
  - Google services inside
  - Add FNMT certificate
- Thunderbird: Import settings if possible
- Spotify
- Visual Studio Code Sync
- Jetbrains Toolbox
- Games:
  - Steam
  - Minecraft

