#!/bin/bash

date="$(cat ../02/log2.txt | awk -F'|' '{print $2}' | awk -F'_' {print $3})"
newDate=${date: -7}

function clean {
    cd
    sudo rm -rf *$newDate
    cd /
    sudo rm -rf /boot/*$newDate
    sudo rm -rf /cdrom/*$newDate
    sudo rm -rf /dev/*$newDate
    sudo rm -rf /etc/*$newDate
    sudo rm -rf /home/*$newDate
    sudo rm -rf /lib/*$newDate
    sudo rm -rf /lib32/*$newDate
    sudo rm -rf /lib64/*$newDate
    sudo rm -rf /libx32/*$newDate
    sudo rm -rf /media/*$newDate
    sudo rm -rf /mnt/*$newDate
    sudo rm -rf /opt/*$newDate
    sudo rm -rf /proc/*$newDate
    sudo rm -rf /run/*$newDate
    sudo rm -rf /snap/*$newDate
    sudo rm -rf /srv/*$newDate
    sudo rm -rf /sys/*$newDate
    sudo rm -rf /tmp/*$newDate
    sudo rm -rf /usr/*$newDate
    sudo rm -rf /var/*$newDate
    sudo rm -rf /root/*$newDate
    sudo rm -rf /lost+found/*$newDate
}

function arguments {

    # Log files
    if [[ "$p1" -eq "1" ]]; then
        file="$(cat ../02/log2.txt | awk -F'|' '{print $2}')"
        for i in $file; do
            sudo rm -rf $i
            echo "${i}"
        done
        sudo rm -rf ../02/log2.txt
        echo "Файл log2.txt - УДАЛЁН"

    # date and time of creation
    elif [[ "$p1" -eq "2" ]]: then
        echo "Введите >DATE< >TIME< Например: >YYYY-MM-DD HH:MM<"
        read srcDate srcTime
        echo "Введите >DATE< >TIME< Например: >YYYY-MM-DD HH:MM<"
        read srcDate srcTime
        sudo rm -rf $(find / -newermt "$srcDate $srcTime" -not -newermt ")
    fi
    # По дате и времени создания
        sudo rm -r $(find / -newermt "$srcDate $srcTime" -not -newermt "$dstDate $dstTime+1" 2>/dev/null | grep $newDate | sort) 2>/dev/null
        echo "удалены папки: $(find / -newermt "$srcDate $srcTime" -not -newermt "$dstDate $dstTime+1" 2>/dev/null | grep $newDate | sort)"
        sudo rm -rf ../02/log2.txt
        echo "удален файл log2.txt"
    # По маске имени (т.е. символы, нижнее подчёркивание и дата).
    elif [[ "$param1" -eq "3" ]]; then
        clean
        sudo rm -rf ../02/log2.txt
        echo "удален файл log2.txt"
    else
        echo "неверный параметр, введите параметр от 1 до 3!"
    fi
}

arguments