-- @crescentrose's neovim config ✨

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- use Mise shims when calling tools from nvim
-- see: https://mise.jdx.dev/getting-started.html#_2b-alternative-add-mise-shims-to-path
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- Basic setup {{{

require("options")

-- }}}

-- Custom keymaps {{{

require("keymaps")

-- }}}

-- Autocmds {{{

require("autocmds")

-- }}}

-- Integrations {{{

-- Support kitty's extended terminal codes (for italic, strikethrough etc.)
if vim.env.TERM == "xterm-kitty" then
	local configpath = vim.fn.stdpath("config") .. "/kitty.vim"
	vim.cmd("source " .. configpath)
end

-- }}}

-- Plugins {{{

-- Set up lazy.vim and configure plugins
require("bootstrap")
require("plugins.plugins")

-- Set up custom functions
require("custom")

-- }}}

-- Color scheme {{{

vim.cmd.colorscheme("catppuccin-macchiato")

-- }}}

-- vim: fdm=marker fdl=0
