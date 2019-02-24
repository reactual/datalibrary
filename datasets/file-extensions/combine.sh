#bin/bash

# All files in this directory will be combined
SOURCE_DIR="packages/file-extension-list/data"
LOCAL_SOURCE_DIR="list"


# The local directory where txt/json files will be saved.
OUTPUT_DIR="output"

TEMP="raw_combined.txt"
TXT="extensions.txt"
JSON="extensions.json"

function createOutputDir {
  if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir "$OUTPUT_DIR"
  fi

  rm "$OUTPUT_DIR/$TEMP"
}

function combine {
  ls -1 "$SOURCE_DIR"/* | sort | while read fn ; do cat "$fn" >> "$OUTPUT_DIR/$TEMP"; done
}

function addLocalList {
  ls -1 "$LOCAL_SOURCE_DIR"/* | sort | while read fn ; do cat "$fn" >> "$OUTPUT_DIR/$TEMP"; done
}

function format {
  grep -v '^$' "$OUTPUT_DIR/$TEMP" | sort > "$OUTPUT_DIR/$TXT"
}

function makeJson {
  grep -v '^$' "$OUTPUT_DIR/$TXT" | jq -R -s -c 'split("\n")' < "$OUTPUT_DIR/$TXT" | jq -c '.[:-1]' >"$OUTPUT_DIR/$JSON"
}

echo "Combining files..."

createOutputDir
combine
addLocalList
format
makeJson

echo "Done, saved output to $TXT and $JSON"
