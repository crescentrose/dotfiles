-- Find all uses of `.unwrap()` and dump them into the quickfix list, then open Trouble to look
-- through them.
vim.api.nvim_create_user_command("Unwrap", function()
	vim.cmd([[silent grep! "\.unwrap()" ]])
	vim.cmd([[Trouble quickfix]])
end, { nargs = 0 })

-- Add Rasi file type
vim.filetype.add({
	extension = {
		rasi = 'rasi',
	},
})

function Init_code_lens(bufnr)
	vim.api.nvim_set_hl(0, "LspCodeLens", { link = "WarningMsg", default = true })
	vim.api.nvim_set_hl(0, "LspCodeLensText", { link = "WarningMsg", default = true })
	vim.api.nvim_set_hl(0, "LspCodeLensSign", { link = "WarningMsg", default = true })
	vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { link = "Boolean", default = true })

	vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "BufWritePre" }, {
		group = vim.api.nvim_create_augroup("code_lens", {}),
		buffer = bufnr,
		callback = function()
			if #vim.lsp.get_clients({ bufnr = bufnr }) > 0 then
				Refresh_code_lens()
			end
		end,
	})
end

function Refresh_code_lens()
	if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
		vim.lsp.codelens.refresh({ bufnr = 0 })
	else
		vim.lsp.codelens.clear()
	end
end
