#!/bin/sh
ps -aux | grep "xscreensaver" | grep -v "grep" | awk '{print $2}' | while read line;
do
	kill -9 $line
done

xset dpms force off
i3lock -c 000000 -e
xscreensaver &
