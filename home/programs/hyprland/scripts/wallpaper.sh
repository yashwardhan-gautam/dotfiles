#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

if [ "$1" = "next" ]; then
    # Logic for next wallpaper
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | sort | head -n 1)
else
    WALLPAPER="$WALLPAPER_DIR/default.jpg"
fi

swww img "$WALLPAPER" --transition-type wipe --transition-duration 1