#!/bin/bash

# Create the output directory if it doesn't exist
mkdir -p output

# Loop through all image files in the 'execute' directory
find execute \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0 | while IFS= read -r -d $'\0' initialPath; do
    # Extract the file name without the extension
    filename=$(basename -- "$initialPath")
    filename_no_ext="${filename%.*}"
    
    # Create a new path in the output directory with the .png extension
    newPath="output/${filename_no_ext}.png"

    # Resize the image to 650x650 pixels using ImageMagick
    magick "$initialPath" -resize 650x650\! "$newPath"

    # Print a conversion message
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$newPath")"

    # Delete the original file if needed
    # rm "$initialPath"

done