#!/bin/bash

# Check if ImageMagick is installed
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick (convert command) is not installed."
    exit 1
fi

# Check if source directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <source_directory>"
    exit 1
fi

source_dir="$1"
target_dir="${source_dir}-webp"

# Create target directory if it doesn't exist
mkdir -p "$target_dir"

# Find all image files recursively and process them
find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) | while read -r file; do
    # Get relative path
    rel_path="${file#$source_dir/}"
    
    # Create target directory structure
    target_file="$target_dir/${rel_path%.*}.webp"
    mkdir -p "$(dirname "$target_file")"
    
    # Convert to webp
    echo "Converting: $file -> $target_file"
    magick "$file" -quality 86 "$target_file"
done

echo "Conversion complete. WebP images are in: $target_dir"
