# A place to put all the extra commands and aliases that I might need.

# Switch the Kubernetes context with the magic of FZF.
def kctx [] {
  kubectl config use-context (kubectl config get-contexts -o=name | fzf --height=30% --reverse)
}

# Pass to nushell's open command.
def nuopen [arg, --raw (-r)] {
  if $raw { open -r $arg } else { open $arg }
}
alias open = ^open

# List all projects (directories under ~/Code)
def list-projects [] { ls -s $"($env.HOME)/Code" | sort-by -r modified | get name }

# Change to a project directory (directory under ~/Code).
def --env view-project [dir: string@list-projects] {
  cd $"($env.HOME)/Code/($dir)"
}

# Open the project in VS Code
def open-project [dir: string@list-projects] {
  code $"($env.HOME)/Code/($dir)"
}
alias ccd = view-project
