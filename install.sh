#!/bin/bash
NEW_DIR=~/.new-conf/
CONF_DIR=~/.config/ 
sudo pacman -Syu git base-devel curl &&
git clone https://github.com/vstkl/conf $NEW_DIR -b arch &&
cp -rf $NEW_DIR/* $NEW_DIR/.* $CONF_DIR &&
bash $CONF_DIR/packaging.sh &&
git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git

