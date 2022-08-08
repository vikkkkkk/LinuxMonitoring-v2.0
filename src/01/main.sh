#!/bin/bash

if [[ $# == 6 ]]; then
    export p1=$1
    export p2=$2
    export p3=$3
    export p4=$4
    export p5=$5
    export p6=$6

    sudo chmod +x ./info.sh
    ./info.sh
else
    echo "Галя, у нас отмена!"
fi
