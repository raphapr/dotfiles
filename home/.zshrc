# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#unsetopt MULTIBYTE

# ctrl arrows funcionando
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# -------------------------------------------------------------------
# Minha configuração
# -------------------------------------------------------------------

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/raphael/.gem/ruby/2.1.0/bin:/home/raphael/bin:/home/raphael/.gem/ruby/2.1.0/bin:/home/raphael/bin"
export MANPAGER="/usr/bin/most -s" #Cor nas manpages (requer pacote most)
export POWERLINE=1 # Usar ou não usar powerline no vim 
export TERM="xterm-256color" # 256 cores no terminal (para utilizar cores no vim)
export EDITOR='vim'
source ~/.local/credentials.sh

# -------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------

#alias ls='ls --color=always'
alias lash='ls -lash'
alias l='ls -CF'
alias sudo='sudo '
alias pblock="sudo rm -rf /var/lib/pacman/db.lck"
alias desk='cd ~/Desktop'
alias h='history'
alias vim='vim --servername vim'
alias v='vim'
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
alias mirror-update='sudo pacman-mirrors -g'

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

#Monta e desmonta a partição NTFS /dev/sda3
alias mount-ntfs='sudo ntfs-3g /dev/sda3 /mnt'
alias umount-ntfs='sudo umount /mnt'

#Conveniencias do Shell
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias pacbkp='tar -cjf ~/Copy/pacman-database.tar.bz2 /var/lib/pacman/local' # pacman database backup # Extrair na raíz: tar -xjvf pacman-database.tar.bz2
alias k='kill -9'

#VIM
alias vv='vim -O'
alias vh='vim -o'
alias vt='vim -p'

#aliases para a saída de audio
alias hdmiaudion='sudo -u $USER pactl set-card-profile 0 output:hdmi-surround' # Ativa saída de audio HDMI
alias hdmiaudioff='sudo -u $USER pactl set-card-profile 0 output:analog-stereo+input:analog-stereo ' # Ativa saída de audio padrão
## Quando usar HDMI
alias hdmion='xrandr --output HDMI1 --auto --right-of LVDS1'

#SSH aliases
alias controller='ssh -p 5116 raphael@200.17.114.136'
alias compute01='ssh -p 5115 raphael@200.17.114.136'
alias lcontroller='ssh raphael@192.168.2.223'
alias lcompute01='ssh raphael@192.168.2.224'

#Tmux
alias tmux='tmux -f ~/.tmux/tmux.conf'
alias tmuxl='tmux ls'
alias tmuxa='tmux attach -t'

#VPN
alias vpn='cd ~/.openvpn && sudo openvpn users.conf'

#Grava log do startx
alias startx='startx &> ~/.xlog'

# -------------------------------------------------------------------
# Funções
# -------------------------------------------------------------------

#Baixa pacote no AUR pelo Yaourt sem confirmação
function ys()
{
    yaourt -S $1 --noconfirm
}


# Lista os detalhes de um determinado padrão de processos
function aux()
{
    ps aux | grep  $1
}

## Zipar arquivos ou diretórios.
function zipf() { zip -r "$1".zip "$1" ; }

## Archive extractor.
## usage: ex <file>
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

function pasteb(){
pastebinit $1 | pbcopy
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


# Compilando com OpenGL
function gl() {
    if [ -f a.out ]; then rm -rf a.out
    fi
    if [ $1 == '-r'  ]; then
        g++ $2 -o a.out -lGLU -lGL -lglut && ./a.out
    else
        g++ $1 -o a.out -lGLU -lGL -lglut
    fi
}


########### Systemd Shorcuts ##############
########### Comandos simplificados #######

############### Systemctl ############### 

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


############### Systemctl --user ############### 


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


# ----------------------------------------------------------
