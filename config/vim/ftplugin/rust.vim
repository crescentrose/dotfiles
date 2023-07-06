" tools must be installed:
" rustup component add rust-analyzer
" rustup component add clippy
" rustup component add rustfmt

let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['analyzer']

" run Clippy on save through rust-analyzer
let b:ale_rust_analyzer_config = {
      \ "checkOnSave": {
      \   "command": "clippy"
      \ }
      \ }
