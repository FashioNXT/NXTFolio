#!/bin/bash

# install prerequisites packages
#   nodejs: required to db setup and execjs
#   imagemagick: required for images
apt-get update && apt-get upgrade -y 
apt-get install -y git \
    sudo \
    curl \
    software-properties-common \
    gpg \
    nodejs \
    imagemagick
# other non-necesary but useful
apt install -y nano tmux

# install rvm
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm -y
source /etc/profile.d/rvm.sh
echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc

# update rvm
command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
rvm get stable
