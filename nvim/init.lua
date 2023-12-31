local cmd = vim.cmd
local fn = vim.fn
local opt = vim.o
local g = vim.g

-- <leader> key. Defaults to `\`. Some people prefer space.
-- g.mapleader = ' '
-- g.maplocalleader = ' '

cmd.syntax('on')
cmd.syntax('enable')
opt.compatible = false

-- Enable true colour support
if fn.has('termguicolors') then
  opt.termguicolors = true
end

-- See :h <option> to see what the options do

-- Search down into subfolders
opt.path = vim.o.path .. '**'

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.lazyredraw = true
opt.showmatch = true -- Highlight matching parentheses, etc
opt.incsearch = true
opt.hlsearch = true

opt.spell = true
opt.spelllang = 'en'

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.foldenable = true
opt.history = 2000
opt.nrformats = 'bin,hex' -- 'octal'
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.cmdheight = 0

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Configure Neovim diagnostic messages

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end

local sign = function(opts)
  fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = '',
  })
end
-- Requires Nerd fonts
sign { name = 'DiagnosticSignError', text = '󰅚' }
sign { name = 'DiagnosticSignWarn', text = '⚠' }
sign { name = 'DiagnosticSignInfo', text = 'ⓘ' }
sign { name = 'DiagnosticSignHint', text = '󰌶' }

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      if severity == vim.diagnostic.severity.ERROR then
        return prefix_diagnostic('󰅚', diagnostic)
      end
      if severity == vim.diagnostic.severity.WARN then
        return prefix_diagnostic('⚠', diagnostic)
      end
      if severity == vim.diagnostic.severity.INFO then
        return prefix_diagnostic('ⓘ', diagnostic)
      end
      if severity == vim.diagnostic.severity.HINT then
        return prefix_diagnostic('󰌶', diagnostic)
      end
      return prefix_diagnostic('■', diagnostic)
    end,
  },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

g.editorconfig = true

vim.opt.colorcolumn = '100'

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')

vim.g.skip_ts_context_commentstring_module = true

cmd('colorscheme github_dark_default')

g.transparent_enabled = true

--[[
local alpha = require('alpha')
local dashboard = require("alpha.themes.dashboard")
-- Set header
dashboard.section.header.opts = {
    hl = "Text", position = "center"
}
dashboard.section.header.val = {
    "ooooo      ooo              o8o                     ",
    "`888b.     `8'              `\"'                    ",
    " 8 `88b.    8  oooo    ooo oooo  ooo. .oo.  .oo.    ",
    " 8   `88b.  8   `88.  .8'  `888  `888P\"Y88bP\"Y88b ",
    " 8     `88b.8    `88..8'    888   888   888   888   ",
    " 8       `888     `888'     888   888   888   888   ",
    "o8o        `8      `8'     o888o o888o o888o o888o  ",
}
-- Set menu
dashboard.section.header.opts = {
    hl = "Text", position = "center"
}
dashboard.section.buttons.val = {
    dashboard.button( "f", "New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button( "s", "Search",   ":cd $HOME/work | Telescope find_files<CR>"),
    dashboard.button( "r", "Recent",   ":Telescope oldfiles<CR>"),
    dashboard.button( "e", "Exit",     ":qa<CR>"),
}
-- Send config to alpha
alpha.setup(dashboard.opts)
]]--

vim.g.mapleader = "<Space><Space>"

vim.api.nvim_set_keymap("n", "<Space><Space>b", ":Neotree<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space><Space>r", ":luafile %<CR>", { noremap = true, silent = true })

-- TODO: Navigate buffers easily, copy content among them
--[[
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.nvim_exec("normal! g'\"",false)
        end
    end
})
]]--

-- Preserve cursor position for each file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
})
