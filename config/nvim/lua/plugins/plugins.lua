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
	-- repeat.vim: enable repeating supported plugin maps with "."
	"tpope/vim-repeat",
	-- A minimalist Neovim plugin that auto pairs & closes brackets
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup({
				keys = {
					["`"] = { escape = false, close = false, pair = "``", disabled_filetypes = {} },
					["'"] = { escape = false, close = false, pair = "''", disabled_filetypes = {} },
				},
				options = {
					pair_spaces = true,
					disabled_filetypes = { "text", "markdown" },
					disable_when_touch = true,
					touch_regex = "[%w(%[{]",
					disable_command_mode = true,
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

	-- Run snippets of code
	require("plugins.sniprun"),

	-- }}}

	-- Git {{{

	-- fugitive.vim: A Git wrapper so awesome, it should be illegal
	"tpope/vim-fugitive",

	-- Git signs
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

	-- Documentation {{{

	-- Document which keys do what
	require("plugins.keymap"),

	-- Language and code documentation
	require("plugins.docs"),

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

	require("plugins.diagrams"),

	-- }}}
})

-- vim: fdm=marker fdl=0
