#!/usr/bin/zsh

#================================================================
#   Copyright (C) 2023 YouLanjie
#
#   文件名称：volume_down.sh
#   创 建 者：youlanjie
#   创建日期：2023年01月19日
#   描    述：调低音量
#
#================================================================

pactl set-sink-volume @DEFAULT_SINK@ -5% && dunstify -u low -h int:value:"`pactl get-sink-volume @DEFAULT_SINK@ |awk '{print $12}'|sed -n "1p"|sed "s/[^0-9]//g"`" "Chang Volume Left:`pactl get-sink-volume @DEFAULT_SINK@ |awk '{print $5}'|sed -n "1p"`" && dunstify -u low -h int:value:"`pactl get-sink-volume @DEFAULT_SINK@ |awk '{print $12}'|sed -n "1p"|sed "s/[^0-9]//g"`" "Chang Volume Right:`pactl get-sink-volume @DEFAULT_SINK@ |awk '{print $12}'|sed -n "1p"`"
