-- Find, Filter, Preview, Pick. All lua, all the time.
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	lazy = true,
	cmd = { "Telescope" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local trouble = require("trouble.sources.telescope")
		telescope.setup({
			defaults = {
				mappings = {
					i = { ["<c-r>"] = trouble.open },
					n = { ["<c-r>"] = trouble.open },
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "[S]earch [G]it Files" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sc", builtin.oldfiles, { desc = "[S]earch Re[c]ents" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sr", builtin.live_grep, { desc = "[S]earch by g[r]ep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, "fzf")
	end,
}
