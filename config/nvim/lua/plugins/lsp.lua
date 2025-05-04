return {
	-- Quickstart configs for Nvim LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp_support").setup()
			local lspconfig_defaults = require('lspconfig').util.default_config

			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- CSS
			require('lspconfig').cssls.setup({})
			-- Golang
			require('lspconfig').gopls.setup({})
			-- HTML
			require('lspconfig').html.setup({})
			-- JSON
			require('lspconfig').jsonls.setup({
				settings = {
					json = {
						schemas = require('schemastore').json.schemas(),
						validate = { enable = true },
					},
				},
			})
			-- Lua
			require('lspconfig').lua_ls.setup({})
			-- Nix
			require('lspconfig').nil_ls.setup({})
			-- Python
			require('lspconfig').pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { 'E501' },
							}
						}
					}
				}
			})
			-- Rust (via rustup)
			require('lspconfig').rust_analyzer.setup({
				settings = {
					['rust-analyzer'] = {
						-- Run `clippy` on save instead of `cargo check`
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			})
			-- Terraform
			require('lspconfig').terraformls.setup({})
			-- TOML
			require('lspconfig').taplo.setup({})
			-- TypeScript
			require('lspconfig').ts_ls.setup({})
		end,
	},

	-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Git
					null_ls.builtins.code_actions.gitrebase,
					-- GitHub Actions
					null_ls.builtins.diagnostics.actionlint,
					-- Go
					null_ls.builtins.code_actions.gomodifytags,
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.diagnostics.staticcheck,
					null_ls.builtins.formatting.goimports_reviser,
					-- Markdown
					null_ls.builtins.diagnostics.markdownlint.with({ extra_args = { "--disable MD033 MD013" } }),
					-- Make
					null_ls.builtins.diagnostics.checkmake,
					-- OpenAPI
					null_ls.builtins.diagnostics.vacuum,
					-- SQL
					null_ls.builtins.formatting.pg_format,
				},
			})
		end,
	},

	-- Display LSP output as virtual text
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = false })

			vim.keymap.set("", "<Leader>dt", require("lsp_lines").toggle, { desc = "[D]iagnostics: [T]oggle Lines" })
		end
	},
}
