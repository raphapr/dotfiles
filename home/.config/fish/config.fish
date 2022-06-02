# fish shell config
# Raphael P. Ribeiro

# Preamble        ---------------------------------------------- {{{

# disable fish greeting message
set fish_greeting

# env vars
export TERM=screen-256color
export EDITOR="nvim"
export VIRTUALENV_PYTHON=/usr/bin/python2.7
export GOPATH="$HOME/go"
export BROWSER=firefox
export GPGKEY DBC876419930B2EB8447BFEFFA70B2729F47724C
export FZF_DEFAULT_OPTS="--height 50%"
export GEMDIR=(ruby -e 'print Gem.user_dir')
# aws-fuzzy
export AWS_FUZZ_PRIVATE_IP=false
export AWS_FUZZ_USE_CACHE=yes
export AWS_FUZZ_CACHE_EXPIRY=604800
export AWS_FUZZ_DNS_OVER_IP=true
export GPG_TTY=(tty)

# load sensible environment variables
source $HOME/.envsen

if test "$DISPLAY"
    xset r rate 240 30
end

if test -e $GOPATH/bin
    set PATH $PATH  $GOPATH/bin
end

if test -e /opt/julia/bin
    set PATH $PATH /opt/julia/bin
end

if test -e $GEMDIR/bin
    set PATH $PATH  $GEMDIR/bin
end

if test -e ~/.bin
    set PATH $PATH ~/.bin
end

if test -e ~/.local/bin
    set PATH $PATH ~/.local/bin
end

# awscli complete
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); ~/.local/bin/aws_completer | sed \'s/ $//\'; end)'

# kubectl krew
set -gx PATH $PATH $HOME/.krew/bin

# npm path setup
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set MANPATH $NPM_PACKAGES/share/man $MANPATH

# kitty autocomplete
kitty + complete setup fish | source

# autojump
if test -e /usr/share/autojump/autojump.fish
  source /usr/share/autojump/autojump.fish
end

#asdf
source /opt/asdf-vm/asdf.fish

 #}}}
# Bindings        ---------------------------------------------- {{{

# fish vi mode
# ctrl+f only accept autosuggestion
# ctrl+a switch AWS profile
# ctrl+q switch virtualenv
# ctrl+k switch k8s context
function fish_user_key_bindings
    fish_vi_key_bindings
    fzf_key_bindings
    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion
    bind -M insert \ca "aws-profile"
    bind \ca "aws-profile"
    bind -M insert \cq "vf-switch"
    bind \cq "vf-switch"
    bind -M insert \ck "kubectl ctx"
    bind \ck "kubectl ctx"
    bind -M insert \cn "kubectl ns"
    bind \cn "kubectl ns"
end

# }}}
# Plugins         ---------------------------------------------- {{{

# direnv
eval (direnv hook fish)

# }}}
# Aliases         ---------------------------------------------- {{{

# Shell aliases    {{{

alias lash 'ls -lash'
alias l 'ls -l'
alias vim 'nvim'
alias v 'nvim'
alias k 'kill -9'
alias r 'ranger'
alias desk 'cd ~/Desktop'
alias h 'history'
alias chromium 'chromium --disk-cache-dir /tmp/cache'
alias showbb 'cat /proc/acpi/bbswitch'
alias grubconf 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias automhwd 'sudo mhwd -r pci video-hybrid-intel-nvidia-bumblebee ; sudo mhwd -a pci nonfree 0300'
alias sof  'source ~/.config/fish/config.fish'
alias sb 'source ~/.bashrc'
alias et 'v ~/.tmux/tmux.conf'
alias ef 'v ~/.config/fish/config.fish'
alias eb 'v ~/.bashrc'
alias ev 'v ~/.config/nvim/init.vim'
alias i3c 'v ~/.i3/config'
alias xmerge 'xrdb -merge ~/.Xresources'
alias notes 'nvim ~/Cloud/notes/notes.txt'
# Ver diretórios com mais espaço em disco
alias topdir 'du -sh * | sort -nr | head -n10'
alias youtube-viewer 'youtube-viewer -C'
# ssh
alias lanc "ssh root@lancassolar -t 'tmux -q has-session -t 0 && tmux attach-session -d -t 0 || tmux -f ~/.tmux.conf new-session -s 0'"
# bash
alias ba "bash"
# git
alias g "git"
alias gpull "git pull origin (git rev-parse --abbrev-ref HEAD)"
alias gpush "git push origin (git rev-parse --abbrev-ref HEAD)"
alias gclean "git clean -fdx && git stash"
# diff dotfiles
alias ddiff "cd ~/.homesick/repos/dotfiles/home/ ; git diff . ; cd -"
# command line pastebin
alias pasteb "curl -F 'f:1=<-' ix.io"
# weather in terminal
alias weather "curl wttr.in/florianopolis"
#  ptpython
alias ptpython "python -m ptpython"
# '-' as shortcut to cd -
abbr -a -- - 'cd -'
# ripgrep
alias rg 'rg --smart-case'

