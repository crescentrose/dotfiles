local if_nil = vim.F.if_nil

local header = {
	type = "text",
	val = {
		[[     ∧＿∧]],
		[[　  ( ･ω･ )つ━☆・*。]],
		[[  ⊂/    /　       ・゜]],
		[[   しーＪ　　   °。+*°。]],
		[[                  .・]],
		[[               ゜｡ﾟﾟ･｡･ﾟﾟ  ]],
		[[]],
		[[                 ╱|、      ]],
		[[               (˚ˎ 。7  ]],
		[[                |、˜〵     ]],
		[[                じしˍ,)ノ ]],
	},
	opts = {
		position = "center",
		hl = "Type",
	},
}

local footer = {
	type = "text",
	val = vim.split(vim.fn.system({ "/usr/bin/env", "fortune", "-n", "200", "-s" }), "\n"),
	opts = {
		position = "center",
		hl = "Comment",
	},
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 3,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("e", "  New file", "<cmd>ene <CR>"),
		button("SPC s f", "󰈞  Find file"),
		button("SPC s c", "  Recently opened"),
		button("ALT 1", "  File browser", "<A-1>"),
		button("?", "  About this config", "<cmd>help crescentrose.txt<cr>"),
	},
	opts = {
		spacing = 1,
	},
}

local config = {
	layout = {
		{ type = "padding", val = 4 },
		header,
		{ type = "padding", val = 2 },
		buttons,
		{ type = "padding", val = 2 },
		footer,
	},
	opts = {
		margin = 5,
	},
}

return {
	config = config,
	leader = leader,
}
