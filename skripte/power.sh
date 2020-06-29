#!/bin/bash

OPCIJA=$(echo -e "Isključi\nRestartuj" | dmenu -l 5)

case $OPCIJA in 
	"Isključi")
		shutdown 0
		;;
	"Restartuj")
		reboot
		;;
	*)
		echo $OPCIJA | bash
		;;

esac
