# Arch Linux Setup Guide

## 1. Connect to Wi-Fi and Update

```sh
nmcli device wifi connect "<SSID>" password "<PASSWORD>"
sudo pacman -Syu
```

## 2. Create Common Folders

```sh
mkdir -p ~/documents ~/downloads ~/pictures ~/projects ~/public ~/templates
~/videos ~/.virtualenvs
```

## 3. Install Yay (AUR Helper)

```sh
sudo pacman -S git github-cli 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## 4. Enable Audio

```sh
sudo pacman -S pipewire wireplumber 
sudo pacman -S pipewire-alsa alsa-utils pipewire-jack pipewire-pulse
systemctl --user --now enable pipewire wireplumber
```

## 5. Install Important Packages

### Development Tools

```sh
sudo pacman -S clang cmake composer dotnet-sdk gradle jdk-openjdk jq julia
lua51 luarocks nodejs npm php python-pip python-pynvim r ruby rust stack yarn
```

### Multimedia & Graphics

```sh
sudo pacman -S audacity feh gimp imagemagick jasper kdenlive vlc zathura
zathura-pdf-mupdf spotify-launcher
```

### Productivity & Office

```sh
sudo pacman -S dbeaver libreoffice-fresh okular
yay -S zotero
```

### LaTeX & Documentation

```sh
sudo pacman -S texlive-basic texlive-bibtexextra texlive-fontsextra
texlive-fontsrecommended texlive-langarabic texlive-langchinese texlive-langcjk
texlive-langcyrillic texlive-langczechslovak texlive-langenglish
texlive-langeuropean texlive-langfrench texlive-langgerman texlive-langgreek
texlive-langitalian texlive-langjapanese texlive-langkorean texlive-langother
texlive-langpolish texlive-langportuguese texlive-langspanish texlive-latex
texlive-latexextra texlive-latexrecommended texlive-luatex texlive-mathscience
texlive-xetex
```

### System Utilities

```sh
sudo pacman -S aria2 bat duf exfat-utils eza fd fzf htop maim redshift rlwrap
rsync stow timeshift tldr tmux trash-cli unrar wget whois xclip xdotool zoxide
lazygit
yay -S tre-command lazydocker
```

### Window Manager & Terminal

```sh
sudo pacman -S i3-wm kitty polybar picom rofi yazi
```

### Xorg & Display Server

```sh
sudo pacman -S xorg-server xorg-server-common xorg-server-devel
xorg-server-xephyr xorg-server-xnest xorg-server-xvfb xorg-sessreg
xorg-setxkbmap xorg-smproxy xorg-x11perf xorg-xauth xorg-xbacklight xorg-xcmsdb
xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost
xorg-xinit xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbutils xorg-xkill
xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrandr
xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwayland
xorg-xwd xorg-xwininfo xorg-xwud xf86-video-amdgpu xf86-video-vesa
xorg-bdftopcf xorg-docs xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi
xorg-fonts-encodings xorg-iceauth xorg-mkfontscale xdg-utils
```

### Networking & Servers

```sh
sudo pacman -S aws-cli docker nginx postgresql redis traefik samba ufw
wireshark-qt network-manager-applet openconnect
```

### Virtualization

```sh
sudo pacman -S virtualbox virtualbox-host-modules-arch xf86-video-vmware
```

### Web Browser

```sh
sudo pacman -S firefox
```

### Multimedia Fonts

```sh
sudo pacman -S noto-fonts-emoji ttf-font-awesome ttf-jetbrains-mono-nerd
ttf-material-icons-git
```

## 6. Stow Dotfiles

```sh
git clone https://github.com/RahulSandhu/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
stow -t ~ .
```
