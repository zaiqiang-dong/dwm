#!/bin/bash

print_volume() {
    Volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    if test "$Volume" -gt 0
    then
	echo -e "Vol:${Volume}"
    else
	echo -e "Mute"
    fi
}

print_mem(){
    memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
    echo -e "Mem:$memfree"
}

# datetime
DateTime=$(date +"%Y年%m月%d日 %A %T" )
xsetroot -name "$(print_mem) $(print_volume) $DateTime "
