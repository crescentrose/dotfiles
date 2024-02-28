-- @crescentrose's neovim config ✨

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install the lazy.vim plugin manager {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- }}}

-- Install plugins {{{

require("lazy").setup({
  -- surround.vim: quoting/parenthesizing made simple
  "tpope/vim-surround",
  -- commentary.vim: comment stuff out
  "tpope/vim-commentary",
  -- fugitive.vim: A Git wrapper so awesome, it should be illegal
  "tpope/vim-fugitive",
  -- repeat.vim: enable repeating supported plugin maps with "."
  "tpope/vim-repeat",
  -- Quickstart configs for Nvim LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Portable package manager for Neovim that runs everywhere Neovim runs.
      { 'williamboman/mason.nvim', config = true },
      -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
      'williamboman/mason-lspconfig.nvim',
      -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
      { 'j-hui/fidget.nvim',       opts = {} },
      -- 💻 Neovim setup for init.lua and plugin development with full signature help, docs and
      -- completion for the nvim lua API.
      'folke/neodev.nvim',
    },
  },
  {
    -- A completion plugin for neovim coded in Lua.
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- nvim-cmp source for neovim builtin LSP client
      'hrsh7th/cmp-nvim-lsp',
      -- nvim-cmp source for filesystem paths.
      'hrsh7th/cmp-path',
    },
  },
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup {}
    end
  },
  -- Flexoki color scheme for Neovim
  { "kepano/flexoki-neovim", name = "flexoki" },
  -- Git integration for buffers
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  -- 💥 Create key bindings that stick.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  -- Snippet plugin for Neovim written in Lua
  "dcampos/nvim-snippy",
  -- nvim-snippy completion source for nvim-cmp.
  "dcampos/cmp-snippy",
  -- Set of preconfigured snippets for different languages.
  "rafamadriz/friendly-snippets",
})

-- }}}

vim.cmd("colorscheme flexoki-light")

-- Setup plugins {{{


-- }}}

-- Color scheme {{{
--
-- }}}

-- Basic setup {{{

-- Undo
vim.o.undofile = true -- Save undo history to a file

-- Line numbers
vim.o.number = true         -- Show line numbers on the side
vim.o.relativenumber = true -- Show both the relative number and the actual line number

-- Saving
vim.o.autowriteall = true -- Automatically save on any editor switch
vim.o.swapfile = false    -- Disable swap files
vim.o.writebackup = false -- Disable backup files
vim.o.backup = false      -- Disable backup files

-- UI
vim.o.termguicolors = true -- Enable full colour support

vim.o.colorcolumn = "+1" -- Display a ruler line at text width.
vim.o.numberwidth = 4 -- Comfortable gutter width
vim.wo.signcolumn = "number" -- Use the number column for signs

vim.o.splitbelow = true -- Create new splits below current split (instead of above)
vim.o.splitright = true -- Create new splits right to the current split (instead of to the left)

vim.o.scrolloff = 3 -- Put a few lines around the cursor when scrolling

vim.o.list = true -- Display tabs and trailing spaces
vim.o.listchars = "tab:␉·,trail:␠,nbsp:⎵" -- Show only tabs, trailing spaces and non-breaking spaces

vim.o.updatetime = 250 -- Decrease time to show popups
vim.o.timeoutlen = 300 -- Decrease time to wait for mapped sequences to complete (?)

vim.o.showmode = false -- Hide mode name from command bar

-- Formatting
vim.o.textwidth = 100             -- Wrap text at 100 characters...
vim.opt.formatoptions:remove("t") -- ... but not automatically.

vim.o.tabstop = 2                 -- Tabs render as 2 spaces
vim.o.shiftwidth = 2              -- Hitting tab inserts 2 spaces
vim.o.shiftround = true           -- Round tabs to nearest 2 spaces (so, 3 or 5 spaces are not possible)
vim.o.expandtab = true            -- Tabs get inserted as spaces

vim.o.breakindent = true          -- Wrapped lines will continue indented

-- Searching
vim.o.ignorecase = true              -- Case-insensitive searching...
vim.o.smartcase = true               -- ... except a capital letter is used to search

if vim.fn.executable('rg') == 1 then -- Use rg if available
  vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
end

-- }}}

-- Custom keymaps {{{

-- Cmd-S (on macOS) to save file in insert or normal mode
vim.keymap.set({ 'n', 'i' }, '<D-s>', '<cmd>w<cr>', { desc = "[󰘳-s] Write current buffer" })

-- Telescope keybinds
local telescope = require('telescope.builtin')
vim.keymap.set({ 'n' }, '<S-D-p>', telescope.find_files, { desc = "[󰘳-󰘶-p] Search Files" })
vim.keymap.set('n', '<leader>sg', telescope.git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sr', telescope.live_grep, { desc = '[S]earch by g[r]ep' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = '[D]iagnostic: [P]revious message' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = '[D]iagnostic: [N]ext message' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = '[D]iagnostic: View [m]essage' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = '[D]iagnostic: Open [l]ist' })
-- }}}

-- Autocommands {{{

-- Highlight search results only while searching
local search = vim.api.nvim_create_augroup("Search settings", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    if vim.fn.getcmdtype() == "/" or vim.fn.getcmdtype() == "?" then
      vim.opt.hlsearch = true
    else
      vim.opt.hlsearch = false
    end
  end,
  group = search,
  desc = "Highlighting matched words when searching",
})

-- }}}

-- Integrations {{{

-- Support kitty's extended terminal codes (for italic, strikethrough etc.)
if vim.env.TERM == "xterm-kitty" then
  local configpath = vim.fn.stdpath("config") .. "/kitty.vim"
  vim.cmd("source " .. configpath)
end

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'go', 'lua', 'python', 'rust', 'javascript', 'typescript' },
    auto_install = true,
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  }
end, 0)


-- }}}

-- LSP {{{

vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', function()
    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
  end, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  nmap('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}


-- }}}

-- Completion {{{

local cmp = require 'cmp'

cmp.setup {
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'snippy' }
  },
}

-- }}}

-- Documentation {{{

local which_key = require("which-key")

which_key.register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

which_key.register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })



-- }}}

--
-- vim: fdm=marker fdl=0
