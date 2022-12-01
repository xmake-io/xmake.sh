#!/bin/sh

echo "src/xmake.sh"

xx=`xmake_sh_test`
echo "xx: $xx"

xmake_sh_test2()
{
    echo "test2"
}
