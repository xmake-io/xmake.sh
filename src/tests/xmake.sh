#!/bin/sh

local tests="test1 test2"
for name in ${tests}; do
    target "${name}"
        set_kind "binary"
        add_files "${name}.cpp"
done
