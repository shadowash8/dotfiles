#!/bin/sh -e
. "$HOME/.cache/ashwal/colors.sh"

while :; do    
    VOL=$(sb-volume)
    NET=$(sb-network)
    TIME=$(date +"%H:%M")
    
    echo "%{B$background}%{l}%{B$color3}%{F$foreground} $NET %{F-}%{B-} %{c}%{B$color3}%{F$foreground} $TIME %{F-}%{B-} %{r}%{B$color3}%{F$foreground} $VOL %{F-}%{B-}"
    
    sleep 60
done | mojito -f "monospace-12" -g 720x25+645+8 -B "$background" -F "$foreground"
