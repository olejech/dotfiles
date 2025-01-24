#!/bin/sh

output_file="${ZETTELKASTEN_PATH}Vocabulary/english.md"

text="$1"

if [ -n "$text" ]; then
  if echo "$text" >> "$output_file"; then
    echo "Saved: $text"
  else
    echo "Error: can't open file: $output_file" >&2
    exit 1
  fi
else
  echo "Error: Text is empty" >&2
  exit 1
fi
