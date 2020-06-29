#!/bin/bash

fajl=$1

ext=`echo $fajl | awk -F. '{print $NF}' -`

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
