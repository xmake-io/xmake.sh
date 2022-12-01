#!/bin/sh

option "debug" "Enable debug compilation mode."
option "tests" "Enable tests."

target "demo"
    set_kind "binary"
    add_deps "foo" "bar"
    add_files "main.cpp"
    if has_config "debug"; then
        add_defines "DEBUG"
    fi
    if is_host "linux" "macosx"; then
        add_defines "POSIX"
    fi

includes "foo" "bar"
if has_config "tests"; then
    includes "tests"
fi
