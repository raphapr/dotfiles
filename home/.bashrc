#
# bashrc
# Raphael P. Ribeiro

# Preambulo           ---------------------------------------------- {{{

if [ "$DISPLAY" ]; then
    xset r rate 200 30
fi

export EDITOR=nvim

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# bash prompt
PS1="\w » "

#}}}
# History Control     ---------------------------------------------- {{{

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist

# After each command, save and reload history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
#export PROMPT_COMMAND="history -a"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000

#}}}
# Paths & Sources     ---------------------------------------------- {{{

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/home/raphael/.gem/ruby/2.2.0/bin:/home/raphael/.bin:/etc/profile.d/jre.sh"
export MANPAGER="/usr/bin/most -s" #Cor nas manpages (requer pacote most)
export TERM="screen-256color" # 256 cores no terminal (para utilizar cores no vim)
source ~/.git-completion.bash

# fasd initalization
# quick access to files and directories for POSIX shells
eval "$(fasd --init auto)"

# fzf initialization
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# }}}
# Aliases             ---------------------------------------------- {{{

# Conveniências do shell
alias lash='ls -lash'
alias l='ls -CF'
alias v='vim'
alias k='kill -9'
alias r='ranger'
alias h='history 1000'
alias g='git'
alias desk='cd ~/Desktop'
alias iup='imgurbash' # image upload # precisa do imgurbash
alias myip='curl ifconfig.me' # show extern ip
alias chromium='chromium --disk-cache-dir=/tmp/cache'
alias showbb='cat /proc/acpi/bbswitch'
alias grubconf='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias automhwd='sudo mhwd -r pci video-hybrid-intel-nvidia-bumblebee && sudo mhwd -a pci nonfree 0300'
alias sb='source ~/.bashrc'
alias eb='vim ~/.bashrc'
alias ev='vim ~/.vimrc'
alias i3c='vim ~/.i3/config'
alias transm='transmission-remote-cli'
alias xmerge='xrdb -merge ~/.Xresources'
alias repos='cd ~/Copy/repos'
alias cheatsh='zathura ~/Copy/cheats/canivete-shell.pdf'
alias cheatsed='cat ~/Copy/cheats/sed | more'
alias x='dtrx'

# fasd 
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# vim
alias vim='vim -X --servername vim'
alias vs='vim -X --servername vim -S ~/.vim/sessions/default'
alias vsa='vim -X --servername vim -S ~/.vim/sessions/session_a'
alias vsb='vim -X --servername vim -S ~/.vim/sessions/session_b'

# translate-shell
alias gt='trans' # (AUR: translate-shell-git)
alias gte='trans -b :en' # portuguese to english
alias gtb='trans -b' # english to portuguese
alias gtp='trans :en -p -b' # pronuncia

# Pacman/Yaourt aliases
alias p='sudo pacman'
alias pacup='sudo pacman -Syuu'
alias pblock="sudo rm -rf /var/lib/pacman/db.lck"
alias y='yaourt'
alias yup='yaourt -Syua' # Atualiza os repositorios do Arch + AUR
alias mirror-update='sudo pacman-mirrors -g'

#Baixar videos do Youtube (requer youtube-dl)
alias utube='youtube-dl -c'
#Baixar apenas o audio do video
alias atube='youtube-dl --extract-audio --audio-format=mp3 -t'

# Pings
alias google='ping -i 3 www.google.com'
alias globo='ping -i 3 www.globo.com'
alias yahoo='ping -i 3 www.yahoo.com'

# connman
alias c="connmanctl"
alias wfscan="connmanctl services"
alias wfcon="connmanctl connect"

#comando para copiar/colar via terminal para a área de transferência
alias pbcopy='xclip -sel clip'
alias pbpaste='xclip -sel clip -o'

# Monta e desmonta a partição NTFS /dev/sda3
alias mount-ntfs='sudo ntfs-3g /dev/sda3 /mnt'
alias umount-ntfs='sudo umount /mnt'

