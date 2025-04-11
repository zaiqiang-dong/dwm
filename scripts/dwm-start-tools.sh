#!/usr/bin/env bash
#flameshot
feh --bg-scale /home/$USER/.config/b.jpg
picom -b --config=/home/zaiqdong/.config/picom-config
alsactl --file ~/.config/asound.state restore
xbindkeys
copyq &
# blueman-tray
blueman-applet &
fcitx5 &
clash-verge &
bytedance-feishu-stable &
curl -s -o /dev/null "www.google.com" --connect-timeout 0.5
if [[ $? -eq 0 ]]; then
    google-chrome-stable &
else
    google-chrome-stable --proxy-server="http://127.0.0.1:7897"
fi
