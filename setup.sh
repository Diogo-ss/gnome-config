#!/bin/bash

sudo apt update && sudo apt upgrade;

echo -e "[*] Iniciando Instalação."

## Iniciando Flatpak
clear
echo -e "[*] Iniciando Flatpak"
sh ./scripts/flatpak.sh
