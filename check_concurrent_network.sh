#!/bin/bash

# Check if netstat or ss is installed
if command -v netstat &> /dev/null; then
    NETSTAT_CMD="netstat -tunap"
elif command -v ss &> /dev/null; then
    NETSTAT_CMD="ss -tunap"
else
    echo "Neither netstat nor ss is installed. Please install one of them and try again."
    exit 1
fi

echo "Using command: $NETSTAT_CMD"
echo "----------------------------------------"

# Display all active network connections
$NETSTAT_CMD

echo "----------------------------------------"
echo "Summary of connection states:"

# Count the number of connections in various states (using netstat or ss)
echo "ESTABLISHED connections: $($NETSTAT_CMD | grep -c 'ESTABLISHED')"
echo "LISTENING connections: $($NETSTAT_CMD | grep -c 'LISTEN')"
echo "TIME_WAIT connections: $($NETSTAT_CMD | grep -c 'TIME_WAIT')"
echo "CLOSE_WAIT connections: $($NETSTAT_CMD | grep -c 'CLOSE_WAIT')"
echo "SYN_SENT connections: $($NETSTAT_CMD | grep -c 'SYN_SENT')"
echo "SYN_RECV connections: $($NETSTAT_CMD | grep -c 'SYN_RECV')"

echo "----------------------------------------"
echo "Total number of active connections: $($NETSTAT_CMD | wc -l)"
