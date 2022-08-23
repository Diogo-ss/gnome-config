#!/bin/bash

## Meus apps
sudo snap remove firefox
sudo apt install git node-typescript make gnome-tweaks neovim nodejs npm curl
sudo apt-get install manpages-dev
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub org.mozilla.firefox
## flatpak install flathub com.discordapp.Discord
## sudo snap install authy

# Extensões
clear
echo "[*] Instalando extensões"

## Extensões - no array
array=(sound-output-device-chooser@kgshank.net
dash-to-panel@jderose9.github.com
user-theme@gnome-shell-extensions.gcampax.github.com
blur-my-shell@aunetx clipboard-history@alexsaveau.dev
emoji-selector@maestroschan.fr
gsconnect@andyholmes.github.io
just-perfection-desktop@just-perfection
soft-brightness@fifi.org
rounded-window-corners@yilozt)

for i in "${array[@]}"
do
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${i}.zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${i}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
    fi
    gnome-extensions enable ${i}
    rm ${EXTENSION_ID}.zip
done

## Aplicando configurações
clear
echo "[*] Aplicando configurações"
sh ./scripts/config.sh
