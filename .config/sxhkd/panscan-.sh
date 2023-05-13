#!/bin/bash
echo '{"command": ["cycle" , "panscan", "-0.1"]}' | socat - /tmp/mpvsocket_wallpaper
