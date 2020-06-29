#!/bin/bash

IME=testime
SUDOERS=sudoers
SHELL=/bin/zsh

useradd $IME -s $SHELL -m

cp $SUDOERS $SUDOERS.bak
echo $IME "ALL=(ALL) NOPASSWD:ALL" >> $SUDOERS

su $IME




# mv $SUDOERS.bak $SUDOERS
# echo $IME "ALL = NOPASSWD: /bin/systemctl restart httpd.service, /bin/kill" >> $SUDOERS
