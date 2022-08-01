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
hi ColorColumn  ctermbg=Black
let g:color_column_toggle = 0
function! ColorColumnToggle()
  if g:color_column_toggle
    set colorcolumn=
    let g:color_column_toggle = 0
  else
    let &colorcolumn=join(range(81,999),",")
    let g:color_column_toggle = 1
  end
endfunc
nmap <silent> <leader>cc :call ColorColumnToggle()<CR>

" change to directory of opened file {{{1
nmap <leader>cd :lcd %:h<CR>

" toggle relative/normal line numbering {{{1
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nmap <silent> <leader>n :call NumberToggle()<CR>

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

" :ColorBG {{{1
highlight ColorBGred ctermbg=red
highlight ColorBGbrown ctermbg=brown
highlight ColorBGwhite ctermbg=white
highlight ColorBGyellow ctermbg=yellow
highlight ColorBGmagenta ctermbg=magenta
highlight ColorBGcyan ctermbg=cyan
highlight ColorBGgreen ctermbg=green
highlight ColorBGblue ctermbg=blue
highlight ColorBGdarkgray ctermbg=darkgray
highlight ColorBGgray ctermbg=gray
highlight ColorBGdarkmagenta ctermbg=darkmagenta
highlight ColorBGdarkmagenta ctermbg=darkmagenta
highlight ColorBGdarkred ctermbg=darkred
highlight ColorBGdarkcyan ctermbg=darkcyan
highlight ColorBGdarkgreen ctermbg=darkgreen
highlight ColorBGdarkblue ctermbg=darkblue
highlight ColorBGblack ctermbg=black

let g:colorbg_matches = []

function s:ColorBgNames(A,L,P)
  return "red\nbrown\nwhite\nyellow\nmagenta\ncyan\ngreen\nblue\ndarkgray\ngray\ndarkmagenta\ndarkmagenta\ndarkred\ndarkcyan\ndarkgreen\ndarkblue\nblack"
endfunction

function! s:ColorBG(color)
  let pattern = getreg('/')
  let match = matchadd('ColorBG'.a:color, pattern)
  call add(g:colorbg_matches, match)
endfunction
command! -complete=custom,s:ColorBgNames -nargs=* ColorBG call s:ColorBG(<q-args>)

function! s:ColorBGRemoveLast()
  if len(g:colorbg_matches) > 0
    let match = g:colorbg_matches[-1]
    let g:colorbg_matches = g:colorbg_matches[:-2]
    call matchdelete(match)
  endif
endfunction
command! -nargs=0 ColorBGRemoveLast call s:ColorBGRemoveLast()

function! s:ColorBGRemoveAll()
  for m in g:colorbg_matches
    call matchdelete(m)
  endfor
  let g:colorbg_matches = []
endfunction
command! -nargs=0 ColorBGRemoveAll call s:ColorBGRemoveAll()

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
"
function! s:PluginUpdate()
  lua package.loaded['plugins'] = nil
  lua require'plugins'
  :PackerSync
endfunction
command! -nargs=0 PluginUpdate call s:PluginUpdate()

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
