local LSP_ZERO = {
  'VonHeikemen/lsp-zero.nvim',
  name = 'LSP Zero',
  branch = 'v2.x',
  dependencies = {
    { 'neovim/nvim-lspconfig', name = 'LSP Config', },
    {
      'williamboman/mason.nvim',
      name = 'Mason',
      build = function ()
        pcall(vim.cmd, 'MasonUpdate')
      end,
      dependencies = {
        { 'williamboman/mason-lspconfig.nvim', name = 'Mason LSP Config', },
      },
    },
    {
      'hrsh7th/nvim-cmp',
      name = 'Cmp',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp', name = 'Cmp LSP', },
      },
    },
    { 'L3MON4D3/LuaSnip', name = 'LuaSnip', },
  },
  config = function ()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
  end
}

return { LSP_ZERO }
