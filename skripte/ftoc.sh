#!/bin/dash

IFS=

IZLAZ=$1

ime=$(echo "$IZLAZ" | awk -F. '{$NF=""; print $0}' - | tr -d " ")

echo "static const char ${ime}[] = " > "$IZLAZ"

while read -r LINIJA
do
	echo -n "\t" >> "$IZLAZ"
	iz=$(echo "$LINIJA" | sed 's/\"/\\\"/g')
	echo "\"$iz\\\\n\"" >> "$IZLAZ"
done
echo ";" >> "$IZLAZ"
