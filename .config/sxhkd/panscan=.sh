#!/bin/bash
echo '{"command": ["cycle" , "panscan" , "1"]}' | socat - /tmp/mpvsocket_wallpaper
