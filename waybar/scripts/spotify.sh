#!/bin/bash

# ---------------- Configuration ----------------
fixed_width=13 # total width of the module including icon
cache_file="/tmp/spotify_scroll.txt"
step=1 # characters to move per update
# ------------------------------------------------

# Check if Spotify is running
if ! pgrep -x spotify >/dev/null; then
  printf "%-${fixed_width}s" "  Not Playing"
  exit 0
fi

# Get song info
status=$(playerctl -p spotify status 2>/dev/null)
title=$(playerctl -p spotify metadata title -p spotify 2>/dev/null)
artist=$(playerctl -p spotify metadata artist -p spotify 2>/dev/null)
[ -z "$title" ] && title="Unknown Title"
[ -z "$artist" ] && artist="Unknown Artist"

song_text="$title - $artist"

# Choose icon
if [ "$status" = "Playing" ]; then
  icon="   "
elif [ "$status" = "Paused" ]; then
  icon=" 󰐊  "
else
  printf "%-${fixed_width}s" "  Not Playing"
  exit 0
fi

# Calculate scroll width (text only)
scroll_width=$((fixed_width - ${#icon}))

# Load previous offset
offset=0
[ -f "$cache_file" ] && offset=$(cat "$cache_file")

# Prepare scroll text with padding for smooth loop
scroll_text="$song_text     "

# Slice text for scrolling
if [ ${#scroll_text} -le $scroll_width ]; then
  display="$scroll_text"
else
  # wrap around when offset exceeds length
  display="${scroll_text:$offset:$scroll_width}"
  next=$((offset + step))
  [ $next -ge ${#scroll_text} ] && next=0
  echo $next >"$cache_file"
fi

# Print fixed-width module
printf "%s%-*s" "$icon" "$scroll_width" "$display"
