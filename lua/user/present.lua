vim.w.presentation_mode = true

vim.wo.number = false
vim.wo.relativenumber = false

vim.go.laststatus = 0
vim.go.ruler = false
vim.go.showtabline = 0

vim.wo.cursorline = false
vim.wo.signcolumn = 'no'

vim.g.indent_blankline_enabled = false

vim.cmd [[echo]]

vim.keymap.set('n', '<Right>', ']a', { remap = true })
vim.keymap.set('n', '<Left>',  '[a', { remap = true })

vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha

local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup {
    dim_inactive = { enabled = true },
    custom_highlights = {
      MiniStatuslineModeInsert  = { bg = colors.sky, fg = colors.text },
      MiniStatuslineModeVisual  = { bg = colors.pink },
      MiniStatuslineModeReplace = { bg = colors.maroon },
      MiniStatuslineModeCommand = { bg = colors.yellow },
      MiniStatuslineModeOther   = { bg = colors.lavender },
    },
}

vim.cmd [[colorscheme catppuccin]]
