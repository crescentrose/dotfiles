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
	-- Neovim Lua plugin to automatically manage character pairs.
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		keys = {
			{
				"<leader>tp",
				function()
					vim.g.minipairs_disable = not vim.g.minipairs_disable
				end,
				desc = "Toggle Auto Pairs",
			},
		},
	},
	-- }}}

	-- UI {{{

	-- Sidebar / tree
	require("plugins.tree"),
	-- Status line
	require("plugins.statusline"),
	-- Greeter / dashboard
	require("plugins.greeter"),
	-- Focus
	require("plugins.focus"),
	-- Tabs
	require("plugins.tabs"),
	-- Select/Input
	require("plugins.dressing"),
	-- 💫 Extensible UI for Neovim notifications and LSP progress messages.
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				override_vim_notify = true,
				window = {
					normal_hl = "Bold",
				},
			},
		},
	},

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

	-- Vim syntax highlighting for Kitty terminal config files
	{
		"fladson/vim-kitty",
		ft = "kitty",
	},

	-- basic vim/terraform integration
	{
		"hashivim/vim-terraform",
		ft = "terraform",
	},

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
