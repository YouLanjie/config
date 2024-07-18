[[ ! -f ~/.zshrc_omz ]] || source ~/.zshrc_omz
export EDITOR='nvim'

# alias about ls
alias l='ls -F'
alias la='ls -A'
alias lh='ls -alh'
alias ll='ls -al'
alias ls='ls -X --color=auto'
# alias lh='ls --date "+%Y_%m_%d %H:%M:%S" -alh'
# alias ll='ls -al --date +%Y_%m_%d" "%H:%M:%S'

# alias for sudo
alias sudo='sudo '

alias c='clear'
alias n='nvim'
alias rm='rm -i'
alias vim='nvim'
#alias psp='ps -eo "%U %p %n %y %a %c" |grep -i '
alias psp='ps aux |grep -i '

alias md='mkdir -p'
alias rd='rmdir'

# alias about emacs
alias emacs2='emacs -nw'
alias e2='emacs -nw'
alias e='emacs'

# alias for git from oh-my-zsh
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gcl='git clone'
alias gcm='git commit -v'
alias gcmh='git commit -v -m "`sed -n "1p" .git/COMMIT_EDITMSG`"'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gm='git merge'
alias gp='git push'
alias gpv='git push -v'
alias gr='git remote'
alias gra='git remote add'
alias grm='git rm'
alias grmc='git rm --cached'
alias grs='git restore'
alias grv='git remote -v'
alias gst='git status'
alias gsw='git switch'
function gcls() {
	gst >/dev/null 2>&1 || return -1
	rm -f `gss | awk '{print $2}'`
}

# alias about wine
alias wine64='WINEARCH=win64 WINEPREFIX=~/.win64 wine'
alias wine32='WINEARCH=win32 WINEPREFIX=~/.win32 wine'

# background image or video
# alias bg='feh --bg-fill'
# alias bg_mpv_pause="echo '{\"command\": [\"cycle\", \"pause\"]}' | socat - /tmp/mpvsocket_wallpaper"
# alias bg_mpv_quit="echo '{\"commquit: [\"quit\"]}' | socat - /tmp/mpvsocket_wallpaper"

# PART
export PATH="$PATH:/mnt/UserData/Code/my-test/bin:/home/$USER/.local/bin"
# FZF Setting
export FZF_DEFAULT_OPTS="--layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
#export FZF_COMPLETION_TRIGGER="**"

# =====================================================
# ==================== My Function ====================
# =====================================================

# 自动切换至WorkSpace
[[ -d ~/WorkSpace/ ]] && [[ `pwd` == "/home/$USER" ]] && cd ~/WorkSpace/

# 动态壁纸
video_background() {
	usagetext="\
usage: video_background [options]
    -f <file> 指定输入文件
    -h        show this message
    -n        open the video whiout input"

	ni="no"
	while {getopts 'f:nh?' arg} {
		case $arg {
			f) {
				killall xwinwrap
				sleep 0.05
				if [[ $ni == "no" ]] {
					nohup 2>&1 >/dev/null\
						xwinwrap -fdt -fs -un -s -b -nf -o 0.9999999 -ov --\
						mpv --input-ipc-server=/tmp/mpvsocket_wallpaper --loop -wid WID\
						"$OPTARG" &
				} else {
					nohup 2>&1 >/dev/null\
						xwinwrap -ni -fdt -fs -un -s -b -nf -o 0.9999999 -ov --\
						mpv --input-ipc-server=/tmp/mpvsocket_wallpaper --loop -wid WID\
						"$OPTARG" &
					}
				return 0
			};;
			n) ni="yes";;
			h|?) echo $usagetext && return 0;;
			*) echo $usagetext && return 1;;
		}
	}
	if [[ $@ == "" ]] {
		echo $usagetext
		return 1
	}
	return 0
}
_video_background() {
	local opts="-f -h -n"
	local cur="${CPMP_WORDS[COMP_CWORD]}"
	local prev="${COMP_WORDS[COMP_CWORD-1]}"
	COMPREPLY=()
	COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
	local IFS2=$IFS
	IFS=""
	case "${prev}" {
		-f|--filename) COMPREPLY=( $(compgen -o filenames -W "$(find ./ -type f -name "*.mp4" 2>/dev/null)" -- ${cur}) );;
		-h) COMPREPLY=() && return 0;;
	}
	IFS=$IFS2
        # _arguments -s -S '-f[文件名]' '-h[获取帮助]' '-n[让播放器没有输入]' '*:directory:_files -/'
	return 0
}
complete -F _video_background video_background

# ==============================
# 输出文件完整目录（可用）
function fp() {
	if [[ ! -e $1 ]] {
		echo "$1 不存在！"
		return -1
	}
	if [[ ${1[1]} == '/' ]] {
		echo "请传入相对位置！" >&2
		return -1
	}
	printf "%s/%s\n" $(pwd) $1
	return 0
}

# ==============================
# 将从B站下载的文件合并为有声的mp4文件
# $1 : 文件目录
function ffmpeg_bilibili_dir() {
	((! $+1)) && {
		o_dir="."
	}
	# file_m=`ls -1 $1|sed -n "s/^\(.*\)\..*/\1/p"|sort|uniq -c|sort|sed -n '$p'|awk '{print $2}'`
	file_m=`ls -1 $1|sed -n "s/^\(.*\)\..*/\1/p"|sort|uniq -c|sort|sed -n '$p'|sed "s/^[ ]*[^ ]* //"`
	if [[ ! -e $file_m.mp4 ]] {
		echo "$1/$file_m.mp4 文件或许缺失，退出"
		return -1
	}
	if [[ ! -e $file_m.m4a ]] {
		echo "$1/$file_m.m4a 文件或许缺失，退出"
		return -1
	}
	ffmpeg -i "$1/$file_m.mp4" -i "$1/$file_m.m4a" -codec copy "$1/$file_m.out.mp4"
	mv $1/$file_m.mp4 $1/$file_m.mp4\~
	mv $1/$file_m.out.mp4 $1/$file_m.mp4
}

