#!/bin/bash

IME=testime
SUDOERS=/etc/sudoers
SHELL=/bin/zsh

groupadd $IME

useradd $IME -s $SHELL -m -g $IME -G network,power,wheel,audio,optical,storage

cp $SUDOERS $SUDOERS.bak
echo $IME "ALL=(ALL) NOPASSWD:ALL" >> $SUDOERS

mkdir /usr/share/xsessions

su $IME << EOSU

cd
mkdir Documents Pictures Desktop Music Public Videos Templates Downloads

sudo pacman --noconfirm -S base-devel git

git clone https://github.com/minnerlas/tackice
cd tackice
sudo cp -r * ..
cd

rm -rvf .git 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd

git clone https://github.com/Minnerlas/wm
cd ~/wm

./skripte/instpakete.sh pak razno/obavezni_paketi.txt
./skripte/instpakete.sh aur razno/obavezni_paketi_aur.txt

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

sudo ln ./razno/dwm.desktop /usr/share/xsessions/dwm.desktop

sudo cp ./razno/lightdm.conf /etc/lightdm/lightdm.conf

echo sudo systemctl enable lightdm.service

cp ./razno/wall.jpg ~/Pictures/wall.jpg
cp ./razno/wall.jpg /usr/share/pixmaps/wall.jpg

EOSU

mv $SUDOERS.bak $SUDOERS
echo "%wheel ALL = (ALL) ALL" >> $SUDOERS
echo $IME "ALL = (root) NOPASSWD: /bin/systemctl restart httpd.service, /bin/kill" >> $SUDOERS

passwd $IME
status=$?

while [ $status -ne 0 ]
do
	passwd $IME
	status=$?
done
