#!/bin/bash

# script de inicialização após execução do guake
# Entra em sessão tmux

if [[ -n $(tmux -f ~/.tmux/tmux.conf ls | grep guake) ]]; then # existe guake session?
    /usr/bin/tmux attach -t guake
else # não existe guake session
    tmux -f ~/.tmux/tmux.conf new-session -s guake
fi