# }}}
# translate-shell  {{{

alias gt 'trans :pt -b' # english to portuguese
alias gt-d 'trans -pager more -d' # dictionary
alias gt-en 'trans :en' # portuguese to english
alias gt-au 'trans :en -p -b' # pronuncia

# }}}
# pacman/pacaur    {{{

alias p 'sudo pacman'
alias pacup 'sudo pacman -Syuu'
alias pblock "sudo rm -rf /var/lib/pacman/db.lck"
alias pr 'pacaur'
alias prup 'pacaur -Syua' # Atualiza os repositorios do Arch + AUR
alias mirror-update 'sudo pacman-mirrors -g'

# }}}
# save_history     {{{

# history across fishes
function save_history --on-event fish_preexec
    history --save
end

alias hm 'history --merge'  # read and merge history from disk

bind \e\[A 'history --merge ; up-or-search'

# }}}
# youtube-dl       {{{

#Baixar videos do Youtube (requer youtube-dl)
alias utube 'youtube-dl -c'
#Baixar apenas o audio do video
alias atube 'youtube-dl --extract-audio --audio-format mp3 -t'

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
# curl-trace       {{{

alias curl-trace='curl -w "@$HOME/.curl-format" -o /dev/null -s'

# }}}
# aws-fuzzy        {{{

alias af='aws-fuzzy'
alias afnc='aws-fuzzy --no-cache'

# }}}
# gce-fuzzy        {{{

alias gf='gce-fuzzy -c 432000'
alias gfnc='gce-fuzzy -c 432000 -r'

# }}}
# kubectl          {{{

alias k kubectl
alias kk 'kubectl krew'
alias kaf 'k apply -f'
alias kdebug 'kubectl-debug'
# get
alias kg 'k get'
alias kgd 'k get deployment'
alias kgi 'k get ingress'
alias kgp 'k get po'
alias kgs 'k get svc'
alias kgc 'k get configmap'
alias kgsec 'k get secret'
# edit
alias ke 'k edit'
alias ked 'k edit deployment'
alias kei 'k edit ingress'
alias kep 'k edit po'
alias kes 'k edit svc'
alias kec 'k edit configmap'
alias kesec 'k edit secret'
# describe
alias kd 'k describe'
alias kdg 'k describe deployment'
alias kdi 'k describe ingress'
alias kdp 'k describe po'
alias kds 'k describe svc'
alias kdc 'k describe configmap'
alias kdsec 'k describe secret'
# exec
alias kexec 'k exec -it'

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
# wallc             {{{

# gist upload com xclip funcionando
function wallc
    cp $argv ~/.wallpaper.png ; feh --bg-fill ~/.wallpaper.png
end

# }}}
# wininfo           {{{
# info about open windows

# copyright 2007 - 2010 Christopher Bratusek
function wininfo
    xprop | grep -w "WM_NAME\|WM_CLASS\|WM_WINDOW_ROLE\|_NET_WM_STATE"
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
# ec2-find          {{{

function ec2-find
    aws ec2 describe-instances --query "Reservations[*].Instances[*].PrivateIpAddress" \
    --filters 'Name=tag:Name,Values=*'$argv'*' 'Name=instance-state-name,Values=running' \
    | jq .[][] | tr -d '"'
end

# }}}
# ec2-table         {{{

function ec2-table
   aws ec2 describe-instances \
       --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,InstanceId:InstanceId,InstanceType:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}"  \
       --filters 'Name=instance-state-name,Values=running' 'Name=tag:Name,Values=*'$argv'*' --output table
