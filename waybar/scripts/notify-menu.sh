#!/bin/bash
# Returns number of unread notifications for Waybar display
count=$(swaync-client count 2>/dev/null || echo 0)
echo "🔔 $count"
