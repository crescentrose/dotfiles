return {
	{
		-- A completion plugin for neovim coded in Lua.
		"hrsh7th/nvim-cmp",
		event = "BufReadPost",
		dependencies = {
			-- nvim-cmp source for neovim builtin LSP client
			"hrsh7th/cmp-nvim-lsp",
			-- nvim-cmp source for filesystem paths.
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						require("snippy").expand_snippet(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "snippy" },
					{ name = "crates" },
				},
			})
		end,
	},

	-- Snippet plugin for Neovim written in Lua
	{ "dcampos/nvim-snippy", event = "BufReadPost" },

	-- nvim-snippy completion source for nvim-cmp.
	{ "dcampos/cmp-snippy", event = "BufReadPost" },

	-- Set of preconfigured snippets for different languages.
	{ "rafamadriz/friendly-snippets", event = "BufReadPost" },
}
