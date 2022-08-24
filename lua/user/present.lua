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

package.loaded['user.present'] = nil
