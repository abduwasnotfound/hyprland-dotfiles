#!/bin/bash

ICONS=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

# Make sure fifo exists
[ ! -p /tmp/cava.fifo ] && mkfifo /tmp/cava.fifo

# Start Cava if not already running
pgrep -f "cava -p ~/.config/cava/waybar/config" >/dev/null || cava -p ~/.config/cava/waybar/config &

# Read one line from fifo
if read -r LINE </tmp/cava.fifo; then
  OUTPUT=""
  for VAL in $LINE; do
    [ "$VAL" -gt 7 ] && VAL=7
    OUTPUT+="${ICONS[$VAL]}"
  done
  echo "$OUTPUT"
fi
