-- A fancy, configurable, notification manager for NeoVim
return {
	"rcarriga/nvim-notify",
	lazy = true,
	event = "VeryLazy",
	config = function()
		vim.notify = require("notify")
		require("telescope").load_extension("notify")
	end,
}
