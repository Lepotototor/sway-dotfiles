#!/usr/bin/env bash

MONITORS=$(hyprctl monitors -j | jq length)
echo $MONITORS

# Nettoyage des règles précédentes
#hyprctl keyword monitor ",disable"

echo cacaa >> /tmp/caca.txt

if [ "$MONITORS" -gt 1 ]; then
    # Cas : écran interne + écran externe → mirroring
    hyprctl keyword monitor ",preferred,auto,1"
    hyprctl keyword monitor ",1920x1080,auto,1,mirror,eDP-1"
else
    # Cas : un seul écran
    hyprctl keyword monitor ",preferred,auto,1"
fi
