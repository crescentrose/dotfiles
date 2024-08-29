-- A UI for nvim-dap
return {
	"rcarriga/nvim-dap-ui",
	command = { "DapUiToggle", "DapToggleBreakpoint" },
	keymap = { "<leader>e" },
	dependencies = {
		-- Debug Adapter Protocol client implementation for Neovim
		"mfussenegger/nvim-dap",
		-- This plugin adds virtual text support to nvim-dap
		"theHamsta/nvim-dap-virtual-text",
		-- A library for asynchronous IO in Neovim
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		require("nvim-dap-virtual-text").setup({})
		require("dap.ext.vscode").json_decode = require("overseer.json").decode
		require("overseer").enable_dap()

		-- Debug keymaps
		vim.keymap.set("n", "<A-5>", dapui.close, { desc = "toggle debug UI" })
		vim.keymap.set("n", "<leader>eb", dap.toggle_breakpoint, { desc = "D[e]bug: [B]reakpoint" })
		vim.keymap.set("n", "<leader>ec", dap.toggle_breakpoint, { desc = "D[e]bug: [C]ontinue" })
		vim.keymap.set("n", "<leader>ee", dapui.close, { desc = "D[e]bug: [E]valuate" })
		vim.keymap.set("n", "<leader>eo", dapui.open, { desc = "D[e]bug: [O]pen" })
		vim.keymap.set("n", "<leader>es", dap.step_into, { desc = "D[e]bug: [S]tep Into" })
		vim.keymap.set("n", "<leader>et", dap.step_into, { desc = "D[e]bug: S[t]ep Over" })
		vim.keymap.set("n", "<leader>ex", dapui.close, { desc = "D[e]bug: Close" })
	end,
}
