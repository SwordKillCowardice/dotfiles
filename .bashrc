# 只在需要时执行整个配置文件
case $- in
    *i*) ;;
      *) return;;
esac

# chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# 长时间命令结束后发桌面通知
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# 设置为Vim风格
set -o vi

# 设置默认编辑器
export EDITOR=vim
export VISUAL=vim

# 设置tmux日志文件路径
export TMUX_TMPDIR="$HOME/.tmux/logs"

# 历史记录
HISTCONTROL=ignoreboth   # 历史记录中不记录重复行和以空格开头的行
shopt -s histappend   # 向历史记录中追加而非覆盖
shopt -s cmdhist   # 设置多行命令保存为一条历史记录 
HISTSIZE=1000   # 当前会话可回看的命令条数
HISTFILESIZE=2000   # 历史文件中保留的命令数字

# 命令自动补全
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# 显示
shopt -s checkwinsize # 确保窗口尺寸正常

# 设置光标
if [[ "$TERM" == xterm* ]]; then
    # 光标形状：2 = block（砖块）
    echo -ne '\e[2 q'
    # 光标颜色：#522B26
    echo -ne '\e]12;#0054DB\a'
fi

# 设置提示符
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# 设置窗口标题
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# 增强分页功能
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ls/grep彩色显示
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# 集中管理个人别名
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ls别名
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# 别名：快速切换至d/c盘
alias d='cd /mnt/d'
alias c='cd /mnt/c'

alias dt='cd /tmp' # 快速切换至/tmp目录
alias vb='vim .bashrc' # 快速编辑bash配置文件
alias rb='source .bashrc' # 重载bash配置
alias vv='vim .vimrc' # 快速编辑vim配置文件
alias vt='vim test' # 快速打开测试文件

# 自定义命令
# 打开Edge浏览器常用网页
gpt() {  # chatgpt
    d
    cmd.exe /c start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "https://chatgpt.com/"
    cd -
}

miss() { # missing-semester
    d
    cmd.exe /c start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "https://missing-semester-cn.github.io/"
    cd -
}

deep() { # deepel
    d
    cmd.exe /c start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "https://www.deepl.com/zh/translator"
    cd -
}

dou() { # 豆包
    d
    cmd.exe /c start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "https://www.doubao.com/chat/"
    cd -
}
# ---------------------------------------------------------------------------------------

# 打开软件
cfw() {      # CFW
    d
    cmd.exe /c start "" "D:\Tools\CFW_META\Clash for Windows.exe"
    cd -
}

et() {      # Everything
    d
    cmd.exe /c start "" "C:\Program Files\Everything\Everything.exe"
    cd -
}

qq() {      # QQ
    d
    cmd.exe /c start "" "D:\Social\Tencent\QQNT\QQ.exe"
    cd -
}

vx() {      # 微信
    d
    cmd.exe /c start "" "D:\social\Weixin\Weixin.exe"
    cd -
}

xmind() {       # Xmind
    c
    cmd.exe /c start "" "C:\Users\tianx\AppData\Local\Programs\Xmind\Xmind.exe"
    cd -
}

# ---------------------------------------------------------------------------------------

# 打开windows文件
wopen() {
    if [ -z "$1" ]; then
        # 没有参数 → 打开当前目录
        cmd.exe /c start "" "$(wslpath -w "$PWD")"
    else
        # 有参数 → 打开当前目录下的文件
        cmd.exe /c start "" "$(wslpath -w "$PWD")\\$1"
    fi
}

# 打开笔记
xopen() {
    d
    cd Mi*
    wopen M*
    cd ~
}

# ---------------------------------------------------------------------------------------

# 快捷键
# 清屏
bind -m vi-insert '"\C-l": clear-screen'
bind -m vi-command '"\C-l": clear-screen'
