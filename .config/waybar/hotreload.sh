#!/usr/bin/env bash
trap "killall waybar 2>/dev/null" EXIT

while true; do
    waybar &
    WAYBAR_PID=$!
    
    inotifywait --quiet -e modify $HOME/.config/waybar/
    
    kill "$WAYBAR_PID"
    wait "$WAYBAR_PID" 2>/dev/null
done
