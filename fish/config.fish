# Disable greeting
set -U fish_greeting ""

# Gemini CLI
if test -f $HOME/.config/gemini.env
    source $HOME/.config/gemini.env
end

# Starship prompt
if status is-interactive
    set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
    starship init fish | source
end

# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Source fish_profile if exists
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Node.js (bundled ICU)
set -gx PATH /opt/node/bin $PATH

# PATH additions
for p in ~/.local/bin ~/Applications/depot_tools
    if test -d $p
        if not contains -- $p $PATH
            set -p PATH $p
        end
    end
end

######################
### Key Bindings  ####
######################
# Enable vim bindings
set -U fish_key_bindings fish_vi_key_bindings

# Always block cursor (disable cursor switching)
function fish_mode_prompt
    echo -n ''
end

# !! and !$ support
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

##################
### Functions  ###
##################
# CS50-style make for C++
function csmake
    set binary output

    if test (count $argv) -eq 0
        set cpp_files (ls *.cpp 2>/dev/null)
        if test -n "$cpp_files"
            set filename $cpp_files[1]
        else
            echo "No .cpp files found"
            return 1
        end
    else
        set name $argv[1]
        if string match -r '\.cpp$' $name >/dev/null
            set filename $name
        else
            set filename "$name.cpp"
        end
    end

    if not test -f $filename
        echo "File $filename does not exist"
        return 1
    end

    g++ -o $binary $filename -std=c++17 -Wall -Wextra
    if test $status -eq 0
        echo "Compiled $filename -> $binary"
        printf "Run %s? [y/N] " $binary
        read -l response
        if string match -ri '^y$' $response
            ./$binary
        end
    end
end

# Run any application fully detached from the terminal
function runbg
    nohup $argv </dev/null &>/dev/null &
    disown
end

# Better history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim -r -c '/' $argv[1])
        set to $argv[2]
        command cp -r $from $to
    else
        command cp $argv
    end
end

# mkcd DIR
function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end

# Copy absolute path to clipboard
function cpath
    if test (count $argv) -eq 0
        pwd | wl-copy
    else
        realpath $argv[1] | wl-copy
    end
end

# Extract archives
function extract
    set file $argv[1]
    if test -f $file
        switch $file
            case '*.tar.bz2'
                tar xjf $file
            case '*.tar.gz'
                tar xzf $file
            case '*.bz2'
                bunzip2 $file
            case '*.rar'
                unrar x $file
            case '*.gz'
                gunzip $file
            case '*.tar'
                tar xvf $file
            case '*.tbz2'
                tar xjf $file
            case '*.tgz'
                tar xzf $file
            case '*.zip'
                unzip $file
            case '*.Z'
                uncompress $file
            case '*.7z'
                7z x $file
            case '*'
                echo "'$file' cannot be extracted via extract()"
        end
    else
        echo "'$file' is not a valid file"
    end
end

##################
### Aliases    ###
##################
# ls replacements
alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.='eza -a | grep -e "^\."'

# System helpers
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias adbconnect="$HOME/.config/scripts/adbconnect.sh"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Arch helpers
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias update='sudo pacman -Syu'
alias mirror="sudo cachyos-rate-mirrors"
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Shortcuts
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
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
alias install='paru -S'
alias update='paru -Syu'
alias search='paru -Ss'
alias lsearch='paru -Qs'
alias remove='paru -Rns'
alias shutdown='systemctl poweroff'

# tmux shortcuts
alias tl='tmux ls'                # list sessions
alias tn='tmux new -s'            # tn <name> → new session "<name>"
alias tk='tmux kill-session -t'   # tk <name> → kill that session
alias tka='tmux kill-server'      # nuke server (all sessions)

function t --description 'tmux: t = attach last/create; t <name> = attach or create that session'
    if test (count $argv) -eq 0
        if tmux has-session 2>/dev/null
            tmux attach
        else
            tmux new-session
        end
    else
        tmux attach -t $argv[1] 2>/dev/null; or tmux new-session -s $argv[1]
    end
end

function tsave --description 'tmux-resurrect: save current session state'
    if not tmux has-session 2>/dev/null
        echo "no tmux server running" >&2
        return 1
    end
    tmux run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh
    echo "saved → $(readlink ~/.local/share/tmux/resurrect/last)"
end

function trestore --description 'tmux-resurrect: restore last saved state and attach'
    set --local bootstrap 0
    if not tmux has-session 2>/dev/null
        tmux new-session -d -s _restore
        set bootstrap 1
    end
    tmux run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh
    # drop the placeholder if real sessions came back from the restore
    if test $bootstrap -eq 1; and test (tmux list-sessions 2>/dev/null | count) -gt 1
        tmux kill-session -t _restore 2>/dev/null
    end
    tmux attach
end

##################
### Environment ###
##################
set -gx SHELL_CONFIG_DIR $HOME/.config
set -gx CHROME_EXECUTABLE /usr/bin/google-chrome-stable
set -gx ANDROID_SDK_ROOT /home/saatvik333/Android/sdk
set -gx ANDROID_HOME /home/saatvik333/Android/sdk

set -gx PATH \
    /home/saatvik333/Android/flutter/bin \
    /home/saatvik333/Android/sdk/cmdline-tools/latest/bin \
    /home/saatvik333/Android/sdk/platform-tools \
    /home/saatvik333/Android/sdk/emulator \
    /opt/node/bin \
    /home/saatvik333/.cargo/bin \
    /home/saatvik333/go/bin \
    /home/saatvik333/.opencode/bin \
    /home/saatvik333/.spicetify \
    /home/saatvik333/.local/bin \
    /home/saatvik333/.browser-use/bin \
    /usr/local/sbin /usr/local/bin /usr/bin /bin \
    /home/saatvik333/.pub-cache/bin

string match -q "$TERM_PROGRAM" kiro and . (kiro --locate-shell-integration-path fish)
alias CC='claude --allow-dangerously-skip-permissions'

# tmux with UTF-8 (required for nerd font icons)
function tmux
    command tmux -u $argv
end
