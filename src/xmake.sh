#!/bin/sh

set_project "hello"
set_version "1.0.1" "%Y%m%d%H%M"

option "debug" "Enable debug compilation mode." false
option "tests" "Enable tests." true

option "pthread"
    add_links "pthread"
    add_cincludes "pthread.h"
    add_cfuncs "pthread_create"
    add_defines "HAS_PTHREAD"
    set_configvar "HAS_PTHREAD" 1
option_end

option "cxx_constexpr"
    set_languages "c++11"
    add_cxxsnippets "constexpr int k = 0;"
    add_defines "HAS_CONSTEXPR"
    set_configvar "HAS_CONSTEXPR" 1
option_end

set_warnings "all" "error"
set_languages "c99" "c++11"
if is_mode "debug"; then
    set_symbols "debug"
    set_optimizes "none"
else
    set_strip "all"
    set_symbols "hidden"
    set_optimizes "smallest"
fi

target "demo"
    set_kind "binary"
    add_deps "foo" "bar"
    add_files "*.cpp"
    add_includedirs "foo" "bar"
    add_options "pthread" "cxx_constexpr"
    add_configfiles "config.h.in"
    set_configdir "${buildir}/include"
    add_headerfiles "${buildir}/include/config.h"
    add_headerfiles "bar/*.h"
    add_headerfiles "foo/*.h"
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
