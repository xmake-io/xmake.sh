#!/bin/sh

echo "src/xmake.sh"

option "debug" "Enable debug compilation mode."
option "tests" "Enable tests."

target "demo"
    set_kind "binary"
    add_deps "foo" "bar"
    add_files "main.cpp"
    if has_config "debug"; then
        add_defines "DEBUG"
    fi

includes "foo" "bar"
if has_config "tests"; then
    includes "tests"
fi
