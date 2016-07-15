" Pre-plugin configuration

let g:EasyMotion_leader_key = '<SPACE>'

let g:no_rust_conceal="yes"
let g:tex_conceal= ''

let g:local_vimrc = {'names':['.local.vim'],'hash_fun':'LVRHashOfFile'}

let g:indentLine_char = '¦'

let g:gruvbox_color_column='faded_red'
" Vundle

set runtimepath+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin("~/.config/nvim/bundle")

" let vundle manage itself
Plugin 'gmarik/Vundle.vim'

Plugin 'john2x/flatui.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'

Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-bundler'

Plugin 'vim-ruby/vim-ruby'
Plugin 'derekwyatt/vim-scala'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nvie/vim-flake8'

Plugin 'adinapoli/vim-markmultiple'
Plugin 'godlygeek/tabular'

Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/matchit.zip'
Plugin 'chreekat/vim-paren-crosshairs'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-underscore'

Plugin 'MarcWeber/vim-addon-local-vimrc'

Plugin 'Yggdroot/indentLine'
Plugin 'ivyl/vim-bling'

Plugin 'morhetz/gruvbox'

" python dependant plugins
Plugin 'davidhalter/jedi-vim'
Plugin 'simnalamburt/vim-mundo' " forked from sjl/gundo.vim

call vundle#end()
