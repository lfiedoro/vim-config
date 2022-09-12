local parser =  vim.treesitter.get_parser(0)
local trees = parser:parse()
local root = trees[1]:root()
local slides = {}

for i = 0, root:named_child_count() - 1 do
  local node = root:named_child(i)
  local text = vim.treesitter.query.get_node_text(node, 0)
  table.insert(slides, text)
end

table.insert(slides, " THE END")

local buf = vim.api.nvim_create_buf(true, true)
vim.api.nvim_buf_set_name(buf, 'presentation')
vim.api.nvim_win_set_buf(0, buf)

local function set_slide(nr)
  vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(slides[nr], '\n'))
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'org')
end

local current_slide = 1
set_slide(current_slide)

-- style

vim.g.catppuccin_flavour = "latte"
vim.cmd [[colorscheme catppuccin]]
vim.g.indent_blankline_enabled = false
require('zen-mode').open()

-- restore style

local function restore_style()
    require('zen-mode').close()
    require('mini.bufremove').delete(buf, true)

    vim.g.indent_blankline_enabled = true
    vim.cmd [[colorscheme solarized]]
    vim.g.termguicolors = false
end

-- mappings

vim.keymap.set('n', 'n', function()
  if current_slide == #slides then
    restore_style()
    return
  end

  current_slide = current_slide + 1
  set_slide(current_slide)
end,
{ buffer = buf }
)

vim.keymap.set('n', 'p', function()
  if current_slide == 1 then return end
  current_slide = current_slide - 1
  set_slide(current_slide)
end,
{ buffer = buf }
)
