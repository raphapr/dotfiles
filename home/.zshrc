# zshrc
# Raphael P. Ribeiro
# Source Prezto.
#

# Preambulo -------------------------------------------------------- {{{

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ctrl arrows funcionando
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# }}}
# Minha configuração  ---------------------------------------------- {{{

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/raphael/.gem/ruby/2.1.0/bin:/home/raphael/bin:/home/raphael/.gem/ruby/2.1.0/bin:/home/raphael/bin"
export MANPAGER="/usr/bin/most -s" #Cor nas manpages (requer pacote most)
export TERM="xterm-256color" # 256 cores no terminal (para utilizar cores no vim)
export EDITOR='vim'
export BROWSER='chromium'
source ~/.local/credentials.sh
zstyle ":completion:*:commands" rehash 1 # Atualiza o cache para o auto complete, principalmente depois de instalar pacotes novos.

# }}}
# Aliases ---------------------------------------------------------- {{{

# Conveniências do shell
alias lash='ls -lash'
alias l='ls -CF'
alias sudo='my_sudo '
alias pblock="sudo rm -rf /var/lib/pacman/db.lck"
alias desk='cd ~/Desktop'
alias h='history'
alias vim='vim -X --servername vim'
alias v='vim'
alias iup='imgurbash' # image upload # precisa do imgurbash
alias myip='curl ifconfig.me' # show extern ip
alias chromium='chromium --disk-cache-dir=/tmp/cache'
alias showbb='cat /proc/acpi/bbswitch'
alias grubconf='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias automhwd='sudo mhwd -r pci video-hybrid-intel-nvidia-bumblebee && sudo mhwd -a pci nonfree 0300'
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias ev='vim ~/.vimrc'
alias k='kill -9'

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
alias pbcopy='xclip -sel clip'
alias pbpaste='xclip -sel clip -o'

#Monta e desmonta a partição NTFS /dev/sda3
alias mount-ntfs='sudo ntfs-3g /dev/sda3 /mnt'
alias umount-ntfs='sudo umount /mnt'

#aliases para a saída de audio
alias hdmiaudion='sudo -u $USER pactl set-card-profile 0 output:hdmi-surround' # Ativa saída de audio HDMI
alias hdmiaudioff='sudo -u $USER pactl set-card-profile 0 output:analog-stereo+input:analog-stereo ' # Ativa saída de audio padrão
## Quando usar HDMI
alias hdmion='xrandr --output HDMI1 --auto --right-of LVDS1'

#Tmux
alias tmux='tmux -f ~/.tmux/tmux.conf'
alias tmuxl='tmux ls'
alias tmuxa='tmux attach -t'

#VPN
alias vpn='sudo openvpn ~/.openvpn/users.conf'

#Grava log do startx
alias startx='startx &> ~/.xlog'

# }}}
# Funções ---------------------------------------------------------- {{{

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
function gl() {
    if [ -f a.out ]; then rm -rf a.out
    fi
    if [ $1 == '-r'  ]; then
        g++ $2 -o a.out -lGLU -lGL -lglut && ./a.out
    else
        g++ $1 -o a.out -lGLU -lGL -lglut
    fi
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
# FIX    ----------------------------------------------------------- {{{

# FIX noglob nocorrect problem
function my_sudo {
    while [[ $# > 0 ]]; do
        case "$1" in
        command) shift ; break ;;
        nocorrect|noglob) shift ;;
        *) break ;;
        esac
    done
    if [[ $# = 0 ]]; then
        command sudo zsh
    else
        noglob command sudo $@
    fi
}

# }}}
