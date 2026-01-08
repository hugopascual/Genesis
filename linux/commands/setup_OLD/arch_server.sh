#!/bin/bash

# Home folders configuration
for home_user_path in $( find /home -maxdepth 1 -mindepth 1 -type d  | sort ); 
do
    # Add alias to .bashrc
    echo "alias ll='ls -alF'
    " >> "$home_user_path/.bashrc"
done
