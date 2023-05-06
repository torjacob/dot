--= Space as Leader Key =--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.do_filetype_lua = 1
vim.g.tex_flavor = "latex"

--== Setting Options ==--
local config = {
  hidden = true, -- Enable hidden buffers
  pumheight = 10, -- Smaller Pop-Up Window
  termguicolors = true, -- Truecolor Support
  number = true, -- Show Linenumbers
  cursorline = true, -- Highlight Cursorline
  colorcolumn = '80', -- Show 80th column
  linebreak = true, -- Wrap Lines in Natural Place
  relativenumber = true, -- Show Relative Linenumbers
  splitbelow = true, -- Natural Splits
  splitright = true, -- Natural Splits
  tabstop = 2, -- Tab-Width
  shiftwidth = 2, -- Tab-Indent Width
  expandtab = true, -- Convert Tabs to Spaces
  smartindent = true, -- Automatically Adds Extra Indents
  conceallevel = 0, -- Visible '' in Markdown
  updatetime = 100, -- Async Updates
  scrolloff = 4, -- Min. Amount of Lines Around Cursor
  backup = false,
  writebackup = false,
  showmode = false,
  swapfile = false,
  mouse = "a",
  smartcase = true,
  background = "dark",
  laststatus = 3, -- Global statusbar
  cmdheight = 0,
  statuscolumn = "%{v:relnum?v:relnum:v:lnum}",
}


--== Applying Options ==--
for k, v in pairs(config) do
	vim.opt[k] = v
end

--== Set Default Opts for Keymap ==--
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

--= Better Tabbing =--
map("v", "<", "<gv")
map("v", ">", ">gv")

--= Use alt + hjkl to resize windows =--
map("n", "<M-j>", ":resize -2<CR>")
map("n", "<M-k>", ":resize +2<CR>")
map("n", "<M-l>", ":vertical resize -2<CR>")
map("n", "<M-h>", ":vertical resize +2<CR>")

--== Use alt + H / V to add splits =--
map("n", "<M-H>", ":new<CR>")
map("n", "<M-V>", ":vnew<CR>")

--= Plugin Manager =--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

--== Colorscheme ==--
vim.cmd.colorscheme 'catppuccin-mocha'

