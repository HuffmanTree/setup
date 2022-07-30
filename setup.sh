#!/usr/bin/env bash

CODE_DIR=$HOME/Projects/Code
GIT_USER=HuffmanTree
NVM_DIR=$HOME/.nvm
PACKAGES=$(cat packages.txt)
REPOSITORIES=$(cat repositories.txt)

# 1. Install apt packages
sudo apt update
sudo apt install $PACKAGES

# 2. Install nvm + node + npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16
nvm use 16
nvm alias default 16

# 3. Install projects

# 3.1 Make ~/Projects/Code directory
mkdir -p $CODE_DIR

# 3.2 Clone repositories and install dependencies
for REPOSITORY in ${REPOSITORIES[@]}
do
    if [ ! -d $CODE_DIR/$REPOSITORY ]
    then
	git clone git@github.com:$GIT_USER/$REPOSITORY.git $CODE_DIR/$REPOSITORY

	if [ -f $CODE_DIR/$REPOSITORY/package.json ];
	then
	    npm i --prefix $CODE_DIR/$REPOSITORY
	fi

    fi
done
