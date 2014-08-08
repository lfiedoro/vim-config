if has('gui_running')
  " minimizing GUI
  set guioptions-=T  " remove toolbar
  set guioptions-=m  " remove menubar
  set guioptions-=r  " remove right-hand scroll bar
  set guioptions-=L  " remove left-hand scroll bar
  set guioptions-=e  " text tabs
  set guioptions+=c  " use console dialogs

  " default font and abstracted setting
  let g:fontsize = 8

  function! SetFont()
    let &gfn = 'Cousine '.g:fontsize
  endfunction

  call SetFont()

  " font resizing
  function! IncreaseFontSize()
    let g:fontsize = g:fontsize + 1

    call SetFont()
  endfunction

  function! DecreaseFontSize()
    let g:fontsize = g:fontsize - 1

    call SetFont()
  endfunction


  nmap <silent><leader>= :call IncreaseFontSize()<CR>
  nmap <silent><leader>- :call DecreaseFontSize()<CR>
endif
