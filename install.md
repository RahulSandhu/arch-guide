# Arch Linux Installation Guide

## 1. Wipe NVMe Drives

```sh
# Wipe NVMe drive /dev/nvme0n1
gdisk /dev/nvme0n1
# Open partitioning tool:
#   - Press x (Extra functionality menu)
#   - Press z (Zap GPT and MBR)
#   - Confirm with y twice

# Wipe NVMe drive /dev/nvme1n1
gdisk /dev/nvme1n1
# Open partitioning tool:
#   - Press x (Extra functionality menu)
#   - Press z (Zap GPT and MBR)
#   - Confirm with y twice
```

Reboot your system before proceeding:

```sh
reboot now
```

## 2. Connect to the Internet

```sh
iwctl
device list
station wlan0 get-networks
station wlan0 connect <SSID>
```

## 3. Update System Packages

```sh
pacman -Sy
```

## 4. Partition NVMe SSDs

```sh
# Partition /dev/nvme0n1
gdisk /dev/nvme0n1

# Create EFI Partition (1GB)
# - Press n, then Enter for default partition number and starting sector
# - Type "+1G" for size, then Enter
# - Press t, select partition 1, then type "EF00"

# Create Swap Partition (34GB: 32GB for RAM + 2GB extra)
# - Press n, then Enter for default partition number and starting sector
# - Type "+34G" for size, then Enter
# - Press t, select partition 2, then type "8200"

# Create Root Partition (Remaining Space)
# - Press n, then Enter for default partition number and starting sector
# - Press Enter to use the remaining space
# - Press t, select partition 3, then type "8300"
# - Press w, to write changes

# Partition /dev/nvme1n1
gdisk /dev/nvme1n1

# Create Home Partition (Entire Disk)
# - Press n, then Enter for default partition number and starting sector
# - Press Enter to use the remaining space
# - Press t, select partition 1, then type "8300"
# - Press w, to write changes
```

## 5. Format Partitions

```sh
# Format EFI partition
mkfs.fat -F32 /dev/nvme0n1p1

# Format swap partition and enable it
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2

# Format root partition
mkfs.ext4 /dev/nvme0n1p3

# Format home partition
mkfs.ext4 /dev/nvme1n1p1
```

## 6. Mount Partitions

```sh
# Mount root partition
mount /dev/nvme0n1p3 /mnt

# Create and mount EFI partition
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi

# Create and mount home partition
mkdir -p /mnt/home
mount /dev/nvme1n1p1 /mnt/home
```

## 7. Install Arch Linux

```sh
pacstrap -K /mnt base linux linux-firmware
```

## 8. Generate fstab

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

## 9. Change Root into New System

```sh
arch-chroot /mnt
```

## 10. Install Essential Packages

```sh
pacman -S base-devel neovim neofetch
export EDITOR=nvim
```

## 11. Set Hostname

```sh
# Edit /etc/hostname and add 'archlinux' as the hostname
nvim /etc/hostname
```

## 12. Set Locale and Timezone

```sh
# Edit locale file and uncomment "en_US.UTF-8 UTF-8"
nvim /etc/locale.gen
locale-gen

# Set locale
nvim /etc/locale.conf   # Add: LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Set timezone and hardware clock
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
```

## 13. Configure System Time Synchronization

```sh
# Edit timesync configuration file
nvim /etc/systemd/timesyncd.conf
# Modify the file as follows:
# [Time]
# NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
# FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org

# Enable time synchronization service
systemctl enable systemd-timesyncd.service
```

## 14. Install and Enable NetworkManager

```sh
pacman -S networkmanager wpa_supplicant wireless_tools dialog
systemctl enable NetworkManager
```

## 15. Improve Download Speeds

```sh
pacman -S reflector

# Backup the current mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# Update mirrorlist using reflector
reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

## 16. Set Root Password

```sh
passwd
```

## 17. Install and Configure Zsh

```sh
pacman -S zsh
```

## 18. Create New User with Sudo Privileges

```sh
# Create a new user with a home directory and Zsh as the default shell
useradd -m -G wheel -s /bin/zsh rahul
passwd rahul

# Edit the sudoers file to grant sudo privileges to the wheel group
visudo # Uncomment the line: %wheel ALL=(ALL:ALL) ALL
```

## 19. Enable SSD Trim Support

```sh
systemctl enable fstrim.timer
```

## 20. Enable Multilib, VerbosePkgLists, and ILoveCandy

```sh
# Edit the pacman configuration file
nvim /etc/pacman.conf
# Uncomment "VerbosePkgLists" and enable ILoveCandy
# Also, enable multilib by uncommenting:
# [multilib]
# Include = /etc/pacman.d/mirrorlist

pacman -Sy
```

## 21. Install and Enable UFW

```sh
pacman -S ufw
ufw enable
systemctl --now enable ufw
```

## 22. Enable Bluetooth

```sh
pacman -S bluez blueman bluez-utils bluez-libs 
modprobe btusb
systemctl --now enable bluetooth 
```

## 23. Install GRUB Bootloader

```sh
pacman -S grub efibootmgr
```

## 24. Install GRUB to EFI

```sh
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

## 25. Set GRUB Timeout

```sh
nvim /etc/default/grub
# Change the GRUB_TIMEOUT line to: GRUB_TIMEOUT=30
grub-mkconfig -o /boot/grub/grub.cfg
```

## 26. Install AMD Microcode and Drivers

```sh
pacman -S amd-ucode
pacman -S mesa lib32-mesa libva-mesa-driver lib32-libva-mesa-driver
pacman -S mesa-vdpau lib32-mesa-vdpau
pacman -S vulkan-radeon lib32-vulkan-radeon
```

## 27. Generate Boot Configuration

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

## 28. Finish Installation

```sh
# Exit the chroot environment
exit

# Unmount all partitions
umount -R /mnt

# Shutdown the system
shutdown now
```
