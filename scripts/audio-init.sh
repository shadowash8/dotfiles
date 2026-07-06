#!/bin/bash

# Define the hardware cards
RYZEN_CARD="alsa_card.pci-0000_04_00.6"

# Force cards into 'pro-audio' profile
# This exposes the raw hardware path for maximum intensity
pactl set-card-profile "$RYZEN_CARD" pro-audio

# Define the specific Sink name
# Note: In Pro Audio mode, the name usually ends in .pro-output-0 or .pro-output-3
RYZEN_SINK="alsa_output.pci-0000_04_00.6.pro-output-0"

# Force 10% Volume
pactl set-sink-volume "$RYZEN_SINK" 10%

# Set your preferred default
pactl set-default-sink "$RYZEN_SINK"

# Ensure that sink is not muted
pactl set-sink-mute "$RYZEN_SINK" 0

echo "Your audio is now pro!"
