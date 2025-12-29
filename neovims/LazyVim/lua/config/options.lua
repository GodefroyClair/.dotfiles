-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local g = vim.g
local opt = vim.opt
--keymap globals
local map = vim.keymap.set

vim.o.list = true
vim.o.listchars = "tab:»·,trail:·,extends:→,precedes:←,nbsp:␣,eol:↲"

-- disable nvim intro
opt.shortmess:append "sI"

-- Global options
g.mapleader = " "
g.maplocalleader = " "
g.have_nerd_font = true
-- disable some default providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Line Wrapping
opt.wrap = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
vim.bo.softtabstop = 2

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmode = false
opt.laststatus = 3
opt.conceallevel = 2
vim.diagnostic.config({
  virtual_text = true, -- Disable virtual text
  signs = true,         -- Enable signs
  update_in_insert = false, -- Do not update diagnostics in insert mode
  underline = true,     -- Enable underline for diagnostics
  severity_sort = true, -- Sort diagnostics by severity
  float = {
    focusable = false,
    -- style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})


-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
-- Remove highlight after search
map("n", "<CR>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Undo file
opt.undofile = true

--- Move
-- go to previous/next line with h,l at end/beg of line
opt.whichwrap:append "[]hl"

-- vim.cmd("colorscheme catppuccin")
