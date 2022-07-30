local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  use 'ivyl/vim-bling'

  use 'chreekat/vim-paren-crosshairs'

  use 'dhruvasagar/vim-table-mode'

  use 'vim-scripts/matchit.zip'

  use 'lambdalisue/suda.vim'

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  use { 'numToStr/Comment.nvim', config = function() require'Comment'.setup() end }

  use { 'kana/vim-textobj-indent', requires = {'kana/vim-textobj-user'}}
  use { 'kana/vim-textobj-entire', requires = {'kana/vim-textobj-user'}}
  use { 'kana/vim-textobj-underscore', requires = {'kana/vim-textobj-user'}}

  use { 'phaazon/hop.nvim', config = function()
    local hop = require 'hop'
    hop.setup()
    vim.keymap.set('n', '<space>w', hop.hint_words)
    vim.keymap.set('n', '<space>j', hop.hint_lines)
  end }

  vim.g.editorconfig_blacklist = { filetype = { 'git.*', 'fugitive' } }
  vim.g.editorconfig_verbose = 1
  vim.g.editorconfig_root_chdir = 1
  use 'sgur/vim-editorconfig'

  use { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup()
  end }

  use { 'lukas-reineke/indent-blankline.nvim', config = function()
    require'indent_blankline'.setup { char = '¦', use_treesitter = true, show_first_indent_level = false }
  end }

  -- telescope

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim', config = function()
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<C-p>', builtin.find_files, {noremap=true})
    vim.keymap.set('n', '<C-A-P>', function() builtin.find_files{no_ignore = true} end, {noremap=true})
    vim.keymap.set('n', '<leader>b', builtin.buffers, {noremap=true})
    vim.keymap.set('n', '<leader>ff', builtin.live_grep, {noremap=true})
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, {noremap=true})

    require'telescope'.setup { extensions =
      { fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case", } }
    }
    require'telescope'.load_extension('fzf')
  end }

  -- nvim-cmp

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use { 'hrsh7th/nvim-cmp', config = function()
    local cmp = require'cmp'

    cmp.setup({
      snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources(
        { { name = 'nvim_lsp' }, },
        { { name = 'nvim_lsp_signature_help' }, },
        { { name = 'orgmode' }, },
        { { name = 'buffer' }, })
    })
  end }

  -- lspconfig

  use { 'neovim/nvim-lspconfig', requires = {'hrsh7th/nvim-cmp'}, config = function()
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    local on_attach = function(_, bufnr)

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

    local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

    local lspconfig = require'lspconfig'
    local servers = { 'clangd', 'pylsp', 'rust_analyzer', 'sumneko_lua' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup{
        on_attach = on_attach,
        capabilities = capabilities,
				settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
      }
    end
  end }

  -- orgmode

  use { 'nvim-orgmode/orgmode', config = function()
    require'orgmode'.setup({
      org_agenda_files = {'~/sync/org/*'},
      org_default_notes_file = '~/sync/org/refile.org',
      org_todo_keywords = {'TODO', 'WIP', '|', 'DONE'}
    })
  end }

  -- treesitter

  use { 'nvim-treesitter/nvim-treesitter', requires = { 'nvim-orgmode/orgmode' },
  run = function() require'nvim-treesitter.install'.update({ with_sync = true }) end,
  config = function()
    require'orgmode'.setup_ts_grammar() -- this seems to be very peculiar about ordering
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
  end }

  -- lualine

  use { 'nvim-lualine/lualine.nvim', config = function()
    require'lualine'.setup {
      options = {
        icons_enabled = false,
        theme = '16color',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
      },
      sections = { lualine_x = {} },
    }
  end }

  use 'wbthomason/packer.nvim'

  if packer_bootstrap then
    require'packer'.sync()
  end
end)
