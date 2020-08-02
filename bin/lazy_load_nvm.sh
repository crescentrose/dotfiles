function _install_nvm() {
  unset -f nvm npm node
  safe_source "$NVM_DIR/nvm.sh"
  safe_source "$NVM_DIR/zsh_completion"
  "$@"
}

function nvm() {
    _install_nvm nvm "$@"
}

function npm() {
    _install_nvm npm "$@"
}

function node() {
    _install_nvm node "$@"
}
