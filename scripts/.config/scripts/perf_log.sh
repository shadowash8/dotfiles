#!/bin/bash

LOG_FILE="apu_stats.csv"
ENERGY_FILE="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# Initial energy reading
LAST_ENERGY=$(sudo cat "$ENERGY_FILE")
LAST_TIME=$(date +%s.%N)

echo "Timestamp,CPU_Usage(%),GPU_Load(%),Temp(C),Wattage(W)" > "$LOG_FILE"

while true; do
    sleep 1
    CURRENT_TIME=$(date +%s.%N)
    CURRENT_ENERGY=$(sudo cat "$ENERGY_FILE")
    
    # Calculate delta
    ENERGY_DELTA=$(echo "$CURRENT_ENERGY - $LAST_ENERGY" | bc)
    TIME_DELTA=$(echo "$CURRENT_TIME - $LAST_TIME" | bc)
    
    # Calculate Watts: (uj_delta / time_delta) / 1,000,000
    WATT=$(echo "scale=2; $ENERGY_DELTA / $TIME_DELTA / 1000000" | bc -l)

    # Standard stats
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    GPU=$(cat /sys/class/drm/card1/device/gpu_busy_percent 2>/dev/null || echo "0")
    TEMP=$(cat /sys/class/hwmon/hwmon4/temp1_input | awk '{print $1/1000}')

    # Update counters for next loop
    LAST_ENERGY=$CURRENT_ENERGY
    LAST_TIME=$CURRENT_TIME

    printf "%s | CPU: %s%% | GPU: %s%% | Temp: %sC | Pwr: %sW\n" "$TIMESTAMP" "$CPU" "$GPU" "$TEMP" "$WATT"
    echo "$TIMESTAMP,$CPU,$GPU,$TEMP,$WATT" >> "$LOG_FILE"
done
