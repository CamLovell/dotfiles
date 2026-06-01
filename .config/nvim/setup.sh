#! /usr/bin/bash

# Install build dependencies
sudo apt-get install -y ninja-build gettext cmake curl build-essential ripgrep xclip fd-find

# Get neovim
git clone https://www.github.com/neovim/neovim $HOME/neovim

# Build and install
make -C $HOME/neovim CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make -C $HOME/neovim install
