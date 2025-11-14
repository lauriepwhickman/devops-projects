#!/bin/bash

printf "###### Server Stats ######\n";

printf "###### CPU Usage ######\n";
top -bn1 | grep "$Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'
