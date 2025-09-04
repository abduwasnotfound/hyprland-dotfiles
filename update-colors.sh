#!/bin/bash
COLOR=$(jq -r '.special.background' ~/.cache/wal/colors.json | sed 's/#//')
R=$((16#${COLOR:0:2}))
G=$((16#${COLOR:2:2}))
B=$((16#${COLOR:4:2}))

# write css with opacity
cat >~/.config/waybar/colors.css <<EOF
window#waybar {
    background: rgba($R, $G, $B, 0.7);
}
EOF
