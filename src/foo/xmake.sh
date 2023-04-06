#!/bin/sh

target "foo"
    set_kind "static"
    add_files "*.cpp"
    add_defines "FOO" "{public}"
    add_defines "SPACES=\"it works\"" "{public}"
    add_undefines "BAZ" "{public}"
    add_includedirs "." "{public}"
