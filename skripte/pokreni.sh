#!/bin/bash

fajl=$1

ext=$(echo "$fajl" | awk -F. '{print $NF}' -)
ime=$(echo "$fajl" | awk -F. '{$NF=""; print $0}' -)

if test -f "Makefile"; then 
	clear
	make
	exit
elif test -f "build.sh"; then
	clear
	./build.sh
	exit
fi

case $ext in 
	py)
		python "$fajl"
		;;
	sh)
		bash "$fajl"
		;;
	tex)
		xelatex "$fajl" && zathura "$ime.pdf"
		;;
	c)
		tcc -run "$fajl"
		;;
	cpp)
		g++ -std=c++17 "$fajl" && ./a.out && rm a.out
		;;
	rs)
		cp "$fajl" main.rs && cargo run --release
		rm -f "$fajl.out"
		;;
	*)
		echo "[GREŠKA] Nepoznata ekstenzija"
		;;
esac
