#!/bin/bash
sudo pacman -Syu git base-devel &&
git clone https://aur.archlinux.org/yay && cd yay && makepkg -si &&
yay -Syu pamac-aur --noconfirm
