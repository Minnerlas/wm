#!/bin/sh

IFS=

IZLAZ=$1

ime=$(echo "$IZLAZ" | awk -F. '{$NF=""; print $0}' - | tr -d " ")

echo "static const char ${ime}[] = " > "$IZLAZ"

while read -r LINIJA
do
	printf '\t' >> "$IZLAZ"
	iz=$(echo "$LINIJA" | sed 's/\"/\\\"/g')
	printf '"%s\\n"\n' "$iz" >> "$IZLAZ"
done
echo ";" >> "$IZLAZ"
