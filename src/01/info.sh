#!/bin/bash

inputFile="log.txt"
sudo touch $inputFile

function arguments {
    end=$(echo $p1 | head -c 1)
        if [[ "$end" != "/" ]]; then
            echo "АХТУНГ {$p1}: путь введён некорректно!"
            exit 1
        fi

        if [[ $p2 =~ [^0-9] ]]; then
            echo "АХТУНГ {$p2}: колличество вложенных папок некорректно!"
            exit 1
        fi

        export count=${#p3}
        if [[ ($count -gt 7) ]]; then
            echo "АХТУНГ {$p3}: в названии папок должно быть не более 7 знаков!"
            exit 1
        fi

        if [[ $p3 =~ [^A-Za-z] ]]; then
            echo "АХТУНГ {$p3}: только латиница - только хардкор!"
            exit 1
        fi

        if [[ $p4 =~ [^0-9] ]]; then
            echo "АХТУНГ {$p4}: колличество файлов в каждой папке некорректно!"
            exit 1
        fi

        if [[ $p4 -gt 100 ]]; then
            echo "АХТУНГ {$p4}: папки засорены файлами!"
            exit 1
        fi

        if [[ ! "$p5" =~ ^([a-zA-Z]{1,7}).([a-zA-Z]{1,3})$ ]]; then
            echo "АХТУНГ {$p5}: для имени файла - не более 7 знаков, для расширения - не более 3 знаков!"
            exit 1
        fi

        filesize=$p6

        onlysize=${filesize%kb}
        if [[ ! "$p6" =~ ^([0-9]+kb)$ ]]; then
            echo "АХТУНГ {$p6}: формат размера файла введён некорректно!"
            exit 1
        fi

        if [[ ! $onlysize > 0 || ! $onlysize -le 100 ]]; then
            echo "АХТУНГ {$p6}: размер файлов должен быть не более 100Кб!"
            exit 1
        fi
}

function spawn {
    folder=$p3
    filename=$(echo $p5 | awk -F. '{print $1}')
    fileExt=$(echo $p5 | awk -F. '{print $2}')
    lastNameFolder=${p3: -1}
    fileName=$filename
    oldName=$fileName
    lastNameFiles=${fileName: -1}
    logDate="$(date +"%d%m%y")"
    newDate="DATE = $(date +"%d.%m.%y")"

    if [[ ${#folder} -lt 4 ]]; then
        for (( i=${#folder}; i<4; i++ )); do
            folder+="$(echo $lastNameFolder)"
        done
    fi

    for (( i=1; i<$p2; i++ )); do
        sudo mkdir -p "$p1/"$folder"_"$logDate""
        for (( j=1; j<=$p4; j++ )); do
            sudo fallocate -l $filesize ""$p1"/"$folder"_"$logDate"/"$fileName"."$fileExt"_"$logDate""
            line=""$newDate" | "$p3"/"$folder"_"$logDate"/"$fileName"."$fileExt"_"$logDate" | Size of file = ${filesize}."
            echo "$line" | sudo tee -a $inputFile
            fileName+="$(echo $lastNameFiles)"
        done
        fileName=$oldName
        folder+="$(echo $lastNameFolder)"
    done
}

arguments
spawn
