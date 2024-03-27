return {
	-- Draw ASCII diagrams in Neovim
	"jbyuki/venn.nvim",
	config = function()
		-- yoinked from https://github.com/jbyuki/venn.nvim?tab=readme-ov-file#using-toggle-command
		-- with some modifications

		function _G.Toggle_venn()
			if vim.b["venn_enabled"] == nil then
				vim.cmd([[let b:venn_enabled = 1]])
				vim.cmd([[setlocal ve=all]])
				-- draw a line on HJKL keystokes
				vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
				vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
				vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
				vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
				-- draw a box by pressing "f" with visual selection
				vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
			else
				vim.cmd([[setlocal ve=]])
				vim.cmd([[mapclear <buffer>]])
				vim.cmd([[unlet b:venn_enabled]])
			end
		end
		-- toggle keymappings for venn using <leader>tv
		vim.api.nvim_set_keymap("n", "<leader>tv", ":lua Toggle_venn()<CR>", { noremap = true })
	end,
}
