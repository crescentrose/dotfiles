-- rustacean.vim is a bit much
-- need to figure out a better way to manage rust projects
return {
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates",
				},
			})
		end,
	},
}
