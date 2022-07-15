" Pre-plugin configuration

let g:no_rust_conceal="yes"
let g:tex_conceal= ''

let g:local_vimrc = {'names':['.local.vim'],'hash_fun':'LVRHashOfFile'}

set runtimepath+=~/.config/nvim/plugs/vim-plug/
runtime plug.vim

call plug#begin("~/.config/nvim/plugs")

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'bash=sh', 'c', 'cpp']
Plug 'tpope/vim-markdown'

Plug 'vim-ruby/vim-ruby'
Plug 'derekwyatt/vim-scala'

Plug 'adinapoli/vim-markmultiple'
Plug 'godlygeek/tabular'

Plug 'majutsushi/tagbar'
Plug 'vim-scripts/matchit.zip'
Plug 'chreekat/vim-paren-crosshairs'

let g:EasyMotion_leader_key = '<SPACE>'
Plug 'Lokaltog/vim-easymotion'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-underscore'

let g:editorconfig_blacklist = {'filetype': ['git.*', 'fugitive']}
let g:editorconfig_verbose = 1
let g:editorconfig_root_chdir = 1
Plug 'sgur/vim-editorconfig'

let g:indentLine_char = '¦'
Plug 'Yggdroot/indentLine'

Plug 'ivyl/vim-bling'

Plug 'altercation/vim-colors-solarized'

Plug 'simnalamburt/vim-mundo'

Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim' }

Plug 'lambdalisue/suda.vim'

Plug '$HOME/.fzf'
Plug 'junegunn/fzf.vim'

Plug 'rhysd/conflict-marker.vim'

call plug#end()

nnoremap <C-p> :Files<CR>
nnoremap gb :Buffers<CR>
nnoremap gy :Tags<CR>
