#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

DIR=$(pwd)

TARGET_PATH="/mypkg"
rm -rf "$TARGET_PATH"
mkdir -p "$TARGET_PATH"


echo "usual updates..." 

# Docker BS
# Add Docker's official GPG key:
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$debian") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update && apt full-upgrade -yf
echo "install snapper finally and some other cool shit"
# INSTALL stuff
apt install -yf btrfs-progs snapper snapper-gui grub-btrfs wget git rsync dialog neovim tmux ca-certificates curl gnupg python3 pip neovim docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin flatpak 
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#
# # Maybe later find a way to purge old kernels
# # get previous kernels
# D_KERNEL=$(ls /boot   | grep vmlinuz | sed -e 's/vmlinuz-//')
# 
# # if it didnt fail, remove old kernels
# for KERN in ${OLD_KERNEL};  do $(echo "linux-image-$KERN
# 	") 
# done

# switch to wayland
mkdir -p /etc/systemd/system/gdm.service.d
sudo ln -sf /dev/null /etc/systemd/system/gdm.service.d/disable-wayland.conf

wget http://repo.radeon.com/amdgpu-install/latest/ubuntu/jammy/amdgpu-install_6.0.60000-1_all.deb -O $TARGET_PATH/amdgpu-install.deb
apt install $TARGET_PATH/amdgpu-install.deb -yf
# 
# # pretend you're ubuntu 
# cp /etc/os-release $TARGET_PATH/os-release.old
# echo "VERSION_CODENAME=jammy\nID=ubuntu" >> /etc/os-release
# 
# # before you try to install, be aware of kernels you can use
# echo 'BUILD_EXCLUSIVE_KERNEL="^(6\.[0-2]\..*)"' >> /usr/src/amdgpu-6.2.4-1697730.22.04/dkms.conf  
# 
# echo "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list.d/debian.list
# apt update && apt install -yf linux-image-6.1.0-15-amd64 linux-headers-6.1.0-15-amd64 
# apt autoclean
# echo "#($cat /etc/apt/sources.list.d/debian.list)" > /etc/apt/sources/list.d/debian.list
# 
# amdgpu-install -y --usecase=graphics
# 
# mv $TARGET_PATH/os-release.old /etc/os-release
# 
# NOW the fuckign swapping for old kernel
# HA I actullay figured out where in debian mirror is the deb pkg stored so NO MORE FUCKING SWAPPING VERSIONS AROUND
# leaving this this disaster here for future warning

# rainbows and sunshine here
# Define mount points, UUIDs, and filesystem types
MOUNT_POINT_SDB1="/media/data1"
UUID_SDB1="348C43678C43232A"
FS_TYPE_SDB1="ntfs"
MOUNT_OPTIONS_SDB1="defaults,auto,users,uid=1000,gid=1000,umask=0022,nofail"

MOUNT_POINT_SDB2="/media/shared"
UUID_SDB2="64EB-69F6"
FS_TYPE_SDB2="exfat"
MOUNT_OPTIONS_SDB2="defaults,auto,users,uid=1000,gid=1000,umask=0022,nofail"

# Backup fstab
cp /etc/fstab /etc/fstab.bak

# Add entries to fstab
echo "UUID=$UUID_SDB1 $MOUNT_POINT_SDB1 $FS_TYPE_SDB1 $MOUNT_OPTIONS_SDB1 0 0" >> /etc/fstab
echo "UUID=$UUID_SDB2 $MOUNT_POINT_SDB2 $FS_TYPE_SDB2 $MOUNT_OPTIONS_SDB2 0 0" >> /etc/fstab

echo "fstab has been updated. Mount points for sdb1 and sdb2 added."

git clone git://github.com/vstkl/conf.git $TARGET_PATH/dotfiles

mkdir -p $HOME/.config
cd $TARGET_PATH/dotfiles

cp bashrc $HOME/.bashrc
cp -rf * HOME/.config/

cd $DIR

