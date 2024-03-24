-- nvim plugin that adds tabs for telescope search
return {
	"FabianWirth/search.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local search = require("search")
		search.setup({
			tabs = {
				{
					"Files",
					builtin.find_files,
				},
				{
					"Git Files",
					builtin.git_files,
					available = function()
						return vim.fn.isdirectory(".git") == 1 -- only if we're in a git repo
					end,
				},
				{
					"Text",
					builtin.live_grep,
				},
				{
					"Symbols",
					builtin.lsp_dynamic_workspace_symbols,
					available = function()
						return #vim.lsp.get_active_clients() > 0 -- only if a LSP is connected
					end,
				},
				{
					"Commits",
					builtin.git_bcommits,
					available = function()
						return vim.fn.isdirectory(".git") == 1 -- only if we're in a git repo
					end,
				},
				{
					"Registers",
					builtin.registers,
				},
				{
					"Help",
					builtin.help_tags,
				},
			},
		})

		vim.keymap.set({ "n" }, "<S-D-p>", search.open, { desc = "[󰘳-󰘶-p] Search" })
		vim.keymap.set({ "n" }, "<C-p>", search.open, { desc = "[󰘴-p] Search" })
	end,
}
