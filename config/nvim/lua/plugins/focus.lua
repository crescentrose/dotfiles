-- Focus on one function at a time
return {
  'koenverburg/peepsight.nvim',
  event = "VeryLazy",
  config = function()
    local peepsight = require('peepsight')
    peepsight.setup({
      "function_declaration",
      "method_declaration",
      "func_literal",
      "class_declaration",
      "method_definition",
      "arrow_function",
      "function_declaration",
      "generator_function_declaration"
    })

    vim.keymap.set('n', '<leader>tf', peepsight.toggle, { desc = '[T]oggle [F]ocus' })
  end
}