# tmux
alias tmux='tmux -f ~/.tmux/tmux.conf'
alias t='tmux -f ~/.tmux/tmux.conf'
alias tls='tmux ls'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'

#VPN
alias vpn='cd ~/.openvpn && sudo openvpn pfsense-udp-1194.ovpn'

# urserver
alias urserver='/opt/urserver/urserver --daemon'

# }}}
# Functions           ---------------------------------------------- {{{

# wallchange        {{{

# gist upload com xclip funcionando
function wallc()
{
    cp $1 ~/.wallpaper.png && feh --bg-fill ~/.wallpaper.png
}

# }}}
# ag                {{{

function ag()
{
    ag --smart-case $1
}

# }}}
# f                 {{{

function f()
{
    find . | ag $1
}

# }}}
# gistt             {{{

# gist upload com xclip funcionando
function gistt()
{
    gist $1 | pbcopy && pbpaste && $BROWSER $(pbpaste)
}

# }}}
# ys                {{{

# yaourt sem confirmação
function ys()
{
    yaourt -S $1 --noconfirm
}

# }}}
# aux               {{{

# lista os detalhes de um determinado padrão de processos
function aux()
{
    ps aux | grep  $1
}

# }}}
# wininfo           {{{
# info about open windows

# copyright 2007 - 2010 Christopher Bratusek
function wininfo() {
	xprop | grep -w "WM_NAME\|WM_CLASS\|WM_WINDOW_ROLE\|_NET_WM_STATE"
}

# }}}
# gl                {{{
# compilando com OpenGL
function cgl() {
    if [ -f a.out ]; then rm -rf a.out; fi
    g++ $1 -o a.out -lGLU -lGL -lglut && ./a.out
}

# }}}
# vz                {{{

function vz()
{
    fasd -fe vim $1
}

# }}}
# take              {{{

function take()
{
    mkdir -p $1
    cd $1
}

# }}}
# Systemd Shortcuts {{{

0.start() {
    sudo systemctl start $1.service
    }
# restart systemd service
0.restart() {
     sudo systemctl restart $1.service
    }
# stop systemd service
0.stop() {
    sudo systemctl stop $1.service
    }
# enable systemd service
    0.enable() {
        sudo systemctl enable $1.service
    }
# disable a systemd service
0.disable() {
         sudo systemctl disable $1.service
    }
# show the status of a service
0.status() {
        systemctl status $1.service
    }
# reload a service configuration
0.reload() {
        sudo systemctl reload $1.service
    }
# list all running service
0.list() {
        systemctl
    }
# list all failed service
0.failed () {
        systemctl --failed
    }
# list all systemd available unit files
0.list-files() {
        systemctl list-unit-files
    }
# check the log
0.log() {
        sudo journalctl
    }
# show wants
0.wants() {
        systemctl show -p "Wants" $1.target
    }
# analyze the system
0.analyze() {
     systemd-analyze $1
    }

# }}}
# Systemd --user    {{{

1.start() {
    systemctl --user start $1.service
    }
# restart systemd service
1.restart() {
    systemctl --user restart $1.service
    }
# stop systemd service
1.stop() {
    systemctl --user stop $1.service
    }
# enable systemd service
1.enable() {
    systemctl --user enable $1.service
    }
# disable a systemd service
1.disable() {
    systemctl --user disable $1.service
    }
# show the status of a service
1.status() {
    systemctl --user status $1.service
    }
# reload a service configuration
1.reload() {
    systemctl --user reload $1.service
    }
# list all running service
1.list() {
    systemctl --user
    }
# list all failed service
1.failed () {
    systemctl --user --failed
    }
# list all systemd available unit files
1.list-files() {
    systemctl --user list-unit-files
    }
# check the log
1.log() {
    journalctl --user
    }
# show wants
1.wants() {
    systemctl --user show -p "Wants" $1.target
    }

# }}}

# }}}
