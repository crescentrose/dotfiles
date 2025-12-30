# "Project manager"

# List all projects (directories under ~/Code)
export def list [] {
  ls -s $"($env.HOME)/Code" | sort-by -r modified | get name
}

# Change to a project directory (directory under ~/Code).
export def --env go [dir: string@list] {
  cd $"($env.HOME)/Code/($dir)"
}

# Open the project in $EDITOR
export def edit [dir: string@list] {
  run-external $env.EDITOR $"($env.HOME)/Code/($dir)"
}

# Load the project's .env file as env variables
export def --env dotenv [] {
  nuopen .env | from toml | load-env
}
