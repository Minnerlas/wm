#!/bin/bash

IME=testime
SUDOERS=/etc/sudoers
SHELL=/bin/zsh

useradd $IME -s $SHELL -m

cp $SUDOERS $SUDOERS.bak
echo $IME "ALL=(ALL) NOPASSWD:ALL" >> $SUDOERS

su $IME

sudo pacman -S base-devel

git clone https://github.com/minnerlas/tackice


git clone https://github.com/minnerlas/tackice
cp -r tackice/* .
rm -rvf .git 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# git clone https://github.com/minnerlas/wm
# cd
# instalirati bitne pakete
# wm/skripte/instpakete.sh
# ln ~/wm/razno/dwm.desktop /usr/share/xessions/dwm.desktop
# podesiti /etc/lightdm/lightdm.conf ([Seat] user-session = dwm)
# sudo systemctl enable lightdm.service
# kopirati pozadine

exit

# mv $SUDOERS.bak $SUDOERS
# echo $IME "ALL = NOPASSWD: /bin/systemctl restart httpd.service, /bin/kill" >> $SUDOERS
