rm -rf config.h
rm *.rej
rm *.orig
sudo make clean install
mkdir ~/.config/scripts/
cp ./scripts/* ~/.config/scripts/
cp ./xinputrc ~/.xinputrc
cp ./b.jpg ~/.config/b.jpg
cp ./xbindkeysrc ~/.xbindkeysrc
rm -rf config.h
