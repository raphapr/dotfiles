# fish shell config
# Raphael P. Ribeiro

# Preambulo       ---------------------------------------------- {{{

# Disable the welcome text
set --erase fish_greeting

if test "$DISPLAY"
    xset r rate 200 30
end

# }}}
# Aliases         ---------------------------------------------- {{{

# Shell aliases    {{{

alias lash 'ls -lash'
alias l 'ls -CF'
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
alias ev 'v ~/.nvimrc'
alias i3c 'v ~/.i3/config'
alias transm 'transmission-remote-cli'
alias xmerge 'xrdb -merge ~/.Xresources'
alias repos 'cd ~/Copy/repos'
alias miniman 'zathura ~/Copy/cheats/miniman.pdf'
alias cheatsh 'zathura ~/Copy/cheats/canivete-shell.pdf'
alias cheatsed 'cat ~/Copy/cheats/sed | more'
alias zz 'fasd'
#VPN
alias vpnlccv 'cd ~/.vpn/lccv ; sudo openvpn --config ~/.vpn/lccv/pfsense-udp-1194.ovpn'
alias vpn 'cd ~/.vpn/lancassolar ; sudo openvpn --config ~/.vpn/lancassolar/client.conf'
# urserver
alias urserver '/opt/urserver/urserver --daemon'
# Ver diretórios com mais espaço em disco 
alias topdir 'du -sh * | sort -nr | head -n10'
alias guake 'guake -e ~/.startupGuake.sh'
alias youtube-viewer 'youtube-viewer -C'

# }}}
# translate-shell  {{{

alias gte 'trans -b :en' # portuguese to english
alias gtb 'trans -b' # english to portuguese
alias gtp 'trans :en -p -b' # pronuncia

# }}}
# Pacman/Yaourt    {{{

alias p 'sudo pacman'
alias pacup 'sudo pacman -Syuu'
alias pblock "sudo rm -rf /var/lib/pacman/db.lck"
alias y 'yaourt'
alias yup 'yaourt -Syua' # Atualiza os repositorios do Arch + AUR
alias mirror-update 'sudo pacman-mirrors -g'

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

alias tmux 'tmux -f ~/.tmux/tmux.conf'
alias t 'tmux -f ~/.tmux/tmux.conf'
alias ta 'tmux attach -t'
alias tk 'tmux kill-session -t'

# }}}
# git              {{{

alias g 'git'
alias gt 'git status'
alias gd 'git diff'
alias gp 'git push origin master'
alias gl 'git log'

# }}}

# }}}
# Functions       ---------------------------------------------- {{{

# copy           {{{

# copy file content
function copy
   xclip -sel clip < $argv
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

function -e fish_preexec _run_fasd
     fasd --proc (fasd --sanitize $argv) > /dev/null 2>&1
end

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
