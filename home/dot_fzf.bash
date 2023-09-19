# Setup fzf
# ---------
if [[ ! "$PATH" == */home/raphael/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/raphael/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/raphael/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/raphael/.fzf/shell/key-bindings.bash"
