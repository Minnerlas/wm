#!/bin/sh

sensors | grep "id 0"| awk -F' ' '{print $4}'
