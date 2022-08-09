#!/bin/bash

inputFile="log2.txt"
sudo touch $inputFile

function arguments {
    if [[ $p1 =~ [^A-Za-z] ]]; then
        echo "АХТУНГ {$p1}: папки названы некорректно!"
        exit
    fi

    if [[ ${#p1} -gt 7 ]]; then
        echo "АХТУНГ {$p1}: в названии папок должно быть не более 7 знаков!"
        exit
    fi

    if [[ ! "$p2" =~ ^([a-zA-Z]{1,7}).([a-zA-Z]{1,3})$ ]]; then
        echo "АХТУНГ {$p2}: для имени файла - не более 7 знаков, для расширения - не более 3 знаков!"
        exit
    fi

    export filesize=$(echo $p3 | awk -F"Mb" '{print 1}')
    if [[ !($p3 =~ Mb$) || ($filesize =~ [^0-9]) || ($filesize -gt 100) || ($filesize -le 0) ]]; then
        echo "АХТУНГ {$p3}: формат размера файла введён некорректно!"
        exit 1
    fi

    # onlysize=${filesize%Mb}
    # if [[ ! "$p3" =~ ^([0-9]+Mb)$ ]]; then
    #     echo "АХТУНГ {$p3}: формат размера файла введён некорректно!"
    #     exit 1
    # fi

    # if [[ ! $onlysize > 0 || ! $onlysize -le 100 ]]; then
    #     echo "АХТУНГ {$p3}: размер файлов должен быть не более 100Мб!"
    #     exit 1
    # fi
}

function spawn {
    folder=$p1
    folderRand="$(compgen -d / | shuf -n1)"
    fileExt=$(echo $p2 | awk -F. '{print $2}')
    lastNameFolder=${p1: -1}
    fileName=$(echo $p2 | awk -F. '{print $1}')
    oldName=$fileName
    lastNameFiles=${fileName: -1}
    logDate="$(date +"%d%m%y")"
    newDate="DATE = $(date +"%d.%m.%y")"

    count=$(( $RANDOM % 100 + 1 ))

    if [[ ${#folder} -lt 5 ]]; then
        for (( i=${#folder}; i<5; i++ )); do
            folder+="$(echo $lastNameFolder)"
        done
    fi

    for (( i=1; i<=$count; i++ )); do
        folderRand="$(compgen -d / | shuf -n1 )"
        filesCounter="$(shuf -i 1-50 -n1)"
        if [[ $folderRand == "/bin" || $folderRand == "/sbin" || $folderRand == "/root" ||  $folderRand == "/proc" || $folderRand == "/sys" ]]; then
            count++
            continue
        fi
        sudo mkdir -p "$folderRand/"$folder"_"$logDate"" 2>/dev/null
        for (( j=1; j<=${filesCounter}; j++ )); do
            echo "заполнено $i/${count} директорий и создано $j/${filesCounter} файлов"
            avelSize="$(df -h / | awk '{print $4}' | tail -n1)"
            if [[ ${avelSize: -1} == "M" ]]; then
                echo "АХТУНГ: недостаточно памяти!"
                exit
            fi
            sudo fallocate -l $filesize ""$folderRand"/"$folder"_"$logDate"/"$fileName"."$fileExt"_"$logDate"" 2>/dev/null
            line=""$newDate" | "$folderRand"/"$folder"_"$newDate"/"$fileName"."$fileExt"_"$logDate" | Размер файла = ${filesize} Mb.";
            echo "$line" | sudo tee -a $inputFile
            fileName+="$(echo $lastNameFiles)"
        done
        fileName=$oldName
        folder+="$(echo $lastNameFolder)"
    done
}

arguments
spawn

END=$(date +%s%N)
DIFF=$((($END - $start)/1000000))
TIMES=$(date +%H:%M)
echo "" | sudo tee -a $inputFile
echo "Начало: $times" | sudo tee -a $inputFile
echo "Конец: $TIMES" | sudo tee -a $inputFile
echo "Скрипт работал $DIFF мс" | sudo tee -a $inputFile
