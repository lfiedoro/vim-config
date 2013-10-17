" minimizing GUI
if has('gui_running')
  set guioptions-=T  " remove toolbar
  set guioptions-=m  " remove menubar
  set guioptions-=r  " remove right-hand scroll bar
  set guioptions-=L  " remove right-hand scroll bar
  set guioptions-=e  " text tabs
  set gfn=Droid\ Sans\ Mono\ Dotted\ 8
endif

" no ugly borders
if has('gui_gtk') && has('gui_running')
  let s:border = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
  exe 'silent !echo ''style "vimfix" { bg[NORMAL] = "' . escape(s:border, '#') . '" }'''.
        \' > ~/.gtkrc-2.0'
  exe 'silent !echo ''widget "vim-main-window.*GtkForm" style "vimfix"'''.
        \' >> ~/.gtkrc-2.0'
endif
