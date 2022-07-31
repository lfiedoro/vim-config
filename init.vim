" clear our autocmd group
augroup InitFile
  au!
augroup END

colorscheme solarized

" for extra safety don't execute modlines
set nomodeline

" how to display the invisible things with :list
set listchars=tab:▸\ ,eol:¬

" show relative numbers in each window
set number relativenumber
augroup InitFile
  au WinEnter * set relativenumber
augroup END

" highlight the line with the cursor
set cursorline

" try to keep extra 8 lights below/above the cursor on the screen
set scrolloff=8

" don't display the :intro
set shortmess+=I

" don't beep on me
set visualbell

" :vsp and :sp behavior
set splitbelow splitright

" don't redraw while executing macros, etc.
set lazyredraw

" virutal editing (characters that do not exist) in the block mode
set virtualedit=block

" when changing (normal c) put $ on word boundary and keep it visible
set cpoptions+=$

" allow switching between buffers without saving
set hidden

" friendlier, magic regexps
set magic

" search incrementally, with highlighting and preview
set hlsearch
set incsearch

" enable smartcase = ignorecase if there are no uppercase chars
set ignorecase smartcase

" when inserting a bracket - flash the matching one
set showmatch
set matchpairs+=<:>

" don't wrap displayed text
set nowrap

" don't create a backup when overwritting or the swapfile
set nowritebackup noswapfile

augroup InitFile
  " resize splits to equal size when resizing vim
  au VimResized * :wincmd =

  " jump to last know position in the file
  au BufReadPost * exe "silent! normal! g`\""

  " use tags file from the git dir
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

  call s:SetGitTags() " for the initial buffer

  au BufWinEnter * call s:SetGitTags()

  " auto-sync plugins after editing plugins.lua
  au BufWritePost plugins.lua lua package.loaded['plugins'] = nil
  au BufWritePost plugins.lua lua require'plugins'
  au BufWritePost plugins.lua :PackerSync

  " blink the yanked text
  au TextYankPost * silent! lua vim.highlight.on_yank({ on_visual = false })
augroup END

runtime mappings.vim
runtime filetypes.vim
