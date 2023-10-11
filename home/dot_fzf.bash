# Setup fzf
# ---------
if [[ ! "$PATH" == */home/raphael/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/raphael/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/raphael/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/raphael/.fzf/shell/key-bindings.bash"
