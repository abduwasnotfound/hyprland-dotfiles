#!/bin/bash
lastwp=$(cat ~/.cache/last_wallpaper 2>/dev/null)
if [ -n "$lastwp" ]; then
  swww img "$lastwp" --transition-type center --transition-fps 60 --transition-duration 1.5
else
  echo "No last wallpaper found"
fi
