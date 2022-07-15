"" vim:ft=vim:fdm=marker

" turn off highlighting by hitting enter {{{1
nmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>
vmap <silent> <CR> :nohlsearch \| :call MarkMultipleClean()<CR>


" spell checking {{{1
nmap <silent> <leader>s :set spell!<CR>

" Gundo - visualizing redo/undo changes {{{1
nmap <leader>u :MundoToggle<CR>

" show invisibles {{{1
nmap <leader>l :set list!<CR>

" toggle ordinary color column {{{1
hi ColorColumn  ctermbg=Black
let g:color_column_toggle = 0
function! ColorColumnToggle()
  if g:color_column_toggle
    set colorcolumn=
    let g:color_column_toggle = 0
  else
    let &colorcolumn=join(range(81,999),",")
    let g:color_column_toggle = 1
  end
endfunc
nmap <silent> <leader>cc :call ColorColumnToggle()<CR>
call ColorColumnToggle()

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
  w suda://%
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

" :Rename new_name - rename the <cword> in all the files in the arglist {{{1
function Rename(new_name)
  let old_name=expand('<cword>')
  let cmd=':argdo :%s/\<' . old_name . '\>/' . a:new_name . '/ge'
  echo
  execute cmd
  execute "normal \<C-O>"
endfunction
command! -nargs=1 Rename call Rename(<q-args>)

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

highlight ColorBGred ctermbg=red
highlight ColorBGbrown ctermbg=brown
highlight ColorBGwhite ctermbg=white
highlight ColorBGyellow ctermbg=yellow
highlight ColorBGmagenta ctermbg=magenta
highlight ColorBGcyan ctermbg=cyan
highlight ColorBGgreen ctermbg=green
highlight ColorBGblue ctermbg=blue
highlight ColorBGdarkgray ctermbg=darkgray
highlight ColorBGgray ctermbg=gray
highlight ColorBGdarkmagenta ctermbg=darkmagenta
highlight ColorBGdarkmagenta ctermbg=darkmagenta
highlight ColorBGdarkred ctermbg=darkred
highlight ColorBGdarkcyan ctermbg=darkcyan
highlight ColorBGdarkgreen ctermbg=darkgreen
highlight ColorBGdarkblue ctermbg=darkblue
highlight ColorBGblack ctermbg=black

let g:colorbg_matches = []

function s:ColorBgNames(A,L,P)
  return "red\nbrown\nwhite\nyellow\nmagenta\ncyan\ngreen\nblue\ndarkgray\ngray\ndarkmagenta\ndarkmagenta\ndarkred\ndarkcyan\ndarkgreen\ndarkblue\nblack"
endfunction

function! s:ColorBG(color)
  let pattern = getreg('/')
  let match = matchadd('ColorBG'.a:color, pattern)
  call add(g:colorbg_matches, match)
endfunction
command! -complete=custom,s:ColorBgNames -nargs=* ColorBG call s:ColorBG(<q-args>)

function! s:ColorBGRemoveLast()
  if len(g:colorbg_matches) > 0
    let match = g:colorbg_matches[-1]
    let g:colorbg_matches = g:colorbg_matches[:-2]
    call matchdelete(match)
  endif
endfunction
command! -nargs=0 ColorBGRemoveLast call s:ColorBGRemoveLast()

function! s:ColorBGRemoveAll()
  for match in g:colorbg_matches
    call matchdelete(match)
  endfor
  let g:colorbg_matches = []
endfunction
command! -nargs=0 ColorBGRemoveAll call s:ColorBGRemoveAll()

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

" <leader>rb and <leader>so git signoffs {{{1
nmap <leader>rb oReviewed-by: <C-r>=system("git config user.name")<CR><ESC>kJA <<C-r>=system("git config user.email")<CR>><ESC>kJx
nmap <leader>so oSigned-off-by: <C-r>=system("git config user.name")<CR><ESC>kJA <<C-r>=system("git config user.email")<CR>><ESC>kJx
nmap <leader>ack oAcked-by: <C-r>=system("git config user.name")<CR><ESC>kJA <<C-r>=system("git config user.email")<CR>><ESC>kJx

" <leader>ss for email signature {{{1
nmap <leader>ss o<CR>-- <CR>Cheers,<CR>Arek<ESC>

" <leader>ab access addrbook {{{3
function! InsertAddress(line)
  call append(line('.'), a:line)
  normal! J
endfunction

nmap <leader>ab :call fzf#run({'source': 'notmuch address \*', 'sink': function('InsertAddress')})<CR>
