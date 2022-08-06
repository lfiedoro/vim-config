if has("autocmd")

  " filetype based settings
  au FileType c,cpp            setl cindent tw=79 path=.,/usr/include,/usr/local/include,/usr/lib/gcc/*/*/include
  au FileType java             setl ai ts=4 sw=4 sts=4   expandtab cindent
  au FileType perl             setl ai ts=4 sw=4 sts=4   expandtab cindent
  au FileType python           setl ai ts=4 sw=4 sts=4   expandtab
  au FileType ruby             setl ai ts=2 sw=2 sts=2   expandtab
  au FileType scala            setl ai ts=2 sw=2 sts=2   expandtab
  au FileType rust             setl ai ts=2 sw=2 sts=2 noexpandtab colorcolumn=
  au FileType awk              setl ai ts=4 sw=4 sts=4 noexpandtab
  au FileType html,htmldjango  setl ai ts=4 sw=4 sts=4   expandtab
  au FileType sh,zsh           setl ai ts=4 sw=4 sts=4   expandtab
  au FileType vim              setl ai ts=2 sw=2 sts=2   expandtab
  au FileType xml              setl ai ts=4 sw=4 sts=4 noexpandtab
  au FileType css,scss         setl ai ts=4 sw=4 sts=4   expandtab
  au FileType make             setl ai ts=4 sw=4 sts=4 noexpandtab
  au FileType eruby            setl ai ts=4 sw=4 sts=4   expandtab
  au FileType javascript       setl ai ts=4 sw=4 sts=4   expandtab
  au FileType coffee           setl ai ts=2 sw=2 sts=2   expandtab
  au FileType lua              setl ai ts=2 sw=2 sts=2   expandtab
  au FileType tex,plaintex     setl ai ts=2 sw=2 sts=2 noexpandtab fo+=t

  au FileType markdown         setl tw=77 fo+=t
  au FileType gitcommit        setl tw=72 fo+=t
  au FileType gitcommit        setl spell

  au FileType javascript       set omnifunc=javascriptcomplete#CompleteJS
endif
