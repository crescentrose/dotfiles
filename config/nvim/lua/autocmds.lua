-- Highlight search results only while searching
local hlsearch = vim.api.nvim_create_augroup("Search settings", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		if vim.fn.getcmdtype() == "/" or vim.fn.getcmdtype() == "?" then
			vim.opt.hlsearch = true
		else
			vim.opt.hlsearch = false
		end
	end,
	group = hlsearch,
	desc = "Highlighting matched words when searching",
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Format Markdown as text instead of code
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	desc = "Markdown: Break text at textwidth",
	callback = function()
		vim.bo.formatoptions = "tln1p"
	end,
})

-- Conceal Markdown syntax when not editing.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	desc = "Markdown: Conceal syntax",
	callback = function()
		vim.wo.conceallevel = 2
	end,
})

-- Add Cargo related keybinds in Cargo.toml files
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "Cargo.toml",
	desc = "Add Cargo related keybinds",
	callback = function(e)
		local crates = require("crates")

		vim.keymap.set({ "n" }, "<leader>cc", function()
			crates.show_features_popup()
			crates.focus_popup()
		end, {
			desc = "Crates: Change Features",
			buffer = e.buf,
		})

		vim.keymap.set({ "n" }, "<leader>cu", function()
			crates.update_crate()
		end, {
			desc = "Crates: Update Crate",
			buffer = e.buf,
		})

		vim.keymap.set({ "n" }, "<leader>cU", function()
			crates.upgrade_crate()
		end, {
			desc = "Crates: Upgrade Crate",
			buffer = e.buf,
		})

		vim.keymap.set({ "n" }, "<leader>cX", function()
			crates.extract_crate_into_table()
		end, {
			desc = "Crates: Extract Into Table",
			buffer = e.buf,
		})
	end,
})

-- Use Treesitter syntax highlighting in Rust files for strings and doc-comments (for injected
-- queries).
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Use Treesitter syntax highlighting for Rust",
	callback = function(_)
		vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
		vim.api.nvim_set_hl(0, "@lsp.type.string", {})
	end,
})
