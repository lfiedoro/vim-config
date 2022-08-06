local au_group = vim.api.nvim_create_augroup("init.lua", { clear = true })

vim.cmd [[colorscheme solarized]]

-- use space as a leader
vim.g.mapleader = " "

-- show relative line numbers in each window
-- and use number column for signs
vim.o.number          = true
vim.wo.relativenumber = true
vim.wo.signcolumn     = 'number'
vim.api.nvim_create_autocmd("WinEnter", {
  group    = au_group,
  callback = function()
    vim.wo.relativenumber = true
    vim.wo.signcolumn     = 'number'
  end
})

-- for extra safety don't execute modlines
vim.o.modeline = false

-- how to display the invisible things with :list
vim.o.listchars = "tab:▸ ,eol:¬"

-- highlight the line with the cursor
vim.o.cursorline = true

-- try to keep extra 8 lights below/above the cursor on the screen
vim.o.scrolloff = 8

-- don't display the :intro
vim.opt.shortmess:append("I")

-- don't beep on me
vim.o.visualbell = true

-- :vsp and :sp behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- don't redraw while executing macros, etc.
vim.o.lazyredraw = true

-- virutal editing (characters that do not exist) in the block mode
vim.o.virtualedit = "block"

-- when changing (normal c) put $ on word boundary and keep it visible
vim.opt.cpoptions:append("$")

-- allow switching between buffers without saving
vim.o.hidden = true

-- friendlier, magic regexps
vim.o.magic = true

-- search incrementally, with highlighting and preview
vim.o.hlsearch = true
vim.o.incsearch = true

-- enable smartcase = ignorecase if there are no uppercase chars
vim.o.ignorecase = true
vim.o.smartcase = true

-- when inserting a bracket - flash the matching one
vim.o.showmatch = true
vim.opt.matchpairs:append("<:>")

-- don't wrap displayed text
vim.o.wrap = false

-- don't create a backup when overwritting or the swapfile
vim.o.writebackup = false
vim.o.swapfile = false

-- resize splits to equal size when resizing vim
vim.api.nvim_create_autocmd("VimResized", {
  group = au_group,
  callback = function()
    vim.cmd [[wincmd =]]
  end
})

-- jump to last know position in the file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = au_group,
  callback = function() vim.cmd [[silent! normal! g`"]] end
})

-- use tags file from the git dir
local function set_tags_for_buffer()
  local buf_dir = vim.fn.expand("%:h")
  if buf_dir == "" then buf_dir = "." end

  local git_dir = vim.fn.system("git -C " .. buf_dir .. " rev-parse --git-dir")

  if vim.v.shell_error == 0 then
    vim.bo.tags = "./tags;,tags," .. vim.fn.trim(git_dir) .. "/tags"
  end
end

set_tags_for_buffer() -- for the initial buffer

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = au_group,
  callback = set_tags_for_buffer
})

-- auto-sync plugins after editing plugins.lua
vim.api.nvim_create_autocmd("BufWritePost", {
  group = au_group,
  pattern = "plugins.lua",
  callback = function()
    package.loaded['plugins'] = nil
    require 'plugins'.sync()
  end
})

-- blink the yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = au_group,
  callback = function() vim.highlight.on_yank { on_visual = false } end
})

vim.cmd [[runtime mappings.vim]]
vim.cmd [[runtime filetypes.vim]]
