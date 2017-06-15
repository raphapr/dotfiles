# fish shell config
# Raphael P. Ribeiro

# Preambulo       ---------------------------------------------- {{{

# Disable the welcome text
set --erase fish_greeting

if test "$DISPLAY"
    xset r rate 200 30
end

if test -e /opt/julia/bin
    set PATH $PATH /opt/julia/bin
end

if test -e ~/.gem/ruby/2.4.0/bin
    set PATH $PATH  ~/.gem/ruby/2.4.0/bin
end

# Env variables
set -x PATH $PATH ~/.local/bin ~/.bin
set -x BROWSER firefox
set -x GPGKEY DBC876419930B2EB8447BFEFFA70B2729F47724C

# aws complete
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); ~/.local/bin/aws_completer | sed \'s/ $//\'; end)'

# fish vi mode
# ctrl+f only accept autosuggestion
function fish_user_key_bindings
    fish_vi_key_bindings
    fzf_key_bindings
    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion
end

# virtualfish settings
eval (python -m virtualfish)

# }}}
# Aliases         ---------------------------------------------- {{{

# Shell aliases    {{{

alias lash 'ls -lash'
alias l 'ls -l'
alias vim 'nvim'
alias v 'nvim'
alias nv 'nvim'
alias k 'kill -9'
alias r 'ranger'
alias desk 'cd ~/Desktop'
alias iup 'imgurbash'
alias h 'history'
alias hm 'history --merge'
alias chromium 'chromium --disk-cache-dir /tmp/cache'
alias showbb 'cat /proc/acpi/bbswitch'
alias grubconf 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias automhwd 'sudo mhwd -r pci video-hybrid-intel-nvidia-bumblebee ; sudo mhwd -a pci nonfree 0300'
alias sof  'source ~/.config/fish/config.fish'
alias sb 'source ~/.bashrc'
alias ef 'v ~/.config/fish/config.fish'
alias eb 'v ~/.bashrc'
alias ev 'v ~/.config/nvim/init.vim'
alias i3c 'v ~/.i3/config'
alias transm 'transmission-remote-cli -c raphael:(cat ~/.passwdlist | head -n1)@localhost'
alias transmr 'transmission-remote-cli -c raphael:(cat ~/.passwdlist | tail -n1)@lancassolar'
alias xmerge 'xrdb -merge ~/.Xresources'
alias miniman 'zathura ~/Cloud/cheats/miniman.pdf'
alias cheatsh 'zathura ~/Cloud/cheats/canivete-shell.pdf'
alias cheatsed 'cat ~/Cloud/cheats/sed | more'
alias zz 'fasd'
alias notes 'nvim ~/Cloud/notes/notes.txt'
# urserver
alias urserver '/opt/urserver/urserver --daemon'
# Ver diretórios com mais espaço em disco 
alias topdir 'du -sh * | sort -nr | head -n10'
alias guake 'guake -e ~/.startupGuake.sh'
alias youtube-viewer 'youtube-viewer -C'
# connman
alias wcon 'connmanctl connect wifi_e006e6dd924b_56616c66656e6461_managed_psk'
alias wdis 'connmanctl disconnect wifi_e006e6dd924b_56616c66656e6461_managed_psk'
# ssh
alias lanc "ssh root@lancassolar -t 'tmux -q has-session -t 0 && tmux attach-session -d -t 0 || tmux -f ~/.tmux.conf new-session -s 0'"
alias prismo "ssh root@prismo -t 'tmux -q has-session -t 0 && tmux attach-session -d -t 0 || tmux -f ~/.tmux.conf new-session -s 0'"
# bash
alias b "bash"
# gcalcli
alias gcal "gcalcli agenda ; gcalcli calw 2"
# diff dotfiles
alias ddiff "cd ~/.homesick/repos/dotfiles/home/ ; git diff . ; cd -"
# gams
alias gams "/media/hdd/Software/gams24.6/gams"
# command line pastebin
alias pasteb "curl -F 'f:1=<-' ix.io"
# weather in terminal
alias weather "curl wttr.in/maceio"
# googler
alias go "googler"
# buku
alias bk "buku"
# jenkins
alias jenkins "java -jar .jekins-cli.jar -s http://jenkins.stant.com.br"

