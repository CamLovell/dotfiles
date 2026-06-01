#!/bin/bash
MONITORS_CONFIG=$HOME/.config/hypr/monitor_definitions.conf

set -e
echo $MONITORS_CONFIG
mapfile -t monitors < <(
    hyprctl monitors all |
    awk '/Monitor DP-/{name=$2; id=$4; print id, name}' |
    sort -n |
    awk '{print $2}'

)

echo "# Auto-generated monitor definitsions by UserScripts/Monitors.sh" > "$MONITORS_CONFIG"
echo "\$laptop = eDP-1" >> "$MONITORS_CONFIG"

if [ "${#monitors[@]}" -eq 2 ]; then
    echo "\$horizontal = ${monitors[0]}" >> "$MONITORS_CONFIG"
    echo "\$vertical = ${monitors[1]}" >> "$MONITORS_CONFIG"
fi

LID_STATE=$(awk -F': *' '{print $2}' /proc/acpi/button/lid/LID0/state 2>/dev/null)
if [ "$LID_STATE" = 'closed' ]; then
    echo "\$lid_shut = true" >> "$MONITORS_CONFIG"
fi

