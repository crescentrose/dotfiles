-- Git integration for buffers
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      on_attach = function()
        vim.keymap.set('n', '<leader>gh', '<Cmd>Gitsigns toggle_linehl<cr>',
          { desc = '[G]it: [H]ighlight Changes' })
        vim.keymap.set('n', '<leader>gp', '<Cmd>Gitsigns preview_hunk_inline<cr>',
          { desc = '[G]it: [P]review Hunk' })
        vim.keymap.set('n', '<leader>gb', '<Cmd>Gitsigns blame_line<cr>',
          { desc = '[G]it: [B]lame Line' })
        vim.keymap.set('n', '<leader>gr', '<Cmd>Gitsigns reset_hunk<cr>',
          { desc = '[G]it: [R]eset Hunk' })
      end
    })
  end,
}
