-------------------------------------------------------------------------------
-- Colorschemes ---------------------------------------------------------------
-------------------------------------------------------------------------------

local CATPPUCCIN = {
	"catppuccin/nvim",
	name = "Catppuccin",
  opts = {
    custom_highlights = function(colors)
      return {
        ["@text.note"] = { fg = colors.blue, bg = colors.none },
        ["@text.todo"] = { fg = colors.yellow, bg = colors.none },
        ["@text.danger"] = { fg = colors.red, bg = colors.none },
      }
    end,
    integrations = {
      treesitter = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    }
  }
}

return { CATPPUCCIN }
