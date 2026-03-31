<div align="center">
  <a href="https://xmake.io">
    <img width="160" height="160" src="https://xmake.io/assets/img/logo.png">
  </a>

  <h1>xmake.sh</h1>

  <div>
    <a href="https://github.com/xmake-io/xmake.sh/actions?query=workflow%3ALinux">
      <img src="https://img.shields.io/github/actions/workflow/status/xmake-io/xmake.sh/ubuntu.yml?branch=master&style=flat-square&logo=linux" alt="github-ci" />
    </a>
    <a href="https://github.com/xmake-io/xmake.sh/actions?query=workflow%3AmacOS">
      <img src="https://img.shields.io/github/actions/workflow/status/xmake-io/xmake.sh/macos.yml?branch=master&style=flat-square&logo=apple" alt="github-ci" />
    </a>
    <a href="https://github.com/xmake-io/xmake.sh/releases">
      <img src="https://img.shields.io/github/release/xmake-io/xmake.sh.svg?style=flat-square" alt="Github All Releases" />
    </a>
  </div>
  <div>
    <a href="https://github.com/xmake-io/xmake.sh/blob/master/LICENSE.md">
      <img src="https://img.shields.io/github/license/xmake-io/xmake.sh.svg?colorB=f48041&style=flat-square" alt="license" />
    </a>
    <a href="https://www.reddit.com/r/xmake/">
      <img src="https://img.shields.io/badge/chat-on%20reddit-ff3f34.svg?style=flat-square" alt="Reddit" />
    </a>
    <a href="https://gitter.im/xmake-io/xmake?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge">
      <img src="https://img.shields.io/gitter/room/xmake-io/xmake.svg?style=flat-square&colorB=96c312" alt="Gitter" />
    </a>
    <a href="https://t.me/tbooxorg">
      <img src="https://img.shields.io/badge/chat-on%20telegram-blue.svg?style=flat-square" alt="Telegram" />
    </a>
    <a href="https://jq.qq.com/?_wv=1027&k=5hpwWFv">
      <img src="https://img.shields.io/badge/chat-on%20QQ-ff69b4.svg?style=flat-square" alt="QQ" />
    </a>
    <a href="https://discord.gg/xmake">
      <img src="https://img.shields.io/badge/chat-on%20discord-7289da.svg?style=flat-square" alt="Discord" />
    </a>
    <a href="https://xmake.io/#/sponsor">
      <img src="https://img.shields.io/badge/donate-us-orange.svg?style=flat-square" alt="Donate" />
    </a>
  </div>

  <b>A script-only build utility like autotools</b><br/>
</div>

## Support this project

