-- LSP signature hint as you type
return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  config = function()
    require('lsp_signature').setup()
  end
}
