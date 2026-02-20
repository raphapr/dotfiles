# Preamble        ---------------------------------------------- {{{

# disable fish greeting message
set fish_greeting

set -gx SHELL fish
set -gx EDITOR nvim
set -gx GOPATH $HOME/go
set -gx GOBIN $HOME/go/bin
set -gx BROWSER firefox
set -gx GPGKEY DBC876419930B2EB8447BFEFFA70B2729F47724C
set -gx FZF_DEFAULT_OPTS "--height 50%"
set -gx ZK_NOTEBOOK_DIR $HOME/Cloud/Sync/notebook
set -gx GPG_TTY (tty)

# Locale settings
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# load sensistive environment variables
source $HOME/.env_files/personal

if status is-interactive; and test -n "$DISPLAY"
    ~/.bin/set-keyboard-repeat
end

# PATH setup (using fish_add_path for idempotent, deduplicated paths)
fish_add_path $GOPATH/bin
fish_add_path ~/.local/bin
fish_add_path ~/.bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.krew/bin
fish_add_path ~/.opencode/bin

# npm
set -gx NPM_PACKAGES $HOME/.npm-packages
fish_add_path $NPM_PACKAGES/bin
set -gx MANPATH $NPM_PACKAGES/share/man $MANPATH

# bun
set -gx BUN_INSTALL $HOME/.bun
fish_add_path $BUN_INSTALL/bin

# pnpm
fish_add_path ~/.local/share/pnpm/bin

# awscli shell completion
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); ~/.local/bin/aws_completer | sed \'s/ $//\'; end)'

# 1password shell completion
op completion fish | source

 #}}}
# Bindings        ---------------------------------------------- {{{

function fish_user_key_bindings
    fzf_key_bindings
    fish_vi_key_bindings

    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion

    bind -M insert \ca "aws-profile"
    bind \ca "aws-profile"

    bind -M insert \cx "kubectl ctx; commandline -f repaint"
    bind \cx "kubectl ctx"

    bind -M insert \cn "kubectl ns; commandline -f repaint"
    bind \cn "kubectl ns"

    bind \cr _atuin_search
    bind -M insert \cr _atuin_search

    bind -M insert \cj history-search-forward
    bind \cj history-search-forward

    bind -M insert \ck history-search-backward
    bind \ck history-search-backward
end

# }}}
# Plugins         ---------------------------------------------- {{{


set -gx ATUIN_NOBIND true
direnv hook fish | source
mise activate fish | source
starship init fish | source
zoxide init fish | source
fzf --fish | source

if status is-interactive
    atuin init fish | source
end

# }}}
# Aliases         ---------------------------------------------- {{{

# misc             {{{

alias lash 'eza -l'
alias l 'eza'
alias lt 'eza -T --icons'
alias K 'kill -9'
abbr -a v nvim
abbr -a vim nvim
alias vcd 'nvim -c "lua require\'telescope\'.extensions.zoxide.list{}"'
alias ot 'otter-launcher'
alias oc 'opencode --agent OpenCoder --port'
# edit
alias sof  'source ~/.config/fish/config.fish'
alias sb 'source ~/.bashrc'
alias et 'nvim ~/.tmux/tmux.conf'
alias ef 'nvim ~/.config/fish/config.fish'
alias eb 'nvim ~/.bashrc'
alias ev 'nvim +"cd ~/.config/nvim/lua/raphapr" ~/.config/nvim/lua/raphapr/init.lua'
alias i3c 'nvim ~/.i3/config'
alias httpf 'nvim +"cd ~/Cloud/Sync/code/http-files" +":Telescope find_files"'
alias xmerge 'xrdb -merge ~/.Xresources'
# notes
alias notes 'nvim +"cd ~/Cloud/Sync/notebook" +":ZkTags"'
alias daily 'zk daily'
alias tomorrow 'zk tomorrow'
alias weekly 'zk weekly'
alias backlog 'nvim ~/Cloud/Sync/notebook/backlog.md'
# git
abbr -a g git
abbr -a gpull 'git pull origin (git rev-parse --abbrev-ref HEAD)'
abbr -a gpush 'git push origin (git rev-parse --abbrev-ref HEAD)'
alias gclean "git clean -fdx && git stash"
alias gco "git checkout (git branch | fzf | tr -d [:space:])"
alias gwip 'git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit -m "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
#  ptpython
alias ptpython "python -m ptpython"
# '-' as shortcut to cd -
abbr -a -- - 'cd -'
# ripgrep
alias rg 'rg --smart-case'
# chezmoi
abbr -a cz chezmoi
abbr -a cdiff 'chezmoi diff'

