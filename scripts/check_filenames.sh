#!/bin/bash

set -e

should_exit="false"

for file in $(cd sources && ls); do
  if echo $file | grep -qv '.json'; then
    echo "$file is missing a .json extension"
    should_exit="true"
  fi
  if echo $file | grep -q '-'; then
    echo "$file is invalid. Replace dashes (-) with underscores (_)."
    should_exit="true"
  fi
done

if $should_exit == "true"; then
  exit 1;
fi
