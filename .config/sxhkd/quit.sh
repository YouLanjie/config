#!/bin/bash
echo '{"command": ["quit"]}' | socat - /tmp/mpvsocket_wallpaper
