#!/bin/bash

# Check if lm-sensors is installed
if ! command -v sensors &> /dev/null; then
    echo "lm-sensors is not installed. Please install it and try again."
    exit 1
fi

# Detect sensors
echo "Detecting sensors..."
sudo sensors-detect --auto

# Check CPU temperature
echo "Checking CPU temperature..."
cpu_temp=$(sensors | grep 'Core 0' | awk '{print $3}' | tr -d '+°C')

# Output the CPU temperature
if [[ -z "$cpu_temp" ]]; then
    echo "Could not read CPU temperature. Ensure that your sensors are configured properly."
else
    echo "Current CPU temperature: $cpu_temp °C"
fi
