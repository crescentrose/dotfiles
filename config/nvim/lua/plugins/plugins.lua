require("lazy").setup({

	-- Theme {{{

	-- 🍨 Soothing pastel theme for (Neo)vim
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local catppuccin = require("catppuccin")
			catppuccin.setup({
				integrations = {
					notify = true,
					which_key = true,
				},
				flavour = "frappe",
			})
		end,
	},

	-- }}}

	-- Editing {{{

	-- surround.vim: quoting/parenthesizing made simple
	"tpope/vim-surround",
	-- commentary.vim: comment stuff out
	"tpope/vim-commentary",
	-- fugitive.vim: A Git wrapper so awesome, it should be illegal
	"tpope/vim-fugitive",
	-- repeat.vim: enable repeating supported plugin maps with "."
	"tpope/vim-repeat",
	-- A minimalist Neovim plugin that auto pairs & closes brackets
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup({
				options = {
					pair_spaces = true,
				},
			})
		end,
	},
	-- }}}

	-- UI {{{

	-- Sidebar / tree
	require("plugins.tree"),
	-- Status line
	require("plugins.statusline"),
	-- Greeter / dashboard
	require("plugins.greeter"),
	-- Notifications
	require("plugins.notifications"),
	-- Focus
	require("plugins.focus"),
	-- Tabs
	require("plugins.tabs"),
	-- Show block end annotations
	require("plugins.biscuits"),
	-- }}}

	-- Search {{{

	-- Fuzzy finder
	require("plugins.telescope"),
	-- Search UI
	require("plugins.search"),

	-- }}}

	-- Language support {{{

	-- LSP
	require("plugins.lsp"),

	-- Parsing
	require("plugins.treesitter"),

	-- Completion
	require("plugins.completion"),

	-- Auto formatting
	require("plugins.format"),

	-- Hints
	require("plugins.hints"),

	-- Outline
	require("plugins.outline"),

	-- Rust
	require("plugins.rust"),

	-- Go
	require("plugins.go"),

	-- Nushell
	require("plugins.nu"),

	-- JSON Schemas
	require("plugins.json"),

	-- Snippet plugin for Neovim written in Lua
	"dcampos/nvim-snippy",

	-- nvim-snippy completion source for nvim-cmp.
	"dcampos/cmp-snippy",

	-- Set of preconfigured snippets for different languages.
	"rafamadriz/friendly-snippets",

	-- Run snippets of code
	require("plugins.sniprun"),

	-- }}}

	-- Git {{{

	require("plugins.git"),

	-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
	"sindrets/diffview.nvim",

	-- }}}

	-- Debugging {{{

	-- Debugging protocol
	require("plugins.dap"),

	-- Diagnostics list
	require("plugins.diagnostics"),

	-- Show todos with diagnostics
	require("plugins.todo"),

	-- Task runner
	require("plugins.runner"),

	-- }}}

	-- Fun {{{

	-- NeoVim plugin with which you can track the time you spent on files, projects, repos, filetypes
	{
		"gaborvecsei/usage-tracker.nvim",
		event = "VeryLazy",
		config = function()
			require("usage-tracker").setup({})
		end,
	},

	-- Draw ASCII diagrams in Neovim
	"jbyuki/venn.nvim",

	-- }}}

	-- Documentation {{{

	-- Document which keys do what
	require("plugins.keymap"),

	-- Documentation for every language ever
	require("plugins.devdocs"),

	-- }}}
})

-- vim: fdm=marker fdl=0
