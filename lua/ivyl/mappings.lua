local silent = { silent = true }
local buffer = { buffer = true }
local expr   = { expr = true }

local function toggle_wo(name)
  return function()
    vim.wo[name] = not vim.wo[name]
  end
end

-- terminal: <C-w><C-direction> - escape terminal and switch window
vim.keymap.set("t", "<C-w><C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w><C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w><C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w><C-l>", "<C-\\><C-n><C-w>l")


-- <CR> - turn off hlsearch
vim.keymap.set({ "n", "v" }, "<CR>", "<CMD>nohlsearch<CR>", silent)
vim.api.nvim_create_autocmd("CmdwinEnter", {
  group    = vim.api.nvim_create_augroup("cmd-no-nohl", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", buffer)
  end
})

-- <Leader>s - toggle spellchecking
vim.keymap.set("n", "<Leader>s", toggle_wo("spell"), silent)

-- <Leader>n - toggle invisibles
vim.keymap.set("n", "<Leader>l", toggle_wo("list"), silent)

-- <Leader>cc - toggle color column
local function toggle_color_column()
  if vim.wo.colorcolumn ~= "" then
    vim.wo.colorcolumn = ""
  else
    local cc = {}
    for i = 81,999 do table.insert(cc, i) end
    vim.wo.colorcolumn = table.concat(cc, ",")
  end
end
vim.keymap.set("n", "<leader>cc", toggle_color_column)

-- <C-direction> - text bubbling with - uses unimpaired
vim.keymap.set("n", "<C-k>", "[e")
vim.keymap.set("n", "<C-j>", "]e")
vim.keymap.set("v", "<C-k>", "[egv")
vim.keymap.set("v", "<C-j>", "]egv")

-- command-mode: change behaior of <C-n> <C-p> to use the already typed text
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- command-mode: expand %% to curent file's dir
vim.keymap.set("c", "%%", function()
  if vim.fn.getcmdtype() == ":" then
    return vim.fn.expand("%:p:h") .. "/"
  else
    return "%%"
  end
end, expr)

-- <Leader>rb, <Leader>so, <Leader>ack - insert git commit tags (Signed-off-by, etc)
local function insert_commit_tag(tag)
  local user_name  = vim.fn.trim(vim.fn.system("git config user.name"))
  local user_email = vim.fn.trim(vim.fn.system("git config user.email"))
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local text = tag .. ": " .. user_name .. " <" .. user_email .. ">"
  vim.api.nvim_buf_set_lines(0, line, line, false, {text})
end
vim.keymap.set("n", "<Leader>rb", function() insert_commit_tag("Reviewed-by") end)
vim.keymap.set("n", "<Leader>so", function() insert_commit_tag("Signed-off-by") end)
vim.keymap.set("n", "<Leader>ack", function() insert_commit_tag("Acked-by") end)

-- <Leader>ss - sign the message
vim.keymap.set("n", "<Leader>ss", function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, line, line, false, { "-- ", "Cheers,", "Arek" })
end)

-- g] - remap to use partial matches
vim.keymap.set("n", "]g", ":ts /<C-r><C-w><CR>")

-- :PluginUpdate
vim.api.nvim_create_user_command('PluginUpdate', function ()
  package.loaded['ivyl.plugins'] = nil
  require'ivyl.plugins'.sync()
end, { force = true })

-- <Leader>ab - address book
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
vim.keymap.set('n', '<leader>ab', function()
  pickers.new({}, {
    prompt_title = "email address",
    finder = finders.new_oneshot_job({ "notmuch", "address", "*" }, {}),
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection[1] }, "", false, true)
      end)
      return true
    end
  }):find()
end)
