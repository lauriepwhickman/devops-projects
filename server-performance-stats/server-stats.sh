#!/bin/bash

echo "###################"
echo "# Total CPU Usage #"
echo "###################"

top -bn1 | grep "$Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'

echo

echo "###################"
echo "# Total RAM Usage #"
echo "###################"

TOTAL_RAM=$(free -g | awk '{print $2}' | sed -n '2p');
USED_RAM=$(free -g | awk '{print $3}' | sed -n '2p');
FREE_RAM=$(free -g | awk '{print $4}' | sed -n '2p');
printf "Total RAM: $TOTAL_RAM GB\n";
printf "Used RAM: $USED_RAM GB\n";
printf "Free RAM: $FREE_RAM GB\n";

PERCENTAGE_USED=$(awk -v USED=$USED_RAM -v TOTAL=$TOTAL_RAM 'BEGIN { printf "%.2f%%", (USED/TOTAL*100) }')
PERCENTAGE_FREE=$(awk -v FREE=$FREE_RAM -v TOTAL=$TOTAL_RAM 'BEGIN { printf "%.2f%%", (FREE/TOTAL*100) }')
printf "Percentage Used: $PERCENTAGE_USED% \n";
printf "Percentage Free: $PERCENTAGE_FREE% \n";

echo

echo "####################"
echo "# Total Disk Usage #"
echo "####################"

TOTAL_DISK=$(df -h -t ext4 | awk '{print $2}' | sed -n '2p' )
USED_DISK=$(df -h -t ext4 | awk '{print $3}' | sed -n '2p' )
FREE_DISK=$(df -h -t ext4 | awk '{print $4}' | sed -n '2p' )
printf "Total Disk: $TOTAL_DISK\n";
printf "Used Disk: $USED_DISK\n";
printf "Free Disk: $FREE_DISK\n";

DISK_PERCENTAGE_USED=$(awk -v USED=$USED_DISK -v TOTAL=$TOTAL_DISK 'BEGIN { printf "%.2f%%", (USED/TOTAL*100) }')
DISK_PERCENTAGE_FREE=$(awk -v FREE=$FREE_DISK -v TOTAL=$TOTAL_DISK 'BEGIN { printf "%.2f%%", (FREE/TOTAL*100) }')
printf "Disk Percentage Used: $DISK_PERCENTAGE_USED% \n"
printf "Disk Percentage Free: $DISK_PERCENTAGE_FREE% \n"

echo

echo "##########################"
echo "# Top 5 Proccesses by CPU#"
echo "##########################"

ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'

echo

echo "##########################"
echo "# Top 5 Proccesses by RAM#"
echo "##########################"

ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
