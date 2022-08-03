"" vim:ft=vim:fdm=marker

" more easily get out of the terminal {{{1
tnoremap <C-w><C-h> <C-\><C-N><C-w>h
tnoremap <C-w><C-j> <C-\><C-N><C-w>j
tnoremap <C-w><C-k> <C-\><C-N><C-w>k
tnoremap <C-w><C-l> <C-\><C-N><C-w>l

" turn off highlighting by hitting enter {{{1
nmap <silent> <CR> <cmd>nohlsearch<CR>
vmap <silent> <CR> <cmd>nohlsearch<CR>
augroup MappingNohl
  au!
  au CmdwinEnter * noremap <buffer><CR> <CR>
augroup END

" spell checking {{{1
nmap <silent> <leader>s :set spell!<CR>

" show invisibles {{{1
nmap <leader>l :set list!<CR>

" toggle ordinary color column {{{1
lua << EOF
local function toggle_color_column()
  if vim.wo.colorcolumn ~= "" then
    vim.wo.colorcolumn = ""
  else
    local cc = {}
    for i = 81,999 do
      table.insert(cc, i)
    end

    vim.wo.colorcolumn = table.concat(cc, ",")
  end
end
vim.keymap.set("n", "<leader>cc", toggle_color_column)
EOF

" change to directory of opened file {{{1
nmap <leader>cd :lcd %:h<CR>

" Unimpaired text bubbling {{{1
nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

" change behaviour of c-n c-p to more common-sense in command line {{{1
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" %% will expand to current dir in command mode {{{1
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" Y to bahave more sanely {{{1
nmap Y y$

" <leader>rb and <leader>so git signoffs {{{1
lua << EOF
local function insert_commit_tag(tag)
  local user_name  = vim.fn.trim(vim.fn.system("git config user.name"))
  local user_email = vim.fn.trim(vim.fn.system("git config user.email"))

  local line = vim.api.nvim_win_get_cursor(0)[1]

  local text = tag .. ": " .. user_name .. " <" .. user_email .. ">"
  vim.api.nvim_buf_set_lines(0, line, line, false, {text})
end

vim.keymap.set("n", "<leader>rb", function() insert_commit_tag("Reviewed-by") end)
vim.keymap.set("n", "<leader>so", function() insert_commit_tag("Signed-off-by") end)
vim.keymap.set("n", "<leader>ack", function() insert_commit_tag("Acked-by") end)
EOF

" <leader>ss for email signature {{{1
nmap <leader>ss o<CR>-- <CR>Cheers,<CR>Arek<ESC>

" redefine g] to use partial matches {{{1
nmap g] :ts /<C-R><C-W><CR>

" :PluginUpdate {{{1
lua << EOF
local function do_plugin_update()
  package.loaded['plugins'] = nil
  require'plugins'.sync()
end

vim.api.nvim_create_user_command('PluginUpdate', do_plugin_update, { force = true })
EOF

" <leader>ab for address book {{{1
lua << EOF
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local addrbook_picker = function()
  pickers.new({}, {
    prompt_title = "email address",
    finder = finders.new_oneshot_job({ "notmuch", "address", "*" }, opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection[1] }, "", false, true)
      end)
      return true
    end
  }):find()
end

vim.keymap.set('n', '<leader>ab', addrbook_picker)
EOF
