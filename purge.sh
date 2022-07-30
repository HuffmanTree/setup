#!/usr/bin/env bash

packages=$(cat packages.txt)

nvm uninstall 16
rm -rf $NVM_DIR

sudo apt purge $packages
sudo apt autoremove