# }}}
# translate-shell  {{{

alias gt 'trans :pt -b' # english to portuguese
alias gt-d 'trans -pager more -d' # dictionary
alias gt-en 'trans :en' # portuguese to english
alias gt-au 'trans -p -b' # pronuncia

# }}}
# Pacman/Yaourt    {{{

alias p 'sudo pacman'
alias pacup 'sudo pacman -Syuu'
alias pblock "sudo rm -rf /var/lib/pacman/db.lck"
alias y 'yaourt'
alias yup 'yaourt -Syua' # Atualiza os repositorios do Arch + AUR
alias mirror-update 'sudo pacman-mirrors -g'

# }}}
# DNF              {{{

alias d 'sudo dnf'
alias di 'sudo dnf install'
alias dr 'sudo dnf remove'
alias ds 'sudo dnf search'
alias dli 'sudo dnf list installed'
alias dla 'sudo dnf list available'

# }}}
# youtube-dl       {{{

#Baixar videos do Youtube (requer youtube-dl)
alias utube 'youtube-dl -c'
#Baixar apenas o audio do video
alias atube 'youtube-dl --extract-audio --audio-format mp3 -t'

# }}}
# Pings            {{{

alias google 'ping -i 3 www.google.com'
alias globo 'ping -i 3 www.globo.com'
alias yahoo 'ping -i 3 www.yahoo.com'

# }}}
# connman          {{{

alias c "connmanctl"
alias wfscan "connmanctl services"
alias wfcon "connmanctl connect"

# }}}
# xclip            {{{

#comando para copiar/colar via terminal para a área de transferência
alias pbcopy 'xclip -sel clip'
alias pbpaste 'xclip -sel clip -o'

# }}}
# ntfs             {{{

# Monta e desmonta a partição NTFS /dev/sda3
alias mount-ntfs 'sudo ntfs-3g /dev/sda3 /mnt'
alias umount-ntfs 'sudo umount /mnt'

# }}}
# tmux             {{{

alias t 'tmux'
alias tmux 'tmux -f ~/.tmux/tmux.conf'
alias ta 'tmux attach -t'
alias tk 'tmux kill-session -t'

# }}}
# git              {{{

alias g 'git'
alias gst 'git status'
alias gd 'git diff'
alias gp 'git push origin master'
alias gl 'git log'
alias gc 'git checkout'

# }}}
# docker           {{{

alias dc 'docker-compose'
alias dockerm 'docker rm -f (docker ps -a -q)'

# }}}
# azure            {{{

alias az 'azure'

function azset
    switch $argv
    case rac
        azure account set 2e0a89dc-7233-44fa-a214-649a52b6bbfd
    case ral
        azure account set c71119be-a373-4b00-a319-0c22a5cb003c
    case men
        azure account set 8d9f4e6b-ba1c-4992-86d3-cd0b11c38f04
    case rod
        azure account set 16f898a3-c2eb-4a4e-87d0-05b8c11554b0
    case ls
        echo "\
        rac:    2e0a89dc-7233-44fa-a214-649a52b6bbfd
        ral:    c71119be-a373-4b00-a319-0c22a5cb003c
        men:    8d9f4e6b-ba1c-4992-86d3-cd0b11c38f04
        rod:    16f898a3-c2eb-4a4e-87d0-05b8c11554b0"
    case '*'
        echo "This command doesn't exists."
    end
end

# }}}

# }}}
# Functions       ---------------------------------------------- {{{

# dexec             {{{

function dexec
   docker exec -it $argv bash
end

# }}}
# copy              {{{

# copy file content
function copy
   xclip -sel clip < $argv
end

# }}}
# tube              {{{

# assistir algum video do youtube pelo smplayer
function tube
     command smplayer "$argv" &
end

