#!/bin/bash
DIR=$(pwd)

TARGET_PATH="/mypkg"
rm -rf "$TARGET_PATH"
mkdir -p "$TARGET_PATH"


echo "usual updates..." 
apt update && apt full-upgrade -yf
echo "install snapper finally and some other cool shit"
# INSTALL SNAPPER FFS 
apt install -yf btrfs-progs snapper snapper-gui grub-btrfs wget git rsync dialog neovim tmux ca-certificates curl gnupg
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

wget http://repo.radeon.com/amdgpu-install/5.7.3/ubuntu/jammy/amdgpu-install_5.7.50703-1_all.deb -O $TARGET_PATH/amdgpu-install.deb
apt install $TARGET_PATH/amdgpu-install.deb -yf

# pretend you're ubuntu 
cp /etc/os-release $TARGET_PATH/os-release.old
echo "VERSION_CODENAME=jammy\nID=ubuntu" >> /etc/os-release

# before you try to install, be aware of kernels you can use
echo 'BUILD_EXCLUSIVE_KERNEL="^(6\.[0-2]\..*)"' >> /usr/src/amdgpu-6.2.4-1697730.22.04/dkms.conf  

echo "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list.d/debian.list
apt update && apt install -yf linux-image-6.1.0-15-amd64 linux-headers-6.1.0-15-amd64 
apt autoclean
echo "#($cat /etc/apt/sources.list.d/debian.list)" > /etc/apt/sources/list.d/debian.list

amdgpu-install -y --usecase=graphics

mv $TARGET_PATH/os-release.old /etc/os-release

# NOW the fuckign swapping for old kernel
# HA I actullay figured out where in debian mirror is the deb pkg stored so NO MORE FUCKING SWAPPING VERSIONS AROUND
# leaving this this disaster here for future warning

# rainbows and sunshine here

apt install python3 pip neovim

# Docker BS
# Add Docker's official GPG key:
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# cp -rf /home/m/.config/* /mypkgs/dotfiles/
# cp -rf /root/.config/* /mypkgs/dotfiles/
# 
# sync 
# mv /mypkg /etc/vsconf/
# 
# rm -rf /home/m/.config/ /root/.config/ 
# 
# ln -s /etc/vsconf/ /home/m/.config/
# ln -s /etc/vsconf/ /root/.config/


git clone https://github.com/vstkl/dotfiles.git $TARGET_PATH/dotfiles
cp bashrc $HOME/.bashrc

mkdir -p $HOME/.config
cp -rf nvim  $HOME/.config/

cd $DIR

