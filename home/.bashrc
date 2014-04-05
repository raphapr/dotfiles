# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

########### HISTORY CONTROL ##############

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=10000

##########################################

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

#Cor nas manpages (requer pacote most)
export MANPAGER="/usr/bin/most -s"



################################# Aliases ##########################################

#Minhas modificaçoes
complete -cf sudo
alias ls='ls --color=always'
alias lash='ls -lash'
alias l='ls -CF'
alias sudo='sudo '
alias pblock="sudo rm -rf /var/lib/pacman/db.lck"
alias desk='cd ~/Desktop'
alias h='history'
alias vim='vim --servername vim'
alias v='vim'
alias svlc='vlc --extraintf=luahttp --fullscreen --qt-start-minimized' # VLC HTTP Server
alias iup='imgurbash' # image upload # precisa do imgurbash
alias myip='curl ifconfig.me' # show extern ip
alias chromium='chromium --disk-cache-dir=/tmp/cache'
alias showbb='cat /proc/acpi/bbswitch'
alias grubconf='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# Pacman/Yaourt aliases 
alias p='sudo pacman'
alias pacup='sudo pacman -Syuu' 
alias pacin='sudo pacman -S'
alias pacrem='sudo pacman -Rns'
alias pacreps='sudo pacman -Ss'
alias y='yaourt'
alias yup='yaourt -Syua' # Atualiza os repositorios do Arch + AUR

#Baixar videos do Youtube (requer youtube-dl)
alias utube='youtube-dl -c -t'
#Baixar apenas o audio do video
alias atube='youtube-dl --extract-audio --audio-format=mp3 -t'

# Pings:
alias google='ping -i 3 www.google.com'
alias globo='ping -i 3 www.globo.com'
alias yahoo='ping -i 3 www.yahoo.com'

#comando para copiar/colar via terminal para a área de transferência
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

#cp com barra de progresso (requer o pacote pycp-git)
alias pcp='pycp'

#(requer a instalação do autojump)
#[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
#alias jt='j --stat'

#[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

#arch-wiki-lite em português
export wiki_lang="Português" 

#alias do arch-wiki-lite
alias wiki='wiki-search'

#Monta e desmonta a partição NTFS /dev/sda3
alias mount-ntfs='sudo ntfs-3g /dev/sda3 /mnt'
alias umount-nfs='sudo umount /mnt'

#Conveniencias do Shell
alias sb='source ~/.bashrc'
alias eb='vim ~/.bashrc'
alias rclua='vim ~/.config/awesome/rc.lua'
alias bkp='cp ~/.bashrc ~/Dropbox/Backup/shell-config && cp ~/.vimrc ~/Dropbox/Backup/shell-config && cp ~/.tmux.conf ~/Dropbox/Backup/shell-config && cp -r ~/.vim ~/Dropbox/Backup/shell-config/'
alias pacbkp='tar -cjf ~/Dropbox/Backup/pacman-database.tar.bz2 /var/lib/pacman/local' # pacman database backup # Extrair na raíz: tar -xjvf pacman-database.tar.bz2

## control cd commands
# get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## aliases para a saída de audio
alias hdmiaudion='sudo -u $USER pactl set-card-profile 0 output:hdmi-surround' # Ativa saída de audio HDMI
alias hdmiaudioff='sudo -u $USER pactl set-card-profile 0 output:analog-stereo+input:analog-stereo ' # Ativa saída de audio padrão
## Quando usar HDMI
alias hdmion='xrandr --output HDMI1 --auto --right-of LVDS1'
alias rauto='/usr/bin/xrandr --auto'


################################# Funções ##########################################

#Função para baixar pacote no AUR pelo Yaourt sem confirmação
function ys()
{
    yaourt -S $1 --noconfirm
}


# Lista os detalhes de um determinado padrão de processos

function aux()
{
    ps aux | grep  $1
}

#
## Zipar arquivos ou diretórios.
function zipf() { zip -r "$1".zip "$1" ; }

#
## Archive extractor.
## usage: ex <file>
#
extract() {
 if [ -f $1 ] ; then
  case $1 in
   *.tar.bz2) tar xvjf $1 ;;
 *.tar.gz) tar xvzf $1 ;;
  *.tar.xz) tar xvJf $1 ;;
   *.bz2) bunzip2 $1 ;;
 *.rar) unrar x $1 ;;
  *.gz) gunzip $1 ;;
   *.tar) tar xvf $1 ;;
 *.tbz2) tar xvjf $1 ;;
  *.tgz) tar xvzf $1 ;;
   *.zip) unzip $1 ;;
 *.Z) uncompress $1 ;;
  *.7z) 7z x $1 ;;
   *.xz) unxz $1 ;;
 *.exe) cabextract $1 ;;
  *) echo "\`$1': unrecognized file compression" ;;
   esac
 else
  echo "\`$1' is not a valid file"
   fi
}


function top10() {
	# copyright 2007 - 2010 Christopher Bratusek
	history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head
     }

###### info about current open windows
# copyright 2007 - 2010 Christopher Bratusek
function wininfo() {
	xprop | grep -w "WM_NAME\|WM_CLASS\|WM_WINDOW_ROLE\|_NET_WM_STATE"
}

# Busca os 10 mirrors mais rápidos e salva no mirrorlist
#alias ref='sudo reflector -l 10 --sort rate --save /etc/pacman.d/mirrorlist'

########### Systemd Shorcuts ##############
########### Comandos simplificados #######

## simplified systemd command, for instance "sudo systemctl stop xxx.service" - > "0.stop xxx"
if ! systemd-notify --booted;
then  # for not systemd
    0.start() {
        sudo rc.d start $1
    }

    0.restart() {
        sudo rc.d restart $1
    }

    0.stop() {
        sudo rc.d stop $1
    }
else
# start systemd service
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
fi

# 256 cores no terminal (para utilizar cores no vim)
export TERM="xterm-256color"

# Carregar tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export EDITOR='vim'

# PATH
PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin:$HOME/bin
export PATH

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
#export ZZOFF=""  # desligue funcoes indesejadas
#export ZZPATH="/usr/bin/funcoeszz"  # script
#source "$ZZPATH"

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel awt.useSystemAAFontSettings=on' 

#Outras aliases
alias controller='ssh -p 5116 raphael@200.17.114.136'
alias compute01='ssh -p 5115 raphael@200.17.114.136'
alias lcontroller='ssh raphael@192.168.2.223'
alias lcompute01='ssh raphael@192.168.2.224'
alias vpn='cd ~/.openvpn && sudo openvpn users.conf'
alias startx='startx &> ~/.xlog'
