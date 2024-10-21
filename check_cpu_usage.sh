#!/bin/bash

# Get server uptime
uptime_info=$(uptime -p)
uptime_full=$(uptime -s)

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | \
            sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
            awk '{print 100 - $1"%"}')

# Get load average
load_average=$(uptime | awk -F 'load average:' '{ print $2 }')

# Display the results
echo "----------------------------------------"
echo "Server Uptime: $uptime_info"
echo "Server Start Time: $uptime_full"
echo "----------------------------------------"
echo "Current CPU Usage: $cpu_usage"
echo "Load Average (1, 5, 15 min): $load_average"
echo "----------------------------------------"
