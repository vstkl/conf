#!/bin/bash
NEW_DIR=$SUDO_HOME/.new-conf/
CONF_DIR=$SUDO_HOME/.config/ 
if [ ! -d $CONF_DIR ];then
	cp -rf $CONF_DIR $CONF_DIR.old
fi
sudo pacman -Syu git base-devel curl --noconfirm &&
git clone https://github.com/vstkl/conf $NEW_DIR -b arch &&
cp -rf $NEW_DIR/* $NEW_DIR/.* $CONF_DIR &&
#su m - $CONF_DIR/packaging.sh &&
git clone https://github.com/LazyVim/starter $CONF_DIR/nvim && rm -rf $CONF_DIR/nvim/.git

