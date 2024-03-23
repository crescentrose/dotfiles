-- A task runner and job management plugin for Neovim
return {
	"stevearc/overseer.nvim",
	event = "VeryLazy",
	config = function()
		require("overseer").setup({ dap = false })

		vim.keymap.set("n", "<A-2>", ":OverseerToggle<CR>", { desc = "Toggle Overseer" })

		vim.keymap.set("n", "<leader>r", ":OverseerRun<CR>", { desc = "[R]un" })
	end,
}
