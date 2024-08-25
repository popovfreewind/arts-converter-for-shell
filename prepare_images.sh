#!/bin/bash

# Clear the output directory if it exists, then recreate it
rm -rf app/images/categories
rm -rf app/images/categories_icons
mkdir -p app/images/categories
mkdir -p app/images/categories_icons

# Loop through all image files in the 'execute' directory
find execute \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0 | while IFS= read -r -d $'\0' initialPath; do
    # Extract the file name without the extension
    filename=$(basename -- "$initialPath")
    filename_no_ext="${filename%.*}"
    
    # Extract the directory name and create the corresponding output directory
    dirname=$(dirname -- "$initialPath")
    relative_dirname=${dirname#execute/}
    output_dir="app/images/categories/$relative_dirname"
    output_dir_icons="app/images/categories_icons/$relative_dirname"
    mkdir -p "$output_dir"
    mkdir -p "$output_dir_icons"
    
    # Create a new path in the output directory with the .png extension
    newPath="$output_dir/${filename_no_ext}.png"
    newPathIcon="$output_dir_icons/${filename_no_ext}.png"

    # convert to grayscale, and then threshold to black and white using ImageMagick
    magick "$initialPath" -resize 650x650 -background white -gravity center -extent 650x650 -threshold 60% -monochrome "$newPath"
    magick "$initialPath" -resize 70x70 -background white -gravity center -extent 70x70 "$newPathIcon"

    # Print a conversion message
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$newPath")"
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$newPathIcon")"

    # Delete the original file if needed (commented out by default)
    # rm "$initialPath"

done