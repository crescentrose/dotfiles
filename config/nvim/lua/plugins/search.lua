return {
	-- An effective way to juggle monorepos in neovim
	{
		"imNel/monorepo.nvim",
		config = function()
			require("monorepo").setup({})

			vim.keymap.set("n", "<leader>mn", function()
				require("telescope").extensions.monorepo.monorepo()
			end, {
				desc = "Monorepo: Switch project",
			})

			vim.keymap.set("n", "<leader>ma", function()
				require("monorepo").add_project()
			end, {
				desc = "Monorepo: Add project",
			})

			vim.keymap.set("n", "<leader>md", function()
				require("monorepo").remove_project()
			end, {
				desc = "Monorepo: Remove project",
			})
		end,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	-- nvim plugin that adds tabs for telescope search
	{
		"FabianWirth/search.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = true,
		keys = { "<S-D-p>", "<C-p>" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local search = require("search")
			search.setup({
				tabs = {
					{
						"Files",
						builtin.find_files,
					},
					{
						"Monorepo",
						telescope.extensions.monorepo.monorepo,
					},
					{
						"Text",
						builtin.live_grep,
					},
					{
						"Symbols",
						builtin.lsp_dynamic_workspace_symbols,
						available = function()
							return #vim.lsp.get_clients() > 0 -- only if a LSP is connected
						end,
					},
					{
						"Registers",
						builtin.registers,
					},
					{
						"Help",
						builtin.help_tags,
					},
				},
			})

			vim.keymap.set({ "n" }, "<S-D-p>", search.open, { desc = "[󰘳-󰘶-p] Search" })
			vim.keymap.set({ "n" }, "<C-p>", search.open, { desc = "[󰘴-p] Search" })
		end,
	},
}
