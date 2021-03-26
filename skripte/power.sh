#!/bin/sh

OPCIJA="$(printf "Isključi\nRestartuj" | dmenu -l 5)"

case "$OPCIJA" in 
	"Isključi")
		sync && sudo loginctl poweroff
		;;
	"Restartuj")
		sync && sudo loginctl reboot
		;;
	*)
		echo "$OPCIJA" | bash
		;;

esac
