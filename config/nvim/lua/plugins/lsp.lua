-- Quickstart configs for Nvim LSP
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Portable package manager for Neovim that runs everywhere Neovim runs.
			{ "williamboman/mason.nvim", config = true },
			-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
			"williamboman/mason-lspconfig.nvim",
			-- Faster LuaLS setup for Neovim
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						"luvit-meta/library",
					},
				},
			},
			-- Meta type definitions for the Lua platform Luvit.
			{ "Bilal2453/luvit-meta", lazy = true },
			"nvim-lua/plenary.nvim",
		},
		event = "BufReadPost",
		config = function()
			require("lsp_support")
			SetupAutoCmd()

			-- List of LSP servers to install and support
			local servers = {
				gopls = {},
				pyright = {},
				rust_analyzer = {},
				tsserver = {},
				taplo = {},
				html = { filetypes = { "html", "twig", "hbs" } },
				marksman = {},

				jsonls = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
				lua_ls = {},
			}

			local mason, lspconfig = require("mason"), require("mason-lspconfig")
			mason.setup()
			lspconfig.setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
			lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
						autostart = (servers[server_name] or { autostart = true }).autostart,
					})
				end,
			})
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
					-- npm i -g @commitlint/config-conventional @commitlint/cli commitlint-format-json
					null_ls.builtins.diagnostics.commitlint,
					-- GitHub Actions
					null_ls.builtins.diagnostics.actionlint,
					-- Go
					null_ls.builtins.code_actions.gomodifytags,
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.diagnostics.staticcheck,
					null_ls.builtins.formatting.goimports_reviser,
					-- HTML
					null_ls.builtins.diagnostics.tidy,
					null_ls.builtins.formatting.tidy,
					-- Markdown
					null_ls.builtins.code_actions.proselint,
					null_ls.builtins.diagnostics.proselint,
					null_ls.builtins.diagnostics.mdl,
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
}
