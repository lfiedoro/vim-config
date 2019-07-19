" Pre-plugin configuration

let g:EasyMotion_leader_key = '<SPACE>'

let g:no_rust_conceal="yes"
let g:tex_conceal= ''

let g:local_vimrc = {'names':['.local.vim'],'hash_fun':'LVRHashOfFile'}

let g:indentLine_char = '¦'

let g:gruvbox_color_column='faded_red'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib64/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib64/clang'

let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'bash=sh', 'c', 'cpp']

let g:ackprg = 'ag --vimgrep --smart-case'

let g:editorconfig_verbose = 1
let g:editorconfig_root_chdir = 1

let g:suda#prefix = 'sudo://'

set runtimepath+=~/.config/nvim/plugs/vim-plug/
runtime plug.vim

call plug#begin("~/.config/nvim/plugs")

Plug 'mileszs/ack.vim'

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'

Plug 'vim-ruby/vim-ruby'
Plug 'derekwyatt/vim-scala'

Plug 'adinapoli/vim-markmultiple'
Plug 'godlygeek/tabular'

Plug 'majutsushi/tagbar'
Plug 'vim-scripts/matchit.zip'
Plug 'chreekat/vim-paren-crosshairs'
Plug 'Lokaltog/vim-easymotion'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-underscore'

Plug 'sgur/vim-editorconfig'

Plug 'Yggdroot/indentLine'
Plug 'ivyl/vim-bling'

Plug 'altercation/vim-colors-solarized'

Plug 'simnalamburt/vim-mundo'

Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim' }

Plug 'lambdalisue/suda.vim'

" deoplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug '$HOME/.fzf'
Plug 'junegunn/fzf.vim'

Plug 'rhysd/conflict-marker.vim'

call plug#end()

nnoremap <C-p> :Files<CR>
nnoremap gb :Buffers<CR>
nnoremap gy :Tags<CR>
