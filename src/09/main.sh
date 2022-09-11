#!/bin/bash

inputFile="/var/www/html/metrics/report.html"
sudo touch $inputFile

function page {
    cpu="$(cat /proc/stat | grep cpu |sed -n '2'p)"
    mem_free="$(free -m | sed -n 2p | awk '{print $4}')"
    disk_used="$(df / | awk 'NR==2{print $3}')"
    disk_available="$(df / | awk 'NR==2{print $4}')"
    echo "${cpu}"
    echo "${mem_free}"
    echo "Disk Used - ${disk_used}"
    echo "Disk Available - ${disk_available}"
}

while true; do
    page | tee $inputFile
    sleep 3
done