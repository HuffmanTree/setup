#!/usr/bin/env bash

# Prerequisites
# - cURL
# - apt

CODE_DIR=$HOME/Projects/Code
GIT_BRANCH=master
GIT_PROJECT=setup
GIT_USER=HuffmanTree
NODEJS_VERSION=16
NVM_DIR=$HOME/.nvm
PACKAGES=$(curl -s https://raw.githubusercontent.com/$GIT_USER/$GIT_PROJECT/$GIT_BRANCH/packages.txt)
REPOSITORIES=$(curl -s https://raw.githubusercontent.com/$GIT_USER/$GIT_PROJECT/$GIT_BRANCH/repositories.txt)

run() {
    printf "[$GIT_PROJECT] $ \033[01;32m$1\n\033[00m"
    $1
}

# 1. Install apt packages
run "sudo apt update"
run "sudo apt install $PACKAGES"

# 2. Install nvm + node + npm
run "curl -o /tmp/nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh 2> /dev/null"
run "/tmp/nvm.sh"
run "source $HOME/.bashrc"
run "nvm install $NODEJS_VERSION"
run "nvm use $NODEJS_VERSION"
run "nvm alias default $NODEJS_VERSION"

# 3. Install projects

# 3.1 Make ~/Projects/Code directory
run "mkdir -p $CODE_DIR"

# 3.2 Clone repositories and set them up
for REPOSITORY in ${REPOSITORIES[@]}
do
    if [ ! -d $CODE_DIR/$REPOSITORY ]
    then
	run "git clone git@github.com:$GIT_USER/$REPOSITORY.git $CODE_DIR/$REPOSITORY"

	if [ -f $CODE_DIR/$REPOSITORY/setup.sh ];
	then
	    run "chmod +x $CODE_DIR/$REPOSITORY/setup.sh"
	    run "$CODE_DIR/$REPOSITORY/setup.sh"
	fi

    fi
done
