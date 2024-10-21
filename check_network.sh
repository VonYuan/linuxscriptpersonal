#!/bin/bash

# Define the hosts to ping
HOSTS=("1.1.1.1" "8.8.8.8")
COUNT=4

# Loop through each host and ping
for HOST in "${HOSTS[@]}"; do
    echo "Pinging $HOST for $COUNT times..."
    ping -c $COUNT $HOST > /dev/null

    # Check the exit status of the ping command
    if [ $? -eq 0 ]; then
        echo "Network connectivity to $HOST: SUCCESS"
    else
        echo "Network connectivity to $HOST: FAILED"
    fi
    echo "----------------------------------------"
done

echo "Connectivity check complete."
