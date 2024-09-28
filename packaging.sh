#!/bin/bash
sudo pacman -Syu git base-devel --noconfirm && git clone https://aur.archlinux.org/yay /tmp/yay && cd /tmp/yay && makepkg -si && yay -Syu pamac-aur --noconfirm
rm -rf /tmp/yay 
