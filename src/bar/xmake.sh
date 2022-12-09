#!/bin/sh

target "bar"
    set_kind "shared"
    add_files "*.cpp"
    add_defines "BAR=\"bar\""
