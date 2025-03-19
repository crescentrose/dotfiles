-- A declarative, highly configurable, and neovim style tabline plugin.

return {
	"nanozuki/tabby.nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local util = require("tabby.module.highlight")
		local theme = {
			fill = util.extract("lualine_c_normal"),
			current_tab = util.extract("lualine_a_normal"),
			head = util.extract("lualine_b_normal"),
			tab = util.extract("lualine_b_normal"),
			win = util.extract("lualine_b_normal"),
			tail = util.extract("lualine_b_normal"),
			warn = util.extract("lualine_b_diff_modified_normal"),
			error = util.extract("lualine_b_diff_removed_normal"),
		}

		---@param tab TabbyTab
		local function tab_icon(tab)
			if tab.is_current() then
				return "▢"
			end
			local diag = 0
			local dirty = false
			tab.wins().foreach(function(win)
				diag = diag + #vim.diagnostic.get(win.buf().id, { severity = { min = vim.diagnostic.severity.WARN } })
				dirty = dirty or win.buf().is_changed()
				return diag
			end)

			if diag > 0 then
				return { "⏶", hl = theme.error }
			end

			if dirty then
				return { "", hl = theme.warn }
			end

			return ""
		end

		local function no_nvimtree(win)
			return not string.match(win.buf_name(), "NvimTree")
		end

		require("tabby").setup()
		require("tabby.tabline").set(function(line)
			return {
				{
					{ " 󰄛 ", hl = theme.head },
					line.sep("", theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						tab_icon(tab),
						tab.name(),
						tab.close_btn(""),
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				line.spacer(),
				line.wins_in_tab(line.api.get_current_tab()).filter(no_nvimtree).foreach(function(win)
					return {
						line.sep("", theme.win, theme.fill),
						win.buf_name(),
						line.sep("", theme.win, theme.fill),
						hl = theme.win,
						margin = " ",
					}
				end),
				{
					line.sep("", theme.tail, theme.fill),
					{ "  ", hl = theme.tail },
				},
				hl = theme.fill,
			}
		end)
	end,
}
