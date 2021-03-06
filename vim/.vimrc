"           ██
"          ░░
"  ██    ██ ██ ██████████  ██████  █████
" ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
" ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"   ░░██   ░██ ███ ░██ ░██░███   ░░█████
"    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
"
"  ▓▓▓▓▓▓▓▓▓▓
" ░▓ author ▓ xero <x@xero.nu>
" ░▓ code   ▓ http://code.xero.nu/dotfiles
" ░▓ mirror ▓ http://git.io/.files
" ░▓▓▓▓▓▓▓▓▓▓
" ░░░░░░░░░░
"
" use vim settings, rather than vi settings
" must be first, because it changes other options as a side effect
set nocompatible

" paste without auto indentation
" doesn't allow insert abbreviations
" TODO: need to set a toggle for setting paste
" set paste

" hide buffers, not close them
set hidden

" TODO: get color column working
" Sets a colored column at col 80
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" let &colorcolumn=join(range(81,999),",")
" highlight ColorColumn ctermbg=180 guibg=#2c2d27

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undo

" do not use the recovery swap file
set noswapfile

" command text tab (twice) completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" case insensitive search (unless using Caps)
set ignorecase
set smartcase

" the /g flag on :s substitutions by default
set gdefault

" make backspace behave in a sane manner
set backspace=indent,eol,start

" searching
set hlsearch
set incsearch

" use indents of 2 spaces
set shiftwidth=2

" tabs are spaces, not tabs
set expandtab

" let backspace delete indent
set softtabstop=2

" remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" let mapleader=","
vnoremap <silent> <leader>y :w !xsel -i -b<CR>
nnoremap <silent> <leader>y V:w !xsel -i -b<CR>
nnoremap <silent> <leader>p :silent :r !xsel -o -b<CR>

" ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
" ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
" ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" make ; work like : for commands (lazy shifting)
nnoremap ; :
inoremap jj <Esc>

" json pretty print
command J :%!python -mjson.tool

" remove trailing white space
command Nows :%s/\s\+$//

" remove blank lines
command Nobl :g/^\s*$/d

" toggle spellcheck
command Spell :setlocal spell! spell?

" ╻┏┓╻╺┳╸┏━╸┏━┓┏━╸┏━┓┏━╸┏━╸
" ┃┃┗┫ ┃ ┣╸ ┣┳┛┣╸ ┣━┫┃  ┣╸
" ╹╹ ╹ ╹ ┗━╸╹┗╸╹  ╹ ╹┗━╸┗━╸

" show matching brackets/parenthesis
set showmatch

" disable startup message
set shortmess+=I

" lightline http://git.io/lightline
" █▓▒░ wizard status line
set laststatus=2
  let g:lightline = {
    \ 'colorscheme': 'sourcerer',
    \ 'active': {
    \   'left': [ [ 'filename' ],
    \             [ 'readonly', 'fugitive' ] ],
    \   'right': [ [ 'percent', 'lineinfo' ],
    \              [ 'fileencoding', 'filetype' ],
    \              [ 'fileformat', 'syntastic' ] ]
    \ },
    \ 'component_function': {
    \   'modified': 'WizMod',
    \   'readonly': 'WizRO',
    \   'fugitive': 'WizGit',
    \   'filename': 'WizName',
    \   'filetype': 'WizType',
    \   'fileformat' : 'WizFormat',
    \   'fileencoding': 'WizEncoding',
    \   'mode': 'WizMode',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
    \ 'subseparator': { 'left': '▒', 'right': '░' }
    \ }

" syntax highlighting and colors
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

syntax on
colorscheme sourcerer
filetype off

" stop unnecessary rendering
set lazyredraw

" show line numbers
set number

" no line wrapping
" set nowrap

" no folding
set foldlevel=99
set foldminlines=99

" don't wrap long lines
set nowrap

" highlight column
set cursorcolumn

if 1 " boolean for plugin loading
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'scrooloose/syntastic'
  Plugin 'wincent/command-t'
  Plugin 'airblade/vim-gitgutter'
  "Plugin 'isa/vim-matchit'
  "Plugin 'mustache/vim-mustache-handlebars'
  "Plugin 'rking/ag.vim'
  Plugin 'itchyny/lightline.vim'
  Plugin 'tpope/vim-fugitive'
  call vundle#end()

  " TODO need to figure out how to harness this
  filetype plugin on

  " syntatic http://git.io/syntastic.vim
  " linters: (from aur) nodejs-jshint, nodejs-jsonlint, csslint, checkbashisms
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  highlight SyntasticErrorSign ctermfg=red ctermbg=237
  highlight SyntasticWarningSign ctermfg=yellow ctermbg=237
  highlight SyntasticStyleErrorSign ctermfg=red ctermbg=237
  highlight SyntasticStyleWarningSign ctermfg=yellow ctermbg=237

  " YouCompleteMe prefs
  let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

  " git-gutter http://git.io/vimgitgutter
  let g:gitgutter_realtime = 1
  let g:gitgutter_eager = 1
  let g:gitgutter_diff_args = '-w'
  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '~'
  let g:gitgutter_sign_removed = '-'
  let g:gitgutter_sign_removed_first_line = '^'
  let g:gitgutter_sign_modified_removed = ':'
  let g:gitgutter_max_signs = 1500
  highlight clear SignColumn
  highlight GitGutterAdd ctermfg=green ctermbg=233
  highlight GitGutterChange ctermfg=yellow ctermbg=233
  highlight GitGutterDelete ctermfg=red ctermbg=233
  highlight GitGutterChangeDelete ctermfg=red ctermbg=233

  " vim mustache http://git.io/vim-stash
  "  let g:mustache_abbreviations = 1

  " ag, the silver searcher http://git.io/AEu3dQ + http://git.io/d9N0MA
  "let g:agprg="ag -i --vimgrep"
  "let g:ag_highlight=1
  " map \ to the ag command for quick searching
  "nnoremap \ :Ag<SPACE>

  function! WizMod()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '»' : &modifiable ? '' : ''
  endfunction

  function! WizRO()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'x' : ''
  endfunction

  function! WizGit()
    if &ft !~? 'help\|vimfiler' && exists("*fugitive#head")
      return fugitive#head()
    endif
    return ''
  endfunction

  function! WizName()
    return ('' != WizMod() ? WizMod() . ' ' : '') .
          \ ('' != expand('%:t') ? expand('%:t') : '[none]')
  endfunction

  function! WizType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '') : ''
  endfunction

  function! WizFormat()
    return ''
  endfunction

  function! WizEncoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
  endfunction

  augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp call s:syntastic()
  augroup END
  function! s:syntastic()
    SyntasticCheck
    call lightline#update()
  endfunction
endif
