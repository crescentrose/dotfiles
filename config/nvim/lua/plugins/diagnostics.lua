-- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
return {
	"folke/trouble.nvim",
	lazy = true,
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local trouble = require("trouble")

		vim.keymap.set("n", "<A-4>", trouble.toggle, { desc = "Open diagnostics" })
		vim.keymap.set("n", "<leader>td", function()
			trouble.toggle("document_diagnostics")
		end, { desc = "[T]oggle Document [D]iagnostics" })
		vim.keymap.set("n", "<leader>tD", function()
			trouble.toggle("workspace_diagnostics")
		end, { desc = "[T]oggle Workspace [D]iagnostics" })
		vim.keymap.set("n", "<leader>tq", function()
			trouble.toggle("quickfix")
		end, { desc = "[T]oggle [Q]uickfix" })
	end,
}
