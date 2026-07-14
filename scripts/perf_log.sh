#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo!"
    exit 1
fi

LOG_FILE="intel_stats.csv"
ENERGY_FILE="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# 1. Coretemp Path Auto-Sense
HWMON_DIR=$(grep -l "coretemp" /sys/class/hwmon/hwmon*/name | head -n1 | xargs dirname 2>/dev/null)
[ -z "$HWMON_DIR" ] && HWMON_DIR="/sys/class/hwmon/hwmon0"
TEMP_FILE="$HWMON_DIR/temp1_input"

# 2. TARGETED: Fixed Iris Xe GPU Path
GPU_FREQ_FILE="/sys/class/drm/card1/gt/gt0/rps_cur_freq_mhz"

# 3. CPU Frequency Path (Core 0 as baseline)
CPU_FREQ_FILE="/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"

# 4. Battery Paths Auto-Sense
BAT_DIR=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n1)

# Baseline deltas tracking
LAST_ENERGY=$(cat "$ENERGY_FILE")
LAST_TIME=$(date +%s.%N)
PREV_TOTAL=0
PREV_IDLE=0

# Clean CSV headers matching new columns (Added CPU_Freq)
echo "Timestamp,CPU_Usage(%),CPU_Freq(MHz),GPU_Freq(MHz),Temp(C),Wattage(W),RAM_Used(GB),Battery(%),Status" > "$LOG_FILE"
echo "Logging metrics to $LOG_FILE... Press [CTRL+C] to stop."

while true; do
    sleep 1
    
    CURRENT_TIME=$(date +%s.%N)
    CURRENT_ENERGY=$(cat "$ENERGY_FILE")
    
    # CPU Calculation Loop
    CPU_STATS=( $(sed -n 's/^cpu //p' /proc/stat) )
    IDLE=${CPU_STATS[3]}
    TOTAL=0
    for VALUE in "${CPU_STATS[@]}"; do TOTAL=$((TOTAL + VALUE)); done
    DIFF_IDLE=$((IDLE - PREV_IDLE))
    DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
    CPU=$(echo "scale=1; 100 * ($DIFF_TOTAL - $DIFF_IDLE) / $DIFF_TOTAL" | bc)
    PREV_TOTAL=$TOTAL; PREV_IDLE=$IDLE

    # Wattage Calculation Loop
    ENERGY_DELTA=$(echo "$CURRENT_ENERGY - $LAST_ENERGY" | bc)
    TIME_DELTA=$(echo "$CURRENT_TIME - $LAST_TIME" | bc)
    WATT=$(echo "scale=2; $ENERGY_DELTA / $TIME_DELTA / 1000000" | bc -l)

    # Gather Metrics
    CPU_FREQ_KHZ=$(cat "$CPU_FREQ_FILE" 2>/dev/null || echo "0")
    CPU_FREQ=$(echo "$CPU_FREQ_KHZ / 1000" | bc 2>/dev/null || echo "0")
    GPU_FREQ=$(cat "$GPU_FREQ_FILE" 2>/dev/null || echo "0")
    TEMP=$(awk '{print $1/1000}' "$TEMP_FILE" 2>/dev/null || echo "0")
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    # Memory Usage Calculation (Reads directly from /proc/meminfo)
    MEM_TOTAL=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
    MEM_AVAIL=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
    RAM=$(echo "scale=2; ($MEM_TOTAL - $MEM_AVAIL) / 1024 / 1024" | bc)

    # Fetch Battery Capacity and Charge Status
    if [ -n "$BAT_DIR" ]; then
        BAT_PCT=$(cat "$BAT_DIR/capacity" 2>/dev/null || echo "0")
        BAT_STAT=$(cat "$BAT_DIR/status" 2>/dev/null || echo "Unknown")
    else
        BAT_PCT="100"
        BAT_STAT="N/A"
    fi

    # Reset frame counters
    LAST_ENERGY=$CURRENT_ENERGY
    LAST_TIME=$CURRENT_TIME

    # Format Display Columns
    printf "%s | CPU: %5s%% @ %4s MHz | GPU: %4s MHz | Temp: %2s°C | Pwr: %5sW | RAM: %4sGB | Bat: %3s%% [%s]\n" \
        "$TIMESTAMP" "$CPU" "$CPU_FREQ" "$GPU_FREQ" "$TEMP" "$WATT" "$RAM" "$BAT_PCT" "$BAT_STAT"
        
    # Append to CSV
    echo "$TIMESTAMP,$CPU,$CPU_FREQ,$GPU_FREQ,$TEMP,$WATT,$RAM,$BAT_PCT,$BAT_STAT" >> "$LOG_FILE"
done
