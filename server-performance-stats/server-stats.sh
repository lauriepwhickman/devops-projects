#!/bin/bash

echo "###################"
echo "# Total CPU Usage #"
echo "###################"

top -bn1 | grep "$Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'

echo

echo "###################"
echo "# Total RAM Usage #"
echo "###################"

TOTAL_RAM=$(free -h | awk '{print $2}' | sed -n '2p');
USED_RAM=$(free -h | awk '{print $3}' | sed -n '2p');
FREE_RAM=$(free -h | awk '{print $4}' | sed -n '2p');
printf "Total RAM: $TOTAL_RAM\n";
printf "Used RAM: $USED_RAM\n";
printf "Free RAM: $FREE_RAM\n";

PERCENTAGE_USED=$((USED_RAM/FREE_RAM))

printf "Percentage Used: $PERCENTAGE_USED %\n";
printf "Percentage Free: \n";
