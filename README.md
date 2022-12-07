<div align="center">
  <a href="https://xmake.io">
    <img width="160" heigth="160" src="https://tboox.org/static/img/xmake/logo256c.png">
  </a>

  <h1>xmake.sh</h1>

  <div>
    <a href="https://github.com/xmake-io/xmake.sh/actions?query=workflow%3ALinux">
      <img src="https://img.shields.io/github/workflow/status/xmake-io/xmake.sh/Linux/master.svg?style=flat-square&logo=linux" alt="github-ci" />
    </a>
    <a href="https://github.com/xmake-io/xmake.sh/actions?query=workflow%3AmacOS">
      <img src="https://img.shields.io/github/workflow/status/xmake-io/xmake.sh/macOS/master.svg?style=flat-square&logo=apple" alt="github-ci" />
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
- [x] Custom toolchains

#### In the future it will support

- [ ] Generate build.ninja
- [ ] Detect options, code snippet, dependencies, compiler features
- [ ] Support more xmake features

### New project

Copy `./configure` script file to your project root directory.

### Write project configuration

We just write `xmake.sh` project file, like this:

```sh
#!/bin/sh

option "debug" "Enable debug compilation mode." false
option "tests" "Enable tests." true

option "pthread"
    add_links "pthread"
    add_cincludes "pthread.h"
    add_cfuncs "pthread_create"
    add_defines "HAS_PTHREAD"
option_end

option "cxx_constexpr"
    set_languages "c++11"
    add_cxxsnippets "constexpr int k = 0;"
    add_defines "HAS_CONSTEXPR"
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
```

### Configure and generate makefile

```console
$ ./configure
```

### Build project

```console
$ make
```

### Install artifacts

```console
$ make install
```

### Run program

```console
$ make run
```

### Supported apis

- [x] includes
- [x] is_plat
- [x] is_arch
- [x] is_host
- [x] is_mode
- [x] is_config
- [x] has_config
- [x] target
  - [x] set_kind
  - [x] add_deps
  - [x] add_files
  - [x] set_basename
  - [x] set_extension
  - [x] set_filename
  - [x] set_prefixname
  - [x] set_targetdir
  - [x] set_objectdir
  - [x] add_defines
  - [x] add_undefines
  - [x] add_includedirs
  - [x] add_linkdirs
  - [x] add_rpathdirs
  - [x] add_links
  - [x] add_syslinks
  - [x] set_strip
  - [x] set_symbols
  - [x] set_languages
  - [x] set_warnings
  - [x] set_optmizes
  - [x] add_frameworks
  - [x] add_frameworkdirs
  - [x] add_cflags
  - [x] add_cxflags
  - [x] add_cxxflags
  - [x] add_mflags
  - [x] add_mxflags
  - [x] add_mxxflags
  - [x] add_asflags
  - [x] add_ldflags
  - [x] add_shflags
  - [x] add_arflags
  - [ ] set_configdir
  - [ ] set_configfiles
  - [ ] set_configvar
  - [ ] set_installdir
  - [ ] add_installfiles
  - [ ] add_headerfiles
  - [x] add_options
- [x] target_end
- [x] option
  - [x] set_default
  - [x] set_description
  - [x] set_showmenu
  - [x] add_defines
  - [x] add_undefines
  - [x] add_includedirs
  - [x] add_linkdirs
  - [x] add_links
  - [x] add_syslinks
  - [x] add_cflags
  - [x] add_cxflags
  - [x] add_cxxflags
  - [ ] add_cfuncs
  - [ ] add_cxxfuncs
  - [ ] add_cincludes
  - [ ] add_cxxincludes
  - [ ] add_ctypes
  - [ ] add_cxxtypes
  - [ ] add_csnippets
  - [ ] add_cxxsnippets
  - [ ] ...
- [x] option_end
- [x] toolchain
  - [x] set_toolset
  - [ ] set_sdkdir
  - [ ] set_bindir
  - [ ] set_cross
- [x] toolchain_end

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
