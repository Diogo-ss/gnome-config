#!/bin/bash

## Meus apps
sudo snap remove firefox
sudo apt install git gnome-themes-extra gtk2-engines-murrine sassc node-typescript make gnome-tweaks neovim nodejs npm curl jq
sudo apt-get install manpages-dev
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub org.mozilla.firefox
## flatpak install flathub com.discordapp.Discord
## sudo snap install authy

## Cores
clear
echo "[*] Aplicando esquema de cores"
## sh ./scripts/extension.sh
sh ./scripts/color-scheme.sh
