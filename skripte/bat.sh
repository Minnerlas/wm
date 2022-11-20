#!/bin/sh

# ACPI="$(acpi)"

# PERC="$(echo "$ACPI" | cut -d' ' -f4)"
# TIME="$(echo "$ACPI" | cut -d' ' -f5)"

# echo "$PERC" "$TIME"

TMPDIR=/tmp

ACPIBAT="$(acpi)"

echo "$ACPIBAT" | cut -d' ' -f4-5

PERC="$(echo "$ACPIBAT" | cut -d' ' -f4)"
PERC="${PERC%?,}"

if [ "$PERC" -le 30 ] && [ ! -f "$TMPDIR/batterylow" ]
then
	notify-send -u critical "Батерија је на $PERC%."
	touch "$TMPDIR/batterylow"
elif [ "$PERC" -gt 30 ] && [ -f "$TMPDIR/batterylow" ]
then
	rm "$TMPDIR/batterylow"
elif [ "$PERC" -ge 80 ] && [ ! -f "$TMPDIR/batteryhigh" ]
then
	notify-send "Батерија је на $PERC%."
	touch "$TMPDIR/batteryhigh"
elif [ "$PERC" -lt 80 ] && [ -f "$TMPDIR/batteryhigh" ]
then
	rm "$TMPDIR/batteryhigh"
elif [ "$PERC" -ge 99  ] && [ ! -f "$TMPDIR/battery100" ]
then
	notify-send "Батерија је на 100%."
	touch "$TMPDIR/battery100"
elif [ "$PERC" -lt 99 ] && [ -f "$TMPDIR/battery100" ]
then
	rm "$TMPDIR/battery100"
fi
