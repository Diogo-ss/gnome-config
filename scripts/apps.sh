#!/bin/bash

## Meus apps
sudo snap remove firefox
sudo apt install git node-typescript make gnome-tweaks neovim nodejs npm curl jq
sudo apt-get install manpages-dev
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub org.mozilla.firefox
## flatpak install flathub com.discordapp.Discord
## sudo snap install authy

## Extensões
clear
echo "[*] Instalando extensões"
## sh ./scripts/extension.sh
sh ./scripts/config.sh
