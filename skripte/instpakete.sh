#!/bin/bash

PAKMAN=./paketi.txt
AUR=./paketi_aur.txt

# sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $FAJL))
# ls $PAKMAN
# cat  $PAKMAN
sudo pacman -S --needed $(cat $PAKMAN)
yay -S $(cat $AUR)
