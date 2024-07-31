-- This is the LSP-specific config that will get enabled for any buffer with an LSP attached.
local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local trouble = require("trouble")
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = event.buffer, desc = desc })
			end

			nmap("<leader>cr", vim.lsp.buf.rename, "[R]ename")
			nmap("<leader>ca", function()
				vim.lsp.buf.code_action()
			end, "[C]ode [A]ction")

			nmap("gd", function()
				trouble.open("lsp_definitions")
			end, "[G]o to [D]efinition")

			nmap("gr", function()
				trouble.open("lsp_references")
			end, "[G]o to [R]eferences")

			nmap("gI", function()
				trouble.open("lsp_implementations")
			end, "[G]o to [I]mplementation")

			nmap("<leader>cd", function()
				trouble.open("lsp_type_definitions")
			end, "Type [D]efinition")

			nmap("<leader>wd", require("telescope.builtin").lsp_document_symbols, "[D]ocument Symbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

			-- Init_code_lens(event.buffer)

			-- nmap("<leader>cl", function()
			-- 	vim.lsp.codelens.run()
			-- end, "[C]ode [L]ens")

			nmap("<A-k>", vim.lsp.buf.signature_help, "Signature Documentation")

			-- Lesser used LSP functionality
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")

			nmap("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end, "[T]oggle Inlay [H]ints")
		end,
	})
end

return M
