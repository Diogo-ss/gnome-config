#!/bin/bash

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
}

decoration, window, window.background, window.titlebar, * {
border-radius: 3px;
}' > /home/$USER/.config/gtk-3.0/gtk.css

## Icones
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

## Tema - TKN
## mv /home/$USER/gnome-config/theme/Tokyonight-Storm-BL-Legacy-Buttons /home/$USER/.themes
## git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme /home/$USER/TKN &&
## mv /home/$USER/TKN/themes/Tokyonight-Dark-BL-Legacy-Buttons /home/$USER/.themes && rm -rf /home/$USER/TKN
git clone https://github.com/vinceliuice/Graphite-gtk-theme && ./Graphite-gtk-theme/install.sh --tweaks nord rimless darker normal -s standard -t all -c dark

## Ajuste do tema
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "DMZ-White"
gsettings set org.gnome.desktop.interface gtk-theme "Graphite-blue-Dark-nord"
dconf write /org/gnome/shell/extensions/user-theme/name "'Graphite-blue-Dark-nord'"

## Ajuste de extensões
## Just-perfection
dconf write /org/gnome/shell/extensions/just-perfection/dash-separator false
dconf write /org/gnome/shell/extensions/just-perfection/activities-button false
dconf write /org/gnome/shell/extensions/just-perfection/show-apps-button false

## Ding
dconf write /org/gnome/shell/extensions/ding/start-corner "'top-right'"
dconf write /org/gnome/shell/extensions/ding/icon-size "'tiny'"
dconf write /org/gnome/shell/extensions/ding/show-home false

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

## Terminal
## bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"

## Desativa extensões
## gnome-extensions disable ubuntu-dock@ubuntu.com
gnome-extensions disable dash-to-panel@jderose9.github.com

## Atalhos
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
dconf write /org/gnome/shell/extensions/clipboard-history/toggle-menu "['<Super>v']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/home "['<Super>e']"

# POP Shell
clear
echo "[*] POP Shell"
sh ./scripts/pop-shell.sh
