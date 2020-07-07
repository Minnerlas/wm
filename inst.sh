#!/bin/bash

IME=testime
SUDOERS=/etc/sudoers
SHELL=/bin/zsh

pacman --noconfirm -S dialog

# Prompts user for new username an password.
IME=$(dialog --inputbox "First, please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit
while ! echo "$IME" | grep "^[a-z_][a-z0-9_-]*$" >/dev/null 2>&1; do
	IME=$(dialog --no-cancel --inputbox "Username not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
done
pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
while ! [ "$pass1" = "$pass2" ]; do
	unset pass2
	pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
done

INIT=""
TMP=".tmp"
LDM=""

dialog --title "Init system" \
	--menu "Choose your installed init system:" 10 30 2 \
	1 "systemd" \
	2 "runit" 2> $TMP

case $(<$TMP) in
	1) INIT="systemd";;
	2) INIT="runit";;
esac

dialog --title "Message"  --yesno "Do you want to install lightdm display manager?" 6 25 
if [ "$?" != "1" ]
then 
	LDM="1"
fi

rm -f $TMP

echo $INIT

clear

groupadd $IME

useradd $IME -s $SHELL -m -g $IME -G network,power,wheel,audio,optical,storage

cp $SUDOERS $SUDOERS.bak
echo "$IME" "ALL=(ALL) NOPASSWD:ALL" >> $SUDOERS

mkdir /usr/share/xsessions

su "$IME" << EOSU

cd
mkdir Documents Pictures Desktop Music Public Videos Templates Downloads

sudo pacman --noconfirm -S base-devel git

git clone https://github.com/minnerlas/tackice

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd

git clone https://github.com/Minnerlas/wm
cd ~/wm

./skripte/instpakete.sh pak ./razno/obavezni_paketi.txt
./skripte/instpakete.sh aur ./razno/obavezni_paketi_aur.txt

git clone https://github.com/minnerlas/dwm
cd dwm
./apply_patches.sh
sudo make clean install
cd ..

git clone https://github.com/minnerlas/st
cd st
./apply_patches.sh
sudo make clean install
cd ..

git clone https://github.com/minnerlas/slstatus
cd slstatus
sudo make clean install
cd ..

cp ./razno/wall.jpg ~/Pictures/wall.jpg
sudo cp ./razno/wall.jpg /usr/share/pixmaps/wall.jpg

EOSU

rsync -a "/home/$IME/tackice/" "/home/$IME/"
rsync -a "/home/$IME/wm/skripte/" /usr/local/sbin/

case "$INIT" in
	"systemd")
		pacman -S xorg
		pacman -S xorg-xinit
		;;
	"runit")
		pacman -S xorg --ignore xorg-server-xdmx
		pacman -S xorg-xinit
		;;
	*)
		dialog --infobox "Nije trebalo da dodje do ovoga!" 10 30
		;;
esac

if [ "$LDM" == "1" ]
then
	cp "/home/$IME/wm/razno/dwm.desktop" /usr/share/xsessions/dwm.desktop
	cp "/home/$IME/wm/razno/lightdm.conf" /etc/lightdm/lightdm.conf
	case "$INIT" in
		"systemd")
			"/home/$IME/wm/skripte/instpakete.sh" pak "/home/$IME/wm/razno/lightdm-sysd.txt"
			systemctl enable lightdm.service
			;;
		"runit")
			"/home/$IME/wm/skripte/instpakete.sh" pak  "/home/$IME/wm/razno/lightdm-runit.txt"
			ln -s /etc/runit/sv/lightdm /run/runit/service
			;;
		*)
			dialog --infobox "Nije trebalo da dodje do ovoga! 2" 10 30
			;;
	esac
fi

mv $SUDOERS.bak $SUDOERS
echo "%wheel ALL = (ALL) ALL" >> $SUDOERS
echo $IME "ALL = (root) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/bin/kill" >> $SUDOERS

echo "$IME:$pass1" | chpasswd
