local TREESITTER = {
  'nvim-treesitter/nvim-treesitter',
  name = 'Treesitter',
  dependencies = { 
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      name = 'Treesitter Textobjects'
    },
  },
  config = function ()
    require('nvim-treesitter.configs').setup({
      ensure_installed = "all",
      matchup = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      autoinstall = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    })
  end,
}

local TSPLAYGROUND = {
	"nvim-treesitter/playground",
	name = 'treesitter playground',
	keys = {
		{ '<leader>ts', vim.cmd.TSPlaygroundToggle }
	}
}

return { TREESITTER, TSPLAYGROUND }
