-- Nushell syntax Highlighting
return {
  'LhKipp/nvim-nu',
  dependencies = { "nvim-treesitter/nvim-treesitter", },
  build = ":TSInstall nu",
  config = function()
    require("nu").setup({ use_lsp_features = false })
  end
}
