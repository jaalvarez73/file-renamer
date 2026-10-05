#!/bin/bash
set -e

# Recursive filename replacer for macOS
# Usage:
#   ./rename-files.sh "ì" "í"
#   ./rename-files.sh " " "_"

FROM="${1:-}"
TO="${2:-}"

if [ -z "$FROM" ] || [ -z "$TO" ]; then
  echo "Usage: $0 \"FROM\" \"TO\""
  echo "Example: $0 \"ì\" \"í\""
  exit 1
fi

find . -depth -name "*$FROM*" -print0 |
while IFS= read -r -d '' file; do
  new="${file//$FROM/$TO}"
  if [ "$file" != "$new" ]; then
    echo "Renaming: $file -> $new"
    mv -- "$file" "$new"
  fi
done
