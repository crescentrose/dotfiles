--  🌅 Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're
--  editing using TreeSitter.
return {
	"folke/twilight.nvim",
	lazy = true,
	cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	config = function()
		require("twilight").setup({})
	end,
}
