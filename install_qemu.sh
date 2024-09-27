yay -Syu libvirt
./install_optdeps.sh libvirt
yay -R iptables
yay -Syu iptables-nft openbsd-netcat
yay -Syu virsh libvirt-sandbox virt-viewer virt-manager cockpit-machines polkit-gnome
su - usermod -aG libvirt m
sudo systemctl start --now libvirtd.service
sudo systemctl start --now virtlogd.service
sudo systemctl enable --now virtlogd.service
