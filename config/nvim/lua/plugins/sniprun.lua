-- A neovim plugin to run lines/blocs of code (independently of the rest of the file), supporting multiples languages
return {
  'michaelb/sniprun',
  event = "VeryLazy",
  build = "sh install.sh",
  config = function()
    require("sniprun").setup({})
  end,
}
