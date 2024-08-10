# Debian Desktop specialized notes

## Games with Lutris
There is a function to install Lutris, so you can install games like Hearthstone
Linux. Once Lutris is installed you can go to https://lutris.net/games and 
search for the games you want and follow the instructions to install them.

## Things that are not automatized in desktops
- **See hidden files in folders**
If you want to see the hidden files and folder you can use Crtl-H on any 
folder.

- **Second Keyboard distribution**. 
In my daily work I use and Spanish and English keyboard distribution, if you 
want, you can add it in the configuration.

## Nvidia Drivers
Pre-Installations Steps
```
sudo apt update
sudo apt upgrade
```

Delete previous installations
```
sudo apt autoremove nvidia* --purge
```
```
sudo /usr/bin/nvidia-uninstall
```

Enable `contrib` and `non-free` repositories on Debian
```
sudo apt install software-properties-common -y
sudo add-apt-repository contrib non-free-firmware non-free
sudo apt update
```

### Installation via APT
Install the nvidia software to detect the GPU
```
sudo apt install nvidia-detect
```
```
nvidia-detect
```
This last command will detect the GPU on your computer and suggest the package 
to install. Install the reccomended one. Probably a warning will appear 
mentioning that the new drivers have a conflict with the ones installed and a 
reboot should fix the problem. Just accept it.
```
sudo apt install nvidia-driver
```
Now reboot the system
```
sudo reboot
```

## Display Link
To install the display link driver go to the [official web](
https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu) and
download the drivers directly. There is an option to install the repository 
but the time I have tried it failed.


## Synchronize accounts
To finish the setup just synchronize your accounts in the web browser and the 
Ubuntu utility if you want.

In my case I start session in:
- Firefox:
  - Web browser synchronization
  - Google services inside
  - Add FNMT certificate
- Thunderbird: Import settings if possible
- Spotify
- Visual Studio Code Sync

