require("lazy").setup({
	-- Theme {{{

	-- 🍨 Soothing pastel theme for (Neo)vim
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					which_key = true,
				},
			})
		end,
	},
	-- A Neovim plugin for macOS, Linux & Windows that automatically changes the editor appearance
	-- based on system settings.
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			set_dark_mode = function()
				vim.cmd.colorscheme("catppuccin-macchiato")
				require("lazy").reload({ plugins = { "tabby.nvim" } })
			end,
			set_light_mode = function()
				vim.cmd.colorscheme("catppuccin-latte")
				require("lazy").reload({ plugins = { "tabby.nvim" } })
			end,
			fallback = "light",
		},
	},

	-- }}}

	-- Editing {{{

	-- surround.vim: quoting/parenthesizing made simple
	"tpope/vim-surround",
	-- commentary.vim: comment stuff out
	"tpope/vim-commentary",
	-- repeat.vim: enable repeating supported plugin maps with "."
	"tpope/vim-repeat",
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

	-- JSON Schemas
	require("plugins.json"),

	-- Neovim development
	require("plugins.nvim"),

	-- Markdown
	require("plugins.markdown"),

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
