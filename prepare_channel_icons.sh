#!/bin/bash

# Clear the output directory if it exists, then recreate it
rm -rf output
mkdir -p output

# Loop through all image files in the 'execute' directory
find execute \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -print0 | while IFS= read -r -d $'\0' initialPath; do
    # Extract the file name without the extension
    filename=$(basename -- "$initialPath")
    filename_no_ext="${filename%.*}"

    # Extract the directory name and create the corresponding output directory
    dirname=$(dirname -- "$initialPath")
    relative_dirname=${dirname#execute/}
    output_dir="output/$relative_dirname"
    mkdir -p "$output_dir"

    # Create a new path in the output directory with the .png extension
    fhd="$output_dir/${filename_no_ext}_fhd.png"
    hd="$output_dir/${filename_no_ext}_hd.png"
    sd="$output_dir/${filename_no_ext}_sd.png"

    # Resize the image to squeeze into the exact dimensions without cropping
    magick "$initialPath" -resize 540x405\! "$fhd"
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$fhd")"

    magick "$initialPath" -resize 290x218\! "$hd"
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$hd")"

    magick "$initialPath" -resize 246x140\! "$sd"
    echo "Converted" "$(basename "$initialPath")" "to" "$(basename "$sd")"

    # Delete the original file if needed (commented out by default)
    # rm "$initialPath"

done
