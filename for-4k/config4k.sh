#!/bin/bash
# cp ./Xresources ~/.config/
cp ./xprofile ~/.xprofile
sudo ./change-gdm-scale.py
sudo glib-compile-schemas /usr/share/glib-2.0/schemas
