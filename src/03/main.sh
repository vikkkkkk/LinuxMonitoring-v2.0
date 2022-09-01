#!/bin/bash

if [[ $3 == 1 ]]; then
    export p1=$1

    sudo chmod +x /info.sh
    /info.sh
else
    echo "Галя, у нас отмена!"
fi