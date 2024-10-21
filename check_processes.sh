#!/bin/bash

echo "----------------------------------------"
echo "Top 5 processes by CPU usage:"
echo "----------------------------------------"
# Display the top 5 processes consuming the most CPU
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo "----------------------------------------"
echo "Top 5 processes by memory usage:"
echo "----------------------------------------"
# Display the top 5 processes consuming the most memory
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
