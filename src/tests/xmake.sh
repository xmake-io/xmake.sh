#!/bin/sh

local tests="test1 test2"
for name in ${tests}; do
    target "${name}"
        set_kind "binary"
        add_files "${name}.cpp"
        add_defines "TEST=\"${name}\""
        add_cxflags "-DIMPL_API=\"extern \\\"C\\\" \""
done
