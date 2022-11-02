#!/bin/sh

export WINEPREFIX="/home/nikola/Data/wine32"
export WINEARCH=win32

cd ~/Data/wine32/drive_c/users/nikola/Documents/Victoria.II.v3.04.Inclu.ALL.DLC \
	|| exit 1

exec wine explorer /desktop=vic2 victoria2.exe
