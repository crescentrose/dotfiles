-- A file explorer tree for neovim written in lua
return {
	"nvim-tree/nvim-tree.lua",
	event = "VimEnter",
	config = function()
		local nvimtree = require("nvim-tree")
		nvimtree.setup({
			view = { width = { min = 30, max = 40 } },
		})

		-- Toggle the file browser with Alt-1
		vim.keymap.set("n", "<A-1>", function()
			local nvimTree = require("nvim-tree.api")
			if nvimTree.tree.is_visible() then
				nvimTree.tree.close_in_this_tab()
			else
				nvimTree.tree.open({ find_file = true })
			end
		end, { desc = "<Alt-1> Toggle NvimTree" })
	end,
}
