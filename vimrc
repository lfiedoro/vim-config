" pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

colorscheme transxoria

set fileencoding=utf-8

set undolevels=100

syntax on

set smarttab
set smartindent
set autoindent
set backspace=indent,eol,start

set magic
set number
set cursorline
set ruler

" switch between buffers without saving
set hidden

set visualbell
set hlsearch

set nowrap linebreak nolist

set nojoinspaces " only one space when joinning
set showmatch matchtime=3 " matching bracket
set matchpairs+=<:>
set showfulltag virtualedit=block
set splitbelow splitright
set incsearch noignorecase
set shortmess+=I showcmd

" backups & history
set nobackup
set nowritebackup
set noswapfile
set history=1000

" when changing (c command) put $
" on word boundary and keep it visible
set cpoptions+=$

" wild menu helping when tabing through matches
set wildmenu

" When the page starts to scroll, keep the cursor 8 lines from
" the top and 8 lines from the bottom
set scrolloff=8

" setting indent and tab expanding depending on file type
filetype indent on
filetype plugin on

" no automatic text wrapping for most formats
set fo-=t

" global textwidth
set textwidth=78

" nice invisibles
set listchars=tab:▸\ ,eol:¬

" Auto window resizing
" Nasty Hack: height must be bigger than minheight on setting.
" Fails when huge at fist.
set winwidth=84
set winheight=10
set winminheight=10
set winheight=999

let g:no_rust_conceal="yes"

" turn off highlighting by hitting enter
nmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>
vmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>

" navigate through buffers easily
nmap <silent> gb :CtrlPBuffer<CR>

" spell checking
nmap <silent> <leader>s :set spell!<CR>

" toggle spelling language
function! SpellingLanguageToggle()
  if (&spelllang == 'pl')
    set spelllang=en
  else
    set spelllang=pl
  endif
endfunc
nmap <silent> <leader>S :call SpellingLanguageToggle()<CR>

" Gundo - visualizing redo/undo changes
nmap <leader>g :GundoToggle<CR>

" switch.vim mapping to -
nmap - :Switch<cr>

" show invisibles
nmap <leader>l :set list!<CR>

" toggle smart color column
let g:color_column_toggle = 0
function! ColorColumnToggle()
  if g:color_column_toggle
    call matchdelete(g:color_column_toggle)
    let g:color_column_toggle = 0
  else
    let g:color_column_toggle = matchadd('ColorColumn', '\%79v', 100)
  end
endfunc
nmap <silent> <leader>cc :call ColorColumnToggle()<CR>
call ColorColumnToggle()


" change to directory of opened file
nmap <leader>cd :lcd %:h<CR>

" toggle relative/normal line numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nmap <silent> <leader>n :call NumberToggle()<CR>

" Unimpaired text bubbling
nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

" binding for editing vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" change behaviour of c-n c-p to more common-sense in command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" view yanking/pasting (number specified by count, defaults to 1)
" use in normal mode:
" zy <some folding> 5zy zp
noremap <silent> zy :<C-u>exe ":mkview ".v:count1<CR>
noremap <silent> zp :<C-u>exe ":loadview ".v:count1<CR>

" %% will expand to current dir in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" eclim java
nmap <leader>ji :JavaImport<CR>
nmap <leader>jI :JavaImportMissing<CR>
nmap <leader>jr :Java<CR>
nmap <leader>jd :JavaDocSearch<CR>
nmap <leader>eo :ProjectOpen<CR>

" writing to protected file using :Sw
function! SudoWrite()
  w !sudo dd of=%
  e!
endfunction
command! -nargs=0 Sw call SudoWrite()

" minimizing GUI
if has('gui_running')
  set guioptions-=T  " remove toolbar
  set guioptions-=m  " remove menubar
  set guioptions-=r  " remove right-hand scroll bar
  set guioptions-=L  " remove right-hand scroll bar
  set guioptions-=e  " text tabs
  set gfn=Droid\ Sans\ Mono\ Dotted\ 8
endif

if has('gui_gtk') && has('gui_running')
  let s:border = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
  exe 'silent !echo ''style "vimfix" { bg[NORMAL] = "' . escape(s:border, '#') . '" }'''.
        \' > ~/.gtkrc-2.0'
  exe 'silent !echo ''widget "vim-main-window.*GtkForm" style "vimfix"'''.
        \' >> ~/.gtkrc-2.0'
endif

if has("autocmd")
  " enter will work in command edit mode as intended
	au CmdwinEnter * noremap <buffer><CR> <CR>

  " jump to last know position in the file
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

	au BufReadPost * set relativenumber

  au FileType c,cpp        setl cindent tw=79 path=.,/usr/include,/usr/local/include,/usr/lib/gcc/*/*/include
  au FileType java         setl ai ts=4 sw=4 sts=4   expandtab cindent
  au FileType perl         setl ai ts=4 sw=4 sts=4   expandtab cindent
  au FileType python       setl ai ts=4 sw=4 sts=4   expandtab
  au FileType ruby         setl ai ts=2 sw=2 sts=2   expandtab
  au FileType rust         setl ai ts=2 sw=2 sts=2 noexpandtab colorcolumn=
  au FileType awk          setl ai ts=4 sw=4 sts=4 noexpandtab
  au FileType html         setl ai ts=4 sw=4 sts=4   expandtab
  au FileType sh,zsh       setl ai ts=4 sw=4 sts=4   expandtab
  au FileType vim          setl ai ts=2 sw=2 sts=2   expandtab
  au FileType xml          setl ai ts=4 sw=4 sts=4 noexpandtab
  au FileType css,scss     setl ai ts=4 sw=4 sts=4   expandtab
  au FileType make         setl ai ts=4 sw=4 sts=4 noexpandtab
  au FileType eruby        setl ai ts=4 sw=4 sts=4   expandtab
  au FileType javascript   setl ai ts=4 sw=4 sts=4   expandtab
  au FileType coffee       setl ai ts=2 sw=2 sts=2   expandtab
  au FileType tex,plaintex setl ai ts=2 sw=2 sts=2 noexpandtab fo+=t

  au FileType markdown     setl tw=77 fo+=t
  au FileType gitcommit    setl tw=72 fo+=t
  
  " autoreload vimrc
  au BufWritePost .vimrc source $MYVIMRC
  au BufWritePost _vimrc source $MYVIMRC

  augroup filetypedetect
    au BufRead,BufNewFile *mutt-* setl filetype=mail tw=72 fo+=t
  augroup END

  augroup gzip
    " Remove all gzip autocommands
    au!

    " Enable editing of gzipped files
    au BufReadPre,FileReadPre     *.gz setl bin
    au BufReadPost,FileReadPost   *.gz let ch_save = &ch|setl ch=2
    au BufReadPost,FileReadPost   *.gz '[,']!gunzip
    au BufReadPost,FileReadPost   *.gz setl nobin
    au BufReadPost,FileReadPost   *.gz let &ch = ch_save|unlet ch_save
    au BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
    au BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
    au BufWritePost,FileWritePost *.gz !gzip <afile>:r
    au FileAppendPre              *.gz !gunzip <afile>
    au FileAppendPre              *.gz !mv <afile>:r <afile>
    au FileAppendPost             *.gz !mv <afile> <afile>:r
    au FileAppendPost             *.gz !gzip <afile>:r
  augroup END
endif

