return {
	-- Faster LuaLS setup for Neovim
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"luvit-meta/library",
			},
		},
	},
	-- Meta type definitions for the Lua platform Luvit.
	{ "Bilal2453/luvit-meta", lazy = true },
	"nvim-lua/plenary.nvim",
}
