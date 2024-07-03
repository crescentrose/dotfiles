return {
	-- Snippet plugin for Neovim written in Lua
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*",
		event = "BufReadPost",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").load()
		end,
	},

	-- Set of preconfigured snippets for different languages.
	{ "rafamadriz/friendly-snippets" },

	-- A completion plugin for neovim coded in Lua.
	{
		"hrsh7th/nvim-cmp",
		event = "BufReadPost",
		dependencies = {
			-- nvim-cmp source for filesystem paths.
			"hrsh7th/cmp-path",
			-- nvim-cmp source for neovim builtin LSP client
			"hrsh7th/cmp-nvim-lsp",
			-- nvim-cmp source for displaying function signatures with the current parameter emphasized
			"hrsh7th/cmp-nvim-lsp-signature-help",
			-- nvim-cmp source for autocompleting git commits with conventional commits types
			"davidsierradz/cmp-conventionalcommits",
			-- nvim-cmp source for emoji
			"hrsh7th/cmp-emoji",
			-- nvim-cmp source for golang packages path.
			"Snikimonkd/cmp-go-pkgs",
			-- nvim-cmp source for math calculation
			"hrsh7th/cmp-calc",
			-- luasnip completion source for nvim-cmp
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local luasnip = require("luasnip")
			local cmp = require("cmp")
			cmp.setup({
				view = {
					entries = "native",
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-N>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 10 }),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-P>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 10 }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "🔎",
							nvim_lsp_signature_help = "ƒ",
							luasnip = "🖇️",
							path = "📁",
							conventionalcommits = "🌱",
							emoji = "😄",
							cals = "🔢",
							crates = "🦀",
							go_pkgs = "🐭",
						})[entry.source.name]
						return vim_item
					end,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						-- Hide "text" suggestions" because they are INCREDIBLY ANNOYING!!! and almost never
						-- useful :(
						entry_filter = function(entry)
							return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
						end,
					},
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
				}, {
					{ name = "path" },
					{ name = "conventionalcommits" },
					{ name = "emoji" },
					{ name = "calc" },
				}, {
					{ name = "crates" },
					{ name = "go_pkgs" },
				}),
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
