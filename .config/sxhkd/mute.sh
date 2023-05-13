#!/bin/bash
echo '{"command": ["cycle" , "mute"]}' | socat - /tmp/mpvsocket_wallpaper
