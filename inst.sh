#!/bin/bash

IME=testime
SUDOERS=/etc/sudoers
SHELL=/bin/zsh

useradd $IME -s $SHELL -m

cp $SUDOERS $SUDOERS.bak
echo $IME "ALL=(ALL) NOPASSWD:ALL" >> $SUDOERS

su $IME << EOSU

sudo pacman --noconfirm -S base-devel git

git clone https://github.com/minnerlas/tackice


git clone https://github.com/minnerlas/tackice
cp -r tackice/* .
rm -rvf .git 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
git clone https://github.com/minnerlas/wm
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

# wm/skripte/instpakete.sh
ln ./razno/dwm.desktop /usr/share/xessions/dwm.desktop

# podesiti /etc/lightdm/lightdm.conf ([Seat] user-session = dwm)
# sudo systemctl enable lightdm.service
# kopirati pozadine


EOSU

mv $SUDOERS.bak $SUDOERS
echo $IME "ALL = NOPASSWD: /bin/systemctl restart httpd.service, /bin/kill" >> $SUDOERS
