"" vim:ft=vim:fdm=marker

" turn off highlighting by hitting enter {{{1
nmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>
vmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>

" navigate through buffers easily {{{1
nmap <silent> gb :CtrlPBuffer<CR>

" spell checking {{{1
nmap <silent> <leader>s :set spell!<CR>

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

" change to directory of opened file {{{1
nmap <leader>cd :lcd %:h<CR>

" toggle relative/normal line numbering {{{1
function! NumberToggle()
  if(&relativenumber == 1)
    set number
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
