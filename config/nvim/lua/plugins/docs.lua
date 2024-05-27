return {
	{
		-- Neovim DevDocs integration
		"luckasRanarison/nvim-devdocs",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local devdocs = require("nvim-devdocs")

			devdocs.setup({
				previewer_cmd = "glow",
				cmd_args = { "-s", "dark", "-w", "80" },
				picker_cmd = true,
				picker_cmd_args = { "-s", "dark", "-w", "80" },
				after_open = function(bufnr)
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {})
				end,
			})

			vim.keymap.set("n", "<leader>so", devdocs.open_doc_float, { desc = "[S]earch D[o]cs" })
		end,
	},
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
		ft = { "lua", "ruby", "rust" },
		config = function()
			vim.g.doge_enable_mappings = false
		end,
	},
}
