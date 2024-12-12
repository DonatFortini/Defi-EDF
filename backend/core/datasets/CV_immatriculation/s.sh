#!/bin/bash

# Directory containing the photos
PHOTO_DIR="datasets/CV_immatriculation/test"
JSON_FILE="datasets/CV_immatriculation/output.json"

# Ensure the directory exists
if [ ! -d "$PHOTO_DIR" ]; then
    echo "Directory $PHOTO_DIR does not exist."
    exit 1
fi

# Initialize JSON file
echo "[]" >"$JSON_FILE"

# Counter for naming files
counter=1

# Loop through all images in the directory
for file in "$PHOTO_DIR"/*.{jpg,jpeg,png,gif}; do
    # Skip if no matching files
    [ -e "$file" ] || continue

    # Construct the new name
    new_name="test_file${counter}$(echo "$file" | grep -oE '\.[^\.]+$')"
    new_path="${PHOTO_DIR}/${new_name}"

    # Rename the file
    mv "$file" "$new_path"

    # Add entry to JSON file
    jq --arg path "$new_path" --arg placeholder "Placeholder string" --arg filename "$new_name" \
        '. += [{"path": $path, "key_name": $placeholder, "file_name": $filename}]' \
        "$JSON_FILE" >tmp.json && mv tmp.json "$JSON_FILE"

    # Increment the counter
    counter=$((counter + 1))
done

echo "Renaming complete and JSON file created at $JSON_FILE."
