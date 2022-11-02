#!/bin/sh

clear
fortune | cowsay -f tux -n

while read -r
do
	clear
	fortune | cowsay -f tux -n
done
