-- ✅ Highlight, list and search todo comments in your projects
return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local todo = require("todo-comments")
		todo.setup({})

		vim.keymap.set("n", "<leader>st", ":TodoTrouble<CR>", { desc = "[S]how [T]odos" })
	end,
}
