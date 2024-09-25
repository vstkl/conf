#!/bin/bash
yay -Qi $1  | grep -E '^\s*[0-z\-]*:' -o | sed -e 's/^\s*//'  -e 's/://' | sort | uniq | xargs yay -Syu -
