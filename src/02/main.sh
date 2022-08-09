#!bin/bash

export start=$(date +%s%N)
export times=$(date +%H:%M)

if [[ $# == 3 ]]; then
    export p1=$1
    export p2=$2
    export p3=$3

    sudo chmod +x ./info.sh
    ./info.sh
else
    echo "Галя, у нас отмена!"
fi