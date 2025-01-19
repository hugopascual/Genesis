#!/bin/bash

sudo apt install -y ssh
sudo systemctl enable ssh && sudo systemctl start ssh
