-- 💥 Create key bindings that stick.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local which_key = require("which-key")
		which_key.setup({})

		which_key.add({
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Diagnostic" },
			{ "<leader>e", group = "Debug" },
			{ "<leader>g", group = "Git" },
			{ "<leader>r", group = "Run" },
			{ "<leader>s", group = "Search" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>w", group = "Workspace" },
			{ "<leader>n", group = "Terminal" },
			{ "<leader>m", group = "Monorepo" },
			{ "<leader>", group = "VISUAL <leader>", mode = "v" },
		})
	end,
}
