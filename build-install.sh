#!/usr/bin/env bash
rm -rf config.h
rm *.rej
rm *.orig
is4k=$(xrandr | grep "3840x2160")

if [[ $is4k != "" ]];then
    sudo make clean install ADD_MACRO='-DIS_4K'
else
    sudo make clean install
fi
mkdir ~/.config/scripts/
cp ./scripts/* ~/.config/scripts/
sudo cp ./dwm-lock.sh /usr/bin/dwm-lock
cp ./xprofile ~/.xprofile
#cp ./xscreensaver ~/.xscreensaver
cp ./b.jpg ~/.config/b.jpg
cp ./picom-config ~/.config/picom-config
cp ./xbindkeysrc ~/.xbindkeysrc
rm -rf config.h
sudo cp ./dwm.desktop /usr/share/xsessions/
make clean

if [[ $is4k != "" ]];then
    echo "is 4k display."
    cd ./for-4k/
    ./config4k.sh
    cd ..
fi
