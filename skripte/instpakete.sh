#!/bin/bash

PAKMAN=""
AUR=""

if [ $# -gt 0 ] then 
	if [ $1 == "aur" ]
		AUR=$2
	else
		PAKMAN=$2
	fi
else
	PAKMAN=$HOME/wm/skripte/paketi.txt
	AUR=$HOME/wm/skripte/paketi_aur.txt
fi

# sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $FAJL))
# ls $PAKMAN
# cat  $PAKMAN
sudo pacman -S --needed $(cat $PAKMAN)
yay -S $(cat $AUR)
