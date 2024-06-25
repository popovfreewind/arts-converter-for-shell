#!/bin/bash

# Loop through all image files in the 'execute' directory
find execute \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0 | while IFS= read -r -d $'\0' initialPath; do
    ext="${initialPath##*.}"  # Extract the file extension
    filename=$(basename -- "$initialPath")  # Extract the file name
    dirname=$(dirname -- "$initialPath")  # Extract the directory name

    # Create a new path with the same extension
    newPath="$dirname/${filename%.*}.$ext"

    # Resize the image to 66% of its original size using ImageMagick
    magick "$initialPath" -resize 66% "$newPath"

    # Print a conversion message
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$newPath")"

    # Delete the original file
    #rm "$initialPath"

done