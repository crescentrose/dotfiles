# Ensure that the files we want to source actually exist.
function safe_source {
  test -e "$1" && source "$1"
}

# Enable zplug
source ~/.zplug/init.zsh

# zsh-async: dependecy for many other plugins
zplug mafredri/zsh-async, from:github
# pure: nice terminal prompt
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
# zsh-syntax-highlighting: self-descriptive
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
# zsh-completions: approximately one billion completion scripts
# zplug 'zsh-users/zsh-completions', defer:2
zplug 'zsh-users/zsh-autosuggestions'

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
