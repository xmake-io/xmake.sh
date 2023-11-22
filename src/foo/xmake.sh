#!/bin/sh

target "foo"
    set_kind "static"
    add_files "*.cpp"
    add_defines "FOO" "{public}"
    add_undefines "BAZ" "{public}"
    add_includedirs "." "{public}"
    after_install "foo_after_install"

foo_after_install() {
    local target=${1}
    local installdir=${2}
    echo "after installing ${target} ${installdir}"
}
