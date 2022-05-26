#!/bin/bash

for initialPath in $(find execute -name "*.png" -or -name "*.jpg" -or -name "*.jpeg") ; do
    ext="${initialPath#*.}"

    newPath=${initialPath//$ext/webp}

    convert -quality 100 $initialPath $newPath

    echo "convert" $(basename $initialPath) "to" $(basename $newPath)

    rm $initialPath

done