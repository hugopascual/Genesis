# Debian Desktop specialized notes

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
