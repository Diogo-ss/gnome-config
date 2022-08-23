#!/bin/bash

## instalção do pop shell
echo "Instalando POP Shell"
git clone https://github.com/pop-os/shell.git
cd shell
make local-install
