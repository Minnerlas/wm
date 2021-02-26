#!/bin/sh

clear
fortune | cowsay -f tux -n

while read -r ULAZ
do
	clear
	fortune | cowsay -f tux -n
done
