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
  " fugitive.vim: A Git wrapper so awesome, it should be illegal
  " TODO: I really just need a small subset of this.
  Plug 'tpope/vim-fugitive'
  " A colorful, dark color scheme for Vim.
  Plug 'nanotech/jellybeans.vim'
  " Vim plugin: Create your own text objects
  Plug 'kana/vim-textobj-user'
  " A custom text object for selecting ruby blocks.
  Plug 'nelstrom/vim-textobj-rubyblock'
  " 🌸 A command-line fuzzy finder
  Plug '/usr/local/opt/fzf'
  " fzf ❤️ vim
  Plug 'junegunn/fzf.vim'
  " A solid language pack for Vim.
  Plug 'sheerun/vim-polyglot'

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

  " Open devdocs.io from Vim
  Plug 'rhysd/devdocs.vim'
  " Open devdocs.io in Safari on macOS
  let g:devdocs_open_cmd = 'open -a DevDocs.app'

  " Run Rspec specs from Vim
  Plug 'thoughtbot/vim-rspec'
  let g:rspec_command = "!bundle exec rspec {spec}"
  let g:rspec_runner = "os_x_iterm2"

  " A light and configurable statusline/tabline plugin for Vim 
  Plug 'itchyny/lightline.vim'
  let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

call plug#end()

" Light it up!
colorscheme jellybeans

" But only slightly.
let &t_ut=''

" Include the built-in matchit.vim plugin
" Allows for matching of blocks with the % motion
packadd! matchit
runtime macros/matchit.vim

" Plugins end }}}

" Vim settings {{{
" Show line numbers on the side
set number
set numberwidth=5 " Comfortable line number pane width

set omnifunc=syntaxcomplete#Complete " Use ALE for Omnifunc

set termguicolors " Use the full spread of our monitor's colours

set undodir=~/.vim/undodir " Permanent undos
set undofile

set backspace=2 " Backspace deletes like most programs in instert mode

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
set visualbell
set vb t_vb=

set encoding=utf-8 " Should be default, just in case

" Put some lines around the cursor so that we have at least a little bit of
" context
set scrolloff=3
" If you don't have a color terminal get with the times.
syntax on

" Use full line to separate windows
set fillchars+=vert:│

" Display tabs and trailing spaces
set list
set listchars=tab:␉·,trail:␠,nbsp:⎵

" Make some file browser adjustments
let g:netrw_liststyle = 3 " Tree view is the default view
let g:netrw_banner = 0 " Hide the directory banner permanently
let g:netrw_winsize = 25 " Reduce the size of the split to 25%

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

" Don't automatically insert suggestions from suggestion menus
set completeopt=menu,menuone,preview,noselect,noinsert

" Vim settings end }}}

" Bindings {{{
" Move within wrapped lines
nmap k gk
nmap j gj

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Use space-` to open a temporary project overview pane.
" I never use this anymore.
" nnoremap <Leader>` :Vexplore<CR>

" Move around windows with Ctrl+hjkl instead of having to do two keystrokes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle relative and absolute line numbers
nnoremap <Leader>o :set relativenumber!<cr>

" Open/close the quickfix pane and go back and forth between errors
nnoremap <Leader>q :copen<cr>
nnoremap <Leader>h :cp<cr>
nnoremap <Leader>l :cn<cr>

" Maximum config stealing efficiency bindings!  S-so to save and re-source vimrc
" S-vc to open vimrc in new tab
nnoremap <leader>so :w<cr>:source ~/.vimrc<cr>
nnoremap <leader>vc :tabe ~/.vimrc<cr>

" vim-rspec bindings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>

" Search for files with Ctrl+P
nnoremap <C-p> :Files<CR>

" Use DevDocs instead of keywordprg
nmap K <Plug>(devdocs-under-cursor)
vmap K <Plug>(devdocs-under-cursor)

" Bindings end }}}

" Custom commands {{{

command! MakeRubocop :cexpr system("bundle exec rubocop -f e " . shellescape(expand('%:p')))
command! MakeRubocopAll :cexpr system("bundle exec rubocop -f e")
command! RipperTags :!ripper-tags -R . --exclude=vendor

" Custom commands end }}}

" Autocmds {{{
augroup filetype_ruby
  autocmd!
  " Run <Leader><Space> to run Rubocop on the current project and expand the
  " results in a quickfix window.
  autocmd FileType ruby nnoremap <buffer> <Leader><Space> :MakeRubocop<cr>:copen<cr>
  autocmd FileType ruby nnoremap <buffer> <Leader>p :MakeRubocopAll<cr>:copen<cr>
  " TODO: Am I really using Autocomplete that much?
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
augroup END

augroup filetype_quickfix
  autocmd!
  " Quickly hide the quickfix window if we so desire.
  autocmd Filetype qf nmap <buffer> q :q<cr>
  autocmd Filetype qf setlocal wrap
augroup END

augroup filetype_vim
  autocmd!
  " Use automatic marker folds for Vim files
  autocmd FileType vim setlocal foldmethod=marker
  " Since our vimrc is nicely categorised, automatically fold it on startup
  autocmd FileType vim setlocal foldlevel=0
augroup END

" Don't pollute the working directory with random NetrwListing files.
augroup filetype_netrw
  autocmd!
  autocmd FileType netrw setlocal noautowriteall
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
