-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()

local transparent = require('transparent')

transparent.setup {
  extra_groups = {
    "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
    "NeoTreeNormal",
    "NeoTreeNormalNC",
  },
}

transparent.clear_prefix('NeoTree')

require('neo-tree').setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  window = {
    position = "left",
    width = 27,
  }
})

