#!/bin/bash

if [[ $p1 == 1 ]]; then
    for (( i=1; i < 6; i++ )); do
        sort -k 9 ../04/$i.log -o sort$i.log
        cat sort$i.log
    done
elif [[ $p1 == 2 ]]; then
    for (( i = 1; i < 6; i++ )); do
        awk '{print $1}' ../04/$i.log > sort$i.log
        cat sort$i.log
    done
elif [[ $p1 == 3 ]]; then
    for (( i = 1; i < 6; i++ )); do
        awk '$9 ~ /[45]/' ../04/$i.log > sort$i.log
        cat sort$i.log
    done
elif [[ $p1 == 4 ]]; then
    for (( i = 1; i < 6; i++ )); do
        awk '$9 ~ /[45]/' ../04/$i.log > temp.log
        awk '{print $1}' temp.log > sort$i.log
        sudo rm -rf temp.log
        cat sort$i.log
    done
else
    echo "АХТУНГ ${p1}: используейте параметры в промежутке от 1 до 4"
    exit
fi


