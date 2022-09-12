local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

local highligh_annotate_path = 'ivyl/highlight-annotate.nvim'
if vim.fn.isdirectory(vim.env.HOME .. '/src/highlight-annotate.nvim') == 1 then
  highligh_annotate_path =  '~/src/highlight-annotate.nvim'
end

return require('packer').startup(function(use)
  use { "catppuccin/nvim", as = "catppuccin" } -- for presentations

  use 'ivyl/vim-bling'
  use { highligh_annotate_path, config = function()
    require'highlight-annotate'.setup {
      mappings = { prev_annotation = "[v", next_annotation = "]v" }
    }
  end }

  use 'dhruvasagar/vim-table-mode'
  use 'tommcdo/vim-lion'

  use 'vim-scripts/matchit.zip'

  use 'lambdalisue/suda.vim'

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'

  use "tversteeg/registers.nvim"

  use { 'numToStr/Comment.nvim', config = function() require'Comment'.setup() end }

  use { 'kana/vim-textobj-indent', requires = {'kana/vim-textobj-user'}}
  use { 'kana/vim-textobj-entire', requires = {'kana/vim-textobj-user'}}
  use { 'kana/vim-textobj-underscore', requires = {'kana/vim-textobj-user'}}

  use { 'nmac427/guess-indent.nvim', config = function()
    require('guess-indent').setup {
      filetype_exclude = { "gitcommit" }
    }
  end }

  use { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup()
  end }

  use { 'lukas-reineke/indent-blankline.nvim', config = function()
    require'indent_blankline'.setup {
      char = '¦',
      use_treesitter = true,
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
      strict_tabs = true,
    }
  end }

  -- telescope

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-symbols.nvim'
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim', config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    vim.keymap.set('n', '<C-p>', function() builtin.find_files(themes.get_dropdown{previewer = false}) end)
    vim.keymap.set('n', '<C-A-P>', function() builtin.find_files(themes.get_dropdown{no_ignore = true, previewer = false}) end)
    vim.keymap.set('n', '<leader>fb', function() builtin.buffers(themes.get_dropdown{previewer=false}) end)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fw', builtin.grep_string)
    vim.keymap.set('n', '<leader>ft', builtin.tags)
    vim.keymap.set('n', '<leader>fs', function() builtin.symbols{sources={'emoji', 'math'}} end)

    telescope.setup { extensions =
      { fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case", } }
    }
    telescope.load_extension('fzf')
    telescope.load_extension('highlight-annotate')
    vim.keymap.set('n', '<leader>fa', telescope.extensions["highlight-annotate"].annotations)
  end }

  -- nvim-cmp

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use { 'hrsh7th/nvim-cmp', config = function()
    local cmp = require'cmp'

    cmp.setup({
      snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
      experimental = { ghost_text = true },
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
        { { name = 'nvim-lua' }, },
        { { name = 'buffer' }, })
    })
  end }

  -- lspconfig

  use { 'neovim/nvim-lspconfig', requires = {'hrsh7th/nvim-cmp'}, config = function()
    local opts = { silent=true }
    vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d',         vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, opts)

    local on_attach = function(client, bufnr)
      local caps = client.resolved_capabilities
      local bufopts = { silent=true, buffer=bufnr }

      if caps.declaration then
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      end
      if caps.goto_definition then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      end
      if caps.hover then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<A-k>', 'K', bufopts)
      end
      if caps.implementation then
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      end
      if caps.signature_help then
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
      end

      -- we don't have competing mappings for those below
      vim.keymap.set('n', '<leader>wa',  vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<leader>wr',  vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<leader>wl',  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
      vim.keymap.set('n', '<leader>D',   vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<leader>rn',  vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca',  vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr',          vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>fmt', vim.lsp.buf.formatting, bufopts)
    end

    local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

    local lspconfig = require'lspconfig'
    local servers = { 'clangd', 'pylsp', 'rust_analyzer', 'sumneko_lua', 'solargraph' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) }
          }
        }
      }
    end
  end }

  -- orgmode
  use {'akinsho/org-bullets.nvim', config = function()
    require('org-bullets').setup()
  end}

  use { 'nvim-orgmode/orgmode', config = function()
    require'orgmode'.setup({
      org_agenda_files = {'~/sync/org/*'},
      org_default_notes_file = '~/sync/org/refile.org',
      org_todo_keywords = {'TODO', 'WIP', '|', 'DONE'}
    })
  end }

  -- treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          node_decremental = '<c-backspace>',
        }
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = { ['<leader>p'] = '@parameter.inner' },
          swap_previous = { ['<leader>P'] = '@parameter.inner' },
        },
      },
    }
  end }

  use 'nvim-treesitter/playground'

  -- mini.bufremove && mini.trailspace && mini.statusline

  use { 'echasnovski/mini.nvim', config = function()
    vim.api.nvim_create_user_command("BD", function() require('mini.bufremove').delete(0, false) end, { force = true })

    require('mini.trailspace').setup {}

    require('mini.surround').setup {
      custom_surroundings = {
        ['('] = { output = { left = '( ', right = ' )' } },
        ['['] = { output = { left = '[ ', right = ' ]' } },
        ['{'] = { output = { left = '{ ', right = ' }' } },
        ['<'] = { output = { left = '< ', right = ' >' } },
      },
      mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',
      },
      search_method = 'cover_or_next',
    }

    -- Remap adding surrounding to Visual mode selection
    vim.keymap.del('x', 'ys')
    vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]])

    local MiniStatusline = require('mini.statusline')
    local active_content = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 50 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 999 }) -- always truncate
      local git = {}
      local diagnostics = {}

      if vim.b.gitsigns_status_dict then
        git.head = '  ' .. vim.b.gitsigns_status_dict.head
        for _, op in ipairs({ { 'added', '+' }, { 'removed', '-' }, { 'changed', '~' } }) do
          local value = vim.b.gitsigns_status_dict[op[1]]
          if value and value > 0 then
            git[op[1]] = op[2] .. tostring(value)
          end
        end
      end

      local diag_severities = {
        {'E', vim.diagnostic.severity.ERROR},
        {'W', vim.diagnostic.severity.WARN},
        {'I', vim.diagnostic.severity.INFO},
        {'H', vim.diagnostic.severity.HINT},
      }

      for _, diag in ipairs(diag_severities) do
        local count = #vim.diagnostic.get(0, {severity = diag[2]})
        if count > 0 then
          diagnostics[diag[1]] = diag[1] .. ':' .. tostring(count)
        end
      end

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                          strings = { mode } },
        { hl = 'MiniStatuslineGitHead',          strings = { git.head } },
        { hl = 'MiniStatuslineGitAdded',         strings = { git.added } },
        { hl = 'MiniStatuslineGitRemoved',       strings = { git.removed } },
        { hl = 'MiniStatuslineGitChanged',       strings = { git.changed } },
        { hl = 'MiniStatuslineDiagnosticsError', strings = { diagnostics.E } },
        { hl = 'MiniStatuslineDiagnosticsWarn',  strings = { diagnostics.W } },
        { hl = 'MiniStatuslineDiagnosticsInfo',  strings = { diagnostics.I } },
        { hl = 'MiniStatuslineDiagnosticsHint',  strings = { diagnostics.H } },
        '%<', '%=',
        { hl = 'MiniStatuslineFilename',         strings = { filename } },
      })
    end
    MiniStatusline.setup {
      content = {
        active = active_content,
        inactive = nil,
      },
      use_icons = false,
    }
  end }

  -- lua docs via :help
  use 'milisims/nvim-luaref'
  use 'nanotee/luv-vimdocs'

  -- self-manage
  use 'wbthomason/packer.nvim'

  if packer_bootstrap then
    require'packer'.sync()
  end
end)
