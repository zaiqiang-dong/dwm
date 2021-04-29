if [[ "$1" == "dwm" ]]; then
	echo "dwm"
	sudo sed -r "s/quiet splash/text/g" /usr/default/grub
	sudo systemctl set-default multi-user.target
	echo "exec dwm" > ~/.xsession
fi

if [[ "$1" == "ubuntu" ]]; then
	echo "ubuntu"
	sudo sed -r "s/text/quiet splash/g" /usr/default/grub
	sudo systemctl set-default graphical.target
	if [[ -f "~/.xsession" ]]; then
		rm ~/.xsession
	fi
fi







