#!/bin/bash

IME=testime
SUDOERS=/etc/sudoers
SHELL=/bin/zsh

groupadd $IME
groupadd network
groupadd power
groupadd wheel
groupadd audio
groupadd optical
groupadd storage

useradd $IME -s $SHELL -m -g $IME -G network,power,wheel,audio,optical,storage

cp $SUDOERS $SUDOERS.bak
echo $IME "ALL=(ALL) NOPASSWD:ALL" >> $SUDOERS

mkdir /use/share/xsessions

su $IME << EOSU

cd
mkdir Documents Pictures Desktop Music Public Videos Templates Downloads

sudo pacman --noconfirm -S base-devel git

git clone https://github.com/minnerlas/tackice
cp -r ~/tackice/* ~

rm -rvf .git 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd

git clone https://github.com/Minnerlas/wm
cd ~/wm

# instalirati bitne pakete
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

# fhgf wm/skripte/instpakete.sh
sudo ln ./razno/dwm.desktop /usr/share/xsessions/dwm.desktop

# podesiti /etc/lightdm/lightdm.conf ([Seat] user-session = dwm)
sudo cp ./razno/lightdm.conf /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm.service
# kopirati pozadine

cp ./razno/wall.jpg ~/Pictures/wall.jpg

EOSU

mv $SUDOERS.bak $SUDOERS
echo $IME "ALL = (root) NOPASSWD: /bin/systemctl restart httpd.service, /bin/kill" >> $SUDOERS

passwd $IME
