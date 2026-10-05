#!/bin/bash

# Find files with special or non-common characters in filenames for macOS
# This script recursively searches for files with non-ASCII or special characters in their names only
# Usage:
#   ./find-special-chars.sh
#   ./find-special-chars.sh /path/to/directory

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist"
  exit 1
fi

echo "=== Files with Special or Non-Common Characters in Filenames ==="
echo "Searching in: $TARGET_DIR"
echo ""

# Find files with non-ASCII or special characters in their names ONLY
find "$TARGET_DIR" -depth | while read -r file; do
  filename=$(basename "$file")
  
  # Check if filename contains non-ASCII characters or special symbols
  # Allow only: letters, numbers, dots, hyphens, underscores, spaces
  if ! echo "$filename" | LC_ALL=C grep -qE '^[a-zA-Z0-9._\- ]+$'; then
    # Extract the special characters found
    special_chars=$(echo "$filename" | sed 's/[a-zA-Z0-9._\- ]//g' | fold -w1 | sort -u)
    
    echo "File: $file"
    echo "  Filename: $filename"
    echo "  Special characters: $special_chars"
    echo ""
  fi
done

echo "=== Scan Complete ==="
