#!/bin/bash
# Check for menu flag
while [[ $# -gt 0 ]]; do
  case $1 in
    --menu)
      MENU_TYPE="$2"
      shift # past argument
      shift # past value
      ;;
    *)
      MENU_TYPE="rofi"
      shift
      ;;
  esac
done

if [[ "$MENU_TYPE" == "dmenu" ]]; then
    menu_cmd="dmenu -p Phone"
elif [[ "$MENU_TYPE" == "wmenu" ]]; then
    menu_cmd="wmenu -i -p Phone"
else
    menu_cmd="rofi -dmenu -i -p Phone"
fi

# Get the first reachable device ID
device=$(kdeconnect-cli -a --id-only | head -n 1)

if [ -z "$device" ]; then
    notify-send "KDE Connect" "No paired devices found."
    exit 1
fi

# Menu options
options="Ping\nRing Phone\nSend Clipboard\nShare File\nRefresh Connection"
choice=$(echo -e "$options" | $menu_cmd)

case "$choice" in
    Ping) kdeconnect-cli -d "$device" --ping-msg "Ping from Linux" ;;
    "Ring Phone") kdeconnect-cli -d "$device" --ring ;;
    "Send Clipboard") kdeconnect-cli -d "$device" --send-clipboard ;;
    "Share File") 
        file=$(kdialog --getopenfilename ~)
        if [ -n "$file" ]; then
            # Extract just the filename for the notification
            filename=$(basename "$file")
            
            notify-send "KDE Connect" "Sending $filename..." -i phone
            
            if kdeconnect-cli -d "$device" --share "$file"; then
                notify-send "KDE Connect" "Successfully sent $filename" -i dialog-information
            else
                notify-send "KDE Connect" "Failed to send $filename" -u critical -i dialog-error
            fi
        fi
        ;;
    "Refresh Connection") kdeconnect-cli --refresh ;;
esac
