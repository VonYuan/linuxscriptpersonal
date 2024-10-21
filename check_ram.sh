#!/bin/bash

# Function to display memory usage with calculations
display_memory_info() {
    local label=$1
    local total=$2
    local used=$3
    local free=$4

    # Calculate percentage of used and free memory
    used_percentage=$(awk "BEGIN {printf \"%.2f\", ($used/$total)*100}")
    free_percentage=$(awk "BEGIN {printf \"%.2f\", ($free/$total)*100}")

    echo "----------------------------------------"
    echo "$label Memory"
    echo "----------------------------------------"
    echo "Total: $total"
    echo "Used: $used ($used_percentage%)"
    echo "Free: $free ($free_percentage%)"
}

# Get RAM and Swap usage information using the free command
ram_info=$(free -m)
total_memory=$(echo "$ram_info" | awk '/^Mem:/ {print $2}')
used_memory=$(echo "$ram_info" | awk '/^Mem:/ {print $3}')
free_memory=$(echo "$ram_info" | awk '/^Mem:/ {print $4}')
total_swap=$(echo "$ram_info" | awk '/^Swap:/ {print $2}')
used_swap=$(echo "$ram_info" | awk '/^Swap:/ {print $3}')
free_swap=$(echo "$ram_info" | awk '/^Swap:/ {print $4}')

# Display the RAM usage information
display_memory_info "RAM" "$total_memory" "$used_memory" "$free_memory"

# Display the Swap usage information if available
if [ "$total_swap" -gt 0 ]; then
    display_memory_info "Swap" "$total_swap" "$used_swap" "$free_swap"
else
    echo "----------------------------------------"
    echo "No Swap memory available."
fi

# Alert if RAM usage exceeds 80%
threshold=80
if (( $(echo "$used_memory/$total_memory*100" | bc) > $threshold )); then
    echo "----------------------------------------"
    echo "WARNING: RAM usage is above ${threshold}%!"
fi

echo "----------------------------------------"
echo "RAM and Swap check complete."
