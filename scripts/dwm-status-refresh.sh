#!/bin/bash

print_volume() {
    Volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    if test "$Volume" -gt 0
    then
	echo -e "\uFA7D ${Volume}"
    else
	echo -e "\uFA7D Mute"
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

get_wireless_signal_strengh() {
    wire_info=$(ip route get 8.8.8.8 | grep -Po 'dev \K\w+' | grep -qFf - /proc/net/wireless && echo wireless || echo wired)
    if [ $wire_info=="wireless" ];then
        signal_strengh=$(cat /proc/net/wireless |tail -1 | tr -s " " | cut -d' ' -f4 | tr -cd "[0-9]")
        echo -e "\ufb09 -"$signal_strengh
    else
        connection=$(ping www.baidu.coewm -c 1 && echo "yes" || echo "no")
        if [ "$connection" = "yes" ]; then
            connection=`echo -e "\uF65A"`
        else
            connection=`echo -e "\uFBF1"`
        fi
        echo $connection
    fi
}


# datetime
Date=$(date +"%Y-%m-%d" )
Week=$(date +"%V")
let Week=Week+1
Week_index=$(date +"%w")
Time=$(date +"%T")
DateTime=`echo -e "\uF073 $Date $Week+$Week_index \uFBAE $Time"`
xsetroot -name "$(dwm_loadavg)  $(print_mem)  $(print_volume)  $(get_wireless_signal_strengh)  $DateTime  $(get_battery_charging_status)  $(get_battery_combined_percent)"

