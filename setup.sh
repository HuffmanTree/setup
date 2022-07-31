#!/usr/bin/env bash

# Prerequisites
# - cURL
# - apt

PS4=">>> "

set -x

CODE_DIR=$HOME/Projects/Code
GIT_BRANCH=master
GIT_PROJECT=setup
GIT_USER=HuffmanTree
NVM_DIR=$HOME/.nvm
PACKAGES=$(curl https://raw.githubusercontent.com/$GIT_USER/$GIT_PROJECT/$GIT_BRANCH/packages.txt)
REPOSITORIES=$(curl https://raw.githubusercontent.com/$GIT_USER/$GIT_PROJECT/$GIT_BRANCH/repositories.txt)

# 1. Install apt packages
sudo apt update
sudo apt install $PACKAGES

# 2. Install nvm + node + npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source $HOME/.bashrc
nvm install 16
nvm use 16
nvm alias default 16

# 3. Install projects

# 3.1 Make ~/Projects/Code directory
mkdir -p $CODE_DIR

# 3.2 Clone repositories and set them up
for REPOSITORY in ${REPOSITORIES[@]}
do
    if [ ! -d $CODE_DIR/$REPOSITORY ]
    then
	git clone git@github.com:$GIT_USER/$REPOSITORY.git $CODE_DIR/$REPOSITORY

	if [ -f $CODE_DIR/$REPOSITORY/setup.sh ];
	then
	    chmod +x $CODE_DIR/$REPOSITORY/setup.sh
	    ./$CODE_DIR/$REPOSITORY/setup.sh
	fi

    fi
done

set +x
