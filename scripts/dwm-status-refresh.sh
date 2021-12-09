#!/bin/bash

print_volume() {
    Volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    if test "$Volume" -gt 0
    then
	echo -e "\uFA7D ${Volume}"
    else
	echo -e "Mute"
    fi
}

print_mem(){
    memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
    echo -e "\uF85A $memfree"
}

#load

dwm_loadavg () {
    lf=1,2,3
    la=$(cut -d " " -f ${lf} /proc/loadavg)
    echo -e "\uFD2E $la"

}

#whether
# whether=$(curl -s wttr.in/$LOCATION?format=1 | grep -o ".[0-9].*")
# whether=`echo -e "\uFA94 $whether"`
#network

connection=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
if [ "$connection" = "" ]; then
    connection=`echo -e "\uF65A"`
else
    connection=`echo -e "\uFBF1"`
fi

# datetime
Date=$(date +"%Y年%m月%d日" )
Week=$(date +"%V")
let Week=Week+1
Week_index=$(date +"%A")
Time=$(date +"%T")
DateTime=`echo -e "\uF073 $Date $Week周 $Week_index \uFBAE $Time"`
xsetroot -name "$(dwm_loadavg) $(print_mem) $(print_volume) $DateTime $connection "
