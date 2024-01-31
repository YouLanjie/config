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

alias c='clear'
alias n='nvim'
alias rm='rm -i'
alias vim='nvim'
# alias sudo='sudo '

alias md='mkdir -p'
alias rd='rmdir'

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gcl='git clone'
alias gcm='git commit -v'
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

# Background Picture: feh --bg-fill
# Background Video: killall xwinwrap;nohup 2>&1 >/dev/null xwinwrap -fs -fdt -ni -b -nf -- mpv --input-ipc-server=/tmp/mpvsocket_wallpaper --loop -wid WID'
 
# alias wine64='WINEARCH=win64 WINEPREFIX=~/.win64 wine'
# alias wine32='WINEARCH=win32 WINEPREFIX=~/.win32 wine'
 
# export PATH="$PATH:/home/$USER/.local/bin"
# export TIMER_FORMAT="\033[1;32m> time: %d"

[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local

