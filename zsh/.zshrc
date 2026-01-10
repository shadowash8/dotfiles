# Welcome
source $HOME/.config/scripts/greet
source $HOME/.zprofile

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit


# Terminal
export LANG=en_US.UTF-8

export EDITOR="nvim"
 
# Alias
alias vi="nvim"
alias vim="nvim"
alias zshconf="vi ~/.zshrc"
alias zshref="source ~/.zshrc"
alias ls='eza'
alias ll='eza -la'
alias g="git"
alias cls="clear"
alias cat="bat"
alias lg="lazygit"
alias lj="lazyjournal"
alias em='emacsclient -c -a "emacs"'
alias get="curl -O"
alias nmrestart="sudo systemctl restart NetworkManager"

alias dn="sudo dnf"
alias dni="sudo dnf in"
alias dnr="sudo dnf rm"
alias dns="sudo dnf search"

alias dwmgen="cd ~/.ashdwm/dwm/ && sudo make clean install"
alias pdry="patch --dry-run -p1 <"
alias prun="patch -p1 <"
alias sx="startx ~/.xinitrc"

# Shell integrations
eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza $realpath'

# opts
setopt CORRECT

# Edit command buffer
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Android Config 
if [[ "$(uname -o)" == "Android" ]]; then
	echo "Termux environment detected."

	alias doom="$HOME/.config/emacs/bin/doom"
	alias emg='termux-x11 :1 -xstartup "emacsclient -c -a emacs" &'
	sv-enable emacsd

	# Check if the Syncthing process is already running
	if ! pgrep -x syncthing > /dev/null 2>&1; then
		echo "Syncthing is not running. Starting it now..."
		# Start Syncthing in the background and silence its output
		syncthing --no-browser > /dev/null 2>&1 &
		echo "Syncthing started in the background."
	else
		echo "Syncthing is already running. No action needed."
	fi
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
