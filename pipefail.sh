#!/bin/sh

# From https://stackoverflow.com/a/75532544/2332415

if ! (set -o  pipefail 2>/dev/null); then
    echo "There is no pipefail"
else
    echo "Setting pipefail"
    set -o pipefail
fi

false | true
echo "false | true -> $?"