end

# }}}
# ec2-ssh           {{{

function ec2-ssh
    set -l region (aws configure get region --profile $AWS_PROFILE)
    set -l result (aws ec2 describe-instances --region $region --query "Reservations[*].Instances[*].PrivateIpAddress" \
    --filters 'Name=tag:Name,Values='"*$argv*"'' 'Name=instance-state-name,Values=running' \
    | jq .[][] | tr -d '"')
    if test (count $result) -eq 1
        echo "ssh $result"
        ssh $result
    end
    if test (count $result) -gt 1
        echo "xpanes -c 'ssh $SSH_OPTS '{}' $result"
        xpanes -c "ssh $SSH_OPTS {}" $result
    end
end

# }}}
# ec2-ssm           {{{

function ec2-ssm
    set -l region (aws configure get region --profile $AWS_PROFILE)
    set -l result (aws ec2 describe-instances --region $region --query "Reservations[*].Instances[*].InstanceId" \
    --filters 'Name=tag:Name,Values='"*$argv*"'' 'Name=instance-state-name,Values=running' \
    | jq .[][] | tr -d '"')
    if test (count $result) -eq 1
        echo "aws ssm start-session --region $region --profile $AWS_PROFILE --target $result"
        aws ssm start-session --region $region --profile $AWS_PROFILE --target $result
    end
    if test (count $result) -gt 1
        echo "xpanes -c 'aws ssm start-session --region $region --profile $AWS_PROFILE --target '{}' $result"
        xpanes -c "aws ssm start-session --region $region --profile $AWS_PROFILE --target {}" $result
    end
end

# }}}
# kps               {{{

function kps
    if [ $__kube_ps_enabled -eq 1 ]
      kube_ps off
      return
    end
    if [ $__kube_ps_enabled -eq 0 ]
      kube_ps on
      return
    end
    if [ -z "$__kube_ps_enabled" ]
      kube_ps on
    end
end

# }}}
# sshagent          {{{

function __ssh_agent_is_started -d "check if ssh agent is already started"
   if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
      source $SSH_ENV > /dev/null
   end

   if test -z "$SSH_AGENT_PID"
      return 1
   end

   ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
   #pgrep ssh-agent
   return $status
end


function __ssh_agent_start -d "start a new ssh agent"
   ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
   chmod 600 $SSH_ENV
   source $SSH_ENV > /dev/null
   true  # suppress errors from setenv, i.e. set -gx
end

function sshagent --description "Start ssh-agent if not started yet, or uses already started ssh-agent."
   if test -z "$SSH_ENV"
      set -xg SSH_ENV $HOME/.ssh/environment
   end

   if not __ssh_agent_is_started
      __ssh_agent_start
   end
end

# }}}

# }}}
# FZF functions   ---------------------------------------------- {{{

# aws-profile       {{{

function aws-profile
    export AWS_PROFILE=(grep "^\[.*]" ~/.aws/config | tr -d "[]" | sed 's/profile.//g' | fzf --height 20% +m)
    commandline -f repaint
end

# }}}
# vf-switch         {{{

function vf-switch
    set -lx FZF_DEFAULT_OPTS "--height 20% +m"
    vf activate (vf ls | fzf)
    commandline -f repaint
end

# }}}
# fco               {{{

function fco -d "Fuzzy-find and checkout a branch"
    set -lx FZF_DEFAULT_OPTS "--height 40% +m"
    git branch --all | grep -v HEAD | string trim | fzf |  xargs git checkout
    commandline -f repaint
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
