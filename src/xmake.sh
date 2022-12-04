#!/bin/sh

option "debug" "Enable debug compilation mode." false
option "tests" "Enable tests." true

target "demo"
    set_kind "binary"
    add_deps "foo" "bar"
    add_files "main.cpp"
    add_includedirs "foo" "bar"
    if has_config "debug"; then
        add_defines "DEBUG" "TEST"
    fi
    if is_plat "linux" "macosx"; then
        add_defines "POSIX"
    fi

includes "foo" "bar"
if has_config "tests"; then
    includes "tests"
fi
