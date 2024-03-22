-- A neovim port of Assorted Biscuits. Ends up with more supported languages too.
return {
  'code-biscuits/nvim-biscuits',
  event = "VeryLazy",
  config = function()
    require('nvim-biscuits').setup({
      cursor_line_only = true,
      language_config = {
        help = {
          disabled = true
        },
        vimdoc = {
          disabled = true
        },
      },
    })
  end,
}
