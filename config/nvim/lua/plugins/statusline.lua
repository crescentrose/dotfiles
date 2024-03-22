-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "catppuccin",
		icons_enabled = true,
		sections = {
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "overseer", "filetype" },
		},
	},
}
