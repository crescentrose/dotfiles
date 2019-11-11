# Ensure that the files we want to source actually exist.
function safe_source {
  test -e "$1" && source "$1"
}

# Enable zplug
source ~/.zplug/init.zsh

# Enable history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# zsh-async: dependecy for many other plugins
zplug mafredri/zsh-async, from:github
# pure: nice terminal prompt
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
# zsh-syntax-highlighting: self-descriptive
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
# zsh-completions: approximately one billion completion scripts
zplug 'zsh-users/zsh-completions', defer:2
zplug 'zsh-users/zsh-autosuggestions'

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Include Google Cloud SDK stuff
safe_source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
safe_source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# Include iTerm2 shell integration stuff.
safe_source "${HOME}/.iterm2_shell_integration.zsh"

# Include custom aliases from a separate file so that we can change them easily
safe_source ~/.aliasrc

# make sure GPG can do its thing on macOS
export GPG_TTY=$(tty)

eval "$(rbenv init -)"

zplug load 

# Fuzzy Finder setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="\
  --ansi \
"

  # --preview-window 'right:60%' \
  # --preview 'bat --color=always --style=header,grid --line-range :300 {}' \
# "

export FZF_DEFAULT_COMMAND="ag -l --nocolor -g \"\""
export BAT_THEME="OneHalfDark"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
