#!/bin/sh

local tests="test1 test2"
for name in ${tests}; do
    target "${name}"
        set_kind "binary"
        add_files "${name}.cpp"
        add_defines "TEST=\"${name}\""
        add_cxflags "-DIMPL_API=\"extern \\\"C\\\" \""
done

target "test_replace"
    set_kind "binary"
    add_deps "foo"
    add_files "test_replace.cpp" "{replace = {HELLO_REPLACE, hello}}" "{replace = {VERSION_REPLACE, 1.0.0}}"
