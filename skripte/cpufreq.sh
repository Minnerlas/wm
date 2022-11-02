#!/bin/sh

exec awk '/cpu MHz/{if($4>a)a=$4;}END{print sprintf("%.0f", a)}' /proc/cpuinfo
