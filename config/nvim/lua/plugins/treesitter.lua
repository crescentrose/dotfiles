-- Nvim Treesitter configurations and abstraction layer
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				"go",
				"lua",
				"ruby",
				"python",
				"rust",
				"tsx",
				"yaml",
				"html",
				"css",
				"sql",
				"dockerfile",
				"gitignore",
				"javascript",
				"typescript",
				"vimdoc",
				"vim",
				"nix",
				"nu",
				-- Linux devs standardise on one config language challenge (turbo-mega-impossible)
				"ron",
				"kdl",
				"rasi",
			},

			-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
			auto_install = false,
			-- Install languages synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- List of parsers to ignore installing
			ignore_install = {},
			-- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
			modules = {},
			highlight = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-return>",
					node_incremental = "<c-return>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-return>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>pa"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>pA"] = "@parameter.inner",
					},
				},
			},

			-- Use HTML syntax highlighting in Handlebars files
			-- TODO: we might use hbs files for non-HTML languages, what then?
			vim.treesitter.language.register("html", "handlebars"),
		})

		-- Use Treesitter for folding
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "nvim_treesitter#foldexpr()"
		vim.o.foldenable = false
	end,
}
