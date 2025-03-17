return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		ft = { "markdown", "md" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}