# }}}
# browser           {{{

# gist upload com xclip funcionando
function browser
    /usr/bin/xdg-open $argv
end

# }}}
# tarc              {{{

function tarc
    tar zxvf $argv.tar.gz -C $argv
end

# }}}
# ag                {{{

function ag
    command ag --smart-case $argv
end

# }}}
# f                 {{{

function f
    find . | ag $argv
end

# }}}
# wallchange        {{{

# gist upload com xclip funcionando
function wallc
    cp $argv ~/.wallpaper.png ; feh --bg-fill ~/.wallpaper.png
end

# }}}
# gistt             {{{

# gist upload com xclip funcionando
function gistt
    gist $argv | pbcopy ; pbpaste ; browser (pbpaste)
end

# }}}
# ys                {{{

# yaourt sem confirmação
function ys
    yaourt -S $argv --noconfirm
end

# }}}
# aux               {{{

# lista os detalhes de um determinado padrão de processos
function aux
    ps aux | grep  $argv
end

# }}}
# wininfo           {{{
# info about open windows

# copyright 2007 - 2010 Christopher Bratusek
function wininfo
    xprop | grep -w "WM_NAME\|WM_CLASS\|WM_WINDOW_ROLE\|_NET_WM_STATE"
end

# }}}
# gl                {{{

# compilando com OpenGL
function cgl
    if test a.out
        rm -rf a.out
    end
    g++ $argv -o a.out -lGLU -lGL -lglut ; ./a.out
end

# }}}
# cd                {{{

function cd
    # Added a record to fasd
    if [ -d $argv ]
        fasd -A $argv
    end

    # Skip history in subshells
    if status --is-command-substitution
        builtin cd $argv
        return $status
    end

    # Avoid set completions
    set -l previous $PWD

    if test $argv[1] = - ^/dev/null
        if test "$__fish_cd_direction" = next ^/dev/null
            nextd
        else
            prevd
        end
        return $status
    end

    builtin cd $argv[1]
    set -l cd_status $status

    if test $cd_status = 0 -a "$PWD" != "$previous"
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    return $cd_status
end

# }}}
# fzf               {{{

# == fzf-cd-fasd     {{{

function fzf-cd-fasd
    fasd -dl | fzf --no-sort --tac > /tmp/fzf; and cd (cat /tmp/fzf)
end

# }}}
# == fzf-cd-home     {{{

function fzf-cd-home
    find ~/* -path '*/\.*' -prune -o -type d -print ^/dev/null | \
        fzf --no-sort --tac > /tmp/fzf; and cd (cat /tmp/fzf)
end

# }}}
# == fzf-cd-subtree  {{{

function fzf-cd-subtree
    find * -path '*/\.*' -prune -o -type d -print ^/dev/null | \
        fzf --no-sort --tac > /tmp/fzf; and cd (cat /tmp/fzf)
end

# }}}
# == fzf-history     {{{

function fzf-history
    history | fzf > /tmp/fzf; and commandline (cat /tmp/fzf)
end

# }}}
# == fzf-vim-fasd    {{{

function fzf-vim-fasd
    fasd -fl | fzf --no-sort --tac > /tmp/fzf; and v (cat /tmp/fzf)
end

# }}}
# == fzf-vim-subtree {{{

function fzf-vim-subtree
    find * -path '*/\.*' -prune -o -type f -print ^/dev/null | \
        fzf --no-sort --tac > /tmp/fzf; and v (cat /tmp/fzf)
end

# }}}

# }}}
# fasd              {{{

function z
    set -l dir (fasd -de "printf %s" "$argv")
    if test "$dir" = ""
        echo "no matching directory"
        return 1
    end
    cd $dir
end

function e
    fasd -fe vim "$argv"
end

# }}}
# vz                {{{

function vz
    fasd -fe vim $argv
end

# }}}
# take              {{{

function take
    mkdir -p $argv
    cd $argv
end

# }}}
# Systemd Shortcuts {{{

function 0.start
    sudo systemctl start $argv.service
