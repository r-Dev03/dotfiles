setopt autocd
setopt correct
setopt interactive_comments
setopt hist_ignore_all_dups
setopt share_history

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000


# --- Load FZF bindings before your custom keybinds ---
if [ -f /run/current-system/sw/share/fzf/key-bindings.zsh ]; then
	source /run/current-system/sw/share/fzf/key-bindings.zsh
fi
if [ -f /run/current-system/sw/share/fzf/completion.zsh ]; then
	source /run/current-system/sw/share/fzf/completion.zsh
fi

# --- Keybindings ---
bindkey -v                                  # Vi mode
bindkey '^ ' autosuggest-accept             # Accept autosuggestion with Ctrl+Space
bindkey -r '\ec'
bindkey -rM emacs '\ec'
bindkey -rM viins '\ec'
bindkey -rM vicmd '\ec'

# --- Aliases (from home.nix) ---
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lh="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all"
alias la="eza --color=always --long --git --icons=always"
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias vim="nvim"
alias open="xdg-open"

# --- Starship prompt ---
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# --- Directory navigation (zoxide) ---
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# --- Direnv + nix-direnv integration ---
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# --- FZF defaults ---
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix"
  export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --info=inline --border --margin=1 --padding=1"
  export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix --exclude .git"
  export FZF_ALT_C_COMMAND="fd --type d"
fi

# --- TMUX session switcher ---
fs() {
  session=$(find ~/code ~/dotfiles -mindepth 1 -maxdepth 1 -type d \( -name '.git' -prune \) -o -type d -print | sed "s|^$HOME/||" | fzf)
  session_name=$(basename "$session" | tr . _)

  if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -d -s "$session_name" -c "$session"
  fi

  if [[ -z $TMUX ]]; then
    tmux attach-session -t "$session_name"
  else
    tmux switch-client -t "$session_name"
  fi
}

# --- Wi-Fi picker (from initExtra) ---
fn() {
  if [[ "$1" == "-r" || "$1" == "--rescan" ]]; then
    nmcli device wifi rescan >/dev/null
  fi

  nmcli device wifi list \
    | tail -n +2 \
    | fzf \
    | awk '{print $1}' \
    | xargs -r nmcli device wifi connect
}

# --- Startup banner ---
if command -v neofetch &>/dev/null; then
  neofetch
fi