# ==============================
# 将B站视频转为有声，但是传入文件名
# $1 : Filename
function ffmpeg_bilibili_file() {
	if [[ $1 == "" ]] {
		echo "没有参数！" >&2
		return -1
	}
	(echo $1|grep ".mp4\$")||{echo "输入文件不为mp4！" >&2 ; return -1}
	input_video=$1
	input_audio=$(echo $1|sed "s/.mp4\$/.m4a/")
	if [[ ! -f $input_video ]] {
		echo "$input_video 文件或许缺失，退出" >&2
		return -2
	}
	if [[ ! -f $input_audio ]] {
		echo "$input_video 文件或许缺失，退出" >&2
		return -2
	}
	ffmpeg -i "$input_video" -i $input_audio -codec copy "$input_video.out.mp4"
	mv "$input_video" "$input_video~"
	mv "$input_video.out.mp4" "$input_video"
}

# ==============================
# 将B站视频转为有声，但是快速调用
# $1 : 番剧集数
function ffmpeg_bilibili_fast() {
	for i ({1..$1}) {
		i2=$(printf "%02d" $i)
		ffmpeg_bilibili_file $i2*.mp4
	}
}

# ==============================
# 下载哔站视频
function video_download() {
	aria2c -i *.txt
	ffmpeg_bilibili_dir ./
}

# ==============================
# 迅速将指定文件内部的指定后缀名的转换成指定后缀名
# $1: dir
# $2: input file extern name no point
# $3: output file extern name no point
# $4: Other input to ffmpeg after
function ffmpeg_fast() {
	if [[ $1 == "-h" || $1 == "--help" || $1 == "" ]] {
		echo "usage: ffmpeg_fast <dir> <ext_in> <ext_out> [OPTARG]"
		return 0
	}
	line=$(ls "$1" |grep "\\.$2")
	echo $line |while {read input} {
		output=$(echo $input |sed "s/\\.$2\$/.$3/")
		cmd="ffmpeg -i \"$input\" $4 \"$output\""
		echo "\033[0;1;32mCOMMAND> \033[0;1;33m$cmd\033[0m"
		zsh -c "$cmd"
		count=$((count + 1))
	}
	echo "\033[0;30;47mLaunch Over.Wiating...\033[0m"
}

# ==============================
# 查看RPG游戏文案
function RPG() {
	# file_m=`ls -1 $1|sed -n "s/^\(.*\)\..*/\1/p"|sort|uniq -c|sort|sed -n '$p'|awk '{print $2}'`
	if [[ ! -e $1 ]] {
		echo "$1 文件或许缺失，退出"
		return -1
	}
	# cat $1|sed "s/\(\"parameters\":\[\"[^\"]*\"\]\)/\n\1\n/g"|grep "^\"parameters\":"|sed "s/\\\..\[[0-9]\]//g"|sed "s/\(\"parameters\":\[\"\"\]\)//g"|grep "^\"parameters\":"|sed "s/\"parameters\":\[\"\(.*\)\"]/\1\n/g"
	cat $1|\
		# 将对话分成不同的行
		sed "s/\(\"parameters\":\[\"[^\"]*\"\]\)/\n\1\n/g"|\
		# 匹配对应的行
		grep "^\"parameters\":"|\
		# 移除多余的转义字符，不包括角色名字显示
		sed 's/\\\\[a-zA-MO-Z]\[[0-9]*\]//g'|\
		# 清除空行
		sed "s/\(\"parameters\":\[\"\"\]\)//g"|\
		# 筛选剩余行
		grep "^\"parameters\":"|\
		# 清除 `parameters' 提示符
		sed "s/\"parameters\":\[\"\(.*\)\"]/\1\n/g"
}

# ==============================
# 查看RPG游戏文案
# 具备匹配搜索功能
function RPG2() {
	# file_m=`ls -1 $1|sed -n "s/^\(.*\)\..*/\1/p"|sort|uniq -c|sort|sed -n '$p'|awk '{print $2}'`
	if [[ ! -e $1 ]] {
		echo "$1 文件或许缺失，退出"
		return -1
	}
	if [[ $2 == "" ]] {
		echo "没有足够的参数!"
	}
	# cat $1|sed "s/\(\"parameters\":\[\"[^\"]*\"\]\)/\n\1\n/g"|grep "^\"parameters\":"|sed "s/\\\..\[[0-9]\]//g"|sed "s/\(\"parameters\":\[\"\"\]\)//g"|grep "^\"parameters\":"|sed "s/\"parameters\":\[\"\(.*\)\"]/\1\n/g"
	cat $1|\
		# 匹配含有特定数据的行
		grep "$2"|\
		# 将对话分成不同的行
		sed "s/\(\"parameters\":\[\"[^\"]*\"\]\)/\n\1\n/g"|\
		# 匹配对应的行
		grep "^\"parameters\":"|\
		# 移除多余的转义字符，不包括角色名字显示
		sed 's/\\\\[a-zA-MO-Z]\[[0-9]*\]//g'|\
		# 清除空行
		sed "s/\(\"parameters\":\[\"\"\]\)//g"|\
		# 筛选剩余行
		grep "^\"parameters\":"|\
		# 清除 `parameters' 提示符
		sed "s/\"parameters\":\[\"\(.*\)\"]/\1\n/g"
}

