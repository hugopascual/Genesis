# Debian Desktop specialized notes

## Nvidia Drivers
Pre-Installations Steps
```
sudo apt update
sudo apt updagrade
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
sudo add-apt-repository contrib non-free-firmware
sudo apt update
```

### Installation via APT
Check your system build 32bit or 64bit
```
lscpu | grep CPU
```

I suppose that the system is 64bit capable
```
# Non-PAE kernel
sudo apt install linux-headers-686
# PAE kernel
sudo apt install linux-headers-686
```

Install the drivers
```
sudo apt install nvidia-detect
```
```
nvidia-detect
```
This last command will detect the GPU on your computer and suggest the package 
to install. Install the reccomended one.
```
sudo apt install nvidia-driver linux-image-amd64
```
Now reboot the system
```
sudo reboot
```
