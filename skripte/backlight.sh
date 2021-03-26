#!/bin/sh

BACKLIGHT="/sys/class/backlight/$(ls /sys/class/backlight/)"

MAKS=$(cat "$BACKLIGHT"/max_brightness)
KORAK=$((MAKS/10))

#echo $KORAK

case $1 in
	+)
		;;
	-)
		KORAK=$((-KORAK))
		;;
	*)
		echo "Greška"
		exit 1
		;;
esac

TREN=$(cat "$BACKLIGHT"/actual_brightness)

TREN=$(( TREN + KORAK ))

if [ "$TREN" -lt "1" ]
then
	TREN=1
elif [ "$TREN" -gt "$MAKS" ]
then
	TREN=$MAKS
fi

#ls $BACKLIGHT
echo "$TREN" > "$BACKLIGHT/brightness"
