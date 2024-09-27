yay -Syu libvirt --noconfirm
./install_optdeps.sh libvirt
yay -R iptables --noconfirm
yay -Syu iptables-nft openbsd-netcat --noconfirm
yay -Syu virsh libvirt-sandbox virt-viewer virt-manager cockpit-machines polkit-gnome --noconfirm
su - usermod -aG libvirt m
sudo systemctl start --now libvirtd.service
sudo systemctl start --now virtlogd.service
sudo systemctl enable --now virtlogd.service
