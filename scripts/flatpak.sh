#!/bin/bash

## Instalação do Flatpak
sudo apt install flatpak
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Meus apps
clear
echo "[*] Instalando apps"
sh ./scripts/apps.sh
