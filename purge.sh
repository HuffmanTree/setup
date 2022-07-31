#!/usr/bin/env bash

CODE_DIR=$HOME/Projects/Code
GIT_BRANCH=master
GIT_PROJECT=setup
GIT_USER=HuffmanTree
NODEJS_VERSION=16
NVM_DIR=$HOME/.nvm
PACKAGES=$(curl -s https://raw.githubusercontent.com/$GIT_USER/$GIT_PROJECT/$GIT_BRANCH/packages.txt | tr "\n" " ")
REPOSITORIES=$(curl -s https://raw.githubusercontent.com/$GIT_USER/$GIT_PROJECT/$GIT_BRANCH/repositories.txt)

run() {
    printf "[$GIT_PROJECT] $ \033[01;32m$1\n\033[00m"
    $1
}

# 1. Uninstall projects
run "rm -rf $CODE_DIR"

# 2. Uninstall nvm + node + npm
run "rm -rf $NVM_DIR"

# 3. Install apt packages
run "sudo apt purge $PACKAGES -y"
run "sudo apt autoremove -y"
