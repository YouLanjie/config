#!/bin/zsh
# =======================================
# 开机启动应用
# =======================================

#
# 其他设置
#

# 指针设置
xsetroot -cursor_name left_ptr

#
# 启动
#

# 启动polybar
# pgrep -x polybar > /dev/null || ~/.config/polybar/launch.sh --cuts

# 启动picom
pgrep -x picom > /dev/null || ~/.config/picom/launch.sh

# 启动conky
pgrep -x conky > /dev/null || (killall conky ;conky -c ~/.config/conky/conky_leon)

# 启动playerctld
playerctld daemon

# 启动fcitx
fcitx

# 启动utools
pgrep -x utools > /dev/null || nohup utools >/dev/null &

# 启动kdeconnect启动器
pgrep -x kdeconnect-indicator > /dev/null || nohup kdeconnect-indicator 2>&1 >/dev/null &

# klipper
# pgrep -x klipper > /dev/null || nohup klipper 2>&1 >/dev/null &

# Dunst通知服务
# pgrep -x dunst > /dev/null || nohup dunst 2>&1 >/dev/null &

# 启动状态栏
# pgrep -x vala-panel > /dev/null || nohup vala-panel 2>&1 >/dev/null &

# 启动plasmashell
# plasmashell

# 启动latte
pgrep -x latte > /dev/null/ || nohup latte-dock 2>&1 >/dev/null &

# 启动polkit-kde-authentication-agent
nohup /usr/lib/polkit-kde-authentication-agent-1 2>&1 >/dev/null &

# 壁纸
feh --randomize --bg-fill ~/图片/yuindex_bg/*
pgrep -x xwinwrap > /dev/null || (killall xwinwrap;nohup 2>&1 >/dev/null xwinwrap -fs -fdt -ni -- mpv --input-ipc-server=/tmp/mpvsocket_wallpaper --loop -wid WID ~/Videos/本地/动态壁纸/沃玛.mp4 &)

