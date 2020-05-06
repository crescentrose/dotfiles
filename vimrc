" @crescentrose's vimrc
" a magic land of mystery and excitement
" recommendation: open with folds for nice categorisation
" soundtrack: https://www.youtube.com/watch?v=--9aIYos4M8

filetype indent plugin on

" Our custom keybinds start with Space
let mapleader = "\<Space>"

" Plugins, using vim-plug: https://github.com/junegunn/vim-plug {{{

" Auto install vim-plug if it does not exist on the system
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " sensible.vim: Defaults everyone can agree on
  Plug 'tpope/vim-sensible'
  " surround.vim: quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'
  " repeat.vim: enable repeating supported plugin maps with "."
  Plug 'tpope/vim-repeat'
  " commentary.vim: comment stuff out
  Plug 'tpope/vim-commentary'
  " Oceanic Next theme for neovim
  Plug 'mhartington/oceanic-next'
  " A solid language pack for Vim.
  Plug 'sheerun/vim-polyglot'
  " EditorConfig plugin for Vim http://editorconfig.org
  Plug 'editorconfig/editorconfig-vim'
  " fzf ❤️ vim
  Plug 'junegunn/fzf.vim'
  " Seamless navigation between tmux panes and vim splits
  Plug 'christoomey/vim-tmux-navigator'
  " 🌸 A command-line fuzzy finder
  Plug '/usr/local/opt/fzf'
  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

  " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
  Plug 'dense-analysis/ale'
  let g:ale_sign_error = '❌'
  let g:ale_sign_warning = '⚠️'
  let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint']
  \ }
  let g:ale_completion_enabled = 1
  nnoremap <Leader>f :ALEFix<cr>

  Plug 'puremourning/vimspector'
  let g:vimspector_enable_mappings = 'HUMAN'

  " A light and configurable statusline/tabline plugin for Vim
  Plug 'itchyny/lightline.vim'
  let g:lightline = {
      \ 'colorscheme': 'oceanicnext',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

call plug#end()

" Include the built-in matchit.vim plugin
" Allows for matching of blocks with the % motion
packadd! matchit
runtime macros/matchit.vim

" Plugins end }}}

" Vim settings {{{

" Hack for tmux
" This has to be first so that various terminal options would not be overriden
" later
if !has("gui_running")
  set t_Co=256
  set term=xterm-256color
endif

" Show line numbers on the side
set number
set relativenumber " show both the relative number and the actual line number
set numberwidth=4 " Comfortable line number pane width

set omnifunc=syntaxcomplete#Complete " Use ALE for Omnifunc

set termguicolors " termguicolors do not work over mosh :(

set undodir=~/.vim/undodir " Permanent undos
set undofile

set backspace=2 " Backspace deletes like most programs in insert mode

set nobackup " Don't write the pesky swap files
set nowritebackup
set noswapfile

set history=50 " remember last 50 cmds

set showcmd " show the last command written in cmd mode
set incsearch " display the next matched line by search
set laststatus=2 " always show the status line
set autowriteall " automatically save on any editor switch

" Hide mode name from command bar (as it is shown in Lightline)
set noshowmode

" Make it painfully obvious how little space we have to write our prose
set textwidth=80
set colorcolumn=+1

" Soft tabs, 2 spaces
" TODO: Maybe I don't want 2 spaces per tab always.
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" More natural splitting configuration (based on thoughtbot's definition of
" natural)
set splitbelow
set splitright

" If I head that fucking ~dInG!~ one more time I swear
set vb t_vb=

set encoding=utf-8 " Should be default, just in case

" Put some lines around the cursor so that we have at least a little bit of
" context
set scrolloff=5
" If you don't have a color terminal get with the times.
syntax on

" Use full line to separate windows
set fillchars+=vert:│

" Display tabs and trailing spaces
set list
set listchars=tab:␉·,trail:␠,nbsp:⎵

" (resigned sigh)
set mouse=a

" Make some file browser adjustments
let g:netrw_liststyle = 3 " Tree view is the default view
let g:netrw_banner = 0 " Hide the directory banner permanently

" Vim diff tools
if &diff
  highlight! link DiffText MatchParen
endif

" Use The Silver Searcher for grepping if available.
if executable('ag')
  set grepprg=ag\ --vimgrep
endif

" Vim terminal theme consistent with Base16 Twilight - kitty color config
" Original by David Hart (https://github.com/hartbit)
let g:terminal_ansi_colors = [
      \  '#1e1e1e', '#cf6a4c', '#8f9d6a',
      \  '#f9ee98', '#7587a6', '#9b859d',
      \  '#afc4db', '#a7a7a7', '#5f5a60',
      \  '#cf6a4c', '#8f9d6a', '#f9ee98',
      \  '#7587a6', '#9b859d', '#afc4db',
      \  '#a7a7a7'
      \  ]
hi Terminal ctermbg=none ctermfg=none guibg=#1e1e1e guifg=#a7a7a7

" Light it up!
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" But we want our background to be transparent
let &t_ut=''

" Don't automatically insert suggestions from suggestion menus
set completeopt=menu,menuone,preview,noselect,noinsert

" Vim settings end }}}

" Bindings {{{
" Move within wrapped lines
nmap k gk
nmap j gj

" Move around windows with Ctrl+hjkl instead of having to do two keystrokes
" Only do this outside of tmux, as it's resolved with `vim-tmux-navigator`
" otherwise
if !$TMUX
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
endif

" Open/close the quickfix pane and go back and forth between errors
nnoremap <Leader>q :copen<cr>
nnoremap <Leader>h :cp<cr>
nnoremap <Leader>l :cn<cr>

" Search for files with Ctrl+P
nnoremap <C-p> :Files<CR>

" Bindings end }}}

" Custom commands {{{

command! RipperTags :!ripper-tags -R . --exclude=vendor

" Custom commands end }}}

" Autocmds {{{
augroup filetype_quickfix
  autocmd!
  " Quickly hide the quickfix window if we so desire.
  autocmd Filetype qf nmap <buffer> q :q<cr>
  autocmd Filetype qf setlocal wrap
augroup END

" Exit help easily to reduce time wasted on being a noob
autocmd Filetype help nmap <buffer> q :q<cr>
" Autocmds end }}}

" Custom functions {{{
" Retrieve a filename to show in Lightline.
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
" Custom functions end }}}

" vim: fdm=marker fdl=0
