#!/bin/bash

set -e

should_exit="false"

for file in $(cd sources && ls); do
  # Check the file has a .json extension.
  if echo $file | grep -qv '.json'; then
    echo "$file is missing a .json extension"
    should_exit="true"
  fi
  # Check the file does not contain hyphens.
  if echo $file | grep -q '-'; then
    echo "$file is invalid. Replace dashes (-) with underscores (_)."
    should_exit="true"
  fi
  # Check that the id matches the filename.
  filename="$(basename 'sources/'$file .json)"
  json_id="$(jq -r '.id' 'sources/'$file | tr '[:upper:]' '[:lower:]')"
  if ! test "$filename" == "$json_id"; then
    echo "$file is invalid. The id in the json: $json_id does not match the filename."
    should_exit="true"
  fi
done

if $should_exit == "true"; then
  exit 1;
fi
