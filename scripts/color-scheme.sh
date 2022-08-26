#!/bin/bash

## Tema por https://github.com/Peter-van-der-Velde/Two-Dark

mkdir -pv ~/.local/share/gtksourceview-3.0/styles/
mkdir -pv ~/.local/share/gtksourceview-4/styles/

cp -v ./theme_two_dark.xml ~/.local/share/gtksourceview-3.0/styles/
cp -v ./theme_two_dark.xml ~/.local/share/gtksourceview-4/styles/

## Terminal por https://github.com/denysdovhan/one-gnome-terminal
bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"

## Extensões
clear
echo "[*] Aplicando configurações e temas"
## sh ./scripts/extension.sh
sh ./scripts/config.sh
