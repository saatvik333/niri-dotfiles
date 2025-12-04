# Gemini CLI
if [[ -f "$HOME/.config/gemini.env" ]]; then
  source "$HOME/.config/gemini.env"
fi

# Starship configuration
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export STARSHIP_CACHE=~/.starship/cache
eval "$(starship init zsh)"

# Format man pages
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Node.js (bundled ICU)
export PATH="/opt/node/bin:$PATH"

# PATH additions
for p in ~/.local/bin ~/Applications/depot_tools; do
  if [[ -d "$p" ]] && [[ ":$PATH:" != *":$p:"* ]]; then
    export PATH="$p:$PATH"
  fi
done

# Development paths
export SHELL_CONFIG_DIR="$HOME/.config"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"
export ANDROID_HOME="$HOME/Android"
export ANDROID_SDK_ROOT="$ANDROID_HOME/sdk"
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
export FLUTTER_HOME="$ANDROID_HOME/flutter"
export PATH="$FLUTTER_HOME/bin:$PATH"
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# opencode
if [[ -d "$HOME/.opencode/bin" ]]; then
  export PATH="$HOME/.opencode/bin:$PATH"
fi

######################
### Key Bindings  ####
######################
# Enable vim bindings
bindkey -v

# !! and !$ support (zsh has this by default, but ensure it's enabled)
# These work natively in zsh with history expansion
setopt BANG_HIST

# Zsh-specific settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt extended_history

##################
### Functions  ###
##################
# Better history with timestamps
history() {
  # Use fc (fix command) to show history with timestamps
  fc -li 1
}

# Backup function
backup() {
  if [[ -n "$1" ]]; then
    cp "$1" "$1.bak"
  else
    echo "Usage: backup <filename>"
  fi
}

# Enhanced copy function
copy() {
  local count=$#
  if [[ $count -eq 2 ]] && [[ -d "$1" ]]; then
    local from="${1%/}"  # Remove trailing slash
    local to="$2"
    command cp -r "$from" "$to"
  else
    command cp "$@"
  fi
}

# mkcd DIR
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
  local file="$1"
  if [[ -f "$file" ]]; then
    case "$file" in
      *.tar.bz2) tar xjf "$file" ;;
      *.tar.gz) tar xzf "$file" ;;
      *.bz2) bunzip2 "$file" ;;
      *.rar) unrar x "$file" ;;
      *.gz) gunzip "$file" ;;
      *.tar) tar xvf "$file" ;;
      *.tbz2) tar xjf "$file" ;;
      *.tgz) tar xzf "$file" ;;
      *.zip) unzip "$file" ;;
      *.Z) uncompress "$file" ;;
      *.7z) 7z x "$file" ;;
      *) echo "'$file' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$file' is not a valid file"
  fi
}

##################
### Aliases    ###
##################
# ls replacements (matching fish exactly)
alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.='eza -a | grep -e "^\."'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# System helpers
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Arch helpers
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias update='sudo pacman -Syu'
alias mirror="sudo cachyos-rate-mirrors"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Shortcuts
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias jctl="journalctl -p 3 -xb"
alias nf='neofetch'
alias ff='fastfetch'
alias uf='uwufetch'
alias q='exit'
alias h='history'
alias c='clear'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcl='git clone'
alias gl='git log --oneline'
alias gd='git diff'
alias gpush='git push'
alias gpull='git pull'

# System control
alias wifi='nmtui'
alias install='yay -S'
alias search='yay -Ss'
alias lsearch='yay -Qs'
alias remove='yay -Rns'
alias shutdown='systemctl poweroff'
alias du='dust'

# Zsh-specific aliases
alias zshconfig='$EDITOR ~/.config/zsh/config.zsh'

# kiro shell integration
if [[ "$TERM_PROGRAM" == "kiro" ]]; then
  if command -v kiro &> /dev/null; then
    source "$(kiro --locate-shell-integration-path zsh)"
  fi
fi

# Zsh-specific plugins
# source $HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh