syntax on

filetype indent on
filetype plugin on

set nomodeline " "security"

set listchars=tab:▸\ ,eol:¬

set number relativenumber
set cursorline
set ruler
set scrolloff=8
set shortmess+=I
set showcmd
set visualbell
set showfulltag
set splitbelow splitright

set lazyredraw

set virtualedit=block

" when changing (c command) put $ on word boundary and keep it visible
set cpoptions+=$

set hidden " switch between buffers without saving

set magic " easier regexps

" search incrementally, with highlighting and preview
set hlsearch
set incsearch
set ignorecase smartcase

set showmatch matchtime=3 " matching bracket
set matchpairs+=<:>

set smartindent

set formatoptions-=t " no automatic text wrapping
set textwidth=80
set nojoinspaces " only one space when joining
set nowrap linebreak

" preview :s
set inccommand=nosplit

" easier tabbing through alternative in command mode
set wildignore+=*.pyc
set wildignore+=*.o

" do not write swap files, what is lot is lost
set nobackup nowritebackup noswapfile

let git_dir = trim(system("git rev-parse --git-dir"))
if v:shell_error == 0
  let &tags .= ',' . git_dir . '/tags'
endif
set tags^=./.git/tags;

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

  " tailing white space highlight
  au WinEnter * match ColorColumn /\M\s\+$/
  match ColorColumn /\M\s\+$/

  au BufWritePost plugins.lua lua package.loaded['plugins'] = nil
  au BufWritePost plugins.lua lua require'plugins'
  au BufWritePost plugins.lua :PackerSync

  au TextYankPost * silent! lua vim.highlight.on_yank()
endif
