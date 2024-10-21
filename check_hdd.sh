#!/bin/bash

# Check if smartmontools is installed
if ! command -v smartctl &> /dev/null; then
    echo "smartmontools is not installed. Please install it and try again."
    exit 1
fi

# Get the list of all disks
disks=$(ls /dev/sd*)

# Create a log file
log_file="smart_check_log_$(date +%Y%m%d_%H%M%S).log"
touch "$log_file"

# Loop through each disk and check SMART status
for disk in $disks; do
    echo "===========================================" | tee -a "$log_file"
    echo "Checking SMART status for $disk..." | tee -a "$log_file"

    # Check if SMART is enabled
    smartctl -s on $disk > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "SMART is not supported on $disk." | tee -a "$log_file"
        continue
    fi

    # Get SMART status
    smart_status=$(smartctl -A $disk | grep "SMART overall-health self-assessment test result")

    # Print the SMART status
    if [[ $smart_status == *"PASSED"* ]]; then
        echo "SMART status for $disk: PASSED" | tee -a "$log_file"
    else
        echo "SMART status for $disk: FAILED or not available" | tee -a "$log_file"
        echo "$smart_status" | tee -a "$log_file"
    fi

    # Print detailed information
    echo "Detailed SMART information:" | tee -a "$log_file"
    smartctl -A $disk | tee -a "$log_file"
    
    # Ask the user if they want to run a self-test
    read -p "Would you like to run a short self-test on $disk? (y/n): " run_test
    if [[ $run_test == "y" ]]; then
        echo "Running short self-test on $disk..." | tee -a "$log_file"
        smartctl -t short $disk
        echo "Short self-test initiated. Please check the results later." | tee -a "$log_file"
    fi

    echo "===========================================" | tee -a "$log_file"
done

echo "SMART check complete. Results logged in $log_file."