# Ubuntu Desktop specialized notes

## Games with Lutris
There is a function to install Lutris, so you can install games like Hearthstone
Linux. Once Lutris is installed you can go to https://lutris.net/games and 
search for the games you want and follow the instructions to install them.

## Things that are not automatized in desktops
- **Activate Wayland**
To activate Wayland, on the password screen click on the gear icon and activate
it.

- **See hidden files in folders**
If you want to see the hidden files and folder you can use Crtl-H on any 
folder.

- **Second Keyboard distribution**. 
In my daily work I use and Spanish and English keyboard distribution, if you 
want, you can add it in the configuration.

## Nvidia drivers
If there is an Nvidia discrete graphics chip you may want to install the 
proprietary drivers for it. With the following command you can see the 
different drivers available for your hardware.
```
ubuntu-drivers devices
```

Select the one you want, I use the recommended one, and install it with the 
following command.
```
sudo apt-get install nvidia-driver-525
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
- Ubuntu Online Accounts: Google ones
- Firefox:
  - Web browser synchronization
  - Google services inside
  - Add FNMT certificate
- Thunderbird: Import settings if possible
- Spotify
- Visual Studio Code Sync

