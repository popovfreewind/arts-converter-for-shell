#!/bin/bash

# Clear the output directory if it exists, then recreate it
rm -rf output
mkdir -p output

# Loop through all image files in the 'execute' directory
find execute \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -print0 | while IFS= read -r -d $'\0' initialPath; do
    # Extract the file name without the extension
    filename=$(basename -- "$initialPath")
    filename_no_ext="${filename%.*}"
    
    # Extract the directory name and create the corresponding output directory
    dirname=$(dirname -- "$initialPath")
    relative_dirname=${dirname#execute/}
    output_dir="output/$relative_dirname"
    mkdir -p "$output_dir"
    
    # Create a new path in the output directory with the .png extension
    newPath="$output_dir/${filename_no_ext}.jpg"

    # Resize the image to fit within a 650x650 pixel canvas, add a white background,
    # convert to grayscale, and then threshold to black and white using ImageMagick
    #magick "$initialPath" -resize 650x650 -background white -gravity center -extent 650x650 -threshold 60% -monochrome "$newPath"
    magick "$initialPath" -resize 1920x1080 -gravity center -extent 1920x1080 "$newPath"

    # Print a conversion message
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$newPath")"

    # Delete the original file if needed (commented out by default)
    # rm "$initialPath"

done