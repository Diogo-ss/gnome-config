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

## Flatpak Instalação
sudo apt install flatpak
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Meus apps
sudo snap remove firefox
sudo apt install git node-typescript make gnome-tweaks neovim nodejs npm curl
## sudo snap install authy
sudo apt-get install manpages-dev

## flatpak install flathub com.discordapp.Discord
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub org.mozilla.firefox

array=(
sound-output-device-chooser@kgshank.net
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

## Tema Download
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme &&
mv Tokyo-Night-GTK-Theme/themes/Tokyonight-Storm-BL-Legacy-Buttons /home/$USER/.themes

## Ajuste do tema
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "DMZ-White"
gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark-BL-Legacy-Buttons"

## Ajuste de extensões
## Just-perfection
dconf write /org/gnome/shell/extensions/just-perfection/dash-separator false
dconf write /org/gnome/shell/extensions/just-perfection/activities-button false
dconf write /org/gnome/shell/extensions/just-perfection/show-apps-button false

## Dash-to-dock-cosmic
dconf write /org/gnome/shell/extensions/dash-to-dock/extend-height false
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-position "'BOTTOM'"
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size 26
dconf write /org/gnome/shell/extensions/dash-to-dock/running-indicator-style "'DASHES'"

## Sound
dconf write /org/gnome/shell/extensions/sound-output-device-chooser/expand-volume-menu false

## Oculta icones na barra superior
dconf write /org/gnome/shell/extensions/emoji-selector/always-show false
dconf write /org/gnome/shell/extensions/clipboard-history/display-mode 3

## Desativa extensões
gnome-extensions disable dash-to-panel@jderose9.github.com
gnome-extensions disable ubuntu-dock@ubuntu.com

## Atalhos
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
dconf write /org/gnome/shell/extensions/clipboard-history/toggle-menu "['<Super>v']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/home "['<Super>e']"

## Remove arqivos desnecessários
rm -rf /home/$USER/gnome-config

## POP Shel WM
pause ()
{
REPLY=Y
while [ "$REPLY" == "Y" ] || [ "$REPLY" != "y" ]
do
 echo -e "Deseja instalar o POP Shell [y/n]" 
 read -n1 -s
     case "$REPLY" in
     "n")  clear && echo "Prontoo!" && exit       	;;
     "N")  clear && echo "Prontoo!" && exit       	;; 
     "y")  clear                     	          	;;
     "Y")  REPLY=y 					;;
     * )  clear && echo "$REPLY Opcão inválida."  	;;
esac
done
}
pause
clear
echo "Instalando POP Shell"
git clone https://github.com/pop-os/shell.git /home/$USER/POP-SELL-TMP
cd /home/$USER/POP-SELL-TMP
make local-install
