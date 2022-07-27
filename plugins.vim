call plug#begin("~/.config/nvim/plugs")

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'bash=sh', 'c', 'cpp']
Plug 'tpope/vim-markdown'

Plug 'numToStr/Comment.nvim'

Plug 'vim-ruby/vim-ruby'
Plug 'derekwyatt/vim-scala'

Plug 'adinapoli/vim-markmultiple'
Plug 'dhruvasagar/vim-table-mode'

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

let g:indent_blankline_char = '¦'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'ivyl/vim-bling'

Plug 'altercation/vim-colors-solarized'

Plug 'simnalamburt/vim-mundo'

Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim' }

Plug 'lambdalisue/suda.vim'

nnoremap <C-p> :Files<CR>
nnoremap gb :Buffers<CR>
nnoremap gy :Tags<CR>
Plug '$HOME/.fzf'
Plug 'junegunn/fzf.vim'

Plug 'rhysd/conflict-marker.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-orgmode/orgmode'

call plug#end()

lua <<EOF
-- nvim-cmp && nvim-lspconfig

local cmp = require'cmp'

cmp.setup({
  snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'orgmode' },
  }, {
    { name = 'buffer' },
  })
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require'lspconfig'
local servers = { 'clangd', 'pylsp', 'rust_analyzer', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- orgmode

require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {'~/sync/org/*'},
  org_default_notes_file = '~/sync/org/refile.org',
  org_todo_keywords = {'TODO', 'WIP', '|', 'DONE'}
})

-- treesitter

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  incremental_selection = { enable = true },
}

require'Comment'.setup()
EOF