Support this project by [becoming a sponsor](https://xmake.io/#/about/sponsor). Your logo will show up here with a link to your website. 🙏

<a href="https://opencollective.com/xmake#sponsors" target="_blank"><img src="https://opencollective.com/xmake/sponsors.svg?width=890"></a>
<a href="https://opencollective.com/xmake#backers" target="_blank"><img src="https://opencollective.com/xmake/backers.svg?width=890"></a>

## Technical Support

You can also consider sponsoring us to get extra technical support services via the [Github sponsor program](https://github.com/sponsors/waruqi),
This gives you access to the [xmake-io/technical-support](https://github.com/xmake-io/technical-support) repository, where you can get more information on consulting.

- [x] Handling Issues with higher priority
- [x] One-to-one technical consulting service
- [x] Review your xmake.lua and provide suggestions for improvement

## Introduction

Xmake.sh is a script-only build utility like autotools.

#### Advantages

- [x] No any dependencies
- [x] No installation, only one shell script file
- [x] Easy, similar configuration syntax to xmake
- [x] Compatible with autotools, same usage

#### Supported features

- [x] Generate makefile
- [x] Generate build.ninja
- [x] Custom toolchains
- [x] Detect options, code snippets, dependencies, compiler features
- [x] Support builtin variables

### New project

Copy `./configure` script file to your project root directory.

### Write project configuration

We just write `xmake.sh` project file, like this:

```sh
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
    add_cincludes "lua.h" "lualib.h" "lauxlib.h"
    before_check "option_find_lua"
option_end

option_find_lua() {
    option "lua"
        add_cxflags `pkg-config --cflags lua5.4 2>/dev/null`
        add_ldflags `pkg-config --libs lua5.4 2>/dev/null`
    option_end
}

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
    set_configdir "${builddir}/include"
    add_headerfiles "${builddir}/include/config.h" "hello"
    add_headerfiles "(bar/*.h)" "hello"
    add_headerfiles "foo/(*.h)" "hello"
    add_installfiles "res/(png/**.png)" "share"
    add_options "lua"
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
```

### Makefile generator

#### Configure and generate makefile

```console
$ ./configure
```

#### Build project

```console
$ make
```

#### Install artifacts

```console
$ make install
```

#### Run program

```console
$ make run
```

### Ninja generator

#### Configure and generate build.ninja

```console
$ ./configure --generator=ninja
```

#### Build project

```console
$ ninja
```

#### Install artifacts

```console
$ ninja install
```

#### Run program

```console
$ ninja run
```

### Supported apis

#### Global scope

##### set_project

Set the project name.

```sh
set_project "hello"
```

##### set_version

Set the project version, optional build date format and soname version.

```sh
set_version "1.0.1" "%Y%m%d%H%M" "1"
```

##### includes

Include sub-project files from subdirectories.

```sh
includes "foo" "bar"
```

##### Condition functions

```sh
# check target platform: linux, macosx, windows, mingw, cross, ...
if is_plat "linux" "macosx"; then ... fi

# check target architecture: x86_64, arm64, ...
if is_arch "x86_64"; then ... fi

# check host OS: linux, macosx, msys, cygwin, ...
if is_host "linux"; then ... fi

# check build mode: debug, release, ...
if is_mode "debug"; then ... fi

# check if an option config value equals a specific value
if is_config "option_name" "value"; then ... fi

# check if an option is enabled
if has_config "pthread"; then ... fi
```

##### set_config

Set a config option value.

```sh
set_config "option_name" "value"
```

#### Target scope

##### target / target_end

Define a build target. All target settings between `target` and `target_end` (or the next `target`) belong to this target.

```sh
target "demo"
    set_kind "binary"
    add_files "*.cpp"
target_end
```

##### set_kind

Set the target type: `binary`, `static`, or `shared`.

```sh
set_kind "binary"
set_kind "static"
set_kind "shared"
```

##### set_default

Set whether this target is built by default.

```sh
set_default false
```

##### add_deps

Add target dependencies.

```sh
add_deps "foo" "bar"
```

##### add_files

Add source files with glob patterns. Supports `{replace = {search, replace}}` to replace text content before compilation.
The original source files will not be modified, temporary files will be generated in the `build/.replace/` directory.

```sh
add_files "*.cpp"
add_files "src/**/*.c"
add_files "*.cpp" "{replace = {HELLO, hello}}" "{replace = {VERSION, 1.0.0}}"
```

##### set_basename / set_extension / set_filename / set_prefixname

Set the target output file naming.

```sh
set_basename "demo"       # output base name
set_extension ".exe"      # output file extension
set_filename "demo.exe"   # output full filename
set_prefixname "lib"      # output prefix (e.g. "lib" for libfoo.a)
```

##### set_targetdir / set_objectdir

Set custom output directories for the target binary and object files.

```sh
set_targetdir "${builddir}/bin"
set_objectdir "${builddir}/objs"
```

##### add_defines / add_undefines

Add preprocessor definitions or undefinitions. Use `{public}` to propagate to dependent targets.

```sh
add_defines "DEBUG" "TEST"
add_defines "FOO=bar" "{public}"
add_undefines "NDEBUG"
```

##### add_includedirs

Add header search directories. Use `{public}` to propagate to dependent targets.

```sh
add_includedirs "src" "include"
add_includedirs "include" "{public}"
```

##### add_linkdirs

Add library search directories. Use `{public}` to propagate to dependent targets.

```sh
add_linkdirs "/usr/local/lib"
add_linkdirs "lib" "{public}"
```

##### add_rpathdirs

Add runtime library search directories (RPATH).

```sh
add_rpathdirs "/usr/local/lib"
```

##### add_links / add_syslinks

Add link libraries or system libraries. Use `{public}` to propagate to dependent targets.

```sh
add_links "foo" "bar"
add_links "foo" "{public}"
add_syslinks "pthread" "dl" "m"
```

##### set_strip

Set the strip mode: `all`, `debug`.

```sh
set_strip "all"
```

##### set_symbols

Set the symbol info mode: `debug`, `hidden`.

```sh
set_symbols "debug"
set_symbols "hidden"
```

##### set_languages

Set the C/C++ language standards.

```sh
set_languages "c99" "c++11"
```

##### set_warnings

Set the warning levels: `all`, `error`, `allextra`, `everything`, `none`.

```sh
set_warnings "all" "error"
```

##### set_optimizes

Set the optimization levels: `none`, `fast`, `faster`, `fastest`, `smallest`, `aggressive`.

```sh
set_optimizes "fastest"
```

##### add_frameworks / add_frameworkdirs

Add Apple frameworks and framework search directories (macOS/iOS). Use `{public}` to propagate to dependent targets.

```sh
add_frameworks "CoreFoundation" "Security"
add_frameworkdirs "/Library/Frameworks"
```

##### Compiler/linker flags

Add raw compiler and linker flags directly.

```sh
add_cflags "-fno-strict-aliasing"         # C only
add_cxflags "-DFOO"                       # C and C++
add_cxxflags "-fno-rtti"                  # C++ only
add_mflags "-fmodules"                    # Objective-C only
add_mxflags "-fmodules"                   # Objective-C and Objective-C++
add_mxxflags "-fno-objc-arc"              # Objective-C++ only
add_asflags "-DASM_FLAG"                  # Assembler
add_ldflags "-L/usr/local/lib"            # Binary linker
add_shflags "-shared"                     # Shared library linker
add_arflags "-cr"                         # Static library archiver
```

##### add_configfiles / set_configdir / set_configvar

Add config header template files with variable substitution. Template files use `${VAR}` placeholders.

```sh
add_configfiles "config.h.in"
set_configdir "${builddir}/include"
set_configvar "HAS_PTHREAD" 1
set_configvar "VERSION" "1.0.0"
```

##### set_installdir / add_installfiles / add_headerfiles

Set install directory and add files for installation. Parentheses `()` define the relative path portion to install.

```sh
set_installdir "/usr/local"
add_installfiles "res/(png/**.png)" "share"
add_headerfiles "(include/*.h)" "mylib"
add_headerfiles "src/(*.h)" "mylib"
```

##### add_options

Bind option dependencies to this target. Use `{public}` to propagate to dependent targets.

```sh
add_options "pthread" "lua"
```

##### before_install / after_install

Set callback functions to run before or after installation.

```sh
before_install "my_before_install"
after_install "my_after_install"

my_before_install() {
    echo "preparing install ..."
}
```

##### set_version (target scope)

Set version for the target with optional build date format and soname version.

```sh
set_version "1.0.1" "%Y%m%d%H%M" "1"
```

#### Option scope

##### option / option_end

Define a config option. Short form with inline description and default value, or block form for complex detection.

```sh
# short form
option "debug" "Enable debug mode." false

# block form
option "pthread"
    add_links "pthread"
    add_cincludes "pthread.h"
    add_cfuncs "pthread_create"
option_end
```

##### set_default / set_description / set_showmenu

Set option properties.

```sh
option "myopt"
    set_default true
    set_description "Enable my feature."
    set_showmenu true
option_end
```

##### before_check

Set a callback function to run before option detection.

```sh
option "lua"
    add_cfuncs "lua_pushstring"
    add_cincludes "lua.h"
    before_check "option_find_lua"
option_end

option_find_lua() {
    option "lua"
        add_cxflags `pkg-config --cflags lua5.4 2>/dev/null`
        add_ldflags `pkg-config --libs lua5.4 2>/dev/null`
    option_end
}
```

##### Detection functions

Check for C/C++ functions, includes, types, and code snippets during option detection.

```sh
option "pthread"
    add_cfuncs "pthread_create"           # check C functions exist
    add_cxxfuncs "std::thread::joinable"  # check C++ functions exist
    add_cincludes "pthread.h"             # check C headers exist
    add_cxxincludes "thread"              # check C++ headers exist
    add_ctypes "pthread_t"                # check C types exist
    add_cxxtypes "std::string"            # check C++ types exist
    add_csnippets "int x = 0;"            # check C code snippet compiles
    add_cxxsnippets "constexpr int k = 0;" # check C++ code snippet compiles
option_end
```

##### Option compiler/linker flags

Add flags that are applied when the option is enabled.

```sh
option "myopt"
    add_defines "USE_MYOPT"
    add_undefines "OLD_OPT"
    add_includedirs "/usr/local/include"
    add_linkdirs "/usr/local/lib"
    add_links "mylib"
    add_syslinks "dl"
    add_cflags "-DFOO"
    add_cxflags "-DBAR"
    add_cxxflags "-std=c++17"
    add_ldflags "-L/opt/lib"
option_end
```

#### Toolchain scope

##### toolchain / toolchain_end

Define a custom toolchain.

```sh
toolchain "myclang"
    set_toolset "cc" "clang"
    set_toolset "cxx" "clang++"
    set_toolset "ld" "clang++"
    set_toolset "sh" "clang++"
    set_toolset "ar" "ar"
toolchain_end
```

##### set_toolset

Set the compiler/linker program for a specific tool kind: `cc`, `cxx`, `mm`, `mxx`, `as`, `ld`, `sh`, `ar`.

```sh
set_toolset "cc" "gcc"
set_toolset "cxx" "g++"
set_toolset "ld" "g++"
set_toolset "ar" "ar"
```

## Contacts

* Email：[waruqi@gmail.com](mailto:waruqi@gmail.com)
* Homepage：[xmake.io](https://xmake.io)
* Community
  - [Chat on reddit](https://www.reddit.com/r/xmake/)
  - [Chat on telegram](https://t.me/tbooxorg)
  - [Chat on gitter](https://gitter.im/xmake-io/xmake?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
  - [Chat on discord](https://discord.gg/xmake)
  - Chat on QQ Group: 343118190, 662147501
* Source Code：[Github](https://github.com/xmake-io/xmake), [Gitee](https://gitee.com/tboox/xmake)
* Wechat Public: tboox-os
