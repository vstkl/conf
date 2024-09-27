#!/bin/bash
pacman -Syu git base-devel --noconfirm && git clone https://aur.archlinux.org/yay ~/yay && cd ~/yay && makepkg -si && yay -Syu pamac-aur --noconfirm
