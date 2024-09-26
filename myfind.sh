#!/bin/bash

# Check if folder and substring are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <folder> <substring>"
  exit 1
fi

FOLDER="$1"
SUBSTRING="$2"

# Find all files in the folder (including subdirectories)
FILES=($(find "$FOLDER" -type f 2>/dev/null))

# Check if there are files to process
TOTAL_FILES=${#FILES[@]}
if [ "$TOTAL_FILES" -eq 0 ]; then
  echo "No files found in the specified folder."
  exit 1
fi

# Array to store files that contain the substring
declare -a FOUND_FILES

# Process each file and search for the substring
for ((i = 0; i < TOTAL_FILES; i++)); do
  FILE="${FILES[$i]}"

  if grep -iq "$SUBSTRING" "$FILE" 2>/dev/null; then
    FOUND_FILES+=("$FILE")
  fi

  # Show progress percentage
  PERCENTAGE=$(((i + 1) * 100 / TOTAL_FILES))
  echo "Progress: $((i + 1))/$TOTAL_FILES files processed ($PERCENTAGE%)"
done

# Output results at the end
echo "Search completed. Files containing the substring:"
for file in "${FOUND_FILES[@]}"; do
  echo "$file"
done

echo "Total files processed: $TOTAL_FILES"
echo "Total files containing the substring: ${#FOUND_FILES[@]}"