# }}}
# pacman           {{{

alias p 'sudo pacman'
alias pacup 'sudo pacman -Syuu'
alias punlock "sudo rm -rf /var/lib/pacman/db.lck"
alias mirrors-update 'sudo pacman-mirrors -g'

# }}}
# save_history     {{{

# sync history across fish sessions
function save_history --on-event fish_preexec
    history --save
end

alias hm 'history --merge'  # read and merge history from disk

# }}}
# tmux             {{{

abbr -a t tmux
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
alias kg 'k get'
alias ke 'k edit'
alias kd 'k describe'
alias kaf 'k apply -f'
alias kexec 'k exec -it'
alias kdebug 'kubectl-debug'

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
    set -l wallpaper ~/.wallpaper.png
    if test (count $argv) -eq 0
        feh --bg-fill $wallpaper
    else
        set -l img $argv[1]
        if not test -f $img
            echo "File not found: $img"
            return 1
        end
        if not test $img = $wallpaper
            cp $img $wallpaper
        end
        feh --bg-fill $wallpaper
    end
end

# }}}
# wininfo           {{{
# get info about open windows

# copyright 2007 - 2010 Christopher Bratusek
function wininfo
    xprop | grep -w "WM_NAME\|WM_CLASS\|WM_WINDOW_ROLE\|_NET_WM_STATE"
end

# }}}
# Systemd Shortcuts {{{

# Helper function for systemd commands
# Usage: __systemctl <system|user> <action> [service_name]
function __systemctl
    set -l scope $argv[1]
    set -l action $argv[2]
    set -l target $argv[3]

    set -l cmd
    set -l sudo_cmd

    if test "$scope" = "user"
        set cmd systemctl --user
    else
        set cmd systemctl
        # Actions that need sudo for system services
        if contains $action start stop restart enable disable reload
            set sudo_cmd sudo
        end
    end

    switch $action
        case start stop restart enable disable reload
            if test -n "$sudo_cmd"
                $sudo_cmd $cmd $action $target.service
            else
                $cmd $action $target.service
            end
        case status
            $cmd status $target.service
        case list
            $cmd
        case failed
            $cmd --failed
        case list-files
            $cmd list-unit-files
        case log
            if test "$scope" = "user"
                journalctl --user
            else
                sudo journalctl
            end
        case wants
            $cmd show -p "Wants" $target.target
        case analyze
            systemd-analyze $target
    end
end

# System service shortcuts (0.*)
function 0.start;      __systemctl system start $argv; end
function 0.restart;    __systemctl system restart $argv; end
function 0.stop;       __systemctl system stop $argv; end
function 0.enable;     __systemctl system enable $argv; end
function 0.disable;    __systemctl system disable $argv; end
function 0.status;     __systemctl system status $argv; end
function 0.reload;     __systemctl system reload $argv; end
function 0.list;       __systemctl system list; end
function 0.failed;     __systemctl system failed; end
function 0.list-files; __systemctl system list-files; end
function 0.log;        __systemctl system log; end
function 0.wants;      __systemctl system wants $argv; end
function 0.analyze;    __systemctl system analyze $argv; end

