## A script-only build utility like autotools

### Project Syntax

We just write `xmake.sh` project file, like this:

```sh
#!/bin/sh

option "debug" "Enable debug compilation mode."
option "tests" "Enable tests."

target "demo"
    set_kind "binary"
    add_deps "foo" "bar"
    add_files "main.cpp"
    if has_config "debug"; then
        add_defines "DEBUG"
    fi
    if is_host "linux" "macosx"; then
        add_defines "POSIX"
    fi

includes "foo" "bar"
if has_config "tests"; then
    includes "tests"
fi
```

### Configure and build

```console
$ ./configure
$ make
```

### Install project

```console
$ make install
```
