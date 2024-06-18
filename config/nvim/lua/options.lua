-- Undo
vim.o.undofile = true -- Save undo history to a file

-- Line numbers
vim.o.number = true -- Show line numbers on the side
vim.o.relativenumber = true -- Show both the relative number and the actual line number

-- Saving
vim.o.autowriteall = true -- Automatically save on any editor switch
vim.o.swapfile = false -- Disable swap files
vim.o.writebackup = false -- Disable backup files
vim.o.backup = false -- Disable backup files
vim.o.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize" -- Save these options with sessions

-- UI
vim.o.termguicolors = true -- Enable full colour support

vim.o.colorcolumn = "+1" -- Display a ruler line at text width.
vim.o.numberwidth = 4 -- Comfortable gutter width
vim.wo.signcolumn = "yes:1" -- Use the number column for signs

vim.o.splitbelow = true -- Create new splits below current split (instead of above)
vim.o.splitright = true -- Create new splits right to the current split (instead of to the left)

vim.o.scrolloff = 5 -- Put a few lines around the cursor when scrolling

vim.o.list = true -- Display tabs and trailing spaces
vim.o.listchars = "tab:␉·,trail:␠,nbsp:⎵" -- Show only tabs, trailing spaces and non-breaking spaces

vim.o.updatetime = 250 -- Decrease time to show popups
vim.o.timeoutlen = 300 -- Decrease time to wait for mapped sequences to complete (?)

vim.o.showmode = false -- Hide mode name from command bar
vim.o.inccommand = "split" -- Preview substitutions as you type

vim.o.showtabline = 2 -- Always display the tab line

vim.o.cursorline = true -- Highlight the current cursor line

vim.diagnostic.config({ -- Disable virtual text since we have lsp_lines
	virtual_text = false,
})

-- Formatting
vim.o.textwidth = 100 -- Wrap text at 100 characters...
-- vim.opt.formatoptions:remove("t") -- ... but not code, only comments
vim.opt.formatoptions:append("1") -- ... and do not leave single letter words alone
vim.opt.formatoptions:append("p") -- ... and do not break at single spaces that follow a period

vim.o.tabstop = 2 -- Tabs render as 2 spaces
vim.o.shiftwidth = 2 -- Hitting tab inserts 2 spaces
vim.o.shiftround = true -- Round tabs to nearest 2 spaces (so, 3 or 5 spaces are not possible)
vim.o.expandtab = true -- Tabs get inserted as spaces

vim.o.breakindent = true -- Wrapped lines will continue indented
vim.o.smartindent = true -- Do smart indenting when starting a new line

-- Searching
vim.o.ignorecase = true -- Case-insensitive searching...
vim.o.smartcase = true -- ... except a capital letter is used to search

if vim.fn.executable("rg") == 1 then -- Use rg if available
	vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
end

-- Symbols
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "@comment.todo", numhl = "" })
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

vim.fn.sign_define("DiagnosticSignError", { text = "󰔶", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "󰔶", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