# User service shortcuts (1.*)
function 1.start;      __systemctl user start $argv; end
function 1.restart;    __systemctl user restart $argv; end
function 1.stop;       __systemctl user stop $argv; end
function 1.enable;     __systemctl user enable $argv; end
function 1.disable;    __systemctl user disable $argv; end
function 1.status;     __systemctl user status $argv; end
function 1.reload;     __systemctl user reload $argv; end
function 1.list;       __systemctl user list; end
function 1.failed;     __systemctl user failed; end
function 1.list-files; __systemctl user list-files; end
function 1.log;        __systemctl user log; end
function 1.wants;      __systemctl user wants $argv; end

# }}}
# su                {{{

function su
        /bin/su --shell=/usr/bin/fish $argv
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
# loadenv           {{{
# copied from https://github.com/berk-karaal/loadenv.fish

function loadenv
    argparse h/help print printb U/unload -- $argv
    or return 1

    if set -q _flag_help
        echo "Usage: loadenv [OPTIONS] [FILE]"
        echo ""
        echo "Export keys and values from a dotenv file."
        echo ""
        echo "Options:"
        echo "  --help, -h      Show this help message"
        echo "  --print         Print env keys (export preview)"
        echo "  --printb        Print keys with surrounding brackets"
        echo "  --unload, -U    Unexport all keys defined in the dotenv file"
        echo ""
        echo "Arguments:"
        echo "  FILE            Path to dotenv file (default: .env)"
        return 0
    end

    if test (count $argv) -gt 1
        echo "Too many arguments. Only one argument is allowed. Use --help for more information."
        return 1
    end

    set -l dotenv_file ".env"
    if test (count $argv) -eq 1
        set dotenv_file $argv[1]
    end

    if not test -f $dotenv_file
        echo "Error: File '$dotenv_file' not found in the current directory."
        return 1
    end

    set -l mode load
    if set -q _flag_print
        set mode print
    else if set -q _flag_printb
        set mode printb
    else if set -q _flag_unload
        set mode unload
    end

    set lineNumber 0

    for line in (cat $dotenv_file)
        set lineNumber (math $lineNumber + 1)

        # Skip empty lines and comment lines
        if string match -qr '^\s*$|^\s*#' $line
            continue
        end

        if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*=' $line
            echo "Error: invalid declaration (line $lineNumber): $line"
            return 1
        end

        # Parse key and value
        set -l key (string split -m 1 '=' $line)[1]
        set -l after_equals_sign (string split -m 1 '=' $line)[2]

        set -l value
        set -l double_quoted_value_regex '^"(.*)"\s*(?:#.*)*$'
        set -l single_quoted_value_regex '^\'(.*)\'\s*(?:#.*)*$'
        set -l plain_value_regex '^([^\'"\s]*)\s*(?:#.*)*$'
        if string match -qgr $double_quoted_value_regex $after_equals_sign
            set value (string match -gr $double_quoted_value_regex $after_equals_sign)
        else if string match -qgr $single_quoted_value_regex $after_equals_sign
            set value (string match -gr $single_quoted_value_regex $after_equals_sign)
        else if string match -qgr $plain_value_regex $after_equals_sign
            set value (string match -gr $plain_value_regex $after_equals_sign)
        else
            echo "Error: invalid value (line $lineNumber): $line"
            return 1
        end

        switch $mode
            case print
                echo "$key=$value"
            case printb
                echo "[$key=$value]"
            case load
                set -gx $key $value
            case unload
                set -e $key
        end
    end

end

# }}}
# kubernetes prompt {{{

function kp
    if ! set -q KUBE_PROMPT_ENABLED
        export KUBE_PROMPT_ENABLED
    else
        set -e KUBE_PROMPT_ENABLED
    end
end

# }}}
# yazi              {{{

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# }}}
# opsignin          {{{

function opsignin
  eval "$(op signin)"
end

# }}}

# }}}
