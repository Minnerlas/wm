#!/bin/bash

fajl=$1

ext=`echo $fajl | awk -F. '{print $NF}' -`

if test -f "build.sh"; then
	clear
	./build.sh
	exit
fi

case $ext in 
	py)
		python $fajl
		;;
	sh)
		bash $fajl
		;;

	c)
		tcc -run $fajl
		;;
	rs)
		cp $fajl main.rs && cargo run --release
		rm -f $fajl.out
		;;
	*)
		echo "[GREŠKA] Nepoznata ekstenzija"
		;;
esac
