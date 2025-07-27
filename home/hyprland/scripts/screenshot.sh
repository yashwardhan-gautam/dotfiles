#!/usr/bin/env bash

case "$1" in
    "s")
        grim -g "$(slurp)" - | swappy -f -
        ;;
    "f")
        grim - | swappy -f -
        ;;
    *)
        echo "Usage: $0 {s|f}"
        echo "  s: Select area"
        echo "  f: Full screen"
        ;;
esac