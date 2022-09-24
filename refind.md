### Install

```
pacman -S refind
refind-install
```

### Configuration

 1. Edit  `/efi/EFI/refind.conf`

	search for `Arch` --> change options with `"root=/dev/root_partition`

 2. Edit  `/boot/refind_linux.conf` leaving only minimal options

 3. Optional: change label for icon:  `fatlabel /dev/boot_partition ARCH`



### Install Minimalist Theme

 1. Locate your refind EFI directory. This is commonly `/boot/EFI/refind`
    though it will depend on where you mount your ESP and where rEFInd is
    installed. `fdisk -l` and `mount` may help.

 2. Create a folder called `themes` inside it, if it doesn't already exist

 3. Clone this repository: `https://github.com/evanpurkhiser/rEFInd-minimal` into the `themes` directory.

 4. To enable the theme add `include themes/rEFInd-minimal/theme.conf` at the end of
    `refind.conf`.

Here's an example menuentry configuration (from the screenshot)

```
menuentry "Arch Linux" {
	icon /EFI/refind/themes/rEFInd-minimal/icons/os_arch.png
	loader vmlinuz-linux
	initrd initramfs-linux.img
	options "rw root=UUID=dfb2919d-ff78-48db-a8a7-23f7542c343a loglevel=3"
}

menuentry "Windows" {
	icon /EFI/refind/themes/rEFInd-minimal/icons/os_win.png
	loader /EFI/Microsoft/Boot/bootmgfw.efi
}

```

### References

Arch Wiki: https://wiki.archlinux.org/title/REFInd
Themes: https://www.rodsbooks.com/refind/themes.html
