#!/usr/bin/env bash

# Find battery path (usually BAT0 on Dell Latitude 5420)
BAT=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)

if [ -z "$BAT" ]; then
    echo "No battery found in /sys/class/power_supply/"
    exit 1
fi

# State tracking
notified_low=false
notified_critical=false

while true; do
    capacity=$(cat "$BAT/capacity")
    status=$(cat "$BAT/status")

    if [ "$status" = "Discharging" ]; then
        if [ "$capacity" -le 10 ] && [ "$notified_critical" = false ]; then
            notify-send -u critical -i battery-empty "CRITICAL BATTERY" "Battery at ${capacity}%. Plug in your charger immediately!"
            notified_critical=true
            notified_low=true
        elif [ "$capacity" -le 20 ] && [ "$capacity" -gt 10 ] && [ "$notified_low" = false ]; then
            notify-send -u normal -i battery-caution "Battery Low" "Battery level is at ${capacity}%."
            notified_low=true
        fi
    else
        # Reset notifications once connected to AC power
        notified_low=false
        notified_critical=false
    fi

    sleep 1
done
