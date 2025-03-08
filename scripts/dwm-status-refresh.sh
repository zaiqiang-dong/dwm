#!/bin/bash

print_volume() {
    Volume="$(amixer -D pulse get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    if test "$Volume" -gt 0; then
        echo -e "🌈 ${Volume}"
    else
        echo -e "🌈 Mute"
    fi
}

print_mem() {
    memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
    echo -e "🍁 $memfree"
}

#load

dwm_loadavg() {
    lf=1,2,3
    la=$(cut -d " " -f ${lf} /proc/loadavg)
    echo -e "🔥 $la"

}

get_battery_combined_percent() {

    # get charge of all batteries, combine them
    total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc))

    # get amount of batteries in the device
    battery_number=$(acpi -b | wc -l)

    percent=$(expr $total_charge / $battery_number)

    echo $percent
}

get_battery_charging_status() {

    batt_info=$(acpi -b)
    if [[ $batt_info =~ "unavailable" ]]; then
        echo -e "🔌"
    elif [[ $batt_info =~ "Charging" ]]; then
        echo -e "🔌"
    elif [[ $batt_info =~ "Discharging" ]]; then
        echo "🔋 "$(get_battery_combined_percent)
    fi
}

get_wireless_signal_strengh() {
    # wire_info=$(ip route get 8.8.8.8 | grep -Po 'dev \K\w+' | grep -qFf - /proc/net/wireless && echo wireless || echo wired)
    # if [ "$wire_info" == "wireless" ];then
    #     signal_strengh=$(cat /proc/net/wireless |tail -1 | tr -s " " | cut -d' ' -f4 | tr -cd "[0-9]")
    #     echo -e "📡 -"$signal_strengh
    # else
    connection=$(ping www.baidu.com -c 1 && echo "yes" || echo "no")
    connection=${connection##*\ }
    if [ "$connection" == "no" ]; then
        connection="󰅛"
    else
        connection="🚀"
    fi
    echo $connection
    # fi
}

get_ble_dev_bp() {
    bp=$(bluetoothctl info F5:3B:A3:BC:33:CA | grep "Battery Percentage" | tail -1 | cut -d'(' -f2 | cut -d')' -f1)
    echo $bp
}

# datetime
Date=$(date +"%Y-%m-%d")
Week=$(date +"%V")
Week_index=$(date +"%w")
Time=$(date +"%T")
DateTime=$(echo -e "📆 $Date $Week+$Week_index ⏰ $Time")

xsetroot -name "$(dwm_loadavg)  $(print_mem)  $(print_volume)  $(get_wireless_signal_strengh)  $DateTime  $(get_battery_charging_status) $(get_ble_dev_bp)"
