-- Paste what I yanked
vim.keymap.set("n", "<leader>p", '"0p', { desc = "[P]aste Yanked" })

-- Cmd-S (on macOS) to save file in insert or normal mode
vim.keymap.set({ "n", "i" }, "<D-s>", "<cmd>w<cr>", { desc = "[󰘳-s] Write current buffer" })
-- Cmd-A selects all
vim.keymap.set({ "i", "n", "v" }, "<D-a>", "<Esc>ggvG", { desc = "[󰘳-a] Select all" })
-- Cmd-V pastes from system clipboard
vim.keymap.set("n", "<D-v>", '"+p', { desc = "[󰘳-v] Paste from system clipboard" })
vim.keymap.set("i", "<D-v>", '<Esc>"+pa', { desc = "[󰘳-v] Paste from system clipboard" })
-- Cmd-C copies to system clipboard
vim.keymap.set({ "v" }, "<D-c>", '"+y', { desc = "[󰘳-c] Yank to system clipboard" })
-- Cmd-X cuts to system clipboard
vim.keymap.set({ "v" }, "<D-x>", '"+d', { desc = "[󰘳-x] Delete to system clipboard" })

-- Move between windows easily
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch to right window" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "[D]iagnostic: [P]revious message" })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "[D]iagnostic: [N]ext message" })
vim.keymap.set("n", "<leader>dm", vim.diagnostic.open_float, { desc = "[D]iagnostic: View [m]essage" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "[D]iagnostic: Open [l]ist" })

-- Plugin maps
vim.keymap.set("n", "<leader>tf", ":Twilight<cr>", { desc = "[T]oggle [F]ocus" })

-- Yoinked from https://github.com/Saecki/crates.nvim/wiki/Documentation-v0.4.0
local function show_documentation()
	local filetype = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end

vim.keymap.set("n", "K", show_documentation, { silent = true })

vim.keymap.set("n", "<leader>nx", "<cmd>spl term://nu<cr>", { silent = true, desc = "Terminal: Split" })
vim.keymap.set("n", "<leader>nv", "<cmd>vspl term://nu<cr>", { silent = true, desc = "Terminal: Vertical Split" })
vim.keymap.set("n", "<leader>ne", "<cmd>edit term://nu<cr>", { silent = true, desc = "Terminal: Edit" })
