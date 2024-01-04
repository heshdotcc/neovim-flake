local theme = require('github-theme')

theme.setup({
  options = {
    dim_inactive = true,
    transparent = true,
    sidebars = {
      'neo-tree',
    },
  },
  groups = {
    github_dark_default = {
      LineNr = { fg = 'ff0000' },
    },
  },
})

--vim.cmd("highlight lualine_c_inactive guibg=NONE")
--vim.g.highlight_color_line_number = "#55555"
