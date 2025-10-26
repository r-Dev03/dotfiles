if [ -f /etc/zshrc ]; then
  source /etc/zshrc
fi

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

HISTDUP=erase


setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt APPEND_HISTORY   
setopt HIST_REDUCE_BLANKS
unsetopt SHARE_HISTORY

# Source Fzf keybindings and completions
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# Fzf Keybindings and Settings
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"
export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix"




# --- Keybindings ---
bindkey '^ ' autosuggest-accept
bindkey -r '\ec'
bindkey -rM emacs '\ec'
bindkey -rM viins '\ec'
bindkey -rM vicmd '\ec'

# --- Aliases ---
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lh="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all"
alias la="eza --color=always --long --git --icons=always"
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias vim="nvim"
alias open="xdg-open"

# --- Functions ---
fs() {
  session=$(find ~/code ~/dotfiles -mindepth 1 -maxdepth 1 -type d \( -name '.git' -prune \) -o -type d -print | sed "s|^$HOME/||" | fzf)
  session_name=$(basename "$session" | tr . _)

  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$session"
  fi

  if [[ -z $TMUX ]]; then
    tmux attach-session -t $session_name
  else
    tmux switch-client -t $session_name
  fi
}

fn() {
  # If called with -r or --rescan, refresh Wi-Fi list first
  if [[ "$1" == "-r" || "$1" == "--rescan" ]]; then
    nmcli device wifi rescan >/dev/null
  fi

  # Show table and let fzf select
  nmcli device wifi list \
    | tail -n +2 \
    | fzf \
    | awk '{print $1}' \
    | xargs -r nmcli device wifi connect
}

