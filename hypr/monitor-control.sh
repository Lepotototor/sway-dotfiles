#!/usr/bin/env bash

INTERNAL="eDP-1"
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

apply_config() {
    local count
    count=$(hyprctl monitors -j | jq length)

    if [ "$count" -gt 1 ]; then
        hyprctl --batch "
            keyword monitor ,preferred,auto,1;
            keyword monitor ,1920x1080,auto,1,mirror,$INTERNAL;
        "
    else
        hyprctl --batch "
            keyword monitor ,preferred,auto,1;
        "
    fi
}

handle_event() {
    case "$1" in
        monitoraddedv2*|monitorremoved*)
            apply_config
            ;;
    esac
}

# Appliquer une fois au démarrage
apply_config

# Écoute des événements Hyprland
socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do
    handle_event "$line"
done
