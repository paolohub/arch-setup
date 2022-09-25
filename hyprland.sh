sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo reflector -c Italy -a 6 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy
sudo pacman -S xorg-server xorg-xinit mesa libva-intel-driver intel-media-driver vulkan-intel
# pacman -S xf86-video-intel
sudo pacman -S  xorg sddm
sudo paru -S hyprland-bin
sudo systemctl enable sddm
sudo pacman -S firefox-i18n-it thunderbird-i18n-it libreoffice-fresh-it vlc  dina-font tamsyn-font ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji
git clone https://github.com/morrolinux/LinuxRices.git