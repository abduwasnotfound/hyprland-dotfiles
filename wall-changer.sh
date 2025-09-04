#!/bin/bash
DIR="$HOME/.config/hypr/wallpapers"
CACHE="$HOME/.cache/wall_thumbs"
LAST="$HOME/.cache/last_wallpaper"

mkdir -p "$CACHE"

# Build Rofi menu (with icons if you generated thumbnails)
CHOICE=$(ls "$DIR" | while read img; do
  echo -en "$img\x00icon\x1f$CACHE/$img.png\n"
done | rofi -dmenu -show-icons -i -p "    󰋫 Wallpaper:")

if [ -n "$CHOICE" ]; then
  WALL="$DIR/$CHOICE"

  # Apply wallpaper with animation
  swww img "$WALL" \
    --transition-type center \
    --transition-fps 60 \
    --transition-duration 1.5

  # Generate pywal colorscheme
  wal -i "$WALL" -n
  /home/abdullah/.local/bin/borders.sh
  /home/abdullah/.config/Vencord/scripts/wal.sh
  pkill waybar && waybar &
  pkill swayosd && swayosd-server &
  pkill swaync && swaync
  cp ~/.cache/wal/colors.css ~/.config/gtk-3.0/gtk.css
  cp ~/.cache/wal/colors.css ~/.config/gtk-4.0/gtk.css

  # Reload your system colors if needed
  # Example: reload waybar, kitty, zathura, dunst, etc.
  # killall -SIGUSR2 waybar
  # killall -SIGUSR1 kitty

  # Save last wallpaper
  echo "$WALL" >"$LAST"
fi
