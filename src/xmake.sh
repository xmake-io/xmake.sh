#!/bin/sh

echo "src/xmake.sh"

# defines options
option "debug" "Enable debug compilation mode."
option "tests" "Enable tests."


includes foo bar tests
