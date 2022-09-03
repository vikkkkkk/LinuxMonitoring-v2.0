#!/bin/bash

if [[ $# == 0 ]]; then
    sudo chmod +x ./info.sh
    ./info.sh
else
    echo "Галя, у нас отмена!"
fi