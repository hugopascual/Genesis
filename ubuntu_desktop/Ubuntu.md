# Ubuntu software installations
Inside this folder there are all the scripts and info necessary to install the 
software I usually use. I tried to make it in a modular way so everyone can 
modify it to its own taste.

## Use and scripts
The scripts in `scripts` folder are the support for the `installations.sh` 
script which install all the software. Furthermore, outside the 
`support_scripts` folder there are two more scripts. The first one is 
`update.sh` which can be used to update most of the software installed. Some of
the custom installations needed to be updated manually. The second one is 
`test.sh` which only purpose is to test some functionalities or code.

To install all the software specified you just need to execute 
`installations.sh`
```
# If you dont have permissions of execution in the file give them
chmod +x installations.sh
# Then execute it
./installations.sh
```

Once the installations have finished restart the computer because flatpak 
recommend it and just in case something needs a restart to work in the proper 
way.

## Games with Lutris
There is a function to install Lutris, so you can install games like Hearthstone
Linux. Once Lutris is installed you can go to https://lutris.net/games and 
search for the games you want and follow the instructions to install them.

## Things that are not automatized
### Activate Wayland
To activate Wayland, on the password screen click on the gear icon and activate
it.

### See hidden files in folders
If you want to see the hidden files and folder you can use Crtl-H on any 
folder.

### Second Keyboard distribution
In my daily work I use and Spanish and English keyboard distribution, if you 
want, you can add it in the configuration.

### Nvidia drivers
If there is an Nvidia discrete graphics chip you may want to install the 
proprietary drivers for it. With the following command you can see the 
different drivers available for your hardware.
```
ubuntu-drivers devices
```

Select the one you want and install it with the following command.
```
sudo apt-get install nvidia-driver-525
```

I get info from:
- https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fo

## Synchronize accounts
To finish the setup just synchronize your accounts in the web browser and the 
Ubuntu utility if you want.

In my case I start session in:
- Ubuntu Online Accounts: Google main
- Firefox:
  - Web browser synchronization
  - Google services inside
- Thunderbird: Import settings if possible
- Spotify
