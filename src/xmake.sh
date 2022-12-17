#!/bin/sh

set_project "hello"
set_version "1.0.1" "%Y%m%d%H%M"

option "debug" "Enable debug compilation mode." false
option "tests" "Enable tests." true

option "pthread"
    add_links "pthread"
    add_cincludes "pthread.h"
    add_cfuncs "pthread_create"
option_end

option "cxx_constexpr"
    set_languages "c++11"
    add_cxxsnippets "constexpr int k = 0;"
option_end

option "lua"
    add_cfuncs "lua_pushstring"
    add_cincludes "lua.h"
    add_cincludes "lualib.h"
    add_cincludes "lauxlib.h"
    add_links "lua5.4"
    add_includedirs "/usr/include/lua5.4"
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
    add_configfiles "config.h.in"
    set_configdir "${buildir}/include"
    add_headerfiles "${buildir}/include/config.h" "hello"
    add_headerfiles "(bar/*.h)" "hello"
    add_headerfiles "foo/(*.h)" "hello"
    add_installfiles "res/(png/**.png)" "share"
    if has_config "debug"; then
        add_defines "DEBUG" "TEST"
    fi
    if is_plat "linux" "macosx"; then
        add_defines "POSIX"
    fi
    if has_config "pthread"; then
        set_configvar "HAS_PTHREAD" 1
    fi
    if has_config "cxx_constexpr"; then
        set_configvar "HAS_CONSTEXPR" 1
    fi

includes "foo" "bar"
if has_config "tests"; then
    includes "tests"
fi
