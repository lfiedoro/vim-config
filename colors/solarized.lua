local base03    = { "#002b36", 8  }
local base02    = { "#073642", 0  }
local base01    = { "#586e75", 10 }
local base00    = { "#657b83", 11 }
local base0     = { "#839496", 12 }
local base1     = { "#93a1a1", 14 }
local base2     = { "#eee8d5", 7  }
local base3     = { "#fdf6e3", 15 }
local yellow    = { "#b58900", 3  }
local orange    = { "#cb4b16", 9  }
local red       = { "#dc322f", 1  }
local magenta   = { "#d33682", 5  }
local violet    = { "#6c71c4", 13 }
local blue      = { "#268bd2", 4  }
local cyan      = { "#2aa198", 6  }
local green     = { "#859900", 2  }

local none = { "NONE",    "NONE" }
local back = { base03[1], "NONE" }

local bold      = "bold"
local italic    = "italic"
local reverse   = "reverse"
local underline = "underline"
local undercurl = "undercurl"
local standout  = "standout"

local c = {
  -- core nvim
  Neutral    = { fg = base0 },
  Normal     = { fg = base0, bg = back },
  Comment    = { fg = base01, { italic } },
  Constant   = { fg = cyan },
  Identifier = { fg = blue },
  Statement  = { fg = green },
  PreProc    = { fg = orange },
  Type       = { fg = yellow },
  Special    = { fg = red },
  Underline  = { fg = violet },
  Ignore     = { fg = none },
  Error      = { fg = red, { bold } },
  Todo       = { fg = magenta, { bold } },
  SpecialKey = { fg = base00, bg = base02, { bold } },
  NonText    = { fg = base00, { bold } },

  StatusLine   = { fg = base1,  bg = base02, { reverse } },
  StatusLineNC = { fg = base00, bg = base02, { reverse } },
  Visual       = { fg = base01, bg = base03, { reverse } },

  Directory = { fg = blue },
  ErrorMsg  = { fg = red, { reverse } },

  Search    = { fg = yellow,  { standout } },
  IncSearch = { fg = magenta, { standout } },

  MoreMsg = { fg = blue },
  ModeMsg = { fg = blue },

  LineNr = { fg = base01, bg = base02 },
  Question = { fg = cyan, { bold } },

  VertSplit = { fg = base00, bg = base00 },

  Title = { fg = orange, { bold } },
  VisualNOS = { fg = none, bg = base02, { reverse, standout } },

  WarningMsg     = { fg = red, { bold } },
  WildMenu       = { fg = base2, bg = base01, { reverse } },
  Folded         = { fg = base0, bg = base02, { bold, underline } },
  FoldColumn     = { fg = base0, bg = base02 },

  DiffAdd        = { fg = green,  bg = base02, { bold } },
  DiffChange     = { fg = yellow, bg = base02, { bold } },
  DiffDelete     = { fg = red,    bg = base02, { bold } },
  DiffText       = { fg = blue,   bg = base02, { bold } },

  SignColumn     = { fg = base0 },

  Conceal        = { fg = blue, bg = none },

  SpellBad       = { fg = none, { undercurl } },
  SpellCap       = { fg = none, { undercurl } },
  SpellRare      = { fg = none, { undercurl } },
  SpellLocal     = { fg = none, { undercurl } },

  Pmenu          = { fg = base1,  bg = base02 },
  PmenuSel       = { fg = base2,  bg = magenta },
  PmenuSbar      = { fg = base0,  bg = base03 },
  PmenuThumb     = { fg = base03, bg = magenta },
  TabLine        = { fg = base0,  bg = base02, { underline } },
  TabLineFill    = { fg = base0,  bg = base02, { underline } },
  TabLineSel     = { fg = base01, bg = base2,  { underline } },
  CursorColumn   = { fg = none,   bg = base02 },
  CursorLine     = { fg = none,   bg = base02 },
  ColorColumn    = { fg = none,   bg = base02 },
  Cursor         = { fg = base03, bg = base0 },
  lCursors       = "Cursor",
  MatchParen     = { fg = red, bg = base01, { bold }},

  -- tree-sitter
  TSKeyword        = { fg = orange },
  TSPunctDelimiter = { fg = base1 },
  TSConstructor    = { fg = magenta },
  TSBoolean        = { fg = blue },
  TSFloat          = "TSBoolean",
  TSNumber         = "TSBoolean",
  TSField          = "Neutral",
  TSProperty       = "TSField",
  TSParameter      = "Neutral",
  TSPunctBracket   = "Neutral",

  -- telescope
  TelescopeSelection      = { fg = base3, bg = magenta, {bold} },
  TelescopeMultiSelection = { fg = base3, bg = violet },
  TelescopeBorder         = { fg = magenta },
  TelescopeSelectionCaret = { fg = magenta },
  TelescopePromptPrefix   = { fg = magenta },
  TelescopeMatching       = { fg = base1 },
  TelescopeTitle          = { fg = base2, {bold} },

  -- nvim-cmp
  CmpItemAbbr           = { fg = none },
  CmpItemAbbrDeprecated = { fg = magenta },
  CmpItemKind           = { fg = magenta },
  CmpItemAbbrMatch      = { fg = cyan },
  CmpItemAbbrMatchFuzzy = "CmpItemAbbrMatch",

  -- LSP
  DiagnosticError = { fg = red,    { bold } },
  DiagnosticWarn  = { fg = yellow, { bold } },
  DiagnosticInfo  = { fg = blue,   { bold } },
  DiagnosticHint  = { fg = violet, { bold } },

  -- mini.statusline
  MiniStatuslineModeNormal  = { fg = base2, bg = base01 },
  MiniStatuslineModeInsert  = { fg = base2, bg = blue },
  MiniStatuslineModeVisual  = { fg = base2, bg = magenta },
  MiniStatuslineModeReplace = { fg = base2, bg = red },
  MiniStatuslineModeCommand = { fg = base2, bg = yellow },
  MiniStatuslineModeOther   = { fg = base2, bg = violet },

  MiniStatuslineGitHead      = { fg = blue,   bg = base03 },
  MiniStatuslineGitAdded     = { fg = green,  bg = base03 },
  MiniStatuslineGitRemoved   = { fg = red,    bg = base03 },
  MiniStatuslineGitChanged   = { fg = yellow, bg = base03 },

  MiniStatuslineDiagnosticsError = { fg = red, bg = base02 },
  MiniStatuslineDiagnosticsWarn  = { fg = yellow, bg = base02 },
  MiniStatuslineDiagnosticsInfo  = { fg = blue, bg = base02 },
  MiniStatuslineDiagnosticsHint  = { fg = violet, bg = base02 },

  MiniStatuslineFilename     = { fg = base1, bg = base02 },
  MiniStatuslineLocation     = { fg = base1, bg = base02 },
  MiniStatuslineInactive     = { fg = base1, bg = base02 },

  -- mini.trailspace
  MiniTrailspace = "ErrorMsg"
}

if vim.g.colors_name then
  vim.cmd [[hi clear]]
end
vim.g.colors_name = 'solarized'

for group, raw_settings in pairs(c) do
  local settings = {}

  if type(raw_settings) == "string" then
    settings.link = raw_settings
    goto end_hl
  end

  settings.fg = raw_settings.fg[1]
  settings.ctermfg = raw_settings.fg[2]

  if not raw_settings.bg then raw_settings.bg = none end
  settings.bg = raw_settings.bg[1]
  settings.ctermbg = raw_settings.bg[2]

  for _, property in ipairs(raw_settings[1] or {}) do
    settings[property] = true
  end

  ::end_hl::

  vim.api.nvim_set_hl(0, group, settings)
end
