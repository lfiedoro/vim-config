runtime plugins.vim

colorscheme transxoria

syntax on

filetype indent on
filetype plugin on


set encoding=utf-8
set listchars=tab:▸\ ,eol:¬

set backspace=indent,eol,start

set magic

set synmaxcol=800
set number relativenumber
set cursorline
set ruler
set scrolloff=8
set shortmess+=I
set showcmd
set visualbell
set showfulltag
set splitbelow splitright

set ttyfast
set lazyredraw

set virtualedit=block

" when changing (c command) put $ on word boundary and keep it visible
set cpoptions+=$

set hidden " switch between buffers without saving

set hlsearch
set incsearch
set ignorecase smartcase

set showmatch matchtime=3 " matching bracket
set matchpairs+=<:>

set smarttab smartindent autoindent

set fo-=t " no automatic text wrapping
set textwidth=80
set nojoinspaces " only one space when joinning
set nowrap linebreak nolist

set wildmenu
set wildignore+=*.pyc

set nobackup
set nowritebackup
set noswapfile
set history=1000
set undolevels=100

runtime gui.vim
runtime mappings.vim
runtime filetypes.vim

if has("autocmd")
  " enter will work in command edit mode as intended, since by default it's
  " mapped to :nohl
  au CmdwinEnter * noremap <buffer><CR> <CR>

  " resize splits to equal size when resizing window
  au VimResized * :wincmd =

  " jump to last know position in the file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " set relativenumber by default everywhere
  au BufRead * set relativenumber
  au BufRead * set concealcursor=c

  " trailing white space highlight
  au WinEnter * match Error /\M\s\+$/
  match Error /\M\s\+$/
endif
