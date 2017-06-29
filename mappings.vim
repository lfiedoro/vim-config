"" vim:ft=vim:fdm=marker

" turn off highlighting by hitting enter {{{1
nmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>
vmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>

" navigate through buffers easily {{{1
nmap <silent> gb :CtrlPBuffer<CR>

" navigate through tags easily {{{1
nmap <silent> gy :CtrlPTag<CR>

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

hi ColorColumn  ctermbg=red ctermfg=black

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

" :TPane - executing in tmux pane {{{1
function! s:TPane(request)
  if exists('g:tpane_id')
    let pane_id = g:tpane_pane_id
  else
    let pane_id = 2
  endif

  call system('tmux send-keys -t '.pane_id.' "'.a:request."\n".'"')
endfunction
command! -nargs=* TPane call s:TPane(<q-args>)

" :TSplit - executing in tmux pane {{{1
function! s:TSplit(request)
  call system('tmux split-window -l 10 '.' "'.a:request."; sleep 2".'"')
  call system('tmux last-pane')
endfunction
command! -nargs=* TSplit call s:TSplit(<q-args>)

" <leader>j to switch between .h and .cpp {{{1
function! SwitchCH(command, alt_ext)
  let extension=expand('%:e')
  let root=expand('%:r')
  if extension == a:alt_ext
    exec a:command.' '.root.'.h'
  elseif extension == 'h'
    exec a:command.' '.root.'.'.a:alt_ext
  end
endfunction
nmap <silent> <leader>j :call SwitchCH('e', 'cpp')<CR>

" <leader>J to open complemetary .h / .cpp in new v split{{{1
nmap <silent> <leader>J :call SwitchCH('vsp', 'cpp')<CR>

" <leader>h to switch between .h and .c{{{1
nmap <silent> <leader>h :call SwitchCH('e', 'c')<CR>

" <leader>H to open complemetary .h / .c in new v split{{{1
nmap <silent> <leader>H :call SwitchCH('vsp', 'c')<CR>

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


" <leader>cs and <leader>cg cscope searches {{{1

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out
" else add the database pointed to by environment variable
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

nmap <leader>cs :cs find s <C-r><C-w><CR>
nmap <leader>cg :cs find g <C-r><C-w><CR>

" <leader>rb and <leader>so git signoffs {{{1
nmap <leader>rb oReviewed-by: <C-r>=system("git config user.name")<CR><ESC>kJA<<C-r>=system("git config user.email")<CR><ESC>kJ$r>
nmap <leader>so oSigned-off-by: <C-r>=system("git config user.name")<CR><ESC>kJA<<C-r>=system("git config user.email")<CR><ESC>kJ$r>

" <leader>ss for email signature {{{1
nmap <leader>ss o<CR>-- <CR>Cheers,<CR>Arek<ESC>

" <leader>ab access addrbook {{{1
nmap <leader>ab :read !addrbook<cr>
