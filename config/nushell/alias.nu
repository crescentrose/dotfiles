alias vim = nvim
alias venv = sh -i -c 'source venv/bin/activate ; nu'

def --env dotenv [] {
  nuopen .env | from toml | load-env
}
