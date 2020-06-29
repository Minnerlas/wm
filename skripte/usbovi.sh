#!/bin/bash

# usb=`lsblk -lp | grep "part $" | grep -v "sda" | awk '{print $1, "(" $4 ")"}' | dmenu -l 9 -p "Mount:" | awk '{print $1}'`
# echo $usb

st -e bashmount
