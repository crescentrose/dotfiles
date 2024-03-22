-- 💥 Create key bindings that stick.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local which_key = require("which-key")
    which_key.setup({})

    which_key.register {
      ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = 'Diagnostic', _ = 'which_key_ignore' },
      ['<leader>e'] = { name = 'Debug', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = 'Toggle', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
    }

    which_key.register({
      ['<leader>'] = { name = 'VISUAL <leader>' },
      ['<leader>h'] = { 'Git [H]unk' },
    }, { mode = 'v' })
  end
}
