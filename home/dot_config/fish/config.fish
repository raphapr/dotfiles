# fish shell config
# Raphael P. Ribeiro

# Preamble        ---------------------------------------------- {{{

# disable fish greeting message
set fish_greeting

export SHELL="fish"
export EDITOR="nvim"
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export BROWSER=firefox
export GPGKEY DBC876419930B2EB8447BFEFFA70B2729F47724C
export FZF_DEFAULT_OPTS="--height 50%"
export GPG_TTY=(tty)

# load sensistive environment variables
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

if test -e ~/.local/bin
    set PATH $PATH ~/.local/bin
end

if test -e ~/.bin
    set PATH $PATH ~/.bin
end

if test -e ~/.cargo/bin
    set PATH $PATH ~/.cargo/bin
end

# awscli complete
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); ~/.local/bin/aws_completer | sed \'s/ $//\'; end)'

# kubectl krew
set -gx PATH $PATH $HOME/.krew/bin

# npm path setup
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set MANPATH $NPM_PACKAGES/share/man $MANPATH

# mise
mise activate fish | source

# startship prompt
starship init fish | source

 #}}}
# Bindings        ---------------------------------------------- {{{

# fish vi mode
# ctrl+f only accept autosuggestion
# ctrl+a switch AWS profile
# ctrl+k switch k8s context
# ctrl+n switch k8s namespace
# ctrl+u open session via tmux sessionizer
# ctrl+o switch sessions via tmux sessionizer

function fish_user_key_bindings
    fzf_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion
    bind -M insert \ca "aws-profile"
    bind \ca "aws-profile"
    bind -M insert \ck "kubectl ctx; commandline -f repaint"
    bind \ck "kubectl ctx"
    bind -M insert \cn "kubectl ns; commandline -f repaint"
    bind \cn "kubectl ns"
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
end

# }}}
# Plugins         ---------------------------------------------- {{{

# direnv
eval (direnv hook fish)

# }}}
# Aliases         ---------------------------------------------- {{{

# shell aliases    {{{

alias lash 'eza -l'
alias l 'eza'
alias lt 'eza -T --icons'
alias k 'kill -9'
alias y 'yazi'
alias v 'nvim'
alias vim 'nvim'
alias vcd 'nvim -c "lua require\'telescope\'.extensions.zoxide.list{}"'
# edit
alias sof  'source ~/.config/fish/config.fish'
alias sb 'source ~/.bashrc'
alias et 'v ~/.tmux/tmux.conf'
alias ef 'v ~/.config/fish/config.fish'
alias eb 'v ~/.bashrc'
alias ev 'v +"cd ~/.config/nvim/lua/raphapr" ~/.config/nvim/lua/raphapr/init.lua'
alias eo 'v +"cd ~/Cloud/Vaults/Raphakasten" +":NvimTreeToggle"'
alias i3c 'v ~/.i3/config'
alias xmerge 'xrdb -merge ~/.Xresources'
# git
alias g "git"
alias gpull "git pull origin (git rev-parse --abbrev-ref HEAD)"
alias gpush "git push origin (git rev-parse --abbrev-ref HEAD)"
alias gclean "git clean -fdx && git stash"
alias gco "git checkout (git branch | fzf | tr -d [:space:])"
alias gwip 'git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit -m "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
# diff dotfiles
alias cdiff "chezmoi diff"
# command line pastebin
alias pasteb "curl -F 'f:1=<-' ix.io"
# weather in terminal
alias weather "curl wttr.in/saopaulo"
#  ptpython
alias ptpython "python -m ptpython"
# '-' as shortcut to cd -
abbr -a -- - 'cd -'
# ripgrep
alias rg 'rg --smart-case'
# chezmoi
alias cz 'chezmoi'

# }}}
# pacman           {{{

alias p 'sudo pacman'
alias pacup 'sudo pacman -Syuu'
alias pblock "sudo rm -rf /var/lib/pacman/db.lck"
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
# xclip            {{{

alias pbcopy 'xclip -sel clip'
alias pbpaste 'xclip -sel clip -o'

# }}}
# tmux             {{{

alias t 'tmux'
alias tmux 'tmux -f ~/.tmux/tmux.conf'
alias ts 'tmux source ~/.tmux/tmux.conf'
alias ta 'tmux attach -t'
alias tk 'tmux kill-session -t'

# }}}
# curl-trace       {{{

alias curl-trace='curl -w "@$HOME/.curl-format" -o /dev/null -s'

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

# copy              {{{

# copy file content
function copy
   xclip -sel clip < $argv
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
# aws-profile       {{{

function aws-profile
    export AWS_PROFILE=(grep "^\[.*]" ~/.aws/config | tr -d "[]" | sed 's/profile.//g' | fzf --height 20% +m)
    commandline -f repaint
end

# }}}
# repo-clone       {{{

function repo-clone
    gh repo clone $argv ~/repos/(ls ~/repos | fzf)/(echo $argv | cut -d '/' -f 2)
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
# zoxide          ---------------------------------------------- {{{

zoxide init fish | source

# }}}
# atuin           ---------------------------------------------- {{{

set -gx ATUIN_NOBIND "true"

if status is-interactive
    atuin init fish | source
end

# }}}
