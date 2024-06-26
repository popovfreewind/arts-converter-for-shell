# Loop through all image files in the 'execute' directory
for initialPath in $(find execute -name "*.png" -or -name "*.jpg" -or -name "*.jpeg"); do
    ext="${initialPath##*.}"  # Extract the file extension
    filename=$(basename -- "$initialPath")  # Extract the file name
    dirname=$(dirname -- "$initialPath")  # Extract the directory name

    # Create a new path with the .webp extension
    newPath="$dirname/${filename%.*}.webp"

    # Convert the image to .webp format with 80% quality
    cwebp -q 90 -m 6 $initialPath -o $newPath
    #cwebp -q 30 -alpha_q 0 -m 6 -mt $initialPath -o $newPath

    # Print a conversion message
    echo "Converted" $(basename $initialPath) "to" $(basename $newPath)

    # Delete the original file
    rm $initialPath

done
