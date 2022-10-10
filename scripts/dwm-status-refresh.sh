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

get_battery_combined_percent() {

	# get charge of all batteries, combine them
	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);

	percent=$(expr $total_charge / $battery_number);

	echo $percent;
}

get_battery_charging_status() {

	if $(acpi -b | grep --quiet Discharging)
	then
		echo -e "\uF578";
	else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
		echo -e "\uF583";
	fi
}

#net
update() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=/tmp/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

get_net_info() {
    rx=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
    tx=$(update /sys/class/net/[ew]*/statistics/tx_bytes)

    printf "\uf6d9%4sB \ufa51%4sB\\n" $(numfmt --to=iec $rx $tx)
}

#whether
# whether=$(curl -s wttr.in/$LOCATION?format=1 | grep -o ".[0-9].*")
# whether=`echo -e "\uFA94 $whether"`
#network

connection=$(ping www.baidu.coewm -c 1 && echo "yes" || echo "no")
if [ "$connection" = "yes" ]; then
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
xsetroot -name "$(dwm_loadavg) $(print_mem) $(print_volume) $DateTime $connection $(get_battery_charging_status) $(get_battery_combined_percent) $(get_net_info)"
