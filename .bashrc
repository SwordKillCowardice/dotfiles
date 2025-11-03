# 基础配置
# 只在需要时执行整个配置文件
case $- in
    *i*) ;;
      *) return;;
esac

# 添加路径到环境变量
export PATH="$HOME/.local/bin:$PATH"

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
shopt -s histappend      # 向历史记录中追加而非覆盖
shopt -s cmdhist         # 设置多行命令保存为一条历史记录 
HISTSIZE=1000            # 当前会话可回看的命令条数
HISTFILESIZE=2000        # 历史文件中保留的命令数字

# 命令自动补全
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ---------------------------------------------------------------------------------------

# 显示设置
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

# ---------------------------------------------------------------------------------------

# 功能设置
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # 增强分页功能

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

# 使cd-不打印提示 
cd() {
    if [[ "$1" == "-" ]]; then
        builtin cd - >/dev/null
    else
        builtin cd "$@"
    fi
}

# 集成git提示
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line_Ubuntu
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

# ---------------------------------------------------------------------------------------

# 别名
# 集中管理个人别名
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ls别名
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# git
alias gs='git status'

# 虚拟机
alias vmls='/mnt/d/Program\ Files/Oracle/VirtualBox/VBoxManage.exe list vms'
alias vmon='/mnt/d/Program\ Files/Oracle/VirtualBox/VBoxManage.exe startvm US2404 --type headless'
alias vmrun='/mnt/d/Program\ Files/Oracle/VirtualBox/VBoxManage.exe list runningvms'
alias vmoff='/mnt/d/Program\ Files/Oracle/VirtualBox/VBoxManage.exe controlvm US2404 poweroff'
alias vmip='/mnt/d/Program\ Files/Oracle/VirtualBox/VBoxManage.exe guestproperty get US2404 "/VirtualBox/GuestInfo/Net/0/V4/IP"' 
alias vmcon='ssh -p 3022 skc@$(ip route | grep default | sed -E '\''s/.* ([0-9.]+).*/\1/'\'')'

# Python调试
alias db='python3 -m pdb'

# --------------------------------------------------------------------------------------

# 目录切换
alias d='cd /mnt/d'
alias c='cd /mnt/c'
alias skc='cd /mnt/c/Users/tianx/Desktop/SwordKillCowardice'

# 打开文件
alias vb='vim ~/.bashrc'    # 快速编辑bash配置文件
alias rb='source ~/.bashrc' # 重载bash配置
alias vv='vim ~/.vimrc'     # 快速编辑vim配置文件
alias rge='vim ~/rg/server.py'

# 打开网页
alias gh='"/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" https://github.com/'
alias gpt='"/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" https://chatgpt.com/'
alias ds='"/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" https://chat.deepseek.com/'
alias deep='"/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" https://www.deepl.com/zh/translator'
alias bl='"/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" https://space.bilibili.com/3546908381415679?spm_id_from=333.1007.0.0' 

# 打开软件
# 定义函数wopen
wopen() {
    if [ -z "$1" ]; then
        return 1
    fi
    (
        "$1" >/dev/null 2>&1 &
    )
}

# 别名
alias cfw='wopen "/mnt/d/Tools/CFW_META/Clash for Windows.exe"'
alias et='wopen "/mnt/c/Program Files/Everything/Everything.exe"'
alias osd='wopen /mnt/d/Tools/Obsidian/Obsidian.exe'
alias xmind='wopen /mnt/c/Users/tianx/AppData/Local/Programs/Xmind/Xmind.exe'
alias qq='wopen /mnt/d/Social/Tencent/QQNT/QQ.exe'
alias vx='wopen /mnt/d/Social/Weixin/Weixin.exe'

# ---------------------------------------------------------------------------------------

# 快捷键
# 清屏
bind -m vi-insert '"\C-l": clear-screen'
bind -m vi-command '"\C-l": clear-screen'
