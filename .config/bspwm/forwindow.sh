#!/bin/zsh
# =======================================
# 针对窗口的设置
# =======================================

#
# Example
#
# bspc rule -a Gimp desktop='^8' state=floating follow=on
# bspc rule -a mplayer2 state=floating
# bspc rule -a Kupfer.py focus=on

#
# 设置
#
bspc rule -a Screenkey            manage=off
bspc rule -a Terraria.bin.x86_64  state=fullscreen
bspc rule -a uTools               state=floating
bspc rule -a center-termux        state=floating
bspc rule -a editor-nvim          state=floating
bspc rule -a SimpleScreenRecorder state=floating
bspc rule -a Fsearch              state=floating
bspc rule -a Wine                 desktop='qq'       state=floating layer=normal
bspc rule -a qq.exe               desktop='qq'       state=floating layer=normal
bspc rule -a wechat.exe           desktop='wechat'   state=floating layer=normal
bspc rule -a bilibili             desktop='bilibili' state=floating
bspc rule -a Microsoft-edge       desktop='^1'
bspc rule -a netease-cloud-music  desktop='music'
bspc rule -a plasma-systemmonitor desktop='systemmonitor'
bspc rule -a Steam                desktop='steam'
bspc rule -a "Minecraft* 1.18.2"  desktop='minecraft'
bspc rule -a Terraria.bin.x86_64  desktop='terraria'
bspc rule -a org.jackhuang.hmcl.Launcher desktop='minecraft-hmcl'
# bspc rule -a
