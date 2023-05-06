-------------------------------------------------------------------------------
-- UI Related Plugins ---------------------------------------------------------
-------------------------------------------------------------------------------

local DEADCOLUMN = {
  'Bekaboo/deadcolumn.nvim',
  name = "Deadcolumn",
  event = "VeryLazy",
}

local DRESSING = {
  "stevearc/dressing.nvim",
  name = "Dressing",
  event = "VeryLazy",
}

local FIDGET = {
  'j-hui/fidget.nvim',
  name = "Fidget",
  event = "VeryLazy",
}

local LUALINE = {
  "nvim-lualine/lualine.nvim",
  name = "Lualine",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", name = "Devicons" },
    { "catppuccin/nvim", name = "Catppuccin" },
  },
  config = function ()
    local lualine = require('lualine')
    local m = require("catppuccin.palettes").get_palette "mocha"
    local colors = {
      bg       = m.mantle,
      fg       = m.text,
      yellow   = m.yellow,
      cyan     = m.sapphire,
      darkblue = m.blue,
      green    = m.green,
      orange   = m.peach,
      violet   = m.mauve,
      magenta  = m.pink,
      blue     = m.blue,
      red      = m.red,
    }
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }
    local evil_config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }
    local function ins_left(component)
      table.insert(evil_config.sections.lualine_c, component)
    end
    local function ins_right(component)
      table.insert(evil_config.sections.lualine_x, component)
    end
    local function colormode()
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      return { fg = mode_color[vim.fn.mode()] }
    end

    ins_left({
      function()
        return '█'
      end,
      color = colormode,
      padding = { left = 0, right = 1 },
    })

    ins_left({
      -- mode component
      function()
        return '' -- 
      end,
      color = colormode,
      padding = { right = 0 },
    })

    ins_left({
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.fg },
    })

    ins_left({
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.fg },
    })

    ins_left({ 'location', color = { fg = colors.fg } })

    ins_left({ 'progress', color = { fg = colors.fg, gui = 'bold' } })

    ins_left({
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return '%='
      end,
    })


    ins_left({
      -- Lsp server name .
      function()
        local msg = 'Kein LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = '󰚩', -- '',
      color = { fg = colors.fg, gui = 'bold' },
    })

    ins_right({
      'filetype',
      fmt = string.upper,
      icons_enabled = true,
      color = function() local icon, color = require'nvim-web-devicons'.get_icon_color(vim.fn.expand("%"), vim.bo.filetype) return { fg = color } end,
    })
    ins_right({
      'o:encoding',
      fmt = string.upper,
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = 'bold' },
    })
    ins_right({
      'fileformat',
      fmt = string.upper,
      icons_enabled = false,
      color = { fg = colors.orange, gui = 'bold' },
    })

    ins_right({
      'branch',
      icon = '',
      fmt = string.upper,
      color = { fg = colors.violet, gui = 'bold' },
    })

    ins_right({
      'diff',
      symbols = { added = ' ', modified = '柳 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    ins_right({
      function()
        return '█'
      end,
      color = colormode,
      padding = { left = 0 },
    })

    lualine.setup(evil_config)
  end,
  event = "VeryLazy",
}

local INDENT_BLANKLINE = {
  'lukas-reineke/indent-blankline.nvim',
  name = 'Indent Blankline',
}

local INCLINE = {
  'b0o/incline.nvim',
  name = 'Incline',
  cmd = { ':vsplit', ':split' },
  config = function()
    require('incline').setup({
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        return { { icon, guifg = color }, { " " }, { filename } }
      end,
      window = { margin = { horizontal = 0, vertical = 0 } }
    })
  end,
}

local BARBECUE = {
  "utilyre/barbecue.nvim",
  name = "Barbecue",
  version = "*",
  dependencies = {
    { "SmiteshP/nvim-navic", name = "Navic" },
    { "nvim-tree/nvim-web-devicons", name = "Devicons" }
  },
  opts = {},
}


return {
  DEADCOLUMN,
  DRESSING,
  FIDGET,
  LUALINE,
  INDENT_BLANKLINE,
  -- INCLINE,
  -- BARBECUE,
}
