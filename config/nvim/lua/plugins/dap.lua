return {
	-- Debug Adapter Protocol client implementation for Neovim
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},
	-- An extension for nvim-dap providing configurations for launching go debugger (delve) and
	-- debugging individual tests
	{
		"leoluz/nvim-dap-go",
		ft = { "go" },
		config = function()
			require("dap-go").setup()
		end,
	},
	-- A UI for nvim-dap
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local dapgo = require("dap-go")
			dapui.setup()
			dapgo.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			vim.keymap.set("n", "<Leader>ec", function()
				require("dap").continue()
			end, { desc = "Continue" })
			vim.keymap.set("n", "<Leader>eo", function()
				require("dap").step_over()
			end, { desc = "Step Over" })
			vim.keymap.set("n", "<Leader>ei", function()
				require("dap").step_into()
			end, { desc = "Step Into" })
			vim.keymap.set("n", "<Leader>eu", function()
				require("dap").step_out()
			end, { desc = "Step Out" })
			vim.keymap.set("n", "<Leader>eb", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>es", function()
				require("dap").set_breakpoint()
			end, { desc = "Set Breakpoint" })
			vim.keymap.set("n", "<Leader>em", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Break Message" })
			vim.keymap.set("n", "<Leader>er", function()
				require("dap").repl.open()
			end, { desc = "Open REPL" })
			vim.keymap.set("n", "<Leader>el", function()
				require("dap").run_last()
			end, { desc = "Run Last" })

			vim.keymap.set("n", "<Leader>ep", function()
				dapui.open()
			end, { desc = "Open UI" })
			vim.keymap.set("n", "<Leader>ex", function()
				dapui.close()
			end, { desc = "Close UI" })
		end,
	},
}
