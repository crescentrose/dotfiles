-- Cmd-S (on macOS) to save file in insert or normal mode
vim.keymap.set({ "n", "i" }, "<D-s>", "<cmd>w<cr>", { desc = "[󰘳-s] Write current buffer" })
-- Cmd-V pastes from system clipboard
vim.keymap.set("n", "<D-v>", '"+p', { desc = "[󰘳-v] Paste from system clipboard" })
vim.keymap.set("i", "<D-v>", '<Esc>"+pi', { desc = "[󰘳-v] Paste from system clipboard" })
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
