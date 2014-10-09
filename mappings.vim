"" vim:ft=vim:fdm=marker

" turn off highlighting by hitting enter {{{1
nmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>
vmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>

" navigate through buffers easily {{{1
nmap <silent> gb :CtrlPBuffer<CR>

" spell checking {{{1
nmap <silent> <leader>s :set spell!<CR>

" tab to jump between matching brackets is easier than % {{{1
map <tab> %

" toggle spelling language {{{1
function! SpellingLanguageToggle()
  if (&spelllang == 'pl')
    set spelllang=en
  else
    set spelllang=pl
  endif
endfunc
nmap <silent> <leader>S :call SpellingLanguageToggle()<CR>

" Gundo - visualizing redo/undo changes {{{1
nmap <leader>g :GundoToggle<CR>

" show invisibles {{{1
nmap <leader>l :set list!<CR>

" toggle smart color column {{{1
let g:color_column_toggle = 0

function! ColorColumnWindowSet()
  if !exists('w:color_column_toggle') | let w:color_column_toggle = 0 | en
  if g:color_column_toggle
    if !w:color_column_toggle
      let w:color_column_toggle = matchadd('ColorColumn', '\M\%'.(&textwidth+1).'v\.\+', 100)
    end
  else
    if w:color_column_toggle
      call matchdelete(w:color_column_toggle)
      let w:color_column_toggle = 0
    end
  end
endfunc

function! ColorColumnToggle()
  if g:color_column_toggle
    let g:color_column_toggle = 0
  else
    let g:color_column_toggle = 1
  end

  windo call ColorColumnWindowSet()
endfunc

au WinEnter * call ColorColumnWindowSet()

nmap <silent> <leader>cc :call ColorColumnToggle()<CR>
call ColorColumnToggle()

" toggle ordinary color column {{{1
let g:ordinary_color_column_toggle = 0
function! OrdinaryColorColumnToggle()
  if g:ordinary_color_column_toggle
    set colorcolumn=
    let g:ordinary_color_column_toggle = 0
  else
    set colorcolumn=+1
    let g:ordinary_color_column_toggle = 1
  end
endfunc
nmap <silent> <leader>CC :call OrdinaryColorColumnToggle()<CR>

" change to directory of opened file {{{1
nmap <leader>cd :lcd %:h<CR>

" toggle relative/normal line numbering {{{1
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nmap <silent> <leader>n :call NumberToggle()<CR>

" Unimpaired text bubbling {{{1
nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

" binding for editing vimrc {{{1
nmap <leader>v :tabedit $MYVIMRC<CR>

" change behaviour of c-n c-p to more common-sense in command line {{{1
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" view yanking/pasting (number specified by count, defaults to 1) {{{1
" use in normal mode:
" zy <some folding> 5zy zp
noremap <silent> zy :<C-u>exe ":mkview ".v:count1<CR>
noremap <silent> zp :<C-u>exe ":loadview ".v:count1<CR>

" %% will expand to current dir in command mode {{{1
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" writing to protected file using :Sw {{{1
function! SudoWrite()
  w !sudo dd of=%
  e!
endfunction
command! -nargs=0 Sw call SudoWrite()

" :Swq {{{1
command! -nargs=0 Swq call SudoWrite() | :q

" Y to bahave more sanely
nmap Y y$

" :Sprunge files to sprunge.us {{{1
function! Sprunge()
  w !curl -s -F 'sprunge=<-' http://sprunge.us
endfunction
command! -nargs=0 Sprunge call Sprunge()

" <leader>h to switch between .h and .cpp {{{1
function! SwitchCppH(command)
  let extension=expand('%:e')
  let root=expand('%:r')
  if extension == 'cpp'
    exec a:command.' '.root.'.h'
  elseif extension == 'h'
    exec a:command.' '.root.'.cpp'
  end
endfunction
nmap <silent> <leader>h :call SwitchCppH('e')<CR>

" <leader>H to open complemetary .h / .cpp in new v split{{{1
nmap <silent> <leader>H :call SwitchCppH('vsp')<CR>

" <leader>b opens tagbar that autoclose {{{1
nmap <silent> <leader>b :TagbarOpenAutoClose<CR>

" <leader>f reformats current file using clang-format {{{1
if !exists('g:clang_style') | let g:clang_style = 'LLVM' | en

function! ClangFormat()
  normal mf
  exec ':%!clang-format -style='.g:clang_style
  normal `fzz
endfunction

nmap <leader>f :call ClangFormat()<CR>
