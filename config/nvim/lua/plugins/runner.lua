-- A task runner and job management plugin for Neovim
return {
	"stevearc/overseer.nvim",
	event = "VeryLazy",
	config = function()
		require("overseer").setup({
			templates = { "builtin" },
			dap = false,
			task_list = {
				bindings = {
					["?"] = "ShowHelp",
					["g?"] = "ShowHelp",
					["<CR>"] = "RunAction",
					["<C-e>"] = "Edit",
					["o"] = "Open",
					["<C-v>"] = "OpenVsplit",
					["<C-s>"] = "OpenSplit",
					["<C-f>"] = "OpenFloat",
					["<C-q>"] = "OpenQuickFix",
					["p"] = "TogglePreview",
					["<A-l>"] = "IncreaseDetail",
					["<A-h>"] = "DecreaseDetail",
					["L"] = "IncreaseAllDetail",
					["H"] = "DecreaseAllDetail",
					["["] = "DecreaseWidth",
					["]"] = "IncreaseWidth",
					["{"] = "PrevTask",
					["}"] = "NextTask",
					["<C-k>"] = "ScrollOutputUp",
					["<C-j>"] = "ScrollOutputDown",
					["q"] = "Close",
				},
			},
		})

		vim.keymap.set("n", "<A-2>", ":OverseerToggle left<CR>", { desc = "Toggle Overseer" })
		vim.keymap.set("n", "<leader>r", ":OverseerRun<CR>", { desc = "[R]un" })
	end,
}
