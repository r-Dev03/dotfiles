if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec Hyprland
fi

# Zsh History Settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# History options to manage duplicates and improve usability
setopt HIST_IGNORE_DUPS          # Ignore consecutive duplicate commands
setopt HIST_IGNORE_ALL_DUPS      # Remove all previous duplicates of a command
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt SHARE_HISTORY             # Share history between sessions
setopt INC_APPEND_HISTORY        # Append commands to history immediately
setopt EXTENDED_HISTORY          # Save timestamps in history
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from commands
setopt HIST_VERIFY               # Verify before executing history expansion

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec dbus-run-session Hyprland
fi



# Source Fzf keybindings and completions
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# Fzf Keybindings and Settings
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Customize Fzf keybindings and commands
bindkey '^T' fzf-file-widget
export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix"
export FZF_CTRL_T_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"

bindkey '^R' fzf-history-widget
export FZF_CTRL_R_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"

bindkey '^[C' fzf-cd-widget
export FZF_ALT_C_COMMAND="fd --type d"

# Aliases
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
alias lh="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all";
alias la="eza --color=always --long --git --icons=always";
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias vim="nvim"

# Tmux Session Function
# fs() {
#   session=$(find ~/dev ~/dev/scratch ~/.config -mindepth 0 -maxdepth 1 -type d | fzf)
#   session_name=$(basename "$session" | tr . _)
#
#   if ! tmux has-session -t "$session_name" 2> /dev/null; then
#     tmux new-session -d -s "$session_name" -c "$session"
#   fi
#
#   if [[ -z $TMUX ]]; then
#     tmux attach-session -t $session_name
#   else
#     tmux switch-client -t $session_name
#   fi
# }

# Environment Variables

