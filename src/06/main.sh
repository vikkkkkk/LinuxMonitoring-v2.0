#!/bin/bash

GREEN='\033[1;32m'; RESET='\033[0m'; RED='\033[1;31m'
if [[ $# == 0 ]]; then
    # !!! ЕСЛИ GOACCESS НЕ УСТАНОВЛЕН, ТО ВЫПОЛНИТЬ ЗАКОМЕНТИРОВАННЫЕ КОМАНДЫ !!!
    echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
    wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/goaccess.gpg add -
    sudo apt update
    sudo apt install goaccess
    sudo goaccess ../04/*.log --log-format=COMBINED -a -o index.html
    if [ -s index.html ]; then
        echo -e "${GREEN}данные записаны в index.html${RESET}"
    fi
    
else
    echo -e "${RED}n/a${RESET}"
fi