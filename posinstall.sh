#!/bin/bash

## Update and upgrade
sudo apt update && sudo apt upgrade;

## Tamanho do barra de título dos apps
echo 'headerbar entry,
headerbar spinbutton,
headerbar button,
headerbar separator {
    margin-top: 0px; /* same as headerbar side padding for nicer proportions */
    margin-bottom: 0px;
}

headerbar {
    min-height: 24px;
    padding-left: 2px; /* same as childrens vertical margins for nicer proportions */
    padding-right: 2px;
    margin: 0px; /* same as headerbar side padding for nicer proportions */
    padding: 0px;
}' > /home/$USER/.config/gtk-3.0/gtk.css

## Intala programas
sudo apt install gnome-tweaks

## Flatpak Instalação
sudo apt install flatpak
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Meus apps
sudo snap remove firefox
sudo apt install git node-typescript make

## flatpak install flathub com.discordapp.Discord
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub org.mozilla.firefox

## Extensões
gnome-extensions disable ubuntu-dock@ubuntu.com

array=(
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

## Ícones
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

## POP Shel WM
git clone https://github.com/pop-os/shell.git
cd shell
make local-install
