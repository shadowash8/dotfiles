#!/usr/bin/env bash

# Locate the battery
BAT=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)
LOGFILE="$HOME/battery_log.csv"

if [ -z "$BAT" ]; then
    echo "No battery found!"
    exit 1
fi

# Add CSV header if the file is new
if [ ! -f "$LOGFILE" ]; then
    echo "Timestamp,Status,Capacity_Percent,Voltage_V,Energy_Wh" > "$LOGFILE"
fi

while true; do
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    status=$(cat "$BAT/status")
    capacity=$(cat "$BAT/capacity")

    # Kernel reports voltage in microvolts (µV) -> convert to Volts
    voltage_uv=$(cat "$BAT/voltage_now")
    voltage=$(awk "BEGIN {printf \"%.2f\", $voltage_uv / 1000000}")

# Check for energy (µWh) or calculate it from charge (µAh) * voltage (µV)
    if [ -f "$BAT/energy_now" ]; then
        energy_uwh=$(cat "$BAT/energy_now")
        energy=$(awk "BEGIN {printf \"%.2f\", $energy_uwh / 1000000}")
    elif [ -f "$BAT/charge_now" ]; then
        charge_uah=$(cat "$BAT/charge_now")
        # Wh = (Ah) * (V)
        energy=$(awk "BEGIN {printf \"%.2f\", ($charge_uah / 1000000) * ($voltage_uv / 1000000)}")
    else
        energy="N/A"
    fi

    # Print human-readable output to the terminal/journal
    echo "[$timestamp] $status: ${capacity}% | ${voltage}V | ${energy}Wh"
    
    # Append clean CSV format to the log file
    echo "$timestamp,$status,$capacity,$voltage,$energy" >> "$LOGFILE"
    
    # Wait 60 seconds
    sleep 10
done
