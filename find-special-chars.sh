#!/bin/bash

# Find files with special or non-common characters in filenames only
# This script recursively searches and displays ONLY files with special characters
# Usage:
#   ./find-special-chars.sh
#   ./find-special-chars.sh /path/to/directory

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist"
  exit 1
fi

echo "=== Files with Special Characters in Filenames ==="
echo ""

found_count=0

find "$TARGET_DIR" -depth | while read -r file; do
  filename=$(basename "$file")
  
  # Check if filename contains non-ASCII characters or special symbols
  if ! echo "$filename" | LC_ALL=C grep -qE '^[a-zA-Z0-9._\- ]+$'; then
    special_chars=$(echo "$filename" | sed 's/[a-zA-Z0-9._\- ]//g' | fold -w1 | sort -u)
    echo "$file"
  fi
done

echo ""
echo "=== Scan Complete ==="