end
# restart systemd service
function 0.restart
    sudo systemctl restart $argv.service
end
# stop systemd service
function 0.stop
    sudo systemctl stop $argv.service
end
# enable systemd service
function 0.enable
    sudo systemctl enable $argv.service
end
# disable a systemd service
function 0.disable
    sudo systemctl disable $argv.service
end
# show the status of a service
function 0.status
    systemctl status $argv.service
end
# reload a service configuration
function 0.reload
    sudo systemctl reload $argv.service
end
# list all running service
function 0.list
    systemctl
end
# list all failed service
function 0.failed 
    systemctl --failed
end
# list all systemd available unit files
function 0.list-files
    systemctl list-unit-files
end
# check the log
function 0.log
    sudo journalctl
end
# show wants
function 0.wants
    systemctl show -p "Wants" $argv.target
end
# analyze the system
function 0.analyze
    systemd-analyze $argv
end

# }}}
# Systemd --user    {{{

function 1.start
    systemctl --user start $argv.service
end
# restart systemd service
function 1.restart
    systemctl --user restart $argv.service
end
# stop systemd service
function 1.stop
    systemctl --user stop $argv.service
end
# enable systemd service
function 1.enable
    systemctl --user enable $argv.service
end
# disable a systemd service
function 1.disable
    systemctl --user disable $argv.service
end
# show the status of a service
function 1.status
    systemctl --user status $argv.service
end
# reload a service configuration
function 1.reload
    systemctl --user reload $argv.service
end
# list all running service
function 1.list
    systemctl --user
end
# list all failed service
function 1.failed 
    systemctl --user --failed
end
# list all systemd available unit files
function 1.list-files
    systemctl --user list-unit-files
end
# check the log
function 1.log
    journalctl --user
end
# show wants
function 1.wants
    systemctl --user show -p "Wants" $argv.target
end

# }}}
# su                {{{

function su
        /bin/su --shell=/usr/bin/fish $argv
end

# }}}
# fish vi mode      {{{

function fish_mode_prompt --description 'Displays the current mode'
                        # Do nothing if not in vi mode
                        if test "$fish_key_bindings" = "fish_vi_key_bindings"
                            switch $fish_bind_mode
                                case default
                                    set_color --bold --background red white
                                    echo " N "
                                case insert
                                    set_color --bold --background green white
                                    echo " I "
                                case replace-one
                                    set_color --bold --background cyan white
                                    echo " R "
                                case visual
                                    set_color --bold --background magenta white
                                    echo " V "
                            end
                            set_color normal
                            printf " "
                        end
end

# }}}
# EC2 variables     {{{

function ec2var
    if count $argv > /dev/null
        if test -e ~/.ec2_vars/"$argv[1]"
            source ~/.ec2_vars/"$argv[1]"
            echo ":: EC2 vars $argv[1] loaded"
        else
            echo ":: This option doesn't exists"
        end
    else
        echo "No arguments provided! Options:" (ls ~/.ec2_vars/)
    end
end

# }}}
# VPN

function vpn
    switch $argv
    case fln
        sudo pon cfln
    case neemu
        cd ~/.vpn/c.neemu ; sudo openvpn --config ~/.vpn/c.neemu/raphael.ribeiro.ovpn --script-security 2 --up /etc/openvpn/update-resolv-conf.sh --down /etc/openvpn/update-resolv-conf.sh
    case '*'
        echo "This command doesn't exists."
    end
end

# }}}
# history subst   ---------------------------------------------- {{{
#
# Syntax:
# To just rerun your last command, simply type '!!'
# '!! sudo' will prepend sudo to your most recent command
# Running !! with anything other than sudo will append the argument to your most recent command
# To add another command to prepend list remove the # on line 10 and put the command in the quotes. Repeat as needed
function !!;
  set var (history | head -n 1)
  if test $argv
    if test $argv = "sudo"        #; or "any other command you want to prepend"
        eval $argv $var
    else
        eval $var $argv
    end
    else
        eval $var
  end
end

# }}}
