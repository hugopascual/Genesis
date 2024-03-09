# LinuxOS
Automation of Linux operative systems. In every folder there is a similar 
structure and a similar use cases and code organization.

## Use and scripts
The scripts in `scripts` folder are the support scripts for the `main.sh` 
script which install all the software and make the wanted configurations. 
Furthermore, outside the `support_scripts` folder there are two more scripts. 
The first one is `main.sh` which install all the software and config the system 
with the config scripts. The second one is `test.sh` which only purpose is to 
test some functionalities or code.

To install all the software specified you just need to execute `main.sh`.
```
# If you dont have permissions of execution in the file give them
chmod +x installations.sh
# Then execute it
./installations.sh
```

Once the installations have finished restart the computer because flatpak 
recommend it and just in case something needs a restart to work in the proper 
way.
