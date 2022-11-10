rm -rf config.h
rm *.rej
rm *.orig
sudo make clean install
mkdir ~/.config/scripts/
cp ./scripts/* ~/.config/scripts/
cp ./xinputrc ~/.xinputrc
cp ./b.jpg ~/.config/b.jpg
cp ./picom-config ~/.config/picom-config
cp ./xbindkeysrc ~/.xbindkeysrc
rm -rf config.h
sudo cp ./dwm.desktop /usr/share/xsessions/
make clean
