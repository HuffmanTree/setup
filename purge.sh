#!/usr/bin/env bash

CODE_DIR=$HOME/Projects/Code
GIT_USER=HuffmanTree
NVM_DIR=$HOME/.nvm
PACKAGES=$(curl https://raw.githubusercontent.com/HuffmanTree/setup/master/packages.txt)
REPOSITORIES=$(curl https://raw.githubusercontent.com/HuffmanTree/setup/master/repositories.txt)

# 1. Uninstall projects
rm -rf $CODE_DIR

# 2. Uninstall nvm + node + npm
rm -rf $NVM_DIR

# 3. Install apt packages
sudo apt purge $PACKAGES -y
sudo apt autoremove -y
