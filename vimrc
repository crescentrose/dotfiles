" Plugins, using vim-plug: https://github.com/junegunn/vim-plug
" Auto install vim-plug if it does not exist on the system

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Define plugins

call plug#begin('~/.vim/plugged')
" Plugin settings

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'nanotech/jellybeans.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

call plug#end()

" Light it up!
colorscheme jellybeans

" Include the built-in matchit.vim plugin
" Allows for matching of blocks with the % motion
" packadd! matchit 
" runtime macros/matchit.vim

" Show line numbers on the side
set number
set numberwidth=5

" Our custom keybinds start with Space
let mapleader = "\<Space>"

" Maximum config stealing efficiency bindings!
" S-so to save and re-source vimrc
" S-vc to open vimrc in new tab
nmap <leader>so :w<cr>:source ~/.vimrc<cr>
nmap <leader>vc :tabe ~/.vimrc<cr>

" Exit help easily to reduce time wasted on being a noob
autocmd Filetype help nmap <buffer> q :q<cr>

" Move within wrapped lines
nmap k gk
nmap j gj

" Some basic setup
set backspace=2 " Backspace deletes like most programs in instert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
" Hide mode name from command bar (as it is shown in Lightline)
set noshowmode

" If you don't have a color terminal get with the times.
syntax on

" Make it painfully obvious how little space we have to write our prose
set textwidth=80
set colorcolumn=+1

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Soft tabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" More natural splitting configuration (based on thoughtbot's definition of
" natural)

set splitbelow
set splitright

" Plugin settings
" CtrlP
" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g "" --ignore .git'
let g:ctrlp_use_caching = 0

" rspec-vim
" Run spec
let g:rspec_command = "!bundle exec rspec {spec}"

nmap <Leader>t :call RunCurrentSpecFile()<CR>
nmap <Leader>a :call RunAllSpecs()<CR>
nmap <Leader>l :call RunLastSpec()<CR>
nmap <Leader>s :call RunNearestSpec()<CR>

let g:rspec_runner = "os_x_iterm2"

" netrw
" Make some file browser adjustments

let g:netrw_liststyle = 3 " Tree view is the default view
let g:netrw_banner = 0 " Hide the directory banner permanently
let g:netrw_winsize = 25 " Reduce the size of the split to 25%

" Use space-` to open a temporary project overview pane.
nmap <Leader>` :Vexplore<CR> 

" CtrlP
" Use Alt-P (π character on macOS) to search for tags
nnoremap π :CtrlPTag<cr>
nmap <F8> :TagbarToggle<CR>

filetype indent plugin on

" Use Gutentags for managing tags
" Include Gemfile as a potential project root
" let g:gutentags_project_root = ['Gemfile']
" Show tag generating indicator on status line while it's running
" :set statusline+=%{gutentags#statusline()}

" Lightline
" Match Lightline color theme to Vim color theme
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

" Vim diff tools
if &diff
    highlight! link DiffText MatchParen
endif

" God knows what this does.
inoremap <C-t> <></><Esc>5hdiwp3lpT>i

" Use full line to separate windows
set fillchars+=vert:│

" Move around windows with Ctrl+hjkl instead of having to do two keystrokes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle relative and absolute line numbers
nnoremap <Leader>l :set relativenumber!<cr>
nnoremap <Leader>q :copen<cr>
nnoremap <Leader>h :cp<cr>
nnoremap <Leader>l :cn<cr>

command! MakeRspec :cexpr system("bundle exec rspec --require ~/Code/dotfiles/QuickfixFormatter.rb -f QuickfixFormatter --no-profile")

augroup filetype_ruby
  autocmd!
  " Use rubocop as a makeprg in Ruby code. This lets us run :make and have a
  " nice overview of any issues that we need to fix.
  autocmd FileType ruby setlocal makeprg=bundle\ exec\ rubocop\ -f\ e
  autocmd FileType ruby nnoremap <buffer> <Leader><Space> :MakeRspec<CR>
augroup END

augroup filetype_quickfix
  autocmd!
  " Quickly hide the quickfix window if we so desire.
  autocmd Filetype qf nmap <buffer> q :q<cr>
  autocmd Filetype qf setlocal wrap
augroup END

" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]
