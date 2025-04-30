#!/usr/bin/env bash

RED='\033[0;31m'
NO_COLOR='\033[0m'

rm -rf config.h
rm *.rej
rm *.orig

if [[ $# -eq 0 ]]; then
    echo >&2 -e "[${RED}ERROR${NO_COLOR}] need set monitor inof [IS_24_4K|IS_27_4K|DEFAULT]"
    exit
fi
sudo make clean install ADD_MACRO='-D'$1

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

if [[ $1 =~ "_4K" ]];then
    echo "is 4k display."
    cd ./for-4k/
    ./config4k.sh
    cd ..
fi
