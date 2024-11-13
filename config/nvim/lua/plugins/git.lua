return {
	-- Git integration for buffers
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufReadPost",
		cmd = "Gitsigns",
		config = function()
			require("gitsigns").setup({
				on_attach = function()
					vim.keymap.set(
						"n",
						"<leader>gh",
						"<Cmd>Gitsigns toggle_linehl<cr>",
						{ desc = "[G]it: [H]ighlight Changes" }
					)
					vim.keymap.set(
						"n",
						"<leader>gp",
						"<Cmd>Gitsigns preview_hunk_inline<cr>",
						{ desc = "[G]it: [P]review Hunk" }
					)
					vim.keymap.set("n", "<leader>gb", "<Cmd>Gitsigns blame_line<cr>", { desc = "[G]it: [B]lame Line" })
					vim.keymap.set("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<cr>", { desc = "[G]it: [R]eset Hunk" })
				end,
			})
		end,
	},
	-- A blazingly fast, stunningly beautiful, exceptionally powerful git branch viewer for
	-- Vim/Neovim.
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
		init = function()
			vim.keymap.set("n", "<leader>gl", "<Cmd>Flog<cr>", { desc = "[G]it: [L]og" })
		end,
	},
}
