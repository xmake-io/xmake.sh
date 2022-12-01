#!/bin/sh

for name in "test1 test2"; do
    target "${name}"
        set_kind "binary"
        add_files "${name}.cpp"
done
