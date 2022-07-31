" clear our autocmd group
augroup InitFile
  au!
augroup END

colorscheme solarized


set nomodeline " "security"

set listchars=tab:▸\ ,eol:¬

set number relativenumber
augroup InitFile
  au WinEnter * set relativenumber
augroup END

set cursorline
set scrolloff=8
set shortmess+=I
set visualbell
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


" do not write swap files, what is lot is lost
set nobackup nowritebackup noswapfile

runtime mappings.vim
runtime filetypes.vim

function! s:SetGitTags()
  let file_dir = expand('%:h')
  let infix = ""

  if file_dir != ""
    let infix="-C " .. file_dir
  endif

  let git_dir = trim(system("git " .. infix .. " rev-parse --git-dir"))

  if v:shell_error == 0
      let &l:tags = './tags;,tags,' . git_dir . '/tags'
  endif
endfunction
call s:SetGitTags()

augroup InitFile
  " resize splits to equal size when resizing window
  au VimResized * :wincmd =

  " jump to last know position in the file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  au BufWinEnter * call s:SetGitTags()

  au BufWritePost plugins.lua lua package.loaded['plugins'] = nil
  au BufWritePost plugins.lua lua require'plugins'
  au BufWritePost plugins.lua :PackerSync

  au TextYankPost * silent! lua vim.highlight.on_yank({ on_visual = false })
augroup END
