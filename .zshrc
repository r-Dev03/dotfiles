if [ -f /etc/zshrc ]; then
  source /etc/zshrc
fi


if [[ -n $NVIM ]]; then
  bindkey -e  # use emacs mode when running inside Neovim terminal
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
# export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"
export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix"
export FZF_DEFAULT_OPTS="\
  --height=50% \
  --layout=reverse \
  --info=inline \
  --border \
  --margin=1 \
  --padding=1 \
  --color=bg+:#1c1c24,bg:#101317,spinner:#ad8dbd,hl:#ad8dbd \
  --color=fg:#D1CEC9,header:#9bb4bc,info:#797ea3,pointer:#8f9e9b \
  --color=marker:#B4C7A7,fg+:#D1CEC9,prompt:#90a0b5,hl+:#ad8dbd \
  --color=selected-bg:#1c1c24 \
  --color=border:#505164,label:#797ea3"




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
  session=$(find ~/code ~/dotfiles ~/work -mindepth 1 -maxdepth 1 -type d \( -name '.git' -prune \) -o -type d -print | sed "s|^$HOME/||" | fzf)
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

