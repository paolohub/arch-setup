# Arch Install Commands-Script

In this repository you will find packages-scripts for the base install of Arch Linux and the Gnome, KDE, Cinnamon and Xfce desktop environments. More to come for Windows Managers soon.
Modify the packages to your liking, make the script executable with `chmod +x scriptname` and then run with `./scriptname`.
Remember that the first part of the Arch Linux install is manual, that is you will have to partition, format and mount the disk yourself. Install the base packages and make sure to inlcude git so that you can clone the repository in chroot.

A small summary:

1. If needed, load your keymap to increase font
~~~~bash
loadkeys it
setfont ter-132n
~~~~
2. Check internet connection
~~~~bash
ip a
~~~~
If wifi connection is needed:
~~~~bash
iwctl

station wlan0 connect home
~~~~

3. Use timedatectl(1) to ensure the system clock is accurate:
~~~~bash
timedatectl set-ntp true
~~~~
To check the service status, use timedatectl status.

4. Refresh the servers
~~~~bash
pacman -Syy
~~~~
5. Partition the disk (check disk to partition with lsblk)
~~~~bash
gdisk /dev/sda
~~~~

`Hex code for EFI: ef00`

6. Format the partitions
~~~~bash
mkfs.fat -F32 /dev/sda1
mkfs.btrfs /dev/sda2
~~~~
7. Mount the partitions
~~~~bash
mount /dev/sda2 /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
cd
umount /mnt
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/sda2 /mnt
mkdir /mnt/{efi,home}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@home /dev/sda2 /mnt/home
mount /dev/sda1 /mnt/efi
lsblk
~~~~  
8. Install the base packages into `/mnt` (intel-ucode or amd-ucode - vim or nano - linux or linux-zen) 
~~~~bash
pacstrap /mnt base linux linux-firmware git vim nano amd-ucode
~~~~
9. Generate the FSTAB file
~~~~bash
genfstab -U /mnt >> /mnt/etc/fstab
~~~~
10. Chroot in with
~~~~bash
arch-chroot /mnt
~~~~
11. Download the git repository
~~~~bash
git clone https://github.com/paolohub/arch-setup.git
~~~~
12. Run the script
~~~~bash
cd arch-install
chmod +x base-uefi.sh
cd /
./arch-install/base-uefi.sh 
~~~~
13.  Uncomment to allow members of group wheel to execute any command
~~~~bash    
EDITOR=vim visudo
~~~~
14. Edit `mkinitcpio.conf`
~~~~bash
vim /etc/mkinitcpio.conf
~~~~
    to add `MODULES=(btrfs amdgpu)`
    and check preset `ls -l /etc/mkinitcpio.d/*.preset`
~~~~bash
mkinitcpio -P
~~~~
15. Remove root access and reboot
~~~~bash
passwd -l root
exit
umount -R /mnt
reboot
~~~~
16. Login with user. If needed execute `setfont ter-132n` and check ip (steps 1. 2.)
17. Sync repos and copy scripts to home
~~~~bash
sudo pacman -Sy
cp -r /arch-install .
chmod +x kde.sh
cd
./arch-basic/kde.sh

reboot
~~~~
18. Install paru
~~~~bash
git clone https://aur.archlinux.org/paru-bin
cd paru-bin/
makepkg -si
~~~~
19. Install timeshift
~~~~bash
paru -S timeshift timeshift-autosnap 
~~~~
20. Install zramd
~~~~bash
paru -S zramd
lsblk 
sudo systemctl enable --now zramd.service 
lsblk 
~~~~
21. Install software
~~~~bash
paru -S google-chrome keepassxc bitwarden rclone-browser grub-customizer vscode
~~~~
22. Generate ssh key to import in github
~~~~bash
ssh-keygen -t ed25519 -C "yourmail@domain.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
~~~~ 