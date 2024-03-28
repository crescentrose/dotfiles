-- A feature-rich Go development plugin, leveraging gopls, treesitter AST, Dap, and various Go tools to enhance the dev experience.
return {
	"ray-x/go.nvim",
	dependencies = {
		-- A GUI library for Neovim plugin developers
		"ray-x/guihua.lua",
	},
	config = function()
		require("go").setup()
	end,
	build = ':lua require("go.install").update_all_sync()',
	ft = { "go", "gomod" },
}
